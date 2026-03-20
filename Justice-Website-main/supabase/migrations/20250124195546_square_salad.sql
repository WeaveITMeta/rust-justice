-- Add courts for Benton County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Benton County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Benton';

  -- Benton County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Benton County Circuit Court',
    '102 Northeast A Street',
    'Bentonville',
    '72712',
    '(479) 271-1015',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.bentoncountyar.gov/courts/',
    36.372778, -94.208889,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Robin Green',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish,Marshallese}'
  ) ON CONFLICT DO NOTHING;

  -- Bentonville District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Bentonville District Court',
    '203 South Main Street',
    'Bentonville',
    '72712',
    '(479) 271-3121',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.bentonvillear.com/152/District-Court',
    36.372500, -94.209444,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Ray Bunch',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish,Marshallese}'
  ) ON CONFLICT DO NOTHING;

  -- Rogers District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Rogers District Court',
    '1901 South Dixieland Road',
    'Rogers',
    '72758',
    '(479) 621-1134',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.rogersar.gov/269/District-Court',
    36.313333, -94.146944,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Chris Griffin',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,Marshallese}'
  ) ON CONFLICT DO NOTHING;

  -- Siloam Springs District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Siloam Springs District Court',
    '410 North Broadway Street',
    'Siloam Springs',
    '72761',
    '(479) 524-5173',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.siloamsprings.com/156/District-Court',
    36.188333, -94.540278,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Stephen Thomas',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Gentry District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Gentry District Court',
    '100 East Main Street',
    'Gentry',
    '72734',
    '(479) 736-2411',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.gentryar.us/district-court',
    36.268056, -94.484722,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. A.J. Anglin',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;