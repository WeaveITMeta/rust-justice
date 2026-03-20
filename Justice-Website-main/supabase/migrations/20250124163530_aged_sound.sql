-- Add sample courts for additional counties
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Los Angeles County Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'CA';
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Los Angeles';

  -- Stanley Mosk Courthouse
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
    'Stanley Mosk Courthouse',
    '111 North Hill Street',
    'Los Angeles',
    '90012',
    '(213) 830-0800',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'https://www.lacourt.org',
    34.053665,
    -118.246541,
    v_county_id,
    '{civil}'::court_type[],
    'county',
    'Hon. Eric C. Taylor',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in courthouse parking structure and nearby lots.',
    true,
    true,
    true,
    '{English,Spanish,Korean,Mandarin,Vietnamese,Armenian}'
  ) ON CONFLICT DO NOTHING;

  -- Clara Shortridge Foltz Criminal Justice Center
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
    'Clara Shortridge Foltz Criminal Justice Center',
    '210 West Temple Street',
    'Los Angeles',
    '90012',
    '(213) 628-7900',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'https://www.lacourt.org',
    34.055374,
    -118.246161,
    v_county_id,
    '{criminal}'::court_type[],
    'county',
    'Hon. Sam Ohta',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Public parking available at nearby lots and structures.',
    true,
    true,
    true,
    '{English,Spanish,Korean,Mandarin,Vietnamese,Armenian}'
  ) ON CONFLICT DO NOTHING;

  -- Edmund D. Edelman Children's Court
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
    'Edmund D. Edelman Children''s Court',
    '201 Centre Plaza Drive',
    'Monterey Park',
    '91754',
    '(323) 307-8000',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'https://www.lacourt.org',
    34.062832,
    -118.123735,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Victor H. Greenberg',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'Security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true,
    true,
    true,
    '{English,Spanish,Korean,Mandarin,Vietnamese,Armenian}'
  ) ON CONFLICT DO NOTHING;

  -- Get Cook County (Chicago) ID
  SELECT id INTO v_state_id FROM states WHERE code = 'IL';
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Cook';

  -- Richard J. Daley Center
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
    'Richard J. Daley Center',
    '50 West Washington Street',
    'Chicago',
    '60602',
    '(312) 603-5030',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'http://www.cookcountycourt.org',
    41.883994,
    -87.630173,
    v_county_id,
    '{civil,probate,family}'::court_type[],
    'county',
    'Hon. Timothy C. Evans',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in nearby garages and lots.',
    true,
    true,
    true,
    '{English,Spanish,Polish}'
  ) ON CONFLICT DO NOTHING;

  -- Leighton Criminal Court Building
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
    'George N. Leighton Criminal Court Building',
    '2650 South California Avenue',
    'Chicago',
    '60608',
    '(773) 674-3100',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'http://www.cookcountycourt.org',
    41.844324,
    -87.693403,
    v_county_id,
    '{criminal}'::court_type[],
    'county',
    'Hon. LeRoy K. Martin Jr.',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot.',
    true,
    true,
    true,
    '{English,Spanish,Polish}'
  ) ON CONFLICT DO NOTHING;

  -- Get Harris County (Houston) ID
  SELECT id INTO v_state_id FROM states WHERE code = 'TX';
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Harris';

  -- Harris County Civil Courthouse
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
    'Harris County Civil Courthouse',
    '201 Caroline Street',
    'Houston',
    '77002',
    '(832) 927-1100',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.harriscountytx.gov/Courts',
    29.760277,
    -95.368057,
    v_county_id,
    '{civil,family,probate}'::court_type[],
    'county',
    'Hon. Linda Hidalgo',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed.',
    'Paid parking available in nearby garages and surface lots.',
    true,
    true,
    true,
    '{English,Spanish,Vietnamese}'
  ) ON CONFLICT DO NOTHING;

  -- Harris County Criminal Justice Center
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
    'Harris County Criminal Justice Center',
    '1201 Franklin Street',
    'Houston',
    '77002',
    '(713) 755-6000',
    'Monday-Friday 7:00 AM - 6:00 PM',
    'https://www.harriscountytx.gov/Courts',
    29.761774,
    -95.363392,
    v_county_id,
    '{criminal}'::court_type[],
    'county',
    'Hon. Lina Hidalgo',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in nearby garages and surface lots.',
    true,
    true,
    true,
    '{English,Spanish,Vietnamese}'
  ) ON CONFLICT DO NOTHING;
END $$;