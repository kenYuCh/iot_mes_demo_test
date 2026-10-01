#!/usr/bin/env bash
# 以 Serverpod 內部 CA（certs/ca）簽發 MQTT Broker 與 Backend 客戶端憑證，
# 並寫入 mosquitto/config，供 docker compose 的 MQTTS 服務使用。
#
# 用法（於 pod_app_v1_server/）：
#   ./tool/setup_mqtts.sh
#
# 產出：
#   certs/mqtt/{server,backend}/…
#   mosquitto/config/{mosquitto.conf,aclfile,certs/…}
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

CA_DIR="certs/ca"
OUT="certs/mqtt"
MQ_CERTS="mosquitto/config/certs"
DAYS=825
MQTT_LAN_IP="${MQTT_LAN_IP:-$(ipconfig getifaddr en0 2>/dev/null || true)}"

if [[ ! -f "$CA_DIR/root-ca.crt" || ! -f "$CA_DIR/intermediate.crt" ]]; then
  echo "錯誤：找不到內部 CA（$CA_DIR）。請先啟動一次 Server（會自動建立 CA），或手動執行 CaService.ensureCa。"
  exit 1
fi

mkdir -p "$OUT/server" "$OUT/backend" "$MQ_CERTS" mosquitto/data mosquitto/log

# ---- Broker server cert（SAN: localhost / LAN IP / mosquitto）----
SERVER_SAN="DNS:localhost,DNS:mosquitto,DNS:mqtt.local,IP:127.0.0.1"
if [[ -n "$MQTT_LAN_IP" ]]; then
  SERVER_SAN+=",IP:${MQTT_LAN_IP}"
fi
cat > "$OUT/server/server.ext" <<EOT
basicConstraints=critical,CA:FALSE
keyUsage=critical,digitalSignature,keyEncipherment
extendedKeyUsage=serverAuth
subjectAltName=${SERVER_SAN}
EOT

openssl ecparam -name prime256v1 -genkey -noout -out "$OUT/server/server.key"
openssl req -new -key "$OUT/server/server.key" -sha256 \
  -subj "/C=TW/O=IoT Smart Factory/CN=mqtt.local" \
  -out "$OUT/server/server.csr"
openssl x509 -req -in "$OUT/server/server.csr" -sha256 \
  -CA "$CA_DIR/root-ca.crt" -CAkey "$CA_DIR/root-ca.key" -CAcreateserial \
  -days "$DAYS" -extfile "$OUT/server/server.ext" \
  -out "$OUT/server/server.crt"
rm -f "$OUT/server/server.csr"

# ---- Backend client cert（CN = backend-service，與 ACL 一致）----
cat > "$OUT/backend/client.ext" <<'EOT'
basicConstraints=critical,CA:FALSE
keyUsage=critical,digitalSignature
extendedKeyUsage=clientAuth
subjectAltName=URI:urn:iot:client:backend-service
EOT

openssl ecparam -name prime256v1 -genkey -noout -out "$OUT/backend/client.key"
openssl req -new -key "$OUT/backend/client.key" -sha256 \
  -subj "/C=TW/O=IoT Smart Factory/CN=backend-service" \
  -out "$OUT/backend/client.csr"
openssl x509 -req -in "$OUT/backend/client.csr" -sha256 \
  -CA "$CA_DIR/intermediate.crt" -CAkey "$CA_DIR/intermediate.key" -CAcreateserial \
  -days "$DAYS" -extfile "$OUT/backend/client.ext" \
  -out "$OUT/backend/client.crt"
rm -f "$OUT/backend/client.csr"

# 客戶端鏈：leaf + intermediate（broker 以 Root 驗證）
cat "$OUT/backend/client.crt" "$CA_DIR/intermediate.crt" > "$OUT/backend/client-chain.crt"

# 不預簽設備憑證：設備必須經 App 配對（CSR → CA 簽發）後才有 MQTT 身分。
# 本機模擬上行憑證寫在 certs/mqtt/devices/{serial}/（由 Server 配對流程產生）。
rm -rf "$OUT/test-device"

# Mosquitto 信任鏈（Root + Intermediate），可驗證設備與 backend 憑證
cat "$CA_DIR/root-ca.crt" "$CA_DIR/intermediate.crt" > "$MQ_CERTS/ca-chain.crt"

cp "$OUT/server/server.crt" "$MQ_CERTS/server.crt"
cp "$OUT/server/server.key" "$MQ_CERTS/server.key"
chmod 600 "$MQ_CERTS/server.key" "$OUT/backend/client.key"

# ---- Mosquitto 設定 ----
cat > mosquitto/config/mosquitto.conf <<'EOT'
per_listener_settings true
persistence true
persistence_location /mosquitto/data/
log_dest stdout
log_type error
log_type warning
log_type notice
log_type information

listener 8883
protocol mqtt
cafile /mosquitto/config/certs/ca-chain.crt
certfile /mosquitto/config/certs/server.crt
keyfile /mosquitto/config/certs/server.key

# 強制 mTLS：客戶端憑證 CN 當作 username
require_certificate true
use_identity_as_username true
allow_anonymous false
acl_file /mosquitto/config/aclfile

tls_version tlsv1.2
EOT

cat > mosquitto/config/aclfile <<'EOT'
# Backend（CN = backend-service）
user backend-service
topic read devices/+/telemetry
topic read devices/+/state
topic read devices/+/controls/state
topic read devices/+/events/#
topic read devices/+/commands/status
topic read devices/+/ota/status
topic write devices/+/commands/#
topic write devices/+/config/#
topic write devices/+/ota/request
topic read $SYS/#

# Device（CN = 設備序號；%u = 憑證 CN）
pattern write devices/%u/telemetry
pattern write devices/%u/state
pattern write devices/%u/controls/state
pattern write devices/%u/events/#
pattern write devices/%u/commands/status
pattern write devices/%u/ota/status
pattern read devices/%u/commands/#
pattern read devices/%u/config/#
pattern read devices/%u/ota/request
EOT

# 權限：Mosquitto 容器以 uid 1883 執行
chmod -R a+rX mosquitto/config
chmod 644 "$MQ_CERTS"/*.crt || true
# key 需可被容器讀取
chmod 644 "$MQ_CERTS/server.key"

echo "MQTTS 憑證與 Mosquitto 設定已就緒。"
echo "  Broker cert : $MQ_CERTS/server.crt"
echo "  Broker SAN  : $SERVER_SAN"
echo "  Backend cert: $OUT/backend/client-chain.crt"
echo "  下一步: docker compose up -d mosquitto"
