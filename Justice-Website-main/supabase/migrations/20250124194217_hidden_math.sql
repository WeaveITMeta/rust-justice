-- Add more courts for Alaska counties
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Alaska state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AK';
  
  -- Yukon-Koyukuk Census Area Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Yukon-Koyukuk';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Fort Yukon Courthouse',
    '255 3rd Avenue',
    'Fort Yukon',
    '99740',
    '(907) 662-2311',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/fyukon',
    66.564722, -145.274167,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Nathaniel Peters',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available at courthouse.',
    true, true, true,
    '{English,Gwich''in,Koyukon}'
  ) ON CONFLICT DO NOTHING;

  -- Galena Courthouse
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Galena Courthouse',
    '171 Antoski Avenue',
    'Galena',
    '99741',
    '(907) 656-1352',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/galena',
    64.733889, -156.927222,
    v_county_id,
    '{civil,criminal}'::court_type[],
    'county',
    'Hon. Romano DiBenedetto',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available at courthouse.',
    true, true, true,
    '{English,Koyukon,Holikachuk}'
  ) ON CONFLICT DO NOTHING;

  -- Wrangell Borough Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Wrangell';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Wrangell Courthouse',
    '215 Front Street',
    'Wrangell',
    '99929',
    '(907) 874-2311',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/wrangell',
    56.470833, -132.376944,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. William B. Carey',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Tlingit,Russian}'
  ) ON CONFLICT DO NOTHING;

END $$;