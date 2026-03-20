-- Add courts for Greenlee County, Arizona
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- Greenlee County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Greenlee';

  -- Greenlee County Superior Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Greenlee County Superior Court',
    '223 5th Street',
    'Clifton',
    '85533',
    '(928) 865-4242',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.greenlee.az.gov/departments/courts',
    33.051389, -109.296111,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Monica L. Stauffer',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Clifton Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Clifton Justice Court',
    '223 5th Street',
    'Clifton',
    '85533',
    '(928) 865-4312',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.greenlee.az.gov/departments/justice-courts',
    33.051389, -109.296111,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Grace Nabor',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Duncan Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Duncan Justice Court',
    '1684 Fairgrounds Road',
    'Duncan',
    '85534',
    '(928) 359-2536',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.greenlee.az.gov/departments/justice-courts',
    32.772222, -109.106944,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Suzanne Menges',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;