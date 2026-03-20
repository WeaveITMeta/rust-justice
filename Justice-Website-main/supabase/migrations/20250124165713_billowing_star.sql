-- Add sample courts for additional counties
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Miami-Dade County Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'FL';
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Miami-Dade';

  -- Richard E. Gerstein Justice Building
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
    'Richard E. Gerstein Justice Building',
    '1351 NW 12th Street',
    'Miami',
    '33125',
    '(305) 275-1155',
    'Monday-Friday 9:00 AM - 4:00 PM',
    'https://www.jud11.flcourts.org',
    25.786447,
    -80.216825,
    v_county_id,
    '{criminal}'::court_type[],
    'county',
    'Hon. Nushin G. Sayfie',
    'Monday-Friday 9:00 AM - 4:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in courthouse garage.',
    true,
    true,
    true,
    '{English,Spanish,Haitian Creole}'
  ) ON CONFLICT DO NOTHING;

  -- Lawson E. Thomas Courthouse Center
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
    'Lawson E. Thomas Courthouse Center',
    '175 NW 1st Avenue',
    'Miami',
    '33128',
    '(305) 349-7777',
    'Monday-Friday 9:00 AM - 4:00 PM',
    'https://www.jud11.flcourts.org',
    25.776169,
    -80.195461,
    v_county_id,
    '{civil,family}'::court_type[],
    'county',
    'Hon. Scott M. Bernstein',
    'Monday-Friday 9:00 AM - 4:00 PM',
    'Security screening required. No weapons allowed.',
    'Public parking available at nearby lots and garages.',
    true,
    true,
    true,
    '{English,Spanish,Haitian Creole}'
  ) ON CONFLICT DO NOTHING;

  -- New York County Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'NY';
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'New York';

  -- New York County Supreme Court
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
    'New York County Supreme Court',
    '60 Centre Street',
    'New York',
    '10007',
    '(646) 386-3600',
    'Monday-Friday 9:00 AM - 5:00 PM',
    'https://www.nycourts.gov/courts/1jd/supctmanh/',
    40.714550,
    -74.002050,
    v_county_id,
    '{civil,criminal}'::court_type[],
    'county',
    'Hon. Deborah A. Kaplan',
    'Monday-Friday 9:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Limited street parking. Public transportation recommended.',
    true,
    true,
    true,
    '{English,Spanish,Mandarin,Cantonese,Russian}'
  ) ON CONFLICT DO NOTHING;

  -- New York County Criminal Court
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
    'New York County Criminal Court',
    '100 Centre Street',
    'New York',
    '10013',
    '(646) 386-4500',
    'Monday-Friday 9:00 AM - 5:00 PM',
    'https://www.nycourts.gov/courts/nyc/criminal/manhattan.shtml',
    40.716397,
    -74.001884,
    v_county_id,
    '{criminal}'::court_type[],
    'county',
    'Hon. Ellen M. Biben',
    'Monday-Friday 9:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Limited street parking. Public transportation recommended.',
    true,
    true,
    true,
    '{English,Spanish,Mandarin,Cantonese,Russian}'
  ) ON CONFLICT DO NOTHING;

  -- King County Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'WA';
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'King';

  -- King County Courthouse
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
    'King County Courthouse',
    '516 Third Avenue',
    'Seattle',
    '98104',
    '(206) 296-9100',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'https://kingcounty.gov/courts/superior-court.aspx',
    47.603229,
    -122.330933,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. James E. Rogers',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in nearby garages and lots.',
    true,
    true,
    true,
    '{English,Spanish,Vietnamese,Korean,Russian,Chinese}'
  ) ON CONFLICT DO NOTHING;

  -- Maleng Regional Justice Center
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
    'Maleng Regional Justice Center',
    '401 4th Avenue North',
    'Kent',
    '98032',
    '(206) 205-9200',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'https://kingcounty.gov/courts/superior-court/mrjc.aspx',
    47.383228,
    -122.233526,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Patrick Oishi',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true,
    true,
    true,
    '{English,Spanish,Vietnamese,Korean,Russian,Chinese}'
  ) ON CONFLICT DO NOTHING;

END $$;