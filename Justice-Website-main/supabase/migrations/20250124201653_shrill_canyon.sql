-- Add courts for Dallas County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Dallas County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Dallas';

  -- Dallas County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Dallas County Circuit Court',
    '206 West 3rd Street',
    'Fordyce',
    '71742',
    '(870) 352-2307',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.dallascountyar.org/circuit-court',
    33.813333, -92.411944,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Hamilton H. Singleton',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Fordyce District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Fordyce District Court',
    '101 North Main Street',
    'Fordyce',
    '71742',
    '(870) 352-2120',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.dallascountyar.org/district-court',
    33.813889, -92.412500,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. G. Wayne Juneau',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in municipal lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Dallas County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Dallas County Juvenile Court',
    '206 West 3rd Street',
    'Fordyce',
    '71742',
    '(870) 352-2307',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.dallascountyar.org/juvenile-court',
    33.813333, -92.411944,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Hamilton H. Singleton',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;