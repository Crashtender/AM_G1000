function init_screen_menu_AUX_sys_setup_lib()
	
	-- VARIABLES --
	
	local AUX_sys_setup_cursor_position = {}
	local AUX_sys_setup_current_position = 1

	-- VISUAL ELEMENTS --
	
	local img_background = img_add("color_dark_grey.png", 0, 55, 1024, 688)
	local temp = txt_add("*** UNDER DEVELOPMENT ***", "-fx-font-family:Arial; -fx-font-size:36px; -fx-fill: red; -fx-font-weight:bold; -fx-text-alignment:center", 0, 600, 1024, 100)
	
	local txt_title_L1 = txt_add("DATE / TIME", font_screen_menu_white_14_left, 50, 70, 310, 20)
	local winL1_brdr = img_add("color_grey.png", 25, 90, 310, 110)
	local winL1_bckgr = img_add("color_black.png", 27, 92, 306, 106)
	
	local winL1_title_1 = txt_add("DATE", font_screen_menu_grey_14_left, 30, 100, 150, 20)
	local winL1_title_2 = txt_add("TIME", font_screen_menu_grey_14_left, 30, 125, 150, 20)
	local winL1_title_3 = txt_add("TIME FORMAT", font_screen_menu_grey_14_left, 30, 150, 150, 20)
	local winL1_title_4 = txt_add("TIME OFFSET", font_screen_menu_grey_14_left, 30, 175, 150, 20)
	local grp_AUX_sys_setup_window = group_add(img_background, temp, txt_title_L1, winL1_brdr, winL1_bckgr, winL1_title_1, winL1_title_2, winL1_title_3, winL1_title_4)
	
	AUX_sys_setup_cursor_position[1] = {txt=txt_add("", font_screen_menu_cyan_14_right, 180, 100, 150, 20), x="180", y="100", w="150"}
	AUX_sys_setup_cursor_position[2] = {txt=txt_add("", font_screen_menu_cyan_14_right, 180, 125, 150, 20), x="180", y="125", w="150"}
	AUX_sys_setup_cursor_position[3] = {txt=txt_add("", font_screen_menu_cyan_14_right, 180, 150, 150, 20), x="180", y="150", w="150"}
	AUX_sys_setup_cursor_position[4] = {txt=txt_add("", font_screen_menu_cyan_14_right, 180, 175, 150, 20), x="180", y="175", w="150"}
	
	-----------------------------------------------------------------------------------------------------------
		
	local txt_title_L2 = txt_add("DISPLAY UNITS", font_screen_menu_white_14_left, 50, 230, 310, 20)
	local winL2_brdr = img_add("color_grey.png", 25, 250, 310, 210)
	local winL2_bckgr = img_add("color_black.png", 27, 252, 306, 206)
	
	local winL2_title_1 = txt_add("NAV ANGLE", font_screen_menu_grey_14_left, 30, 260, 150, 20)
	local winL2_title_2 = txt_add("MAG VAR", font_screen_menu_grey_14_left, 30, 285, 150, 20)
	local winL2_title_3 = txt_add("DIS SPD", font_screen_menu_grey_14_left, 30, 310, 150, 20)
	local winL2_title_4 = txt_add("ALT VS", font_screen_menu_grey_14_left, 30, 335, 150, 20)
	local winL2_title_5 = txt_add("TEMP", font_screen_menu_grey_14_left, 30, 360, 150, 20)
	local winL2_title_6 = txt_add("FUEL", font_screen_menu_grey_14_left, 30, 385, 150, 20)
	local winL2_title_7 = txt_add("WEIGHT", font_screen_menu_grey_14_left, 30, 410, 150, 20)
	local winL2_title_8 = txt_add("POSITION", font_screen_menu_grey_14_left, 30, 435, 150, 20)
	group_obj_add(grp_AUX_sys_setup_window, txt_title_L2, winL2_brdr, winL2_bckgr, winL2_title_1, winL2_title_2, winL2_title_3, winL2_title_4, winL2_title_5, winL2_title_6, winL2_title_7, winL2_title_8)
	
	AUX_sys_setup_cursor_position[5] = {txt = txt_add("MAGNETIC(°)", font_screen_menu_cyan_14_right, 180, 260, 150, 20), x="180", y="260", w="150"}
	AUX_sys_setup_cursor_position[6] = {txt = txt_add("3°E", font_screen_menu_cyan_14_right, 180, 285, 150, 20), x="180", y="285", w="150"}
	AUX_sys_setup_cursor_position[7] = {txt = txt_add("NAUTICAL (NM,KT)", font_screen_menu_cyan_14_right, 180, 310, 150, 20), x="180", y="310", w="150"}
	AUX_sys_setup_cursor_position[8] = {txt = txt_add("FEET(FT,FPM)", font_screen_menu_cyan_14_right, 180, 335, 150, 20), x="180", y="335", w="150"}
	AUX_sys_setup_cursor_position[9] = {txt = txt_add("CELSIUS(°C)", font_screen_menu_cyan_14_right, 180, 360, 150, 20), x="180", y="360", w="150"}
	AUX_sys_setup_cursor_position[10] = {txt = txt_add("GALLONS(GL,GL/HR)", font_screen_menu_cyan_14_right, 180, 385, 150, 20), x="180", y="385", w="150"}
	AUX_sys_setup_cursor_position[11] = {txt = txt_add("POUNDS(LB)", font_screen_menu_cyan_14_right, 180, 410, 150, 20), x="180", y="410", w="150"}
	AUX_sys_setup_cursor_position[12] = {txt = txt_add("HDDD°MM.MM", font_screen_menu_cyan_14_right, 180, 435, 150, 20), x="180", y="435", w="150"}
	
	-----------------------------------------------------------------------------------------------------------
		
	local txt_title_L3 = txt_add("BARO TRANSITION ALERT", font_screen_menu_white_14_left, 50, 490, 310, 20)
	local winL3_brdr = img_add("color_grey.png", 25, 510, 310, 35)
	local winL2_bckgr = img_add("color_black.png", 27, 512, 306, 31)
	
	AUX_sys_setup_cursor_position[13] = {txt=txt_add("ON", font_screen_menu_cyan_14_left, 30, 520, 50, 20), x="30", y="520", w="50"}
	
	local winL3_title_1 = txt_add("ALTITUDE", font_screen_menu_grey_14_left, 80, 520, 150, 20)
	group_obj_add(grp_AUX_sys_setup_window, txt_title_L3, winL3_brdr, winL2_bckgr, winL3_title_1)
	
	AUX_sys_setup_cursor_position[14] = {txt=txt_add("18000FT", font_screen_menu_cyan_14_right, 180, 520, 150, 20), x="180", y="520", w="150"}
	
	-----------------------------------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------
	
	local txt_title_M1 = txt_add("AIRSPACE ALERTS", font_screen_menu_white_14_left, 405, 70, 310, 20)
	local winM1_brdr = img_add("color_grey.png", 355, 90, 310, 185)
	local winM1_bckgr = img_add("color_black.png", 357, 92, 306, 181)
	
	local winM1_title_1 = txt_add("ALTITUDE BUFFER", font_screen_menu_grey_14_left, 360, 100, 150, 20)
	local winM1_title_2 = txt_add("CLASS B/TMA", font_screen_menu_grey_14_left, 360, 125, 150, 20)
	local winM1_title_3 = txt_add("CLASS C/TCA", font_screen_menu_grey_14_left, 360, 150, 150, 20)
	local winM1_title_4 = txt_add("CLASS D", font_screen_menu_grey_14_left, 360, 175, 150, 20)
	local winM1_title_5 = txt_add("RESTRICTED", font_screen_menu_grey_14_left, 360, 200, 150, 20)
	local winM1_title_6 = txt_add("MOA (MILITARY)", font_screen_menu_grey_14_left, 360, 225, 150, 20)
	local winM1_title_7 = txt_add("OTHER/ADIZ", font_screen_menu_grey_14_left, 360, 250, 150, 20)
	group_obj_add(grp_AUX_sys_setup_window, txt_title_M1, winM1_brdr, winM1_bckgr, winM1_title_1, winM1_title_2, winM1_title_3, winM1_title_4, winM1_title_5, winM1_title_6, winM1_title_7)
		
	AUX_sys_setup_cursor_position[15] = {txt = txt_add("200FT", font_screen_menu_cyan_14_right, 510, 100, 150, 20), x="510", y="100", w="150"}
	AUX_sys_setup_cursor_position[16] = {txt = txt_add("OFF", font_screen_menu_cyan_14_right, 510, 125, 150, 20), x="510", y="125", w="150"}
	AUX_sys_setup_cursor_position[17] = {txt = txt_add("OFF", font_screen_menu_cyan_14_right, 510, 150, 150, 20), x="510", y="150", w="150"}
	AUX_sys_setup_cursor_position[18] = {txt = txt_add("OFF", font_screen_menu_cyan_14_right, 510, 175, 150, 20), x="510", y="175", w="150"}
	AUX_sys_setup_cursor_position[19] = {txt = txt_add("OFF", font_screen_menu_cyan_14_right, 510, 200, 150, 20), x="510", y="200", w="150"}
	AUX_sys_setup_cursor_position[20] = {txt = txt_add("OFF", font_screen_menu_cyan_14_right, 510, 225, 150, 20), x="510", y="225", w="150"}
	AUX_sys_setup_cursor_position[21] = {txt = txt_add("OFF", font_screen_menu_cyan_14_right, 510, 250, 150, 20), x="510", y="250", w="150"}
	
	-----------------------------------------------------------------------------------------------------------
	
	local txt_title_M2 = txt_add("AUDIO ALERT", font_screen_menu_white_14_left, 405, 290, 310, 20)
	local winM2_brdr = img_add("color_grey.png", 355, 310, 310, 35)
	local winM2_bckgr = img_add("color_black.png", 357, 312, 306, 31)
	
	local winM2_title_1 = txt_add("VOICE", font_screen_menu_grey_14_left, 360, 320, 150, 20)
	group_obj_add(grp_AUX_sys_setup_window, txt_title_M2, winM2_brdr, winM2_bckgr, winM2_title_1)
	
	AUX_sys_setup_cursor_position[22] = {txt = txt_add("FEMALE", font_screen_menu_cyan_14_right, 510, 320, 150, 20), x="510", y="290", w="150"}
	
	-----------------------------------------------------------------------------------------------------------
	
	local txt_title_M3 = txt_add("FLIGHT DIRECTOR", font_screen_menu_white_14_left, 405, 360, 310, 20)
	local winM3_brdr = img_add("color_grey.png", 355, 380, 310, 35)
	local winM3_bckgr = img_add("color_black.png", 357, 382, 306, 31)
	
	local winM3_title_1 = txt_add("FORMAT ACTIVE", font_screen_menu_grey_14_left, 360, 390, 150, 20)
	group_obj_add(grp_AUX_sys_setup_window, txt_title_M3, winM3_brdr, winM3_bckgr, winM3_title_1)
	
	AUX_sys_setup_cursor_position[23] = {txt = txt_add("SNGLE CUE", font_screen_menu_cyan_14_right, 510, 390, 150, 20), x="510", y="350", w="150"}
	
	-----------------------------------------------------------------------------------------------------------
	
	local txt_title_M4 = txt_add("PAGE NAVIGATION", font_screen_menu_white_14_left, 405, 430, 310, 20)
	local winM4_brdr = img_add("color_grey.png", 355, 450, 310, 60)
	local winM4_bckgr = img_add("color_black.png", 357, 452, 306, 56)
	
	local winM4_title_1 = txt_add("CHANGE ON 1ST CLICK", font_screen_menu_grey_14_left, 360, 460, 200, 20)
	local winM4_title_2 = txt_add("TIMEOUT SECONDS", font_screen_menu_grey_14_left, 360, 485, 150, 20)
	group_obj_add(grp_AUX_sys_setup_window, txt_title_M4, winM4_brdr, winM4_bckgr, winM4_title_1, winM4_title_2)
	
	AUX_sys_setup_cursor_position[24] = {txt = txt_add("OFF", font_screen_menu_cyan_14_right, 510, 460, 150, 20), x="510", y="410", w="150"}
	AUX_sys_setup_cursor_position[25] = {txt = txt_add("3", font_screen_menu_cyan_14_right, 510, 485, 150, 20), x="510", y="435", w="150"}
	
	-----------------------------------------------------------------------------------------------------------
	-----------------------------------------------------------------------------------------------------------
	
	local txt_title_R1 = txt_add("MFD DATA BAR FIELDS", font_screen_menu_white_14_left, 735, 70, 310, 20)
	local winR1_brdr = img_add("color_grey.png", 685, 90, 310, 110)
	local winR1_bckgr = img_add("color_black.png", 687, 92, 306, 106)
	
	local winR1_title_1 = txt_add("FIELD 1", font_screen_menu_grey_14_left, 690, 100, 150, 20)
	local winR1_title_2 = txt_add("FIELD 2", font_screen_menu_grey_14_left, 690, 125, 150, 20)
	local winR1_title_3 = txt_add("FIELD 3", font_screen_menu_grey_14_left, 690, 150, 150, 20)
	local winR1_title_4 = txt_add("FIELD 4", font_screen_menu_grey_14_left, 690, 175, 150, 20)
	group_obj_add(grp_AUX_sys_setup_window, txt_title_R1, winR1_brdr, winR1_bckgr, winR1_title_1, winR1_title_2, winR1_title_3, winR1_title_4)
	
	AUX_sys_setup_cursor_position[26] = {txt = txt_add("---", font_screen_menu_cyan_14_right, 840, 100, 150, 20), x="840", y="100", w="150"}
	AUX_sys_setup_cursor_position[27] = {txt = txt_add("---", font_screen_menu_cyan_14_right, 840, 125, 150, 20), x="840", y="125", w="150"}
	AUX_sys_setup_cursor_position[28] = {txt = txt_add("---", font_screen_menu_cyan_14_right, 840, 150, 150, 20), x="840", y="150", w="150"}
	AUX_sys_setup_cursor_position[29] = {txt = txt_add("---", font_screen_menu_cyan_14_right, 840, 175, 150, 20), x="840", y="175", w="150"}
	
	-----------------------------------------------------------------------------------------------------------
	
	local txt_title_R2 = txt_add("GPS CDI", font_screen_menu_white_14_left, 735, 215, 310, 20)
	local winR2_brdr = img_add("color_grey.png", 685, 235, 310, 60)
	local winR2_bckgr = img_add("color_black.png", 687, 237, 306, 56)
	
	local winR2_title_1 = txt_add("SELECTED", font_screen_menu_grey_14_left, 690, 245, 150, 20)
	local winR2_title_2 = txt_add("SYSTEM CDI", font_screen_menu_grey_14_left, 690, 270, 150, 20)
	group_obj_add(grp_AUX_sys_setup_window, txt_title_R2, winR2_brdr, winR2_bckgr, winR2_title_1, winR2_title_2)
	
	AUX_sys_setup_cursor_position[30]= {txt = txt_add("AUTO", font_screen_menu_cyan_14_right, 840, 245, 150, 20), x="840", y="260", w="150"}
	AUX_sys_setup_cursor_position[31]= {txt = txt_add("2.0NM", font_screen_menu_cyan_14_right, 840, 270, 150, 20), x="840", y="285", w="150"}
	
	-----------------------------------------------------------------------------------------------------------
	
	local txt_title_R3 = txt_add("COM CONFIG", font_screen_menu_white_14_left, 735, 310, 310, 20)
	local winR3_brdr = img_add("color_grey.png", 685, 330, 310, 35)
	local winR3_bckgr = img_add("color_black.png", 687, 332, 306, 31)
	
	local winR3_title_1 = txt_add("CHANNEL SPACING", font_screen_menu_grey_14_left, 690, 340, 200, 20)
	group_obj_add(grp_AUX_sys_setup_window, txt_title_R3, winR3_brdr, winR3_bckgr, winR3_title_1)
	
	AUX_sys_setup_cursor_position[32] = {txt = txt_add("25.0 KHz", font_screen_menu_cyan_14_right, 840, 340, 150, 20), x="840", y="340", w="150"}
	
	-----------------------------------------------------------------------------------------------------------
	
	local txt_title_R4 = txt_add("NEAREST APT", font_screen_menu_white_14_left, 735, 380, 310, 20)
	local winR4_brdr = img_add("color_grey.png", 685, 400, 310, 60)
	local winR4_bckgr = img_add("color_black.png", 687, 402, 306, 56)
	
	local winR4_title_1 = txt_add("RWY SURFACE", font_screen_menu_grey_14_left, 690, 410, 150, 20)
	local winR4_title_2 = txt_add("MIN LENGTH", font_screen_menu_grey_14_left, 690, 435, 150, 20)
	group_obj_add(grp_AUX_sys_setup_window, txt_title_R4, winR4_brdr, winR4_bckgr, winR4_title_1, winR4_title_2)
	
	AUX_sys_setup_cursor_position[33] = {txt = txt_add("HARD/SOFT", font_screen_menu_cyan_14_right, 840, 410, 150, 20), x="840", y="400", w="150"}
	AUX_sys_setup_cursor_position[34] = {txt = txt_add("0 FT", font_screen_menu_cyan_14_right, 840, 435, 150, 20), x="840", y="425", w="150"}
	
	-----------------------------------------------------------------------------------------------------------
	
	visible(grp_AUX_sys_setup_window, false)
	for k, v in pairs(AUX_sys_setup_cursor_position) do
		visible(AUX_sys_setup_cursor_position[k].txt, false)
	end
	
	-----------------------------------------
	-----------------------------------------
	-- FUNCTIONS
	-----------------------------------------
	-----------------------------------------
	
	local function set_cursor_layout()
		move(tmr_ref_cursor, AUX_sys_setup_cursor_position[AUX_sys_setup_current_position].x, AUX_sys_setup_cursor_position[AUX_sys_setup_current_position].y, AUX_sys_setup_cursor_position[AUX_sys_setup_current_position].w, 16)
		txt_style(AUX_sys_setup_cursor_position[AUX_sys_setup_current_position].txt, font_screen_menu_black_14)
	end
	
	local function reset_cursor_layout()
		txt_style(AUX_sys_setup_cursor_position[AUX_sys_setup_current_position].txt, font_screen_menu_cyan_14)
	end
	
	
	function AUX_sys_setup_FMS_base_up()
		reset_cursor_layout()
		AUX_sys_setup_current_position = AUX_sys_setup_current_position + 1
		if AUX_sys_setup_current_position > 13 then AUX_sys_setup_current_position = 1 end
		set_cursor_layout()
	end
	
	function AUX_sys_setup_FMS_base_dn()
		reset_cursor_layout()
		AUX_sys_setup_current_position = AUX_sys_setup_current_position - 1
		if AUX_sys_setup_current_position < 1 then AUX_sys_setup_current_position = 13 end
		set_cursor_layout()
	end
	
	
	
	function menu_AUX_sys_setup()
		screen_menu = "AUX_sys_setup"
		
	end
	tdays = 2
	days = tdays - 1
	print(os.date("%d-%b-%Y", os.time({year=os.date("%Y"), month=1, day=0}) + days*24*60*60) )
	-- os.date("%d-%b-%Y"
		
	local function screen_update(date_days, lcl_hr, lcl_mn, lcl_sc)
		
		if screen_menu == "AUX_sys_setup" then 
			-- DATE 
			days = date_days - 1
			txt_set(AUX_sys_setup_cursor_position[1].txt, os.date("%d-%b-%Y", os.time({year=os.date("%Y"), month=1, day=0}) + days*24*60*60))	--print(os.date("%d-%b-%Y", os.time({year=os.date("%Y"), month=1, day=0}) + days*24*60*60) )
			
			-- TIME
			txt_set(AUX_sys_setup_cursor_position[3].txt, lcl_hr..":"..lcl_mn..":"..lcl_sc)
		end
		
	end
	
	xpl_dataref_subscribe(	"sim/time/local_date_days", "INT",
							"sim/cockpit2/clock_timer/local_time_hours", "INT",
							"sim/cockpit2/clock_timer/local_time_minutes", "INT",
							"sim/cockpit2/clock_timer/local_time_seconds", "INT", screen_update)
	
	
	-- function none_MENU()
	-- end

	-- function none_FMS_base_up()
	-- end

	-- function none_FMS_base_up()
	-- end

	-- function none_FMS_base_dn()
	-- end

	-- function none_FMS_top_up()
	-- end

	-- function none_FMS_top_dn()
	-- end

	-- function none_FMS_press()
	-- end

	-- function none_ENTR()
	-- end

	-- function none_CLR()
	-- end

end