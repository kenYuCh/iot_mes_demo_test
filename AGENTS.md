# Serverpod IoT Platform — Agent Development Rules

本規則適用於 `pod_app_v1/` 及其子目錄。產品與技術規格入口位於
[`../docs/README.md`](../docs/README.md)。

## 目錄

- [1. 文件目的](#1-文件目的)
- [2. 專案技術範圍](#2-專案技術範圍)
- [3. Agent 工作流程](#3-agent-工作流程)
- [4. Serverpod 命令規範](#4-serverpod-命令規範)
- [5. 架構分層規範](#5-架構分層規範)
- [6. 資料模型規範](#6-資料模型規範)
- [7. API 與 Endpoint 規範](#7-api-與-endpoint-規範)
- [8. IoT 即時資料規範](#8-iot-即時資料規範)
- [9. Migration 安全規範](#9-migration-安全規範)
- [10. 測試與品質檢查](#10-測試與品質檢查)
- [11. 允許與禁止的命令](#11-允許與禁止的命令)
- [12. 最終回報格式](#12-最終回報格式)

---

# 1. 文件目的

本文件用於約束 Codex、Claude、Cursor 或其他 AI Agent 在本 Serverpod IoT 專案中的開發行為。

所有 Agent 必須：

1. 先理解現有專案，再修改程式。
2. 優先沿用既有架構與命名。
3. 不直接修改 Serverpod 產生檔。
4. 模型變更後執行程式碼產生。
5. 資料庫結構變更必須建立 Migration。
6. Migration 套用前必須檢查 SQL。
7. 所有修改必須通過格式化、分析與測試。
8. 不得隱藏失敗、警告或未完成事項。

---

# 2. 專案技術範圍

> 版本註記：本 repo 目前釘選 Serverpod 3.4.11 / Dart ^3.8.0 / Flutter ^3.32.0 / PostgreSQL 16 / Redis 6.2.6。文件中「請確認版本」的提醒仍適用於升級時，但開發時應以上述釘選版本為準。

主要技術：

```text
Flutter
Dart
Serverpod
PostgreSQL
Redis
MQTT
Serverpod Streaming（WebSocket）
Docker Compose
Riverpod
```

主要 IoT 層級：

```text
Company
└── Project
    └── Site
        └── Area
            └── Gateway
                └── Device
                    └── DeviceFeature
```

主要資料類型：

```text
Metadata        固定資料
Realtime State  最新狀態
Measurement     歷史量測
Event           設備事件
Alarm           告警
Command         控制命令
Audit Log       操作稽核
```

---

# 3. Agent 工作流程

每次任務依序執行。

## 3.1 任務前檢查

先檢查：

```text
pubspec.yaml
config/generator.yaml
config/development.yaml
docker-compose.yaml
lib/src/{feature}/（功能模組資料夾，含 *.spy.yaml Model、Endpoint、Service、Repository）
lib/src/generated/
migrations/
test/
```

Serverpod 3 採功能模組佈局：Model 為 `.spy.yaml` 檔，與同功能的 Endpoint、Service、Repository 放在 `lib/src/{feature}/`（例如 `lib/src/greetings/greeting.spy.yaml`）；`lib/src/generated/` 由產生器維護，不得手動修改。

同時確認：

```bash
dart --version
serverpod --version
serverpod help
git status
```

不可假設 Serverpod 版本或命令支援情況；應以目前專案與 CLI 實際輸出為準。

## 3.2 修改前分析

Agent 必須先回答：

1. 功能涉及哪些 Model？
2. 是否影響資料庫 Schema？
3. 是否需要 Migration？
4. 是否影響產生的 Client？
5. 是否涉及登入、租戶或權限？
6. 是否涉及高頻資料？
7. 是否可能產生 N+1 Query？
8. 是否需要索引、快取或批次處理？
9. 是否需要補測試？
10. 是否存在資料損失風險？

## 3.3 實作順序

```text
需求分析
→ 搜尋既有實作
→ 設計 Model / DTO
→ 修改 YAML 或原始碼
→ serverpod generate
→ Repository
→ Service
→ Endpoint
→ Migration
→ 檢查 SQL
→ 測試
→ 格式化與分析
→ git diff
```

---

# 4. Serverpod 命令規範

## 4.1 取得套件

```bash
dart pub get
```

Flutter 專案：

```bash
flutter pub get
```

## 4.2 產生程式碼

修改 Model、Protocol、Exception、Enum 或 Endpoint 公開介面後：

```bash
serverpod generate
```

需要確認命令選項時：

```bash
serverpod help generate
```

## 4.3 建立 Migration

```bash
serverpod create-migration --tag "feature-name"
```

建立後必須檢查新 Migration 目錄中的 SQL 與定義檔。

## 4.4 套用 Migration

開發環境：

```bash
dart run bin/main.dart --apply-migrations
```

CI 或維護程序：

```bash
dart run bin/main.dart --role maintenance --apply-migrations
```

## 4.5 啟動服務

傳統流程：

```bash
docker compose up -d
dart run bin/main.dart
```

若目前 CLI 支援整合式開發流程，可使用：

```bash
serverpod start
```

Agent 必須先確認目前版本支援，不得盲目改用新版命令。

---

# 5. 架構分層規範

```text
Endpoint
└── 驗證輸入、驗證登入、驗證權限、呼叫 Service

Service
└── 商業邏輯、交易流程、狀態轉換、跨 Repository 協調

Repository
└── PostgreSQL 查詢、寫入、分頁、鎖定與 Transaction

Integration
└── MQTT、Redis、外部 API、通知、檔案儲存

Worker
└── 批次寫入、排程、聚合、離線判斷、告警運算
```

禁止：

- Endpoint 直接塞入大量商業邏輯。
- UI 傳入 tenantId 後就直接信任。
- Service 內大量複製 SQL 查詢。
- Repository 負責 UI 顯示格式。
- 高頻 MQTT Callback 直接逐筆寫 PostgreSQL。

詳細規範請參考：

```text
../docs/backend/serverpod-architecture.md
../docs/backend/database-rules.md
../docs/backend/api-rules.md
../docs/backend/iot-data-flow.md
```

---

# 6. 資料模型規範

1. 所有租戶資料必須可追溯至 `companyId`。
2. 固定資料與即時狀態分離。
3. 高頻量測不得存入 Device 主表。
4. 時間使用 UTC 儲存。
5. 列表回傳使用摘要 DTO。
6. 關聯欄位必須評估索引。
7. 唯一限制優先由資料庫保證。
8. 不使用無結構 JSON 取代所有正式欄位。
9. JSON 欄位必須有版本或 Schema 管理策略。
10. 刪除資料優先採 Soft Delete，除非明確定義可物理刪除。

---

# 7. API 與 Endpoint 規範

所有 Endpoint 必須：

1. 驗證使用者登入狀態。
2. 驗證 Company、Site 或 Resource Scope。
3. 驗證輸入長度、範圍與格式。
4. 大型列表使用分頁。
5. `limit` 必須設上限。
6. 不回傳密碼、Token 或內部機密欄位。
7. 不接受 Client 指定審計欄位。
8. 重要寫入支援 Idempotency。
9. 控制命令必須回傳 `commandId`。
10. 大量即時更新使用 Streaming，而非高頻輪詢。

---

# 8. IoT 即時資料規範

標準資料流：

```text
Device
→ Gateway
→ MQTT Broker
→ Ingestion Consumer
→ Validation / Deduplication
→ Redis Latest State
→ Batch Writer
→ PostgreSQL History
→ Aggregation
→ Serverpod Streaming
→ Flutter
```

必要欄位：

```text
messageId
deviceId
gatewayId
timestamp
receivedAt
sequence
schemaVersion
params
```

必要機制：

- 訊息去重。
- Sequence 或時間順序檢查。
- 過期資料不得覆蓋較新狀態。
- Redis 保存最新狀態。
- PostgreSQL 批次保存歷史資料。
- Dashboard 使用摘要。
- 前端只訂閱目前需要的範圍。
- 控制命令包含 ACK、Timeout 與 Idempotency Key。

---

# 9. Migration 安全規範

建立 Migration 後，檢查：

```text
DROP TABLE
DROP COLUMN
ALTER COLUMN TYPE
SET NOT NULL
UNIQUE
FOREIGN KEY
DEFAULT
INDEX
資料回填
大量表鎖定
```

禁止 Agent 自動執行：

```bash
serverpod create-migration --force
serverpod create-repair-migration --force
docker compose down -v
```

除非使用者明確授權，且 Agent 已說明資料風險。

詳細規範請參考：

```text
../docs/backend/migration-rules.md
```

---

# 10. 測試與品質檢查

Server 修改後至少執行：

```bash
dart format .
dart analyze
dart test
```

Flutter 修改後至少執行：

```bash
flutter analyze
flutter test
```

模型或 Endpoint 變更後：

```bash
serverpod generate
```

最後檢查：

```bash
git status
git diff
```

測試至少涵蓋：

- 正常流程。
- 未登入。
- 無權限。
- 跨租戶存取。
- 無效輸入。
- 重複資料。
- 分頁邊界。
- Transaction Rollback。
- Idempotency。
- 舊訊息覆蓋防護。
- N+1 Query 風險。

---

# 11. 允許與禁止的命令

## 11.1 一般可執行

```bash
serverpod --version
serverpod help
serverpod generate
dart pub get
dart format .
dart analyze
dart test
flutter pub get
flutter analyze
flutter test
git status
git diff
docker compose ps
docker compose logs
```

## 11.2 執行前需檢查

```bash
serverpod create-migration
dart run bin/main.dart --apply-migrations
docker compose up -d
docker compose down
```

## 11.3 禁止自行執行

```bash
serverpod create-migration --force
serverpod create-repair-migration --force
docker compose down -v
DROP DATABASE
DROP TABLE
TRUNCATE
rm -rf
git reset --hard
git clean -fd
```

---

# 12. 最終回報格式

每次任務完成後，Agent 必須回報：

```text
1. 任務摘要
2. 問題根因或設計判斷
3. 修改檔案
4. Model / API / Database 變更
5. 執行命令
6. 測試結果
7. Migration 內容與風險
8. 效能影響
9. 安全與權限影響
10. 尚未完成或需要人工確認事項
```
