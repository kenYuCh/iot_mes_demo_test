BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workstation" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "active" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "workstation_company_code_uidx" ON "workstation" USING btree ("companyId", "code");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workstation_assignment" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "workstationId" bigint NOT NULL,
    "membershipId" bigint NOT NULL,
    "active" boolean NOT NULL DEFAULT true,
    "assignedBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "workstation_assignment_member_station_uidx" ON "workstation_assignment" USING btree ("membershipId", "workstationId");
CREATE INDEX "workstation_assignment_company_idx" ON "workstation_assignment" USING btree ("companyId", "active");


--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260812142223116-workstation-assignments', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260812142223116-workstation-assignments', "timestamp" = now();

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
