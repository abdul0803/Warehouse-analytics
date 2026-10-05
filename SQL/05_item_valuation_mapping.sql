-- ============================================================
-- 05_item_valuation_mapping.sql
-- Purpose:
-- Create the approved item-valuation mapping view and confirm
-- that every warehouse category/item combination is covered.
-- ============================================================


-- ------------------------------------------------------------
-- 1. CREATE THE MAPPING VIEW
-- ------------------------------------------------------------

DROP VIEW IF EXISTS item_valuation_mapping;

CREATE VIEW item_valuation_mapping AS
SELECT
    category_group,
    category_item,
    used_unit_value,
    new_unit_value,
    mapping_status,
    source_tab,
    source_section,
    source_item,
    mapping_notes,
    review_decision,
    source_url,
    source_note
FROM valuation_reference;


-- ------------------------------------------------------------
-- 2. COUNT WAREHOUSE ITEM COMBINATIONS
-- Expected: 78 category-group/item combinations
-- ------------------------------------------------------------

SELECT COUNT(*) AS warehouse_item_combinations
FROM (
    SELECT DISTINCT
        category_group,
        category_item
    FROM boxes
);


-- ------------------------------------------------------------
-- 3. COUNT VALUATION MAPPINGS
-- Expected: 78 mapping rows and 78 unique keys
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS mapping_rows,
    COUNT(
        DISTINCT category_group || '|' || category_item
    ) AS unique_mapping_keys
FROM item_valuation_mapping;


-- ------------------------------------------------------------
-- 4. CHECK FOR DUPLICATE MAPPING KEYS
-- Expected: no results
-- ------------------------------------------------------------

SELECT
    category_group,
    category_item,
    COUNT(*) AS mapping_count
FROM item_valuation_mapping
GROUP BY
    category_group,
    category_item
HAVING COUNT(*) > 1
ORDER BY mapping_count DESC;


-- ------------------------------------------------------------
-- 5. FIND WAREHOUSE ITEMS WITHOUT A VALUATION MAPPING
-- Expected: no results
-- ------------------------------------------------------------

SELECT DISTINCT
    b.category_group,
    b.category_item
FROM boxes AS b
LEFT JOIN item_valuation_mapping AS m
    ON TRIM(b.category_group) = TRIM(m.category_group)
   AND TRIM(b.category_item) = TRIM(m.category_item)
WHERE m.category_item IS NULL
ORDER BY
    b.category_group,
    b.category_item;


-- ------------------------------------------------------------
-- 6. FIND VALUATION MAPPINGS NOT USED IN THE WAREHOUSE DATA
-- Expected: no results
-- ------------------------------------------------------------

SELECT
    m.category_group,
    m.category_item
FROM item_valuation_mapping AS m
LEFT JOIN (
    SELECT DISTINCT
        category_group,
        category_item
    FROM boxes
) AS b
    ON TRIM(m.category_group) = TRIM(b.category_group)
   AND TRIM(m.category_item) = TRIM(b.category_item)
WHERE b.category_item IS NULL
ORDER BY
    m.category_group,
    m.category_item;


-- ------------------------------------------------------------
-- 7. REVIEW MAPPING QUALITY
-- ------------------------------------------------------------

SELECT
    mapping_status,
    review_decision,
    COUNT(*) AS mapping_count
FROM item_valuation_mapping
GROUP BY
    mapping_status,
    review_decision
ORDER BY
    mapping_status,
    review_decision;


-- ------------------------------------------------------------
-- 8. CHECK FOR INVALID OR MISSING VALUATION VALUES
-- Expected: no results
-- ------------------------------------------------------------

SELECT
    category_group,
    category_item,
    used_unit_value,
    new_unit_value
FROM item_valuation_mapping
WHERE used_unit_value IS NULL
   OR new_unit_value IS NULL
   OR used_unit_value < 0
   OR new_unit_value < 0
   OR used_unit_value > new_unit_value
ORDER BY
    category_group,
    category_item;