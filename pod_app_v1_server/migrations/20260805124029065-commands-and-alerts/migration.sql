BEGIN;

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
    "enabled" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "alert_rule_device_idx" ON "alert_rule" USING btree ("deviceId");
CREATE INDEX "alert_rule_company_idx" ON "alert_rule" USING btree ("companyId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "device_command" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "deviceId" bigint NOT NULL,
    "commandType" text NOT NULL,
    "payload" json NOT NULL,
    "state" text NOT NULL,
    "idempotencyKey" text NOT NULL,
    "issuedBy" text NOT NULL,
    "errorMessage" text,
    "createdAt" timestamp without time zone NOT NULL,
    "sentAt" timestamp without time zone,
    "acknowledgedAt" timestamp without time zone,
    "completedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "device_command_idem_uidx" ON "device_command" USING btree ("idempotencyKey");
CREATE INDEX "device_command_device_idx" ON "device_command" USING btree ("deviceId", "createdAt");
CREATE INDEX "device_command_company_idx" ON "device_command" USING btree ("companyId");


--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260805124029065-commands-and-alerts', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260805124029065-commands-and-alerts', "timestamp" = now();

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
