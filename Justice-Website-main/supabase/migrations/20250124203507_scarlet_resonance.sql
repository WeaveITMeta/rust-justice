-- This migration fixes duplicate court entries by removing redundant migrations

-- Remove duplicate Craighead County courts from 20250124202230_jolly_wildflower.sql
-- Original courts are in 20250124202057_silent_sun.sql

-- Remove duplicate Dallas County courts from 20250124201653_shrill_canyon.sql and 20250124203429_copper_beacon.sql
-- Original courts are in 20250124203204_odd_sea.sql

-- Remove duplicate Chicot County courts from 20250124201218_twilight_flame.sql and 20250124203428_throbbing_art.sql
-- Original courts are in 20250124201127_wispy_valley.sql

-- No actual SQL changes needed since the duplicates were prevented by ON CONFLICT DO NOTHING
-- This migration serves as documentation of the cleanup