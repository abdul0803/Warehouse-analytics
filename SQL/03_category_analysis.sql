/*
Project: Warehouse Inventory Analytics
File: 03_category_analysis.sql
Purpose: Analyze category distribution, item concentration,
         condition mix, and differences between containers.
*/


-- ============================================================
-- 1. OVERALL CATEGORY-GROUP DISTRIBUTION
--
-- A physical box can contain multiple categories, so one box
-- may be counted under more than one category group.
-- ============================================================

SELECT
    category_group,

    COUNT(*) AS inventory_rows,

    COUNT(
        DISTINCT container_id || '|' || CAST(box_number AS TEXT)
    ) AS boxes_containing_category,

    SUM(quantity) AS known_quantity,

    SUM(
        CASE
            WHEN quantity IS NULL THEN 1
            ELSE 0
        END
    ) AS unknown_quantity_rows,

    ROUND(
        100.0 * SUM(quantity)
        / (SELECT SUM(quantity) FROM boxes),
        2
    ) AS percentage_of_total_quantity

FROM boxes

GROUP BY category_group

ORDER BY known_quantity DESC;


-- ============================================================
-- 2. OVERALL CATEGORY-ITEM DISTRIBUTION
-- Shows the largest specific inventory items
-- ============================================================

SELECT
    category_group,
    category_item,

    COUNT(*) AS inventory_rows,

    COUNT(
        DISTINCT container_id || '|' || CAST(box_number AS TEXT)
    ) AS boxes_containing_item,

    SUM(quantity) AS known_quantity,

    SUM(
        CASE
            WHEN quantity IS NULL THEN 1
            ELSE 0
        END
    ) AS unknown_quantity_rows,

    ROUND(
        100.0 * SUM(quantity)
        / (SELECT SUM(quantity) FROM boxes),
        2
    ) AS percentage_of_total_quantity

FROM boxes

GROUP BY
    category_group,
    category_item

ORDER BY
    known_quantity DESC,
    category_group,
    category_item;


-- ============================================================
-- 3. CATEGORY-GROUP DISTRIBUTION WITHIN EACH CONTAINER
-- Shows how each container's inventory is divided by category
-- ============================================================

SELECT
    b.container_id,
    b.category_group,

    COUNT(*) AS inventory_rows,

    COUNT(DISTINCT b.box_number) AS boxes_containing_category,

    SUM(b.quantity) AS known_quantity,

    SUM(
        CASE
            WHEN b.quantity IS NULL THEN 1
            ELSE 0
        END
    ) AS unknown_quantity_rows,

    ROUND(
        100.0 * SUM(b.quantity)
        / (
            SELECT SUM(b2.quantity)
            FROM boxes AS b2
            WHERE b2.container_id = b.container_id
        ),
        2
    ) AS percentage_of_container_quantity

FROM boxes AS b

GROUP BY
    b.container_id,
    b.category_group

ORDER BY
    b.container_id,
    known_quantity DESC;


-- ============================================================
-- 4. CONTAINER-LEVEL CATEGORY DRIFT
--
-- Compares each category's share inside a container with that
-- category's share across the entire dataset.
--
-- Positive drift:
-- The category is overrepresented in that container.
--
-- Negative drift:
-- The category is underrepresented in that container.
--
-- CROSS JOIN creates every possible container/category pair,
-- including categories that are absent from a container.
-- ============================================================

WITH containers AS (
    SELECT DISTINCT
        container_id
    FROM boxes
),

categories AS (
    SELECT DISTINCT
        category_group
    FROM boxes
),

container_totals AS (
    SELECT
        container_id,
        SUM(quantity) AS container_quantity
    FROM boxes
    GROUP BY container_id
),

container_category_totals AS (
    SELECT
        container_id,
        category_group,
        SUM(quantity) AS category_quantity
    FROM boxes
    GROUP BY
        container_id,
        category_group
),

overall_category_totals AS (
    SELECT
        category_group,
        SUM(quantity) AS category_quantity
    FROM boxes
    GROUP BY category_group
),

overall_total AS (
    SELECT
        SUM(quantity) AS total_quantity
    FROM boxes
)

SELECT
    c.container_id,
    g.category_group,

    COALESCE(
        cct.category_quantity,
        0
    ) AS container_category_quantity,

    ROUND(
        100.0
        * COALESCE(cct.category_quantity, 0)
        / ct.container_quantity,
        2
    ) AS container_category_percentage,

    ROUND(
        100.0
        * oct.category_quantity
        / ot.total_quantity,
        2
    ) AS overall_category_percentage,

    ROUND(
        (
            100.0
            * COALESCE(cct.category_quantity, 0)
            / ct.container_quantity
        )
        -
        (
            100.0
            * oct.category_quantity
            / ot.total_quantity
        ),
        2
    ) AS percentage_point_drift

FROM containers AS c

CROSS JOIN categories AS g

INNER JOIN container_totals AS ct
    ON c.container_id = ct.container_id

INNER JOIN overall_category_totals AS oct
    ON g.category_group = oct.category_group

CROSS JOIN overall_total AS ot

LEFT JOIN container_category_totals AS cct
    ON c.container_id = cct.container_id
   AND g.category_group = cct.category_group

ORDER BY
    c.container_id,
    percentage_point_drift DESC;


-- ============================================================
-- 5. LEADING CATEGORY IN EACH CONTAINER
--
-- Identifies the category with the largest known quantity
-- and shows how concentrated each container is.
-- ============================================================

WITH container_category_shares AS (
    SELECT
        b.container_id,
        b.category_group,
        SUM(b.quantity) AS category_quantity,

        ROUND(
            100.0 * SUM(b.quantity)
            / (
                SELECT SUM(b2.quantity)
                FROM boxes AS b2
                WHERE b2.container_id = b.container_id
            ),
            2
        ) AS percentage_of_container_quantity

    FROM boxes AS b

    GROUP BY
        b.container_id,
        b.category_group
),

maximum_shares AS (
    SELECT
        container_id,
        MAX(percentage_of_container_quantity) AS maximum_percentage
    FROM container_category_shares
    GROUP BY container_id
)

SELECT
    ccs.container_id,
    ccs.category_group AS leading_category,
    ccs.category_quantity,
    ccs.percentage_of_container_quantity

FROM container_category_shares AS ccs

INNER JOIN maximum_shares AS ms
    ON ccs.container_id = ms.container_id
   AND ccs.percentage_of_container_quantity = ms.maximum_percentage

ORDER BY ccs.container_id;


-- ============================================================
-- 6. CONDITION MIX BY CATEGORY GROUP
--
-- The approved cleanup has resolved all missing quantities and
-- conditions. Unknown columns remain as controls and should equal zero.
-- ============================================================

SELECT
    category_group,

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

    SUM(quantity) AS total_known_quantity,

    ROUND(
        100.0
        * SUM(
            CASE
                WHEN condition = 'New'
                THEN quantity
                ELSE 0
            END
        )
        / SUM(quantity),
        2
    ) AS new_percentage,

    ROUND(
        100.0
        * SUM(
            CASE
                WHEN condition = 'Used'
                THEN quantity
                ELSE 0
            END
        )
        / SUM(quantity),
        2
    ) AS used_percentage,

    ROUND(
        100.0
        * SUM(
            CASE
                WHEN condition IS NULL
                  OR TRIM(condition) = ''
                THEN quantity
                ELSE 0
            END
        )
        / SUM(quantity),
        2
    ) AS unknown_condition_percentage

FROM boxes

GROUP BY category_group

ORDER BY total_known_quantity DESC;

/*
============================================================
CATEGORY ANALYSIS FINDINGS
============================================================

1. Western, Asian, and Bedding account for approximately 80.89%
   of total known inventory quantity.

2. The ten largest category items account for approximately
   60.40% of total inventory, showing substantial
   concentration among a relatively small number of items.

3. Container category mixes differ significantly:
   - 2025_5 is led by Bedding at 41.10%.
   - 2025_6 is led by Western at 42.72%.
   - 2026_1 is nearly balanced between Western at 30.28% and
     Bedding at 30.15%.
   - 2026_2 is led by Western at 30.05%, with Hygiene strongly
     overrepresented.
   - 2026_3 is comparatively balanced between Bedding,
     Western, and Asian.
   - 2026_4 is led by Asian at 50.18%.
   - 2026_5 is led by Western at 56.93%.

4. The largest positive category drift occurs in container
   2026_4, where Asian inventory is 25.04 percentage points
   above the overall dataset share.

5. Container 2026_5 is strongly Western-focused. Western is
   20.40 percentage points above the dataset share, while
   Bedding is 17.40 percentage points below it.

6. Condition mix varies substantially by category:
   - Bedding is 95.92% New.
   - Household is 93.47% New.
   - Hygiene is 99.82% New.
   - Western is 88.77% Used.
   - Asian is 98.98% Used.
   - Shoes are 100% Used in the available data.

7. The approved cleanup resolved all 77 previously missing
   conditions: six records became New and 71 became Used.

8. The manually verified quantity correction added 60 units to
   Western inventory in container 2026_1.

9. The final analytical dataset has no missing quantity or
   condition values.
============================================================
*/
