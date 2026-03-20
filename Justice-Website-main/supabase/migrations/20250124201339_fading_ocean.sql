-- Add courts for Columbia County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Columbia County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Columbia';

  -- Columbia County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Columbia County Circuit Court',
    '1 Court Square',
    'Magnolia',
    '71753',
    '(870) 235-3700',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.columbiacountyar.gov/circuit-court',
    33.266667, -93.239722,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. David W. Talley Jr.',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Magnolia District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Magnolia District Court',
    '201 North Jackson Street',
    'Magnolia',
    '71753',
    '(870) 234-2424',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.columbiacountyar.gov/district-court',
    33.267500, -93.241667,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Phillip Cater',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Waldo District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Waldo District Court',
    '125 East Main Street',
    'Waldo',
    '71770',
    '(870) 693-5502',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.columbiacountyar.gov/district-court',
    33.351667, -93.295833,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Phillip Cater',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Taylor District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Taylor District Court',
    '106 South Vine Street',
    'Taylor',
    '71861',
    '(870) 694-4100',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.columbiacountyar.gov/district-court',
    33.099722, -93.469722,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Phillip Cater',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Columbia County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Columbia County Juvenile Court',
    '1 Court Square',
    'Magnolia',
    '71753',
    '(870) 235-3700',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.columbiacountyar.gov/juvenile-court',
    33.266667, -93.239722,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. David W. Talley Jr.',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;