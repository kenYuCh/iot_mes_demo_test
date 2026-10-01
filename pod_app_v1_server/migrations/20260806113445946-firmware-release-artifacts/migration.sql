BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "firmware_artifact" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "firmwarePackageId" bigint NOT NULL,
    "fileName" text NOT NULL,
    "fileType" text NOT NULL,
    "core" text,
    "storagePath" text NOT NULL,
    "sha256" text NOT NULL,
    "sizeBytes" bigint NOT NULL,
    "isPrimary" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "firmware_artifact_package_idx" ON "firmware_artifact" USING btree ("firmwarePackageId");
CREATE UNIQUE INDEX "firmware_artifact_package_name_uidx" ON "firmware_artifact" USING btree ("firmwarePackageId", "fileName");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "firmware_package" ADD COLUMN "productKey" text;
ALTER TABLE "firmware_package" ADD COLUMN "chipFamily" text;
ALTER TABLE "firmware_package" ADD COLUMN "updateProtocol" text;

--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260806113445946-firmware-release-artifacts', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260806113445946-firmware-release-artifacts', "timestamp" = now();

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
