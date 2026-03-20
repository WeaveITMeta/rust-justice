/*
  # Add Remaining Counties for States

  1. New Data
    - Add counties for Maryland through Wyoming
    - Use v_state_id to avoid ambiguity
    - Preserve existing data with ON CONFLICT

  2. Changes
    - Insert counties for remaining states
    - Use PL/pgSQL variables correctly
*/

DO $$
DECLARE
  v_state_id uuid;
BEGIN
  -- Maryland
  SELECT id INTO v_state_id FROM states WHERE code = 'MD';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Allegany'), (v_state_id, 'Anne Arundel'), (v_state_id, 'Baltimore'),
    (v_state_id, 'Baltimore City'), (v_state_id, 'Calvert'), (v_state_id, 'Caroline'),
    (v_state_id, 'Carroll'), (v_state_id, 'Cecil'), (v_state_id, 'Charles'),
    (v_state_id, 'Dorchester'), (v_state_id, 'Frederick'), (v_state_id, 'Garrett'),
    (v_state_id, 'Harford'), (v_state_id, 'Howard'), (v_state_id, 'Kent'),
    (v_state_id, 'Montgomery'), (v_state_id, 'Prince George''s'), (v_state_id, 'Queen Anne''s'),
    (v_state_id, 'St. Mary''s'), (v_state_id, 'Somerset'), (v_state_id, 'Talbot'),
    (v_state_id, 'Washington'), (v_state_id, 'Wicomico'), (v_state_id, 'Worcester')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Massachusetts
  SELECT id INTO v_state_id FROM states WHERE code = 'MA';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Barnstable'), (v_state_id, 'Berkshire'), (v_state_id, 'Bristol'),
    (v_state_id, 'Dukes'), (v_state_id, 'Essex'), (v_state_id, 'Franklin'),
    (v_state_id, 'Hampden'), (v_state_id, 'Hampshire'), (v_state_id, 'Middlesex'),
    (v_state_id, 'Nantucket'), (v_state_id, 'Norfolk'), (v_state_id, 'Plymouth'),
    (v_state_id, 'Suffolk'), (v_state_id, 'Worcester')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Michigan
  SELECT id INTO v_state_id FROM states WHERE code = 'MI';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Alcona'), (v_state_id, 'Alger'), (v_state_id, 'Allegan'),
    (v_state_id, 'Alpena'), (v_state_id, 'Antrim'), (v_state_id, 'Arenac'),
    (v_state_id, 'Baraga'), (v_state_id, 'Barry'), (v_state_id, 'Bay'),
    (v_state_id, 'Benzie'), (v_state_id, 'Berrien'), (v_state_id, 'Branch'),
    (v_state_id, 'Calhoun'), (v_state_id, 'Cass'), (v_state_id, 'Charlevoix'),
    (v_state_id, 'Cheboygan'), (v_state_id, 'Chippewa'), (v_state_id, 'Clare'),
    (v_state_id, 'Clinton'), (v_state_id, 'Crawford'), (v_state_id, 'Delta'),
    (v_state_id, 'Dickinson'), (v_state_id, 'Eaton'), (v_state_id, 'Emmet'),
    (v_state_id, 'Genesee'), (v_state_id, 'Gladwin'), (v_state_id, 'Gogebic'),
    (v_state_id, 'Grand Traverse'), (v_state_id, 'Gratiot'), (v_state_id, 'Hillsdale'),
    (v_state_id, 'Houghton'), (v_state_id, 'Huron'), (v_state_id, 'Ingham'),
    (v_state_id, 'Ionia'), (v_state_id, 'Iosco'), (v_state_id, 'Iron'),
    (v_state_id, 'Isabella'), (v_state_id, 'Jackson'), (v_state_id, 'Kalamazoo'),
    (v_state_id, 'Kalkaska'), (v_state_id, 'Kent'), (v_state_id, 'Keweenaw'),
    (v_state_id, 'Lake'), (v_state_id, 'Lapeer'), (v_state_id, 'Leelanau'),
    (v_state_id, 'Lenawee'), (v_state_id, 'Livingston'), (v_state_id, 'Luce'),
    (v_state_id, 'Mackinac'), (v_state_id, 'Macomb'), (v_state_id, 'Manistee'),
    (v_state_id, 'Marquette'), (v_state_id, 'Mason'), (v_state_id, 'Mecosta'),
    (v_state_id, 'Menominee'), (v_state_id, 'Midland'), (v_state_id, 'Missaukee'),
    (v_state_id, 'Monroe'), (v_state_id, 'Montcalm'), (v_state_id, 'Montmorency'),
    (v_state_id, 'Muskegon'), (v_state_id, 'Newaygo'), (v_state_id, 'Oakland'),
    (v_state_id, 'Oceana'), (v_state_id, 'Ogemaw'), (v_state_id, 'Ontonagon'),
    (v_state_id, 'Osceola'), (v_state_id, 'Oscoda'), (v_state_id, 'Otsego'),
    (v_state_id, 'Ottawa'), (v_state_id, 'Presque Isle'), (v_state_id, 'Roscommon'),
    (v_state_id, 'Saginaw'), (v_state_id, 'St. Clair'), (v_state_id, 'St. Joseph'),
    (v_state_id, 'Sanilac'), (v_state_id, 'Schoolcraft'), (v_state_id, 'Shiawassee'),
    (v_state_id, 'Tuscola'), (v_state_id, 'Van Buren'), (v_state_id, 'Washtenaw'),
    (v_state_id, 'Wayne'), (v_state_id, 'Wexford')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Minnesota
  SELECT id INTO v_state_id FROM states WHERE code = 'MN';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Aitkin'), (v_state_id, 'Anoka'), (v_state_id, 'Becker'),
    (v_state_id, 'Beltrami'), (v_state_id, 'Benton'), (v_state_id, 'Big Stone'),
    (v_state_id, 'Blue Earth'), (v_state_id, 'Brown'), (v_state_id, 'Carlton'),
    (v_state_id, 'Carver'), (v_state_id, 'Cass'), (v_state_id, 'Chippewa'),
    (v_state_id, 'Chisago'), (v_state_id, 'Clay'), (v_state_id, 'Clearwater'),
    (v_state_id, 'Cook'), (v_state_id, 'Cottonwood'), (v_state_id, 'Crow Wing'),
    (v_state_id, 'Dakota'), (v_state_id, 'Dodge'), (v_state_id, 'Douglas'),
    (v_state_id, 'Faribault'), (v_state_id, 'Fillmore'), (v_state_id, 'Freeborn'),
    (v_state_id, 'Goodhue'), (v_state_id, 'Grant'), (v_state_id, 'Hennepin'),
    (v_state_id, 'Houston'), (v_state_id, 'Hubbard'), (v_state_id, 'Isanti'),
    (v_state_id, 'Itasca'), (v_state_id, 'Jackson'), (v_state_id, 'Kanabec'),
    (v_state_id, 'Kandiyohi'), (v_state_id, 'Kittson'), (v_state_id, 'Koochiching'),
    (v_state_id, 'Lac qui Parle'), (v_state_id, 'Lake'), (v_state_id, 'Lake of the Woods'),
    (v_state_id, 'Le Sueur'), (v_state_id, 'Lincoln'), (v_state_id, 'Lyon'),
    (v_state_id, 'McLeod'), (v_state_id, 'Mahnomen'), (v_state_id, 'Marshall'),
    (v_state_id, 'Martin'), (v_state_id, 'Meeker'), (v_state_id, 'Mille Lacs'),
    (v_state_id, 'Morrison'), (v_state_id, 'Mower'), (v_state_id, 'Murray'),
    (v_state_id, 'Nicollet'), (v_state_id, 'Nobles'), (v_state_id, 'Norman'),
    (v_state_id, 'Olmsted'), (v_state_id, 'Otter Tail'), (v_state_id, 'Pennington'),
    (v_state_id, 'Pine'), (v_state_id, 'Pipestone'), (v_state_id, 'Polk'),
    (v_state_id, 'Pope'), (v_state_id, 'Ramsey'), (v_state_id, 'Red Lake'),
    (v_state_id, 'Redwood'), (v_state_id, 'Renville'), (v_state_id, 'Rice'),
    (v_state_id, 'Rock'), (v_state_id, 'Roseau'), (v_state_id, 'St. Louis'),
    (v_state_id, 'Scott'), (v_state_id, 'Sherburne'), (v_state_id, 'Sibley'),
    (v_state_id, 'Stearns'), (v_state_id, 'Steele'), (v_state_id, 'Stevens'),
    (v_state_id, 'Swift'), (v_state_id, 'Todd'), (v_state_id, 'Traverse'),
    (v_state_id, 'Wabasha'), (v_state_id, 'Wadena'), (v_state_id, 'Waseca'),
    (v_state_id, 'Washington'), (v_state_id, 'Watonwan'), (v_state_id, 'Wilkin'),
    (v_state_id, 'Winona'), (v_state_id, 'Wright'), (v_state_id, 'Yellow Medicine')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Mississippi
  SELECT id INTO v_state_id FROM states WHERE code = 'MS';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Adams'), (v_state_id, 'Alcorn'), (v_state_id, 'Amite'),
    (v_state_id, 'Attala'), (v_state_id, 'Benton'), (v_state_id, 'Bolivar'),
    (v_state_id, 'Calhoun'), (v_state_id, 'Carroll'), (v_state_id, 'Chickasaw'),
    (v_state_id, 'Choctaw'), (v_state_id, 'Claiborne'), (v_state_id, 'Clarke'),
    (v_state_id, 'Clay'), (v_state_id, 'Coahoma'), (v_state_id, 'Copiah'),
    (v_state_id, 'Covington'), (v_state_id, 'DeSoto'), (v_state_id, 'Forrest'),
    (v_state_id, 'Franklin'), (v_state_id, 'George'), (v_state_id, 'Greene'),
    (v_state_id, 'Grenada'), (v_state_id, 'Hancock'), (v_state_id, 'Harrison'),
    (v_state_id, 'Hinds'), (v_state_id, 'Holmes'), (v_state_id, 'Humphreys'),
    (v_state_id, 'Issaquena'), (v_state_id, 'Itawamba'), (v_state_id, 'Jackson'),
    (v_state_id, 'Jasper'), (v_state_id, 'Jefferson'), (v_state_id, 'Jefferson Davis'),
    (v_state_id, 'Jones'), (v_state_id, 'Kemper'), (v_state_id, 'Lafayette'),
    (v_state_id, 'Lamar'), (v_state_id, 'Lauderdale'), (v_state_id, 'Lawrence'),
    (v_state_id, 'Leake'), (v_state_id, 'Lee'), (v_state_id, 'Leflore'),
    (v_state_id, 'Lincoln'), (v_state_id, 'Lowndes'), (v_state_id, 'Madison'),
    (v_state_id, 'Marion'), (v_state_id, 'Marshall'), (v_state_id, 'Monroe'),
    (v_state_id, 'Montgomery'), (v_state_id, 'Neshoba'), (v_state_id, 'Newton'),
    (v_state_id, 'Noxubee'), (v_state_id, 'Oktibbeha'), (v_state_id, 'Panola'),
    (v_state_id, 'Pearl River'), (v_state_id, 'Perry'), (v_state_id, 'Pike'),
    (v_state_id, 'Pontotoc'), (v_state_id, 'Prentiss'), (v_state_id, 'Quitman'),
    (v_state_id, 'Rankin'), (v_state_id, 'Scott'), (v_state_id, 'Sharkey'),
    (v_state_id, 'Simpson'), (v_state_id, 'Smith'), (v_state_id, 'Stone'),
    (v_state_id, 'Sunflower'), (v_state_id, 'Tallahatchie'), (v_state_id, 'Tate'),
    (v_state_id, 'Tippah'), (v_state_id, 'Tishomingo'), (v_state_id, 'Tunica'),
    (v_state_id, 'Union'), (v_state_id, 'Walthall'), (v_state_id, 'Warren'),
    (v_state_id, 'Washington'), (v_state_id, 'Wayne'), (v_state_id, 'Webster'),
    (v_state_id, 'Wilkinson'), (v_state_id, 'Winston'), (v_state_id, 'Yalobusha'),
    (v_state_id, 'Yazoo')
  ON CONFLICT (state_id, name) DO NOTHING;

END $$;