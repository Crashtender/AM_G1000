--===================================================================================================
--
--		USED FONTS
--
--===================================================================================================
function init_fonts_lib()
	
	-- font_Error = 
	
	--Altimeter
	font_altitude_set_cyan = "-fx-font-family:Arial; -fx-font-size:20px; -fx-fill: cyan; -fx-text-alignment:center;" 
	font_altitude_set_yellow = "-fx-font-family:Arial; -fx-font-size:20px; -fx-fill: yellow; -fx-text-alignment:center;" 
	font_altitude_set_black = "-fx-font-family:Arial; -fx-font-size:20px; -fx-fill: black; -fx-text-alignment:center;" 

	font_altitude_clock_big = "-fx-font-size:28px; -fx-font-family:arial; -fx-font-weight:bold; -fx-fill:white;-fx-text-alignment:right"
	font_altitude_clock_small = "-fx-font-size:24px; -fx-font-family:arial; -fx-font-weight:bold; -fx-fill:white;-fx-text-alignment:center"
	
	font_altitude_tape_running_txt = "-fx-font-family:Arial; -fx-font-size:20px; -fx-fill: grey"

	font_vertical_speed = "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: white; -fx-text-alignment:center"

	font_alt_meters  = "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: cyan; -fx-text-alignment:center"
	
	font_BARO_value = "-fx-font-family:Arial; -fx-font-size:20px; -fx-fill: cyan; -fx-text-alignment:right"
	font_BARO_title = "-fx-font-family:Arial; -fx-font-size:12px; -fx-fill: cyan; -fx-text-alignment:left"
	
	-- Annunciators
	font_annunciator_warning = "-fx-font-family:Arial; -fx-font-size:14px; -fx-font-weight:bold; -fx-text-alignment:left; -fx-fill: red"
	font_annunciator_caution = "-fx-font-family:Arial; -fx-font-size:14px; -fx-font-weight:bold; -fx-text-alignment:left; -fx-fill: yellow"
	font_annunciator_black = "-fx-font-family:Arial; -fx-font-size:14px; -fx-font-weight:bold; -fx-text-alignment:left; -fx-fill: black"
	
	-- Attitude
	
	font_AHRS_allign = "-fx-font-family:Arial; -fx-font-size:20px; -fx-fill: yellow; -fx-text-alignment:center"

	-- Radios
	font_NavCom_white = "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left"
	font_NavCom_green = "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: lime; -fx-font-weight:bold; -fx-text-alignment:left"

	-- DME/BRG
	font_BRG_white_l = "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: white; -fx-text-alignment:left;"
	font_BRG_white_r = "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: white; -fx-text-alignment:right;"
	font_BRG_cyan_l = "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: cyan; -fx-text-alignment:left;"
	font_BRG_cyan_r = "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: cyan; -fx-text-alignment:right;"

	-- EIS
	font_fuel_black = "-fx-font-family:Arial; -fx-font-size:12px; -fx-fill: black; -fx-text-alignment:center;" 

	-- HSI
	
	font_HSI_green = "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: lime; -fx-text-alignment:left;"
	font_HSI_magenta = "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: magenta; -fx-text-alignment:left;"
	
	-- Info bar
	
	-- Menu
	
	font_SoftKeys = "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:center;"
	font_SoftKeys_pressed = "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: black; -fx-font-weight:bold; -fx-text-alignment:center;"
	
	-- Screen Menu
	font_screen_menu_white_10 = "-fx-font-family:Arial; -fx-font-size:10px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left"
	font_screen_menu_white_12 = "-fx-font-family:Arial; -fx-font-size:12px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:center"
	font_screen_menu_white_14 = "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:center"
	font_screen_menu_white_14_left = "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left"
	font_screen_menu_grey_14_left = "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: grey; -fx-font-weight:bold; -fx-text-alignment:left"
	font_screen_menu_black_12 = "-fx-font-family:Arial; -fx-font-size:12px; -fx-fill: black; -fx-font-weight:bold; -fx-text-alignment:center"
	font_screen_menu_black_14 = "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: black; -fx-font-weight:bold; -fx-text-alignment:center"
	font_screen_menu_cyan_12 = "-fx-font-family:Arial; -fx-font-size:12px; -fx-fill: cyan; -fx-font-weight:bold; -fx-text-alignment:center"
	font_screen_menu_cyan_14 = "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: cyan; -fx-font-weight:bold; -fx-text-alignment:center"
	font_screen_menu_cyan_14_left = "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: cyan; -fx-font-weight:bold; -fx-text-alignment:left"
	font_screen_menu_cyan_14_right = "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: cyan; -fx-font-weight:bold; -fx-text-alignment:right"

	-- OAT
		
	-- Speeds
	font_Vref = "-fx-font-family:Arial; -fx-font-size:12px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;"
	font_speed_clock_WHITE = "-fx-font-size:24px; -fx-font-family:arial; -fx-fill:white; -fx-font-weight:bold; -fx-text-alignment:right"
	font_speed_clock_YELLOW = "-fx-font-size:24px; -fx-font-family:arial; -fx-fill:yellow; -fx-font-weight:bold; -fx-text-alignment:right"

	-- Time
	
	-- Transponder
	
	-- Wind
	font_wind =  "-fx-font-family:Arial; -fx-font-size:12px; -fx-fill:white; -fx-text-alignment:right;"
	font_wind2 =  "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill:white; -fx-text-alignment:right;"

end