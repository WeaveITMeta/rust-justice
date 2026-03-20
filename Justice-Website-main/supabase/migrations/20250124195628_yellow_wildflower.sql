-- Add courts for Craighead County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Craighead County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Craighead';

  -- Craighead County Courthouse - Jonesboro
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Craighead County Courthouse - Jonesboro',
    '511 South Main Street',
    'Jonesboro',
    '72401',
    '(870) 933-4530',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.craigheadcounty.org/departments/courts/',
    35.838333, -90.704167,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Pamela Honeycutt',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Craighead County Courthouse - Lake City
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Craighead County Courthouse - Lake City',
    '107 Cobean Boulevard',
    'Lake City',
    '72437',
    '(870) 237-4444',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.craigheadcounty.org/departments/courts/',
    35.816667, -90.434167,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. David Boling',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Jonesboro District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Jonesboro District Court',
    '410 West Washington Avenue',
    'Jonesboro',
    '72401',
    '(870) 933-4551',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.jonesboro.org/191/District-Court',
    35.842500, -90.704722,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Tommy Fowler',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Lake City District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Lake City District Court',
    '107 Cobean Boulevard',
    'Lake City',
    '72437',
    '(870) 237-4444',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.craigheadcounty.org/departments/courts/',
    35.816667, -90.434167,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Shannon Prince',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Craighead County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Craighead County Juvenile Court',
    '511 South Main Street',
    'Jonesboro',
    '72401',
    '(870) 933-4544',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.craigheadcounty.org/departments/courts/juvenile-division/',
    35.838333, -90.704167,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Barbara Halsey',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;