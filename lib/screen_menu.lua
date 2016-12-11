function init_screen_menu_none_lib()

	local screen_menu = "none"
	
	function get_screen_menu()
		return screen_menu
	end
	
	function set_screen_menu(menu)
		screen_menu = menu
	end
	
	function none_MENU()
	end

	function none_FMS_base_up()
		menu_AUX_sys_setup()
	end

	function none_FMS_base_up()
		menu_AUX_sys_setup()
	end

	function none_FMS_base_dn()
	end

	function none_FMS_top_up()
	end

	function none_FMS_top_dn()
	end

	function none_FMS_press()
	end

	function none_ENTR()
	end

	function none_CLR()
	end

end