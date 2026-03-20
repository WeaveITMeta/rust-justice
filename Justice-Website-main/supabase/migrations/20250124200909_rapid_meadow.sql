-- Add courts for Clark County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Clark County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Clark';

  -- Clark County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Clark County Circuit Court',
    '401 Clay Street',
    'Arkadelphia',
    '71923',
    '(870) 246-4701',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.clarkcountyar.gov/circuit-court',
    34.120278, -93.053611,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Blake Batson',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Arkadelphia District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Arkadelphia District Court',
    '700 Clay Street',
    'Arkadelphia',
    '71923',
    '(870) 246-9864',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.clarkcountyar.gov/district-court',
    34.120833, -93.053889,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Randy Hill',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Caddo Valley District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Caddo Valley District Court',
    '100 Valley Street',
    'Caddo Valley',
    '71923',
    '(870) 246-9854',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.clarkcountyar.gov/district-court',
    34.179722, -93.066944,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Randy Hill',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Gurdon District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Gurdon District Court',
    '103 East Main Street',
    'Gurdon',
    '71743',
    '(870) 353-2514',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.clarkcountyar.gov/district-court',
    33.919444, -93.154722,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Randy Hill',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Clark County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Clark County Juvenile Court',
    '401 Clay Street',
    'Arkadelphia',
    '71923',
    '(870) 246-4701',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.clarkcountyar.gov/juvenile-court',
    34.120278, -93.053611,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Blake Batson',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;