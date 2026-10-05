# SQL pipeline

Run these files in order in DB Browser for SQLite:

1. `00_create_typed_boxes.sql` — rebuild the typed `boxes` table from the
   preserved `boxes_text_backup` source.
2. `00_apply_cleaning_decisions.sql` — apply the verified quantity correction
   and the approved treatment of 77 missing conditions.
3. `01_data_quality.sql` — validate rows, nulls, conditions, and duplicates.
4. `02_container_summary.sql` — summarize volume and coverage by container.
5. `03_category_analysis.sql` — analyze category concentration and drift.
6. `04_valuation_reference.sql` — create/update 78 approved valuation rows.
7. `05_item_valuation_mapping.sql` — validate one-to-one warehouse mapping.
8. `06_inventory_valuation.sql` — create final Power BI-ready valuation views.

## Final control totals

- Inventory records: `4,883`
- Containers: `7`
- Total quantity: `143,692`
- New records: `2,931`
- Used records: `1,952`
- Missing quantities: `0`
- Missing conditions: `0`
- Warehouse item combinations: `78`
- Valuation mappings: `78`
- Unvalued inventory records: `0`

## Final database objects

Tables:

- `boxes`
- `boxes_text_backup`
- `valuation_reference`

Views:

- `item_valuation_mapping`
- `vw_inventory_valuation_detail`
- `vw_container_valuation`
- `vw_category_valuation`

DB Browser controls the active transaction. The SQL scripts intentionally do
not use `BEGIN` or `COMMIT`; after successful execution, click **Write Changes**.
