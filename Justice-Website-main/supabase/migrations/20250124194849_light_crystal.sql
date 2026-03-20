-- Add courts for La Paz County, Arizona
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- La Paz County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'La Paz';

  -- La Paz County Superior Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'La Paz County Superior Court',
    '1316 Kofa Avenue',
    'Parker',
    '85344',
    '(928) 669-6131',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.lapazcountyaz.org/departments/superior-court',
    34.150278, -114.289444,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Jessica Quickle',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Parker Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Parker Justice Court',
    '1105 Arizona Avenue',
    'Parker',
    '85344',
    '(928) 669-2504',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.lapazcountyaz.org/departments/justice-courts',
    34.150000, -114.287778,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Tiffany Dyer',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Quartzsite Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Quartzsite Justice Court',
    '555 Plymouth Avenue',
    'Quartzsite',
    '85346',
    '(928) 927-6313',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.lapazcountyaz.org/departments/justice-courts',
    33.664167, -114.229444,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Karen Slaughter',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot and street parking.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Colorado River Indian Tribes Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Colorado River Indian Tribes Tribal Court',
    '26600 Mohave Road',
    'Parker',
    '85344',
    '(928) 669-1355',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.crit-nsn.gov/crit_contents/government/tribal-court',
    34.166667, -114.300000,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'federal',
    'Hon. Lawrence C. King',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. Special protocols for tribal court. Photo ID required.',
    'Free parking available at courthouse.',
    true, true, true,
    '{English,Mohave,Chemehuevi,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;