DO $$
DECLARE
  v_state_id uuid;
BEGIN
  -- Oklahoma
  SELECT id INTO v_state_id FROM states WHERE code = 'OK';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Adair'), (v_state_id, 'Alfalfa'), (v_state_id, 'Atoka'),
    (v_state_id, 'Beaver'), (v_state_id, 'Beckham'), (v_state_id, 'Blaine'),
    (v_state_id, 'Bryan'), (v_state_id, 'Caddo'), (v_state_id, 'Canadian'),
    (v_state_id, 'Carter'), (v_state_id, 'Cherokee'), (v_state_id, 'Choctaw'),
    (v_state_id, 'Cimarron'), (v_state_id, 'Cleveland'), (v_state_id, 'Coal'),
    (v_state_id, 'Comanche'), (v_state_id, 'Cotton'), (v_state_id, 'Craig'),
    (v_state_id, 'Creek'), (v_state_id, 'Custer'), (v_state_id, 'Delaware'),
    (v_state_id, 'Dewey'), (v_state_id, 'Ellis'), (v_state_id, 'Garfield'),
    (v_state_id, 'Garvin'), (v_state_id, 'Grady'), (v_state_id, 'Grant'),
    (v_state_id, 'Greer'), (v_state_id, 'Harmon'), (v_state_id, 'Harper'),
    (v_state_id, 'Haskell'), (v_state_id, 'Hughes'), (v_state_id, 'Jackson'),
    (v_state_id, 'Jefferson'), (v_state_id, 'Johnston'), (v_state_id, 'Kay'),
    (v_state_id, 'Kingfisher'), (v_state_id, 'Kiowa'), (v_state_id, 'Latimer'),
    (v_state_id, 'Le Flore'), (v_state_id, 'Lincoln'), (v_state_id, 'Logan'),
    (v_state_id, 'Love'), (v_state_id, 'Major'), (v_state_id, 'Marshall'),
    (v_state_id, 'Mayes'), (v_state_id, 'McClain'), (v_state_id, 'McCurtain'),
    (v_state_id, 'McIntosh'), (v_state_id, 'Murray'), (v_state_id, 'Muskogee'),
    (v_state_id, 'Noble'), (v_state_id, 'Nowata'), (v_state_id, 'Okfuskee'),
    (v_state_id, 'Oklahoma'), (v_state_id, 'Okmulgee'), (v_state_id, 'Osage'),
    (v_state_id, 'Ottawa'), (v_state_id, 'Pawnee'), (v_state_id, 'Payne'),
    (v_state_id, 'Pittsburg'), (v_state_id, 'Pontotoc'), (v_state_id, 'Pottawatomie'),
    (v_state_id, 'Pushmataha'), (v_state_id, 'Roger Mills'), (v_state_id, 'Rogers'),
    (v_state_id, 'Seminole'), (v_state_id, 'Sequoyah'), (v_state_id, 'Stephens'),
    (v_state_id, 'Texas'), (v_state_id, 'Tillman'), (v_state_id, 'Tulsa'),
    (v_state_id, 'Wagoner'), (v_state_id, 'Washington'), (v_state_id, 'Washita'),
    (v_state_id, 'Woods'), (v_state_id, 'Woodward')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Oregon
  SELECT id INTO v_state_id FROM states WHERE code = 'OR';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Baker'), (v_state_id, 'Benton'), (v_state_id, 'Clackamas'),
    (v_state_id, 'Clatsop'), (v_state_id, 'Columbia'), (v_state_id, 'Coos'),
    (v_state_id, 'Crook'), (v_state_id, 'Curry'), (v_state_id, 'Deschutes'),
    (v_state_id, 'Douglas'), (v_state_id, 'Gilliam'), (v_state_id, 'Grant'),
    (v_state_id, 'Harney'), (v_state_id, 'Hood River'), (v_state_id, 'Jackson'),
    (v_state_id, 'Jefferson'), (v_state_id, 'Josephine'), (v_state_id, 'Klamath'),
    (v_state_id, 'Lake'), (v_state_id, 'Lane'), (v_state_id, 'Lincoln'),
    (v_state_id, 'Linn'), (v_state_id, 'Malheur'), (v_state_id, 'Marion'),
    (v_state_id, 'Morrow'), (v_state_id, 'Multnomah'), (v_state_id, 'Polk'),
    (v_state_id, 'Sherman'), (v_state_id, 'Tillamook'), (v_state_id, 'Umatilla'),
    (v_state_id, 'Union'), (v_state_id, 'Wallowa'), (v_state_id, 'Wasco'),
    (v_state_id, 'Washington'), (v_state_id, 'Wheeler'), (v_state_id, 'Yamhill')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Pennsylvania
  SELECT id INTO v_state_id FROM states WHERE code = 'PA';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Adams'), (v_state_id, 'Allegheny'), (v_state_id, 'Armstrong'),
    (v_state_id, 'Beaver'), (v_state_id, 'Bedford'), (v_state_id, 'Berks'),
    (v_state_id, 'Blair'), (v_state_id, 'Bradford'), (v_state_id, 'Bucks'),
    (v_state_id, 'Butler'), (v_state_id, 'Cambria'), (v_state_id, 'Cameron'),
    (v_state_id, 'Carbon'), (v_state_id, 'Centre'), (v_state_id, 'Chester'),
    (v_state_id, 'Clarion'), (v_state_id, 'Clearfield'), (v_state_id, 'Clinton'),
    (v_state_id, 'Columbia'), (v_state_id, 'Crawford'), (v_state_id, 'Cumberland'),
    (v_state_id, 'Dauphin'), (v_state_id, 'Delaware'), (v_state_id, 'Elk'),
    (v_state_id, 'Erie'), (v_state_id, 'Fayette'), (v_state_id, 'Forest'),
    (v_state_id, 'Franklin'), (v_state_id, 'Fulton'), (v_state_id, 'Greene'),
    (v_state_id, 'Huntingdon'), (v_state_id, 'Indiana'), (v_state_id, 'Jefferson'),
    (v_state_id, 'Juniata'), (v_state_id, 'Lackawanna'), (v_state_id, 'Lancaster'),
    (v_state_id, 'Lawrence'), (v_state_id, 'Lebanon'), (v_state_id, 'Lehigh'),
    (v_state_id, 'Luzerne'), (v_state_id, 'Lycoming'), (v_state_id, 'McKean'),
    (v_state_id, 'Mercer'), (v_state_id, 'Mifflin'), (v_state_id, 'Monroe'),
    (v_state_id, 'Montgomery'), (v_state_id, 'Montour'), (v_state_id, 'Northampton'),
    (v_state_id, 'Northumberland'), (v_state_id, 'Perry'), (v_state_id, 'Philadelphia'),
    (v_state_id, 'Pike'), (v_state_id, 'Potter'), (v_state_id, 'Schuylkill'),
    (v_state_id, 'Snyder'), (v_state_id, 'Somerset'), (v_state_id, 'Sullivan'),
    (v_state_id, 'Susquehanna'), (v_state_id, 'Tioga'), (v_state_id, 'Union'),
    (v_state_id, 'Venango'), (v_state_id, 'Warren'), (v_state_id, 'Washington'),
    (v_state_id, 'Wayne'), (v_state_id, 'Westmoreland'), (v_state_id, 'Wyoming'),
    (v_state_id, 'York')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Rhode Island
  SELECT id INTO v_state_id FROM states WHERE code = 'RI';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Bristol'), (v_state_id, 'Kent'), (v_state_id, 'Newport'),
    (v_state_id, 'Providence'), (v_state_id, 'Washington')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- South Carolina
  SELECT id INTO v_state_id FROM states WHERE code = 'SC';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Abbeville'), (v_state_id, 'Aiken'), (v_state_id, 'Allendale'),
    (v_state_id, 'Anderson'), (v_state_id, 'Bamberg'), (v_state_id, 'Barnwell'),
    (v_state_id, 'Beaufort'), (v_state_id, 'Berkeley'), (v_state_id, 'Calhoun'),
    (v_state_id, 'Charleston'), (v_state_id, 'Cherokee'), (v_state_id, 'Chester'),
    (v_state_id, 'Chesterfield'), (v_state_id, 'Clarendon'), (v_state_id, 'Colleton'),
    (v_state_id, 'Darlington'), (v_state_id, 'Dillon'), (v_state_id, 'Dorchester'),
    (v_state_id, 'Edgefield'), (v_state_id, 'Fairfield'), (v_state_id, 'Florence'),
    (v_state_id, 'Georgetown'), (v_state_id, 'Greenville'), (v_state_id, 'Greenwood'),
    (v_state_id, 'Hampton'), (v_state_id, 'Horry'), (v_state_id, 'Jasper'),
    (v_state_id, 'Kershaw'), (v_state_id, 'Lancaster'), (v_state_id, 'Laurens'),
    (v_state_id, 'Lee'), (v_state_id, 'Lexington'), (v_state_id, 'Marion'),
    (v_state_id, 'Marlboro'), (v_state_id, 'McCormick'), (v_state_id, 'Newberry'),
    (v_state_id, 'Oconee'), (v_state_id, 'Orangeburg'), (v_state_id, 'Pickens'),
    (v_state_id, 'Richland'), (v_state_id, 'Saluda'), (v_state_id, 'Spartanburg'),
    (v_state_id, 'Sumter'), (v_state_id, 'Union'), (v_state_id, 'Williamsburg'),
    (v_state_id, 'York')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- South Dakota
  SELECT id INTO v_state_id FROM states WHERE code = 'SD';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Aurora'), (v_state_id, 'Beadle'), (v_state_id, 'Bennett'),
    (v_state_id, 'Bon Homme'), (v_state_id, 'Brookings'), (v_state_id, 'Brown'),
    (v_state_id, 'Brule'), (v_state_id, 'Buffalo'), (v_state_id, 'Butte'),
    (v_state_id, 'Campbell'), (v_state_id, 'Charles Mix'), (v_state_id, 'Clark'),
    (v_state_id, 'Clay'), (v_state_id, 'Codington'), (v_state_id, 'Corson'),
    (v_state_id, 'Custer'), (v_state_id, 'Davison'), (v_state_id, 'Day'),
    (v_state_id, 'Deuel'), (v_state_id, 'Dewey'), (v_state_id, 'Douglas'),
    (v_state_id, 'Edmunds'), (v_state_id, 'Fall River'), (v_state_id, 'Faulk'),
    (v_state_id, 'Grant'), (v_state_id, 'Gregory'), (v_state_id, 'Haakon'),
    (v_state_id, 'Hamlin'), (v_state_id, 'Hand'), (v_state_id, 'Hanson'),
    (v_state_id, 'Harding'), (v_state_id, 'Hughes'), (v_state_id, 'Hutchinson'),
    (v_state_id, 'Hyde'), (v_state_id, 'Jackson'), (v_state_id, 'Jerauld'),
    (v_state_id, 'Jones'), (v_state_id, 'Kingsbury'), (v_state_id, 'Lake'),
    (v_state_id, 'Lawrence'), (v_state_id, 'Lincoln'), (v_state_id, 'Lyman'),
    (v_state_id, 'Marshall'), (v_state_id, 'McCook'), (v_state_id, 'McPherson'),
    (v_state_id, 'Meade'), (v_state_id, 'Mellette'), (v_state_id, 'Miner'),
    (v_state_id, 'Minnehaha'), (v_state_id, 'Moody'), (v_state_id, 'Oglala Lakota'),
    (v_state_id, 'Pennington'), (v_state_id, 'Perkins'), (v_state_id, 'Potter'),
    (v_state_id, 'Roberts'), (v_state_id, 'Sanborn'), (v_state_id, 'Spink'),
    (v_state_id, 'Stanley'), (v_state_id, 'Sully'), (v_state_id, 'Todd'),
    (v_state_id, 'Tripp'), (v_state_id, 'Turner'), (v_state_id, 'Union'),
    (v_state_id, 'Walworth'), (v_state_id, 'Yankton'), (v_state_id, 'Ziebach')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Tennessee
  SELECT id INTO v_state_id FROM states WHERE code = 'TN';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Anderson'), (v_state_id, 'Bedford'), (v_state_id, 'Benton'),
    (v_state_id, 'Bledsoe'), (v_state_id, 'Blount'), (v_state_id, 'Bradley'),
    (v_state_id, 'Campbell'), (v_state_id, 'Cannon'), (v_state_id, 'Carroll'),
    (v_state_id, 'Carter'), (v_state_id, 'Cheatham'), (v_state_id, 'Chester'),
    (v_state_id, 'Claiborne'), (v_state_id, 'Clay'), (v_state_id, 'Cocke'),
    (v_state_id, 'Coffee'), (v_state_id, 'Crockett'), (v_state_id, 'Cumberland'),
    (v_state_id, 'Davidson'), (v_state_id, 'Decatur'), (v_state_id, 'DeKalb'),
    (v_state_id, 'Dickson'), (v_state_id, 'Dyer'), (v_state_id, 'Fayette'),
    (v_state_id, 'Fentress'), (v_state_id, 'Franklin'), (v_state_id, 'Gibson'),
    (v_state_id, 'Giles'), (v_state_id, 'Grainger'), (v_state_id, 'Greene'),
    (v_state_id, 'Grundy'), (v_state_id, 'Hamblen'), (v_state_id, 'Hamilton'),
    (v_state_id, 'Hancock'), (v_state_id, 'Hardeman'), (v_state_id, 'Hardin'),
    (v_state_id, 'Hawkins'), (v_state_id, 'Haywood'), (v_state_id, 'Henderson'),
    (v_state_id, 'Henry'), (v_state_id, 'Hickman'), (v_state_id, 'Houston'),
    (v_state_id, 'Humphreys'), (v_state_id, 'Jackson'), (v_state_id, 'Jefferson'),
    (v_state_id, 'Johnson'), (v_state_id, 'Knox'), (v_state_id, 'Lake'),
    (v_state_id, 'Lauderdale'), (v_state_id, 'Lawrence'), (v_state_id, 'Lewis'),
    (v_state_id, 'Lincoln'), (v_state_id, 'Loudon'), (v_state_id, 'Macon'),
    (v_state_id, 'Madison'), (v_state_id, 'Marion'), (v_state_id, 'Marshall'),
    (v_state_id, 'Maury'), (v_state_id, 'McMinn'), (v_state_id, 'McNairy'),
    (v_state_id, 'Meigs'), (v_state_id, 'Monroe'), (v_state_id, 'Montgomery'),
    (v_state_id, 'Moore'), (v_state_id, 'Morgan'), (v_state_id, 'Obion'),
    (v_state_id, 'Overton'), (v_state_id, 'Perry'), (v_state_id, 'Pickett'),
    (v_state_id, 'Polk'), (v_state_id, 'Putnam'), (v_state_id, 'Rhea'),
    (v_state_id, 'Roane'), (v_state_id, 'Robertson'), (v_state_id, 'Rutherford'),
    (v_state_id, 'Scott'), (v_state_id, 'Sequatchie'), (v_state_id, 'Sevier'),
    (v_state_id, 'Shelby'), (v_state_id, 'Smith'), (v_state_id, 'Stewart'),
    (v_state_id, 'Sullivan'), (v_state_id, 'Sumner'), (v_state_id, 'Tipton'),
    (v_state_id, 'Trousdale'), (v_state_id, 'Unicoi'), (v_state_id, 'Union'),
    (v_state_id, 'Van Buren'), (v_state_id, 'Warren'), (v_state_id, 'Washington'),
    (v_state_id, 'Wayne'), (v_state_id, 'Weakley'), (v_state_id, 'White'),
    (v_state_id, 'Williamson'), (v_state_id, 'Wilson')
  ON CONFLICT (state_id, name) DO NOTHING;

END $$;