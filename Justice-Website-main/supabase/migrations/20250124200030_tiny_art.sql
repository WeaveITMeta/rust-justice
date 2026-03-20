-- Add courts for Washington County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Washington County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Washington';

  -- Washington County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Washington County Circuit Court',
    '280 North College Avenue',
    'Fayetteville',
    '72701',
    '(479) 444-1500',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.washingtoncountyar.gov/government/circuit-court',
    36.065833, -94.158889,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Mark Lindsay',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish,Marshallese}'
  ) ON CONFLICT DO NOTHING;

  -- Fayetteville District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Fayetteville District Court',
    '176 South Church Avenue',
    'Fayetteville',
    '72701',
    '(479) 575-8040',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.fayetteville-ar.gov/447/District-Court',
    36.062500, -94.159722,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. William Storey',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish,Marshallese}'
  ) ON CONFLICT DO NOTHING;

  -- Springdale District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Springdale District Court',
    '201 Spring Street',
    'Springdale',
    '72764',
    '(479) 750-8134',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.springdalear.gov/156/District-Court',
    36.186389, -94.128889,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Jeff Harper',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,Marshallese}'
  ) ON CONFLICT DO NOTHING;

  -- Prairie Grove District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Prairie Grove District Court',
    '119 East Buchanan Street',
    'Prairie Grove',
    '72753',
    '(479) 846-3694',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.washingtoncountyar.gov/government/district-courts',
    35.975833, -94.318889,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Graham Nations',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Elm Springs District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Elm Springs District Court',
    '1411 East Lake Road',
    'Elm Springs',
    '72728',
    '(479) 248-7100',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.washingtoncountyar.gov/government/district-courts',
    36.206389, -94.228889,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Casey Jones',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Washington County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Washington County Juvenile Court',
    '280 North College Avenue',
    'Fayetteville',
    '72701',
    '(479) 444-1710',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.washingtoncountyar.gov/government/juvenile-court',
    36.065833, -94.158889,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Stacey Zimmerman',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish,Marshallese}'
  ) ON CONFLICT DO NOTHING;

END $$;