------------------------------------------------
-- BRG windows
------------------------------------------------
function init_BRG_lib()

	local bearing1_window = img_add("BRG_window_left.png", 310, 675, 75, 65)
	local bearing1_window_border = img_add("color_white.png", 223, 673, 87, 67)
	local bearing1_window_sqr = img_add("color_black.png", 225, 675, 85, 63)
	local txt_brg1_distance = txt_add("88.8 NM",font_BRG_white_l, 228, 677, 80,20)
	local txt_brg1_ID = txt_add("ID1",font_BRG_cyan_l, 228, 696, 80, 20)
	local txt_brg1_source = txt_add("SRC", font_BRG_white_l, 228, 715, 80, 20)
	local img_brg1_pointer = img_add("brg1.png", 357, 487, 206, 206)
	
	local grp_brg1 = group_add(bearing1_window_border, bearing1_window, bearing1_window_sqr, txt_brg1_distance, txt_brg1_ID, txt_brg1_source, img_brg1_pointer)
	visible(grp_brg1, false)
	
	local bearing2_window = img_add("BRG_window_right.png", 535, 675, 75, 65)
	local bearing2_window_border = img_add("color_white.png", 610, 673, 87, 67)
	local bearing2_window_sqr = img_add("color_black.png", 610, 675, 85, 63)
	local txt_brg2_distance = txt_add("88.8".." NM",font_BRG_white_r, 613, 677, 80 ,20)
	local txt_brg2_ID = txt_add("ID2",font_BRG_cyan_r, 613, 696, 80, 20)
	local txt_brg2_source = txt_add("SRC",font_BRG_white_r, 613, 715, 80, 20)
	local img_brg2_pointer = img_add("brg2.png", 357, 487, 206, 206)
	
	local grp_brg2 = group_add(bearing2_window_border, bearing2_window, bearing2_window_sqr, txt_brg2_distance, txt_brg2_ID, txt_brg2_source, img_brg2_pointer)
	visible(grp_brg2, false)
	
	local NAV1act = 0
	local NAV2act = 0
	
	local nav1freq = 0
	local nav2freq = 0
	local ndb1freq = 0
	local ndb2freq = 0
	
	local nav1id = 0
	local nav2id = 0
	local ndb1id = 0
	local ndb2id = 0
	
	local function brg1_lookup_timer_callback()
		visible(txt_brg1_ID, true)
		timer_stop(brg1timer)
	end
	
	local function brg2_lookup_timer_callback()
		visible(txt_brg2_ID, true)
		timer_stop(brg2timer)
	end
	
	
	local function brg_station_lookup()
		
		-- Find the nearest 100 VOR/NDB stations in a  200 mile radius from current latitude and longitude
		local lon , lat = get_position()
		local vor_stations = nav_get_radius("VOR", lat, lon, 200, 100)
		local ndb_stations = nav_get_radius("NDB", lat, lon, 200, 100)
		NAV1act, NAV2act = get_nav_act()
		
		-- match stations to NAV frequencies
		local nav1found = false
		local nav2found = false
		for i=1,#vor_stations do
			if vor_stations[i]["FREQUENCY"] == (NAV1act/100) then
				txt_set(txt_brg1_ID, vor_stations[i]["ID"])
				nav1found = true
			elseif vor_stations[i]["FREQUENCY"] == (NAV2act/100) then
				txt_set(txt_brg2_ID, vor_stations[i]["ID"])
				nav2found = true
			end
		end
		if nav1found == false then txt_set(txt_brg1_ID, "") end
		if nav2found == false then txt_set(txt_brg2_ID, "") end
		
		local delay = 9000  --sec
		local nav1timer = timer_start(delay, nil, station1_lookup_timer_callback)
		local nav2timer = timer_start(delay, nil, station2_lookup_timer_callback)
		
		vor_stations = nil
	end
	
	
	local brg1src = ""
	function select_brg1()
		HSI_360()
		visible(txt_brg1_ID, false)
		if brg1src == "" then
			brg1src = "nav1"
			visible(grp_brg1, true)
		elseif brg1src == "nav1" then
			brg1src = "gps"
			visible(grp_brg1, true)
		elseif brg1src == "gps" then
			brg1src = "adf1"
			visible(grp_brg1, true)
		elseif brg1src == "adf1" then
			brg1src = ""
			visible(grp_brg1, false)
		end
		
		brg_station_lookup()
		
	end
	
	local brg2src = ""
	function select_brg2()
		HSI_360()
		visible(txt_brg2_ID, false)
		if brg2src == "" then 
			brg2src = "nav2"
			visible(grp_brg2, true)
		elseif brg2src == "nav2" then
			brg2src = "gps"
			visible(grp_brg2, true)
		elseif brg2src == "gps" then
			brg2src = "adf2"
			visible(grp_brg2, true)
		elseif brg2src == "adf2" then
			brg2src = ""
			visible(grp_brg2, false)
		end
		
		brg_station_lookup()
		
	end

	function brg_HSI_arc()
		brg1src = ""
		visible(grp_brg1, false)
		
		brg2src = ""
		visible(grp_brg2, false)
	end
	
	local function new_brg1(nav1_dir, adf1_dir, gps_dir, nav1_dme_dist, adf1_dme_dist, gps_dme_dist, nav1id, ndb1id, gps_nav_id)
		
		if brg1src == "" then
		elseif brg1src == "nav1" then
			img_rotate(img_brg1_pointer, nav1_dir)
			if nav1_dme_dist ~= 0 then
				txt_set(txt_brg1_distance, new_var_format(nav1_dme_dist,1).." NM" )
			else
				txt_set(txt_brg1_distance, "__._ NM" )
			end
			--txt_set(txt_brg1_ID, nav1id)
			txt_set(txt_brg1_source, "NAV1")
		elseif brg1src == "gps" then
			img_rotate(img_brg1_pointer, gps_dir)
			if gps_dme_dist ~= nil then 
				txt_set(txt_brg1_distance, new_var_format(gps_dme_dist,1).." NM" )
			else
				txt_set(txt_brg1_distance, "__._ NM" )
			end
			--txt_set(txt_brg1_ID, gps_nav_id)
			txt_set(txt_brg1_source, "GPS")
		elseif brg1src == "adf1" then
			img_rotate(img_brg1_pointer, adf1_dir)
			if adf1_dme_dist ~= nil then 
				txt_set(txt_brg1_distance, new_var_format(adf1_dme_dist,1).." NM" )
			else
				txt_set(txt_brg1_distance, "__._ NM" )
			end
			---txt_set(txt_brg1_distance, new_var_format(adf1_dme_dist,1) )
			--txt_set(txt_brg1_ID, ndb1id)
			txt_set(txt_brg1_source, "ADF1")
		end
		
	end
	
	local function new_brg2(nav2_dir, adf2_dir, gps_dir, nav2_dme_dist, adf2_dme_dist, gps_dme_dist, nav2id, ndb2id, gps_nav_id)
		
		if brg2src == "" then
		elseif brg2src == "nav2" then
			img_rotate(img_brg2_pointer, nav2_dir)
			if nav1_dme_dist ~= 0 then
				--txt_set(txt_brg2_ID, nav2id)
				txt_set(txt_brg2_distance, new_var_format(nav2_dme_dist,1).." NM" )
			else
				txt_set(txt_brg2_distance, "__._ NM" )
			end
			txt_set(txt_brg2_source, "NAV2")
		elseif brg2src == "gps" then
			img_rotate(img_brg2_pointer, gps_dir)
			if gps_dme_dist ~= nil then 
				txt_set(txt_brg2_distance, new_var_format(gps_dme_dist,1).." NM" )
			else
				txt_set(txt_brg2_distance, "__._ NM" )
			end
			--txt_set(txt_brg2_ID, gps_nav_id)
			txt_set(txt_brg2_source, "GPS")
		elseif brg2src == "adf2" then
			img_rotate(img_brg2_pointer, adf2_dir)
			if adf2_dme_dist ~= nil then 
				txt_set(txt_brg2_distance, new_var_format(adf2_dme_dist,1).." NM" )
			else
				txt_set(txt_brg2_distance, "__._ NM" )
			end
			---txt_set(txt_brg2_distance, new_var_format(adf2_dme_dist,1) )
			--txt_set(txt_brg2_ID, ndb1id)
			txt_set(txt_brg1_source, "ADF2")
		end
	end
	
	xpl_dataref_subscribe(	"sim/cockpit/radios/nav1_dir_degt",	"FLOAT",
							"sim/cockpit/radios/adf1_dir_degt",	"FLOAT",
							"sim/cockpit/radios/gps_dir_degt", "FLOAT",
							
							"sim/cockpit/radios/nav1_dme_dist_m", "FLOAT",
							"sim/cockpit/radios/adf1_dme_dist_m", "FLOAT",
							"sim/cockpit/radios/gps_dme_dist_m", "FLOAT",
							
							"sim/cockpit2/radios/indicators/nav1_nav_id", "DATA",
							"sim/cockpit2/radios/indicators/adf1_nav_id", "DATA",
							"sim/cockpit2/radios/indicators/gps_nav_id", "DATA",
							new_brg1)
	
	fsx_variable_subscribe(
						"NAV RELATIVE BEARING TO STATION:1", "DEGREES", 
						"ADF RADIAL:1", "DEGREES",
						"GPS WP BEARING", "DEGREES", 
						
						"NAV DME:1", "NAUTICAL MILES", 
						"NAV DME:3", "NAUTICAL MILES",
						"GPS WP DISTANCE", "METERS", new_brg1_fsx)							
		
	xpl_dataref_subscribe(	"sim/cockpit/radios/nav2_dir_degt",	"FLOAT",
							"sim/cockpit/radios/adf2_dir_degt",	"FLOAT",
							"sim/cockpit/radios/gps_dir_degt", "FLOAT",
							
							"sim/cockpit/radios/nav2_dme_dist_m", "FLOAT",
							"sim/cockpit/radios/adf2_dme_dist_m", "FLOAT",
							"sim/cockpit/radios/gps_dme_dist_m", "FLOAT",
						
							"sim/cockpit2/radios/indicators/nav2_nav_id", "DATA",
							"sim/cockpit2/radios/indicators/adf2_nav_id", "DATA",
							"sim/cockpit2/radios/indicators/gps_nav_id", "DATA",
							new_brg2)
							
	fsx_variable_subscribe(
						"NAV RELATIVE BEARING TO STATION:2", "DEGREES", 
						"ADF RADIAL:2", "DEGREES",
						"GPS WP BEARING", "DEGREES", 
						
						"NAV DME:2", "NAUTICAL MILES", 
						"NAV DME:3", "NAUTICAL MILES",
						"GPS WP DISTANCE", "METERS", new_brg2_fsx)		
end