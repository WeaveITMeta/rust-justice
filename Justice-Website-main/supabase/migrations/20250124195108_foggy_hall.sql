-- Add courts for Navajo County, Arizona
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- Navajo County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Navajo';

  -- Navajo County Superior Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Navajo County Superior Court',
    '100 East Carter Drive',
    'Holbrook',
    '86025',
    '(928) 524-4188',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.navajocountyaz.gov/Departments/Superior-Court',
    34.902778, -110.156944,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Dale P. Nielson',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,Navajo,Hopi}'
  ) ON CONFLICT DO NOTHING;

  -- Holbrook Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Holbrook Justice Court',
    '100 East Carter Drive',
    'Holbrook',
    '86025',
    '(928) 524-4720',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.navajocountyaz.gov/Departments/Justice-Courts',
    34.902778, -110.156944,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. David Widmaier',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,Navajo}'
  ) ON CONFLICT DO NOTHING;

  -- Snowflake Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Snowflake Justice Court',
    '145 South Main Street',
    'Snowflake',
    '85937',
    '(928) 536-4141',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.navajocountyaz.gov/Departments/Justice-Courts',
    34.513333, -110.078333,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Fred Peterson',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Show Low Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Show Low Justice Court',
    '550 North 9th Place',
    'Show Low',
    '85901',
    '(928) 532-6030',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.navajocountyaz.gov/Departments/Justice-Courts',
    34.254722, -110.036944,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Stephen Price',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Kayenta Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Kayenta Justice Court',
    'Highway 163 & Lake Powell Boulevard',
    'Kayenta',
    '86033',
    '(928) 697-3522',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.navajocountyaz.gov/Departments/Justice-Courts',
    36.727778, -110.254722,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Susie Nelson',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available at courthouse.',
    true, true, true,
    '{English,Navajo}'
  ) ON CONFLICT DO NOTHING;

  -- Pinetop-Lakeside Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Pinetop-Lakeside Justice Court',
    '1630 South White Mountain Road',
    'Show Low',
    '85901',
    '(928) 532-6030',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.navajocountyaz.gov/Departments/Justice-Courts',
    34.254722, -110.036944,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. David Widmaier',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;