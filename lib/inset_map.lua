----------------------------------------------
-- Inset Map
----------------------------------------------


function init_inset_map(instrument_operator, map_update_interval)

	local map_visible = false
	local map_range = 12
	local dcltr = 0
	local map_base_layer = 0 	-- 0=NONE 1=OSM_STANDARD, 2=OSM_CYCLE, 3=OSM_TRANSPORT, 4=OSM_MAPQUEST, 5=OSM_HUMANITARIAN
	
	local img_map_BG = img_add("color_black.png", 10 , 491 ,220 ,220 )
	
	-- Two maps needed until map move is available
	local inset_map_left = map_add(10 , 491 ,220,220, "OSM_STANDARD", map_range)
	local inset_map_right = map_add(794 , 491 ,220,220, "OSM_STANDARD", map_range)
	map_goto(inset_map_left, 5.485053, 52.222607) -- DEFAULT LOCATION FOR ERROR CHECKING
	map_goto(inset_map_right, 5.485053, 52.222607) -- DEFAULT LOCATION FOR ERROR CHECKING
	
	local map_layer_left_FIX = map_add_nav_img_layer(inset_map_left, "FIX", "fuel_tank2_pointer.png", -8, -6, 16, 12)
	local map_layer_left_NDB = map_add_nav_img_layer(inset_map_left, "NDB", "NDB.png", -8, -8, 16, 16)
	local map_layer_left_VOR = map_add_nav_img_layer(inset_map_left, "VOR", "VOR.png", -8, -6, 16, 13)
	local map_layer_left_AIRP = map_add_nav_img_layer(inset_map_left, "AIRP", "airport.png", -8, -8, 16, 16)
	
	local map_layer_right_FIX = map_add_nav_img_layer(inset_map_right, "FIX", "fuel_tank2_pointer.png", -8, -6, 16, 12)
	local map_layer_right_NDB = map_add_nav_img_layer(inset_map_right, "NDB", "NDB.png", -8, -8, 16, 16)
	local map_layer_right_VOR = map_add_nav_img_layer(inset_map_right, "VOR", "VOR.png", -8, -6, 16, 13)
	local map_layer_right_AIRP = map_add_nav_img_layer(inset_map_right, "AIRP", "airport.png", -8, -8, 16, 16)
			
	local img_map_plane = img_add("airplane_icon.png",105 , 586 ,30,30)
	
	local grp_inset_map = group_add(img_map_BG, inset_map_left, inset_map_right, img_map_plane,
									map_layer_left_NDB, map_layer_left_VOR, map_layer_left_AIRP, 
									map_layer_right_NDB, map_layer_right_VOR, map_layer_right_AIRP)
	visible(grp_inset_map, false)
	
	
	local eis_visible = false
	local inset_visible = false
	
	function set_map_eis(condition)
		eis_visible = condition
		if inset_visible == true then
			hide_map_screen()
			build_map_screen()
		end
	end
	
	
	function dcltr_map()
	
		local  dcltr = dcltr -1
		if dcltr < 0 then 
			dcltr = 4 
		end
		
		if eis_visible == true then 
			if dcltr == 4 then
				visible(map_layer_left_FIX, false)
				visible(map_layer_left_NDB, false)
				visible(map_layer_left_VOR, false)
				visible(map_layer_left_AIRP, false)
				
				visible(map_layer_right_FIX, true)
				visible(map_layer_right_NDB, true)
				visible(map_layer_right_VOR, true)
				visible(map_layer_right_AIRP, true)
				
			elseif dcltr == 3 then
				visible(map_layer_left_FIX, false)
				visible(map_layer_left_NDB, false)
				visible(map_layer_left_VOR, false)
				visible(map_layer_left_AIRP, false)
				
				visible(map_layer_right_FIX, true)
				visible(map_layer_right_NDB, false)
				visible(map_layer_right_VOR, false)
				visible(map_layer_right_AIRP, false)
				
			elseif dcltr == 2 then
				visible(map_layer_left_FIX, false)
				visible(map_layer_left_NDB, false)
				visible(map_layer_left_VOR, false)
				visible(map_layer_left_AIRP, false)
				
				visible(map_layer_right_FIX, false)
				visible(map_layer_right_NDB, false)
				visible(map_layer_right_VOR, true)
				visible(map_layer_right_AIRP, false)
				
			elseif dcltr == 1 then
				visible(map_layer_left_FIX, false)
				visible(map_layer_left_NDB, false)
				visible(map_layer_left_VOR, false)
				visible(map_layer_left_AIRP, false)
				
				visible(map_layer_right_FIX, false)
				visible(map_layer_right_NDB, true)
				visible(map_layer_right_VOR, false)
				visible(map_layer_right_AIRP, false)
				
			elseif dcltr == 0 then
				visible(map_layer_left_FIX, false)
				visible(map_layer_left_NDB, false)
				visible(map_layer_left_VOR, false)
				visible(map_layer_left_AIRP, false)
				
				visible(map_layer_right_FIX, false)
				visible(map_layer_right_NDB, false)
				visible(map_layer_right_VOR, false)
				visible(map_layer_right_AIRP, true)
				
			end
		elseif eis_visible == false then
			visible(map_layer_left_FIX, false)
			visible(map_layer_left_NDB, false)
			visible(map_layer_left_VOR, false)
			visible(map_layer_left_AIRP, false)
			
			visible(map_layer_right_FIX, false)
			visible(map_layer_right_NDB, false)
			visible(map_layer_right_VOR, false)
			visible(map_layer_right_AIRP, false)
		end
	end

	local function new_map_position()
		local lon, lat, hdg = get_position()
		if map_visible then 
			if eis_visible == true then 
				map_goto(inset_map_right, lon, lat)
			elseif eis_visible == false then 
				map_goto(inset_map_left, lon, lat)
			end
		end
		img_rotate(img_map_plane, hdg)
	end

	function build_map_screen()
		inset_visible = true
		if eis_visible == true then 
			move(img_map_BG, 794 , nil ,nil ,nil )
			move(img_map_plane,899 , nil ,nil,nil)
			visible(inset_map_left, false)
			visible(inset_map_right, true)
			visible(img_map_BG, true)
			visible(img_map_plane, true)
		elseif eis_visible == false then 
			move(img_map_BG, 10 , 491 ,220 ,220 )
			move(img_map_plane ,105 , nil ,nil,nil)
			visible(inset_map_left, true)
			visible(inset_map_right, false)
			visible(img_map_BG, true)
			visible(img_map_plane, true)
		end		
		timer_map_update = timer_start(0, map_update_interval*1000, new_map_position) 
		map_visible = true
	end


	function hide_map_screen()
		visible(grp_inset_map, false)
		timer_stop(timer_map_update) 
		timer_map_update = nil
		inset_visible = false
	end


	function new_baselayer()
		map_base_layer = map_base_layer + 1
		if map_base_layer > 3 then map_base_layer = 0 end
		if map_base_layer == 0 then map_baselayer(inset_map_left, nil)
		elseif  map_base_layer == 1 then map_baselayer(inset_map_left,"OSM_STANDARD")
		elseif map_base_layer == 2 then map_baselayer(inset_map_left,"OSM_TRANSPORT")
		elseif map_base_layer == 3 then map_baselayer(inset_map_left,"OSM_HUMANITARIAN")
		end
	end

	function map_range_dn()
		map_range = map_range - 1
		if map_range < 1 then map_range = 1 end
		map_zoom(inset_map_left, map_range)
		map_zoom(inset_map_right, map_range)
	end
	am_command_subscribe("G1000_"..instrument_operator.."_range_dn", map_range_dn)
	
	function map_range_up()
		map_range = map_range + 1
		if map_range > 16 then map_range = 16 end
		map_zoom(inset_map_left, map_range)
		map_zoom(inset_map_right, map_range)
	end
	am_command_subscribe("G1000_"..instrument_operator.."_range_up", map_range_up)

end
