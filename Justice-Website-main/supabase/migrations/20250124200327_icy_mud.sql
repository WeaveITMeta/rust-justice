-- Add courts for Bradley County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Bradley County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Bradley';

  -- Bradley County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Bradley County Circuit Court',
    '101 East Cedar Street',
    'Warren',
    '71671',
    '(870) 226-3355',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.bradleycountyar.org/circuit-court',
    33.613056, -92.064722,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Teresa French',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Warren District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Warren District Court',
    '101 East Cedar Street',
    'Warren',
    '71671',
    '(870) 226-5710',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.bradleycountyar.org/district-court',
    33.613056, -92.064722,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Robert Gibson',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Bradley County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Bradley County Juvenile Court',
    '101 East Cedar Street',
    'Warren',
    '71671',
    '(870) 226-3355',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.bradleycountyar.org/juvenile-court',
    33.613056, -92.064722,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Teresa French',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;