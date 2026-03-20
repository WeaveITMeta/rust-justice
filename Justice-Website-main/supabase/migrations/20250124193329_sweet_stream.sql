-- Add courts for additional Alabama counties
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Alabama state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AL';
  
  -- Tallapoosa County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Tallapoosa';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Tallapoosa County Courthouse',
    '125 North Broadnax Street',
    'Dadeville',
    '36853',
    '(256) 825-4266',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://tallapoosa.alacourt.gov',
    32.831111, -85.763889,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Kim Taylor',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Walker County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Walker';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Walker County Courthouse',
    '1803 3rd Avenue',
    'Jasper',
    '35501',
    '(205) 384-7268',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://walker.alacourt.gov',
    33.831944, -87.277778,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Hoyt Elliott',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Washington County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Washington';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Washington County Courthouse',
    '1 Court Street',
    'Chatom',
    '36518',
    '(251) 847-2201',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://washington.alacourt.gov',
    31.465000, -88.254722,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Jerry L. Baxter',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Winston County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Winston';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Winston County Courthouse',
    '25 Court Square',
    'Double Springs',
    '35553',
    '(205) 489-5533',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://winston.alacourt.gov',
    34.146944, -87.402500,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Lee A. Carter',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;