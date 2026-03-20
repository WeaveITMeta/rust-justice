-- Add courts for Gila County, Arizona
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- Gila County Courts
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Gila';

  -- Globe Courthouse
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Gila County Superior Court - Globe',
    '1400 East Ash Street',
    'Globe',
    '85501',
    '(928) 425-3231',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.gilacountyaz.gov/government/courts',
    33.394722, -110.781667,
    v_county_id,
    '{civil,criminal,family,probate}'::court_type[],
    'county',
    'Hon. Bryan B. Chambers',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Enhanced security screening required. No weapons allowed. Valid government ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,Apache}'
  ) ON CONFLICT DO NOTHING;

  -- Payson Regional Courthouse
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Gila County Superior Court - Payson',
    '714 South Beeline Highway',
    'Payson',
    '85541',
    '(928) 474-3978',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.gilacountyaz.gov/government/courts',
    34.231944, -111.321667,
    v_county_id,
    '{civil,criminal,family}'::court_type[],
    'county',
    'Hon. Timothy M. Wright',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

  -- Globe Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Globe Justice Court',
    '1400 East Ash Street',
    'Globe',
    '85501',
    '(928) 425-3231',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.gilacountyaz.gov/government/justice_courts',
    33.394722, -110.781667,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Gary V. Scales',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish,Apache}'
  ) ON CONFLICT DO NOTHING;

  -- Payson Justice Court
  INSERT INTO court_locations (
    name, address, city, zip_code, phone, hours, website,
    latitude, longitude, county_id, court_type, jurisdiction,
    presiding_judge, filing_office_hours, security_info, parking_info,
    electronic_filing, virtual_hearings, ada_accessibility, languages_supported
  ) VALUES (
    'Payson Justice Court',
    '714 South Beeline Highway',
    'Payson',
    '85541',
    '(928) 474-5267',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.gilacountyaz.gov/government/justice_courts',
    34.231944, -111.321667,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Dorothy A. Little',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed. Photo ID required.',
    'Free parking available in courthouse lot.',
    true, true, true,
    '{English,Spanish}'
  ) ON CONFLICT DO NOTHING;

END $$;