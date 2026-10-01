BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "company_membership" ADD COLUMN "role" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "firmware_package" ADD COLUMN "fileName" text;
ALTER TABLE "firmware_package" ADD COLUMN "storagePath" text;
ALTER TABLE "firmware_package" ADD COLUMN "deletedAt" timestamp without time zone;
ALTER TABLE "firmware_package" ADD COLUMN "deletedBy" text;

--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260806111702288-firmware-asset-rbac', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260806111702288-firmware-asset-rbac', "timestamp" = now();

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
