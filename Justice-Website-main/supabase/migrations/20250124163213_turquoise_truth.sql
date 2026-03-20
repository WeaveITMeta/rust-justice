-- Add sample courts for Pima County
DO $$
DECLARE
  v_state_id uuid;
  v_county_id uuid;
BEGIN
  -- Get Arizona state ID
  SELECT id INTO v_state_id FROM states WHERE code = 'AZ';
  
  -- Get Pima County ID
  SELECT id INTO v_county_id FROM counties 
  WHERE state_id = v_state_id AND name = 'Pima';

  -- Insert Pima County Superior Court
  INSERT INTO court_locations (
    name,
    address,
    city,
    zip_code,
    phone,
    hours,
    website,
    latitude,
    longitude,
    county_id,
    court_type,
    jurisdiction,
    presiding_judge,
    filing_office_hours,
    security_info,
    parking_info,
    electronic_filing,
    virtual_hearings
  ) VALUES (
    'Pima County Superior Court',
    '110 W Congress St',
    'Tucson',
    '85701',
    '(520) 724-3200',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.sc.pima.gov',
    32.221743,
    -110.974167,
    v_county_id,
    '{criminal,civil}'::court_type[],
    'county',
    'Hon. Jeffrey T. Bergin',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed.',
    'Paid parking available in nearby garages and street parking',
    true,
    true
  ) ON CONFLICT DO NOTHING;

  -- Insert Pima County Juvenile Court
  INSERT INTO court_locations (
    name,
    address,
    city,
    zip_code,
    phone,
    hours,
    website,
    latitude,
    longitude,
    county_id,
    court_type,
    jurisdiction,
    presiding_judge,
    filing_office_hours,
    security_info,
    parking_info,
    electronic_filing,
    virtual_hearings
  ) VALUES (
    'Pima County Juvenile Court',
    '2225 E Ajo Way',
    'Tucson',
    '85713',
    '(520) 724-2000',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.sc.pima.gov/juvenile',
    32.182439,
    -110.944669,
    v_county_id,
    '{juvenile}'::court_type[],
    'county',
    'Hon. Joan L. Wagener',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed.',
    'Free parking available',
    true,
    true
  ) ON CONFLICT DO NOTHING;

  -- Insert Pima County Justice Court
  INSERT INTO court_locations (
    name,
    address,
    city,
    zip_code,
    phone,
    hours,
    website,
    latitude,
    longitude,
    county_id,
    court_type,
    jurisdiction,
    presiding_judge,
    filing_office_hours,
    security_info,
    parking_info,
    electronic_filing,
    virtual_hearings
  ) VALUES (
    'Pima County Justice Court',
    '240 N Stone Ave',
    'Tucson',
    '85701',
    '(520) 724-3171',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.jp.pima.gov',
    32.224431,
    -110.972084,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'county',
    'Hon. Charlene Pesquiera',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed.',
    'Paid street parking and nearby garages available',
    true,
    true
  ) ON CONFLICT DO NOTHING;

  -- Insert Tucson City Court
  INSERT INTO court_locations (
    name,
    address,
    city,
    zip_code,
    phone,
    hours,
    website,
    latitude,
    longitude,
    county_id,
    court_type,
    jurisdiction,
    presiding_judge,
    filing_office_hours,
    security_info,
    parking_info,
    electronic_filing,
    virtual_hearings
  ) VALUES (
    'Tucson City Court',
    '103 E Alameda St',
    'Tucson',
    '85701',
    '(520) 791-4216',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'https://www.tucsonaz.gov/courts',
    32.222439,
    -110.970931,
    v_county_id,
    '{criminal,civil,traffic}'::court_type[],
    'municipal',
    'Hon. Antonio F. Riojas Jr.',
    'Monday-Friday 8:00 AM - 5:00 PM',
    'Security screening required. No weapons allowed.',
    'Paid parking available in city garages',
    true,
    true
  ) ON CONFLICT DO NOTHING;
END $$;