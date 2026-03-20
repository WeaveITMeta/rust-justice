-- Add courts for Garland County, Arkansas
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arkansas state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AR';
  
  -- Garland County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Garland';

  -- Garland County Circuit Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Garland County Circuit Court',
    '501 Ouachita Avenue',
    'Hot Springs',
    '71901',
    '(501) 622-3600',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.garlandcounty.org/266/Circuit-Court',
    34.503333, -93.055278,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Marcia R. Hearnsberger',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Hot Springs District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Hot Springs District Court',
    '607 Ouachita Avenue',
    'Hot Springs',
    '71901',
    '(501) 321-6765',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.cityhs.net/156/District-Court',
    34.504167, -93.055556,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Ralph C. Ohm',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Garland County Juvenile Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Garland County Juvenile Court',
    '607 Ouachita Avenue',
    'Hot Springs',
    '71901',
    '(501) 622-3750',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.garlandcounty.org/267/Juvenile-Court',
    34.504167, -93.055556,
    v_county_id,
    '{juvenile,family}'::court_type[],
    'county',
    'Hon. Cecilia Dyer',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Enhanced security screening required. Special protocols for juvenile cases.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Mountain Pine District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Mountain Pine District Court',
    '144 Blakely Dam Road',
    'Mountain Pine',
    '71956',
    '(501) 767-3335',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.garlandcounty.org/268/District-Courts',
    34.573333, -93.172778,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. David Switzer',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Fountain Lake District Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Fountain Lake District Court',
    '4207 Park Avenue',
    'Hot Springs',
    '71901',
    '(501) 623-5188',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'https://www.garlandcounty.org/268/District-Courts',
    34.518889, -93.026389,
    v_county_id,
    '{criminal,traffic,civil}'::court_type[],
    'county',
    'Hon. Joe Graham',
    'Monday-Friday 8:00 AM - 4:30 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;