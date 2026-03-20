-- Add more courts for Alaska counties
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Alaska state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AK';
  
  -- Southeast Fairbanks Census Area Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Southeast Fairbanks';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Delta Junction Courthouse',
    '2397 Alaska Highway',
    'Delta Junction',
    '99737',
    '(907) 895-4225',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/delta',
    64.037500, -145.732778,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Matthew C. Christian',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available at courthouse.',
    true, true, true,
    '{English,Athabascan,Russian}'
  ) ON CONFLICT DO NOTHING;

  -- Tok Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Tok Court',
    'Mile 1314 Alaska Highway',
    'Tok',
    '99780',
    '(907) 883-4951',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/tok',
    63.335833, -142.985833,
    v_county_id,
    '{civil,criminal}'::court_type[],
    'county',
    'Hon. David Roghair',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available at courthouse.',
    true, true, true,
    '{English,Athabascan}'
  ) ON CONFLICT DO NOTHING;

  -- Valdez-Cordova Census Area Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Valdez-Cordova';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Valdez Courthouse',
    '213 Meals Avenue',
    'Valdez',
    '99686',
    '(907) 835-2266',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/valdez',
    61.130833, -146.348333,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Daniel Schally',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Russian,Alutiiq}'
  ) ON CONFLICT DO NOTHING;

  -- Cordova Courthouse
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Cordova Courthouse',
    '500 Water Street',
    'Cordova',
    '99574',
    '(907) 424-6125',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://courts.alaska.gov/courts/cordova',
    60.545556, -145.759167,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Rachel Ahrens',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Russian,Alutiiq}'
  ) ON CONFLICT DO NOTHING;

END $$;