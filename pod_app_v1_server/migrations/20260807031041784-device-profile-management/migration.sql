BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "custom_device_profile" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "profileKey" text NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "features" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "custom_device_profile_company_key_uidx" ON "custom_device_profile" USING btree ("companyId", "profileKey");
CREATE INDEX "custom_device_profile_company_idx" ON "custom_device_profile" USING btree ("companyId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "device" ADD COLUMN "serialNumber" text;
ALTER TABLE "device" ALTER COLUMN "gatewayId" DROP NOT NULL;
CREATE INDEX "device_serial_idx" ON "device" USING btree ("serialNumber");

-- ESP32-00192837 是可直接連上 MQTTS 的馬達控制器，不是閘道器。
-- 保留既有 Gateway 歷史資料，只解除配對紀錄的錯誤 Gateway 關聯，讓管理者重新加入為 Device。
UPDATE "provisioned_device"
SET "model" = 'ESP32-MOTOR-01', "linkedGatewayId" = NULL
WHERE "serial" = 'ESP32-00192837';

--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260807031041784-device-profile-management', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260807031041784-device-profile-management', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
