-- Add courts for Pinal County, Arizona
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- Pinal County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Pinal';

  -- Pinal County Superior Court - Florence
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Pinal County Superior Court',
    '971 North Jason Lopez Circle',
    'Florence',
    '85132',
    '(520) 866-5400',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.pinalcountyaz.gov/Judicial/SuperiorCourt',
    33.037778, -111.387222,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Stephen F. McCarville',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Apache Junction Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Apache Junction Justice Court',
    '575 North Idaho Road Suite 200',
    'Apache Junction',
    '85119',
    '(480) 982-2921',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.pinalcountyaz.gov/Judicial/JusticeCourts',
    33.415833, -111.548889,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Shaun Babeu',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Casa Grande Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Casa Grande Justice Court',
    '820 East Cottonwood Lane',
    'Casa Grande',
    '85122',
    '(520) 836-5471',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.pinalcountyaz.gov/Judicial/JusticeCourts',
    32.879722, -111.743889,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. John Ellsworth',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Eloy Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Eloy Justice Court',
    '628 North Main Street',
    'Eloy',
    '85131',
    '(520) 866-7983',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.pinalcountyaz.gov/Judicial/JusticeCourts',
    32.755556, -111.554722,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Delia Neal',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Florence/Coolidge Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Florence/Coolidge Justice Court',
    '971 Jason Lopez Circle Building B',
    'Florence',
    '85132',
    '(520) 866-7900',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.pinalcountyaz.gov/Judicial/JusticeCourts',
    33.037778, -111.387222,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Anna Feliz',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Maricopa/Stanfield Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Maricopa/Stanfield Justice Court',
    '19955 North Wilson Avenue',
    'Maricopa',
    '85139',
    '(520) 866-3999',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.pinalcountyaz.gov/Judicial/JusticeCourts',
    33.058333, -112.047778,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Lyle Riggs',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;