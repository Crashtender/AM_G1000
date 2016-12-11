------------------------------------------------
-- Engine Information System Window
------------------------------------------------

function init_eis_lib(instrument_operator)

	--===================================================================================================
	--
	--		2) AIRCRAFT SPECIFIC VARIABLES
	--
	--===================================================================================================

	------------------
	-- SPEED VARIABLES
	------------------

	-- V-Speeds
	--	Symbol			What Is It?
	--	--------------------------------------------------------
	--	VSO			Stall speed or minimum steady flight speed in the
	--        			landing configuration (flaps fully extended).
	--	VS1        		Stall speed or minimum steady flight speed in the
	--				clean configuration (flaps fully retracted).
	--	VR              	Rotation speed. The speed at which the nosewheel
	--				is lifted from the runway during takeoff.
	--	VX              	Best Angle speed. In a climb it provides the
	--				maximum gain in altitude for the distance traveled
	--				forward.
	--	VY              	Best Rate speed. In a climb it provides the
	--				maximum gain in altitude per unit of time traveled.
	--             
	--	VENROUTE
	--	CLIMB			In a climb it provides increased forward visibility
	--				and engine cooling.
	--	VBEST
	--	GLIDE			In a glide it provides the maximum distance traveled
	--				forward with the minimum altitude lost.
	--	VFE			Full Flaps Extended speed. Maximum speed at
	--				which flaps may be fully extended.
	--	VA			Design Maneuvering speed. Maximum speed at
	--				which full, abrupt deflection of the controls can be
	--				made without causing structural damage. Reduce
	--				speed to this value when in rough air.
	--	VNO			Maximum Structural Cruising speed. Do not
	--				exceed this speed except in smooth air.
	--	VNE			Never Exceed speed. Do not exceed this speed
	--				under any circumstances.


	-- AIRCRAFT SPECIFIC VALUES THESE NEED TO BE PUT IN BY HAND
	local Vglide = 80
	local Vr = 60
	local Vx = 75
	local Vy = 91
	--===================================================================================================

	local font_eis_green =  "-fx-font-family:Arial; -fx-font-size:20px; -fx-fill: green; -fx-font-weight:bold; -fx-text-alignment:right"

	local img_eis = img_add("eis_TBM850.png",0, 55, 207 , 685)

	local img_trq_pointer = img_add("RollPointer.png", 65, 65, 15, 115)
	local img_prop_rpm_pointer = img_add("RollPointer.png", 65, 147, 15, 115)
	local img_ng_pointer = img_add("RollPointer.png", 65, 229, 15, 115)
	img_itt_start = img_add("itt_start.png", 64, 305, 59, 30)
	img_itt_pointer = img_add("RollPointer.png", 65, 311, 15, 115)

	local img_oil_psi_pointer = img_add("EIS_pointer.png", 3, 410, 14, 18)
	local img_oil_temp_pointer = img_add("EIS_pointer.png", 3, 460, 14, 18)

	local img_elev_pointer = img_add("EIS_pointer.png",184,600,10,18) -- min 545 - avg 600 - max 655
	img_rotate(img_elev_pointer,-90)

	local txt_trq = txt_add("88.8", font_eis_green, 95, 110, 50, 20)
	local txt_prop_rpm = txt_add("8888", font_eis_green, 85, 195, 60, 20)
	local txt_ng = txt_add("88.8", font_eis_green, 85, 280, 60, 20)
	local txt_itt_start = txt_add("OFF", "-fx-font-family:Arial; -fx-font-size:10px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left", 110, 308, 60, 20)
	local txt_itt = txt_add("888", font_eis_green, 85, 362, 60, 20)

	local txt_oil_psi = txt_add("888", font_eis_green, 85, 390, 60, 20)
	local txt_oil_temp = txt_add("88", font_eis_green, 85, 440, 60, 20)

	local txt_cabin_alt = txt_add("8888", font_eis_green, 85, 508, 60, 20)
	local txt_diff_press = txt_add("8.8", font_eis_green, 85, 530, 60, 20)

	local txt_fuel_left = txt_add("88", font_eis_green, 0, 585, 30, 20)
	local txt_fuel_right = txt_add("88", font_eis_green, 85, 585, 60, 20)
	local txt_fuel_flow = txt_add("88", font_eis_green, 27, 605, 60, 20)

	local txt_amps_batt = txt_add("88", font_eis_green, 85, 643, 60, 20)
	local txt_amps_gen = txt_add("88", font_eis_green, 85, 665, 60, 20)

	local txt_volts_batt = txt_add("88", font_eis_green, 85, 693, 60, 20)
	local txt_volts_ess = txt_add("88", font_eis_green, 85, 715, 60, 20)

	local txt_flaps = txt_add("UP", "-fx-font-family:Arial; -fx-font-size:20px; -fx-fill: cyan; -fx-font-weight:bold; -fx-text-alignment:center", 155, 710, 45, 20)


	local grp_engine_window = group_add(img_eis,img_trq_pointer,img_prop_rpm_pointer,
					  img_ng_pointer,img_itt_start,img_itt_pointer,img_oil_psi_pointer,img_oil_temp_pointer, img_elev_pointer,
					  txt_trq, txt_prop_rpm, txt_ng, txt_itt, txt_itt_start, txt_oil_psi, txt_oil_temp,
					  txt_cabin_alt,txt_diff_press, txt_fuel_left, txt_fuel_right, txt_fuel_flow,
					  txt_amps_batt, txt_amps_gen, txt_volts_batt, txt_volts_ess, txt_flaps)

	visible(grp_engine_window,false)


	local eis_visible = false

	function eis_open()
		OAT_position(213, 524)
		visible(grp_engine_window,true)
		eis_visible = true
	end


	function eis_close()
		OAT_position(1, 722)
		visible(grp_engine_window,false)
		eis_visible = false
		skmenu.setPage = "menu_main"
		skmenu("build")
	end


	local fuelInTank = 0

	local function new_trq(torque, green_lo_TRQ, green_hi_TRQ, yellow_lo_TRQ, yellow_hi_TRQ, red_lo_TRQ, red_hi_TRQ)
		
		-- if torque[1] > yellow_hi_TRQ then
			-- --eis_open()
			-- -- warning red 
			-- return
		-- elseif  torque[1] > green_hi_TRQ then
			-- eis_open()
			-- -- warning yellow
		-- end

		if eis_visible == true then 
			max_torque = 3354

			trq100 = max_torque * 100 / 130
			
			img_rotate(img_trq_pointer, ((torque[1]/max_torque) * 160 - 100) )
			
			txt_set(txt_trq, string.format("%.1f", 100 * torque[1]/trq100) )
			
			--   string.format("%d.%.02d",nav1act/100, nav1act%100))
		end
		
	end

	xpl_dataref_subscribe(	"sim/cockpit2/engine/indicators/torque_n_mtr" , "FLOAT[8]", 
							"sim/aircraft/limits/green_lo_TRQ" , "FLOAT", 
							"sim/aircraft/limits/green_hi_TRQ" , "FLOAT", 
							"sim/aircraft/limits/yellow_lo_TRQ" , "FLOAT", 
							"sim/aircraft/limits/yellow_hi_TRQ" , "FLOAT", 
							"sim/aircraft/limits/red_lo_TRQ" , "FLOAT", 
							"sim/aircraft/limits/red_hi_TRQ" , "FLOAT", 
							new_trq)

	local function new_prop_rpm(rpm)
		if eis_visible then 
			img_rotate(img_prop_rpm_pointer, (rpm[1]/2200) * 160 - 100)
			txt_set(txt_prop_rpm, var_round(rpm[1],0) )
		end
	end
	xpl_dataref_subscribe("sim/cockpit2/engine/indicators/prop_speed_rpm", "FLOAT[8]" , new_prop_rpm)

	local function new_ng(gen_spd)
		if eis_visible then 
			img_rotate(img_ng_pointer, (gen_spd[1]/120) * 160 - 100)
			txt_set(txt_ng, var_round(gen_spd[1],0) )
		end
	end
	xpl_dataref_subscribe("sim/cockpit2/engine/indicators/N1_percent", "FLOAT[8]" ,new_ng)

	-- 	sim/cockpit2/engine/actuators/ignition_key	int[8]	y	enum	0 = off, 1 = left, 2 = right, 3 = both, 4 = starting
	local function new_itt(itt, max_itt, ignition)

		if eis_visible then
		
			if ignition[1] == 4 then
				visible(img_itt_start, true)
				txt_set(txt_itt_start, "STRT")
				if itt[1] > 200 then
					img_rotate(img_itt_pointer, ((itt[1]-200)/(1000-200)) * 160 - 100)
				else
					img_rotate(img_itt_pointer, - 100)
				end
				txt_set(txt_itt, var_round(itt[1],0) )
				
			elseif ignition[1] == 1 or ignition[1] == 2 or ignition[1] == 3 then
				visible(img_itt_start, false)
				txt_set(txt_itt_start, "")
				if itt[1] > 200 then
					img_rotate(img_itt_pointer, ((itt[1]-200)/(1200-200)) * 160 - 100)
				else
					img_rotate(img_itt_pointer, - 100)
				end
				txt_set(txt_itt, var_round(itt[1],0) )
				
			elseif ignition[1] == 0 then
				visible(img_itt_start, true)
				txt_set(txt_itt_start, "OFF")
				itt_lim = var_cap(itt[1],0,700) 
				if itt[1] > 200 then
					img_rotate(img_itt_pointer, ((itt[1]-200)/(700-200)) * 160 - 100)
				else
					img_rotate(img_itt_pointer, - 100)
				end
				txt_set(txt_itt, var_round(itt[1],0) )
			else
			
			end 
		end
	end
	xpl_dataref_subscribe(	"sim/flightmodel/engine/ENGN_ITT_c", "FLOAT[8]",
							"sim/aircraft/engine/acf_max_ITT", "FLOAT",
							"sim/cockpit2/engine/actuators/ignition_key", "INT[8]",
							new_itt)


	local function new_oil_press(psi)
		if eis_visible then 
			move(img_oil_psi_pointer, ((psi[1]/150) * 130 + 3), nil, nil, nil)
			txt_set(txt_oil_psi, var_round(psi[1],0) )
		end
	end
	xpl_dataref_subscribe("sim/cockpit2/engine/indicators/oil_pressure_psi", "FLOAT[8]" ,new_oil_press)

	local function new_oil_temp(celsius)
		if eis_visible then 
			move(img_oil_temp_pointer, ((celsius[1]/150) * 130 + 3), nil, nil, nil)
			txt_set(txt_oil_temp, var_round(celsius[1],0) )
		end
	end
	xpl_dataref_subscribe("sim/cockpit2/engine/indicators/oil_temperature_deg_C", "FLOAT[8]"  ,new_oil_temp)


	local function new_cabin_press(alt, diff)
		if eis_visible then 
			txt_set(txt_cabin_alt, var_round(alt * 3.2808399,0) ) -- 3.2808399 ft/m
			txt_set(txt_diff_press, var_round(diff,1) )
		end
	end
	xpl_dataref_subscribe(	"sim/cockpit/pressure/cabin_altitude_actual_m_msl", "FLOAT" ,
							"sim/cockpit2/pressurization/indicators/pressure_diffential_psi", "FLOAT",
							new_cabin_press)

							
	local function new_fuel(fuel, flow)
		if eis_visible then 
			txt_set(txt_fuel_left, var_round(fuel[1] * 0.3674371036414626, 0) ) -- 0,3674371036414626 gallon/kg
			txt_set(txt_fuel_right, var_round(fuel[2] * 0.3674371036414626, 0) )
			txt_set(txt_fuel_flow, var_round((flow[1]+flow[2]) * 0.3674371036414626 * 3600,0) )
		end
	end
	xpl_dataref_subscribe(	"sim/cockpit2/fuel/fuel_quantity", "FLOAT[9]" , --kg
							"sim/flightmodel/engine/ENGN_FF_", "FLOAT[9]" , --kg/s
							new_fuel)

							
	local function new_electrics(battA, genA, battV, essV)
		if eis_visible then 
			txt_set(txt_amps_batt, var_round(battA[1],1) )
			txt_set(txt_amps_gen, var_round(genA[1],0) )
			txt_set(txt_volts_batt, var_round(battV[1],1) )
			txt_set(txt_volts_ess, var_round(essV[1],1) )
		end
	end
	xpl_dataref_subscribe(	"sim/cockpit2/electrical/battery_amps", "FLOAT[8]",
							"sim/cockpit2/electrical/generator_amps", "FLOAT[8]",
							"sim/cockpit2/electrical/battery_voltage_indicated_volts", "FLOAT[8]",
							"sim/cockpit2/electrical/bus_volts", "FLOAT[6]",
							new_electrics)

	local function new_elevator_trim(trim)
		if eis_visible then 
			move(img_elev_pointer, nil, (trim * 55 + 600), nil, nil) -- min 545 - avg 600 - max 655, -1 = down, 1 = up
		end
	end
	xpl_dataref_subscribe("sim/cockpit2/controls/elevator_trim", "FLOAT"  ,new_elevator_trim)

	local function new_flaps(flaps)				--	0 = up; 0.2 = T/O; 1= LND
		if eis_visible then 
			if flaps == 0 then
				txt_set(txt_flaps, "UP")
			elseif flaps == 0.29411765933036804 then
				txt_set(txt_flaps, "T/O")
			elseif flaps == 1 then
				txt_set(txt_flaps, "LND")
			else
				txt_set(txt_flaps, "...")
			end
		end
	end
	xpl_dataref_subscribe("sim/flightmodel2/controls/flap1_deploy_ratio", "FLOAT" ,new_flaps)


end