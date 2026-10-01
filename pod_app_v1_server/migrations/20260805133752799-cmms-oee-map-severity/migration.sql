BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "alert" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "alert" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "siteId" bigint NOT NULL,
    "deviceId" bigint NOT NULL,
    "ruleId" bigint NOT NULL,
    "featureKey" text NOT NULL,
    "triggeredValue" double precision NOT NULL,
    "threshold" double precision NOT NULL,
    "comparison" text NOT NULL,
    "severity" text NOT NULL,
    "state" text NOT NULL,
    "message" text NOT NULL,
    "triggeredAt" timestamp without time zone NOT NULL,
    "acknowledgedAt" timestamp without time zone,
    "resolvedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "alert_company_state_idx" ON "alert" USING btree ("companyId", "state");
CREATE INDEX "alert_rule_active_idx" ON "alert" USING btree ("ruleId", "state");
CREATE INDEX "alert_device_idx" ON "alert" USING btree ("deviceId");

--
-- ACTION DROP TABLE
--
DROP TABLE "alert_rule" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "alert_rule" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "deviceId" bigint NOT NULL,
    "featureKey" text NOT NULL,
    "name" text NOT NULL,
    "comparison" text NOT NULL,
    "threshold" double precision NOT NULL,
    "severity" text NOT NULL,
    "enabled" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "alert_rule_device_idx" ON "alert_rule" USING btree ("deviceId");
CREATE INDEX "alert_rule_company_idx" ON "alert_rule" USING btree ("companyId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "device" ADD COLUMN "mapX" double precision;
ALTER TABLE "device" ADD COLUMN "mapY" double precision;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "production_stat" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "siteId" bigint NOT NULL,
    "windowStart" timestamp without time zone NOT NULL,
    "plannedMinutes" double precision NOT NULL,
    "runMinutes" double precision NOT NULL,
    "idealCount" bigint NOT NULL,
    "actualCount" bigint NOT NULL,
    "goodCount" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "production_stat_site_window_uidx" ON "production_stat" USING btree ("siteId", "windowStart");
CREATE INDEX "production_stat_company_idx" ON "production_stat" USING btree ("companyId", "windowStart");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "work_order" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "siteId" bigint NOT NULL,
    "deviceId" bigint,
    "alertId" bigint,
    "title" text NOT NULL,
    "description" text,
    "status" text NOT NULL,
    "priority" text NOT NULL,
    "note" text,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "startedAt" timestamp without time zone,
    "completedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "work_order_company_status_idx" ON "work_order" USING btree ("companyId", "status");
CREATE INDEX "work_order_site_idx" ON "work_order" USING btree ("siteId");
CREATE INDEX "work_order_device_idx" ON "work_order" USING btree ("deviceId");


--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260805133752799-cmms-oee-map-severity', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260805133752799-cmms-oee-map-severity', "timestamp" = now();

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
