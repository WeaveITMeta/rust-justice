-- Add courts for Autauga County, Alabama
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Alabama state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AL';
  
  -- Get Autauga County ID
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Autauga';

  -- Autauga County Courthouse
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
    'Autauga County Courthouse',
    '134 North Court Street',
    'Prattville',
    '36067',
    '(334) 358-6800',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'https://autauga.alacourt.gov',
    32.464722,
    -86.474167,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Joy P. Booth',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and surrounding streets.',
    true,
    true,
    true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Autauga County District Court
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
    'Autauga County District Court',
    '134 North Court Street',
    'Prattville',
    '36067',
    '(334) 358-6900',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'https://autauga.alacourt.gov/district',
    32.464722,
    -86.474167,
    v_county_id,
    '{criminal,traffic}'::court_type[],
    'county',
    'Hon. Patrick D. Pinkston',
    'Monday-Friday 8:30 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and surrounding streets.',
    true,
    true,
    true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;