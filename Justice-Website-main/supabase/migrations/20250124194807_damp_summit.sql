-- Add courts for Graham County, Arizona
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- Graham County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Graham';

  -- Graham County Superior Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Graham County Superior Court',
    '800 West Main Street',
    'Safford',
    '85546',
    '(928) 428-3100',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.graham.az.gov/147/Superior-Court',
    32.833889, -109.707778,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Michael D. Peterson',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,Apache}'
  ) ON CONFLICT DO NOTHING;

  -- Safford Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Safford Justice Court',
    '800 West Main Street',
    'Safford',
    '85546',
    '(928) 428-1210',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.graham.az.gov/148/Justice-Courts',
    32.833889, -109.707778,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Gary W. Griffith',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Pima Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Pima Justice Court',
    '136 West Center Street',
    'Pima',
    '85543',
    '(928) 485-2771',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.graham.az.gov/148/Justice-Courts',
    32.893333, -109.831667,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Wyatt Palmer',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- San Carlos Apache Tribal Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'San Carlos Apache Tribal Court',
    'Tribal Court Building, San Carlos Avenue',
    'San Carlos',
    '85550',
    '(928) 475-2342',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.scat-nsn.gov/court.html',
    33.353333, -110.453333,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'federal',
    'Hon. Lawrence King',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. Special protocols for tribal court. Photo ID required.',
    'Free parking available at courthouse.',
    true, true, true,
    '{English,Apache,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;