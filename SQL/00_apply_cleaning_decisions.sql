/*
Project: Warehouse Inventory Analytics
File: 00_apply_cleaning_decisions.sql
Purpose: Apply the two approved source-data corrections.

Run this immediately after 00_create_typed_boxes.sql and before any
data-quality or analytical query files.
*/

-- The source record was manually verified as quantity 60.
UPDATE boxes
SET quantity = 60
WHERE container_id = '2026_1'
  AND box_number = 188
  AND category_group = 'Western'
  AND category_item = 'Women Pants'
  AND condition = 'Used'
  AND quantity IS NULL;

/*
Approved treatment for the 77 missing conditions in container 2026_4:
  - Bedding and Children records are New.
  - The remaining clothing records are Used.

This produces six New records and 71 Used records. It changes only rows
whose condition is currently missing or blank, so rerunning is safe.
*/
UPDATE boxes
SET condition = CASE
    WHEN category_group IN ('Bedding', 'Children') THEN 'New'
    ELSE 'Used'
END
WHERE container_id = '2026_4'
  AND (condition IS NULL OR TRIM(condition) = '');

-- Expected: zero missing quantities and zero missing conditions.
SELECT
    SUM(quantity IS NULL) AS missing_quantity,
    SUM(condition IS NULL OR TRIM(condition) = '') AS missing_condition
FROM boxes;

-- Expected: New = 2,931; Used = 1,952; total = 4,883.
SELECT
    condition,
    COUNT(*) AS record_count
FROM boxes
GROUP BY condition
ORDER BY condition;

-- Expected total quantity after the correction: 143,692.
SELECT
    COUNT(*) AS total_records,
    SUM(quantity) AS total_quantity
FROM boxes;
