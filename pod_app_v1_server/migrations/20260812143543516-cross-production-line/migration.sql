BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "line_transfer" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "productUnitId" bigint NOT NULL,
    "productionOrderId" bigint NOT NULL,
    "fromLineId" bigint NOT NULL,
    "toLineId" bigint NOT NULL,
    "fromWorkstationId" bigint NOT NULL,
    "toWorkstationId" bigint NOT NULL,
    "fromNodeId" bigint NOT NULL,
    "toNodeId" bigint NOT NULL,
    "status" text NOT NULL,
    "dispatchedBy" text,
    "dispatchedAt" timestamp without time zone,
    "receivedBy" text,
    "receivedAt" timestamp without time zone,
    "note" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "line_transfer_unit_status_idx" ON "line_transfer" USING btree ("productUnitId", "status");
CREATE INDEX "line_transfer_destination_status_idx" ON "line_transfer" USING btree ("companyId", "toWorkstationId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "production_line" (
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
CREATE UNIQUE INDEX "production_line_company_code_uidx" ON "production_line" USING btree ("companyId", "code");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "workstation" ADD COLUMN "productionLineId" bigint;

--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260812143543516-cross-production-line', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260812143543516-cross-production-line', "timestamp" = now();

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
