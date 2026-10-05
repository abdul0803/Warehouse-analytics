# Warehouse Inventory Analytics

Excel, SQL, and Power BI analysis of warehouse inventory across seven containers. The project compares physical box counts, category mix, item condition, and estimated inventory value to inform container planning.

## Business question

How do box capacity, inventory condition, category mix, and estimated value differ across containers? Which parts of the observed category mix may be worth adjusting in future loads?

## Workflow and tools

1. **Excel:** prepare and combine the container source data into `data/clean/boxes_clean.csv`.
2. **SQLite and SQL:** create the typed inventory table, apply documented cleaning decisions, run quality checks, map items to valuation references, and create analysis views.
3. **Power BI:** present the results in an interactive report with container, category, condition, and valuation comparisons.

See [`sql/README.md`](sql/README.md) for the SQL run order and database controls.

## Key findings

- The analysis covers **4,883 inventory records** across **7 containers**.
- The records represent **4,604 unique physical boxes** and **143,692 units**.
- The category analysis contains **4,622 box-category assignments**. The 18-assignment difference reflects boxes assigned to more than one category, not additional physical boxes. The identified overlaps are in containers `2025_6` and `2026_4`.
- Observed container loads range from **600 to 727 unique boxes**.
- Container `2026_5` had the highest estimated value per physical box in this dataset: **$399.70 per box** across **618 boxes**, with an estimated total value of **$247,012.66**.
- Bedding accounted for **50.78%** of category-box assignments and averaged **$92.75 per assigned box**. Asian averaged **$768.28** and Western **$219.51** per assigned box. These historical comparisons suggest considering a lower Bedding share and more higher-value categories where supply and destination needs allow.

The category comparison is descriptive, not a guaranteed packing forecast. Some physical boxes appear in multiple categories, and category assignment shares should not be interpreted as exclusive portions of container capacity.

## Data preparation and valuation

- The Excel-prepared source is imported into SQLite as `boxes_text_backup`; the original source table is preserved during analysis.
- A missing quantity for container `2026_1`, box `188` (Western / Women Pants / Used) was manually verified as **60**.
- The 77 missing conditions in container `2026_4` were resolved using the approved rule: Bedding and Children records are New; the remaining clothing records are Used. No inventory records were deleted.
- The valuation reference maps **78 category-item combinations**: 25 Exact, 27 Approximate, and 26 Assumed. All mappings were reviewed and approved. Estimated values use the referenced rates for New and Used items; they are estimates, not realized sale proceeds.
- Final controls: **2,931 New records**, **1,952 Used records**, no missing quantities or conditions, and no unvalued inventory records.

## Repository contents

- `data/clean/boxes_clean.csv` — Excel-prepared source dataset for the SQL pipeline.
- `sql/` — ordered SQL scripts, SQL run guide, and SQLite database.
- `powerbi/warehouse_inventory.pbix` — interactive Power BI report.

## Reproduce the analysis

1. Import `data/clean/boxes_clean.csv` into SQLite as `boxes_text_backup`.
2. Run the SQL files in the order documented in [`sql/README.md`](sql/README.md), then save the database changes.
3. Open the Power BI report and refresh its data source. If needed, update the database path to your local copy.

## Limitations

- Inventory values depend on the documented valuation references and Exact, Approximate, and Assumed mappings.
- Category mix and value comparisons describe the observed containers. They do not prove that changing a future container's mix will produce the same value.
- Boxes with multiple category assignments count once toward physical capacity but appear under each applicable category in category-level analysis.
