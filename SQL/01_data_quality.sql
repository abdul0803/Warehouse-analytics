/*
Project: Warehouse Inventory Analytics
File: 01_data_quality.sql
Purpose: Validate dataset size, missing values, condition values,
         and possible duplicate records before analysis.
*/


-- ============================================================
-- 1. DATASET SIZE AND CONTAINER COVERAGE
-- Expected: 4,883 rows and 7 distinct containers
-- ============================================================

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT container_id) AS distinct_containers
FROM boxes;


-- ============================================================
-- 2. MISSING OR BLANK VALUES BY COLUMN
-- Expected after 00_apply_cleaning_decisions.sql:
-- missing_quantity = 0
-- missing_condition = 0
-- ============================================================

SELECT
    SUM(
        CASE
            WHEN container_id IS NULL
              OR TRIM(container_id) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_container_id,

    SUM(
        CASE
            WHEN box_number IS NULL
              OR TRIM(CAST(box_number AS TEXT)) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_box_number,

    SUM(
        CASE
            WHEN category_group IS NULL
              OR TRIM(category_group) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_category_group,

    SUM(
        CASE
            WHEN category_item IS NULL
              OR TRIM(category_item) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_category_item,

    SUM(
        CASE
            WHEN quantity IS NULL
              OR TRIM(CAST(quantity AS TEXT)) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_quantity,

    SUM(
        CASE
            WHEN condition IS NULL
              OR TRIM(condition) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_condition

FROM boxes;

-- ============================================================
-- 3. CONDITION DISTRIBUTION
-- Expected: New = 2,931 and Used = 1,952
-- ============================================================

SELECT
    condition AS condition_status,
    COUNT(*) AS row_count,
    ROUND(
        100.0 * COUNT(*) / (SELECT COUNT(*) FROM boxes),
        2
    ) AS percentage_of_rows
FROM boxes
GROUP BY condition
ORDER BY row_count DESC;

-- ============================================================
-- 4. EXACT DUPLICATE RECORDS
-- Returns only groups where every field is identical
-- No returned rows means there are no exact duplicates
-- ============================================================

SELECT
    container_id,
    box_number,
    category_group,
    category_item,
    quantity,
    condition,
    COUNT(*) AS duplicate_count

FROM boxes

GROUP BY
    container_id,
    box_number,
    category_group,
    category_item,
    quantity,
    condition

HAVING COUNT(*) > 1

ORDER BY
    duplicate_count DESC,
    container_id,
    box_number;


-- ============================================================
-- 5. REPEATED BOX NUMBERS WITHIN THE SAME CONTAINER
-- These are possible duplicates and require investigation
-- ============================================================

SELECT
    container_id,
    box_number,
    COUNT(*) AS row_count,
    COUNT(DISTINCT category_group) AS distinct_category_groups,
    COUNT(DISTINCT category_item) AS distinct_category_items

FROM boxes

GROUP BY
    container_id,
    box_number

HAVING COUNT(*) > 1

ORDER BY
    row_count DESC,
    container_id,
    box_number;


-- ============================================================
-- 6. DETAILS FOR REPEATED BOX NUMBERS
-- Shows the underlying records identified in Section 5
-- ============================================================

SELECT
    b.container_id,
    b.box_number,
    b.category_group,
    b.category_item,
    b.quantity,
    CASE
        WHEN b.condition IS NULL
          OR TRIM(b.condition) = ''
        THEN 'Unknown'
        ELSE TRIM(b.condition)
    END AS condition_status

FROM boxes AS b

INNER JOIN (
    SELECT
        container_id,
        box_number
    FROM boxes
    GROUP BY
        container_id,
        box_number
    HAVING COUNT(*) > 1
) AS repeated_boxes
    ON b.container_id = repeated_boxes.container_id
   AND b.box_number = repeated_boxes.box_number

ORDER BY
    b.container_id,
    b.box_number,
    b.category_group,
    b.category_item;
	
	
	/*
============================================================
DATA QUALITY FINDINGS AND DECISIONS
============================================================

1. The boxes table contains 4,883 records across 7 containers.

2. No exact duplicate records were found.

3. There are 271 repeated container_id and box_number groups,
   covering 550 records.

4. Of the 271 repeated box groups, 270 contain multiple
   category items. Repeated box numbers therefore represent
   multiple inventory items stored in the same physical box
   and must not be removed as duplicates.

5. Container 2025_6, box 258 contains two separate records for
   Pillows with quantities 54 and 6. Both records are retained
   because they are not exact duplicates, but the source should
   be verified if possible.

6. The previously missing quantity for container 2026_1,
   box 188, Western, Women Pants, Used was manually verified
   and recorded as 60.

7. The 77 missing conditions in container 2026_4 were resolved
   using the approved rule: Bedding and Children are New; the
   remaining clothing records are Used. This assigned six New
   records and 71 Used records.

8. The cleaned result contains 2,931 New records and 1,952 Used
   records, with zero missing quantities or conditions.

9. No records were deleted during the data-quality stage.
============================================================
*/
