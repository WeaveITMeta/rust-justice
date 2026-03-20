-- Add courts for Sebastian County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Sebastian County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Sebastian';

  -- Sebastian County Courts - Fort Smith Division
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Sebastian County Courts - Fort Smith Division',
    '35 South 6th Street',
    'Fort Smith',
    '72901',
    '(479) 783-1883',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.sebastiancountyar.gov/Departments/Courts',
    35.385833, -94.424722,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Stephen Tabor',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish,Vietnamese}'
  ) ON CONFLICT DO NOTHING;

  -- Sebastian County Courts - Greenwood Division
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Sebastian County Courts - Greenwood Division',
    '301 East Center Street',
    'Greenwood',
    '72936',
    '(479) 996-2766',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.sebastiancountyar.gov/Departments/Courts',
    35.213889, -94.255833,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. James O. Cox',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Fort Smith District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Fort Smith District Court',
    '100 South 10th Street',
    'Fort Smith',
    '72901',
    '(479) 784-2010',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.fortsmithar.gov/index.php/courts',
    35.384722, -94.428889,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Claire Borengasser',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish,Vietnamese}'
  ) ON CONFLICT DO NOTHING;

  -- Greenwood District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Greenwood District Court',
    '301 East Center Street',
    'Greenwood',
    '72936',
    '(479) 996-2766',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.greenwoodar.org/district-court',
    35.213889, -94.255833,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Nicholas Lelack',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Sebastian County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Sebastian County Juvenile Court',
    '1420 South D Street',
    'Fort Smith',
    '72901',
    '(479) 783-4031',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.sebastiancountyar.gov/Departments/Courts/Juvenile-Division',
    35.375556, -94.424167,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Leigh Zuerker',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,Vietnamese}'
  ) ON CONFLICT DO NOTHING;

END $$;