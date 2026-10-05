/*
Project: Warehouse Inventory Analytics
File: 02_container_summary.sql
Purpose: Compare inventory volume, quantities, conditions,
         and category coverage across containers.
*/


-- ============================================================
-- 1. OVERALL INVENTORY SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS total_inventory_rows,
    COUNT(DISTINCT container_id) AS total_containers,
    COUNT(
        DISTINCT container_id || '-' || CAST(box_number AS TEXT)
    ) AS total_physical_boxes,
    SUM(quantity) AS total_known_quantity,
    SUM(
        CASE
            WHEN quantity IS NULL THEN 1
            ELSE 0
        END
    ) AS rows_with_unknown_quantity

FROM boxes;


-- ============================================================
-- 2. INVENTORY SUMMARY BY CONTAINER
-- ============================================================

SELECT
    container_id,

    COUNT(*) AS inventory_rows,

    COUNT(DISTINCT box_number) AS unique_boxes,

    SUM(quantity) AS known_quantity,

    SUM(
        CASE
            WHEN quantity IS NULL THEN 1
            ELSE 0
        END
    ) AS unknown_quantity_rows,

    SUM(
        CASE
            WHEN condition = 'New'
            THEN quantity
            ELSE 0
        END
    ) AS new_quantity,

    SUM(
        CASE
            WHEN condition = 'Used'
            THEN quantity
            ELSE 0
        END
    ) AS used_quantity,

    SUM(
        CASE
            WHEN condition IS NULL
              OR TRIM(condition) = ''
            THEN quantity
            ELSE 0
        END
    ) AS unknown_condition_quantity,

    SUM(
        CASE
            WHEN condition = 'New'
            THEN 1
            ELSE 0
        END
    ) AS new_rows,

    SUM(
        CASE
            WHEN condition = 'Used'
            THEN 1
            ELSE 0
        END
    ) AS used_rows,

    SUM(
        CASE
            WHEN condition IS NULL
              OR TRIM(condition) = ''
            THEN 1
            ELSE 0
        END
    ) AS unknown_condition_rows

FROM boxes

GROUP BY container_id

ORDER BY container_id;


-- ============================================================
-- 3. CONTAINER SHARE OF TOTAL KNOWN QUANTITY
-- ============================================================

SELECT
    container_id,
    SUM(quantity) AS known_quantity,

    ROUND(
        100.0 * SUM(quantity)
        / (SELECT SUM(quantity) FROM boxes),
        2
    ) AS percentage_of_total_quantity

FROM boxes

GROUP BY container_id

ORDER BY known_quantity DESC;


-- ============================================================
-- 4. CATEGORY COVERAGE BY CONTAINER
-- ============================================================

SELECT
    container_id,
    COUNT(DISTINCT category_group) AS category_groups,
    COUNT(DISTINCT category_item) AS category_items

FROM boxes

GROUP BY container_id

ORDER BY container_id;


-- ============================================================
-- 5. AVERAGE KNOWN QUANTITY PER PHYSICAL BOX
-- ============================================================

WITH box_totals AS (
    SELECT
        container_id,
        box_number,
        SUM(quantity) AS box_quantity
    FROM boxes
    GROUP BY
        container_id,
        box_number
)

SELECT
    container_id,
    COUNT(*) AS physical_boxes,
    SUM(box_quantity) AS known_quantity,

    ROUND(
        AVG(box_quantity),
        2
    ) AS average_quantity_per_box

FROM box_totals

GROUP BY container_id

ORDER BY average_quantity_per_box DESC;

/*
============================================================
CONTAINER SUMMARY FINDINGS
============================================================

1. The dataset contains 4,883 inventory rows representing
   4,604 physical boxes across 7 containers.

2. Total inventory quantity is 143,692 units after the manually
   verified quantity of 60 was added to container 2026_1.

3. Container 2026_5 has the largest quantity at 28,988 units,
   representing approximately 20.17% of total inventory.

4. Container 2026_5 also has the highest inventory density at
   46.91 known units per box. Approximately 89.61% of its known
   quantity is Used.

5. Container 2025_5 has the highest New inventory concentration:
   approximately 72.79% of its known quantity is New.

6. Container 2026_4 has the broadest category coverage with
   45 distinct category items.

7. The 77 previously missing conditions were resolved through an
   approved documented rule, leaving zero unknown-condition rows.

8. The cleaned dataset contains no missing quantities and no
   missing conditions.
============================================================
*/
