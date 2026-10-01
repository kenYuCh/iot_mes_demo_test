BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bom_item" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "productDefinitionId" bigint NOT NULL,
    "materialId" bigint NOT NULL,
    "quantity" double precision NOT NULL,
    "unit" text NOT NULL,
    "scrapRatePercent" double precision NOT NULL DEFAULT 0,
    "note" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "bom_product_material_uidx" ON "bom_item" USING btree ("companyId", "productDefinitionId", "materialId");
CREATE INDEX "bom_product_idx" ON "bom_item" USING btree ("productDefinitionId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "material" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "type" text NOT NULL,
    "specification" text,
    "unit" text NOT NULL,
    "supplier" text,
    "safetyStock" double precision NOT NULL DEFAULT 0,
    "active" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "material_company_code_uidx" ON "material" USING btree ("companyId", "code");
CREATE INDEX "material_company_name_idx" ON "material" USING btree ("companyId", "name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "material_lot" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "materialId" bigint NOT NULL,
    "lotNumber" text NOT NULL,
    "quantity" double precision NOT NULL,
    "receivedAt" timestamp without time zone NOT NULL,
    "expiresAt" timestamp without time zone,
    "supplierLot" text,
    "qrCode" text,
    "rfidEpc" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "material_lot_company_number_uidx" ON "material_lot" USING btree ("companyId", "lotNumber");
CREATE INDEX "material_lot_material_idx" ON "material_lot" USING btree ("materialId", "receivedAt");
CREATE UNIQUE INDEX "material_lot_qr_uidx" ON "material_lot" USING btree ("companyId", "qrCode");
CREATE UNIQUE INDEX "material_lot_rfid_uidx" ON "material_lot" USING btree ("companyId", "rfidEpc");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "process_event" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "clientEventId" text NOT NULL,
    "productUnitId" bigint NOT NULL,
    "productionOrderId" bigint NOT NULL,
    "processNodeId" bigint NOT NULL,
    "stationCode" text NOT NULL,
    "eventType" text NOT NULL,
    "result" text NOT NULL,
    "operatorId" text NOT NULL,
    "deviceId" bigint,
    "materialLotIds" json,
    "measurements" json,
    "note" text,
    "occurredAt" timestamp without time zone NOT NULL,
    "receivedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "process_event_company_client_uidx" ON "process_event" USING btree ("companyId", "clientEventId");
CREATE INDEX "process_event_unit_time_idx" ON "process_event" USING btree ("productUnitId", "occurredAt");
CREATE INDEX "process_event_order_time_idx" ON "process_event" USING btree ("productionOrderId", "occurredAt");
CREATE INDEX "process_event_station_time_idx" ON "process_event" USING btree ("companyId", "stationCode", "occurredAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "process_node" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "routeId" bigint NOT NULL,
    "sequence" bigint NOT NULL,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "stationCode" text NOT NULL,
    "standardSeconds" bigint NOT NULL,
    "scanMode" text NOT NULL DEFAULT 'startComplete'::text,
    "allowSkip" boolean NOT NULL DEFAULT false,
    "allowRework" boolean NOT NULL DEFAULT true,
    "measurementRequirements" json,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "process_node_route_sequence_uidx" ON "process_node" USING btree ("routeId", "sequence");
CREATE UNIQUE INDEX "process_node_route_code_uidx" ON "process_node" USING btree ("routeId", "code");
CREATE INDEX "process_node_station_idx" ON "process_node" USING btree ("companyId", "stationCode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "process_route" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "productDefinitionId" bigint NOT NULL,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "version" bigint NOT NULL DEFAULT 1,
    "active" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "process_route_company_code_version_uidx" ON "process_route" USING btree ("companyId", "code", "version");
CREATE INDEX "process_route_product_idx" ON "process_route" USING btree ("productDefinitionId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "product_definition" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "code" text NOT NULL,
    "name" text NOT NULL,
    "specification" text,
    "unit" text NOT NULL,
    "active" boolean NOT NULL DEFAULT true,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "product_definition_company_code_uidx" ON "product_definition" USING btree ("companyId", "code");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "product_unit" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "productionOrderId" bigint NOT NULL,
    "productDefinitionId" bigint NOT NULL,
    "serialNumber" text NOT NULL,
    "qrCode" text NOT NULL,
    "rfidEpc" text,
    "status" text NOT NULL,
    "currentNodeId" bigint,
    "currentStationCode" text,
    "enteredNodeAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "product_unit_company_serial_uidx" ON "product_unit" USING btree ("companyId", "serialNumber");
CREATE UNIQUE INDEX "product_unit_company_qr_uidx" ON "product_unit" USING btree ("companyId", "qrCode");
CREATE UNIQUE INDEX "product_unit_company_rfid_uidx" ON "product_unit" USING btree ("companyId", "rfidEpc");
CREATE INDEX "product_unit_order_status_idx" ON "product_unit" USING btree ("productionOrderId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "production_order" (
    "id" bigserial PRIMARY KEY,
    "companyId" bigint NOT NULL,
    "orderNumber" text NOT NULL,
    "productDefinitionId" bigint NOT NULL,
    "routeId" bigint NOT NULL,
    "plannedQuantity" bigint NOT NULL,
    "completedQuantity" bigint NOT NULL DEFAULT 0,
    "rejectedQuantity" bigint NOT NULL DEFAULT 0,
    "status" text NOT NULL,
    "scheduledStart" timestamp without time zone,
    "scheduledEnd" timestamp without time zone,
    "startedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "createdBy" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "production_order_company_number_uidx" ON "production_order" USING btree ("companyId", "orderNumber");
CREATE INDEX "production_order_status_idx" ON "production_order" USING btree ("companyId", "status");


--
-- MIGRATION VERSION FOR pod_app_v1
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('pod_app_v1', '20260812132535260-production-trace-mes', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260812132535260-production-trace-mes', "timestamp" = now();

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
