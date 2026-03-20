/*
  # Add Final Counties

  1. New Data
    - Add counties for New Mexico through Wyoming
    - Use v_state_id to avoid ambiguity
    - Preserve existing data with ON CONFLICT

  2. Changes
    - Insert counties for final set of states
    - Complete the counties database
*/

DO $$
DECLARE
  v_state_id uuid;
BEGIN
  -- New Mexico
  SELECT id INTO v_state_id FROM states WHERE code = 'NM';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Bernalillo'), (v_state_id, 'Catron'), (v_state_id, 'Chaves'),
    (v_state_id, 'Cibola'), (v_state_id, 'Colfax'), (v_state_id, 'Curry'),
    (v_state_id, 'De Baca'), (v_state_id, 'Doña Ana'), (v_state_id, 'Eddy'),
    (v_state_id, 'Grant'), (v_state_id, 'Guadalupe'), (v_state_id, 'Harding'),
    (v_state_id, 'Hidalgo'), (v_state_id, 'Lea'), (v_state_id, 'Lincoln'),
    (v_state_id, 'Los Alamos'), (v_state_id, 'Luna'), (v_state_id, 'McKinley'),
    (v_state_id, 'Mora'), (v_state_id, 'Otero'), (v_state_id, 'Quay'),
    (v_state_id, 'Rio Arriba'), (v_state_id, 'Roosevelt'), (v_state_id, 'San Juan'),
    (v_state_id, 'San Miguel'), (v_state_id, 'Sandoval'), (v_state_id, 'Santa Fe'),
    (v_state_id, 'Sierra'), (v_state_id, 'Socorro'), (v_state_id, 'Taos'),
    (v_state_id, 'Torrance'), (v_state_id, 'Union'), (v_state_id, 'Valencia')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- New York
  SELECT id INTO v_state_id FROM states WHERE code = 'NY';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Albany'), (v_state_id, 'Allegany'), (v_state_id, 'Bronx'),
    (v_state_id, 'Broome'), (v_state_id, 'Cattaraugus'), (v_state_id, 'Cayuga'),
    (v_state_id, 'Chautauqua'), (v_state_id, 'Chemung'), (v_state_id, 'Chenango'),
    (v_state_id, 'Clinton'), (v_state_id, 'Columbia'), (v_state_id, 'Cortland'),
    (v_state_id, 'Delaware'), (v_state_id, 'Dutchess'), (v_state_id, 'Erie'),
    (v_state_id, 'Essex'), (v_state_id, 'Franklin'), (v_state_id, 'Fulton'),
    (v_state_id, 'Genesee'), (v_state_id, 'Greene'), (v_state_id, 'Hamilton'),
    (v_state_id, 'Herkimer'), (v_state_id, 'Jefferson'), (v_state_id, 'Kings'),
    (v_state_id, 'Lewis'), (v_state_id, 'Livingston'), (v_state_id, 'Madison'),
    (v_state_id, 'Monroe'), (v_state_id, 'Montgomery'), (v_state_id, 'Nassau'),
    (v_state_id, 'New York'), (v_state_id, 'Niagara'), (v_state_id, 'Oneida'),
    (v_state_id, 'Onondaga'), (v_state_id, 'Ontario'), (v_state_id, 'Orange'),
    (v_state_id, 'Orleans'), (v_state_id, 'Oswego'), (v_state_id, 'Otsego'),
    (v_state_id, 'Putnam'), (v_state_id, 'Queens'), (v_state_id, 'Rensselaer'),
    (v_state_id, 'Richmond'), (v_state_id, 'Rockland'), (v_state_id, 'St. Lawrence'),
    (v_state_id, 'Saratoga'), (v_state_id, 'Schenectady'), (v_state_id, 'Schoharie'),
    (v_state_id, 'Schuyler'), (v_state_id, 'Seneca'), (v_state_id, 'Steuben'),
    (v_state_id, 'Suffolk'), (v_state_id, 'Sullivan'), (v_state_id, 'Tioga'),
    (v_state_id, 'Tompkins'), (v_state_id, 'Ulster'), (v_state_id, 'Warren'),
    (v_state_id, 'Washington'), (v_state_id, 'Wayne'), (v_state_id, 'Westchester'),
    (v_state_id, 'Wyoming'), (v_state_id, 'Yates')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- North Carolina
  SELECT id INTO v_state_id FROM states WHERE code = 'NC';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Alamance'), (v_state_id, 'Alexander'), (v_state_id, 'Alleghany'),
    (v_state_id, 'Anson'), (v_state_id, 'Ashe'), (v_state_id, 'Avery'),
    (v_state_id, 'Beaufort'), (v_state_id, 'Bertie'), (v_state_id, 'Bladen'),
    (v_state_id, 'Brunswick'), (v_state_id, 'Buncombe'), (v_state_id, 'Burke'),
    (v_state_id, 'Cabarrus'), (v_state_id, 'Caldwell'), (v_state_id, 'Camden'),
    (v_state_id, 'Carteret'), (v_state_id, 'Caswell'), (v_state_id, 'Catawba'),
    (v_state_id, 'Chatham'), (v_state_id, 'Cherokee'), (v_state_id, 'Chowan'),
    (v_state_id, 'Clay'), (v_state_id, 'Cleveland'), (v_state_id, 'Columbus'),
    (v_state_id, 'Craven'), (v_state_id, 'Cumberland'), (v_state_id, 'Currituck'),
    (v_state_id, 'Dare'), (v_state_id, 'Davidson'), (v_state_id, 'Davie'),
    (v_state_id, 'Duplin'), (v_state_id, 'Durham'), (v_state_id, 'Edgecombe'),
    (v_state_id, 'Forsyth'), (v_state_id, 'Franklin'), (v_state_id, 'Gaston'),
    (v_state_id, 'Gates'), (v_state_id, 'Graham'), (v_state_id, 'Granville'),
    (v_state_id, 'Greene'), (v_state_id, 'Guilford'), (v_state_id, 'Halifax'),
    (v_state_id, 'Harnett'), (v_state_id, 'Haywood'), (v_state_id, 'Henderson'),
    (v_state_id, 'Hertford'), (v_state_id, 'Hoke'), (v_state_id, 'Hyde'),
    (v_state_id, 'Iredell'), (v_state_id, 'Jackson'), (v_state_id, 'Johnston'),
    (v_state_id, 'Jones'), (v_state_id, 'Lee'), (v_state_id, 'Lenoir'),
    (v_state_id, 'Lincoln'), (v_state_id, 'Macon'), (v_state_id, 'Madison'),
    (v_state_id, 'Martin'), (v_state_id, 'McDowell'), (v_state_id, 'Mecklenburg'),
    (v_state_id, 'Mitchell'), (v_state_id, 'Montgomery'), (v_state_id, 'Moore'),
    (v_state_id, 'Nash'), (v_state_id, 'New Hanover'), (v_state_id, 'Northampton'),
    (v_state_id, 'Onslow'), (v_state_id, 'Orange'), (v_state_id, 'Pamlico'),
    (v_state_id, 'Pasquotank'), (v_state_id, 'Pender'), (v_state_id, 'Perquimans'),
    (v_state_id, 'Person'), (v_state_id, 'Pitt'), (v_state_id, 'Polk'),
    (v_state_id, 'Randolph'), (v_state_id, 'Richmond'), (v_state_id, 'Robeson'),
    (v_state_id, 'Rockingham'), (v_state_id, 'Rowan'), (v_state_id, 'Rutherford'),
    (v_state_id, 'Sampson'), (v_state_id, 'Scotland'), (v_state_id, 'Stanly'),
    (v_state_id, 'Stokes'), (v_state_id, 'Surry'), (v_state_id, 'Swain'),
    (v_state_id, 'Transylvania'), (v_state_id, 'Tyrrell'), (v_state_id, 'Union'),
    (v_state_id, 'Vance'), (v_state_id, 'Wake'), (v_state_id, 'Warren'),
    (v_state_id, 'Washington'), (v_state_id, 'Watauga'), (v_state_id, 'Wayne'),
    (v_state_id, 'Wilkes'), (v_state_id, 'Wilson'), (v_state_id, 'Yadkin'),
    (v_state_id, 'Yancey')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- North Dakota
  SELECT id INTO v_state_id FROM states WHERE code = 'ND';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Adams'), (v_state_id, 'Barnes'), (v_state_id, 'Benson'),
    (v_state_id, 'Billings'), (v_state_id, 'Bottineau'), (v_state_id, 'Bowman'),
    (v_state_id, 'Burke'), (v_state_id, 'Burleigh'), (v_state_id, 'Cass'),
    (v_state_id, 'Cavalier'), (v_state_id, 'Dickey'), (v_state_id, 'Divide'),
    (v_state_id, 'Dunn'), (v_state_id, 'Eddy'), (v_state_id, 'Emmons'),
    (v_state_id, 'Foster'), (v_state_id, 'Golden Valley'), (v_state_id, 'Grand Forks'),
    (v_state_id, 'Grant'), (v_state_id, 'Griggs'), (v_state_id, 'Hettinger'),
    (v_state_id, 'Kidder'), (v_state_id, 'LaMoure'), (v_state_id, 'Logan'),
    (v_state_id, 'McHenry'), (v_state_id, 'McIntosh'), (v_state_id, 'McKenzie'),
    (v_state_id, 'McLean'), (v_state_id, 'Mercer'), (v_state_id, 'Morton'),
    (v_state_id, 'Mountrail'), (v_state_id, 'Nelson'), (v_state_id, 'Oliver'),
    (v_state_id, 'Pembina'), (v_state_id, 'Pierce'), (v_state_id, 'Ramsey'),
    (v_state_id, 'Ransom'), (v_state_id, 'Renville'), (v_state_id, 'Richland'),
    (v_state_id, 'Rolette'), (v_state_id, 'Sargent'), (v_state_id, 'Sheridan'),
    (v_state_id, 'Sioux'), (v_state_id, 'Slope'), (v_state_id, 'Stark'),
    (v_state_id, 'Steele'), (v_state_id, 'Stutsman'), (v_state_id, 'Towner'),
    (v_state_id, 'Traill'), (v_state_id, 'Walsh'), (v_state_id, 'Ward'),
    (v_state_id, 'Wells'), (v_state_id, 'Williams')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Ohio
  SELECT id INTO v_state_id FROM states WHERE code = 'OH';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Adams'), (v_state_id, 'Allen'), (v_state_id, 'Ashland'),
    (v_state_id, 'Ashtabula'), (v_state_id, 'Athens'), (v_state_id, 'Auglaize'),
    (v_state_id, 'Belmont'), (v_state_id, 'Brown'), (v_state_id, 'Butler'),
    (v_state_id, 'Carroll'), (v_state_id, 'Champaign'), (v_state_id, 'Clark'),
    (v_state_id, 'Clermont'), (v_state_id, 'Clinton'), (v_state_id, 'Columbiana'),
    (v_state_id, 'Coshocton'), (v_state_id, 'Crawford'), (v_state_id, 'Cuyahoga'),
    (v_state_id, 'Darke'), (v_state_id, 'Defiance'), (v_state_id, 'Delaware'),
    (v_state_id, 'Erie'), (v_state_id, 'Fairfield'), (v_state_id, 'Fayette'),
    (v_state_id, 'Franklin'), (v_state_id, 'Fulton'), (v_state_id, 'Gallia'),
    (v_state_id, 'Geauga'), (v_state_id, 'Greene'), (v_state_id, 'Guernsey'),
    (v_state_id, 'Hamilton'), (v_state_id, 'Hancock'), (v_state_id, 'Hardin'),
    (v_state_id, 'Harrison'), (v_state_id, 'Henry'), (v_state_id, 'Highland'),
    (v_state_id, 'Hocking'), (v_state_id, 'Holmes'), (v_state_id, 'Huron'),
    (v_state_id, 'Jackson'), (v_state_id, 'Jefferson'), (v_state_id, 'Knox'),
    (v_state_id, 'Lake'), (v_state_id, 'Lawrence'), (v_state_id, 'Licking'),
    (v_state_id, 'Logan'), (v_state_id, 'Lorain'), (v_state_id, 'Lucas'),
    (v_state_id, 'Madison'), (v_state_id, 'Mahoning'), (v_state_id, 'Marion'),
    (v_state_id, 'Medina'), (v_state_id, 'Meigs'), (v_state_id, 'Mercer'),
    (v_state_id, 'Miami'), (v_state_id, 'Monroe'), (v_state_id, 'Montgomery'),
    (v_state_id, 'Morgan'), (v_state_id, 'Morrow'), (v_state_id, 'Muskingum'),
    (v_state_id, 'Noble'), (v_state_id, 'Ottawa'), (v_state_id, 'Paulding'),
    (v_state_id, 'Perry'), (v_state_id, 'Pickaway'), (v_state_id, 'Pike'),
    (v_state_id, 'Portage'), (v_state_id, 'Preble'), (v_state_id, 'Putnam'),
    (v_state_id, 'Richland'), (v_state_id, 'Ross'), (v_state_id, 'Sandusky'),
    (v_state_id, 'Scioto'), (v_state_id, 'Seneca'), (v_state_id, 'Shelby'),
    (v_state_id, 'Stark'), (v_state_id, 'Summit'), (v_state_id, 'Trumbull'),
    (v_state_id, 'Tuscarawas'), (v_state_id, 'Union'), (v_state_id, 'Van Wert'),
    (v_state_id, 'Vinton'), (v_state_id, 'Warren'), (v_state_id, 'Washington'),
    (v_state_id, 'Wayne'), (v_state_id, 'Williams'), (v_state_id, 'Wood'),
    (v_state_id, 'Wyandot')
  ON CONFLICT (state_id, name) DO NOTHING;

END $$;