-- Add courts for Coconino County, Arizona
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- Coconino County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Coconino';

  -- Flagstaff Courthouse
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Coconino County Superior Court',
    '200 North San Francisco Street',
    'Flagstaff',
    '86001',
    '(928) 679-7600',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.coconino.az.gov/167/Superior-Court',
    35.198333, -111.648889,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Dan Slayton',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish,Navajo,Hopi}'
  ) ON CONFLICT DO NOTHING;

  -- Flagstaff Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Flagstaff Justice Court',
    '200 North San Francisco Street',
    'Flagstaff',
    '86001',
    '(928) 679-7650',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.coconino.az.gov/169/Justice-Courts',
    35.198333, -111.648889,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Howard Grodman',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish,Navajo,Hopi}'
  ) ON CONFLICT DO NOTHING;

  -- Page Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Page Justice Court',
    '547 Vista Avenue',
    'Page',
    '86040',
    '(928) 645-8871',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.coconino.az.gov/169/Justice-Courts',
    36.914722, -111.456389,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Donald G. Roberts',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,Navajo}'
  ) ON CONFLICT DO NOTHING;

  -- Williams Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Williams Justice Court',
    '700 West Railroad Avenue',
    'Williams',
    '86046',
    '(928) 635-2691',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.coconino.az.gov/169/Justice-Courts',
    35.249722, -112.190833,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Robert Krombeen',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Fredonia Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Fredonia Justice Court',
    '112 North Main Street',
    'Fredonia',
    '86022',
    '(928) 643-7472',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.coconino.az.gov/169/Justice-Courts',
    36.947222, -112.527778,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Serena Cutchen',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;