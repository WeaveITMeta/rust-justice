-- Add courts for White County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- White County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'White';

  -- White County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'White County Circuit Court',
    '301 West Arch Avenue',
    'Searcy',
    '72143',
    '(501) 279-6233',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.whitecountyar.org/circuit-court',
    35.249722, -91.736389,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Robert Edwards',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Searcy District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Searcy District Court',
    '400 West Vine Avenue',
    'Searcy',
    '72143',
    '(501) 279-1000',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.cityofsearcy.org/district-court',
    35.250000, -91.738889,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Mark Pate',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Beebe District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Beebe District Court',
    '321 North Main Street',
    'Beebe',
    '72012',
    '(501) 882-8110',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.whitecountyar.org/district-courts',
    35.070833, -91.898333,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Teresa Hughes',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Bald Knob District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Bald Knob District Court',
    '3713 Highway 367 North',
    'Bald Knob',
    '72010',
    '(501) 724-5116',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.whitecountyar.org/district-courts',
    35.310833, -91.566944,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Mark Derrick',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- White County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'White County Juvenile Court',
    '301 West Arch Avenue',
    'Searcy',
    '72143',
    '(501) 279-6233',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.whitecountyar.org/juvenile-court',
    35.249722, -91.736389,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Chris Carnahan',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;