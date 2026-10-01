# IoT 智慧工廠 · Serverpod × Flutter

以 Flutter App 搭配 Serverpod 後端打造的 IoT 管理專案，整合場域與設備管理、即時監控、製程、警報、設備配對與 OTA 韌體更新。

> 本文件以本機開發為主。截圖為既有操作畫面，新建資料庫不會自動出現截圖中的設備或資料。

## 畫面展示

### 主頁與場域

<table>
  <tr>
    <td align="center"><img src="screenshot/%E4%B8%BB%E9%A0%81/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202026-09-18%20at%2020.00.41.png" width="240" alt="主頁" /><br />主頁</td>
    <td align="center"><img src="screenshot/site/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202026-09-18%20at%2019.47.12.png" width="240" alt="場域管理" /><br />場域管理</td>
    <td align="center"><img src="screenshot/site/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202026-09-18%20at%2019.48.24.png" width="240" alt="場域詳情" /><br />場域詳情</td>
  </tr>
</table>

### 維運、製程與警報

<table>
  <tr>
    <td align="center"><img src="screenshot/%E7%B6%AD%E9%81%8B%E4%B8%AD%E5%BF%83/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202026-09-18%20at%2019.52.43.png" width="240" alt="維運中心" /><br />維運中心</td>
    <td align="center"><img src="screenshot/%E8%A3%BD%E7%A8%8B/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202026-09-18%20at%2019.55.42.png" width="240" alt="製程管理" /><br />製程管理</td>
    <td align="center"><img src="screenshot/%E8%AD%A6%E5%A0%B1/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202026-09-18%20at%2019.58.41.png" width="240" alt="警報" /><br />警報</td>
  </tr>
</table>

### 設備設定與更新

<table>
  <tr>
    <td align="center"><img src="screenshot/%E8%A8%AD%E5%AE%9A/%E8%A8%AD%E5%82%99%E8%97%8D%E7%89%99%E9%85%8D%E5%B0%8D/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202026-09-18%20at%2020.06.19.png" width="240" alt="設備配對" /><br />設備配對</td>
    <td align="center"><img src="screenshot/%E8%A8%AD%E5%AE%9A/%E8%A8%AD%E5%82%99%E6%AC%8A%E9%99%90%E5%85%B1%E4%BA%AB/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202026-09-18%20at%2020.10.19.png" width="240" alt="設備權限共享" /><br />設備權限共享</td>
    <td align="center"><img src="screenshot/%E8%A8%AD%E5%AE%9A/OTA%E9%81%A0%E7%AB%AF%E6%9B%B4%E6%96%B0/Simulator%20Screenshot%20-%20iPhone%2016%20Pro%20-%202026-09-18%20at%2019.41.21.png" width="240" alt="OTA 遠端更新" /><br />OTA 遠端更新</td>
  </tr>
</table>

更多畫面見 [screenshot/](screenshot/)。圖片使用儲存庫相對路徑，推送 README 時也需要一併提交 `screenshot/`，GitHub 才能顯示；不需要額外圖床。

## 專案結構

```text
pod_app_v1/
├── pod_app_v1_flutter/   # Flutter App、Riverpod 狀態管理與 UI
├── pod_app_v1_server/    # Serverpod API、MQTT、資料模型與 migrations
├── pod_app_v1_client/    # Serverpod 自動產生的 Dart Client
├── screenshot/          # App 畫面展示
├── pubspec.yaml         # Dart / Flutter workspace
└── AGENTS.md            # 開發規範
```

主要模組包含場域／設備、遙測、設備控制、維運、製程與 OEE、警報、權限共享、BLE 配對及 OTA。App 透過 Serverpod API 與 Streaming 取得資料；設備透過 MQTTS 連線至 Mosquitto，再由後端處理上行資料與控制命令。

```text
Flutter App ↔ Serverpod API / Streaming ↔ PostgreSQL / Redis
                         ↕
                  Mosquitto MQTTS
                         ↕
                      IoT 設備
```

## 開發環境

| 工具 | 專案設定 |
| --- | --- |
| Flutter / Dart | Flutter `^3.32.0`、Dart `^3.8.0`，需使用能解析目前套件的 SDK |
| Serverpod / CLI | `3.4.11` |
| PostgreSQL | `pgvector/pgvector:pg16` |
| Redis | Compose 目前使用 `redis:7.2-alpine` |
| MQTT Broker | `eclipse-mosquitto:2`，mTLS，連接埠 `8883` |
| 其他 | Docker Compose、OpenSSL；iOS 另需 macOS、Xcode、CocoaPods |

以下指令假設從專案根目錄開始；不同終端機請先切換到標示的目錄。

### 1. 安裝套件與 CLI

```bash
# 專案根目錄（workspace 一次取得三個 package 的依賴）
flutter pub get
dart pub global activate serverpod_cli 3.4.11
export PATH="$PATH:$HOME/.pub-cache/bin"
serverpod --version
```

### 2. 準備密碼與金鑰

在本機建立 `pod_app_v1_server/config/passwords.yaml`，不需提交這個檔案。依 Serverpod 3.4.11 的設定格式，在 `development:` 區段填入：

| 設定名稱 | 用途／處理方式 |
| --- | --- |
| `database` | 與 Compose 的 PostgreSQL 密碼一致 |
| `redis` | 與 Compose 的 Redis `--requirepass` 一致；修改時也同步 healthcheck |
| `serviceSecret` | Serverpod 服務密鑰，使用獨立隨機值 |
| `jwtHmacSha512PrivateKey` | JWT 簽署密鑰，使用獨立隨機值 |
| `jwtRefreshTokenHashPepper` | Refresh token 雜湊密鑰，使用獨立隨機值 |
| `emailSecretHashPepper` | Email 登入驗證用密鑰，使用獨立隨機值 |

可用 `openssl rand -base64 64` 分別產生隨機值。要跑整合測試時，另設定 `test:` 區段，資料庫／Redis 密碼需對應 Compose 的測試服務。正式部署使用獨立設定與密鑰，不沿用開發值。

憑證、私鑰與密碼只在本機產生／配置，本 README 不附實際金鑰檔案。

### 3. 首次建立 CA 與服務憑證

目前資料庫設定已啟用 TLS。必須先有 Root CA，再產生資料庫與 MQTT 憑證，最後才啟動容器。現行後端啟動流程不會主動呼叫 `CaService.ensureCa`，因此乾淨環境不能只靠啟動 Server 建立 CA。

以下為本機首次建立 CA 的方式，對應 `CaService` 使用的檔名與憑證層級。**已有 CA 時跳過此段，避免覆蓋既有信任鏈。**

```bash
cd pod_app_v1_server
mkdir -p certs/ca
openssl ecparam -name prime256v1 -genkey -noout -out certs/ca/root-ca.key
openssl req -x509 -new -key certs/ca/root-ca.key -sha256 -days 3650 \
  -subj "/C=TW/O=IoT Smart Factory/CN=IoT Root CA" \
  -addext "basicConstraints=critical,CA:TRUE,pathlen:1" \
  -addext "keyUsage=critical,keyCertSign,cRLSign" -out certs/ca/root-ca.crt
openssl ecparam -name prime256v1 -genkey -noout -out certs/ca/intermediate.key
openssl req -new -key certs/ca/intermediate.key \
  -subj "/C=TW/O=IoT Smart Factory/CN=IoT Device Intermediate CA" \
  -out certs/ca/intermediate.csr
printf 'basicConstraints=critical,CA:TRUE,pathlen:0\nkeyUsage=critical,keyCertSign,cRLSign\n' > certs/ca/intermediate.ext
openssl x509 -req -in certs/ca/intermediate.csr -sha256 \
  -CA certs/ca/root-ca.crt -CAkey certs/ca/root-ca.key -CAcreateserial \
  -days 1825 -extfile certs/ca/intermediate.ext -out certs/ca/intermediate.crt
chmod 600 certs/ca/*.key
```

接著在 `pod_app_v1_server/` 產生服務憑證：

```bash
bash tool/setup_db_ssl.sh
bash tool/setup_mqtts.sh
```

實體設備使用區網 IP 連線時，將第二行改成 `MQTT_LAN_IP=192.168.1.100 bash tool/setup_mqtts.sh`（換成開發機 IP），讓 Broker 憑證包含該 IP。這些腳本會重建相關服務憑證；一般日常啟動不必重跑。

### 4. 啟動資料庫、MQTT 與後端

```bash
# pod_app_v1_server/
docker compose up -d postgres redis mosquitto
docker compose ps
serverpod generate
```

首次套用前先檢查 `migrations/` 內的 SQL；既有資料庫應先備份。確認後啟動後端：

```bash
dart run bin/main.dart --apply-migrations
```

使用實體設備時，以以下方式啟動，讓配對 API 回傳設備能連到的 Broker 地址：

```bash
MQTT_PUBLIC_HOST=192.168.1.100 dart run bin/main.dart --apply-migrations
```

`MQTT_HOST` 是後端連 Broker 的地址（預設 `localhost`）；`MQTT_PUBLIC_HOST` 是設備使用的地址。兩者用途不同。

| 服務 | 本機連接埠 |
| --- | --- |
| Serverpod API | `8080` |
| Serverpod Insights | `8081` |
| Web／韌體下載 | `8082` |
| PostgreSQL / Redis（TLS） | `8090` / `8091` |
| Mosquitto（mTLS） | `8883` |

### 5. 啟動 Flutter App

另開終端機：

```bash
cd pod_app_v1_flutter
flutter devices
flutter run -d <device-id> --dart-define=AUTO_LOGIN=false \
  --dart-define=SERVER_URL=http://localhost:8080/
```

將 `<device-id>` 換成 `flutter devices` 顯示的裝置 ID。iOS Simulator 可用 `localhost`；Android Emulator 通常改成 `http://10.0.2.2:8080/`；實體手機則使用開發機區網 IP，例如：

```bash
flutter run -d <device-id> --dart-define=AUTO_LOGIN=false \
  --dart-define=SERVER_URL=http://192.168.1.100:8080/
```

手機與開發機需在可互通的網路，並允許相關服務連接埠。iOS 實機另需在 Xcode 設定 Signing Team；BLE 配對需使用實體手機與設備。

### 6. 登入與初始資料

- 建立帳號時，開發版驗證碼會印在後端終端機，目前尚未接入正式寄信服務。
- 上述指令關閉 Debug 自動登入，避免乾淨資料庫因預設測試帳號不存在而重複重試。
- 現行 Server 不會自動執行 demo seed 或遙測模擬器；空資料庫需要由管理者匯入／建立 Company 與使用者 Membership、角色及場域資料。註冊帳號不會自動建立公司。
- 尚無公司時 API 會回報「尚未建立任何公司資料」；已有公司但新帳號無 Membership 時，現行邏輯會加入第一家公司並給予 viewer 權限。管理操作需由管理者配置適當角色。
- 初始公司／管理者目前沒有一鍵初始化指令，需依 `lib/src/company/` 模型準備資料；這是乾淨環境進入完整業務功能前的必要步驟。
- 真實設備需完成出廠資料／Claim Code 準備、配對、憑證簽發與 MQTT 上行，才會有實際量測資料。截圖中的資料不會隨 App 自動載入。

## 日常啟動與停止

首次設定完成後：

```bash
# 終端機 A：pod_app_v1_server/
docker compose up -d postgres redis mosquitto
dart run bin/main.dart

# 終端機 B：pod_app_v1_flutter/
flutter run -d <device-id> --dart-define=AUTO_LOGIN=false \
  --dart-define=SERVER_URL=http://localhost:8080/
```

停止 App 與 Server 後，在後端目錄執行 `docker compose stop`，保留資料供下次使用。

## 開發與檢查

Model（`.spy.yaml`）或 Endpoint 公開介面變更後，在後端目錄執行 `serverpod generate`，不要手動修改 `lib/src/generated/` 或產生的 Client。有資料庫結構變更才執行 `serverpod create-migration --tag "feature-name"`，檢查 SQL 後再套用。

```bash
# pod_app_v1_server/
dart format .
dart analyze
# 整合測試需要測試服務、憑證與 passwords.yaml 的 test 設定
docker compose up -d postgres_test redis_test
dart test

# pod_app_v1_flutter/
flutter analyze
flutter test
```

## 常見問題

| 狀況 | 檢查方式 |
| --- | --- |
| 找不到 `serverpod` | 確認 CLI 已安裝，且 `$HOME/.pub-cache/bin` 已加入 PATH |
| Redis／PostgreSQL TLS 失敗 | 先建立 CA，再跑 `setup_db_ssl.sh`；確認憑證掛載與密碼一致 |
| MQTT 沒有連線 | 檢查 `setup_mqtts.sh` 產出、Broker 日誌與憑證中的 IP |
| 手機無法連 API | 不要在實機使用 `localhost`；確認 `SERVER_URL` 與區網連線 |
| 登入後沒有資料或沒有權限 | 檢查 Company、Membership、角色與設備是否已準備完成 |
| GitHub 圖片未顯示 | 確認 `screenshot/` 已提交並推送，保留路徑及檔名大小寫 |

開發規範見 [AGENTS.md](AGENTS.md)。本文件以現有程式與 Compose 為準；本機 HTTP、終端機驗證碼與初始租戶加入邏輯仍需在正式部署前另行配置。
