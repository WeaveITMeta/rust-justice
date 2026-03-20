-- Add courts for additional Alabama counties
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Alabama state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AL';
  
  -- Monroe County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Monroe';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Monroe County Courthouse',
    '65 North Alabama Avenue',
    'Monroeville',
    '36460',
    '(251) 743-4107',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://monroe.alacourt.gov',
    31.526389, -87.324722,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Jack B. Weaver',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Montgomery County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Montgomery';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Montgomery County Courthouse',
    '251 South Lawrence Street',
    'Montgomery',
    '36104',
    '(334) 832-1260',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://montgomery.alacourt.gov',
    32.376667, -86.308889,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Johnny Hardwick',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish,Korean,Vietnamese}'
  ) ON CONFLICT DO NOTHING;

  -- Montgomery County Family Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Montgomery County Family Court',
    '100 South Lawrence Street',
    'Montgomery',
    '36104',
    '(334) 832-1390',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://montgomery.alacourt.gov/family',
    32.375833, -86.309167,
    v_county_id,
    '{family,juvenile}'::court_type[],
    'county',
    'Hon. Calvin L. Williams',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish,Korean,Vietnamese}'
  ) ON CONFLICT DO NOTHING;

  -- Morgan County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Morgan';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Morgan County Courthouse',
    '302 Lee Street NE',
    'Decatur',
    '35601',
    '(256) 351-4600',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://morgan.alacourt.gov',
    34.605833, -86.983333,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Jennifer M. Howell',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Perry County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Perry';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Perry County Courthouse',
    '300 Washington Street',
    'Marion',
    '36756',
    '(334) 683-2205',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://perry.alacourt.gov',
    32.631944, -87.319167,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Donald R. McMillan',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;