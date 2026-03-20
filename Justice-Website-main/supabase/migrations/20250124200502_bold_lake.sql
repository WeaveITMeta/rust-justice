-- Add courts for Carroll County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Carroll County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Carroll';

  -- Carroll County Circuit Court - Eastern District
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Carroll County Circuit Court - Eastern District',
    '210 West Church Avenue',
    'Berryville',
    '72616',
    '(870) 423-2022',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.carrollcountyar.gov/circuit-court',
    36.364722, -93.568333,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Scott Jackson',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Carroll County Circuit Court - Western District
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Carroll County Circuit Court - Western District',
    '44 South Main Street',
    'Eureka Springs',
    '72632',
    '(479) 253-8646',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.carrollcountyar.gov/circuit-court',
    36.401667, -93.737778,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Scott Jackson',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in nearby lots and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Berryville District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Berryville District Court',
    '112 East Fancher Street',
    'Berryville',
    '72616',
    '(870) 423-3767',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.berryvillear.gov/district-court',
    36.364444, -93.567778,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Dale Ramsey',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Eureka Springs District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Eureka Springs District Court',
    '44 South Main Street',
    'Eureka Springs',
    '72632',
    '(479) 253-8611',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.cityofeurekasprings.gov/district-court',
    36.401667, -93.737778,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Dale Ramsey',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in nearby lots and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Carroll County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Carroll County Juvenile Court',
    '210 West Church Avenue',
    'Berryville',
    '72616',
    '(870) 423-2022',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.carrollcountyar.gov/juvenile-court',
    36.364722, -93.568333,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Scott Jackson',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available around courthouse square.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;