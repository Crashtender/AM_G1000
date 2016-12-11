-- ===================================================================================================
--
--			Menu Timer/Reference
--
-- ===================================================================================================

function init_screen_menu_tmr_ref_lib()
	
	
	-- Variables
	-----------------------------------------
	local tmr_ref_window_visible = false
	local tmr_ref_cursor_position = {}
	local tmr_ref_current_position = 0
	local Vglide,Vr,Vx,Vy
	local timer_direction = "up"
	local timer_status = "reset"
	local hr = 0
	local mn = 0
	local sc = 0
	local Vglide,Vr,Vx,Vy
	local factory_Vglide,factory_Vr,factory_Vx,factory_Vy
	
	local page_menu_visible = false
	local page_menu_cursor_position = {}
	local page_menu_current_position = 1
	
	
	-- Visual elements
	-----------------------------------------
	local tmr_ref_window_border = img_add("color_white.png", 792 , 489 ,224,224)
	local tmr_ref_window_background = img_add("color_black.png", 794 , 491 ,220,220)
	local tmr_ref_cursor = img_add("color_cyan.png",0,0,0,0)
	local window_main_title = txt_add("REFERENCES", font_screen_menu_cyan_12, 794 , 493 ,220,20)
	
	local window_line1 = img_add("color_grey.png", 796 , 511 ,216,2)
	
	local window_timer_title = txt_add("TIMER", font_screen_menu_white_12, 796 , 518 ,40,20)
	tmr_ref_cursor_position[1] =  {txt=txt_add("  :  :  ", font_screen_menu_cyan_14, 844 , 516 ,60,20), x="844", y="516", w="60"}
	tmr_ref_cursor_position["1h"] = {txt=txt_add("", font_screen_menu_cyan_14, 844 , 516 ,60,20), x="844", y="516", w="20"}
	tmr_ref_cursor_position["1m"] = {txt=txt_add("", font_screen_menu_cyan_14, 844 , 516 ,60,20), x="864", y="516", w="20"}
	tmr_ref_cursor_position["1s"] = {txt=txt_add("", font_screen_menu_cyan_14, 844 , 516 ,60,20), x="884", y="516", w="20"}
	txt_set(tmr_ref_cursor_position[1].txt, string.format("%02d:%02d:%02d", hr, mn, sc))
	tmr_ref_cursor_position[2] = {txt=txt_add("UP", font_screen_menu_cyan_14, 920 , 516, 20 ,20), x="920" , y="516", w="20"}
	tmr_ref_cursor_position[3] = {txt=txt_add("START?", font_screen_menu_cyan_14, 945 , 516 ,60,20), x="945", y="516", w="60"}
	
	local window_line2 = img_add("color_grey.png", 796 , 535 ,216,2)
	
	local window_V_title1 = txt_add("V", font_screen_menu_white_12, 796 , 540 ,10, 20)
	local window_r_title1 = txt_add("glide", font_screen_menu_white_10, 805 , 542 ,30, 20)
	tmr_ref_cursor_position[4] = {txt=txt_add("999 KT", font_screen_menu_cyan_14, 844 , 540 ,60,20), x="844", y="540", w="60"}
	tmr_ref_cursor_position[5] = {txt=txt_add("ON", font_screen_menu_cyan_14, 965 , 540 ,30,20), x="965", y="540", w="30"}
	
	local window_V_title2 = txt_add("V", font_screen_menu_white_12, 796 , 555 ,10, 20)
	local window_x_title2 = txt_add("r", font_screen_menu_white_10, 805 , 557 ,30, 20)
	tmr_ref_cursor_position[6] = {txt=txt_add("999 KT", font_screen_menu_cyan_14, 844 , 555 ,60,20), x="844", y="555", w="60"}
	tmr_ref_cursor_position[7] = {txt=txt_add("ON", font_screen_menu_cyan_14, 965 , 555 ,30,20), x="965", y="555", w="30"}
	
	local window_V_title3 = txt_add("V", font_screen_menu_white_12, 796 , 570 ,10, 20)
	local window_y_title3 = txt_add("x", font_screen_menu_white_10, 805 , 572 ,30, 20)
	tmr_ref_cursor_position[8] = {txt=txt_add("999 KT", font_screen_menu_cyan_14, 844 , 570 ,60,20), x="844", y="570", w="60"}
	tmr_ref_cursor_position[9] = {txt=txt_add("ON", font_screen_menu_cyan_14, 965 , 570 ,30,20), x="965", y="570" , w="30"}
	
	local window_V_title4 = txt_add("V", font_screen_menu_white_12, 796 , 585 ,10, 20)
	local window_glide_title4 = txt_add("y", font_screen_menu_white_10, 805 , 587 ,30, 20)
	tmr_ref_cursor_position[10] = {txt=txt_add("999 KT", font_screen_menu_cyan_14, 844 , 585 ,60,20), x="844", y="585", w="60"}
	tmr_ref_cursor_position[11] = {txt=txt_add("ON", font_screen_menu_cyan_14, 965 , 585 ,30,20), x="965", y="585", w="30"}
	
	local window_line3 = img_add("color_grey.png", 796 , 661 ,216,2)
	
	local window_minimums_title = txt_add("MINIMUMS", font_screen_menu_white_12, 796 , 665 ,70, 20)
	tmr_ref_cursor_position[12] = {txt=txt_add("RADIO", font_screen_menu_cyan_12, 880 , 665 , 60, 20), x="880", y="665", w="60"}
	tmr_ref_cursor_position[13] = {txt=txt_add("200", font_screen_menu_cyan_12, 950 , 665 , 60, 20), x="950", y="665", w="60"}
	
	grp_tmr_ref_window = group_add(	tmr_ref_window_border, tmr_ref_window_background, tmr_ref_cursor, 
									window_main_title, window_line1,
									window_timer_title, window_timer_mode, window_line2,
									window_V_title1, window_r_title1,
									window_V_title2, window_x_title2,
									window_V_title3, window_y_title3,
									window_V_title4, window_glide_title4, window_line3,
									window_minimums_title, window_minimums_text, window_minimums_value)
									
	visible(grp_tmr_ref_window, false)
	
	
	for k, v in pairs(tmr_ref_cursor_position) do
		visible(tmr_ref_cursor_position[k].txt, false)
	end
	
	
	-- PAGE MENU
	local page_menu_window_depth_border = img_add("color_black.png", 800 , 498 ,204,124)
	local page_menu_window_border = img_add("color_grey.png", 800 , 498 ,202,122)
	local page_menu_window_body = img_add("color_dark_grey.png", 802 , 500 ,200,120)
	local page_menu_window_background_border = img_add("color_grey.png", 820 , 538 ,164,69)
	local page_menu_window_background = img_add("color_black.png", 822 , 540 ,160,65)
	local page_menu_cursor = img_add("color_cyan.png",0,0,0,0)
	
	local page_menu_title = txt_add("PAGE MENU", font_screen_menu_white_12, 800 , 505 ,200,20)
	local page_menu_options = txt_add("OPTIONS", font_screen_menu_white_12, 830 , 525 ,60,20)
	page_menu_cursor_position[1] =  {txt=txt_add("All References On", font_screen_menu_cyan_14_left, 825 , 545 ,150,20), x="885", y="550", w="100"}
	page_menu_cursor_position[2] = {txt=txt_add("All References Off", font_screen_menu_cyan_14_left, 825 , 565, 150 ,20), x="885" , y="580", w="100"}
	page_menu_cursor_position[3] = {txt=txt_add("Restore Defaults", font_screen_menu_cyan_14_left, 825 , 585 ,150,20), x="885", y="610", w="100"}
	
	grp_page_menu = group_add(	page_menu_window_depth_border, page_menu_window_border, page_menu_window_body, page_menu_window_background_border, page_menu_window_background, 
									page_menu_cursor, page_menu_title, page_menu_options)
									
	visible(grp_page_menu, false)
	
	for k, v in pairs(page_menu_cursor_position) do
		visible(page_menu_cursor_position[k].txt, false)
	end
	

	-- Functions
	-----------------------------------------
	local function set_cursor_layout()
		move(tmr_ref_cursor, tmr_ref_cursor_position[tmr_ref_current_position].x, tmr_ref_cursor_position[tmr_ref_current_position].y, tmr_ref_cursor_position[tmr_ref_current_position].w, 16)
		txt_style(tmr_ref_cursor_position[tmr_ref_current_position].txt, font_screen_menu_black_14)
	end
	
	local function reset_cursor_layout()
		txt_style(tmr_ref_cursor_position[tmr_ref_current_position].txt, font_screen_menu_cyan_14)
	end
	
	function menu_tmr_ref()
		if tmr_ref_window_visible == false then
		
			txt_set(tmr_ref_cursor_position[1].txt, string.format("%02d:%02d:%02d", hr, mn, sc))
		
			Vglide,Vr,Vx,Vy = get_vref()
			factory_Vglide,factory_Vr,factory_Vx,factory_Vy = get_factory_vref()
			if Vglide ~= factory_Vglide then txt_set(tmr_ref_cursor_position[4].txt, Vglide .." KT*") else txt_set(tmr_ref_cursor_position[4].txt, Vglide .." KT") end
			if Vr ~= factory_Vr then txt_set(tmr_ref_cursor_position[6].txt, Vr.." KT*") else txt_set(tmr_ref_cursor_position[6].txt, Vr.." KT") end
			if Vx ~= factory_Vx then txt_set(tmr_ref_cursor_position[8].txt, Vx.." KT*") else txt_set(tmr_ref_cursor_position[8].txt, Vx.." KT") end
			if Vy ~= factory_Vy then txt_set(tmr_ref_cursor_position[10].txt, Vy.." KT*") else txt_set(tmr_ref_cursor_position[10].txt, Vy.." KT") end
			
			txt_set(tmr_ref_cursor_position[13].txt, get_baro_minimums())
			
			set_screen_menu("tmr_ref")
			tmr_ref_window_visible = true
			visible(grp_tmr_ref_window, true)
						
			for k, v in pairs(tmr_ref_cursor_position) do
				visible(tmr_ref_cursor_position[k].txt, true)
			end
						
			tmr_ref_current_position = 3
			set_cursor_layout()
						
		else
			
			reset_cursor_layout()
			tmr_ref_window_visible = false
			visible(grp_tmr_ref_window, false)
			set_screen_menu("none")
			
			for k, v in pairs(tmr_ref_cursor_position) do
				visible(tmr_ref_cursor_position[k].txt, false)
			end
	
		end
	end
	
	function tmr_ref_FMS_base_up()
		reset_cursor_layout()
		tmr_ref_current_position = tmr_ref_current_position + 1
		if tmr_ref_current_position > 13 then tmr_ref_current_position = 1 end
		set_cursor_layout()
	end
	
	function tmr_ref_FMS_base_dn()
		reset_cursor_layout()
		tmr_ref_current_position = tmr_ref_current_position - 1
		if tmr_ref_current_position < 1 then tmr_ref_current_position = 13 end
		set_cursor_layout()
	end
	
	function top_up_1h()
		hr = hr + 1
		txt_set(tmr_ref_cursor_position[1].txt, string.format("%02d:%02d:%02d", hr, mn, sc))
	end
	
	function top_dn_1h()
		if hr > 0 then hr = hr - 1 end
		txt_set(tmr_ref_cursor_position[1].txt, string.format("%02d:%02d:%02d", hr, mn, sc))
	end
		
	function top_up_1m()
		mn = mn + 1
		txt_set(tmr_ref_cursor_position[1].txt, string.format("%02d:%02d:%02d", hr, mn, sc))
	end
	
	function top_dn_1m()
		if mn > 0 then mn = mn - 1 end
		txt_set(tmr_ref_cursor_position[1].txt, string.format("%02d:%02d:%02d", hr, mn, sc))
	end
		
	function top_up_1s()
		sc = sc + 1
		txt_set(tmr_ref_cursor_position[1].txt, string.format("%02d:%02d:%02d", hr, mn, sc))
	end
	
	function top_dn_1s()
		if sc > 0 then sc = sc - 1 end
		txt_set(tmr_ref_cursor_position[1].txt, string.format("%02d:%02d:%02d", hr, mn, sc))
	end
	
	function top_up_2()
		timer_direction = "up"
		txt_set(tmr_ref_cursor_position[2].txt, "up")
	end
	
	function top_dn_2()
		timer_direction = "dn"
		txt_set(tmr_ref_cursor_position[2].txt, "dn")
	end
	
	function top_up_4()
		Vglide = Vglide + 1
		if Vglide ~= factory_Vglide then txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vglide .." KT*") else txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vglide .." KT") end
		set_vref(Vglide,Vr,Vx,Vy)
	end
	
	function top_dn_4()
		Vglide = Vglide - 1
		if Vglide ~= factory_Vglide then txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vglide .." KT*") else txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vglide .." KT") end
		set_vref(Vglide,Vr,Vx,Vy)
	end
	
	function top_up_5()
		show_Vglide(true)
		txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, "ON")
	end
	
	function top_dn_5()
		show_Vglide(false)
		txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, "OFF")
	end
	
	function top_up_6()
		Vr = Vr + 1
		if Vr ~= factory_Vr then txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vr.." KT*") else txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vr.." KT") end
		set_vref(Vglide,Vr,Vx,Vy)
	end
	
	function top_dn_6()
		Vr = Vr - 1
		if Vr ~= factory_Vr then txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vr.." KT*") else txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vr.." KT") end
		set_vref(Vglide,Vr,Vx,Vy)
	end
	
	function top_up_7()
		show_Vr(true)
		txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, "ON")
	end
	
	function top_dn_7()
		show_Vr(false)
		txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, "OFF")
	end
	
	function top_up_8()
		Vr = Vr + 1
		if Vx ~= factory_Vx then txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vx.." KT*") else txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vx.." KT") end
		set_vref(Vglide,Vr,Vx,Vy)
	end
	
	function top_dn_8()
		Vr = Vx - 1
		if Vx ~= factory_Vx then txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vx.." KT*") else txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vx.." KT") end
		set_vref(Vglide,Vr,Vx,Vy)
	end
	
	function top_up_9()
		show_Vx(true)
		txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, "ON")
	end
	
	function top_dn_9()
		show_Vx(false)
		txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, "OFF")
	end
	
	function top_up_10()
		Vy = Vy + 1
		if Vy ~= factory_Vy then txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vy.." KT*") else txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vy.." KT") end
		set_vref(Vglide,Vr,Vx,Vy)
	end
	
	function top_dn_10()
		Vy = Vy - 1
		if Vy ~= factory_Vy then txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vy.." KT*") else txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, Vy.." KT") end
		set_vref(Vglide,Vr,Vx,Vy)
	end
	
	function top_up_11()
		show_Vy(true)
		txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, "ON")
	end
	
	function top_dn_11()
		show_Vy(false)
		txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, "OFF")
	end
		
	function top_up_12()
		txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, "BARO")  
	end
	
	function top_dn_12()
		txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, "OFF")
	end
	
	function top_up_13()
		local baro_minimums = get_baro_minimums() + 10
		txt_set(tmr_ref_cursor_position[13].txt, baro_minimums)
		set_baro_minimums(baro_minimums)
	end
	
	function top_dn_13()
		if get_baro_minimums() > 0 then 
			local baro_minimums = baro_minimums - 10
		end
		txt_set(tmr_ref_cursor_position[13].txt, baro_minimums)
		set_baro_minimums(baro_minimums)
	end
	
	function tmr_ref_FMS_top_up()
		_G["top_up_"..tmr_ref_current_position]()
	end
	
	function tmr_ref_FMS_top_dn()
		_G["top_dn_"..tmr_ref_current_position]()
	end
	
	local function reset_to_default()
		Vglide,Vr,Vx,Vy = get_factory_vref()
	end
	
	local function timer_callback()
		if timer_direction == "up" then
			
			sc=sc+1
			if sc > 60 then 
				sc = 0
				mn = mn+1
			end
			if mn > 60 then 
				mn = 0
				hr = hr+1
			end
		elseif timer_direction == "dn" then
		
			sc=sc-1
			if sc < 0 then 
				sc = 0
				mn = mn - 1
			end
			if mn < 0  then 
				mn = 0
				hr = hr - 1
			end
			
			if hr == 0 and mn == 0 and sc == 0 then
				--ALARM TODO
				timer_direction = up
			end	
		end	
		
		txt_set(tmr_ref_cursor_position[1].txt, string.format("%02d:%02d:%02d", hr, mn, sc) )
		
	end
	
	function tmr_ref_FMS_press()
		if page_menu_visible == false then
			if tmr_ref_current_position == 1 then
				reset_cursor_layout()
				tmr_ref_current_position = "1h"
				set_cursor_layout()
			elseif tmr_ref_current_position == "1h" or tmr_ref_current_position == "1m" or tmr_ref_current_position == "1s" then
				reset_cursor_layout()
				tmr_ref_current_position = 1
				set_cursor_layout()
			elseif tmr_ref_current_position == 3 then
				if timer_status == "reset" then
					tmr_timer = timer_start(0,1000,timer_callback)
					timer_status = "started"
					txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, "STOP?")
				elseif timer_status == "started" then
					timer_stop(tmr_timer)
					timer_status = "stopped"
					txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, "RESET?")
				elseif timer_status == "stopped" then
					hr = 0
					mn = 0
					sc = 0
					txt_set(tmr_ref_cursor_position[1].txt, string.format("%02d:%02d:%02d", hr, mn, sc) )
					timer_status = "reset"
					tmr_timer = nil
					txt_set(tmr_ref_cursor_position[tmr_ref_current_position].txt, "START?")
				end
			end
		elseif page_menu_visible == true then
			if page_menu_cursor_position == 1 then
				-- All References On
				all_Vref_on()
				txt_set(tmr_ref_cursor_position[5].txt, "ON")
				txt_set(tmr_ref_cursor_position[7].txt, "ON")
				txt_set(tmr_ref_cursor_position[9].txt, "ON")
				txt_set(tmr_ref_cursor_position[1].txt, "ON")
			elseif page_menu_cursor_position == 2 then
				-- All References Off
				all_Vref_off()
				txt_set(tmr_ref_cursor_position[5].txt, "OFF")
				txt_set(tmr_ref_cursor_position[7].txt, "OFF")
				txt_set(tmr_ref_cursor_position[9].txt, "OFF")
				txt_set(tmr_ref_cursor_position[1].txt, "OFF")
			elseif page_menu_cursor_position == 3 then
				-- Restore Defaults
				Vglide,Vr,Vx,Vy = get_vref()
				set_vref(Vglide,Vr,Vx,Vy)
				txt_set(tmr_ref_cursor_position[4].txt, Vglide.." KT")
				txt_set(tmr_ref_cursor_position[6].txt, Vr.." KT")
				txt_set(tmr_ref_cursor_position[8].txt, Vx.." KT")
				txt_set(tmr_ref_cursor_position[10].txt, Vy.." KT")
			end
		end
	end
	

	function tmr_ref_MENU()
		set_screen_menu("tmr_ref_page_menu")	
		visible(grp_page_menu, true)
		for k, v in pairs(page_menu_cursor_position) do
			visible(page_menu_cursor_position[k].txt, true)
		end
		page_menu_visible = true
	end
	
	function tmr_ref_ENTR()
		tmr_ref_FMS_press()
	end
		
	function tmr_ref_CLR()
		if page_menu_visible == true then
			
			visible(grp_page_menu, false)
			for k, v in pairs(page_menu_cursor_position) do
				visible(page_menu_cursor_position[k].txt, false)
			end
			page_menu_visible = false
		elseif tmr_ref_window_visible == true then 
			tmr_ref_window_visible = false
			visible(grp_tmr_ref_window, false)
			set_screen_menu("none")
			
			for k, v in pairs(tmr_ref_cursor_position) do
				visible(tmr_ref_cursor_position[k].txt, false)
			end
		end
	end
	
	-- PAGE MENU
	
	local function set_page_menu_cursor_layout()
		move(page_menu_cursor, page_menu_cursor_position[page_menu_current_position].x, page_menu_cursor_position[page_menu_current_position].y, page_menu_cursor_position[page_menu_current_position].w, 16)
		txt_style(page_menu_cursor_position[page_menu_current_position].txt, font_screen_menu_black_14)
	end
	
	local function reset_page_menu_cursor_layout()
		txt_style(page_menu_cursor_position[page_menu_current_position].txt, font_screen_menu_cyan_14)
	end
	
	function tmr_ref_page_menu_FMS_base_up()
		reset_page_menu_cursor_layout()
		page_menu = page_menu_current_position + 1
		if page_menu_current_position > 3 then page_menu_current_position = 1 end
		set_page_menu_cursor_layout()
	end
	
	function tmr_ref_page_menu_FMS_base_dn()
		reset_page_menu_cursor_layout()
		page_menu_current_position = page_menu_current_position - 1
		if page_menu_current_position < 1 then page_menu_current_position = 3 end
		set_page_menu_cursor_layout()
	end
	
	function tmr_ref_page_menu_FMS_press()
		if page_menu_cursor_position == 1 then
			-- All References On
			all_Vref_on()
			txt_set(tmr_ref_cursor_position[5].txt, "ON")
			txt_set(tmr_ref_cursor_position[7].txt, "ON")
			txt_set(tmr_ref_cursor_position[9].txt, "ON")
			txt_set(tmr_ref_cursor_position[1].txt, "ON")
		elseif page_menu_cursor_position == 2 then
			-- All References Off
			all_Vref_off()
			txt_set(tmr_ref_cursor_position[5].txt, "OFF")
			txt_set(tmr_ref_cursor_position[7].txt, "OFF")
			txt_set(tmr_ref_cursor_position[9].txt, "OFF")
			txt_set(tmr_ref_cursor_position[1].txt, "OFF")
		elseif page_menu_cursor_position == 3 then
			-- Restore Defaults
			Vglide,Vr,Vx,Vy = get_factory_vref()
			set_vref(Vglide,Vr,Vx,Vy)
			txt_set(tmr_ref_cursor_position[4].txt, Vglide.." KT")
			txt_set(tmr_ref_cursor_position[6].txt, Vr.." KT")
			txt_set(tmr_ref_cursor_position[8].txt, Vx.." KT")
			txt_set(tmr_ref_cursor_position[10].txt, Vy.." KT")
		end
	end
	
	function tmr_ref_page_menu_MENU()
		set_screen_menu("tmr_ref")	

		visible(grp_page_menu, false)
		for k, v in pairs(page_menu_cursor_position) do
			visible(page_menu_cursor_position[k].txt, false)
		end
		page_menu_visible = false
	end
	
	function tmr_ref_page_menu_ENTR()
		tmr_ref_page_menu_FMS_press()
	end
		
	function tmr_ref_page_menu_CLR()
		visible(grp_page_menu, false)
		for k, v in pairs(page_menu_cursor_position) do
			visible(page_menu_cursor_position[k].txt, false)
		end
		page_menu_visible = false
	end
	
end


-- local timeTable = { year = 2015, day = 19, month = 4, hour = 16, min = 15 }
-- local previousTime = os.time( timeTable )
-- local timeDifference = os.time() - previousTime
-- print( timeDifference )