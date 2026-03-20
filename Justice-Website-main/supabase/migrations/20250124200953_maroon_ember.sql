-- Add courts for Clay County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Clay County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Clay';

  -- Clay County Circuit Court - Western District
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Clay County Circuit Court - Western District',
    '800 SW 2nd Street',
    'Corning',
    '72422',
    '(870) 857-3480',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.claycountyar.gov/circuit-court',
    36.408333, -90.580556,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Cindy Thyer',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Clay County Circuit Court - Eastern District
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Clay County Circuit Court - Eastern District',
    '151 South 2nd Avenue',
    'Piggott',
    '72454',
    '(870) 598-2813',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.claycountyar.gov/circuit-court',
    36.382778, -90.190833,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Cindy Thyer',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Corning District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Corning District Court',
    '801 West 2nd Street',
    'Corning',
    '72422',
    '(870) 857-3521',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.claycountyar.gov/district-courts',
    36.408333, -90.580833,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. David Copelin',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Piggott District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Piggott District Court',
    '151 South 2nd Avenue',
    'Piggott',
    '72454',
    '(870) 598-2815',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.claycountyar.gov/district-courts',
    36.382778, -90.190833,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. David Copelin',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Clay County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Clay County Juvenile Court',
    '800 SW 2nd Street',
    'Corning',
    '72422',
    '(870) 857-3480',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.claycountyar.gov/juvenile-court',
    36.408333, -90.580556,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Cindy Thyer',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;