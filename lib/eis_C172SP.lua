------------------------------------------------
-- Engine Information System Window
------------------------------------------------

function init_eis_C172SP_lib(instrument_operator)

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
	local Vglide = 68
	local Vr = 55
	local Vx = 62
	local Vy = 74
	
	set_factory_vref(Vglide, Vr, Vx, Vy)
	set_vref(Vglide, Vr, Vx, Vy)
	
	--===================================================================================================
	--===================================================================================================
	--===================================================================================================
	--===================================================================================================
	--===================================================================================================

	
	font_eis_white =  "-fx-font-family:Arial; -fx-font-size:20px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:center"

	local img_eis = img_add("EIS_C172SP.png",0, 56, 150 , 685)

	local img_prop_rpm_pointer = img_add("RollPointer.png", 65, 65, 15, 115)
	local txt_prop_rpm = txt_add("RPMX", font_eis_white, 0, 150, 150, 20)
	
	local img_fuel_flow = img_add("EIS_pointer.png", 3, 210, 14, 18)

	local img_oil_psi_pointer = img_add("EIS_pointer.png", 3, 270, 14, 18)
	
	local img_oil_temp_pointer = img_add("EIS_pointer.png", 3, 330, 14, 18)
	
	local img_egt_pointer = img_add("EIS_pointer.png", 3, 390, 14, 18)
	
	local img_vac_pointer = img_add("EIS_pointer.png", 3, 449, 14, 18)
	
	local img_fuel_left = img_add("fuel_tank1_pointer.png", 0, 510, 20, 15)
	local img_fuel_right = img_add("fuel_tank2_pointer.png", 0, 530, 20, 15)
	local txt_fuel_left = txt_add("L", font_fuel_black, 7, 509, 10, 20)
	local txt_fuel_right = txt_add("R", font_fuel_black, 7, 532, 10, 20)

	local txt_eng_hrs = txt_add("0", font_eis_white, 70, 575, 80, 20)
	
	local txt_main_bus_volts = txt_add("0.0", font_eis_white, 0, 655, 50, 20)
	
	local txt_essential_bus_volts = txt_add("0.0", font_eis_white, 100, 655, 50, 20)
	
	local txt_main_battery = txt_add("+0", font_eis_white, 0, 710, 75, 20)
	
	local txt_standby_battery = txt_add("+0", font_eis_white, 75, 710, 75, 20)
	
	local 	grp_engine_window = group_add(img_eis, img_prop_rpm_pointer, txt_prop_rpm, img_fuel_flow, img_oil_psi_pointer, img_oil_temp_pointer, img_egt_pointer, img_vac_pointer, 
									img_fuel_left, img_fuel_right, txt_fuel_left, txt_fuel_right, txt_eng_hrs, txt_main_bus_volts, txt_essential_bus_volts, txt_main_battery, txt_standby_battery)
 	visible(grp_engine_window,false)


	local eis_visible = false

	function C172SP_eis_open()
		OAT_position(213, 524)
		visible(grp_engine_window, true)
		eis_visible = true
		set_map_eis(true)
	end


	function C172SP_eis_close()
		OAT_position(1, 722)
		visible(grp_engine_window, false)
		eis_visible = false
		skmenu.setPage = "menu_main"
		skmenu("build")
		set_map_eis(false)
	end


	local fuelInTank = 0

	local function C172SP_new_prop_rpm(rpm)
		if eis_visible then 
			img_rotate(img_prop_rpm_pointer, (rpm[1]/3000) * 160 - 100)
			txt_set(txt_prop_rpm, var_round(rpm[1],0) )
		end
	end
	xpl_dataref_subscribe("sim/cockpit2/engine/indicators/prop_speed_rpm", "FLOAT[8]" , C172SP_new_prop_rpm)

	
	local function C172SP_new_oil_press(psi, red_lo_oilP, red_hi_oilP)
		move(img_oil_psi_pointer, ( ( (psi[1]-red_lo_oilP)/(red_hi_oilP-red_lo_oilP) ) * 130 + 3), nil, nil, nil)
	end
	xpl_dataref_subscribe(	"sim/cockpit2/engine/indicators/oil_pressure_psi", "FLOAT[8]" ,
							"sim/aircraft/limits/red_lo_oilP", "FLOAT", 
							"sim/aircraft/limits/red_hi_oilP", "FLOAT", 
							C172SP_new_oil_press)

							
	local function C172SP_new_egt(itt, max_itt, ignition)

		if eis_visible then
			move(img_egt_pointer, ((itt[1]/max_itt) * 130 + 3), nil, nil, nil)
			
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
							C172SP_new_egt)

	local function C172SP_new_vac(value, red_lo, red_hi)
			if value > red_lo then 
				move(img_vac_pointer, (((value-red_lo)/(red_hi-red_lo)) * 130 + 3), nil, nil, nil)
			end
	end
	xpl_dataref_subscribe(	"sim/cockpit/misc/vacuum", "FLOAT",
							"sim/aircraft/limits/red_lo_vac", "FLOAT",
							"sim/aircraft/limits/red_hi_vac", "FLOAT", C172SP_new_vac)
	
	
	
	local function C172SP_new_oil_temp(celsius, max_temp)
		move(img_oil_temp_pointer, ((celsius[1]/max_temp) * 130 + 3), nil, nil, nil)
	end
	xpl_dataref_subscribe(	"sim/cockpit2/engine/indicators/oil_temperature_deg_C", "FLOAT[8]",
							"sim/aircraft/engine/acf_max_OILT", "FLOAT", C172SP_new_oil_temp)

		
	local function C172SP_new_fuel(flow, quan, max)
		
		if eis_visible then

			move(img_fuel_flow, 130 * ((flow[1]+flow[2]) * 0.3674371036414626 * 3600) / 20 , nil, nil, nil)	-- ((flow[1]+flow[2]) * 0.3674371036414626 * 3600)
			
			-----------------------------------------------------------------------------------------------
			
			move(img_fuel_left, -3 + 130 * (quan[1]/(max/2)) , nil, nil, nil)
			move(img_fuel_right, -3 + 130 * (quan[2]/(max/2)) , nil, nil, nil)
			
			move(txt_fuel_left, 2 + 130 * (quan[1]/(max/2)) , nil, nil, nil)
			move(txt_fuel_right, 2 + 130 * (quan[2]/(max/2)) , nil, nil, nil)
			
		end
		
	end
	xpl_dataref_subscribe(	"sim/flightmodel/engine/ENGN_FF_", "FLOAT[9]" , --kg/s
							"sim/cockpit2/fuel/fuel_quantity", "FLOAT[9]" , --kg
							"sim/aircraft/weight/acf_m_fuel_tot", "FLOAT", --kg
							C172SP_new_fuel)
							
							
							

	local function new_eng_hrs(hr, min)
		if eis_visible then 
			txt_set(txt_eng_hrs, hr..":"..min)
		end
	end
	xpl_dataref_subscribe(	"sim/cockpit2/clock_timer/hobbs_time_hours", "INT",
							"sim/cockpit2/clock_timer/hobbs_time_minutes", "INT",new_eng_hrs)	
	
	local function new_electrics(busV, battA)
			txt_set(txt_main_bus_volts, new_var_format(busV[1],1) )
			txt_set(txt_essential_bus_volts, new_var_format(busV[1],1) )
			txt_set(txt_main_battery, new_var_format(battA[1],1) )
			txt_set(txt_standby_battery, new_var_format(battA[1],1) )
	end
	xpl_dataref_subscribe(	"sim/cockpit2/electrical/bus_volts", "FLOAT[6]",
							"sim/cockpit2/electrical/battery_amps", "FLOAT[8]",
							new_electrics)

end
	