-- Add courts for Vermont and Virginia
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Vermont Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'VT';
  
  -- Chittenden County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Chittenden';

  -- Costello Courthouse
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
    'Costello Courthouse',
    '32 Cherry Street',
    'Burlington',
    '05401',
    '(802) 651-1950',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.vermontjudiciary.org/court-locations/burlington',
    44.476389,
    -73.213889,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Samuel Hoar Jr.',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Metered street parking and nearby garages available.',
    true,
    true,
    true,
    '{English,French,Nepali,Somali}'
  ) ON CONFLICT DO NOTHING;

  -- Virginia Courts
  SELECT id INTO v_state_id FROM states WHERE code = 'VA';
  
  -- Fairfax County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Fairfax';

  -- Fairfax County Courthouse
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
    'Fairfax County Courthouse',
    '4110 Chain Bridge Road',
    'Fairfax',
    '22030',
    '(703) 691-7320',
    'Monday-Friday 8:00 AM - 4:00 PM',
    'https://www.fairfaxcounty.gov/circuit/',
    38.846111,
    -77.306389,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Penney S. Azcarate',
    'Monday-Friday 8:00 AM - 4:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in courthouse garage.',
    true,
    true,
    true,
    '{English,Spanish,Korean,Vietnamese,Arabic}'
  ) ON CONFLICT DO NOTHING;

  -- Fairfax County Juvenile and Domestic Relations Court
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
    'Fairfax County Juvenile and Domestic Relations Court',
    '4110 Chain Bridge Road',
    'Fairfax',
    '22030',
    '(703) 246-3367',
    'Monday-Friday 8:00 AM - 4:00 PM',
    'https://www.fairfaxcounty.gov/juveniledomesticrelations/',
    38.846111,
    -77.306389,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Todd G. Petit',
    'Monday-Friday 8:00 AM - 4:00 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Paid parking available in courthouse garage.',
    true,
    true,
    true,
    '{English,Spanish,Korean,Vietnamese,Arabic}'
  ) ON CONFLICT DO NOTHING;

  -- Get Arlington County ID
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Arlington';

  -- Arlington County Courthouse
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
    'Arlington County Courthouse',
    '1425 North Courthouse Road',
    'Arlington',
    '22201',
    '(703) 228-7010',
    'Monday-Friday 8:00 AM - 4:00 PM',
    'https://courts.arlingtonva.us',
    38.889722,
    -77.086944,
    v_county_id,
    '{civil,criminal,family,traffic}'::court_type[],
    'county',
    'Hon. William T. Newman Jr.',
    'Monday-Friday 8:00 AM - 4:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in courthouse garage and nearby lots.',
    true,
    true,
    true,
    '{English,Spanish,Amharic,Arabic}'
  ) ON CONFLICT DO NOTHING;

END $$;