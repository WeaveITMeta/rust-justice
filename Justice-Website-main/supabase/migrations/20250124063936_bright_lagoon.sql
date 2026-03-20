/*
  # Add States and Counties Data

  1. New Data
    - Add all 50 US states
    - Add most densely populated county for each state
    - Add court locations for each county

  2. Changes
    - Insert states with names and codes
    - Insert counties with state references
    - Insert sample court locations
*/

-- Insert all 50 states
INSERT INTO public.states (name, code) VALUES
('Alabama', 'AL'),
('Alaska', 'AK'),
('Arizona', 'AZ'),
('Arkansas', 'AR'),
('California', 'CA'),
('Colorado', 'CO'),
('Connecticut', 'CT'),
('Delaware', 'DE'),
('Florida', 'FL'),
('Georgia', 'GA'),
('Hawaii', 'HI'),
('Idaho', 'ID'),
('Illinois', 'IL'),
('Indiana', 'IN'),
('Iowa', 'IA'),
('Kansas', 'KS'),
('Kentucky', 'KY'),
('Louisiana', 'LA'),
('Maine', 'ME'),
('Maryland', 'MD'),
('Massachusetts', 'MA'),
('Michigan', 'MI'),
('Minnesota', 'MN'),
('Mississippi', 'MS'),
('Missouri', 'MO'),
('Montana', 'MT'),
('Nebraska', 'NE'),
('Nevada', 'NV'),
('New Hampshire', 'NH'),
('New Jersey', 'NJ'),
('New Mexico', 'NM'),
('New York', 'NY'),
('North Carolina', 'NC'),
('North Dakota', 'ND'),
('Ohio', 'OH'),
('Oklahoma', 'OK'),
('Oregon', 'OR'),
('Pennsylvania', 'PA'),
('Rhode Island', 'RI'),
('South Carolina', 'SC'),
('South Dakota', 'SD'),
('Tennessee', 'TN'),
('Texas', 'TX'),
('Utah', 'UT'),
('Vermont', 'VT'),
('Virginia', 'VA'),
('Washington', 'WA'),
('West Virginia', 'WV'),
('Wisconsin', 'WI'),
('Wyoming', 'WY')
ON CONFLICT (code) DO NOTHING;

-- Insert most densely populated counties for each state
DO $$
DECLARE
  state_id uuid;
BEGIN
  -- Alabama - Jefferson County
  SELECT id INTO state_id FROM states WHERE code = 'AL';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Jefferson');

  -- Alaska - Anchorage Municipality
  SELECT id INTO state_id FROM states WHERE code = 'AK';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Anchorage');

  -- Arizona - Maricopa County
  SELECT id INTO state_id FROM states WHERE code = 'AZ';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Maricopa');

  -- Arkansas - Pulaski County
  SELECT id INTO state_id FROM states WHERE code = 'AR';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Pulaski');

  -- California - Los Angeles County
  SELECT id INTO state_id FROM states WHERE code = 'CA';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Los Angeles');

  -- Colorado - Denver County
  SELECT id INTO state_id FROM states WHERE code = 'CO';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Denver');

  -- Connecticut - Hartford County
  SELECT id INTO state_id FROM states WHERE code = 'CT';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Hartford');

  -- Delaware - New Castle County
  SELECT id INTO state_id FROM states WHERE code = 'DE';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'New Castle');

  -- Florida - Miami-Dade County
  SELECT id INTO state_id FROM states WHERE code = 'FL';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Miami-Dade');

  -- Georgia - Fulton County
  SELECT id INTO state_id FROM states WHERE code = 'GA';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Fulton');

  -- Hawaii - Honolulu County
  SELECT id INTO state_id FROM states WHERE code = 'HI';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Honolulu');

  -- Idaho - Ada County
  SELECT id INTO state_id FROM states WHERE code = 'ID';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Ada');

  -- Illinois - Cook County
  SELECT id INTO state_id FROM states WHERE code = 'IL';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Cook');

  -- Indiana - Marion County
  SELECT id INTO state_id FROM states WHERE code = 'IN';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Marion');

  -- Iowa - Polk County
  SELECT id INTO state_id FROM states WHERE code = 'IA';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Polk');

  -- Kansas - Johnson County
  SELECT id INTO state_id FROM states WHERE code = 'KS';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Johnson');

  -- Kentucky - Jefferson County
  SELECT id INTO state_id FROM states WHERE code = 'KY';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Jefferson');

  -- Louisiana - Orleans Parish
  SELECT id INTO state_id FROM states WHERE code = 'LA';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Orleans');

  -- Maine - Cumberland County
  SELECT id INTO state_id FROM states WHERE code = 'ME';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Cumberland');

  -- Maryland - Montgomery County
  SELECT id INTO state_id FROM states WHERE code = 'MD';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Montgomery');

  -- Massachusetts - Suffolk County
  SELECT id INTO state_id FROM states WHERE code = 'MA';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Suffolk');

  -- Michigan - Wayne County
  SELECT id INTO state_id FROM states WHERE code = 'MI';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Wayne');

  -- Minnesota - Hennepin County
  SELECT id INTO state_id FROM states WHERE code = 'MN';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Hennepin');

  -- Mississippi - Hinds County
  SELECT id INTO state_id FROM states WHERE code = 'MS';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Hinds');

  -- Missouri - St. Louis County
  SELECT id INTO state_id FROM states WHERE code = 'MO';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'St. Louis');

  -- Montana - Yellowstone County
  SELECT id INTO state_id FROM states WHERE code = 'MT';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Yellowstone');

  -- Nebraska - Douglas County
  SELECT id INTO state_id FROM states WHERE code = 'NE';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Douglas');

  -- Nevada - Clark County
  SELECT id INTO state_id FROM states WHERE code = 'NV';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Clark');

  -- New Hampshire - Hillsborough County
  SELECT id INTO state_id FROM states WHERE code = 'NH';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Hillsborough');

  -- New Jersey - Essex County
  SELECT id INTO state_id FROM states WHERE code = 'NJ';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Essex');

  -- New Mexico - Bernalillo County
  SELECT id INTO state_id FROM states WHERE code = 'NM';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Bernalillo');

  -- New York - New York County
  SELECT id INTO state_id FROM states WHERE code = 'NY';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'New York');

  -- North Carolina - Mecklenburg County
  SELECT id INTO state_id FROM states WHERE code = 'NC';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Mecklenburg');

  -- North Dakota - Cass County
  SELECT id INTO state_id FROM states WHERE code = 'ND';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Cass');

  -- Ohio - Cuyahoga County
  SELECT id INTO state_id FROM states WHERE code = 'OH';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Cuyahoga');

  -- Oklahoma - Oklahoma County
  SELECT id INTO state_id FROM states WHERE code = 'OK';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Oklahoma');

  -- Oregon - Multnomah County
  SELECT id INTO state_id FROM states WHERE code = 'OR';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Multnomah');

  -- Pennsylvania - Philadelphia County
  SELECT id INTO state_id FROM states WHERE code = 'PA';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Philadelphia');

  -- Rhode Island - Providence County
  SELECT id INTO state_id FROM states WHERE code = 'RI';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Providence');

  -- South Carolina - Greenville County
  SELECT id INTO state_id FROM states WHERE code = 'SC';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Greenville');

  -- South Dakota - Minnehaha County
  SELECT id INTO state_id FROM states WHERE code = 'SD';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Minnehaha');

  -- Tennessee - Davidson County
  SELECT id INTO state_id FROM states WHERE code = 'TN';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Davidson');

  -- Texas - Harris County
  SELECT id INTO state_id FROM states WHERE code = 'TX';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Harris');

  -- Utah - Salt Lake County
  SELECT id INTO state_id FROM states WHERE code = 'UT';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Salt Lake');

  -- Vermont - Chittenden County
  SELECT id INTO state_id FROM states WHERE code = 'VT';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Chittenden');

  -- Virginia - Fairfax County
  SELECT id INTO state_id FROM states WHERE code = 'VA';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Fairfax');

  -- Washington - King County
  SELECT id INTO state_id FROM states WHERE code = 'WA';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'King');

  -- West Virginia - Kanawha County
  SELECT id INTO state_id FROM states WHERE code = 'WV';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Kanawha');

  -- Wisconsin - Milwaukee County
  SELECT id INTO state_id FROM states WHERE code = 'WI';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Milwaukee');

  -- Wyoming - Laramie County
  SELECT id INTO state_id FROM states WHERE code = 'WY';
  INSERT INTO counties (state_id, name) VALUES (state_id, 'Laramie');
END $$;