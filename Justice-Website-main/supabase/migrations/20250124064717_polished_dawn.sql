/*
  # Add More Counties for States

  1. New Data
    - Add counties for Missouri through New Jersey
    - Use v_state_id to avoid ambiguity
    - Preserve existing data with ON CONFLICT

  2. Changes
    - Insert counties for next set of states
    - Use PL/pgSQL variables correctly
*/

DO $$
DECLARE
  v_state_id uuid;
BEGIN
  -- Missouri
  SELECT id INTO v_state_id FROM states WHERE code = 'MO';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Adair'), (v_state_id, 'Andrew'), (v_state_id, 'Atchison'),
    (v_state_id, 'Audrain'), (v_state_id, 'Barry'), (v_state_id, 'Barton'),
    (v_state_id, 'Bates'), (v_state_id, 'Benton'), (v_state_id, 'Bollinger'),
    (v_state_id, 'Boone'), (v_state_id, 'Buchanan'), (v_state_id, 'Butler'),
    (v_state_id, 'Caldwell'), (v_state_id, 'Callaway'), (v_state_id, 'Camden'),
    (v_state_id, 'Cape Girardeau'), (v_state_id, 'Carroll'), (v_state_id, 'Carter'),
    (v_state_id, 'Cass'), (v_state_id, 'Cedar'), (v_state_id, 'Chariton'),
    (v_state_id, 'Christian'), (v_state_id, 'Clark'), (v_state_id, 'Clay'),
    (v_state_id, 'Clinton'), (v_state_id, 'Cole'), (v_state_id, 'Cooper'),
    (v_state_id, 'Crawford'), (v_state_id, 'Dade'), (v_state_id, 'Dallas'),
    (v_state_id, 'Daviess'), (v_state_id, 'DeKalb'), (v_state_id, 'Dent'),
    (v_state_id, 'Douglas'), (v_state_id, 'Dunklin'), (v_state_id, 'Franklin'),
    (v_state_id, 'Gasconade'), (v_state_id, 'Gentry'), (v_state_id, 'Greene'),
    (v_state_id, 'Grundy'), (v_state_id, 'Harrison'), (v_state_id, 'Henry'),
    (v_state_id, 'Hickory'), (v_state_id, 'Holt'), (v_state_id, 'Howard'),
    (v_state_id, 'Howell'), (v_state_id, 'Iron'), (v_state_id, 'Jackson'),
    (v_state_id, 'Jasper'), (v_state_id, 'Jefferson'), (v_state_id, 'Johnson'),
    (v_state_id, 'Knox'), (v_state_id, 'Laclede'), (v_state_id, 'Lafayette'),
    (v_state_id, 'Lawrence'), (v_state_id, 'Lewis'), (v_state_id, 'Lincoln'),
    (v_state_id, 'Linn'), (v_state_id, 'Livingston'), (v_state_id, 'McDonald'),
    (v_state_id, 'Macon'), (v_state_id, 'Madison'), (v_state_id, 'Maries'),
    (v_state_id, 'Marion'), (v_state_id, 'Mercer'), (v_state_id, 'Miller'),
    (v_state_id, 'Mississippi'), (v_state_id, 'Moniteau'), (v_state_id, 'Monroe'),
    (v_state_id, 'Montgomery'), (v_state_id, 'Morgan'), (v_state_id, 'New Madrid'),
    (v_state_id, 'Newton'), (v_state_id, 'Nodaway'), (v_state_id, 'Oregon'),
    (v_state_id, 'Osage'), (v_state_id, 'Ozark'), (v_state_id, 'Pemiscot'),
    (v_state_id, 'Perry'), (v_state_id, 'Pettis'), (v_state_id, 'Phelps'),
    (v_state_id, 'Pike'), (v_state_id, 'Platte'), (v_state_id, 'Polk'),
    (v_state_id, 'Pulaski'), (v_state_id, 'Putnam'), (v_state_id, 'Ralls'),
    (v_state_id, 'Randolph'), (v_state_id, 'Ray'), (v_state_id, 'Reynolds'),
    (v_state_id, 'Ripley'), (v_state_id, 'St. Charles'), (v_state_id, 'St. Clair'),
    (v_state_id, 'St. Francois'), (v_state_id, 'St. Louis'), (v_state_id, 'St. Louis City'),
    (v_state_id, 'Ste. Genevieve'), (v_state_id, 'Saline'), (v_state_id, 'Schuyler'),
    (v_state_id, 'Scotland'), (v_state_id, 'Scott'), (v_state_id, 'Shannon'),
    (v_state_id, 'Shelby'), (v_state_id, 'Stoddard'), (v_state_id, 'Stone'),
    (v_state_id, 'Sullivan'), (v_state_id, 'Taney'), (v_state_id, 'Texas'),
    (v_state_id, 'Vernon'), (v_state_id, 'Warren'), (v_state_id, 'Washington'),
    (v_state_id, 'Wayne'), (v_state_id, 'Webster'), (v_state_id, 'Worth'),
    (v_state_id, 'Wright')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Montana
  SELECT id INTO v_state_id FROM states WHERE code = 'MT';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Beaverhead'), (v_state_id, 'Big Horn'), (v_state_id, 'Blaine'),
    (v_state_id, 'Broadwater'), (v_state_id, 'Carbon'), (v_state_id, 'Carter'),
    (v_state_id, 'Cascade'), (v_state_id, 'Chouteau'), (v_state_id, 'Custer'),
    (v_state_id, 'Daniels'), (v_state_id, 'Dawson'), (v_state_id, 'Deer Lodge'),
    (v_state_id, 'Fallon'), (v_state_id, 'Fergus'), (v_state_id, 'Flathead'),
    (v_state_id, 'Gallatin'), (v_state_id, 'Garfield'), (v_state_id, 'Glacier'),
    (v_state_id, 'Golden Valley'), (v_state_id, 'Granite'), (v_state_id, 'Hill'),
    (v_state_id, 'Jefferson'), (v_state_id, 'Judith Basin'), (v_state_id, 'Lake'),
    (v_state_id, 'Lewis and Clark'), (v_state_id, 'Liberty'), (v_state_id, 'Lincoln'),
    (v_state_id, 'Madison'), (v_state_id, 'McCone'), (v_state_id, 'Meagher'),
    (v_state_id, 'Mineral'), (v_state_id, 'Missoula'), (v_state_id, 'Musselshell'),
    (v_state_id, 'Park'), (v_state_id, 'Petroleum'), (v_state_id, 'Phillips'),
    (v_state_id, 'Pondera'), (v_state_id, 'Powder River'), (v_state_id, 'Powell'),
    (v_state_id, 'Prairie'), (v_state_id, 'Ravalli'), (v_state_id, 'Richland'),
    (v_state_id, 'Roosevelt'), (v_state_id, 'Rosebud'), (v_state_id, 'Sanders'),
    (v_state_id, 'Sheridan'), (v_state_id, 'Silver Bow'), (v_state_id, 'Stillwater'),
    (v_state_id, 'Sweet Grass'), (v_state_id, 'Teton'), (v_state_id, 'Toole'),
    (v_state_id, 'Treasure'), (v_state_id, 'Valley'), (v_state_id, 'Wheatland'),
    (v_state_id, 'Wibaux'), (v_state_id, 'Yellowstone')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Nebraska
  SELECT id INTO v_state_id FROM states WHERE code = 'NE';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Adams'), (v_state_id, 'Antelope'), (v_state_id, 'Arthur'),
    (v_state_id, 'Banner'), (v_state_id, 'Blaine'), (v_state_id, 'Boone'),
    (v_state_id, 'Box Butte'), (v_state_id, 'Boyd'), (v_state_id, 'Brown'),
    (v_state_id, 'Buffalo'), (v_state_id, 'Burt'), (v_state_id, 'Butler'),
    (v_state_id, 'Cass'), (v_state_id, 'Cedar'), (v_state_id, 'Chase'),
    (v_state_id, 'Cherry'), (v_state_id, 'Cheyenne'), (v_state_id, 'Clay'),
    (v_state_id, 'Colfax'), (v_state_id, 'Cuming'), (v_state_id, 'Custer'),
    (v_state_id, 'Dakota'), (v_state_id, 'Dawes'), (v_state_id, 'Dawson'),
    (v_state_id, 'Deuel'), (v_state_id, 'Dixon'), (v_state_id, 'Dodge'),
    (v_state_id, 'Douglas'), (v_state_id, 'Dundy'), (v_state_id, 'Fillmore'),
    (v_state_id, 'Franklin'), (v_state_id, 'Frontier'), (v_state_id, 'Furnas'),
    (v_state_id, 'Gage'), (v_state_id, 'Garden'), (v_state_id, 'Garfield'),
    (v_state_id, 'Gosper'), (v_state_id, 'Grant'), (v_state_id, 'Greeley'),
    (v_state_id, 'Hall'), (v_state_id, 'Hamilton'), (v_state_id, 'Harlan'),
    (v_state_id, 'Hayes'), (v_state_id, 'Hitchcock'), (v_state_id, 'Holt'),
    (v_state_id, 'Hooker'), (v_state_id, 'Howard'), (v_state_id, 'Jefferson'),
    (v_state_id, 'Johnson'), (v_state_id, 'Kearney'), (v_state_id, 'Keith'),
    (v_state_id, 'Keya Paha'), (v_state_id, 'Kimball'), (v_state_id, 'Knox'),
    (v_state_id, 'Lancaster'), (v_state_id, 'Lincoln'), (v_state_id, 'Logan'),
    (v_state_id, 'Loup'), (v_state_id, 'Madison'), (v_state_id, 'McPherson'),
    (v_state_id, 'Merrick'), (v_state_id, 'Morrill'), (v_state_id, 'Nance'),
    (v_state_id, 'Nemaha'), (v_state_id, 'Nuckolls'), (v_state_id, 'Otoe'),
    (v_state_id, 'Pawnee'), (v_state_id, 'Perkins'), (v_state_id, 'Phelps'),
    (v_state_id, 'Pierce'), (v_state_id, 'Platte'), (v_state_id, 'Polk'),
    (v_state_id, 'Red Willow'), (v_state_id, 'Richardson'), (v_state_id, 'Rock'),
    (v_state_id, 'Saline'), (v_state_id, 'Sarpy'), (v_state_id, 'Saunders'),
    (v_state_id, 'Scotts Bluff'), (v_state_id, 'Seward'), (v_state_id, 'Sheridan'),
    (v_state_id, 'Sherman'), (v_state_id, 'Sioux'), (v_state_id, 'Stanton'),
    (v_state_id, 'Thayer'), (v_state_id, 'Thomas'), (v_state_id, 'Thurston'),
    (v_state_id, 'Valley'), (v_state_id, 'Washington'), (v_state_id, 'Wayne'),
    (v_state_id, 'Webster'), (v_state_id, 'Wheeler'), (v_state_id, 'York')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Nevada
  SELECT id INTO v_state_id FROM states WHERE code = 'NV';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Carson City'), (v_state_id, 'Churchill'), (v_state_id, 'Clark'),
    (v_state_id, 'Douglas'), (v_state_id, 'Elko'), (v_state_id, 'Esmeralda'),
    (v_state_id, 'Eureka'), (v_state_id, 'Humboldt'), (v_state_id, 'Lander'),
    (v_state_id, 'Lincoln'), (v_state_id, 'Lyon'), (v_state_id, 'Mineral'),
    (v_state_id, 'Nye'), (v_state_id, 'Pershing'), (v_state_id, 'Storey'),
    (v_state_id, 'Washoe'), (v_state_id, 'White Pine')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- New Hampshire
  SELECT id INTO v_state_id FROM states WHERE code = 'NH';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Belknap'), (v_state_id, 'Carroll'), (v_state_id, 'Cheshire'),
    (v_state_id, 'Coos'), (v_state_id, 'Grafton'), (v_state_id, 'Hillsborough'),
    (v_state_id, 'Merrimack'), (v_state_id, 'Rockingham'), (v_state_id, 'Strafford'),
    (v_state_id, 'Sullivan')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- New Jersey
  SELECT id INTO v_state_id FROM states WHERE code = 'NJ';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Atlantic'), (v_state_id, 'Bergen'), (v_state_id, 'Burlington'),
    (v_state_id, 'Camden'), (v_state_id, 'Cape May'), (v_state_id, 'Cumberland'),
    (v_state_id, 'Essex'), (v_state_id, 'Gloucester'), (v_state_id, 'Hudson'),
    (v_state_id, 'Hunterdon'), (v_state_id, 'Mercer'), (v_state_id, 'Middlesex'),
    (v_state_id, 'Monmouth'), (v_state_id, 'Morris'), (v_state_id, 'Ocean'),
    (v_state_id, 'Passaic'), (v_state_id, 'Salem'), (v_state_id, 'Somerset'),
    (v_state_id, 'Sussex'), (v_state_id, 'Union'), (v_state_id, 'Warren')
  ON CONFLICT (state_id, name) DO NOTHING;

END $$;