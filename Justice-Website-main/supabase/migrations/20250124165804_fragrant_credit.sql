-- Add courts for Rhode Island and South Carolina
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Rhode Island Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'RI';
  
  -- Providence County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Providence';

  -- Licht Judicial Complex
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
    'Licht Judicial Complex',
    '250 Benefit Street',
    'Providence',
    '02903',
    '(401) 222-3250',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'https://www.courts.ri.gov',
    41.826389,
    -71.408333,
    v_county_id,
    '{civil,criminal}'::court_type[],
    'county',
    'Hon. Alice B. Gibney',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Metered street parking and nearby parking garages available.',
    true,
    true,
    true,
    '{English,Spanish,Portuguese}'
  ) ON CONFLICT DO NOTHING;

  -- Garrahy Judicial Complex
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
    'Garrahy Judicial Complex',
    '1 Dorrance Plaza',
    'Providence',
    '02903',
    '(401) 458-5300',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'https://www.courts.ri.gov',
    41.823611,
    -71.413333,
    v_county_id,
    '{family,juvenile}'::court_type[],
    'county',
    'Hon. Michael B. Forte',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed.',
    'Public parking garage adjacent to courthouse.',
    true,
    true,
    true,
    '{English,Spanish,Portuguese}'
  ) ON CONFLICT DO NOTHING;

  -- South Carolina Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'SC';
  
  -- Greenville County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Greenville';

  -- Greenville County Courthouse
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
    'Greenville County Courthouse',
    '305 East North Street',
    'Greenville',
    '29601',
    '(864) 467-8551',
    'Monday-Friday 8:30 AM - 5:00 PM',
    'https://www.greenvillecounty.org/courts',
    34.852778,
    -82.398889,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Letitia H. Verdin',
    'Monday-Friday 8:30 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'County parking garage available with validated parking.',
    true,
    true,
    true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Greenville County Family Court
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
    'Greenville County Family Court',
    '301 University Ridge',
    'Greenville',
    '29601',
    '(864) 467-5800',
    'Monday-Friday 8:30 AM - 5:00 PM',
    'https://www.greenvillecounty.org/familycourt',
    34.851389,
    -82.397778,
    v_county_id,
    '{family,juvenile}'::court_type[],
    'county',
    'Hon. Alex Kinlaw Jr.',
    'Monday-Friday 8:30 AM - 5:00 PM',
    'Security screening required. No weapons allowed.',
    'Free parking available in county lots.',
    true,
    true,
    true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;