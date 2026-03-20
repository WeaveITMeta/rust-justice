-- Add courts for Alaska counties
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Alaska state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AK';
  
  -- Anchorage Municipality Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Anchorage';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Nesbett Courthouse',
    '825 West 4th Avenue',
    'Anchorage',
    '99501',
    '(907) 264-0514',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/anc',
    61.217778, -149.898333,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. William F. Morse',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in courthouse garage and nearby lots.',
    true, true, true,
    '{English,Spanish,Yupik,Korean,Tagalog,Samoan}'
  ) ON CONFLICT DO NOTHING;

  -- Anchorage Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Anchorage Juvenile Court',
    '3600 Providence Drive',
    'Anchorage',
    '99508',
    '(907) 264-0482',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/anc/juvenile',
    61.188056, -149.818333,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Jennifer K. Wells',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,Yupik,Korean,Tagalog,Samoan}'
  ) ON CONFLICT DO NOTHING;

  -- Bethel Census Area Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Bethel';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Bethel Courthouse',
    '204 Chief Eddie Hoffman Highway',
    'Bethel',
    '99559',
    '(907) 543-2298',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/bethel',
    60.792500, -161.755833,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Nathaniel Peters',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available at courthouse.',
    true, true, true,
    '{English,Yupik,Inupiaq}'
  ) ON CONFLICT DO NOTHING;

  -- Fairbanks North Star Borough Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Fairbanks North Star';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Rabinowitz Courthouse',
    '101 Lacey Street',
    'Fairbanks',
    '99701',
    '(907) 452-9250',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/fbks',
    64.845833, -147.721389,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Michael A. MacDonald',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Inupiaq,Russian,Korean}'
  ) ON CONFLICT DO NOTHING;

END $$;