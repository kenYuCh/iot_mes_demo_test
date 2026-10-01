BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "feature_definition" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "featureKey" text NOT NULL,
    "label" text NOT NULL,
    "unit" text NOT NULL,
    "kind" text NOT NULL,
    "dataType" text,
    "controlPresentation" text,
    "enumOptions" json,
    "precision" bigint,
    "description" text,
    "minValue" double precision NOT NULL,
    "maxValue" double precision NOT NULL,
    "defaultValue" double precision,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "feature_definition_company_key_uidx" ON "feature_definition" USING btree ("companyId", "featureKey");
CREATE INDEX "feature_definition_company_idx" ON "feature_definition" USING btree ("companyId");


--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260807052654999-feature-catalog', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260807052654999-feature-catalog', "timestamp" = now();

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
