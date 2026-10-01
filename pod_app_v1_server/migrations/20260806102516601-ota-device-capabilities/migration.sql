BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "device" ADD COLUMN "hardwareRevision" text;
ALTER TABLE "device" ADD COLUMN "firmwareVersion" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "firmware_package" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "name" text NOT NULL,
    "version" text NOT NULL,
    "targetDeviceType" text NOT NULL,
    "hardwareRevision" text,
    "releaseNotes" text,
    "downloadUrl" text NOT NULL,
    "sha256" text NOT NULL,
    "sizeBytes" bigint NOT NULL,
    "state" text NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "firmware_company_type_idx" ON "firmware_package" USING btree ("companyId", "targetDeviceType");
CREATE UNIQUE INDEX "firmware_company_version_uidx" ON "firmware_package" USING btree ("companyId", "targetDeviceType", "version");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ota_campaign" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "firmwarePackageId" bigint NOT NULL,
    "name" text NOT NULL,
    "targetDeviceType" text NOT NULL,
    "strategy" text NOT NULL,
    "state" text NOT NULL,
    "scheduledAt" timestamp without time zone,
    "totalDevices" bigint NOT NULL,
    "succeededDevices" bigint NOT NULL,
    "failedDevices" bigint NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "startedAt" timestamp without time zone,
    "completedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "ota_campaign_company_created_idx" ON "ota_campaign" USING btree ("companyId", "createdAt");
CREATE INDEX "ota_campaign_firmware_idx" ON "ota_campaign" USING btree ("firmwarePackageId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ota_device_job" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "campaignId" bigint NOT NULL,
    "deviceId" bigint NOT NULL,
    "state" text NOT NULL,
    "progress" bigint NOT NULL,
    "previousVersion" text,
    "errorMessage" text,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "ota_job_campaign_idx" ON "ota_device_job" USING btree ("campaignId");
CREATE INDEX "ota_job_device_idx" ON "ota_device_job" USING btree ("deviceId", "updatedAt");
CREATE UNIQUE INDEX "ota_job_campaign_device_uidx" ON "ota_device_job" USING btree ("campaignId", "deviceId");


--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260806102516601-ota-device-capabilities', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260806102516601-ota-device-capabilities', "timestamp" = now();

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
