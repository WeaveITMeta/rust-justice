/*
  # Add More Counties for States

  1. New Data
    - Add counties for California through Georgia
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
  -- California
  SELECT id INTO v_state_id FROM states WHERE code = 'CA';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Alameda'), (v_state_id, 'Alpine'), (v_state_id, 'Amador'),
    (v_state_id, 'Butte'), (v_state_id, 'Calaveras'), (v_state_id, 'Colusa'),
    (v_state_id, 'Contra Costa'), (v_state_id, 'Del Norte'), (v_state_id, 'El Dorado'),
    (v_state_id, 'Fresno'), (v_state_id, 'Glenn'), (v_state_id, 'Humboldt'),
    (v_state_id, 'Imperial'), (v_state_id, 'Inyo'), (v_state_id, 'Kern'),
    (v_state_id, 'Kings'), (v_state_id, 'Lake'), (v_state_id, 'Lassen'),
    (v_state_id, 'Los Angeles'), (v_state_id, 'Madera'), (v_state_id, 'Marin'),
    (v_state_id, 'Mariposa'), (v_state_id, 'Mendocino'), (v_state_id, 'Merced'),
    (v_state_id, 'Modoc'), (v_state_id, 'Mono'), (v_state_id, 'Monterey'),
    (v_state_id, 'Napa'), (v_state_id, 'Nevada'), (v_state_id, 'Orange'),
    (v_state_id, 'Placer'), (v_state_id, 'Plumas'), (v_state_id, 'Riverside'),
    (v_state_id, 'Sacramento'), (v_state_id, 'San Benito'), (v_state_id, 'San Bernardino'),
    (v_state_id, 'San Diego'), (v_state_id, 'San Francisco'), (v_state_id, 'San Joaquin'),
    (v_state_id, 'San Luis Obispo'), (v_state_id, 'San Mateo'), (v_state_id, 'Santa Barbara'),
    (v_state_id, 'Santa Clara'), (v_state_id, 'Santa Cruz'), (v_state_id, 'Shasta'),
    (v_state_id, 'Sierra'), (v_state_id, 'Siskiyou'), (v_state_id, 'Solano'),
    (v_state_id, 'Sonoma'), (v_state_id, 'Stanislaus'), (v_state_id, 'Sutter'),
    (v_state_id, 'Tehama'), (v_state_id, 'Trinity'), (v_state_id, 'Tulare'),
    (v_state_id, 'Tuolumne'), (v_state_id, 'Ventura'), (v_state_id, 'Yolo'),
    (v_state_id, 'Yuba')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Colorado
  SELECT id INTO v_state_id FROM states WHERE code = 'CO';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Adams'), (v_state_id, 'Alamosa'), (v_state_id, 'Arapahoe'),
    (v_state_id, 'Archuleta'), (v_state_id, 'Baca'), (v_state_id, 'Bent'),
    (v_state_id, 'Boulder'), (v_state_id, 'Broomfield'), (v_state_id, 'Chaffee'),
    (v_state_id, 'Cheyenne'), (v_state_id, 'Clear Creek'), (v_state_id, 'Conejos'),
    (v_state_id, 'Costilla'), (v_state_id, 'Crowley'), (v_state_id, 'Custer'),
    (v_state_id, 'Delta'), (v_state_id, 'Denver'), (v_state_id, 'Dolores'),
    (v_state_id, 'Douglas'), (v_state_id, 'Eagle'), (v_state_id, 'El Paso'),
    (v_state_id, 'Elbert'), (v_state_id, 'Fremont'), (v_state_id, 'Garfield'),
    (v_state_id, 'Gilpin'), (v_state_id, 'Grand'), (v_state_id, 'Gunnison'),
    (v_state_id, 'Hinsdale'), (v_state_id, 'Huerfano'), (v_state_id, 'Jackson'),
    (v_state_id, 'Jefferson'), (v_state_id, 'Kiowa'), (v_state_id, 'Kit Carson'),
    (v_state_id, 'La Plata'), (v_state_id, 'Lake'), (v_state_id, 'Larimer'),
    (v_state_id, 'Las Animas'), (v_state_id, 'Lincoln'), (v_state_id, 'Logan'),
    (v_state_id, 'Mesa'), (v_state_id, 'Mineral'), (v_state_id, 'Moffat'),
    (v_state_id, 'Montezuma'), (v_state_id, 'Montrose'), (v_state_id, 'Morgan'),
    (v_state_id, 'Otero'), (v_state_id, 'Ouray'), (v_state_id, 'Park'),
    (v_state_id, 'Phillips'), (v_state_id, 'Pitkin'), (v_state_id, 'Prowers'),
    (v_state_id, 'Pueblo'), (v_state_id, 'Rio Blanco'), (v_state_id, 'Rio Grande'),
    (v_state_id, 'Routt'), (v_state_id, 'Saguache'), (v_state_id, 'San Juan'),
    (v_state_id, 'San Miguel'), (v_state_id, 'Sedgwick'), (v_state_id, 'Summit'),
    (v_state_id, 'Teller'), (v_state_id, 'Washington'), (v_state_id, 'Weld'),
    (v_state_id, 'Yuma')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Connecticut
  SELECT id INTO v_state_id FROM states WHERE code = 'CT';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Fairfield'), (v_state_id, 'Hartford'), (v_state_id, 'Litchfield'),
    (v_state_id, 'Middlesex'), (v_state_id, 'New Haven'), (v_state_id, 'New London'),
    (v_state_id, 'Tolland'), (v_state_id, 'Windham')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Delaware
  SELECT id INTO v_state_id FROM states WHERE code = 'DE';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Kent'), (v_state_id, 'New Castle'), (v_state_id, 'Sussex')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Florida
  SELECT id INTO v_state_id FROM states WHERE code = 'FL';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Alachua'), (v_state_id, 'Baker'), (v_state_id, 'Bay'),
    (v_state_id, 'Bradford'), (v_state_id, 'Brevard'), (v_state_id, 'Broward'),
    (v_state_id, 'Calhoun'), (v_state_id, 'Charlotte'), (v_state_id, 'Citrus'),
    (v_state_id, 'Clay'), (v_state_id, 'Collier'), (v_state_id, 'Columbia'),
    (v_state_id, 'DeSoto'), (v_state_id, 'Dixie'), (v_state_id, 'Duval'),
    (v_state_id, 'Escambia'), (v_state_id, 'Flagler'), (v_state_id, 'Franklin'),
    (v_state_id, 'Gadsden'), (v_state_id, 'Gilchrist'), (v_state_id, 'Glades'),
    (v_state_id, 'Gulf'), (v_state_id, 'Hamilton'), (v_state_id, 'Hardee'),
    (v_state_id, 'Hendry'), (v_state_id, 'Hernando'), (v_state_id, 'Highlands'),
    (v_state_id, 'Hillsborough'), (v_state_id, 'Holmes'), (v_state_id, 'Indian River'),
    (v_state_id, 'Jackson'), (v_state_id, 'Jefferson'), (v_state_id, 'Lafayette'),
    (v_state_id, 'Lake'), (v_state_id, 'Lee'), (v_state_id, 'Leon'),
    (v_state_id, 'Levy'), (v_state_id, 'Liberty'), (v_state_id, 'Madison'),
    (v_state_id, 'Manatee'), (v_state_id, 'Marion'), (v_state_id, 'Martin'),
    (v_state_id, 'Miami-Dade'), (v_state_id, 'Monroe'), (v_state_id, 'Nassau'),
    (v_state_id, 'Okaloosa'), (v_state_id, 'Okeechobee'), (v_state_id, 'Orange'),
    (v_state_id, 'Osceola'), (v_state_id, 'Palm Beach'), (v_state_id, 'Pasco'),
    (v_state_id, 'Pinellas'), (v_state_id, 'Polk'), (v_state_id, 'Putnam'),
    (v_state_id, 'Santa Rosa'), (v_state_id, 'Sarasota'), (v_state_id, 'Seminole'),
    (v_state_id, 'St. Johns'), (v_state_id, 'St. Lucie'), (v_state_id, 'Sumter'),
    (v_state_id, 'Suwannee'), (v_state_id, 'Taylor'), (v_state_id, 'Union'),
    (v_state_id, 'Volusia'), (v_state_id, 'Wakulla'), (v_state_id, 'Walton'),
    (v_state_id, 'Washington')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Georgia
  SELECT id INTO v_state_id FROM states WHERE code = 'GA';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Appling'), (v_state_id, 'Atkinson'), (v_state_id, 'Bacon'),
    (v_state_id, 'Baker'), (v_state_id, 'Baldwin'), (v_state_id, 'Banks'),
    (v_state_id, 'Barrow'), (v_state_id, 'Bartow'), (v_state_id, 'Ben Hill'),
    (v_state_id, 'Berrien'), (v_state_id, 'Bibb'), (v_state_id, 'Bleckley'),
    (v_state_id, 'Brantley'), (v_state_id, 'Brooks'), (v_state_id, 'Bryan'),
    (v_state_id, 'Bulloch'), (v_state_id, 'Burke'), (v_state_id, 'Butts'),
    (v_state_id, 'Calhoun'), (v_state_id, 'Camden'), (v_state_id, 'Candler'),
    (v_state_id, 'Carroll'), (v_state_id, 'Catoosa'), (v_state_id, 'Charlton'),
    (v_state_id, 'Chatham'), (v_state_id, 'Chattahoochee'), (v_state_id, 'Chattooga'),
    (v_state_id, 'Cherokee'), (v_state_id, 'Clarke'), (v_state_id, 'Clay'),
    (v_state_id, 'Clayton'), (v_state_id, 'Clinch'), (v_state_id, 'Cobb'),
    (v_state_id, 'Coffee'), (v_state_id, 'Colquitt'), (v_state_id, 'Columbia'),
    (v_state_id, 'Cook'), (v_state_id, 'Coweta'), (v_state_id, 'Crawford'),
    (v_state_id, 'Crisp'), (v_state_id, 'Dade'), (v_state_id, 'Dawson'),
    (v_state_id, 'Decatur'), (v_state_id, 'DeKalb'), (v_state_id, 'Dodge'),
    (v_state_id, 'Dooly'), (v_state_id, 'Dougherty'), (v_state_id, 'Douglas'),
    (v_state_id, 'Early'), (v_state_id, 'Echols'), (v_state_id, 'Effingham'),
    (v_state_id, 'Elbert'), (v_state_id, 'Emanuel'), (v_state_id, 'Evans'),
    (v_state_id, 'Fannin'), (v_state_id, 'Fayette'), (v_state_id, 'Floyd'),
    (v_state_id, 'Forsyth'), (v_state_id, 'Franklin'), (v_state_id, 'Fulton'),
    (v_state_id, 'Gilmer'), (v_state_id, 'Glascock'), (v_state_id, 'Glynn'),
    (v_state_id, 'Gordon'), (v_state_id, 'Grady'), (v_state_id, 'Greene'),
    (v_state_id, 'Gwinnett'), (v_state_id, 'Habersham'), (v_state_id, 'Hall'),
    (v_state_id, 'Hancock'), (v_state_id, 'Haralson'), (v_state_id, 'Harris'),
    (v_state_id, 'Hart'), (v_state_id, 'Heard'), (v_state_id, 'Henry'),
    (v_state_id, 'Houston'), (v_state_id, 'Irwin'), (v_state_id, 'Jackson'),
    (v_state_id, 'Jasper'), (v_state_id, 'Jeff Davis'), (v_state_id, 'Jefferson'),
    (v_state_id, 'Jenkins'), (v_state_id, 'Johnson'), (v_state_id, 'Jones'),
    (v_state_id, 'Lamar'), (v_state_id, 'Lanier'), (v_state_id, 'Laurens'),
    (v_state_id, 'Lee'), (v_state_id, 'Liberty'), (v_state_id, 'Lincoln'),
    (v_state_id, 'Long'), (v_state_id, 'Lowndes'), (v_state_id, 'Lumpkin'),
    (v_state_id, 'Macon'), (v_state_id, 'Madison'), (v_state_id, 'Marion'),
    (v_state_id, 'McDuffie'), (v_state_id, 'McIntosh'), (v_state_id, 'Meriwether'),
    (v_state_id, 'Miller'), (v_state_id, 'Mitchell'), (v_state_id, 'Monroe'),
    (v_state_id, 'Montgomery'), (v_state_id, 'Morgan'), (v_state_id, 'Murray'),
    (v_state_id, 'Muscogee'), (v_state_id, 'Newton'), (v_state_id, 'Oconee'),
    (v_state_id, 'Oglethorpe'), (v_state_id, 'Paulding'), (v_state_id, 'Peach'),
    (v_state_id, 'Pickens'), (v_state_id, 'Pierce'), (v_state_id, 'Pike'),
    (v_state_id, 'Polk'), (v_state_id, 'Pulaski'), (v_state_id, 'Putnam'),
    (v_state_id, 'Quitman'), (v_state_id, 'Rabun'), (v_state_id, 'Randolph'),
    (v_state_id, 'Richmond'), (v_state_id, 'Rockdale'), (v_state_id, 'Schley'),
    (v_state_id, 'Screven'), (v_state_id, 'Seminole'), (v_state_id, 'Spalding'),
    (v_state_id, 'Stephens'), (v_state_id, 'Stewart'), (v_state_id, 'Sumter'),
    (v_state_id, 'Talbot'), (v_state_id, 'Taliaferro'), (v_state_id, 'Tattnall'),
    (v_state_id, 'Taylor'), (v_state_id, 'Telfair'), (v_state_id, 'Terrell'),
    (v_state_id, 'Thomas'), (v_state_id, 'Tift'), (v_state_id, 'Toombs'),
    (v_state_id, 'Towns'), (v_state_id, 'Treutlen'), (v_state_id, 'Troup'),
    (v_state_id, 'Turner'), (v_state_id, 'Twiggs'), (v_state_id, 'Union'),
    (v_state_id, 'Upson'), (v_state_id, 'Walker'), (v_state_id, 'Walton'),
    (v_state_id, 'Ware'), (v_state_id, 'Warren'), (v_state_id, 'Washington'),
    (v_state_id, 'Wayne'), (v_state_id, 'Webster'), (v_state_id, 'Wheeler'),
    (v_state_id, 'White'), (v_state_id, 'Whitfield'), (v_state_id, 'Wilcox'),
    (v_state_id, 'Wilkes'), (v_state_id, 'Wilkinson'), (v_state_id, 'Worth')
  ON CONFLICT (state_id, name) DO NOTHING;

END $$;