#!/bin/bash
# 將掛載的 TLS 憑證複製進資料目錄並修正權限（Postgres 要求 key 為 0600）。
set -euo pipefail

if [[ -f /certs/server.crt && -f /certs/server.key ]]; then
  cp /certs/server.crt /var/lib/postgresql/server.crt
  cp /certs/server.key /var/lib/postgresql/server.key
  chown postgres:postgres /var/lib/postgresql/server.crt /var/lib/postgresql/server.key
  chmod 644 /var/lib/postgresql/server.crt
  chmod 600 /var/lib/postgresql/server.key
fi

exec docker-entrypoint.sh postgres \
  -c ssl=on \
  -c ssl_cert_file=/var/lib/postgresql/server.crt \
  -c ssl_key_file=/var/lib/postgresql/server.key \
  "$@"
