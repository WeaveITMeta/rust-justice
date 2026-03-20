-- Add courts for additional Alabama counties
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Alabama state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AL';
  
  -- St. Clair County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'St. Clair';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'St. Clair County Courthouse - Ashville',
    '1815 Cogswell Avenue',
    'Ashville',
    '35953',
    '(205) 594-2120',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://stclair.alacourt.gov',
    33.840278, -86.265833,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Phillip Seay',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'St. Clair County Courthouse - Pell City',
    '1702 Cogswell Avenue',
    'Pell City',
    '35125',
    '(205) 338-9463',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://stclair.alacourt.gov',
    33.586389, -86.286111,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Bill Weathington',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Talladega County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Talladega';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Talladega County Courthouse',
    '1 Court Square',
    'Talladega',
    '35160',
    '(256) 362-4175',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://talladega.alacourt.gov',
    33.435833, -86.106389,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Chad E. Woodruff',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Talladega County Courthouse - Sylacauga',
    '1 West First Street',
    'Sylacauga',
    '35150',
    '(256) 249-1150',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://talladega.alacourt.gov',
    33.172778, -86.251389,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Julian M. King',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;