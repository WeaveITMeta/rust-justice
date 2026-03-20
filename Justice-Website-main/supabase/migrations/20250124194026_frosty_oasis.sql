-- Add more courts for Alaska counties
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Alaska state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AK';
  
  -- Kodiak Island Borough Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Kodiak Island';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Kodiak Courthouse',
    '204 Mission Road',
    'Kodiak',
    '99615',
    '(907) 486-1600',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/kodiak',
    57.788333, -152.407222,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Stephen Wallace',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Alutiiq,Tagalog}'
  ) ON CONFLICT DO NOTHING;

  -- Matanuska-Susitna Borough Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Matanuska-Susitna';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Palmer Courthouse',
    '435 South Denali Street',
    'Palmer',
    '99645',
    '(907) 746-8100',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/palmer',
    61.599444, -149.112778,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Jonathan A. Woodman',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Denaʼina,Russian,Samoan}'
  ) ON CONFLICT DO NOTHING;

  -- Nome Census Area Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Nome';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Nome Courthouse',
    '113 Front Street',
    'Nome',
    '99762',
    '(907) 443-5216',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/nome',
    64.497222, -165.406389,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Romano DiBenedetto',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Inupiaq,Yupik,Siberian Yupik}'
  ) ON CONFLICT DO NOTHING;

  -- North Slope Borough Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'North Slope';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Barrow Courthouse',
    '1250 Agvik Street',
    'Utqiaġvik',
    '99723',
    '(907) 852-4800',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/barrow',
    71.290556, -156.788611,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Angela Greene',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available at courthouse.',
    true, true, true,
    '{English,Inupiaq,Yupik}'
  ) ON CONFLICT DO NOTHING;

END $$;