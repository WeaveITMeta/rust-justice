-- Add courts for Maricopa County, Arizona
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- Maricopa County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Maricopa';

  -- Central Court Building
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Central Court Building',
    '201 West Jefferson Street',
    'Phoenix',
    '85003',
    '(602) 506-3204',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://superiorcourt.maricopa.gov',
    33.447778, -112.075833,
    v_county_id,
    '{civil,criminal}'::court_type[],
    'county',
    'Hon. Joseph C. Welty',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in nearby garages and surface lots.',
    true, true, true,
    '{English,Spanish,American Sign Language}'
  ) ON CONFLICT DO NOTHING;

  -- South Court Tower
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'South Court Tower',
    '175 West Madison Street',
    'Phoenix',
    '85003',
    '(602) 506-8575',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://superiorcourt.maricopa.gov',
    33.447222, -112.075278,
    v_county_id,
    '{criminal}'::court_type[],
    'county',
    'Hon. Patricia Ann Starr',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in nearby garages and surface lots.',
    true, true, true,
    '{English,Spanish,American Sign Language}'
  ) ON CONFLICT DO NOTHING;

  -- Family Court Building
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Maricopa County Family Court',
    '201 West Jefferson Street',
    'Phoenix',
    '85003',
    '(602) 506-1561',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://superiorcourt.maricopa.gov/family',
    33.447778, -112.075833,
    v_county_id,
    '{family}'::court_type[],
    'county',
    'Hon. Bruce R. Cohen',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in nearby garages and surface lots.',
    true, true, true,
    '{English,Spanish,American Sign Language}'
  ) ON CONFLICT DO NOTHING;

  -- Southeast Court Complex
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Southeast Court Complex',
    '222 East Javelina Avenue',
    'Mesa',
    '85210',
    '(602) 506-2020',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://superiorcourt.maricopa.gov/southeast',
    33.406944, -111.831667,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Sam J. Myers',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,American Sign Language}'
  ) ON CONFLICT DO NOTHING;

  -- Northwest Court Complex
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Northwest Court Complex',
    '14264 West Tierra Buena Lane',
    'Surprise',
    '85374',
    '(602) 506-3676',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://superiorcourt.maricopa.gov/northwest',
    33.626944, -112.357778,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Pamela S. Gates',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,American Sign Language}'
  ) ON CONFLICT DO NOTHING;

  -- Northeast Court Complex
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Northeast Court Complex',
    '18380 North 40th Street',
    'Phoenix',
    '85032',
    '(602) 506-3676',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://superiorcourt.maricopa.gov/northeast',
    33.652778, -111.998889,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Frank W. Moskowitz',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,American Sign Language}'
  ) ON CONFLICT DO NOTHING;

END $$;