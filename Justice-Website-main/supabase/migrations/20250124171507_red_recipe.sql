-- Add courts for additional Alabama counties
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Alabama state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AL';
  
  -- Hale County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Hale';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Hale County Courthouse',
    '1001 Main Street',
    'Greensboro',
    '36744',
    '(334) 624-4334',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://hale.alacourt.gov',
    32.704722, -87.595833,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Arthur L. Crawford Sr.',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Henry County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Henry';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Henry County Courthouse',
    '101 Court Square',
    'Abbeville',
    '36310',
    '(334) 585-3133',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://henry.alacourt.gov',
    31.571944, -85.250833,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Derek Peterson',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Houston County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Houston';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Houston County Courthouse',
    '462 North Oates Street',
    'Dothan',
    '36303',
    '(334) 677-4700',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://houston.alacourt.gov',
    31.224167, -85.393611,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Todd Derrick',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and nearby deck.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Jackson County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Jackson';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Jackson County Courthouse',
    '102 East Laurel Street',
    'Scottsboro',
    '35768',
    '(256) 574-9300',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://jackson.alacourt.gov',
    34.672500, -86.034444,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. John H. Graham',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;