-- Add courts for Chicot County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Chicot County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Chicot';

  -- Chicot County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Chicot County Circuit Court',
    '108 Main Street',
    'Lake Village',
    '71653',
    '(870) 265-8000',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.chicotcounty.ar.gov/circuit-court',
    33.328889, -91.284722,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Sam Pope',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Lake Village District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Lake Village District Court',
    '108 Main Street',
    'Lake Village',
    '71653',
    '(870) 265-5310',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.chicotcounty.ar.gov/district-court',
    33.328889, -91.284722,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Mack McCain',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Dermott District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Dermott District Court',
    '116 North Freeman Street',
    'Dermott',
    '71638',
    '(870) 538-5269',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.chicotcounty.ar.gov/district-court',
    33.525556, -91.435833,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Mack McCain',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Eudora District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Eudora District Court',
    '239 South Main Street',
    'Eudora',
    '71640',
    '(870) 355-2300',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.chicotcounty.ar.gov/district-court',
    33.109722, -91.262222,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Mack McCain',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Chicot County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Chicot County Juvenile Court',
    '108 Main Street',
    'Lake Village',
    '71653',
    '(870) 265-8000',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.chicotcounty.ar.gov/juvenile-court',
    33.328889, -91.284722,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Sam Pope',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;