DO $$
DECLARE
  v_state_id uuid;
BEGIN
  -- Utah
  SELECT id INTO v_state_id FROM states WHERE code = 'UT';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Beaver'), (v_state_id, 'Box Elder'), (v_state_id, 'Cache'),
    (v_state_id, 'Carbon'), (v_state_id, 'Daggett'), (v_state_id, 'Davis'),
    (v_state_id, 'Duchesne'), (v_state_id, 'Emery'), (v_state_id, 'Garfield'),
    (v_state_id, 'Grand'), (v_state_id, 'Iron'), (v_state_id, 'Juab'),
    (v_state_id, 'Kane'), (v_state_id, 'Millard'), (v_state_id, 'Morgan'),
    (v_state_id, 'Piute'), (v_state_id, 'Rich'), (v_state_id, 'Salt Lake'),
    (v_state_id, 'San Juan'), (v_state_id, 'Sanpete'), (v_state_id, 'Sevier'),
    (v_state_id, 'Summit'), (v_state_id, 'Tooele'), (v_state_id, 'Uintah'),
    (v_state_id, 'Utah'), (v_state_id, 'Wasatch'), (v_state_id, 'Washington'),
    (v_state_id, 'Wayne'), (v_state_id, 'Weber')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Vermont
  SELECT id INTO v_state_id FROM states WHERE code = 'VT';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Addison'), (v_state_id, 'Bennington'), (v_state_id, 'Caledonia'),
    (v_state_id, 'Chittenden'), (v_state_id, 'Essex'), (v_state_id, 'Franklin'),
    (v_state_id, 'Grand Isle'), (v_state_id, 'Lamoille'), (v_state_id, 'Orange'),
    (v_state_id, 'Orleans'), (v_state_id, 'Rutland'), (v_state_id, 'Washington'),
    (v_state_id, 'Windham'), (v_state_id, 'Windsor')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Virginia
  SELECT id INTO v_state_id FROM states WHERE code = 'VA';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Accomack'), (v_state_id, 'Albemarle'), (v_state_id, 'Alleghany'),
    (v_state_id, 'Amelia'), (v_state_id, 'Amherst'), (v_state_id, 'Appomattox'),
    (v_state_id, 'Arlington'), (v_state_id, 'Augusta'), (v_state_id, 'Bath'),
    (v_state_id, 'Bedford'), (v_state_id, 'Bland'), (v_state_id, 'Botetourt'),
    (v_state_id, 'Brunswick'), (v_state_id, 'Buchanan'), (v_state_id, 'Buckingham'),
    (v_state_id, 'Campbell'), (v_state_id, 'Caroline'), (v_state_id, 'Carroll'),
    (v_state_id, 'Charles City'), (v_state_id, 'Charlotte'), (v_state_id, 'Chesterfield'),
    (v_state_id, 'Clarke'), (v_state_id, 'Craig'), (v_state_id, 'Culpeper'),
    (v_state_id, 'Cumberland'), (v_state_id, 'Dickenson'), (v_state_id, 'Dinwiddie'),
    (v_state_id, 'Essex'), (v_state_id, 'Fairfax'), (v_state_id, 'Fauquier'),
    (v_state_id, 'Floyd'), (v_state_id, 'Fluvanna'), (v_state_id, 'Franklin'),
    (v_state_id, 'Frederick'), (v_state_id, 'Giles'), (v_state_id, 'Gloucester'),
    (v_state_id, 'Goochland'), (v_state_id, 'Grayson'), (v_state_id, 'Greene'),
    (v_state_id, 'Greensville'), (v_state_id, 'Halifax'), (v_state_id, 'Hanover'),
    (v_state_id, 'Henrico'), (v_state_id, 'Henry'), (v_state_id, 'Highland'),
    (v_state_id, 'Isle of Wight'), (v_state_id, 'James City'), (v_state_id, 'King and Queen'),
    (v_state_id, 'King George'), (v_state_id, 'King William'), (v_state_id, 'Lancaster'),
    (v_state_id, 'Lee'), (v_state_id, 'Loudoun'), (v_state_id, 'Louisa'),
    (v_state_id, 'Lunenburg'), (v_state_id, 'Madison'), (v_state_id, 'Mathews'),
    (v_state_id, 'Mecklenburg'), (v_state_id, 'Middlesex'), (v_state_id, 'Montgomery'),
    (v_state_id, 'Nelson'), (v_state_id, 'New Kent'), (v_state_id, 'Northampton'),
    (v_state_id, 'Northumberland'), (v_state_id, 'Nottoway'), (v_state_id, 'Orange'),
    (v_state_id, 'Page'), (v_state_id, 'Patrick'), (v_state_id, 'Pittsylvania'),
    (v_state_id, 'Powhatan'), (v_state_id, 'Prince Edward'), (v_state_id, 'Prince George'),
    (v_state_id, 'Prince William'), (v_state_id, 'Pulaski'), (v_state_id, 'Rappahannock'),
    (v_state_id, 'Richmond'), (v_state_id, 'Roanoke'), (v_state_id, 'Rockbridge'),
    (v_state_id, 'Rockingham'), (v_state_id, 'Russell'), (v_state_id, 'Scott'),
    (v_state_id, 'Shenandoah'), (v_state_id, 'Smyth'), (v_state_id, 'Southampton'),
    (v_state_id, 'Spotsylvania'), (v_state_id, 'Stafford'), (v_state_id, 'Surry'),
    (v_state_id, 'Sussex'), (v_state_id, 'Tazewell'), (v_state_id, 'Warren'),
    (v_state_id, 'Washington'), (v_state_id, 'Westmoreland'), (v_state_id, 'Wise'),
    (v_state_id, 'Wythe'), (v_state_id, 'York')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Washington
  SELECT id INTO v_state_id FROM states WHERE code = 'WA';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Adams'), (v_state_id, 'Asotin'), (v_state_id, 'Benton'),
    (v_state_id, 'Chelan'), (v_state_id, 'Clallam'), (v_state_id, 'Clark'),
    (v_state_id, 'Columbia'), (v_state_id, 'Cowlitz'), (v_state_id, 'Douglas'),
    (v_state_id, 'Ferry'), (v_state_id, 'Franklin'), (v_state_id, 'Garfield'),
    (v_state_id, 'Grant'), (v_state_id, 'Grays Harbor'), (v_state_id, 'Island'),
    (v_state_id, 'Jefferson'), (v_state_id, 'King'), (v_state_id, 'Kitsap'),
    (v_state_id, 'Kittitas'), (v_state_id, 'Klickitat'), (v_state_id, 'Lewis'),
    (v_state_id, 'Lincoln'), (v_state_id, 'Mason'), (v_state_id, 'Okanogan'),
    (v_state_id, 'Pacific'), (v_state_id, 'Pend Oreille'), (v_state_id, 'Pierce'),
    (v_state_id, 'San Juan'), (v_state_id, 'Skagit'), (v_state_id, 'Skamania'),
    (v_state_id, 'Snohomish'), (v_state_id, 'Spokane'), (v_state_id, 'Stevens'),
    (v_state_id, 'Thurston'), (v_state_id, 'Wahkiakum'), (v_state_id, 'Walla Walla'),
    (v_state_id, 'Whatcom'), (v_state_id, 'Whitman'), (v_state_id, 'Yakima')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- West Virginia
  SELECT id INTO v_state_id FROM states WHERE code = 'WV';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Barbour'), (v_state_id, 'Berkeley'), (v_state_id, 'Boone'),
    (v_state_id, 'Braxton'), (v_state_id, 'Brooke'), (v_state_id, 'Cabell'),
    (v_state_id, 'Calhoun'), (v_state_id, 'Clay'), (v_state_id, 'Doddridge'),
    (v_state_id, 'Fayette'), (v_state_id, 'Gilmer'), (v_state_id, 'Grant'),
    (v_state_id, 'Greenbrier'), (v_state_id, 'Hampshire'), (v_state_id, 'Hancock'),
    (v_state_id, 'Hardy'), (v_state_id, 'Harrison'), (v_state_id, 'Jackson'),
    (v_state_id, 'Jefferson'), (v_state_id, 'Kanawha'), (v_state_id, 'Lewis'),
    (v_state_id, 'Lincoln'), (v_state_id, 'Logan'), (v_state_id, 'Marion'),
    (v_state_id, 'Marshall'), (v_state_id, 'Mason'), (v_state_id, 'McDowell'),
    (v_state_id, 'Mercer'), (v_state_id, 'Mineral'), (v_state_id, 'Mingo'),
    (v_state_id, 'Monongalia'), (v_state_id, 'Monroe'), (v_state_id, 'Morgan'),
    (v_state_id, 'Nicholas'), (v_state_id, 'Ohio'), (v_state_id, 'Pendleton'),
    (v_state_id, 'Pleasants'), (v_state_id, 'Pocahontas'), (v_state_id, 'Preston'),
    (v_state_id, 'Putnam'), (v_state_id, 'Raleigh'), (v_state_id, 'Randolph'),
    (v_state_id, 'Ritchie'), (v_state_id, 'Roane'), (v_state_id, 'Summers'),
    (v_state_id, 'Taylor'), (v_state_id, 'Tucker'), (v_state_id, 'Tyler'),
    (v_state_id, 'Upshur'), (v_state_id, 'Wayne'), (v_state_id, 'Webster'),
    (v_state_id, 'Wetzel'), (v_state_id, 'Wirt'), (v_state_id, 'Wood'),
    (v_state_id, 'Wyoming')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Wisconsin
  SELECT id INTO v_state_id FROM states WHERE code = 'WI';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Adams'), (v_state_id, 'Ashland'), (v_state_id, 'Barron'),
    (v_state_id, 'Bayfield'), (v_state_id, 'Brown'), (v_state_id, 'Buffalo'),
    (v_state_id, 'Burnett'), (v_state_id, 'Calumet'), (v_state_id, 'Chippewa'),
    (v_state_id, 'Clark'), (v_state_id, 'Columbia'), (v_state_id, 'Crawford'),
    (v_state_id, 'Dane'), (v_state_id, 'Dodge'), (v_state_id, 'Door'),
    (v_state_id, 'Douglas'), (v_state_id, 'Dunn'), (v_state_id, 'Eau Claire'),
    (v_state_id, 'Florence'), (v_state_id, 'Fond du Lac'), (v_state_id, 'Forest'),
    (v_state_id, 'Grant'), (v_state_id, 'Green'), (v_state_id, 'Green Lake'),
    (v_state_id, 'Iowa'), (v_state_id, 'Iron'), (v_state_id, 'Jackson'),
    (v_state_id, 'Jefferson'), (v_state_id, 'Juneau'), (v_state_id, 'Kenosha'),
    (v_state_id, 'Kewaunee'), (v_state_id, 'La Crosse'), (v_state_id, 'Lafayette'),
    (v_state_id, 'Langlade'), (v_state_id, 'Lincoln'), (v_state_id, 'Manitowoc'),
    (v_state_id, 'Marathon'), (v_state_id, 'Marinette'), (v_state_id, 'Marquette'),
    (v_state_id, 'Menominee'), (v_state_id, 'Milwaukee'), (v_state_id, 'Monroe'),
    (v_state_id, 'Oconto'), (v_state_id, 'Oneida'), (v_state_id, 'Outagamie'),
    (v_state_id, 'Ozaukee'), (v_state_id, 'Pepin'), (v_state_id, 'Pierce'),
    (v_state_id, 'Polk'), (v_state_id, 'Portage'), (v_state_id, 'Price'),
    (v_state_id, 'Racine'), (v_state_id, 'Richland'), (v_state_id, 'Rock'),
    (v_state_id, 'Rusk'), (v_state_id, 'St. Croix'), (v_state_id, 'Sauk'),
    (v_state_id, 'Sawyer'), (v_state_id, 'Shawano'), (v_state_id, 'Sheboygan'),
    (v_state_id, 'Taylor'), (v_state_id, 'Trempealeau'), (v_state_id, 'Vernon'),
    (v_state_id, 'Vilas'), (v_state_id, 'Walworth'), (v_state_id, 'Washburn'),
    (v_state_id, 'Washington'), (v_state_id, 'Waukesha'), (v_state_id, 'Waupaca'),
    (v_state_id, 'Waushara'), (v_state_id, 'Winnebago'), (v_state_id, 'Wood')
  ON CONFLICT (state_id, name) DO NOTHING;

  -- Wyoming
  SELECT id INTO v_state_id FROM states WHERE code = 'WY';
  INSERT INTO counties (state_id, name) VALUES
    (v_state_id, 'Albany'), (v_state_id, 'Big Horn'), (v_state_id, 'Campbell'),
    (v_state_id, 'Carbon'), (v_state_id, 'Converse'), (v_state_id, 'Crook'),
    (v_state_id, 'Fremont'), (v_state_id, 'Goshen'), (v_state_id, 'Hot Springs'),
    (v_state_id, 'Johnson'), (v_state_id, 'Laramie'), (v_state_id, 'Lincoln'),
    (v_state_id, 'Natrona'), (v_state_id, 'Niobrara'), (v_state_id, 'Park'),
    (v_state_id, 'Platte'), (v_state_id, 'Sheridan'), (v_state_id, 'Sublette'),
    (v_state_id, 'Sweetwater'), (v_state_id, 'Teton'), (v_state_id, 'Uinta'),
    (v_state_id, 'Washakie'), (v_state_id, 'Weston')
  ON CONFLICT (state_id, name) DO NOTHING;

END $$;