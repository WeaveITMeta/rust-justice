-- Add courts for additional Alabama counties
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Alabama state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AL';
  
  -- Randolph County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Randolph';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Randolph County Courthouse',
    '1 Main Street',
    'Wedowee',
    '36278',
    '(256) 357-4933',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://randolph.alacourt.gov',
    33.308889, -85.485556,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. George Diamond',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Russell County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Russell';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Russell County Judicial Center',
    '501 14th Street',
    'Phenix City',
    '36867',
    '(334) 298-0516',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://russell.alacourt.gov',
    32.471111, -85.000833,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. David Johnson',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Russell County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Russell County Juvenile Court',
    '1500 Broad Street',
    'Phenix City',
    '36867',
    '(334) 298-8862',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://russell.alacourt.gov/juvenile',
    32.469444, -85.002778,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Buster Landreau',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Shelby County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Shelby';

  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Shelby County Courthouse',
    '112 North Main Street',
    'Columbiana',
    '35051',
    '(205) 669-3760',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://shelby.alacourt.gov',
    33.183889, -86.607222,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. William H. Bostick III',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;