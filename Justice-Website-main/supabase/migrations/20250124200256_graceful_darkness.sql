-- Add courts for Boone County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Boone County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Boone';

  -- Boone County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Boone County Circuit Court',
    '100 North Main Street',
    'Harrison',
    '72601',
    '(870) 741-8432',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.boonecountyar.com/circuit-court',
    36.229722, -93.107500,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. John R. Putman',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Harrison District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Harrison District Court',
    '114 South Spring Street',
    'Harrison',
    '72601',
    '(870) 741-3137',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.cityofharrison.com/district-court',
    36.229167, -93.107222,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Dale Miller',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Valley Springs District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Valley Springs District Court',
    '6818 Highway 65 South',
    'Valley Springs',
    '72682',
    '(870) 429-5611',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.boonecountyar.com/district-courts',
    36.157500, -92.988333,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Dale Miller',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Boone County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Boone County Juvenile Court',
    '100 North Main Street',
    'Harrison',
    '72601',
    '(870) 741-8432',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.boonecountyar.com/juvenile-court',
    36.229722, -93.107500,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Deanna Evans',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;