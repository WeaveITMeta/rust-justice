-- Add courts for Pulaski County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Pulaski County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Pulaski';

  -- Pulaski County Courthouse
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Pulaski County Courthouse',
    '401 West Markham Street',
    'Little Rock',
    '72201',
    '(501) 340-8000',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://pulaskicounty.net/circuit-court/',
    34.748611, -92.273889,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Mary Spencer McGowan',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish,American Sign Language}'
  ) ON CONFLICT DO NOTHING;

  -- Pulaski County District Court - Little Rock
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Pulaski County District Court - Little Rock',
    '600 West Markham Street',
    'Little Rock',
    '72201',
    '(501) 371-4733',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://pulaskicounty.net/district-court/',
    34.748889, -92.275833,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Hugh Finkelstein',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish,American Sign Language}'
  ) ON CONFLICT DO NOTHING;

  -- Pulaski County District Court - North Little Rock
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Pulaski County District Court - North Little Rock',
    '200 West Pershing Boulevard',
    'North Little Rock',
    '72114',
    '(501) 791-8562',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://pulaskicounty.net/district-court/',
    34.756944, -92.268889,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Randy Morley',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Pulaski County District Court - Jacksonville
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Pulaski County District Court - Jacksonville',
    '1412 West Main Street',
    'Jacksonville',
    '72076',
    '(501) 982-3191',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://pulaskicounty.net/district-court/',
    34.866667, -92.116667,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Rita Bailey',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Pulaski County District Court - Sherwood
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Pulaski County District Court - Sherwood',
    '2201 East Kiehl Avenue',
    'Sherwood',
    '72120',
    '(501) 835-8166',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://pulaskicounty.net/district-court/',
    34.832778, -92.163889,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Milas Hale III',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Pulaski County District Court - Maumelle
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Pulaski County District Court - Maumelle',
    '550 Edgewood Drive',
    'Maumelle',
    '72113',
    '(501) 851-9819',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://pulaskicounty.net/district-court/',
    34.851944, -92.401667,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Mark Leverett',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;