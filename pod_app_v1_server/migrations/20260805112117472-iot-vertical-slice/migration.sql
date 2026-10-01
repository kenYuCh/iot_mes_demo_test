BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "company" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "company_name_uidx" ON "company" USING btree ("name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "company_membership" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "authUserId" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "company_membership_auth_user_uidx" ON "company_membership" USING btree ("authUserId");
CREATE INDEX "company_membership_company_idx" ON "company_membership" USING btree ("companyId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "device" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "siteId" bigint NOT NULL,
    "gatewayId" bigint NOT NULL,
    "name" text NOT NULL,
    "model" text NOT NULL,
    "deviceType" text NOT NULL,
    "expectedIntervalSeconds" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "device_company_site_idx" ON "device" USING btree ("companyId", "siteId");
CREATE INDEX "device_gateway_idx" ON "device" USING btree ("gatewayId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "device_status" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "deviceId" bigint NOT NULL,
    "connectionState" text NOT NULL,
    "latestValues" json NOT NULL,
    "lastUpdatedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "device_status_device_uidx" ON "device_status" USING btree ("deviceId");
CREATE INDEX "device_status_company_idx" ON "device_status" USING btree ("companyId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "gateway" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "siteId" bigint NOT NULL,
    "serialNumber" text NOT NULL,
    "name" text NOT NULL,
    "connectionState" text NOT NULL,
    "lastSeenAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "gateway_serial_uidx" ON "gateway" USING btree ("serialNumber");
CREATE INDEX "gateway_company_site_idx" ON "gateway" USING btree ("companyId", "siteId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "measurement" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "deviceId" bigint NOT NULL,
    "featureKey" text NOT NULL,
    "value" double precision NOT NULL,
    "measuredAt" timestamp without time zone NOT NULL,
    "receivedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "measurement_device_time_idx" ON "measurement" USING btree ("deviceId", "measuredAt");
CREATE INDEX "measurement_company_time_idx" ON "measurement" USING btree ("companyId", "measuredAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "site" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "site_company_created_idx" ON "site" USING btree ("companyId", "createdAt");


--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260805112117472-iot-vertical-slice', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260805112117472-iot-vertical-slice', "timestamp" = now();

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
