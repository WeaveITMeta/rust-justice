-- Add courts for Drew County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Drew County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Drew';

  -- Drew County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Drew County Circuit Court',
    '210 South Main Street',
    'Monticello',
    '71655',
    '(870) 460-6200',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.drewcounty.org/circuit-court',
    33.629167, -91.791389,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Quincey Ross',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Monticello District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Monticello District Court',
    '101 East Gaines Street',
    'Monticello',
    '71655',
    '(870) 367-4454',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.drewcounty.org/district-court',
    33.628889, -91.791667,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Ken Harper',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Wilmar District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Wilmar District Court',
    '2684 Highway 278 West',
    'Wilmar',
    '71675',
    '(870) 469-5411',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.drewcounty.org/district-court',
    33.628333, -91.935833,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Ken Harper',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Drew County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Drew County Juvenile Court',
    '210 South Main Street',
    'Monticello',
    '71655',
    '(870) 460-6200',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.drewcounty.org/juvenile-court',
    33.629167, -91.791389,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Quincey Ross',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;