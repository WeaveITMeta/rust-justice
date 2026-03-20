-- Add courts for Jefferson County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Jefferson County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Jefferson';

  -- Jefferson County Courthouse
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Jefferson County Courthouse',
    '101 West Barraque Street',
    'Pine Bluff',
    '71601',
    '(870) 541-5322',
    'Monday-Friday 8:30 AM - 5:00 PM',
    'https://www.jeffersoncountyar.gov/county-courts',
    34.228333, -92.003333,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Robert H. Wyatt Jr.',
    'Monday-Friday 8:30 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Pine Bluff District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Pine Bluff District Court',
    '201 East 2nd Avenue',
    'Pine Bluff',
    '71601',
    '(870) 541-5455',
    'Monday-Friday 8:30 AM - 5:00 PM',
    'https://www.cityofpinebluff.com/departments/district-court/',
    34.227778, -92.002778,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. John Kearney',
    'Monday-Friday 8:30 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- White Hall District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'White Hall District Court',
    '8204 Dollarway Road',
    'White Hall',
    '71602',
    '(870) 247-2399',
    'Monday-Friday 8:30 AM - 5:00 PM',
    'https://www.whitehallcourt.org',
    34.273889, -92.088889,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Kim Bridgforth',
    'Monday-Friday 8:30 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Redfield District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Redfield District Court',
    '206 River Road',
    'Redfield',
    '72132',
    '(501) 397-5987',
    'Monday-Friday 8:30 AM - 5:00 PM',
    'https://www.jeffersoncountyar.gov/district-courts',
    34.441667, -92.180556,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Phillip Green',
    'Monday-Friday 8:30 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Jefferson County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Jefferson County Juvenile Court',
    '301 East 2nd Avenue',
    'Pine Bluff',
    '71601',
    '(870) 541-5455',
    'Monday-Friday 8:30 AM - 5:00 PM',
    'https://www.jeffersoncountyar.gov/juvenile-court',
    34.227778, -92.001944,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Earnest E. Brown Jr.',
    'Monday-Friday 8:30 AM - 5:00 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;