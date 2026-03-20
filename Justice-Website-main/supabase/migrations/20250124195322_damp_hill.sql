-- Add courts for Yavapai County, Arizona
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- Yavapai County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Yavapai';

  -- Yavapai County Superior Court - Prescott
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Yavapai County Superior Court - Prescott',
    '120 South Cortez Street',
    'Prescott',
    '86303',
    '(928) 771-3312',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://courts.yavapaiaz.gov/superiorcourt',
    34.540278, -112.469722,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. John D. Napper',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Yavapai County Superior Court - Verde Valley
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Yavapai County Superior Court - Verde Valley',
    '2840 North Commonwealth Drive',
    'Camp Verde',
    '86322',
    '(928) 567-7741',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://courts.yavapaiaz.gov/superiorcourt',
    34.583889, -111.854722,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Michael R. Bluff',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Prescott Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Prescott Justice Court',
    '120 South Cortez Street',
    'Prescott',
    '86303',
    '(928) 771-3300',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://courts.yavapaiaz.gov/justicecourts',
    34.540278, -112.469722,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Glenn A. Savona',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Paid parking available in nearby garages and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Verde Valley Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Verde Valley Justice Court',
    '2840 North Commonwealth Drive',
    'Camp Verde',
    '86322',
    '(928) 567-7710',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://courts.yavapaiaz.gov/justicecourts',
    34.583889, -111.854722,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. William Lundy',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Mayer Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Mayer Justice Court',
    '10250 Highway 69',
    'Mayer',
    '86333',
    '(928) 771-3300',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://courts.yavapaiaz.gov/justicecourts',
    34.403889, -112.238889,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. William Rummer',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Seligman Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Seligman Justice Court',
    '54242 North William Street',
    'Seligman',
    '86337',
    '(928) 771-3300',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://courts.yavapaiaz.gov/justicecourts',
    35.326944, -112.879722,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Jane Doe',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;