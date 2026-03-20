-- Add courts for Cochise County, Arizona
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- Cochise County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Cochise';

  -- Bisbee Courthouse
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Cochise County Superior Court',
    '100 Quality Hill Road',
    'Bisbee',
    '85603',
    '(520) 432-8600',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.cochise.az.gov/241/Superior-Court',
    31.448333, -109.928056,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Laura Cardinal',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Sierra Vista Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Sierra Vista Justice Court',
    '100 Colonia De Salud',
    'Sierra Vista',
    '85635',
    '(520) 803-3800',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.cochise.az.gov/242/Justice-Courts',
    31.554722, -110.276389,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Kenneth Curfman',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Douglas Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Douglas Justice Court',
    '661 G Avenue',
    'Douglas',
    '85607',
    '(520) 805-5640',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.cochise.az.gov/242/Justice-Courts',
    31.344722, -109.545833,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Roger Contreras',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Willcox Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Willcox Justice Court',
    '450 S. Haskell Avenue',
    'Willcox',
    '85643',
    '(520) 384-7000',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.cochise.az.gov/242/Justice-Courts',
    32.252778, -109.831944,
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

  -- Benson Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Benson Justice Court',
    '126 W 5th Street',
    'Benson',
    '85602',
    '(520) 586-8100',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.cochise.az.gov/242/Justice-Courts',
    31.967778, -110.294444,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. John Kelliher',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;