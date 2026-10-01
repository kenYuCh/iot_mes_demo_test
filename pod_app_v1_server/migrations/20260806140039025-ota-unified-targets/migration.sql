BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "gateway" ADD COLUMN "model" text;
ALTER TABLE "gateway" ADD COLUMN "productKey" text;
ALTER TABLE "gateway" ADD COLUMN "chipFamily" text;
ALTER TABLE "gateway" ADD COLUMN "updateProtocol" text;
ALTER TABLE "gateway" ADD COLUMN "hardwareRevision" text;
ALTER TABLE "gateway" ADD COLUMN "firmwareVersion" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "ota_device_job" ADD COLUMN "gatewayId" bigint;
ALTER TABLE "ota_device_job" ALTER COLUMN "deviceId" DROP NOT NULL;
CREATE INDEX "ota_job_gateway_idx" ON "ota_device_job" USING btree ("gatewayId", "updatedAt");

--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260806140039025-ota-unified-targets', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260806140039025-ota-unified-targets', "timestamp" = now();

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
