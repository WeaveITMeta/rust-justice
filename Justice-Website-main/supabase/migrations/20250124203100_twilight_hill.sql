-- Add courts for Cross County, Arkansas
INSERT INTO court_locations (
  name, address, city, zip_code, phone, hours, website,
  latitude, longitude, county_id, court_type, jurisdiction,
  presiding_judge, filing_office_hours, security_info, parking_info,
  electronic_filing, virtual_hearings, ada_accessibility, languages_supported
) 
SELECT 
  'Cross County Circuit Court',
  '705 East Union Avenue',
  'Wynne',
  '72396',
  '(870) 238-5735',
  'Monday-Friday 8:00 AM - 4:30 PM',
  'https://www.crosscountyar.org/circuit-court',
  35.224722, -90.786944,
  counties.id,
  '{civil,criminal,family,probate}'::court_type[],
  'county',
  'Hon. Chalk Mitchell',
  'Monday-Friday 8:00 AM - 4:30 PM',
  'Enhanced security screening required. No weapons allowed. Valid government ID required.',
  'Free parking available in courthouse lot.',
  true, true, true,
  '{English,Spanish}'
FROM states
JOIN counties ON counties.state_id = states.id
WHERE states.code = 'AR' AND counties.name = 'Cross'
ON CONFLICT DO NOTHING;

INSERT INTO court_locations (
  name, address, city, zip_code, phone, hours, website,
  latitude, longitude, county_id, court_type, jurisdiction,
  presiding_judge, filing_office_hours, security_info, parking_info,
  electronic_filing, virtual_hearings, ada_accessibility, languages_supported
)
SELECT 
  'Wynne District Court',
  '1 East Hamilton Avenue',
  'Wynne',
  '72396',
  '(870) 238-3101',
  'Monday-Friday 8:00 AM - 4:30 PM',
  'https://www.crosscountyar.org/district-court',
  35.224167, -90.786667,
  counties.id,
  '{criminal,traffic,civil}'::court_type[],
  'county',
  'Hon. Joe Boeckmann',
  'Monday-Friday 8:00 AM - 4:30 PM',
  'Security screening required. No weapons allowed. Photo ID required.',
  'Free parking available in courthouse lot and street parking.',
  true, true, true,
  '{English,Spanish}'
FROM states
JOIN counties ON counties.state_id = states.id
WHERE states.code = 'AR' AND counties.name = 'Cross'
ON CONFLICT DO NOTHING;

INSERT INTO court_locations (
  name, address, city, zip_code, phone, hours, website,
  latitude, longitude, county_id, court_type, jurisdiction,
  presiding_judge, filing_office_hours, security_info, parking_info,
  electronic_filing, virtual_hearings, ada_accessibility, languages_supported
)
SELECT 
  'Cherry Valley District Court',
  '215 Highway 1',
  'Cherry Valley',
  '72324',
  '(870) 588-3121',
  'Monday-Friday 8:00 AM - 4:30 PM',
  'https://www.crosscountyar.org/district-court',
  35.402778, -90.753333,
  counties.id,
  '{criminal,traffic,civil}'::court_type[],
  'county',
  'Hon. Joe Boeckmann',
  'Monday-Friday 8:00 AM - 4:30 PM',
  'Security screening required. No weapons allowed. Photo ID required.',
  'Free parking available in courthouse lot.',
  true, true, true,
  '{English,Spanish}'
FROM states
JOIN counties ON counties.state_id = states.id
WHERE states.code = 'AR' AND counties.name = 'Cross'
ON CONFLICT DO NOTHING;

INSERT INTO court_locations (
  name, address, city, zip_code, phone, hours, website,
  latitude, longitude, county_id, court_type, jurisdiction,
  presiding_judge, filing_office_hours, security_info, parking_info,
  electronic_filing, virtual_hearings, ada_accessibility, languages_supported
)
SELECT 
  'Cross County Juvenile Court',
  '705 East Union Avenue',
  'Wynne',
  '72396',
  '(870) 238-5735',
  'Monday-Friday 8:00 AM - 4:30 PM',
  'https://www.crosscountyar.org/juvenile-court',
  35.224722, -90.786944,
  counties.id,
  '{juvenile,family}'::court_type[],
  'county',
  'Hon. Chalk Mitchell',
  'Monday-Friday 8:00 AM - 4:30 PM',
  'Enhanced security screening required. Special protocols for juvenile cases.',
  'Free parking available in courthouse lot.',
  true, true, true,
  '{English,Spanish}'
FROM states
JOIN counties ON counties.state_id = states.id
WHERE states.code = 'AR' AND counties.name = 'Cross'
ON CONFLICT DO NOTHING;