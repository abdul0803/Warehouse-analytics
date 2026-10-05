/*
Project: Warehouse Inventory Analytics
File: 04_valuation_reference.sql
Purpose:
  1. Store the approved valuation mapping for every warehouse item.
  2. Preserve source evidence, mapping quality, and review decisions.
  3. Supply the source table used by files 05 and 06.

Valuation policy:
  - Used inventory uses used_unit_value.
  - New inventory uses new_unit_value.
  - Unsupported conditions or missing quantities remain unvalued controls.
  - Used disposable hygiene items have an approved value of $0.
  - Exact, Approximate, and Assumed mappings stay labeled for transparency.

Source workbook:
  data/reference/warehouse_valuation_reference.xlsx
*/

CREATE TABLE IF NOT EXISTS valuation_reference (
    category_group TEXT NOT NULL,
    category_item TEXT NOT NULL,
    used_unit_value REAL NOT NULL CHECK (used_unit_value >= 0),
    new_unit_value REAL NOT NULL CHECK (new_unit_value >= 0),
    mapping_status TEXT NOT NULL
        CHECK (mapping_status IN ('Exact', 'Approximate', 'Assumed')),
    source_tab TEXT NOT NULL,
    source_section TEXT,
    source_item TEXT NOT NULL,
    mapping_notes TEXT,
    review_decision TEXT NOT NULL
        CHECK (review_decision = 'Approved'),
    source_url TEXT,
    source_note TEXT,
    PRIMARY KEY (category_group, category_item)
);

INSERT INTO valuation_reference (
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
)
VALUES ('Accessories', 'Backpacks', 5, 16, 'Approximate', 'Household', 'Miscellaneous Item Donation', 'Luggage', 'Backpacks use the closest Salvation Army Luggage rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Accessories', 'Belts', 2, 6, 'Assumed', 'External estimate', 'Clothing accessories', 'Belt', 'Conservative externally sourced donation estimate.', 'Approved', 'https://deductibee.com/valuation-guide/clothing', 'Conservative rounded range informed by published donation-guide ranges.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Accessories', 'Gloves', 2, 4, 'Assumed', 'External estimate', 'Clothing accessories', 'Gloves', 'Goodwill-based used value with a conservative new-value assumption.', 'Approved', 'https://www.goodwillde.org/wp-content/uploads/2022/12/Donation-valuation-guide_12.2022.pdf', 'Goodwill lists gloves/hats/socks at $1.99; the new estimate is a conservative assumption.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Accessories', 'Hats', 1, 8, 'Approximate', 'Clothes', 'Women''s', 'Hat', 'General hats mapped to the women''s Hat rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Accessories', 'Mats', 2, 12, 'Approximate', 'Household', 'Household Goods Donation', 'Throw Rug', 'Mats use the closest available small-rug rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Accessories', 'Mittens', 2, 4, 'Assumed', 'External estimate', 'Clothing accessories', 'Mittens', 'Uses gloves as the closest comparable accessory.', 'Approved', 'https://www.goodwillde.org/wp-content/uploads/2022/12/Donation-valuation-guide_12.2022.pdf', 'Uses the published gloves baseline as the closest comparable item.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Accessories', 'Purses', 2, 21, 'Approximate', 'Clothes', 'Women''s', 'Handbag', 'Purses use the Handbag rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Accessories', 'Rugs', 2, 12, 'Approximate', 'Household', 'Household Goods Donation', 'Throw Rug', 'Rugs use the Throw Rug rate; size is unavailable.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Accessories', 'Scarves', 4, 9.69, 'Approximate', 'HHRD Valuations', 'Pakistani Clothing', 'Shawls', 'Scarves use the HHRD Shawls rate.', 'Approved', '', 'HHRD valuation rate.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Accessories', 'Ties', 2, 6, 'Assumed', 'External estimate', 'Clothing accessories', 'Tie', 'Goodwill-based used value with a conservative new-value assumption.', 'Approved', 'https://www.goodwillde.org/wp-content/uploads/2022/12/Donation-valuation-guide_12.2022.pdf', 'Goodwill lists ties/belts at $1.99; the new estimate is a conservative assumption.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Accessories', 'Winter Mufflers', 4, 9.69, 'Approximate', 'HHRD Valuations', 'Pakistani Clothing', 'Shawls', 'Winter mufflers use the closest HHRD Shawls rate.', 'Approved', '', 'HHRD valuation rate.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Accessories', 'Women Hats', 1, 8, 'Exact', 'Clothes', 'Women''s', 'Hat', 'Women''s hat rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Asian', 'Boys Set', 30, 52.98, 'Approximate', 'HHRD Valuations', 'Pakistani Clothing', 'Men shalwar kameez', 'User directed Boys Set to the shalwar kameez rate.', 'Approved', '', 'HHRD valuation rate.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Asian', 'Men Pants', 5, 12, 'Approximate', 'Clothes', 'Men''s', 'Slacks', 'Asian men''s pants use the Salvation Army men''s Slacks rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Asian', 'Men Set', 30, 52.98, 'Approximate', 'HHRD Valuations', 'Pakistani Clothing', 'Men shalwar kameez', 'Men Set mapped to the closest HHRD two-piece outfit.', 'Approved', '', 'HHRD valuation rate.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Asian', 'Men Shirts', 3, 12, 'Approximate', 'Clothes', 'Men''s', 'Shirt', 'Asian men''s shirts use the Salvation Army men''s Shirt rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Asian', 'Men Thobe', 32.89, 59.99, 'Exact', 'HHRD Valuations', 'Pakistani Clothing', 'Thobe', 'Direct terminology match.', 'Approved', '', 'HHRD valuation rate.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Asian', 'Women 2Pc Set', 32, 41.02, 'Exact', 'HHRD Valuations', 'Pakistani Clothing', 'Womens 2 piece shalwar kameez', 'Direct terminology match.', 'Approved', '', 'HHRD valuation rate.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Asian', 'Women 3Pc Set', 45, 58.8, 'Exact', 'HHRD Valuations', 'Pakistani Clothing', 'Womens 3 piece shalwar kameez', 'Direct terminology match.', 'Approved', '', 'HHRD valuation rate.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Asian', 'Women Abayas', 38.16, 54.9, 'Exact', 'HHRD Valuations', 'Pakistani Clothing', 'Abaya', 'Direct terminology match.', 'Approved', '', 'HHRD valuation rate.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Asian', 'Women Bridal', 75, 191, 'Exact', 'HHRD Valuations', 'Pakistani Clothing', 'Women wedding suit', 'Bridal inventory mapped to the HHRD wedding-suit rate.', 'Approved', '', 'HHRD valuation rate.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Asian', 'Women Pants', 4, 12, 'Approximate', 'Clothes', 'Women''s', 'Slacks', 'Asian women''s pants use the Salvation Army women''s Slacks rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Asian', 'Women Scarves', 8.99, 17, 'Approximate', 'HHRD Valuations', 'Pakistani Clothing', 'Hijab', 'Scarves may include non-hijab items.', 'Approved', '', 'HHRD valuation rate.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Asian', 'Women Shirts', 3, 12, 'Approximate', 'Clothes', 'Women''s', 'Blouse', 'Asian women''s shirts use the Salvation Army women''s Blouse rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Bedding', '3Pc Bed Set', 6, 19, 'Assumed', 'Derived estimate', 'Bedding', '3Pc Bed Set', 'One sheet, one bed skirt, and one pillowcase.', 'Approved', 'https://www.walmart.com/ip/916863799', 'Assumes one sheet, one bed skirt, and one pillowcase. Combines Salvation Army component rates with discounted Lux Decor pricing.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Bedding', '4Pc Bed Set', 7, 22, 'Assumed', 'Derived estimate', 'Bedding', '4Pc Bed Set', 'Three-piece estimate plus one pillowcase.', 'Approved', 'https://www.luxdecorcollection.com/', 'Three-piece estimate plus one additional pillowcase.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Bedding', '6Pc Bed Set', 9, 28, 'Assumed', 'Derived estimate', 'Bedding', '6Pc Bed Set', 'Four-piece estimate plus two pillowcases.', 'Approved', 'https://www.luxdecorcollection.com/collections/all', 'Four-piece estimate plus two additional pillowcases.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Bedding', 'Bed Set', 6, 19, 'Assumed', 'Derived estimate', 'Bedding', 'Bed Set', 'Unspecified sets use the conservative three-piece estimate.', 'Approved', 'https://www.luxdecorcollection.com/', 'Unspecified bed sets use the conservative three-piece estimate.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Bedding', 'Bed Sheets', 2, 8, 'Exact', 'Household', 'Household Goods Donation', 'Sheets', 'Direct terminology match.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Bedding', 'Blankets/Comforters', 3, 16, 'Approximate', 'Household', 'Household Goods Donation', 'Blanket', 'Combined category mapped to Blanket; comforters may differ.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Bedding', 'Comforter Set', 11.25, 27, 'Assumed', 'Derived estimate', 'Bedding', '5Pc Comforter Set', 'Assumed five-piece Lux Decor comforter set with donation discounts.', 'Approved', 'https://www.luxdecorcollection.com/', 'Based on a $44.99 Lux Decor five-piece set; used is 25% and new donation value is 60% of retail.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Bedding', 'Curtains', 2, 12, 'Exact', 'Household', 'Household Goods Donation', 'Curtains', 'Direct terminology match.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Bedding', 'Mattress Pad Covers', 7.5, 18, 'Assumed', 'Derived estimate', 'Bedding', 'Mattress Pad Cover', 'Lux Decor retail reference reduced to donation values.', 'Approved', 'https://www.luxdecorcollection.com/collections/all', 'Based on a $29.99 Lux Decor mattress pad; used is 25% and new donation value is 60% of retail.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Bedding', 'Pillowcase', 1, 3, 'Assumed', 'Derived estimate', 'Bedding', 'Pillowcase', 'Per-piece Lux Decor estimate reduced to donation values.', 'Approved', 'https://www.luxdecorcollection.com/', 'Conservative per-piece value derived from Lux Decor sheet-set pricing and donation discounts.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Bedding', 'Pillows', 2, 8, 'Exact', 'Household', 'Household Goods Donation', 'Pillow', 'Singular/plural terminology match.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Bedding', 'Seat Cushions', 2, 8, 'Approximate', 'Household', 'Household Goods Donation', 'Pillow', 'User directed seat cushions to the Salvation Army Pillow rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Bedding', 'Towels', 0.5, 4, 'Exact', 'Household', 'Household Goods Donation', 'Towel', 'Singular/plural terminology match.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Children', 'Babies Under 3', 3, 12, 'Assumed', 'Derived estimate', 'Children', 'Mixed infant clothing item', 'Mixed category uses a conservative children''s clothing range.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Uses a conservative range within Salvation Army children''s clothing values because the item mix is unknown.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Children', 'Baby Crib', 26, 104, 'Approximate', 'Household', 'Furniture Donation', 'Crib (w/mattress)', 'Source rate includes a mattress; warehouse record does not specify one.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Children', 'Baby Jackets', 3, 26, 'Exact', 'Clothes', 'Children''s', 'Jacket', 'Children''s jacket rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Household', 'Hangers', 0.2, 0.4, 'Assumed', 'Derived estimate', 'Household', 'Hanger', 'Lux Decor 30-pack converted to conservative per-hanger donation values.', 'Approved', 'https://www.walmart.com/browse/0?facet=brand%3ALux+Decor+Collection', 'Based on a Lux Decor 30-pack at $19.99; reduced to conservative per-hanger donation values.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Hygiene', 'Adult Diapers', 0, 0.33, 'Assumed', 'Retail-derived estimate', 'Hygiene', 'Adult Diaper', 'New per-unit estimate; used disposable value is $0.', 'Approved', 'https://www.target.com/c/incontinence-pads-health/up-up/-/N-4so0rZq643lepiiob', 'New per-unit estimate. Used disposable hygiene products are assigned $0 because they have no reusable donation value.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Hygiene', 'Baby Diapers', 0, 0.33, 'Assumed', 'Retail-derived estimate', 'Hygiene', 'Baby Diaper', 'New per-unit estimate; used disposable value is $0.', 'Approved', 'https://www.target.com/c/-/N-62foxZq643lepiiob', 'New per-unit estimate. Used disposable hygiene products are assigned $0 because they have no reusable donation value.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Hygiene', 'Diaper Pants (Kids)', 0, 0.48, 'Assumed', 'Retail-derived estimate', 'Hygiene', 'Diaper Pants', 'New per-unit estimate; used disposable value is $0.', 'Approved', 'https://www.target.com/c/-/N-62foxZq643lepiiob', 'New per-unit training-pant estimate. Used disposable hygiene products are assigned $0.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Hygiene', 'Diapers', 0, 0.33, 'Assumed', 'Retail-derived estimate', 'Hygiene', 'Generic Diaper', 'New per-unit estimate; used disposable value is $0.', 'Approved', 'https://www.target.com/c/-/N-62foxZq643lepiiob', 'New per-unit estimate. Used disposable hygiene products are assigned $0.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Hygiene', 'Underpads', 0, 0.5, 'Assumed', 'Retail-derived estimate', 'Hygiene', 'Underpad', 'New per-unit estimate; used disposable value is $0.', 'Approved', 'https://www.target.com/c/incontinence-pads-health/up-up/-/N-4so0rZq643lepiiob', 'Conservative new per-unit estimate. Used disposable underpads are assigned $0.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Hygiene', 'Women Liner', 0, 0.15, 'Assumed', 'Retail-derived estimate', 'Hygiene', 'Women Liner', 'New per-unit estimate; used disposable value is $0.', 'Approved', 'https://www.target.com/c/incontinence-pads-health/incontinence-liners/-/N-4so0rZxtz5s', 'New per-unit estimate based on current liner pack prices. Used disposable liners are assigned $0.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('School Supplies', 'School Supplies', 5, 5, 'Assumed', 'User assumption', 'School Supplies', 'School Supplies', 'User-directed flat $5 value.', 'Approved', '', 'User-directed flat value.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Shoes', 'Men', 4, 26, 'Exact', 'Clothes', 'Men''s', 'Shoes', 'Men''s shoes rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Shoes', 'Women', 2, 26, 'Exact', 'Clothes', 'Women''s', 'Shoes', 'Women''s shoes rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Toys', 'Baby Toys', 2, 6, 'Assumed', 'User assumption', 'Toys', 'Generic Toy', 'User-directed toy value.', 'Approved', '', 'User-directed value for all otherwise-unmapped toy categories, including vests.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Toys', 'Battery', 2, 6, 'Assumed', 'User assumption', 'Toys', 'Generic Toy', 'User-directed toy value.', 'Approved', '', 'User-directed value for all otherwise-unmapped toy categories, including vests.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Toys', 'Bicycles', 5, 83, 'Exact', 'Household', 'Miscellaneous Item Donation', 'Bicycle', 'Singular/plural terminology match.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Toys', 'No Battery', 2, 6, 'Assumed', 'User assumption', 'Toys', 'Generic Toy', 'User-directed toy value.', 'Approved', '', 'User-directed value for all otherwise-unmapped toy categories, including vests.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Toys', 'Toys', 2, 6, 'Assumed', 'User assumption', 'Toys', 'Generic Toy', 'User-directed toy value.', 'Approved', '', 'User-directed value for all otherwise-unmapped toy categories, including vests.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Toys', 'Vests', 2, 6, 'Assumed', 'User assumption', 'Toys', 'Generic Toy', 'User directed vests to the toy assumption.', 'Approved', '', 'User-directed value for all otherwise-unmapped toy categories, including vests.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('UnderClothing', 'Bra', 1, 3, 'Exact', 'Clothes', 'Women''s', 'Bra', 'Direct terminology match.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('UnderClothing', 'Kids Underwear (Boys)', 1, 4, 'Approximate', 'Clothes', 'Children''s', 'Underwear', 'Uses the Salvation Army children''s Underwear rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('UnderClothing', 'Socks', 0.5, 1, 'Approximate', 'Clothes', 'Women''s', 'Socks', 'Warehouse data does not specify adult or child socks.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('UnderClothing', 'Tops', 3, 12, 'Approximate', 'Clothes', 'Women''s', 'Blouse', 'Unspecified tops use the closest women''s Blouse rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('UnderClothing', 'Undershirts', 1, 3, 'Exact', 'Clothes', 'Men''s', 'Undershirt', 'Singular/plural terminology match.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('UnderClothing', 'Underwear', 1, 4, 'Approximate', 'Clothes', 'Children''s', 'Underwear', 'Warehouse data does not specify age or gender.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Men 2Pc Suit Set', 16, 62, 'Approximate', 'Clothes', 'Men''s', 'Suit', 'Two-piece set mapped to the men''s Suit rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Men 2Pc Track Suit', 8, 24, 'Assumed', 'Derived estimate', 'Western', 'Men 2Pc Track Suit', 'User-directed sum of one men''s shirt and one pair of pants.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Sum of Salvation Army men''s Shirt ($3/$12) and Slacks ($5/$12).')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Men And Boys Shirts', 3, 12, 'Approximate', 'Clothes', 'Men''s', 'Shirt', 'Combined men/boys category uses the men''s Shirt rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Men And Boys Shoes', 4, 26, 'Approximate', 'Clothes', 'Men''s', 'Shoes', 'Combined men/boys category uses the men''s Shoes rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Men Jackets', 8, 26, 'Exact', 'Clothes', 'Men''s', 'Jacket', 'Men''s jacket rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Men Pants', 5, 12, 'Approximate', 'Clothes', 'Men''s', 'Slacks', 'Pants mapped to the closest available men''s Slacks rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Men Shirts', 3, 12, 'Exact', 'Clothes', 'Men''s', 'Shirt', 'Men''s shirt rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Men Shoes', 4, 26, 'Exact', 'Clothes', 'Men''s', 'Shoes', 'Men''s shoes rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Men Sweaters', 3, 12, 'Exact', 'Clothes', 'Men''s', 'Sweater', 'Men''s sweater rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Women Coats', 10, 41, 'Exact', 'Clothes', 'Women''s', 'Coat', 'Women''s coat rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Women Dresses', 4, 20, 'Exact', 'Clothes', 'Women''s', 'Dress', 'Women''s dress rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Women Jackets', 4, 12, 'Exact', 'Clothes', 'Women''s', 'Jacket', 'Women''s jacket rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Women Pants', 4, 12, 'Approximate', 'Clothes', 'Women''s', 'Slacks', 'Pants mapped to the closest available women''s Slacks rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Women Shirts', 3, 12, 'Approximate', 'Clothes', 'Women''s', 'Blouse', 'Shirts mapped to the closest available women''s Blouse rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Women Shoes', 2, 26, 'Exact', 'Clothes', 'Women''s', 'Shoes', 'Women''s shoes rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

INSERT INTO valuation_reference (
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
)
VALUES ('Western', 'Women Sweaters', 4, 16, 'Exact', 'Clothes', 'Women''s', 'Sweater', 'Women''s sweater rate.', 'Approved', 'https://satruck.org/Home/DonationValueGuide', 'Template labels these columns Low/Old and High/New.')
ON CONFLICT(category_group, category_item) DO UPDATE SET
    used_unit_value = excluded.used_unit_value,
    new_unit_value = excluded.new_unit_value,
    mapping_status = excluded.mapping_status,
    source_tab = excluded.source_tab,
    source_section = excluded.source_section,
    source_item = excluded.source_item,
    mapping_notes = excluded.mapping_notes,
    review_decision = excluded.review_decision,
    source_url = excluded.source_url,
    source_note = excluded.source_note;

/*
============================================================
CONTROL QUERIES
Run these after the script. Expected results:
  valuation_reference rows: 78
  warehouse item combinations: 78
  unmapped item combinations: 0
  duplicate mapping keys: no rows
============================================================
*/

SELECT COUNT(*) AS valuation_reference_rows
FROM valuation_reference;

SELECT COUNT(*) AS warehouse_item_combinations
FROM (
    SELECT category_group, category_item
    FROM boxes
    GROUP BY category_group, category_item
);

SELECT
    b.category_group,
    b.category_item
FROM (
    SELECT category_group, category_item
    FROM boxes
    GROUP BY category_group, category_item
) AS b
LEFT JOIN valuation_reference AS vr
    ON b.category_group = vr.category_group
   AND b.category_item = vr.category_item
WHERE vr.category_item IS NULL;

SELECT
    category_group,
    category_item,
    COUNT(*) AS mapping_rows
FROM valuation_reference
GROUP BY category_group, category_item
HAVING COUNT(*) > 1;
