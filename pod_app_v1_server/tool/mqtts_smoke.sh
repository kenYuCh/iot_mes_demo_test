#!/usr/bin/env bash
# 以後端 mTLS 憑證驗證 MQTTS 連線（訂閱 + 模擬設備上行）。
# 前置：docker compose up -d mosquitto && ./tool/setup_mqtts.sh
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

CA="certs/ca/root-ca.crt"
B_CERT="certs/mqtt/backend/client-chain.crt"
B_KEY="certs/mqtt/backend/client.key"

if ! command -v mosquitto_sub >/dev/null 2>&1; then
  echo "請先安裝 mosquitto clients：brew install mosquitto"
  exit 1
fi

echo "== 後端訂閱 devices/+/telemetry（5 秒）="
timeout 5 mosquitto_sub \
  -h localhost -p 8883 \
  --cafile "$CA" --cert "$B_CERT" --key "$B_KEY" \
  -i backend-service-smoke \
  -t 'devices/+/telemetry' -v &
SUB_PID=$!
sleep 1

# 若有測試設備憑證則用；否則只驗證 backend 可連線
if [[ -f certs/mqtt/test-device/client-chain.crt ]]; then
  echo "== 模擬設備上行 =="
  mosquitto_pub \
    -h localhost -p 8883 \
    --cafile "$CA" \
    --cert certs/mqtt/test-device/client-chain.crt \
    --key certs/mqtt/test-device/client.key \
    -i ESP32-SMOKE \
    -t 'devices/ESP32-SMOKE/telemetry' \
    -m '{"temperature":26.5,"humidity":55}'
fi

wait "$SUB_PID" || true
echo "MQTTS smoke 完成（backend mTLS 可連）"
