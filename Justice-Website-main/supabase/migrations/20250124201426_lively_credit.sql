-- Add courts for Conway County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Conway County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Conway';

  -- Conway County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Conway County Circuit Court',
    '117 South Moose Street',
    'Morrilton',
    '72110',
    '(501) 354-9621',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.conwaycounty.org/circuit-court',
    35.151944, -92.744722,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Terry Sullivan',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Morrilton District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Morrilton District Court',
    '117 South Moose Street',
    'Morrilton',
    '72110',
    '(501) 354-4343',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.conwaycounty.org/district-court',
    35.151944, -92.744722,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. David Reynolds',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Plumerville District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Plumerville District Court',
    '101 West Main Street',
    'Plumerville',
    '72127',
    '(501) 354-4343',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.conwaycounty.org/district-court',
    35.160833, -92.639722,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. David Reynolds',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Menifee District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Menifee District Court',
    '555 West Conway Street',
    'Menifee',
    '72107',
    '(501) 354-4343',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.conwaycounty.org/district-court',
    35.148889, -92.557222,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. David Reynolds',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Conway County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Conway County Juvenile Court',
    '117 South Moose Street',
    'Morrilton',
    '72110',
    '(501) 354-9621',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.conwaycounty.org/juvenile-court',
    35.151944, -92.744722,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Terry Sullivan',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;