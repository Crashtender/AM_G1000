--------------------------------------------------- 
-- Altimeter 
--------------------------------------------------- 

function init_altimeter_lib(instrument_operator) 

	-- Altitude box 
	local img_set_alt__top_border = img_add("color_white.png" , 702 , 84 , 105 , 2) 
	local img_set_alt_box_black = img_add("color_black.png" , 704 , 87 , 103 , 24) 
	local img_set_alt_box_cyan = img_add("color_cyan.png" , 704 , 87 , 103 , 24)
	visible(img_set_alt_box_cyan,false) 
	local img_set_alt_box_gold  = img_add("color_gold.png" , 704 , 87 , 103 , 24)
	visible(img_set_alt_box_gold,false) 
	local img_altbox_1 = img_add("color_white.png" , 702 , 110 , 105 , 2) 
	local img_altbox_2 = img_add("TR_25_Black.png" , 702 , 113 , 103 , 341) 
	local img_altbox_3 = img_add("color_white.png" , 702 , 454 , 105 , 2) 
	local img_altbox_4 = img_add("color_black.png" , 704 , 456 , 103 , 24) 
	local img_altbox_5 = img_add("color_white.png" , 702 , 480 , 105 , 2) 
	local img_altbox_6 = img_add("color_white.png" , 702 , 86 , 2 , 395) 
	local img_altbox_7 = img_add("color_white.png" , 806 , 84 , 2 , 397) 
	local grp_altimeter_box = group_add(img_set_alt__top_border, img_set_alt_box_black, img_altbox_1,img_altbox_2,img_altbox_3,img_altbox_4,img_altbox_5,img_altbox_6,img_altbox_7) 
	visible(grp_altimeter_box, false) 

	-- Vertical Speed Indicator
	local img_VSI = img_add("VSI.png" , 809 , 126 , 46 , 316) 
	local img_vertical_speed_requested = img_add("vertical_speed_requested.png" , 811 , 272 , 20 , 24) 
	local img_vertical_speed = img_add("vertical_speed.png" , 813 , 274 , 50 , 20) 
	local txt_vertical_speed = txt_add("", font_vertical_speed , 815 , 275 , 50 , 15) 
	local grp_VSI = group_add(img_VSI,img_vertical_speed,txt_vertical_speed, img_vertical_speed_requested) 
	visible(grp_VSI, false) 
	
	-- TODO 
	-- SET VNV Target Altitude BOX (P.56)
	-- local img_vnv_target_border = img_add("color_black.png", 810, 100, 102, 22)
	-- local img_vnv_target_bckgr = img_add("color_black.png", 812, 102, 100, 20)
	-- local txt_vnv_target = txt_add("9999FT", font, 812, 102, 100, 20)
	-- grp_vnv_target = group_add(img_vnv_target_border, img_vnv_target_bckgr, txt_vnv_target)
	-- visible(grp_vnv_target, true)
	
	-- local function vnv_target_box(conodition)
	-- visible(grp_vnv_target, conodition)
	-- end
	-- TODO 
   
	-- Altitude tape 
	local function altitude_tape_callback(altitude) 
		return string.format("%d", altitude * 100 * -1) 
	end 
	
	local altitude_tape = running_img_add_ver("altitude_tape.png" , 705 , 115 , 7 , 14 , 57) 
	viewport_rect(altitude_tape , 703 , 114 , 103 , 340) 
	local altitude_tape_running_txt = running_txt_add_ver(728 , 103 , 7 , 60 , 57 , altitude_tape_callback , font_altitude_tape_running_txt) 
	viewport_rect(altitude_tape_running_txt , 703 , 114 , 103 , 340) 
	
	local grp_altimeter_tape = group_add(altitude_tape,altitude_tape_running_txt) 
	visible(grp_altimeter_tape, false) 
	
	-- Altitude trend indicator -- 
	local img_altitude_trend_border = img_add("speedtrend.png", 704 , 284 , 6 , 0) 
	local img_altitude_trend = img_add("speedtrend.png", 704 , 284 , 5 , 0) 
	local img_altitude_trend_base = img_add("color_white.png", 704 , 284 , 6 , 0) 
	local grp_altitude_trend = group_add(img_altitude_trend_border, img_altitude_trend, img_altitude_trend_base) 
	visible(grp_altitude_trend, false) 

	-- Autopilot Altitude set -- 
	local txt_altitude_set = txt_add("", font_altitude_set_cyan, 705 , 88 , 101 , 22) 
	local img_altitude_bug = img_add("altitude_bug.png", 696 , 282 , 25 , 8) 
	img_rotate(img_altitude_bug, 90) 
	viewport_rect(img_altitude_bug, 695 , 114 , 30 , 341) 
	group_add(grp_altimeter_tape, img_altitude_bug, txt_altitude_set )
   
	-- Barometric minimums --
	local img_baro_min_bug = img_add("baro_min_bug.png", 704 , 270 , 10 , 31) 
	viewport_rect(img_baro_min_bug, 695 , 114 , 30 , 341) 
	
	img_baro_min_window_border = img_add("color_white.png", 620, 460, 80, 45)
	img_baro_min_window = img_add("color_black.png", 622, 462, 76, 41)
	txt_baro_min_title = txt_add("BARO MIN", "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: white; -fx-text-alignment:left", 625, 465, 90, 18)
	txt_baro_min_set = txt_add("---", "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: cyan; -fx-text-alignment:right", 625, 485, 70, 18)
	local grp_minimums = group_add(img_baro_min_bug, img_baro_min_window_border, img_baro_min_window, txt_baro_min_title, txt_baro_min_set)
	visible(grp_minimums, false)
	
	-- Altitude clock 
	-- Box 
	local img_altitude_clock_pointer_box = img_add("color_black.png", 709 , 277 , 16 , 16) 
	img_rotate(img_altitude_clock_pointer_box, 45) 
	local img_altitude_100_clock = img_add("color_black.png", 717 , 264 , 54 , 41) 
	local img_altitude_10_clock = img_add("color_black.png", 771 , 251 , 34 , 67) 
	local grp_altitude_clock = group_add(img_altitude_clock_pointer_box,img_altitude_100_clock,img_altitude_10_clock) 
	visible(grp_altitude_clock, false) 

	-- Running text altimeter clock -- 

	local function alt_10_value_callback(i) 
		return string.format("%02d", (4- (i%5) ) * 20 ) 
	end 
	local running_txt_alt_10 = running_txt_add_ver(771 , 215 ,5,34,28,alt_10_value_callback,font_altitude_clock_small) 
	running_txt_viewport_rect(running_txt_alt_10, 772 , 257 , 32 , 54) 

	local function alt_100_value_callback(i) 
		return (0 - i) % 10 
	end 
	local running_txt_alt_100 = running_txt_add_ver(757, 243,3,17,28, alt_100_value_callback,font_altitude_clock_small) 
	running_txt_viewport_rect(running_txt_alt_100, 758 , 268 , 32 , 32) 

	local function alt_1000_value_callback(i) 
		return ((0 - i) % 100) 
	end 
	local running_txt_alt_1000 = running_txt_add_ver(707 , 240,3,50,28,alt_1000_value_callback,font_altitude_clock_big) 
	running_txt_viewport_rect(running_txt_alt_1000, 707 , 268 , 100 , 32) 
	local grp_running_text_altitude = group_add(running_txt_alt_10,running_txt_alt_100,running_txt_alt_1000) 
	visible(grp_running_text_altitude,false) 

	-- Meters -- 
	local img_meters_1 = img_add("color_white.png" , 703 , 64 , 106 , 24) 
	local img_meters_2 = img_add("color_black.png" , 704 , 65 , 104 , 22) 
	local txt_meters_alt_set = txt_add("", font_alt_meters,705 , 66 , 102 , 20) 
	local img_meters_3 = img_add("color_white.png" , 715 , 226 , 90 , 26) 
	local img_meters_4 = img_add("color_black.png" , 716 , 227 , 88 , 24) 
	local txt_meters_alt = txt_add("", font_alt_meters,717 , 228 , 86 , 22) 
	local grp_meters = group_add(img_meters_1,img_meters_2,img_meters_3,img_meters_4,txt_meters_alt,txt_meters_alt_set) 
	visible(grp_meters,false) 
	local meters = 0 -- Meters visible? 0=no 1=yes 

	-- BARO -- 
	local BARO_unit = 0  -- 0=IN 1=HPA 
	local txt_BARO_value = txt_add("", font_BARO_value , 708 , 457 , 70 , 20) 
	local txt_BARO_title = txt_add("", font_BARO_title, 780 , 464 , 35 , 20) 
	local grp_BARO = group_add(txt_BARO_title,txt_BARO_value) 
	visible(grp_BARO, false) 

	-- ERROR -- 
	local img_ALT_box_X = img_add("RedX.png" , 703 , 113 , 103 , 341) 
	local txt_ALTerror1 = txt_add("ALT" , font_Error , 158 , 230 , 84 , 20) 
	local txt_ALTerror2 = txt_add("FAIL" , font_Error , 158 , 250 , 84 , 20) 
	local ALTerror = group_add(img_ALT_box_X, txt_ALTerror1, txt_ALTerror2) 
	visible(ALTerror,false) 
   
	local function timer_callback_altimeter_startup() 
		visible(grp_altimeter_box, true) 
		visible(grp_altimeter_tape, true) 
		visible(grp_altitude_clock, true) 
		visible(grp_altimeter_clock_numbers, true) 
		visible(grp_altimeter_tape, true) 
		visible(grp_BARO, true) 
		visible(grp_running_text_altitude, true) 
		visible(grp_altitude_trend, true) 
		visible(grp_VSI, true) 
   end
   
   function power_altimeter(condition) 
		visible(grp_altimeter_box, false) 
		visible(grp_altimeter_tape, false) 
		visible(grp_altitude_clock, false) 
		visible(grp_altimeter_clock_numbers, false) 
		visible(grp_altimeter_tape, false) 
		visible(grp_BARO, false) 
		visible(grp_running_text_altitude, false) 
		visible(grp_altitude_trend, false) 
		visible(grp_VSI, false) 
		if condition == true then 
			tmr_altimeter_startup = timer_start(6000, nil, timer_callback_altimeter_startup) 
		end 
	end 
	
   ---------- 
   -- BARO -- 
   ---------- 
   BAROinHG = 0 

   function dial_baro_turned_up() 
		xpl_command("sim/instruments/barometer_up") 
		fsx_event("KOHLSMAN_INC") 
   end 

   function dial_baro_turned_down() 
		xpl_command("sim/instruments/barometer_down") 
		fsx_event("KOHLSMAN_DEC") 
   end 

   function baro_press() 
		xpl_command("sim/instruments/barometer_2992") 
		fsx_variable_write("KOHLSMAN SETTING MB", "Millibars", 29.92) 
   end 
   
   -- MINIMUMS
	baro_minimums = 200 
	function get_baro_minimums()
		return baro_minimums
	end

	function set_baro_minimums(value)
		baro_minimums = value 
		txt_set(txt_baro_min_set, baro_minimums)
	end
	
	------------
	-- ALTITUDE
	------------
	
	function alt_meters() 
		if meters == 0 then 
			meters = 1 
			visible(grp_meters,true) 
		else 
			meters = 0 
			visible(grp_meters,false) 
		end 
	end 

	function alt_in() 
		BARO_unit = 0 
		txt_set(txt_BARO_value,var_format(var_round(BAROinHG, 2),2)) 
		txt_set(txt_BARO_title, "IN") 
	end 

	function alt_hpa() 
		BARO_unit = 1 
		HPApr = BAROinHG * 33.8638815 
		txt_set(txt_BARO_value, var_round(HPApr, 0)) 
		txt_set(txt_BARO_title, "HPA") 
	end 
	
	function change_reference_altitude_up(change) -- TODO
		reference_altitude = reference_altitude + change 
	end
	
	-- Variables for altitude alerting
	local setAlt = 9999 -- comparison for change in set AP altitude
	xpl_dataref_write ( "sim/cockpit/autopilot/altitude", "FLOAT", 4000 ) -- set initial AP altitude at FL060
	local warning_within_1000_set = false	--
	local warning_within_200_set = false	-- initialize all altitude warning checkers
	local warning_deviation_200_set = false	--

	local flash_count = 1 -- counter for the altitude alert flashes

	function FLASH_1000()
		if flash_count == 1 or flash_count == 2 or flash_count == 3 or flash_count == 4  or flash_count == 5 then
			visible(img_set_alt_box_cyan,true)
			txt_style(txt_altitude_set, font_altitude_set_black) 
			if flash_count == 5 then 
			   timer_stop(timer_FLASH_1000)
			end 
		else
			visible(img_set_alt_box_cyan,false)
			txt_style(txt_altitude_set, font_altitude_set_cyan)
		end
		flash_count = flash_count + 0.5 
	end

	function FLASH_200()
		if flash_count == 1 or flash_count == 2 or flash_count == 3 or flash_count == 4  or flash_count >= 5 then
			visible(img_set_alt_box_cyan,false)
			txt_style(txt_altitude_set, font_altitude_set_cyan) 
			if flash_count == 5 then 
			   stop_timer(timer_FLASH_200)
			end
		else
			visible(img_set_alt_box_cyan,true)
			txt_style(txt_altitude_set, font_altitude_set_black)
		end
		flash_count = flash_count + 0.5 
	end
	
	function FLASH_deviated()
		if flash_count == 1 or flash_count == 2 or flash_count == 3 or flash_count == 4  or flash_count == 5 then
			visible(img_set_alt_box_gold,true)
			txt_style(txt_altitude_set, font_altitude_set_black)
		else
			visible(img_set_alt_box_gold,false)
			txt_style(txt_altitude_set, font_altitude_set_yellow) 
			if flash_count == 5.5 then 
				stop_timer(timer_FLASH_deviated) 
			end
		end
		flash_count = flash_count + 0.5
	end
	
	function new_altitude(onground, altitude, AP_altitude, vvi_status, VertSpdReq, VertSpd, radioAlt, DH) 
		if power_on then
		-- Altitude Flash Alert --
			-- first reset alerts if AP altitude changes
			if setAlt ~= AP_altitude then 
				warning_within_1000_set = false 
				warning_within_200_set = false 
				warning_deviation_200_set = false
				setAlt = AP_altitude
			
				-- Check if the timers are running to stop them
				if timer_running(timer_FLASH_1000) then
					timer_stop(timer_FLASH_1000)
				end
				if timer_running(timer_FLASH_200) then
					timer_stop(timer_FLASH_200)
				end
				if timer_running(timer_FLASH_deviated) then
					timer_stop(timer_FLASH_deviated)
				end
			end
			
			--if onground == 0 then -- Only evaluate the ALT alert when airborne
			
				-- check if we are within 1000 ft of set AP altitude
				if math.abs(AP_altitude-altitude) < 1000 then -- if so
					if warning_within_1000_set == false then -- and alert is not triggered yet
						warning_within_1000_set = true -- set alert to triggered
						flash_count = 0
						timer_FLASH_1000 = timer_start(0, 500, FLASH_1000) -- start flashing
					end 
				end
				
				-- check if we are within 200 ft of set AP altitude, as above
				if math.abs(AP_altitude-altitude) < 200 then 
					if warning_within_200_set == false then
						warning_within_200_set = true 
						flash_count = 0
						timer_FLASH_200 = timer_start(0,500,FLASH_200)
					end
				end
				
				if warning_within_1000_set == true and warning_within_200_set == true and math.abs(AP_altitude-altitude) > 200 then 
					if warning_deviation_200_set == false then
						warning_deviation_200_set = true
						flash_count = 0
						timer_FLASH_deviated = timer_start(0,500,FLASH_deviated) 
					end
				end
			--end

			-- MINMUMS
			
			if (altitude - baro_minimums) <	2500 then
				visible(grp_minimums, true)
				if altitude <= baro_minimums then 
					txt_style(txt_baro_min_set, "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: gold; -fx-text-alignment:right" )
				elseif (altitude - baro_minimums) <	100 then 
					txt_style(txt_baro_min_set, "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: white; -fx-text-alignment:right" )
				else
					txt_style(txt_baro_min_set, "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: cyan; -fx-text-alignment:right" )
				end
			else
				visible(grp_minimums, false)
			end
			
			-- Vertical speed --
			-- Autopilot VVI Status. 0=off,1=armed,2=captured
			if vvi_status ~= 0 then
				local deltaVSIreq = -VertSpdReq * 0.07 -- 70 pixels / 1000 ft 
				local deltaVSIreq = var_cap(deltaVSIreq, -154, 154) -- Equivalent of 2200 ft, blocks the vertical speed deflection 
				move(img_vertical_speed_requested, nil , 272 + deltaVSIreq, nil , nil) 
				visible(img_vertical_speed_requested, true)
			else
				visible(img_vertical_speed_requested, false)
			end
			
			if math.abs(VertSpd) > 100 then 
				txt_set(txt_vertical_speed, var_round((VertSpd/50),0)*50) 
			else 
				txt_set(txt_vertical_speed, "")
			end 
			
			local deltaVSI = -VertSpd * 0.07 -- 70 pixels / 1000 ft 
			local deltaVSI = var_cap(deltaVSI, -154, 154) -- Equivalent of 2200 ft, blocks the vertical speed deflection 
			move(img_vertical_speed, 811 , 274 + deltaVSI, 50 , 20) 
			move(txt_vertical_speed, 815 , 275 + deltaVSI, 50 , 15)
			
			-- -- Altitude trend -- 
			local altitude_trend = 0.57 * math.abs(VertSpd / 10) -- trend in 6 seconds ; 0.575pixels/ft
			if altitude_trend > 170 then altitude_trend = 170 end
			if VertSpd > 0 then
				visible(grp_altitude_trend, true)
				move(img_altitude_trend_border,704, 285  - altitude_trend  , 4 , altitude_trend )
				move(img_altitude_trend,704, 285  - altitude_trend  , 4 , altitude_trend )
			elseif VertSpd < 0 then
				visible(grp_altitude_trend, true)
				move(img_altitude_trend_border,704, 285, 4 , altitude_trend)
				move(img_altitude_trend,704, 285, 4 , altitude_trend)
			elseif VertSpd == 0 then
				visible(grp_altitude_trend, false)
			end
			
			-- Altitude indicator -- 
			-- Tape -- 
			running_txt_move_carot(altitude_tape_running_txt, (altitude /100) * -1) 
			running_img_move_carot(altitude_tape, (altitude / 100) * -1) 
			-- Altimeter drums -- 
			running_txt_move_carot(running_txt_alt_10, ((20+altitude) / 20) * -1) 
			if (altitude % 100) > 80 then 
				running_txt_move_carot(running_txt_alt_100, (math.floor( altitude / 100 )+(((altitude%100)-80)/20))*-1) 
			else 
				running_txt_move_carot(running_txt_alt_100, (math.floor( altitude / 100 )) * -1) 
			end 
			if (altitude % 1000) > 980 then 
				running_txt_move_carot(running_txt_alt_1000, (math.floor( altitude / 1000 )+(((altitude%100)-80)/20))*-1) 
			else 
				running_txt_move_carot(running_txt_alt_1000, (math.floor( altitude / 1000 )) * -1) 
			end 
			-- Altitude set -- 
			txt_set(txt_altitude_set, AP_altitude) 
			local bug_movement = var_cap((AP_altitude-altitude), -300, 300)
			move(img_altitude_bug, nil , 282 - (bug_movement*57/100), nil , nil) -- 57pixels/100ft 
			-- DH 
			move(img_baro_min_bug, nil , 270 - ((baro_minimums-altitude)*57/100), nil , nil) -- 57pixels/100ft 
			-- Altitude metric -- 
			if meters == 1 then 
				txt_set(txt_meters_alt_set, string.format("%03d" .. "MT" , var_round((AP_altitude * 0.3048),0))) -- 0.3048 meter/foot 
				txt_set(txt_meters_alt, string.format("%03d" .. "MT" , var_round((altitude * 0.3048),0))) 
			end 
		end 
   end

	-- Barometer -- 

	function baro_standard()
		xpl_command("sim/instruments/barometer_2992") 
		fsx_variable_write("KOHLSMAN SETTING MB", "Millibars", 29.92) 
	end 
	
	local function new_BARO(inHG) 
		if inHG > 0 then 
			BAROinHG = inHG 
		end 
		if BARO_unit == 0 then 
			txt_set(txt_BARO_value, new_var_format(BAROinHG, 2) ) 
			txt_set(txt_BARO_title, "IN") 
		elseif BARO_unit == 1 then 
			HPApr = BAROinHG * 33.8638815 
			txt_set(txt_BARO_value, new_var_format(HPApr, 0)) 
			txt_set(txt_BARO_title, "HPA") 
		end 
	end 

   --------------------------------------------------------------------------------------------- 

   xpl_dataref_subscribe(
						"sim/flightmodel/failures/onground_any", "INT",
						"sim/cockpit2/gauges/indicators/altitude_ft_pilot" , "FLOAT" , 
						"sim/cockpit/autopilot/altitude", "FLOAT", 
						"sim/cockpit2/autopilot/vvi_status", "INT",
						"sim/cockpit/autopilot/vertical_velocity", "FLOAT",
						"sim/cockpit2/gauges/indicators/vvi_fpm_pilot", "FLOAT",
						"sim/cockpit2/gauges/actuators/radio_altimeter_bug_ft_pilot", "FLOAT", 
						"sim/cockpit/misc/radio_altimeter_minimum", "FLOAT", 
						new_altitude) 
						
   -- fsx_variable_subscribe(
						-- "INDICATED ALTITUDE", "Feet", 
						-- "AUTOPILOT ALTITUDE LOCK VAR", "Feet", 
						-- "AUTOPILOT VERTICAL HOLD VAR", "Feet/minute", 
						-- "RADIO HEIGHT", "Feet", 
						-- new_altitude)

   --------------------------------------------------------------------------------------------- 
   xpl_dataref_subscribe("sim/cockpit2/gauges/actuators/barometer_setting_in_hg_pilot","FLOAT", new_BARO)
	
   fsx_variable_subscribe("KOHLSMAN SETTING HG", "inHg", new_BARO) 

end 
