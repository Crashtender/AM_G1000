------------------------------------------------
-- NAV radios
------------------------------------------------

function init_NAV_radio_lib(volume_sensitivity)

	-- visual elements
	local NAV1act = 0
	local NAV2act = 0
	
	local txt_NAV1_title = txt_add("NAV1", "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 10, 5, 100, 20)
	local txt_NAV1_stby_freq = txt_add("888.888", font_NavCom_white, 60, 4, 100, 20)
	local txt_NAV1_act_freq = txt_add("888.888", font_NavCom_white, 155, 4, 100, 20)
	local txt_NAV1_station = txt_add("", "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 225, 5, 100, 20)
	
	local txt_NAV2_title = txt_add("NAV2", "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 10, 30, 100, 20)
	local txt_NAV2_stby_freq = txt_add("888.888", font_NavCom_white, 60, 29, 100, 20)
	local txt_NAV2_act_freq = txt_add("888.888", font_NavCom_white, 155, 29, 100, 20)
	local txt_NAV2_station = txt_add("", "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 225, 30, 100, 20)

	local grp_NAV_titles = group_add(txt_NAV1_title,txt_NAV2_title)
	visible(grp_NAV_titles, false)
	
	local grp_NAV_frequencies = group_add(txt_NAV1_act_freq,txt_NAV1_stby_freq,txt_NAV2_act_freq,txt_NAV2_stby_freq)
	
	local grp_NAV_stations = group_add(txt_NAV1_station, txt_NAV2_station)
	visible(grp_NAV_stations, false)
	
	local img_NAV_transfer = img_add("switch_active.png", 125, 9, 20, 10)
	
	local img_NAV_box_L = img_add("color_green.png", 54, 3, 2, 20)
	local img_NAV_box_R = img_add("color_green.png", 120, 2, 2, 22)
	local img_NAV_box_T = img_add("color_green.png", 54, 2, 67, 2)
	local img_NAV_box_B = img_add("color_green.png", 54, 22, 67, 2)
	group_obj_add(grp_NAV_frequencies, img_NAV_box_B, img_NAV_box_L, img_NAV_box_R, img_NAV_box_T, img_NAV_transfer)
	visible(grp_NAV_frequencies, false)
	
	local NAV_startup_complete = false
	local function timer_callback_NAV_startup()
		visible(grp_NAV_frequencies, true)
		NAV_startup_complete = true
	end
	
	local on = false
	function power_NAV_radios(condition)
		visible(grp_NAV_titles, condition)
		visible(grp_NAV_frequencies, false)
		if condition == true then
			tmr_NAV_startup = timer_start(6500, nil, timer_callback_NAV_startup)	
		end
		
		on = condition
	end

	function set_NAV_startup_complete(condition)
		NAV_startup_complete = condition
	end
	
	function get_nav_act()
		return NAV1act, NAV2act
	end
	
	----------------
	-- NAV VOLUME --
	----------------
	local radio_memory_volume = 0
	local radio_volume_setting = 1
	
	local function new_NAV_vol(vol)
		radio_volume_setting = vol
	end
	xpl_dataref_subscribe("sim/operation/sound/radio_volume_ratio", "FLOAT", new_NAV_vol)
	
	function dial_NAV_vol_up()
		if radio_volume_setting < 1 then
			local new_volume = radio_volume_setting + volume_sensitivity
			if new_volume > 1 then new_volume = 1 end
			radio_memory_volume = new_volume	
			xpl_dataref_write("sim/operation/sound/radio_volume_ratio", "FLOAT", new_volume)
		end
	end


	function dial_NAV_vol_down()
		if radio_volume_setting > 0 then
			local new_volume = radio_volume_setting - volume_sensitivity
			if new_volume < 0 then new_volume = 0 end
			radio_memory_volume = new_volume	
			xpl_dataref_write("sim/operation/sound/radio_volume_ratio", "FLOAT", new_volume)
		end
	end


	function NAV_vol_pressed()
		if radio_volume_setting == 0 then 
			xpl_dataref_write("sim/operation/sound/radio_volume_ratio", "FLOAT", radio_memory_volume)
		else 
			radio_volume_setting = 0
		end
	end


	-------------
	-- NAV XFR --
	-------------

	local NAV_tuning = 1
	
	function NAV_XFR_pressed()
		if NAV_tuning == 1 then
			visible(txt_NAV1_station, false)
			xpl_command("sim/radios/nav1_standy_flip")
		elseif NAV_tuning == 2 then
			visible(txt_NAV2_station, false)
			xpl_command("sim/radios/nav2_standy_flip")
		end
	end


	---------
	-- NAV --
	---------

	function stby_nav_fine_up()
		if NAV_tuning == 1 then
			xpl_command("sim/radios/stby_nav1_fine_up")
		elseif NAV_tuning == 2 then
			xpl_command("sim/radios/stby_nav2_fine_up")
		end
	end

	function stby_nav_fine_down()
		if NAV_tuning == 1 then
			xpl_command("sim/radios/stby_nav1_fine_down")
		elseif NAV_tuning == 2 then
			xpl_command("sim/radios/stby_nav2_fine_down")
		end
	end

	function stby_nav_coarse_up()
		if NAV_tuning == 1 then
			xpl_command("sim/radios/stby_nav1_coarse_up")
		elseif NAV_tuning == 2 then
			xpl_command("sim/radios/stby_nav2_coarse_up")
		end
	end

	function stby_nav_coarse_down()
		if NAV_tuning == 1 then
			xpl_command("sim/radios/stby_nav1_coarse_down")
		elseif NAV_tuning == 2 then
			xpl_command("sim/radios/stby_nav2_coarse_down")
		end
	end
	
	function draw_NAV_box(NAV)

		local box_offset = 0
		
		if NAV == 1 then 
			box_offset = 0
		elseif NAV == 2 then 
			box_offset = 25
		end
		
		move(img_NAV_box_L, 55, box_offset + 3, nil, nil)
		move(img_NAV_box_R, 120, box_offset + 3, nil, nil)
		move(img_NAV_box_T, 55, box_offset + 3, nil, nil)
		move(img_NAV_box_B, 55, box_offset + 23, nil, nil)
		
		move(img_NAV_transfer, nil, box_offset + 9, nil, nil)
		
	end

	function NAV_PUSH_1_2_pressed()
		if NAV_tuning == 1 then
			NAV_tuning = 2
			--set_DME_source(2)
			draw_NAV_box(2)
		elseif NAV_tuning == 2 then
			NAV_tuning = 1
			--set_DME_source(1)
			draw_NAV_box(1)
		end
	end
	
	local identifying = false

	local function station_visibility(signal1, signal2)	-- TODO
		if not identifying then
			visible(txt_NAV1_station, signal1)
			visible(txt_NAV2_station, signal2)
		end
	end
	xpl_dataref_subscribe(	"sim/cockpit2/radios/indicators/nav1_display_horizontal", "INT",
							"sim/cockpit2/radios/indicators/nav2_display_horizontal", "INT",
							station_visibility)
							
	
		-- This function will be called after 6-10 seconds
	local function station1_lookup_timer_callback()
		if NAV_startup_complete == true then
			identifying = false
			visible(txt_NAV1_station, true)
		end
	end
		
	local function station2_lookup_timer_callback()
		if NAV_startup_complete == true then 
			visible(txt_NAV2_station, true)
			identifying = false
		end
	end
	
	-- local function station_ID(station)
		-- -- Find the nearest 100 VOR stations in a  200 mile radius from current latitude and longitude
		-- local lon , lat = get_position()
		-- local vor_stations = nav_get_radius("VOR", lat, lon, 200, 100)
		
		-- -- match stations to NAV frequencies
		-- local nav1found = false
		-- local nav2found = false
		
		-- if station == 1 then
			-- for i=1,#vor_stations do
				-- if vor_stations[i]["FREQUENCY"] == (NAV1act/100) then
					-- txt_set(txt_NAV1_station, vor_stations[i]["ID"])
					-- nav1found = true
				-- end
			-- end
			-- if nav1found == false then 
				-- txt_set(txt_NAV1_station, "")
			-- end
		-- end
		
		-- if station == 2 then			
			-- for i=1,#vor_stations do
				-- if vor_stations[i]["FREQUENCY"] == (NAV2act/100) then
					-- txt_set(txt_NAV2_station, vor_stations[i]["ID"])
					-- nav2found = true
				-- end
			-- end
			-- if nav2found == false then
				-- txt_set(txt_NAV2_station, "")
			-- end
		-- end
		
		-- vor_stations = nil

	-- end
	
	local station1mem
	local function new_station1(id)
		if station1mem ~= id then
			identifying = true
			visible(txt_NAV1_station, false)
			txt_set(txt_NAV1_station, id)
			--station_ID(1)
			lookup1timer = timer_start(9000, nil, station1_lookup_timer_callback)
			station1mem = id
		end
	end
	xpl_dataref_subscribe("sim/cockpit2/radios/indicators/nav1_nav_id", "STRING", new_station1)
	
	local station2mem
	local function new_station2(id)
		if station2mem ~= id then
			identifying = true
			visible(txt_NAV2_station, false)
			--station_ID(2)
			lookup2timer = timer_start(9000, nil, station2_lookup_timer_callback)
			station2mem = id
		end
	end
	xpl_dataref_subscribe("sim/cockpit2/radios/indicators/nav1_nav_id", "STRING", new_station2)
	
	
	
	local function new_nav_freq(nav1act, nav1stby, nav1id, nav2act, nav2stby, nav2id)
	
		txt_set(txt_NAV1_act_freq, new_var_format(nav1act/100,2) )
		txt_set(txt_NAV1_stby_freq, new_var_format(nav1stby/100, 2) )
		NAV1act = nav1act
		
		--
		
		txt_set(txt_NAV2_act_freq, new_var_format(nav2act/100,2) )
		txt_set(txt_NAV2_stby_freq, new_var_format(nav2stby/100,2) )
		NAV2act = nav2act
		
	end

	xpl_dataref_subscribe(
						"sim/cockpit2/radios/actuators/nav1_frequency_hz", "INT",
						"sim/cockpit2/radios/actuators/nav1_standby_frequency_hz", "INT",
						"sim/cockpit2/radios/indicators/nav1_nav_id", "DATA",
		
						"sim/cockpit2/radios/actuators/nav2_frequency_hz", "INT",
						"sim/cockpit2/radios/actuators/nav2_standby_frequency_hz", "INT",
						"sim/cockpit2/radios/indicators/nav2_nav_id", "DATA",
						new_nav_freq)

	xpl_command("sim/autopilot/hsi_select_nav_1")
	
	visible(grp_NAV_stations, false)
	
end
