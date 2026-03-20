-- Add courts for Faulkner County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Faulkner County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Faulkner';

  -- Faulkner County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Faulkner County Circuit Court',
    '801 Locust Street',
    'Conway',
    '72034',
    '(501) 450-4914',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.faulknercounty.org/government/circuit-courts',
    35.086944, -92.441667,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Troy B. Braswell Jr.',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Conway District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Conway District Court',
    '810 Parkway Street',
    'Conway',
    '72034',
    '(501) 450-6110',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.conwayarkansas.gov/district-court',
    35.086389, -92.440833,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Chris R. Carnahan',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Greenbrier District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Greenbrier District Court',
    '11 Wilson Farm Road',
    'Greenbrier',
    '72058',
    '(501) 679-2923',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.faulknercounty.org/government/district-courts',
    35.233889, -92.387778,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Susan Weaver',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Guy District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Guy District Court',
    '403 Highway 25 North',
    'Guy',
    '72061',
    '(501) 679-2923',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.faulknercounty.org/government/district-courts',
    35.325833, -92.334722,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. David Reynolds',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Mayflower District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Mayflower District Court',
    '2 Ashmore Drive',
    'Mayflower',
    '72106',
    '(501) 470-0229',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.faulknercounty.org/government/district-courts',
    34.966667, -92.423889,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. David Reynolds',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;