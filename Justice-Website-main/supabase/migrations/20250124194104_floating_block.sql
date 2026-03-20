-- Add more courts for Alaska counties
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Alaska state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AK';
  
  -- Northwest Arctic Borough Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Northwest Arctic';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Kotzebue Courthouse',
    '605 3rd Avenue',
    'Kotzebue',
    '99752',
    '(907) 442-3208',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/kotz',
    66.898333, -162.597778,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Paul A. Roetman',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available at courthouse.',
    true, true, true,
    '{English,Inupiaq,Yupik}'
  ) ON CONFLICT DO NOTHING;

  -- Petersburg Borough Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Petersburg';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Petersburg Courthouse',
    '17 South Nordic Drive',
    'Petersburg',
    '99833',
    '(907) 772-3824',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/petersburg',
    56.812500, -132.955556,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. William B. Carey',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Tlingit,Norwegian}'
  ) ON CONFLICT DO NOTHING;

  -- Prince of Wales-Hyder Census Area Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Prince of Wales-Hyder';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Craig Courthouse',
    '404 Hamilton Drive',
    'Craig',
    '99921',
    '(907) 826-3374',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/craig',
    55.476389, -133.148611,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Kevin G. Miller',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available at courthouse.',
    true, true, true,
    '{English,Tlingit,Haida}'
  ) ON CONFLICT DO NOTHING;

  -- Sitka Borough Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Sitka';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Sitka Courthouse',
    '304 Lake Street',
    'Sitka',
    '99835',
    '(907) 747-3291',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/sitka',
    57.050833, -135.333056,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Jude Pate',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Tlingit,Russian}'
  ) ON CONFLICT DO NOTHING;

END $$;