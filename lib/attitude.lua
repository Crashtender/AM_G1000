------------------------------------------------
-- Attitude Indicator
------------------------------------------------

function init_attitude_lib()

	local img_horizon = img_add("horizon.png" , nil , nil , 3000 , 3000)
	viewport_rect(img_horizon , 0, 55, 1024 , 687)

	local img_horizonscale = img_add("horizonscale.png" ,nil, nil , 126 , 1500)
	viewport_rect(img_horizonscale , 340 , 130 , 240 , 270)

	local img_roll_pointer = img_add("RollPointer.png", 449 , 98 , 23 , 115)
	local img_slip_indicator = img_add("slip_indicator.png",  445 , 121 , 31 , 5)
	local grp_attitude_indicator_numbers = group_add(img_horizon,img_horizonscale,img_roll_pointer,img_slip_indicator)
	visible(grp_attitude_indicator_numbers, false)

	local img_roll = img_add("roll.png" , 251 , 72 , 420 , 420)
	local img_attitude_indicator = img_add("attitude_indicator.png" , 261 , 277 , 399 , 45)
	local grp_attitude_indicator = group_add(img_roll, img_attitude_indicator)
	visible(grp_attitude_indicator, false)

	-- Aligning instrument
	local txt_Attitude_Align = txt_add("AHRS ALIGN: Keep Wings Level" , font_AHRS_allign , 270 , 220 , 380 , 25)
	visible(txt_Attitude_Align, false)
	
	
	local function timer_callback_attitude_power()
			visible(grp_attitude_indicator, true)
			visible(grp_attitude_indicator_numbers, true)
			visible(img_roll, true)
			visible(txt_Attitude_Align, false)
	end
	
	function power_attitude(condition)
		visible(grp_attitude_indicator, false)
		visible(grp_attitude_indicator_numbers, false)
		visible(img_roll, false)
		visible(txt_Attitude_Align, false)
		if condition == true then
			visible(txt_Attitude_Align, true)
			tmr_attitude_power = timer_start(3000, nil, timer_callback_attitude_power)
		end
	end
	
	function attitude_allign()
		power_attitude(false)
		power_attitude(true)
	end
	
	local function new_attitude(roll, pitch, slip)
		
		-- scherm 1024 x 758
		-- horizon 3000 x 3000
		-- midden x 460 y 285
		
		local dAttX = 460
		local dAttY = 285
		
		local roll = var_cap(roll , -60 , 60)
		img_rotate(img_roll , roll *-1)
		
		-- Roll horizon
		img_rotate(img_horizon , roll * -1)
		
		-- Move horizon pitch
		local pitch = var_cap(pitch , -55 , 55)
		move(img_horizon , (-1500 + dAttX) , (-1500 + dAttY + pitch * 6.35) , nil , nil)
		
		local x , y = geo_rotate_coordinates ( roll * -1 , pitch )
		move(img_horizonscale, (397 - (x * 6.35)), (-465 - (y * 6.35)), nil , nil)
		img_rotate(img_horizonscale, roll * -1)
		
		-- Move slip indicator
		local slip = 2 * var_cap(slip , -30 , 30)
		move(img_slip_indicator,  445 -slip , nil , nil , nil)

	end

	local function new_attitude_fsx(roll, pitch, slip)
		
		new_attitude(roll *-1, pitch * -1, slip * -1)

	end

	xpl_dataref_subscribe("sim/flightmodel/position/phi" , "FLOAT" ,
						"sim/flightmodel/position/theta" , "FLOAT" ,
						"sim/cockpit2/gauges/indicators/slip_deg" , "FLOAT" ,
						new_attitude)

	fsx_variable_subscribe("ATTITUDE INDICATOR BANK DEGREES", "Degrees",
						   "ATTITUDE INDICATOR PITCH DEGREES", "Degrees",
						   "INCIDENCE BETA", "Degrees",
						   new_attitude_fsx)	
end				