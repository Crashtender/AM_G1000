-- ===================================================================================================
--
--			INPUT ACTIONS
--
-- ===================================================================================================


function init_bezel_input_lib(instrument_operator, short_press_limit)

	-- BUTTONS AND DIALS
	-- LEFT SIDE OF THE BEZEL

	------------
	-- NAV VOL --
	-------------

	function callback_NAV_vol_up()
		dial_NAV_vol_up()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_NAV_vol_up", callback_NAV_vol_up) 
	
	function callback_NAV_vol_dn()
		dial_NAV_vol_down()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_NAV_vol_dn", callback_NAV_vol_dn) 


	-- BUTTON

	function callback_nav_vol_press(press_time)
		NAV_vol_pressed()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_NAV_vol_pressed",callback_nav_vol_press)
	
	
	-------------
	-- NAV XFR --
	-------------

	function callback_nav_xfr_press()
		NAV_XFR_pressed()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_NAV_XFR_pressed", callback_nav_xfr_press)

	---------
	-- NAV --
	---------

	-- DIALS

	function callback_stby_nav_fine_dn()
		stby_nav_fine_down()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_stby_nav_fine_dn", callback_stby_nav_fine_dn)
	
	function callback_stby_nav_fine_up()
		stby_nav_fine_up()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_stby_nav_fine_up", callback_stby_nav_fine_up)

	function callback_stby_nav_coarse_dn()
		stby_nav_coarse_down()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_stby_nav_coarse_dn", callback_stby_nav_coarse_dn)
	
	function callback_stby_nav_coarse_up()
		stby_nav_coarse_up()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_stby_nav_coarse_up", callback_stby_nav_coarse_up)

	
	-- BUTTON

	function callback_nav12_press()
		NAV_PUSH_1_2_pressed()
	end
	am_command_subscribe("G1000_" .. instrument_operator .. "_nav12_press", callback_nav12_press)

	
	
	
	---------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------

	-- BUTTONS AND DIALS
	-- RIGHT SIDE OF THE BEZEL

	
	------------
	-- COM VOL --
	-------------

	function callback_COM_vol_up()
		dial_COM_vol_up()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_COM_vol_up", callback_COM_vol_up) 
	
	function callback_COM_vol_dn()
		dial_COM_vol_down()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_COM_vol_dn", callback_COM_vol_dn) 


	-- BUTTON

	function callback_COM_vol_press(press_time)
		COM_vol_pressed()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_COM_vol_pressed",callback_COM_vol_press)
	
	-------------
	-- COM XFR --
	-------------

	function callback_COM_xfr_press()
		start_XFR_press_time = os.clock()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_COM_XFR_pressed", callback_COM_xfr_press)

	function callback_COM_xfr_release()
		press_time = os.clock() - start_XFR_press_time
		if press_time > short_press_limit then
			COM_preset()
		else	
			COM_XFR_pressed()
		end
	end
	am_command_subscribe("G1000_"..instrument_operator.."_COM_XFR_released", callback_COM_xfr_release)

	---------
	-- COM --
	---------

	-- DIALS

	function callback_stby_COM_fine_dn()
		stby_COM_fine_down()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_stby_COM_fine_dn", callback_stby_COM_fine_dn)
	
	function callback_stby_COM_fine_up()
		stby_COM_fine_up()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_stby_COM_fine_up", callback_stby_COM_fine_up)

	function callback_stby_COM_coarse_dn()
		stby_COM_coarse_down()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_stby_COM_coarse_dn", callback_stby_COM_coarse_dn)
	
	function callback_stby_COM_coarse_up()
		stby_COM_coarse_up()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_stby_COM_coarse_up", callback_stby_COM_coarse_up)

	
	-- BUTTON

	function callback_COM12_press()
		COM_PUSH_1_2_pressed()
	end
	am_command_subscribe("G1000_" .. instrument_operator .. "_COM12_press", callback_COM12_press)

	

	----------
	-- BARO --
	----------
	
	-- DIAL

	function callback_dial_baro_knob_turned_dn()
			dial_baro_turned_down()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_barometer_dn", callback_dial_baro_knob_turned_dn)
	
	function callback_dial_baro_knob_turned_up()
			dial_baro_turned_up()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_barometer_up", callback_dial_baro_knob_turned_up)

	
	-- BUTTON
	function callback_baro_push()
		baro_press()
	end
	am_command_subscribe("G1000_" .. instrument_operator .. "_baro_PUSH", callback_baro_push)
	
	-----------
	-- RANGE --
	-----------
	
	function callback_dial_range_knob_turned(direction)
		if direction > 0 then
			-- com_base_knob_turned up function
		elseif direction < 0 then
			-- com_base_knob_turned dn function
		end
	end
	am_variable_subscribe("G1000_" .. instrument_operator .. "_range", "INT", callback_dial_range_knob_turned)
	
	
	-- --=====================================================================
	
	function callback_DIRECT_press(time)
		--am_command("DIRECT_pressed")
	end
	am_command_subscribe("G1000_" .. instrument_operator .. "_btn_DIRECT_released", callback_DIRECT_press)


	function callback_FPL_press()
		--am_command("FPL_pressed")
	end
	am_command_subscribe("G1000_" .. instrument_operator .. "_btn_FPL_released", callback_FPL_press)

	function callback_CLR_press()
		_G[get_screen_menu().."_CLR"]()
	end
	am_command_subscribe("G1000_" .. instrument_operator .. "_btn_CLR_released", callback_CLR_press)

	function callback_MENU_press()
		_G[get_screen_menu().."_MENU"]()
	end
	am_command_subscribe("G1000_" .. instrument_operator .. "_btn_MENU_released", callback_MENU_press)

	function callback_PROC_press()
		--am_command("PROC_pressed")
	end
	am_command_subscribe("G1000_" .. instrument_operator .. "_btn_PROC_released", callback_PROC_press)

	function callback_ENT_press()
		_G[get_screen_menu().."_ENTR"]()
	end
	am_command_subscribe("G1000_" .. instrument_operator .. "_btn_ENT_released", callback_ENT_press)

	function callback_FMS_base_up()
		_G[get_screen_menu().."_FMS_base_up"]()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_FMS_base_up", callback_FMS_base_up)
	
	function callback_FMS_base_down()
		_G[get_screen_menu().."_FMS_base_dn"]()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_FMS_base_down", callback_FMS_base_down)

	function callback_FMS_top_up()
		_G[get_screen_menu().."_FMS_top_up"]()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_FMS_top_up", callback_FMS_top_up)
	
	function callback_FMS_top_down()
		_G[get_screen_menu().."_FMS_top_dn"]()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_FMS_top_down", callback_FMS_top_down)

	function callback_FMS_press()
		_G[get_screen_menu().."_FMS_press"]()
	end
	am_command_subscribe("G1000_"..instrument_operator.."_FMS_released", callback_FMS_press)

	

	-- SOFT KEY BUTTONS
	-- BOTTOM OF THE BEZEL

	function sk1_press_callback()
		show_SK_BG(1)
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey1_press", sk1_press_callback)

	function sk1_release_callback()
		hide_SK_BG()
		skmenu("sk1")
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey1_release", sk1_release_callback)

	function sk2_press_callback()
		show_SK_BG(2)
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey2_press", sk2_press_callback)

	function sk2_release_callback()
		hide_SK_BG()
		skmenu("sk2")
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey2_release", sk2_release_callback)

	function sk3_press_callback()
		show_SK_BG(3)
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey3_press", sk3_press_callback)

	function sk3_release_callback()
		hide_SK_BG()
		skmenu("sk3")
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey3_release", sk3_release_callback)

	function sk4_press_callback()
		show_SK_BG(4)
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey4_press", sk4_press_callback)

	function sk4_release_callback()
		hide_SK_BG()
		skmenu("sk4")
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey4_release", sk4_release_callback)

	function sk5_press_callback()
		show_SK_BG(5)
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey5_press", sk5_press_callback)

	function sk5_release_callback()
		hide_SK_BG()
		skmenu("sk5")
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey5_release", sk5_release_callback)
	
	function sk6_press_callback()
		show_SK_BG(6)
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey6_press", sk6_press_callback)

	function sk6_release_callback()
		hide_SK_BG()
		skmenu("sk6")
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey6_release", sk6_release_callback)

	function sk7_press_callback()
		show_SK_BG(7)
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey7_press", sk7_press_callback)

	function sk7_release_callback()
		hide_SK_BG()
		skmenu("sk7")
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey7_release", sk7_release_callback)

	function sk8_press_callback()
		show_SK_BG(8)
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey8_press", sk8_press_callback)

	function sk8_release_callback()
		hide_SK_BG()
		skmenu("sk8")
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey8_release", sk8_release_callback)

	function sk9_press_callback()
		show_SK_BG(9)
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey9_press", sk9_press_callback)

	function sk9_release_callback()
		hide_SK_BG()
		skmenu("sk9")
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey9_release", sk9_release_callback)

	function sk10_press_callback()
		show_SK_BG(10)
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey10_press", sk10_press_callback)

	function sk10_release_callback()
		hide_SK_BG()
		skmenu("sk10")
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey10_release", sk10_release_callback)

	function sk11_press_callback()
		show_SK_BG(11)
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey11_press", sk11_press_callback)

	function sk11_release_callback()
		hide_SK_BG()
		skmenu("sk11")
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey11_release", sk11_release_callback)

	function sk12_press_callback()
		show_SK_BG(12)
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey12_press", sk12_press_callback)

	function sk12_release_callback()
		hide_SK_BG()
		skmenu("sk12")
	end
	am_command_subscribe("G1000_"..instrument_operator.."_SoftKey12_release", sk12_release_callback)

end