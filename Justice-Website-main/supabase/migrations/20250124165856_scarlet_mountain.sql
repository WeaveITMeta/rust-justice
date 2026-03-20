-- Add courts for South Dakota and Tennessee
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- South Dakota Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'SD';
  
  -- Minnehaha County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Minnehaha';

  -- Minnehaha County Courthouse
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
    'Minnehaha County Courthouse',
    '425 North Dakota Avenue',
    'Sioux Falls',
    '57104',
    '(605) 367-5900',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.minnehahacounty.org/dept/ci/cc/cc.php',
    43.549722,
    -96.731111,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Robin J. Houwman',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true,
    true,
    true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Tennessee Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'TN';
  
  -- Davidson County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Davidson';

  -- Justice A.A. Birch Building
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
    'Justice A.A. Birch Building',
    '408 2nd Avenue North',
    'Nashville',
    '37201',
    '(615) 862-5601',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://circuitclerk.nashville.gov',
    36.166389,
    -86.778333,
    v_county_id,
    '{criminal}'::court_type[],
    'county',
    'Hon. Monte Watkins',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in nearby garages and lots.',
    true,
    true,
    true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Historic Davidson County Courthouse
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
    'Historic Davidson County Courthouse',
    '1 Public Square',
    'Nashville',
    '37201',
    '(615) 862-5181',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://circuitclerk.nashville.gov',
    36.166111,
    -86.781667,
    v_county_id,
    '{civil,probate}'::court_type[],
    'county',
    'Hon. Philip E. Smith',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in nearby garages and street parking.',
    true,
    true,
    true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Juvenile Justice Center
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
    'Juvenile Justice Center',
    '100 Woodland Street',
    'Nashville',
    '37213',
    '(615) 862-7980',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://juvenilecourt.nashville.gov',
    36.173056,
    -86.775833,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Sheila Calloway',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true,
    true,
    true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;