BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "company_membership" ADD COLUMN "permissions" json;
ALTER TABLE "company_membership" ADD COLUMN "email" text;
ALTER TABLE "company_membership" ADD COLUMN "displayName" text;
ALTER TABLE "company_membership" ADD COLUMN "isActive" boolean NOT NULL DEFAULT true;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "device_share" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "deviceId" bigint NOT NULL,
    "membershipId" bigint NOT NULL,
    "canRead" boolean NOT NULL DEFAULT true,
    "canWrite" boolean NOT NULL DEFAULT false,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "device_share_device_member_uidx" ON "device_share" USING btree ("deviceId", "membershipId");
CREATE INDEX "device_share_company_idx" ON "device_share" USING btree ("companyId");
CREATE INDEX "device_share_membership_idx" ON "device_share" USING btree ("membershipId");


--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260808025721618-access-sharing-offline', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260808025721618-access-sharing-offline', "timestamp" = now();

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
