-- Add courts for Desha County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Desha County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Desha';

  -- Desha County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Desha County Circuit Court',
    '604 President Street',
    'Arkansas City',
    '71630',
    '(870) 877-2426',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.deshacounty.org/circuit-court',
    33.608889, -91.206944,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Don Glover',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Arkansas City District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Arkansas City District Court',
    '604 President Street',
    'Arkansas City',
    '71630',
    '(870) 877-2426',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.deshacounty.org/district-court',
    33.608889, -91.206944,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Jeremy Bueker',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- McGehee District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'McGehee District Court',
    '901 Holly Street',
    'McGehee',
    '71654',
    '(870) 222-4937',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.deshacounty.org/district-court',
    33.628889, -91.396111,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Jeremy Bueker',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Dumas District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Dumas District Court',
    '155 East Waterman Street',
    'Dumas',
    '71639',
    '(870) 382-4786',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.deshacounty.org/district-court',
    33.887778, -91.492222,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Jeremy Bueker',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Desha County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Desha County Juvenile Court',
    '604 President Street',
    'Arkansas City',
    '71630',
    '(870) 877-2426',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.deshacounty.org/juvenile-court',
    33.608889, -91.206944,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Don Glover',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;