------------------
-- SPEED VARIABLES
------------------

-- Speed variables are defined in the aircraft specific EIS files

-- V-Speeds
--	Symbol			What Is It?
--	--------------------------------------------------------
--	VSO			Stall speed or minimum steady flight speed in the
--        			landing configuration (flaps fully extended).
--	VS1        	Stall speed or minimum steady flight speed in the
--					clean configuration (flaps fully retracted).
--	VR          Rotation speed. The speed at which the nosewheel
--					is lifted from the runway during takeoff.
--	VX          Best Angle speed. In a climb it provides the
--					maximum gain in altitude for the distance traveled
--					forward.
--	VY          Best Rate speed. In a climb it provides the
--					maximum gain in altitude per unit of time traveled.
--             
--	VENROUTE
--	CLIMB		In a climb it provides increased forward visibility
--					and engine cooling.
--	VBEST
--	GLIDE		In a glide it provides the maximum distance traveled
--					forward with the minimum altitude lost.
--	VFE			Full Flaps Extended speed. Maximum speed at
--					which flaps may be fully extended.
--	VA			Design Maneuvering speed. Maximum speed at
--					which full, abrupt deflection of the controls can be
--					made without causing structural damage. Reduce
--					speed to this value when in rough air.
--	VNO			Maximum Structural Cruising speed. Do not
--					exceed this speed except in smooth air.
--	VNE			Never Exceed speed. Do not exceed this speed
--					under any circumstances.

------------------------------------------------
-- Airspeed Indicator
------------------------------------------------

function init_speed_lib()

	-- Reference speeds for colored speed tape --
	local Vs0 = 0
	local Vs1 = 0
	local Vfe = 0
	local Vno = 0
	local Vne = 0
	local Vyse = 0
	
	-- Visual elements
	------------------
	-- Speed box layout
	local img_speedbox_1 = img_add("color_white.png" , 152 , 111 , 88 , 2)
	local img_speedbox_2 = img_add("color_white.png" , 152 , 454 , 88 , 2)
	local img_speedbox_3 = img_add("color_white.png" , 152 , 112 , 2 , 343)
	local img_speedbox_4 = img_add("color_white.png" , 239 , 112 , 2 , 343)
	local img_speedbox_5 = img_add("TR_25_Black.png" , 154 , 113 , 84 , 341)
	local grp_speedbox_borders = group_add(img_speedbox_1,img_speedbox_2,img_speedbox_3,img_speedbox_4,img_speedbox_5)
	visible(grp_speedbox_borders, false)

	-- TAS layout
	local TASboxTop = img_add("color_white.png" , 153 , 455 , 86 , 1)
	local TASboxBG = img_add("color_black.png" , 154 , 456 , 84 , 24)
	local TASboxBottom = img_add("color_white.png" , 152 , 480 , 88 , 2)
	local TASboxLeft = img_add("color_white.png" , 152 , 455 , 2 , 26)
	local TASboxRight = img_add("color_white.png" , 239 , 455 , 2 , 26)
	local txt_TASboxTitle = txt_add("TAS           KT" , "-fx-font-family:Arial; -fx-font-size:12px; -fx-fill: white; -fx-text-alignment:center;" , 157 , 464 , 84 , 16)
	local txt_TASboxSpeed = txt_add("" , "-fx-font-family:Arial; -fx-font-size:20px; -fx-fill: white; -fx-text-alignment:right;" , 158 , 457 , 60 , 20)
	local grp_TASbox = group_add(TASboxTop,TASboxBG,TASboxBottom,TASboxLeft,TASboxRight,txt_TASboxTitle)
	visible(grp_TASbox, false)

	-- Speed trend indicator --
	local img_speed_trend = img_add("speedtrend.png", 240 , 284 , 5 , 0)
	local img_speed_trend_base = img_add("color_white.png", 240 , 284 , 5 , 0)
	local grp_speed_trend = group_add(img_speed_trend, img_speed_trend_base)
	visible(grp_speed_trend, false)

	-- Speed Tape
	local img_speed_range_red = img_add("color_red.png" , 0,0,0,0)
	local img_speed_range_green = img_add("color_green.png" , 0,0,0,0)
	local img_speed_range_green_white_g = img_add("color_green.png" , 0,0,0,0)
	local img_speed_range_green_white_w = img_add("color_green.png" , 0,0,0,0)
	local img_speed_range_white = img_add("color_white.png" , 0,0,0,0)
	local img_speed_range_yellow = img_add("color_yellow.png" , 0,0,0,0)
	viewport_rect(img_speed_range_red, 228 , 115 , 10 , 337)
	viewport_rect(img_speed_range_white,228 , 115 , 10 , 337)
	viewport_rect(img_speed_range_green,228 , 115 , 10 , 337)
	viewport_rect(img_speed_range_green_white_g,228 , 115 , 10 , 337)
	viewport_rect(img_speed_range_green_white_w,228 , 115 , 10 , 337)
	viewport_rect(img_speed_range_yellow,228 , 115 , 10 , 337)

	-- Vref speeds
	local img_Vglide = img_add("Vref_indicator.png" , 242 , 278 ,  19 , 15)
	local txt_Vglide = txt_add("G", font_Vref, 248 , 279 , 18 , 12)
	viewport_rect(img_Vglide, 242 , 115 , 30 , 337)
	viewport_rect(txt_Vglide, 242 , 115 , 30 , 337)

	local img_Vr = img_add("Vref_indicator.png" , 242 , 278 ,  19 , 15)
	local txt_Vr = txt_add("R", font_Vref, 248 , 279 , 18 , 12)
	viewport_rect(img_Vr, 242 , 115 , 30 , 337)
	viewport_rect(txt_Vr, 242 , 115 , 30 , 337)

	local img_Vx = img_add("Vref_indicator.png" , 242 , 278 ,  19 , 15)
	local txt_Vx = txt_add("X", font_Vref, 248 , 279 , 18 , 12)
	viewport_rect(img_Vx, 242 , 115 , 30 , 337)
	viewport_rect(txt_Vx, 242 , 115 , 30 , 337)

	local img_Vy = img_add("Vref_indicator.png" , 242 , 278 ,  19 , 15)
	local txt_Vy = txt_add("Y", font_Vref, 248 , 280 ,  18 , 12)
	viewport_rect(img_Vy, 242 , 115 , 30 , 337)
	viewport_rect(txt_Vy, 242 , 115 , 30 , 337)
	
	local grp_Vref = group_add(img_Vglide,img_Vr,img_Vx,img_Vy,txt_Vglide,txt_Vr,txt_Vx,txt_Vy)
	visible(grp_Vref, Vref_visible)
	
	function show_Vref(condition)
		visible(grp_Vref, condition)
	end

	function show_Vglide(condition)
		visible(img_Vglide, condition)
		visible(txt_Vglide, condition)
	end

	function show_Vr(condition)
		visible(img_Vr, condition)
		visible(txt_Vr, condition)
	end

	function show_Vx(condition)
		visible(img_Vx, condition)
		visible(txt_Vx, condition)
	end

	function show_Vy(condition)
		visible(img_Vy, condition)
		visible(txt_Vy, condition)
	end

	-- Speed Tape
	local function speed_tape_callback(indicated_airspeed)
		   if ( - (indicated_airspeed * 10)) < 0 then return "" else
		return string.format("%d", - (indicated_airspeed * 10))
		end
	end
	local speed_tape = running_img_add_ver("speedtape.png" , 221 , 115 , 7 , 14 , 57)
	viewport_rect(speed_tape , 220 , 114 , 103 , 341)
	local speed_tape_running_txt = running_txt_add_ver(165 , 103 , 7 , 50 , 57 , speed_tape_callback , "-fx-font-family:Arial; -fx-font-size:20px; -fx-fill: grey; -fx-text-alignment:right;")
	viewport_rect(speed_tape_running_txt , 165 , 113 , 103 , 341)
	local grp_speedtape = group_add(speed_tape, speed_tape_running_txt, txt_TASboxSpeed,img_speed_range_red,img_speed_range_white,img_speed_range_green,img_speed_range_yellow)
	visible(grp_speedtape, false)

	-- Speed Clock
	-- Black BG
	local img_airspeed_major_clock_black = img_add("color_black.png", 158 , 264 , 47 , 41)
	local img_airspeed_minor_clock_black = img_add("color_black.png", 204 , 251 , 26 , 67)
	local img_airspeed_clock_pointer_box_black = img_add("color_black.png", 217 , 277 , 16 , 16)
	img_rotate(img_airspeed_clock_pointer_box_black, 45)
	local grp_airspeed_indicator_speed_clock_black = group_add(img_airspeed_major_clock_black, img_airspeed_minor_clock_black, img_airspeed_clock_pointer_box_black)
	visible(airspeed_indicator_speed_clock_black, false)

	-- Red BG (overspeed)
	local img_airspeed_clock_pointer_box_red = img_add("color_red.png", 218 , 278 , 14 , 14)
	local img_airspeed_major_clock_red = img_add("color_red.png", 159 , 265 , 47 , 39)
	local img_airspeed_minor_clock_red = img_add("color_red.png", 205 , 252 , 24 , 65)
	img_rotate(img_airspeed_clock_pointer_box_red, 45)
	local grp_airspeed_indicator_speed_clock_red = group_add(img_airspeed_major_clock_red, img_airspeed_minor_clock_red, img_airspeed_clock_pointer_box_red)
	visible(airspeed_indicator_speed_clock_red, false)

	-- Running text speed clock --

	local function item_value_callback_speed_100(i)
		return (0 - i) % 10
	end
	local running_text_speed_100 = running_txt_add_ver(158 , 242, 3 , 24 , 28, item_value_callback_speed_100, font_speed_clock_WHITE)
	running_txt_viewport_rect(running_text_speed_100,150 , 270 , 80 , 30)

	local function item_value_callback_speed_10(i)
		return (0 - i) % 10
	end
	local running_text_speed_10 = running_txt_add_ver(179 , 242, 3 , 24 , 28, item_value_callback_speed_10, font_speed_clock_WHITE)
	running_txt_viewport_rect(running_text_speed_10,150 , 270 , 80 , 30)

	local function item_value_callback_speed_1(i)
		return (0 - i) % 10
	end
	local running_text_speed_1 = running_txt_add_ver(200 , 242, 4 , 24 , 28, item_value_callback_speed_1, font_speed_clock_WHITE)
	running_txt_viewport_rect(running_text_speed_1,206 , 256 , 22 , 57)
	local grp_speedclock_numbers = group_add(running_text_speed_1,running_text_speed_10,running_text_speed_100)
	visible(grp_speedclock_numbers, false)

	-- Airspeed error
	local img_SPD_box_X = img_add("RedX.png" , 154 , 113 , 84 , 341)
	local txt_ASerror1 = txt_add("SPEED" , font_Error , 158 , 230 , 84 , 20)
	local txt_ASerror2 = txt_add("FAIL" , font_Error , 158 , 250 , 84 , 20)
	local ASerror = group_add(img_SPD_box_X, txt_ASerror1, txt_ASerror2)
	group_visible(ASerror, false)
	
	local function timer_callback_speed_power()
		visible(grp_speedtape, true)
		visible(grp_airspeed_indicator_speed_clock_black, true)
		visible(grp_speedclock_numbers, true)
		visible(grp_speedbox_borders, true)
		visible(grp_TASbox, true)
		visible(grp_speed_trend, true)
		visible(grp_Vref, Vref_visible)
	end
	
	function power_speed_box(condition)
		visible(grp_speedtape, false)
		visible(grp_airspeed_indicator_speed_clock_black, false)
		visible(grp_speedclock_numbers, false)
		visible(grp_speedbox_borders, false)
		visible(grp_TASbox, false)
		visible(grp_speed_trend, false)
		visible(grp_Vref, false)
		if condition == true then
			tmr_speed_power = timer_start(6000, nil, timer_callback_speed_power)	
		end
		
	end
	
	local factory_Vglide = g
	local factory_Vr = r
	local factory_Vx = x
	local factory_Vy = y
	
	local Vglide = 0
	local Vr = 0
	local Vx = 0
	local Vy = 0

	local Vs0 = 0
	local Vs1 = 0
	local Vfe = 0
	local Vno = 0
	local Vne = 0
	local Vyse = 0
		
	function set_factory_vref(g, r, x, y)
		factory_Vglide = g
		factory_Vr = r
		factory_Vx = x
		factory_Vy = y
	end
	
	function get_factory_vref()
		return factory_Vglide,factory_Vr,factory_Vx,factory_Vy
	end
			
	function set_vref(g, r, x, y)
		Vglide = g
		Vr = r
		Vx = x
		Vy = y
	end
		
	function get_vref()
		return Vglide,Vr,Vx,Vy
	end
	
	function new_ref_speeds(refVs0, refVs1, refVfe, refVno, refVne, refVyse)
		Vs0 = refVs0
		Vs1 = refVs1
		Vfe = refVfe
		Vno = refVno
		Vne = refVne
		Vyse = refVyse
	end
	xpl_dataref_subscribe(
					  "sim/aircraft/view/acf_Vso", "FLOAT" ,
					  "sim/aircraft/view/acf_Vs", "FLOAT" ,
					  "sim/aircraft/view/acf_Vfe", "FLOAT" ,
					  "sim/aircraft/view/acf_Vno", "FLOAT" ,
					  "sim/aircraft/view/acf_Vne", "FLOAT" ,
					  "sim/aircraft/overflow/acf_Vyse", "FLOAT" ,
					  new_ref_speeds)
					  
	function all_Vref_on()
		visible(grp_Vref, true)
	end
					  
	function all_Vref_off()
		visible(grp_Vref, false)
	end
	
	function Vglide_visibility(condition)
		visible(Vglide, condition)
	end
	
	function Vr_visibility(condition)
		visible(Vr, condition)
	end
	
	function Vx_visibility(condition)
		visible(Vx, condition)
	end
	
	function Vy_visibility(condition)
		visible(Vy, condition)
	end
		
	local function new_speed(acceleration, indicated_airspeed, true_airspeed)

		-- ACCELERATION --
		local acceleration = var_cap(acceleration,-5,5)
		
		if acceleration > 0 then
		   visible(grp_speed_trend, true)
		   move(img_speed_trend,240, 285 - ((6*5.7)*acceleration) , 6 , ((6*5.7)*acceleration)) -- trend in 6 seconds ; 57pixels/10kts = 5.7
		elseif acceleration < 0 then
		   visible(grp_speed_trend, true)
		   move(img_speed_trend,240, 285, 6 , ((6*5.7)*math.abs(acceleration))) -- trend in 6 seconds ; 57pixels/10kts = 5.7 pixels per knot
		elseif acceleration == 0 then
		   visible(grp_speed_trend, false)
		end

		-- SPEED --
		local indicated_airspeed = var_cap(indicated_airspeed, 0, 999)
		
		-- Speed tape running image
		running_txt_move_carot(speed_tape_running_txt, (indicated_airspeed/10) * -1)
		running_img_move_carot(speed_tape, (indicated_airspeed/10) * -1)
		local spdRng_delt_y = indicated_airspeed * 5.7 -- 5.7pixels/kt
		move(img_speed_range_red , 230, (285 + spdRng_delt_y - (999*5.7)), 8 , (999*5.7))
		move(img_speed_range_green , 230, (285 +spdRng_delt_y - (Vno*5.7)), 8 , ((Vno-Vs1)*5.7))
		move(img_speed_range_white , 230, (285 + spdRng_delt_y - (Vfe*5.7)), 5 , ((Vfe-Vs0)*5.7))
		move(img_speed_range_yellow , 230, (285 + spdRng_delt_y - (Vne*5.7)), 8 , ((Vne-Vno)*5.7))
		
		
		-- Speed drums
		
		running_txt_move_carot(running_text_speed_1, (indicated_airspeed-1) * -1)
		
		if (indicated_airspeed % 10) >= 9 then
		   running_txt_move_carot(running_text_speed_10, (indicated_airspeed %1 + math.floor( indicated_airspeed / 10 ) )* -1)
		else
		   running_txt_move_carot(running_text_speed_10, math.floor( indicated_airspeed / 10 ) * -1)
		end
		if (indicated_airspeed % 100) >= 99 then
		   running_txt_move_carot(running_text_speed_100, (indicated_airspeed %1 + math.floor( indicated_airspeed / 100 ) )* -1)
		else
		   running_txt_move_carot(running_text_speed_100, math.floor( indicated_airspeed / 100 ) * -1)
		end
		
		-- TAS
		txt_set(txt_TASboxSpeed, var_round(true_airspeed * 1.943844492, 0)) -- 1.943844492 (m/s => KTS conversion)
		
		move(img_Vglide, nil, 278 - (Vglide*5.7) + (indicated_airspeed*5.7), 19 , 15)
		move(txt_Vglide, nil, 279 - (Vglide*5.7) + (indicated_airspeed*5.7), 18 , 12)

		move(img_Vr, nil, 278 - (Vr*5.7) + (indicated_airspeed*5.7), 19 , 15)
		move(txt_Vr, nil, 279 - (Vr*5.7) + (indicated_airspeed*5.7), 18 , 12)

		move(img_Vx, nil, 278 - (Vx*5.7) + (indicated_airspeed*5.7), 19 , 15)
		move(txt_Vx, nil, 279 - (Vx*5.7) + (indicated_airspeed*5.7), 18 , 12)

		move(img_Vy, nil, 278 - (Vy*5.7) + (indicated_airspeed*5.7), 19 , 15)
		move(txt_Vy, nil, 279 - (Vy*5.7) + (indicated_airspeed*5.7), 18 , 12)
		
		-- speed drum box color
		if indicated_airspeed > Vne then
		   visible(grp_airspeed_indicator_speed_clock_red, true)
		else
		   visible(grp_airspeed_indicator_speed_clock_red, false)
		end
		
		-- speed drum box color
		if (indicated_airspeed + 6 * acceleration) > Vne then
		   txt_style(running_text_speed_1,font_speed_clock_YELLOW)
		   txt_style(running_text_speed_10,font_speed_clock_YELLOW)
		   txt_style(running_text_speed_100,font_speed_clock_YELLOW)
		else
		   txt_style(running_text_speed_1,font_speed_clock_WHITE)
		   txt_style(running_text_speed_10,font_speed_clock_WHITE)
		   txt_style(running_text_speed_100,font_speed_clock_WHITE)
		end
	end

	xpl_dataref_subscribe(
					  "sim/cockpit2/gauges/indicators/airspeed_acceleration_kts_sec_pilot", "FLOAT",
					  "sim/flightmodel/position/indicated_airspeed", "FLOAT", -- KIAS
					  "sim/flightmodel/position/true_airspeed", "FLOAT", -- m/s
					  new_speed)
end