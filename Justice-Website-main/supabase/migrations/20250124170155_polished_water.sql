-- Add courts for Wisconsin and Wyoming
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Wisconsin Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'WI';
  
  -- Milwaukee County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Milwaukee';

  -- Milwaukee County Courthouse
  INSERT INTO court_locations (
    name,
    address,
    city,
    zip_code,
    phone,
    hours,
    website,
    latitude,
    longitude,
    county_id,
    court_type,
    jurisdiction,
    presiding_judge,
    filing_office_hours,
    security_info,
    parking_info,
    electronic_filing,
    virtual_hearings,
    ada_accessibility,
    languages_supported
  ) VALUES (
    'Milwaukee County Courthouse',
    '901 North 9th Street',
    'Milwaukee',
    '53233',
    '(414) 278-4444',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://county.milwaukee.gov/EN/Courts',
    43.040833,
    -87.922500,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Mary E. Triggiano',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in courthouse garage and nearby lots.',
    true,
    true,
    true,
    '{English,Spanish,Hmong}'
  ) ON CONFLICT DO NOTHING;

  -- Vel R. Phillips Juvenile Justice Center
  INSERT INTO court_locations (
    name,
    address,
    city,
    zip_code,
    phone,
    hours,
    website,
    latitude,
    longitude,
    county_id,
    court_type,
    jurisdiction,
    presiding_judge,
    filing_office_hours,
    security_info,
    parking_info,
    electronic_filing,
    virtual_hearings,
    ada_accessibility,
    languages_supported
  ) VALUES (
    'Vel R. Phillips Juvenile Justice Center',
    '10201 West Watertown Plank Road',
    'Wauwatosa',
    '53226',
    '(414) 257-7700',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://county.milwaukee.gov/EN/Courts/Children-s-Court',
    43.044722,
    -88.052778,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Laura Crivello',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true,
    true,
    true,
    '{English,Spanish,Hmong}'
  ) ON CONFLICT DO NOTHING;

  -- Wyoming Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'WY';
  
  -- Laramie County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Laramie';

  -- Laramie County Courthouse
  INSERT INTO court_locations (
    name,
    address,
    city,
    zip_code,
    phone,
    hours,
    website,
    latitude,
    longitude,
    county_id,
    court_type,
    jurisdiction,
    presiding_judge,
    filing_office_hours,
    security_info,
    parking_info,
    electronic_filing,
    virtual_hearings,
    ada_accessibility,
    languages_supported
  ) VALUES (
    'Laramie County Courthouse',
    '309 West 20th Street',
    'Cheyenne',
    '82001',
    '(307) 633-4270',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.laramiecounty.com/departments/district_court',
    41.128889,
    -104.820000,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Catherine R. Rogers',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true,
    true,
    true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Laramie County Juvenile Services Center
  INSERT INTO court_locations (
    name,
    address,
    city,
    zip_code,
    phone,
    hours,
    website,
    latitude,
    longitude,
    county_id,
    court_type,
    jurisdiction,
    presiding_judge,
    filing_office_hours,
    security_info,
    parking_info,
    electronic_filing,
    virtual_hearings,
    ada_accessibility,
    languages_supported
  ) VALUES (
    'Laramie County Juvenile Services Center',
    '1977 Pioneer Avenue',
    'Cheyenne',
    '82001',
    '(307) 633-4390',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.laramiecounty.com/departments/juvenile_services',
    41.122778,
    -104.813333,
    v_county_id,
    '{juvenile}'::court_type[],
    'county',
    'Hon. Steven K. Sharpe',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in facility lot.',
    true,
    true,
    true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;