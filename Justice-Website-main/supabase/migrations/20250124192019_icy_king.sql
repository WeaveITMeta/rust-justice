-- Add courts for additional Alabama counties
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Alabama state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AL';
  
  -- Marengo County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Marengo';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Marengo County Courthouse',
    '101 East Coats Avenue',
    'Linden',
    '36748',
    '(334) 295-2200',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://marengo.alacourt.gov',
    32.306389, -87.798056,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Eddie Hardaway Jr.',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Marion County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Marion';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Marion County Courthouse',
    '132 Military Street South',
    'Hamilton',
    '35570',
    '(205) 921-7451',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://marion.alacourt.gov',
    34.142222, -87.988889,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Lee Carter',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Marshall County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Marshall';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Marshall County Courthouse - Albertville',
    '424 Gunter Avenue',
    'Albertville',
    '35950',
    '(256) 878-0201',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://marshall.alacourt.gov',
    34.267778, -86.208333,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Tim Riley',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Marshall County Courthouse - Guntersville',
    '425 Gunter Avenue',
    'Guntersville',
    '35976',
    '(256) 571-7800',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://marshall.alacourt.gov',
    34.358056, -86.295278,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Chris Abel',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Mobile County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Mobile';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Mobile Government Plaza',
    '205 Government Street',
    'Mobile',
    '36644',
    '(251) 574-8100',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://mobile.alacourt.gov',
    30.686944, -88.045278,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Michael A. Youngpeter',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish,Vietnamese}'
  ) ON CONFLICT DO NOTHING;

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Mobile County Juvenile Court',
    '251 North Bayou Street',
    'Mobile',
    '36603',
    '(251) 574-1450',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://mobile.alacourt.gov/juvenile',
    30.690833, -88.047778,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Edmond G. Naman',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,Vietnamese}'
  ) ON CONFLICT DO NOTHING;

END $$;