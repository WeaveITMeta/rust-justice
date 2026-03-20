-- Add courts for Mohave County, Arizona
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- Mohave County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Mohave';

  -- Mohave County Superior Court - Kingman
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Mohave County Superior Court - Kingman',
    '401 East Spring Street',
    'Kingman',
    '86401',
    '(928) 753-0713',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.mohavecourts.com',
    35.189722, -114.052778,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Charles W. Gurtler',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Lake Havasu City Superior Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Mohave County Superior Court - Lake Havasu',
    '2001 College Drive',
    'Lake Havasu City',
    '86403',
    '(928) 453-0701',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.mohavecourts.com',
    34.483889, -114.321944,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Rick Lambert',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Bullhead City Superior Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Mohave County Superior Court - Bullhead City',
    '2225 Trane Road',
    'Bullhead City',
    '86442',
    '(928) 758-0730',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.mohavecourts.com',
    35.108889, -114.568333,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Billy Sipe',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Kingman Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Kingman Justice Court',
    '524 West Beale Street',
    'Kingman',
    '86401',
    '(928) 753-0719',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.mohavecourts.com/justice/jcss_home.html',
    35.189167, -114.053889,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. John Taylor',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Lake Havasu City Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Lake Havasu City Justice Court',
    '2001 College Drive',
    'Lake Havasu City',
    '86403',
    '(928) 453-0705',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.mohavecourts.com/justice/jcss_home.html',
    34.483889, -114.321944,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Jill Davis',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Bullhead City Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Bullhead City Justice Court',
    '2225 Trane Road',
    'Bullhead City',
    '86442',
    '(928) 758-0709',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.mohavecourts.com/justice/jcss_home.html',
    35.108889, -114.568333,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Timothy Dickerson',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;