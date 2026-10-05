-- ============================================================
-- 06_inventory_valuation.sql
-- Purpose:
-- Join inventory records to approved valuation mappings and
-- calculate estimated unit and total donation values.
-- ============================================================


-- ------------------------------------------------------------
-- 1. CREATE RECORD-LEVEL INVENTORY VALUATION VIEW
-- ------------------------------------------------------------

DROP VIEW IF EXISTS inventory_valuation;

CREATE VIEW inventory_valuation AS
SELECT
    b.container_id,
    b.box_number,
    b.category_group,
    b.category_item,
    b.quantity,
    b.condition,

    CASE
        WHEN LOWER(TRIM(b.condition)) = 'used'
            THEN m.used_unit_value
        WHEN LOWER(TRIM(b.condition)) = 'new'
            THEN m.new_unit_value
        ELSE NULL
    END AS selected_unit_value,

    ROUND(
        CAST(b.quantity AS REAL) *
        CASE
            WHEN LOWER(TRIM(b.condition)) = 'used'
                THEN m.used_unit_value
            WHEN LOWER(TRIM(b.condition)) = 'new'
                THEN m.new_unit_value
            ELSE NULL
        END,
        2
    ) AS estimated_total_value,

    m.used_unit_value,
    m.new_unit_value,
    m.mapping_status,
    m.source_tab,
    m.source_section,
    m.source_item,
    m.mapping_notes,
    m.review_decision,
    m.source_url,
    m.source_note

FROM boxes AS b

LEFT JOIN item_valuation_mapping AS m
    ON TRIM(b.category_group) = TRIM(m.category_group)
   AND TRIM(b.category_item) = TRIM(m.category_item);


-- ------------------------------------------------------------
-- 2. OVERALL VALIDATION
-- Expected:
-- 4,883 records
-- 7 containers
-- 78 item combinations
-- 0 unvalued records
-- ------------------------------------------------------------

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT container_id) AS total_containers,
    COUNT(
        DISTINCT category_group || '|' || category_item
    ) AS item_combinations,
    SUM(quantity) AS total_quantity,

    SUM(
        CASE
            WHEN selected_unit_value IS NULL
              OR estimated_total_value IS NULL
            THEN 1
            ELSE 0
        END
    ) AS unvalued_records,

    ROUND(SUM(estimated_total_value), 2)
        AS estimated_inventory_value

FROM inventory_valuation;


-- ------------------------------------------------------------
-- 3. FIND ANY RECORDS THAT FAILED VALUATION
-- Expected: no results
-- ------------------------------------------------------------

SELECT
    container_id,
    box_number,
    category_group,
    category_item,
    quantity,
    condition,
    mapping_status,
    selected_unit_value,
    estimated_total_value
FROM inventory_valuation
WHERE selected_unit_value IS NULL
   OR estimated_total_value IS NULL
ORDER BY
    container_id,
    box_number;


-- ------------------------------------------------------------
-- 4. VALUE BY CONDITION
-- ------------------------------------------------------------

SELECT
    condition,
    COUNT(*) AS record_count,
    SUM(quantity) AS total_quantity,
    ROUND(AVG(selected_unit_value), 2)
        AS average_unit_value,
    ROUND(SUM(estimated_total_value), 2)
        AS estimated_value,
    ROUND(
        100.0 * SUM(estimated_total_value) /
        SUM(SUM(estimated_total_value)) OVER (),
        2
    ) AS percentage_of_total_value
FROM inventory_valuation
GROUP BY condition
ORDER BY estimated_value DESC;


-- ------------------------------------------------------------
-- 5. VALUE BY CONTAINER
-- ------------------------------------------------------------

SELECT
    container_id,
    COUNT(*) AS record_count,
    COUNT(DISTINCT box_number) AS unique_boxes,
    SUM(quantity) AS total_quantity,

    SUM(
        CASE WHEN LOWER(TRIM(condition)) = 'new'
             THEN quantity ELSE 0 END
    ) AS new_quantity,

    SUM(
        CASE WHEN LOWER(TRIM(condition)) = 'used'
             THEN quantity ELSE 0 END
    ) AS used_quantity,

    ROUND(SUM(estimated_total_value), 2)
        AS estimated_value,

    ROUND(
        100.0 * SUM(estimated_total_value) /
        SUM(SUM(estimated_total_value)) OVER (),
        2
    ) AS percentage_of_total_value

FROM inventory_valuation
GROUP BY container_id
ORDER BY estimated_value DESC;


-- ------------------------------------------------------------
-- 6. VALUE BY CATEGORY GROUP
-- ------------------------------------------------------------

SELECT
    category_group,
    COUNT(*) AS record_count,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(estimated_total_value), 2)
        AS estimated_value,

    ROUND(
        100.0 * SUM(estimated_total_value) /
        SUM(SUM(estimated_total_value)) OVER (),
        2
    ) AS percentage_of_total_value

FROM inventory_valuation
GROUP BY category_group
ORDER BY estimated_value DESC;


-- ------------------------------------------------------------
-- 7. VALUE BY CATEGORY ITEM
-- ------------------------------------------------------------

SELECT
    category_group,
    category_item,
    COUNT(*) AS record_count,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(estimated_total_value), 2)
        AS estimated_value,
    mapping_status
FROM inventory_valuation
GROUP BY
    category_group,
    category_item,
    mapping_status
ORDER BY estimated_value DESC;


-- ------------------------------------------------------------
-- 8. VALUE BY MAPPING QUALITY
-- Shows how much of the estimate relies on Exact,
-- Approximate, or Assumed mappings.
-- ------------------------------------------------------------

SELECT
    mapping_status,
    COUNT(*) AS record_count,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(estimated_total_value), 2)
        AS estimated_value,

    ROUND(
        100.0 * SUM(estimated_total_value) /
        SUM(SUM(estimated_total_value)) OVER (),
        2
    ) AS percentage_of_total_value

FROM inventory_valuation
GROUP BY mapping_status
ORDER BY estimated_value DESC;


-- ------------------------------------------------------------
-- 9. FINAL SANITY CHECK
-- Expected: no results
-- ------------------------------------------------------------

SELECT *
FROM inventory_valuation
WHERE quantity < 0
   OR selected_unit_value < 0
   OR estimated_total_value < 0
   OR review_decision <> 'Approved';