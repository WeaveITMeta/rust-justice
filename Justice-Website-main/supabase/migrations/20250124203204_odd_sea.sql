-- Add courts for Dallas County, Arkansas
INSERT INTO court_locations (
  name, address, city, zip_code, phone, hours, website,
  latitude, longitude, county_id, court_type, jurisdiction,
  presiding_judge, filing_office_hours, security_info, parking_info,
  electronic_filing, virtual_hearings, ada_accessibility, languages_supported
) 
SELECT 
  'Dallas County Circuit Court',
  '206 West 3rd Street',
  'Fordyce',
  '71742',
  '(870) 352-2307',
  'Monday-Friday 8:00 AM - 4:30 PM',
  'https://www.dallascountyar.org/circuit-court',
  33.813333, -92.411944,
  counties.id,
  '{civil,criminal,family,probate}'::court_type[],
  'county',
  'Hon. Hamilton H. Singleton',
  'Monday-Friday 8:00 AM - 4:30 PM',
  'Security screening required. No weapons allowed. Photo ID required.',
  'Free parking available around courthouse square.',
  true, true, true,
  '{English,Spanish}'
FROM states
JOIN counties ON counties.state_id = states.id
WHERE states.code = 'AR' AND counties.name = 'Dallas'
ON CONFLICT DO NOTHING;

INSERT INTO court_locations (
  name, address, city, zip_code, phone, hours, website,
  latitude, longitude, county_id, court_type, jurisdiction,
  presiding_judge, filing_office_hours, security_info, parking_info,
  electronic_filing, virtual_hearings, ada_accessibility, languages_supported
)
SELECT 
  'Fordyce District Court',
  '101 North Main Street',
  'Fordyce',
  '71742',
  '(870) 352-2120',
  'Monday-Friday 8:00 AM - 4:30 PM',
  'https://www.dallascountyar.org/district-court',
  33.813889, -92.412500,
  counties.id,
  '{criminal,traffic,civil}'::court_type[],
  'county',
  'Hon. G. Wayne Juneau',
  'Monday-Friday 8:00 AM - 4:30 PM',
  'Security screening required. No weapons allowed. Photo ID required.',
  'Free parking available in municipal lot.',
  true, true, true,
  '{English,Spanish}'
FROM states
JOIN counties ON counties.state_id = states.id
WHERE states.code = 'AR' AND counties.name = 'Dallas'
ON CONFLICT DO NOTHING;

INSERT INTO court_locations (
  name, address, city, zip_code, phone, hours, website,
  latitude, longitude, county_id, court_type, jurisdiction,
  presiding_judge, filing_office_hours, security_info, parking_info,
  electronic_filing, virtual_hearings, ada_accessibility, languages_supported
)
SELECT 
  'Dallas County Juvenile Court',
  '206 West 3rd Street',
  'Fordyce',
  '71742',
  '(870) 352-2307',
  'Monday-Friday 8:00 AM - 4:30 PM',
  'https://www.dallascountyar.org/juvenile-court',
  33.813333, -92.411944,
  counties.id,
  '{juvenile,family}'::court_type[],
  'county',
  'Hon. Hamilton H. Singleton',
  'Monday-Friday 8:00 AM - 4:30 PM',
  'Enhanced security screening required. Special protocols for juvenile cases.',
  'Free parking available around courthouse square.',
  true, true, true,
  '{English,Spanish}'
FROM states
JOIN counties ON counties.state_id = states.id
WHERE states.code = 'AR' AND counties.name = 'Dallas'
ON CONFLICT DO NOTHING;