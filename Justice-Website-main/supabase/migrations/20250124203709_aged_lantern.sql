-- This migration documents the cleanup of duplicate court entries

-- The following duplicate migrations have been removed:

-- 1. Craighead County, Arkansas courts
-- Removed duplicate from 20250124202230_jolly_wildflower.sql
-- Original entries preserved in 20250124202057_silent_sun.sql

-- 2. Dallas County, Arkansas courts
-- Removed duplicates from:
--   - 20250124201653_shrill_canyon.sql
--   - 20250124203429_copper_beacon.sql
-- Original entries preserved in 20250124203204_odd_sea.sql

-- 3. Chicot County, Arkansas courts
-- Removed duplicates from:
--   - 20250124201218_twilight_flame.sql
--   - 20250124203428_throbbing_art.sql
-- Original entries preserved in 20250124201127_wispy_valley.sql

-- No actual SQL changes needed since duplicates were prevented by ON CONFLICT DO NOTHING
-- This migration serves as documentation of the cleanup