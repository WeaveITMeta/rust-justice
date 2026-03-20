-- Add courts for Crittenden County, Arkansas
INSERT INTO court_locations (
  name, address, city, zip_code, phone, hours, website,
  latitude, longitude, county_id, court_type, jurisdiction,
  presiding_judge, filing_office_hours, security_info, parking_info,
  electronic_filing, virtual_hearings, ada_accessibility, languages_supported
) 
SELECT 
  'Crittenden County Circuit Court',
  '100 Court Street',
  'Marion',
  '72364',
  '(870) 739-3209',
  'Monday-Friday 8:30 AM - 5:00 PM',
  'https://www.crittendencountyar.org/circuit-court',
  35.214722, -90.196389,
  counties.id,
  '{civil,criminal,family,probate}'::court_type[],
  'county',
  'Hon. Randy F. Philhours',
  'Monday-Friday 8:30 AM - 5:00 PM',
  'Enhanced security screening required. No weapons allowed. Valid government ID required.',
  'Free parking available in courthouse lot and street parking.',
  true, true, true,
  '{English,Spanish}'
FROM states
JOIN counties ON counties.state_id = states.id
WHERE states.code = 'AR' AND counties.name = 'Crittenden'
ON CONFLICT DO NOTHING;

INSERT INTO court_locations (
  name, address, city, zip_code, phone, hours, website,
  latitude, longitude, county_id, court_type, jurisdiction,
  presiding_judge, filing_office_hours, security_info, parking_info,
  electronic_filing, virtual_hearings, ada_accessibility, languages_supported
)
SELECT 
  'West Memphis District Court',
  '100 Court Street',
  'West Memphis',
  '72301',
  '(870) 732-7510',
  'Monday-Friday 8:30 AM - 5:00 PM',
  'https://www.westmemphisar.gov/district-court',
  35.146944, -90.184722,
  counties.id,
  '{criminal,traffic,civil}'::court_type[],
  'county',
  'Hon. Fred Thorne',
  'Monday-Friday 8:30 AM - 5:00 PM',
  'Security screening required. No weapons allowed. Photo ID required.',
  'Free parking available in courthouse lot.',
  true, true, true,
  '{English,Spanish}'
FROM states
JOIN counties ON counties.state_id = states.id
WHERE states.code = 'AR' AND counties.name = 'Crittenden'
ON CONFLICT DO NOTHING;

INSERT INTO court_locations (
  name, address, city, zip_code, phone, hours, website,
  latitude, longitude, county_id, court_type, jurisdiction,
  presiding_judge, filing_office_hours, security_info, parking_info,
  electronic_filing, virtual_hearings, ada_accessibility, languages_supported
)
SELECT 
  'Marion District Court',
  '14 Military Road',
  'Marion',
  '72364',
  '(870) 739-5411',
  'Monday-Friday 8:30 AM - 5:00 PM',
  'https://www.marionar.org/district-court',
  35.214444, -90.196667,
  counties.id,
  '{criminal,traffic,civil}'::court_type[],
  'county',
  'Hon. Jim Spears',
  'Monday-Friday 8:30 AM - 5:00 PM',
  'Security screening required. No weapons allowed. Photo ID required.',
  'Free parking available in courthouse lot.',
  true, true, true,
  '{English,Spanish}'
FROM states
JOIN counties ON counties.state_id = states.id
WHERE states.code = 'AR' AND counties.name = 'Crittenden'
ON CONFLICT DO NOTHING;

INSERT INTO court_locations (
  name, address, city, zip_code, phone, hours, website,
  latitude, longitude, county_id, court_type, jurisdiction,
  presiding_judge, filing_office_hours, security_info, parking_info,
  electronic_filing, virtual_hearings, ada_accessibility, languages_supported
)
SELECT 
  'Crittenden County Juvenile Court',
  '100 Court Street',
  'Marion',
  '72364',
  '(870) 739-3209',
  'Monday-Friday 8:30 AM - 5:00 PM',
  'https://www.crittendencountyar.org/juvenile-court',
  35.214722, -90.196389,
  counties.id,
  '{juvenile,family}'::court_type[],
  'county',
  'Hon. Ralph Wilson Jr.',
  'Monday-Friday 8:30 AM - 5:00 PM',
  'Enhanced security screening required. Special protocols for juvenile cases.',
  'Free parking available in courthouse lot.',
  true, true, true,
  '{English,Spanish}'
FROM states
JOIN counties ON counties.state_id = states.id
WHERE states.code = 'AR' AND counties.name = 'Crittenden'
ON CONFLICT DO NOTHING;