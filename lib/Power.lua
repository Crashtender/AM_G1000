--===================================================================================================
-- STARTUP ROUTINE
--===================================================================================================
function init_power_lib()

	local power_off_counter = 0
	
	local function switch_off()
		
			power_on = false
			
			power_splash(false)
			power_HSI(false)
			power_info_bar(false)
			power_bottom_bar(false)
			power_speed_box(false)
			power_altimeter(false)
			power_XPDR_box(false)
			power_time_box(false)
			power_OAT_box(false)
			power_NAV_radios(false)
			power_COM_radios(false)
			power_SK_menu(false)
			power_attitude(false)
			
	end

	local function add_to_counter()
		power_off_counter = power_off_counter + 1
		info_btm_left(power_off_counter)
		if power_off_counter == 5 then 
			switch_off()
		end
	end
	
	local function connection_lost_checker()
		if timer_running(tmr_connection_lost_checker) == false then 
			tmr_connection_lost_checker = timer_start(1000, nil, add_to_counter)
		end
	end
		
	local generator_on = false
	
	local function new_generator(generator, engine_rpm)
		if (generator[1] == 1 and engine_rpm[1] > 200) then 
			generator_on = true
		else
			generator_on = false
		end
	end
	xpl_dataref_subscribe(
						  "sim/cockpit/electrical/generator_on", "INT[8]",
						  "sim/cockpit2/engine/indicators/engine_speed_rpm", "FLOAT[8]",
						  new_generator)
	
	local function powered_on(battery, avionics)
	
		if (battery[1] == 1 or generator_on) and avionics == 1 then
			
			timer_stop(tmr_connection_lost_checker)
			power_off_counter = 0
			power_on = true
			
			power_splash(true)
			power_HSI(true)
			power_info_bar(true)
			power_bottom_bar(true)
			power_attitude(true)
			power_speed_box(true)
			power_altimeter(true)
			power_XPDR_box(true)
			power_time_box(true)
			power_OAT_box(true)
			power_NAV_radios(true)
			power_COM_radios(true)
			power_SK_menu(true)
			
		else
			
			connection_lost_checker()
			
		end
		
	end	
	
	xpl_dataref_subscribe(
					  "sim/cockpit/electrical/battery_array_on", "INT[8]",
					  "sim/cockpit/electrical/avionics_on", "INT",
					  powered_on)

	-- When in development mode make sure the instrument powers on
	if instrument_prop("DEVELOPMENT") then
		new_generator({1,0,0,0,0,0,0,0},{1200.0,0,0,0,0,0,0,0})
		powered_on({1,0,0,0,0,0,0,0}, 1)
		new_HSI_source(0, 0)
	end

end