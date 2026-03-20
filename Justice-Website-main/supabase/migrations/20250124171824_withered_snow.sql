-- Add courts for Jefferson County, Alabama
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Alabama state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AL';
  
  -- Jefferson County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Jefferson';

  -- Jefferson County Criminal Justice Center
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Jefferson County Criminal Justice Center',
    '801 Richard Arrington Jr Boulevard North',
    'Birmingham',
    '35203',
    '(205) 325-5300',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://jefferson.alacourt.gov',
    33.518889, -86.811944,
    v_county_id,
    '{criminal}'::court_type[],
    'county',
    'Hon. Teresa T. Pulliam',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in deck and nearby lots.',
    true, true, true,
    '{English,Spanish,American Sign Language}'
  ) ON CONFLICT DO NOTHING;

  -- Jefferson County Civil Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Jefferson County Civil Court',
    '716 Richard Arrington Jr Boulevard North',
    'Birmingham',
    '35203',
    '(205) 325-5355',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://jefferson.alacourt.gov',
    33.518333, -86.812500,
    v_county_id,
    '{civil}'::court_type[],
    'county',
    'Hon. Elisabeth A. French',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in deck and nearby lots.',
    true, true, true,
    '{English,Spanish,American Sign Language}'
  ) ON CONFLICT DO NOTHING;

  -- Jefferson County Family Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Jefferson County Family Court',
    '120 2nd Court North',
    'Birmingham',
    '35204',
    '(205) 325-5538',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://jefferson.alacourt.gov/family',
    33.516667, -86.813889,
    v_county_id,
    '{family,juvenile}'::court_type[],
    'county',
    'Hon. Carnella Greene Norman',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Paid parking available in nearby lots and street parking.',
    true, true, true,
    '{English,Spanish,American Sign Language}'
  ) ON CONFLICT DO NOTHING;

  -- Bessemer Division Courthouse
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Jefferson County Courthouse - Bessemer Division',
    '1801 3rd Avenue North',
    'Bessemer',
    '35020',
    '(205) 497-8500',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://jefferson.alacourt.gov/bessemer',
    33.402778, -86.954167,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. David J. Hobdy',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,American Sign Language}'
  ) ON CONFLICT DO NOTHING;

END $$;