-- Add courts for additional Alabama counties
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Alabama state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AL';
  
  -- Macon County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Macon';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Macon County Courthouse',
    '101 East Northside Street',
    'Tuskegee',
    '36083',
    '(334) 724-2614',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://macon.alacourt.gov',
    32.430278, -85.681389,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Steven T. Marshall',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Madison County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Madison';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Madison County Courthouse',
    '100 North Side Square',
    'Huntsville',
    '35801',
    '(256) 532-3300',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://madison.alacourt.gov',
    34.731944, -86.584722,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Ruth Ann Hall',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish,American Sign Language}'
  ) ON CONFLICT DO NOTHING;

  -- Madison County Courthouse Annex
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Madison County Courthouse Annex',
    '603 Madison Street',
    'Huntsville',
    '35801',
    '(256) 532-3482',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://madison.alacourt.gov',
    34.730833, -86.583611,
    v_county_id,
    '{family,juvenile}'::court_type[],
    'county',
    'Hon. Allison S. Austin',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish,American Sign Language}'
  ) ON CONFLICT DO NOTHING;

  -- Marengo County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Marengo';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Marengo County Courthouse',
    '101 East Coats Avenue',
    'Linden',
    '36748',
    '(334) 295-2200',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://marengo.alacourt.gov',
    32.306389, -87.798056,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Eddie Hardaway Jr.',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;