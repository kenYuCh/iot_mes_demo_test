BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "device_certificate" (
    "id" bigserial PRIMARY KEY,
    "serial" text NOT NULL,
    "certSerialNumber" text NOT NULL,
    "subjectCn" text NOT NULL,
    "certificatePem" text NOT NULL,
    "version" bigint NOT NULL,
    "issuedAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "revoked" boolean NOT NULL,
    "revokedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "device_certificate_serial_idx" ON "device_certificate" USING btree ("serial");
CREATE UNIQUE INDEX "device_certificate_cert_serial_uidx" ON "device_certificate" USING btree ("certSerialNumber");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "device_claim" (
    "id" bigserial PRIMARY KEY,
    "sessionId" text NOT NULL,
    "serial" text NOT NULL,
    "userIdentifier" text NOT NULL,
    "companyId" bigint NOT NULL,
    "status" text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "confirmedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "device_claim_session_uidx" ON "device_claim" USING btree ("sessionId");
CREATE INDEX "device_claim_serial_idx" ON "device_claim" USING btree ("serial");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "provisioned_device" (
    "id" bigserial PRIMARY KEY,
    "serial" text NOT NULL,
    "model" text NOT NULL,
    "claimCodeHash" text NOT NULL,
    "state" text NOT NULL,
    "companyId" bigint,
    "claimedBy" text,
    "claimedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "provisioned_device_serial_uidx" ON "provisioned_device" USING btree ("serial");
CREATE INDEX "provisioned_device_company_idx" ON "provisioned_device" USING btree ("companyId");


--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260805143126837-provisioning-mtls', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260805143126837-provisioning-mtls', "timestamp" = now();

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
