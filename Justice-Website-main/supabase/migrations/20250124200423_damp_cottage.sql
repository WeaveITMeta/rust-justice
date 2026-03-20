-- Add courts for Calhoun County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Calhoun County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Calhoun';

  -- Calhoun County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Calhoun County Circuit Court',
    '309 West Main Street',
    'Hampton',
    '71744',
    '(870) 798-2517',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.calhouncountyar.com/circuit-court',
    33.537222, -92.469722,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Hamilton Singleton',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Hampton District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Hampton District Court',
    '309 West Main Street',
    'Hampton',
    '71744',
    '(870) 798-2626',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.calhouncountyar.com/district-court',
    33.537222, -92.469722,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. David Graham',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Calhoun County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Calhoun County Juvenile Court',
    '309 West Main Street',
    'Hampton',
    '71744',
    '(870) 798-2517',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.calhouncountyar.com/juvenile-court',
    33.537222, -92.469722,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Hamilton Singleton',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;