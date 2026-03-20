-- Add courts for Cleveland County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Cleveland County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Cleveland';

  -- Cleveland County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Cleveland County Circuit Court',
    '20 Magnolia Street',
    'Rison',
    '71665',
    '(870) 325-6012',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.clevelandcountyar.gov/circuit-court',
    33.957778, -92.190278,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. David W. Talley Jr.',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Rison District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Rison District Court',
    '20 Magnolia Street',
    'Rison',
    '71665',
    '(870) 325-6231',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.clevelandcountyar.gov/district-court',
    33.957778, -92.190278,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Ken Harper',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Cleveland County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Cleveland County Juvenile Court',
    '20 Magnolia Street',
    'Rison',
    '71665',
    '(870) 325-6012',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.clevelandcountyar.gov/juvenile-court',
    33.957778, -92.190278,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. David W. Talley Jr.',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;