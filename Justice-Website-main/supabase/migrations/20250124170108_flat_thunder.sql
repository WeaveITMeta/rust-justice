-- Add courts for Washington and West Virginia
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Washington Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'WA';
  
  -- Pierce County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Pierce';

  -- County-City Building
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
    'County-City Building',
    '930 Tacoma Avenue South',
    'Tacoma',
    '98402',
    '(253) 798-7455',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'https://www.piercecountywa.gov/122/Superior-Court',
    47.252778,
    -122.441944,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Elizabeth P. Martin',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in nearby garages and street parking.',
    true,
    true,
    true,
    '{English,Spanish,Korean,Vietnamese,Russian}'
  ) ON CONFLICT DO NOTHING;

  -- Remann Hall Juvenile Court
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
    'Remann Hall Juvenile Court',
    '5501 6th Avenue',
    'Tacoma',
    '98406',
    '(253) 798-7900',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'https://www.piercecountywa.gov/123/Juvenile-Court',
    47.255833,
    -122.507778,
    v_county_id,
    '{juvenile}'::court_type[],
    'county',
    'Hon. Judy Jasprica',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true,
    true,
    true,
    '{English,Spanish,Korean,Vietnamese,Russian}'
  ) ON CONFLICT DO NOTHING;

  -- West Virginia Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'WV';
  
  -- Kanawha County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Kanawha';

  -- Kanawha County Judicial Building
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
    'Kanawha County Judicial Building',
    '111 Court Street',
    'Charleston',
    '25301',
    '(304) 357-0111',
    'Monday-Friday 8:00 AM - 4:00 PM',
    'https://kanawha.us/circuit-clerk/',
    38.349722,
    -81.632778,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Joanna I. Tabit',
    'Monday-Friday 8:00 AM - 4:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Metered street parking and nearby garages available.',
    true,
    true,
    true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Kanawha County Juvenile Court
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
    'Kanawha County Juvenile Court',
    '900 Pennsylvania Avenue',
    'Charleston',
    '25302',
    '(304) 357-0570',
    'Monday-Friday 8:00 AM - 4:00 PM',
    'https://kanawha.us/juvenile-court/',
    38.353056,
    -81.628889,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Kenneth D. Ballard',
    'Monday-Friday 8:00 AM - 4:00 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true,
    true,
    true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;