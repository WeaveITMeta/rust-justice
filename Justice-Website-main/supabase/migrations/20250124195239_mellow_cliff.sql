-- Add courts for Santa Cruz County, Arizona
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- Santa Cruz County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Santa Cruz';

  -- Santa Cruz County Superior Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Santa Cruz County Superior Court',
    '2150 North Congress Drive',
    'Nogales',
    '85621',
    '(520) 375-7730',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.santacruzcountyaz.gov/168/Superior-Court',
    31.353889, -110.933889,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Thomas Fink',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Nogales Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Nogales Justice Court',
    '2150 North Congress Drive',
    'Nogales',
    '85621',
    '(520) 375-7762',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.santacruzcountyaz.gov/169/Justice-Courts',
    31.353889, -110.933889,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Emilio G. Velasquez',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Santa Cruz Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Santa Cruz Justice Court',
    '2160 North Congress Drive',
    'Nogales',
    '85621',
    '(520) 375-7760',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.santacruzcountyaz.gov/169/Justice-Courts',
    31.353889, -110.933889,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Keith Barth',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Nogales Municipal Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Nogales Municipal Court',
    '777 North Grand Avenue',
    'Nogales',
    '85621',
    '(520) 287-6571',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.nogalesaz.gov/departments/city-court',
    31.340556, -110.936667,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'municipal',
    'Hon. Mayra Galindo',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in city lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;