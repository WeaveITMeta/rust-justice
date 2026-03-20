-- Add courts for Crawford County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Crawford County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Crawford';

  -- Crawford County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Crawford County Circuit Court',
    '300 Main Street',
    'Van Buren',
    '72956',
    '(479) 474-1421',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.crawfordcountyar.org/circuit-court',
    35.436944, -94.348333,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Gary R. Cottrell',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish,Vietnamese}'
  ) ON CONFLICT DO NOTHING;

  -- Van Buren District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Van Buren District Court',
    '1003 Broadway',
    'Van Buren',
    '72956',
    '(479) 474-5067',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.crawfordcountyar.org/district-court',
    35.436667, -94.348611,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Steven Peer',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish,Vietnamese}'
  ) ON CONFLICT DO NOTHING;

  -- Alma District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Alma District Court',
    '804 Fayetteville Avenue',
    'Alma',
    '72921',
    '(479) 632-2361',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.crawfordcountyar.org/district-court',
    35.478889, -94.221944,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Steven Peer',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Mulberry District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Mulberry District Court',
    '203 North Main Street',
    'Mulberry',
    '72947',
    '(479) 997-1321',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.crawfordcountyar.org/district-court',
    35.500833, -94.051389,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Steven Peer',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Crawford County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Crawford County Juvenile Court',
    '300 Main Street',
    'Van Buren',
    '72956',
    '(479) 474-1421',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.crawfordcountyar.org/juvenile-court',
    35.436944, -94.348333,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Gary R. Cottrell',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,Vietnamese}'
  ) ON CONFLICT DO NOTHING;

END $$;