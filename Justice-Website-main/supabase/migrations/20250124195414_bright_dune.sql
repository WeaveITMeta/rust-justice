-- Add courts for Yuma County, Arizona
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- Yuma County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Yuma';

  -- Yuma County Superior Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Yuma County Superior Court',
    '250 West 2nd Street',
    'Yuma',
    '85364',
    '(928) 817-4100',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.yumacountyaz.gov/government/courts/superior-court',
    32.725278, -114.623056,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. David M. Haws',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Yuma Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Yuma Justice Court',
    '250 West 2nd Street',
    'Yuma',
    '85364',
    '(928) 817-4100',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.yumacountyaz.gov/government/courts/justice-courts',
    32.725278, -114.623056,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Juan M. Guerrero',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Wellton Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Wellton Justice Court',
    '10260 Dome Street',
    'Wellton',
    '85356',
    '(928) 785-3321',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.yumacountyaz.gov/government/courts/justice-courts',
    32.673889, -114.143889,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Gregory L. Stewart',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Somerton Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Somerton Justice Court',
    '240 West State Avenue',
    'Somerton',
    '85350',
    '(928) 627-8152',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.yumacountyaz.gov/government/courts/justice-courts',
    32.593889, -114.706944,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. James Coil',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- San Luis Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'San Luis Justice Court',
    '1298 Avenue G',
    'San Luis',
    '85349',
    '(928) 627-8152',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.yumacountyaz.gov/government/courts/justice-courts',
    32.486944, -114.782222,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Maria Elena Galindo',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;