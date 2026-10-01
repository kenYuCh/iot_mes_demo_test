BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "audit_log" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "userIdentifier" text NOT NULL,
    "source" text NOT NULL,
    "action" text NOT NULL,
    "resourceType" text NOT NULL,
    "resourceId" bigint,
    "deviceId" bigint,
    "summary" text NOT NULL,
    "details" json,
    "success" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "audit_log_company_time_idx" ON "audit_log" USING btree ("companyId", "createdAt");
CREATE INDEX "audit_log_device_time_idx" ON "audit_log" USING btree ("deviceId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "automation_rule" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "name" text NOT NULL,
    "triggerDeviceId" bigint NOT NULL,
    "triggerFeatureKey" text NOT NULL,
    "comparison" text NOT NULL,
    "threshold" double precision NOT NULL,
    "recoveryThreshold" double precision NOT NULL,
    "actionDeviceId" bigint NOT NULL,
    "actionFeatureKey" text NOT NULL,
    "actionValue" double precision NOT NULL,
    "pulseOnSeconds" bigint NOT NULL,
    "intervalSeconds" bigint NOT NULL,
    "maxRepeats" bigint NOT NULL,
    "mixingDelaySeconds" bigint NOT NULL,
    "enabled" boolean NOT NULL,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "automation_rule_company_idx" ON "automation_rule" USING btree ("companyId");
CREATE INDEX "automation_rule_trigger_idx" ON "automation_rule" USING btree ("triggerDeviceId", "triggerFeatureKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "automation_run" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "ruleId" bigint NOT NULL,
    "state" text NOT NULL,
    "triggerValue" double precision NOT NULL,
    "repeatCount" bigint NOT NULL,
    "currentStep" text NOT NULL,
    "message" text,
    "startedAt" timestamp without time zone NOT NULL,
    "finishedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "automation_run_company_time_idx" ON "automation_run" USING btree ("companyId", "startedAt");
CREATE INDEX "automation_run_rule_idx" ON "automation_run" USING btree ("ruleId", "startedAt");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "custom_device_profile" ADD COLUMN "mcuFamily" text;
ALTER TABLE "custom_device_profile" ADD COLUMN "category" text;

--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260807071646616-operations-automation-audit', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260807071646616-operations-automation-audit', "timestamp" = now();

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
