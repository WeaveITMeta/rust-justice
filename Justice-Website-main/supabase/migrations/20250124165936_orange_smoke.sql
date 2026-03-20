-- Add courts for Texas and Utah
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Texas Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'TX';
  
  -- Travis County Courts (Austin)
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Travis';

  -- Heman Marion Sweatt Travis County Courthouse
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
    'Heman Marion Sweatt Travis County Courthouse',
    '1000 Guadalupe Street',
    'Austin',
    '78701',
    '(512) 854-9300',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.traviscountytx.gov/courts',
    30.271389,
    -97.745000,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Andy Brown',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in nearby garages and surface lots.',
    true,
    true,
    true,
    '{English,Spanish,Vietnamese}'
  ) ON CONFLICT DO NOTHING;

  -- Gardner Betts Juvenile Justice Center
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
    'Gardner Betts Juvenile Justice Center',
    '2515 South Congress Avenue',
    'Austin',
    '78704',
    '(512) 854-7000',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.traviscountytx.gov/courts/juvenile',
    30.238333,
    -97.750833,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Aurora Martinez Jones',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true,
    true,
    true,
    '{English,Spanish,Vietnamese}'
  ) ON CONFLICT DO NOTHING;

  -- Utah Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'UT';
  
  -- Salt Lake County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Salt Lake';

  -- Matheson Courthouse
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
    'Matheson Courthouse',
    '450 South State Street',
    'Salt Lake City',
    '84111',
    '(801) 238-7300',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.utcourts.gov/courts/dist/distict3',
    40.758333,
    -111.888333,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Keith A. Kelly',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in courthouse garage and nearby lots.',
    true,
    true,
    true,
    '{English,Spanish,Arabic,Vietnamese}'
  ) ON CONFLICT DO NOTHING;

  -- West Jordan Courthouse
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
    'West Jordan Courthouse',
    '8080 South Redwood Road',
    'West Jordan',
    '84088',
    '(801) 233-9700',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.utcourts.gov/courts/dist/distict3',
    40.598889,
    -111.939167,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. William K. Kendall',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true,
    true,
    true,
    '{English,Spanish,Arabic}'
  ) ON CONFLICT DO NOTHING;

  -- Sandy Courthouse
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
    'Sandy District Courthouse',
    '210 West 10000 South',
    'Sandy',
    '84070',
    '(801) 238-7300',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.utcourts.gov/courts/dist/distict3',
    40.578889,
    -111.890556,
    v_county_id,
    '{civil,criminal,traffic}'::court_type[],
    'county',
    'Hon. Douglas Hogan',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed.',
    'Free parking available in courthouse lot.',
    true,
    true,
    true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;