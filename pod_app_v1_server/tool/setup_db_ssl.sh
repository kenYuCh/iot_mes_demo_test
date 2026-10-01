#!/usr/bin/env bash
# 為開發環境 Postgres／Redis 產生 TLS 憑證（配合 development.yaml requireSsl: true）。
# 優先以內部 Root CA 簽發，讓 Serverpod Redis（SecureSocket）能驗證憑證。
#
# 用法（於 pod_app_v1_server/）：
#   ./tool/setup_db_ssl.sh
#   docker compose up -d --force-recreate postgres redis
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

CA_DIR="certs/ca"
DAYS=825

sign_leaf() {
  local dir="$1" cn="$2"
  mkdir -p "$dir"

  if [[ -f "$CA_DIR/root-ca.crt" && -f "$CA_DIR/root-ca.key" ]]; then
    openssl genrsa -out "$dir/server.key" 2048
    openssl req -new -key "$dir/server.key" -sha256 \
      -subj "/C=TW/O=IoT Smart Factory/CN=${cn}" \
      -out "$dir/server.csr"
    cat > "$dir/server.ext" <<EOT
basicConstraints=critical,CA:FALSE
keyUsage=critical,digitalSignature,keyEncipherment
extendedKeyUsage=serverAuth
subjectAltName=DNS:localhost,DNS:${cn},IP:127.0.0.1
EOT
    openssl x509 -req -in "$dir/server.csr" -sha256 \
      -CA "$CA_DIR/root-ca.crt" -CAkey "$CA_DIR/root-ca.key" -CAcreateserial \
      -days "$DAYS" -extfile "$dir/server.ext" \
      -out "$dir/server.crt"
    rm -f "$dir/server.csr"
    echo "  ${cn} — 由內部 Root CA 簽發"
  else
    openssl req -x509 -newkey rsa:2048 -nodes -sha256 -days "$DAYS" \
      -keyout "$dir/server.key" \
      -out "$dir/server.crt" \
      -subj "/C=TW/O=IoT Smart Factory/CN=${cn}" \
      -addext "subjectAltName=DNS:localhost,DNS:${cn},IP:127.0.0.1"
    echo "  ${cn} — 自簽（找不到 ${CA_DIR}；請先啟動一次 Server 或跑 setup_mqtts.sh）"
  fi

  chmod 600 "$dir/server.key"
  chmod 644 "$dir/server.crt"
}

echo "產生資料庫 TLS 憑證…"
sign_leaf certs/postgres postgres
sign_leaf certs/redis redis

mkdir -p certs/postgres_test certs/redis_test
cp certs/postgres/server.crt certs/postgres_test/server.crt
cp certs/postgres/server.key certs/postgres_test/server.key
cp certs/redis/server.crt certs/redis_test/server.crt
cp certs/redis/server.key certs/redis_test/server.key
chmod 600 certs/postgres_test/server.key certs/redis_test/server.key

echo "資料庫 TLS 憑證已就緒。"
echo "下一步: docker compose up -d --force-recreate postgres redis"
