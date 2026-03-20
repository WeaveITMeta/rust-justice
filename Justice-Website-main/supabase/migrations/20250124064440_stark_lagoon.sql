/*
  # Add More Counties for States

  1. New Data
    - Add counties for Hawaii through Maine
    - Use v_state_id to avoid ambiguity
    - Preserve existing data with ON CONFLICT

  2. Changes
    - Insert counties for each state
    - Use PL/pgSQL variables correctly
*/

DO $$
DECLARE
  v_state_id uuid;
BEGIN
  -- Hawaii
  SELECT id INTO v_state_id FROM states WHERE code = 'HI';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Hawaii'), (v_state_id, 'Kalawao'), (v_state_id, 'Kauai'),
    (v_state_id, 'Maui')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Idaho
  SELECT id INTO v_state_id FROM states WHERE code = 'ID';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Adams'), (v_state_id, 'Bannock'), (v_state_id, 'Bear Lake'),
    (v_state_id, 'Benewah'), (v_state_id, 'Bingham'), (v_state_id, 'Blaine'),
    (v_state_id, 'Boise'), (v_state_id, 'Bonner'), (v_state_id, 'Bonneville'),
    (v_state_id, 'Boundary'), (v_state_id, 'Butte'), (v_state_id, 'Camas'),
    (v_state_id, 'Canyon'), (v_state_id, 'Caribou'), (v_state_id, 'Cassia'),
    (v_state_id, 'Clark'), (v_state_id, 'Clearwater'), (v_state_id, 'Custer'),
    (v_state_id, 'Elmore'), (v_state_id, 'Franklin'), (v_state_id, 'Fremont'),
    (v_state_id, 'Gem'), (v_state_id, 'Gooding'), (v_state_id, 'Idaho'),
    (v_state_id, 'Jefferson'), (v_state_id, 'Jerome'), (v_state_id, 'Kootenai'),
    (v_state_id, 'Latah'), (v_state_id, 'Lemhi'), (v_state_id, 'Lewis'),
    (v_state_id, 'Lincoln'), (v_state_id, 'Madison'), (v_state_id, 'Minidoka'),
    (v_state_id, 'Nez Perce'), (v_state_id, 'Oneida'), (v_state_id, 'Owyhee'),
    (v_state_id, 'Payette'), (v_state_id, 'Power'), (v_state_id, 'Shoshone'),
    (v_state_id, 'Teton'), (v_state_id, 'Twin Falls'), (v_state_id, 'Valley'),
    (v_state_id, 'Washington')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Illinois
  SELECT id INTO v_state_id FROM states WHERE code = 'IL';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Adams'), (v_state_id, 'Alexander'), (v_state_id, 'Bond'),
    (v_state_id, 'Boone'), (v_state_id, 'Brown'), (v_state_id, 'Bureau'),
    (v_state_id, 'Calhoun'), (v_state_id, 'Carroll'), (v_state_id, 'Cass'),
    (v_state_id, 'Champaign'), (v_state_id, 'Christian'), (v_state_id, 'Clark'),
    (v_state_id, 'Clay'), (v_state_id, 'Clinton'), (v_state_id, 'Coles'),
    (v_state_id, 'Crawford'), (v_state_id, 'Cumberland'), (v_state_id, 'DeKalb'),
    (v_state_id, 'De Witt'), (v_state_id, 'Douglas'), (v_state_id, 'DuPage'),
    (v_state_id, 'Edgar'), (v_state_id, 'Edwards'), (v_state_id, 'Effingham'),
    (v_state_id, 'Fayette'), (v_state_id, 'Ford'), (v_state_id, 'Franklin'),
    (v_state_id, 'Fulton'), (v_state_id, 'Gallatin'), (v_state_id, 'Greene'),
    (v_state_id, 'Grundy'), (v_state_id, 'Hamilton'), (v_state_id, 'Hancock'),
    (v_state_id, 'Hardin'), (v_state_id, 'Henderson'), (v_state_id, 'Henry'),
    (v_state_id, 'Iroquois'), (v_state_id, 'Jackson'), (v_state_id, 'Jasper'),
    (v_state_id, 'Jefferson'), (v_state_id, 'Jersey'), (v_state_id, 'Jo Daviess'),
    (v_state_id, 'Johnson'), (v_state_id, 'Kane'), (v_state_id, 'Kankakee'),
    (v_state_id, 'Kendall'), (v_state_id, 'Knox'), (v_state_id, 'Lake'),
    (v_state_id, 'LaSalle'), (v_state_id, 'Lawrence'), (v_state_id, 'Lee'),
    (v_state_id, 'Livingston'), (v_state_id, 'Logan'), (v_state_id, 'McDonough'),
    (v_state_id, 'McHenry'), (v_state_id, 'McLean'), (v_state_id, 'Macon'),
    (v_state_id, 'Macoupin'), (v_state_id, 'Madison'), (v_state_id, 'Marion'),
    (v_state_id, 'Marshall'), (v_state_id, 'Mason'), (v_state_id, 'Massac'),
    (v_state_id, 'Menard'), (v_state_id, 'Mercer'), (v_state_id, 'Monroe'),
    (v_state_id, 'Montgomery'), (v_state_id, 'Morgan'), (v_state_id, 'Moultrie'),
    (v_state_id, 'Ogle'), (v_state_id, 'Peoria'), (v_state_id, 'Perry'),
    (v_state_id, 'Piatt'), (v_state_id, 'Pike'), (v_state_id, 'Pope'),
    (v_state_id, 'Pulaski'), (v_state_id, 'Putnam'), (v_state_id, 'Randolph'),
    (v_state_id, 'Richland'), (v_state_id, 'Rock Island'), (v_state_id, 'St. Clair'),
    (v_state_id, 'Saline'), (v_state_id, 'Sangamon'), (v_state_id, 'Schuyler'),
    (v_state_id, 'Scott'), (v_state_id, 'Shelby'), (v_state_id, 'Stark'),
    (v_state_id, 'Stephenson'), (v_state_id, 'Tazewell'), (v_state_id, 'Union'),
    (v_state_id, 'Vermilion'), (v_state_id, 'Wabash'), (v_state_id, 'Warren'),
    (v_state_id, 'Washington'), (v_state_id, 'Wayne'), (v_state_id, 'White'),
    (v_state_id, 'Whiteside'), (v_state_id, 'Will'), (v_state_id, 'Williamson'),
    (v_state_id, 'Winnebago'), (v_state_id, 'Woodford')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Indiana
  SELECT id INTO v_state_id FROM states WHERE code = 'IN';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Adams'), (v_state_id, 'Allen'), (v_state_id, 'Bartholomew'),
    (v_state_id, 'Benton'), (v_state_id, 'Blackford'), (v_state_id, 'Boone'),
    (v_state_id, 'Brown'), (v_state_id, 'Carroll'), (v_state_id, 'Cass'),
    (v_state_id, 'Clark'), (v_state_id, 'Clay'), (v_state_id, 'Clinton'),
    (v_state_id, 'Crawford'), (v_state_id, 'Daviess'), (v_state_id, 'Dearborn'),
    (v_state_id, 'Decatur'), (v_state_id, 'DeKalb'), (v_state_id, 'Delaware'),
    (v_state_id, 'Dubois'), (v_state_id, 'Elkhart'), (v_state_id, 'Fayette'),
    (v_state_id, 'Floyd'), (v_state_id, 'Fountain'), (v_state_id, 'Franklin'),
    (v_state_id, 'Fulton'), (v_state_id, 'Gibson'), (v_state_id, 'Grant'),
    (v_state_id, 'Greene'), (v_state_id, 'Hamilton'), (v_state_id, 'Hancock'),
    (v_state_id, 'Harrison'), (v_state_id, 'Hendricks'), (v_state_id, 'Henry'),
    (v_state_id, 'Howard'), (v_state_id, 'Huntington'), (v_state_id, 'Jackson'),
    (v_state_id, 'Jasper'), (v_state_id, 'Jay'), (v_state_id, 'Jefferson'),
    (v_state_id, 'Jennings'), (v_state_id, 'Johnson'), (v_state_id, 'Knox'),
    (v_state_id, 'Kosciusko'), (v_state_id, 'LaGrange'), (v_state_id, 'Lake'),
    (v_state_id, 'LaPorte'), (v_state_id, 'Lawrence'), (v_state_id, 'Madison'),
    (v_state_id, 'Marshall'), (v_state_id, 'Martin'), (v_state_id, 'Miami'),
    (v_state_id, 'Monroe'), (v_state_id, 'Montgomery'), (v_state_id, 'Morgan'),
    (v_state_id, 'Newton'), (v_state_id, 'Noble'), (v_state_id, 'Ohio'),
    (v_state_id, 'Orange'), (v_state_id, 'Owen'), (v_state_id, 'Parke'),
    (v_state_id, 'Perry'), (v_state_id, 'Pike'), (v_state_id, 'Porter'),
    (v_state_id, 'Posey'), (v_state_id, 'Pulaski'), (v_state_id, 'Putnam'),
    (v_state_id, 'Randolph'), (v_state_id, 'Ripley'), (v_state_id, 'Rush'),
    (v_state_id, 'St. Joseph'), (v_state_id, 'Scott'), (v_state_id, 'Shelby'),
    (v_state_id, 'Spencer'), (v_state_id, 'Starke'), (v_state_id, 'Steuben'),
    (v_state_id, 'Sullivan'), (v_state_id, 'Switzerland'), (v_state_id, 'Tippecanoe'),
    (v_state_id, 'Tipton'), (v_state_id, 'Union'), (v_state_id, 'Vanderburgh'),
    (v_state_id, 'Vermillion'), (v_state_id, 'Vigo'), (v_state_id, 'Wabash'),
    (v_state_id, 'Warren'), (v_state_id, 'Warrick'), (v_state_id, 'Washington'),
    (v_state_id, 'Wayne'), (v_state_id, 'Wells'), (v_state_id, 'White'),
    (v_state_id, 'Whitley')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Iowa
  SELECT id INTO v_state_id FROM states WHERE code = 'IA';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Adair'), (v_state_id, 'Adams'), (v_state_id, 'Allamakee'),
    (v_state_id, 'Appanoose'), (v_state_id, 'Audubon'), (v_state_id, 'Benton'),
    (v_state_id, 'Black Hawk'), (v_state_id, 'Boone'), (v_state_id, 'Bremer'),
    (v_state_id, 'Buchanan'), (v_state_id, 'Buena Vista'), (v_state_id, 'Butler'),
    (v_state_id, 'Calhoun'), (v_state_id, 'Carroll'), (v_state_id, 'Cass'),
    (v_state_id, 'Cedar'), (v_state_id, 'Cerro Gordo'), (v_state_id, 'Cherokee'),
    (v_state_id, 'Chickasaw'), (v_state_id, 'Clarke'), (v_state_id, 'Clay'),
    (v_state_id, 'Clayton'), (v_state_id, 'Clinton'), (v_state_id, 'Crawford'),
    (v_state_id, 'Dallas'), (v_state_id, 'Davis'), (v_state_id, 'Decatur'),
    (v_state_id, 'Delaware'), (v_state_id, 'Des Moines'), (v_state_id, 'Dickinson'),
    (v_state_id, 'Dubuque'), (v_state_id, 'Emmet'), (v_state_id, 'Fayette'),
    (v_state_id, 'Floyd'), (v_state_id, 'Franklin'), (v_state_id, 'Fremont'),
    (v_state_id, 'Greene'), (v_state_id, 'Grundy'), (v_state_id, 'Guthrie'),
    (v_state_id, 'Hamilton'), (v_state_id, 'Hancock'), (v_state_id, 'Hardin'),
    (v_state_id, 'Harrison'), (v_state_id, 'Henry'), (v_state_id, 'Howard'),
    (v_state_id, 'Humboldt'), (v_state_id, 'Ida'), (v_state_id, 'Iowa'),
    (v_state_id, 'Jackson'), (v_state_id, 'Jasper'), (v_state_id, 'Jefferson'),
    (v_state_id, 'Johnson'), (v_state_id, 'Jones'), (v_state_id, 'Keokuk'),
    (v_state_id, 'Kossuth'), (v_state_id, 'Lee'), (v_state_id, 'Linn'),
    (v_state_id, 'Louisa'), (v_state_id, 'Lucas'), (v_state_id, 'Lyon'),
    (v_state_id, 'Madison'), (v_state_id, 'Mahaska'), (v_state_id, 'Marion'),
    (v_state_id, 'Marshall'), (v_state_id, 'Mills'), (v_state_id, 'Mitchell'),
    (v_state_id, 'Monona'), (v_state_id, 'Monroe'), (v_state_id, 'Montgomery'),
    (v_state_id, 'Muscatine'), (v_state_id, 'O''Brien'), (v_state_id, 'Osceola'),
    (v_state_id, 'Page'), (v_state_id, 'Palo Alto'), (v_state_id, 'Plymouth'),
    (v_state_id, 'Pocahontas'), (v_state_id, 'Polk'), (v_state_id, 'Pottawattamie'),
    (v_state_id, 'Poweshiek'), (v_state_id, 'Ringgold'), (v_state_id, 'Sac'),
    (v_state_id, 'Scott'), (v_state_id, 'Shelby'), (v_state_id, 'Sioux'),
    (v_state_id, 'Story'), (v_state_id, 'Tama'), (v_state_id, 'Taylor'),
    (v_state_id, 'Union'), (v_state_id, 'Van Buren'), (v_state_id, 'Wapello'),
    (v_state_id, 'Warren'), (v_state_id, 'Washington'), (v_state_id, 'Wayne'),
    (v_state_id, 'Webster'), (v_state_id, 'Winnebago'), (v_state_id, 'Winneshiek'),
    (v_state_id, 'Woodbury'), (v_state_id, 'Worth'), (v_state_id, 'Wright')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Maine
  SELECT id INTO v_state_id FROM states WHERE code = 'ME';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Androscoggin'), (v_state_id, 'Aroostook'), (v_state_id, 'Cumberland'),
    (v_state_id, 'Franklin'), (v_state_id, 'Hancock'), (v_state_id, 'Kennebec'),
    (v_state_id, 'Knox'), (v_state_id, 'Lincoln'), (v_state_id, 'Oxford'),
    (v_state_id, 'Penobscot'), (v_state_id, 'Piscataquis'), (v_state_id, 'Sagadahoc'),
    (v_state_id, 'Somerset'), (v_state_id, 'Waldo'), (v_state_id, 'Washington'),
    (v_state_id, 'York')
  ON CONFLICT (state_id, name) DO NOTHING;

END $$;