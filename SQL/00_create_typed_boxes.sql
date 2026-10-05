/*
Project: Warehouse Inventory Analytics
File: 00_create_typed_boxes.sql
Purpose: Rebuild the analysis-ready boxes table from the preserved
         text backup while keeping the source table unchanged.

Run order:
  1. Import the source data as boxes_text_backup.
  2. Run this file.
  3. Run 00_apply_cleaning_decisions.sql.

This script intentionally does not start or commit a transaction because
DB Browser for SQLite manages transactions through Write Changes.
*/

-- Remove derived views before replacing their source table. Later files
-- recreate the final views, so no analytical result is lost.
DROP VIEW IF EXISTS inventory_valuation;
DROP VIEW IF EXISTS vw_category_valuation;
DROP VIEW IF EXISTS vw_container_valuation;
DROP VIEW IF EXISTS vw_inventory_valuation_detail;

DROP TABLE IF EXISTS boxes_typed_rebuild;

CREATE TABLE boxes_typed_rebuild (
    container_id TEXT NOT NULL,
    box_number INTEGER NOT NULL CHECK (box_number > 0),
    category_group TEXT NOT NULL,
    category_item TEXT NOT NULL,
    quantity INTEGER CHECK (quantity IS NULL OR quantity >= 0),
    condition TEXT CHECK (
        condition IS NULL OR condition IN ('New', 'Used')
    )
);

INSERT INTO boxes_typed_rebuild (
    container_id,
    box_number,
    category_group,
    category_item,
    quantity,
    condition
)
SELECT
    TRIM(Container_id),
    CAST(TRIM(Box_number) AS INTEGER),
    TRIM(category_group),
    TRIM(category_item),
    CASE
        WHEN quantity IS NULL OR TRIM(quantity) = '' THEN NULL
        ELSE CAST(TRIM(quantity) AS INTEGER)
    END,
    CASE
        WHEN condition IS NULL OR TRIM(condition) = '' THEN NULL
        ELSE TRIM(condition)
    END
FROM boxes_text_backup;

-- Replace only the derived analysis table. The source backup is preserved.
DROP TABLE IF EXISTS boxes;
ALTER TABLE boxes_typed_rebuild RENAME TO boxes;

CREATE INDEX IF NOT EXISTS idx_boxes_container
    ON boxes (container_id);

CREATE INDEX IF NOT EXISTS idx_boxes_item
    ON boxes (category_group, category_item);

CREATE INDEX IF NOT EXISTS idx_boxes_condition
    ON boxes (condition);

-- Expected: 4,883 rows and 7 containers.
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT container_id) AS distinct_containers
FROM boxes;

-- Expected before cleaning: one missing quantity and 77 missing conditions.
SELECT
    SUM(quantity IS NULL) AS missing_quantity,
    SUM(condition IS NULL OR TRIM(condition) = '') AS missing_condition
FROM boxes;
