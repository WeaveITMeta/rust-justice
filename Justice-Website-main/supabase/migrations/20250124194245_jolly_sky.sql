-- Add courts for Apache County, Arizona
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- Apache County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Apache';

  -- St. Johns Courthouse
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Apache County Superior Court',
    '70 West 3rd South',
    'St. Johns',
    '85936',
    '(928) 337-7555',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.apachecountyaz.gov/Superior-Court',
    34.508333, -109.361944,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Michael Latham',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,Navajo,Apache}'
  ) ON CONFLICT DO NOTHING;

  -- Chinle Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Chinle Justice Court',
    'Highway 191 and Route 7',
    'Chinle',
    '86503',
    '(928) 674-5922',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.apachecountyaz.gov/Justice-Courts',
    36.153333, -109.556389,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Victor Clyde',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available at courthouse.',
    true, true, true,
    '{English,Navajo,Apache}'
  ) ON CONFLICT DO NOTHING;

  -- Window Rock District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Window Rock District Court',
    'Navajo Nation Administration Building #1',
    'Window Rock',
    '86515',
    '(928) 871-6962',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.navajocourts.org',
    35.681111, -109.051944,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Geraldine Benally',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Navajo,Apache}'
  ) ON CONFLICT DO NOTHING;

  -- Round Valley Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Round Valley Justice Court',
    '180 North 9th Street',
    'Springerville',
    '85938',
    '(928) 333-4613',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.apachecountyaz.gov/Justice-Courts',
    34.133333, -109.285556,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Butch L. Gunnels',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;