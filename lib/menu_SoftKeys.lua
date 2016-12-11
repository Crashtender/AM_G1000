-- Menu functionality
 
 
function init_menu_lib()

	-- Background image
	local img_bottom_bar = img_add("bottom_bar.png" , 0, 742, 1024 , 26)
	visible(img_bottom_bar, false)
	
	function power_bottom_bar(condition)
		visible(img_bottom_bar, condition)
	end
	
	-- Click press backgrounds
	local img_sk1_BG = img_add("color_grey.png", 0 , 746 , 85 , 25)
	local img_sk2_BG = img_add("color_grey.png" ,85 , 746 , 85 , 25)
	local img_sk3_BG = img_add("color_grey.png" , 170 , 746 , 85 , 25)
	local img_sk5_BG = img_add("color_grey.png" , 340 , 746 , 85 , 25)
	local img_sk6_BG = img_add("color_grey.png" , 425 , 746 , 85 , 25)
	local img_sk7_BG = img_add("color_grey.png" , 510 , 746 , 85 , 25)
	local img_sk8_BG = img_add("color_grey.png" , 595 , 746 , 85 , 25)
	local img_sk9_BG = img_add("color_grey.png" , 680 , 746 , 85 , 25)
	local img_sk10_BG = img_add("color_grey.png" , 765 , 746 , 85 , 25)
	local img_sk11_BG = img_add("color_grey.png" , 850 , 746 , 85 , 25)
	local img_sk12_BG = img_add("color_grey.png" , 935 , 746 , 85 , 25)
	
	local grp_sk_bg = group_add(img_sk1_BG,img_sk2_BG,img_sk3_BG,img_sk4_BG,img_sk5_BG,img_sk6_BG,img_sk7_BG,img_sk8_BG,img_sk9_BG,img_sk10_BG,img_sk11_BG,img_sk12_BG)
	visible(grp_sk_bg, false)
	
	function show_SK_BG(key)
		if 		key == 1 then visible(img_sk1_BG, true)
		elseif	key == 2 then visible(img_sk2_BG, true)
		elseif	key == 3 then visible(img_sk3_BG, true)
		elseif	key == 4 then visible(img_sk4_BG, true)
		elseif	key == 5 then visible(img_sk5_BG, true)
		elseif	key == 6 then visible(img_sk6_BG, true)
		elseif	key == 7 then visible(img_sk7_BG, true)
		elseif	key == 8 then visible(img_sk8_BG, true)
		elseif	key == 9 then visible(img_sk9_BG, true)
		elseif	key == 10 then visible(img_sk10_BG, true)
		elseif	key == 11 then visible(img_sk11_BG, true)
		elseif	key == 12 then visible(img_sk12_BG, true)
		end
	end

	function hide_SK_BG()
		visible(grp_sk_bg, false)
	end
	
	
	-- Menu item text place holders
	sk1 = txt_add("1" , font_SoftKeys , 0 , 747 , 85 , 25)
	sk2 = txt_add("2" , font_SoftKeys , 85 , 747 , 85 , 25)
	sk3 = txt_add("3" , font_SoftKeys , 170 , 747 , 85 , 25)
	sk4 = txt_add("4" , font_SoftKeys , 255 , 747 , 85 , 25)
	sk5 = txt_add("5" , font_SoftKeys , 340 , 747 , 85 , 25)
	sk6 = txt_add("6" , font_SoftKeys , 425 , 747 , 85 , 25)
	sk7 = txt_add("7" , font_SoftKeys , 510 , 747 , 85 , 25)
	sk8 = txt_add("8" , font_SoftKeys , 595 , 747 , 85 , 25)
	sk9 = txt_add("9" , font_SoftKeys , 680 , 747 , 85 , 25)
	sk10 = txt_add("10" , font_SoftKeys , 765 , 747 , 85 , 25)
	sk11 = txt_add("11" , font_SoftKeys , 850 , 747 , 85 , 25)
	sk12 = txt_add("12" , font_SoftKeys , 935 , 747 , 85 , 25)
	
	local grp_SK_texts = group_add(sk1,sk2,sk3,sk4,sk5,sk6,sk7,sk8,sk9,sk10,sk11,sk12)
	visible(grp_SK_texts, false)
	
	function power_SK_menu(condition)
		visible(grp_SK_texts, condition)
	end
	
	-- Make the menu items
	--====================
	
	function menu_item_inop() end

	function menu_main()
		skmenu.setPage = "menu_main"
		skmenu("build")
	end

	function menu_engine()
		_G[plane.."_eis_open"]()
		skmenu.setPage = "menu_engine"
		skmenu("build")
	end

	function eis_close()
		_G[plane.."_eis_close"]()
	end
	
	function menu_inset()
		skmenu.setPage = "menu_inset"
		skmenu("build")
		build_map_screen(10)
	end

	function inset_map_invisible()
		hide_map_screen()
		menu_main()
	end

	function menu_pfd()
		skmenu.setPage = "menu_pfd"
		skmenu("build")
	end

	function menu_wind()
		skmenu.setPage = "menu_wind"
		skmenu("build")
	end

	function menu_hsi_frmt()
		skmenu.setPage = "menu_hsi"
		skmenu("build")
	end

	function menu_alt()
		skmenu.setPage = "menu_alt"
		skmenu("build")
	end

	function menu_hsi()
		skmenu.setPage = "menu_hsi"
		skmenu("build")
	end

	function menu_xpdr()
		skmenu.setPage = "menu_xpdr"
		skmenu("build")
	end


	function menu_code()
		skmenu.setPage = "menu_code"
		skmenu("build")
	end
	

	-- MAIN {"", "INSET", "", "PFD", "OBS", "CDI", "ADF/DME", "XPDR", "IDENT", "TMR/REF", "NRST", "MSG"}
	menuItem("menu_main", "sk1", "ENGINE", menu_engine)
	menuItem("menu_main", "sk2", "INSET", menu_inset)
	menuItem("menu_main", "sk3", "", menu_item_inop)
	menuItem("menu_main", "sk4", "PFD", menu_pfd)
	menuItem("menu_main", "sk5", "", menu_item_inop)
	menuItem("menu_main", "sk6", "CDI", cdi_select)
	menuItem("menu_main", "sk7", "", menu_item_inop)
	menuItem("menu_main", "sk8", "XPDR", menu_xpdr)
	menuItem("menu_main", "sk9", "IDENT", xpdr_ident)
	menuItem("menu_main", "sk10", "TMR/REF", menu_tmr_ref)
	menuItem("menu_main", "sk11", "", menu_item_inop)
	menuItem("menu_main", "sk12", "", menu_item_inop)
	
	-- ENGINE {"ENGINE", "LEAN", "SYSTEM", "BACK", "", "", "", "", "", "", "", ""}
	menuItem("menu_engine", "sk1", "ENGINE", eis_close)
	menuItem("menu_engine", "sk2", "", menu_item_inop)
	menuItem("menu_engine", "sk3", "", menu_item_inop)
	menuItem("menu_engine", "sk4", "BACK", menu_main)
	menuItem("menu_engine", "sk5", "", menu_item_inop)
	menuItem("menu_engine", "sk6", "", menu_item_inop)
	menuItem("menu_engine", "sk7", "", menu_item_inop)
	menuItem("menu_engine", "sk8", "", menu_item_inop)
	menuItem("menu_engine", "sk9", "", menu_item_inop)
	menuItem("menu_engine", "sk10", "", menu_item_inop)
	menuItem("menu_engine", "sk11", "", menu_item_inop)
	menuItem("menu_engine", "sk12", "", menu_item_inop)
	
	-- INSET {"OFF", "DCLTR", "WX LGND", "TRAFFIC", "TOPO", "TERRAIN", "STRMSCP", "NEXRAD", "XM LTNG", "METAR", "BACK", "MSG"}
	menuItem("menu_inset", "sk1", "OFF", inset_map_invisible)
	menuItem("menu_inset", "sk2", "DCLTR", dcltr_map)
	menuItem("menu_inset", "sk3", "", menu_item_inop)
	menuItem("menu_inset", "sk4", "", menu_item_inop)
	menuItem("menu_inset", "sk5", "TOPO", new_baselayer)
	menuItem("menu_inset", "sk6", "", menu_item_inop)
	menuItem("menu_inset", "sk7", "", menu_item_inop)
	menuItem("menu_inset", "sk8", "", menu_item_inop)
	menuItem("menu_inset", "sk9", "", menu_item_inop)
	menuItem("menu_inset", "sk10", "", menu_item_inop)
	menuItem("menu_inset", "sk11", "BACK", menu_main)
	menuItem("menu_inset", "sk12", "", menu_item_inop)
	
	-- PFD {"SYN VIS", "DFLTS", "WIND", "DME", "BRG1", "HSI FRMT", "BRG2", "", "ALT UNIT", "STD BARO", "BACK", "MSG"}
	menuItem("menu_pfd", "sk1", "TIME", time_zone_set)
	menuItem("menu_pfd", "sk2", "Vref", toggle_Vref)
	menuItem("menu_pfd", "sk3", "WIND", menu_wind)
	menuItem("menu_pfd", "sk4", "DME", select_dme)
	menuItem("menu_pfd", "sk5", "BRG1", select_brg1)
	menuItem("menu_pfd", "sk6", "HSI FRMT", menu_hsi_frmt)
	menuItem("menu_pfd", "sk7", "BRG2", select_brg2)
	menuItem("menu_pfd", "sk8", "TMP UNIT", toggle_temp)
	menuItem("menu_pfd", "sk9", "ALT UNIT", menu_alt)
	menuItem("menu_pfd", "sk10", "STD BARO", baro_standard)
	menuItem("menu_pfd", "sk11", "BACK", menu_main)
	menuItem("menu_pfd", "sk12", "", menu_item_inop)
	
	-- WIND {"", "","OPT 1", "OPT 2", "OPT 3", "OFF", "", "", "", "", "BACK", "MSG"}
	menuItem("menu_wind", "sk1", "", menu_item_inop)
	menuItem("menu_wind", "sk2", "", menu_item_inop)
	menuItem("menu_wind", "sk3", "OPT 1", wind1)
	menuItem("menu_wind", "sk4", "OPT 2", wind2)
	menuItem("menu_wind", "sk5", "OPT 3", wind3)
	menuItem("menu_wind", "sk6", "OFF", wind_off)
	menuItem("menu_wind", "sk7", "", menu_item_inop)
	menuItem("menu_wind", "sk8", "", menu_item_inop)
	menuItem("menu_wind", "sk9", "", menu_item_inop)
	menuItem("menu_wind", "sk10", "", menu_item_inop)
	menuItem("menu_wind", "sk11", "BACK", menu_main)
	menuItem("menu_wind", "sk12", "", menu_item_inop)
	
	
	--HSI_FRMT	{"", "","", "", "", "360 HSI", "ARC HSI", "", "", "", "BACK", "MSG"}
	menuItem("menu_hsi", "sk1", "", menu_item_inop)
	menuItem("menu_hsi", "sk2", "", menu_item_inop)
	menuItem("menu_hsi", "sk3", "", menu_item_inop)
	menuItem("menu_hsi", "sk4", "", menu_item_inop)
	menuItem("menu_hsi", "sk5", "", menu_item_inop)
	menuItem("menu_hsi", "sk6", "360 HSI", HSI_360)
	menuItem("menu_hsi", "sk7", "ARC HSI", HSI_arc)
	menuItem("menu_hsi", "sk8", "", menu_item_inop)
	menuItem("menu_hsi", "sk9", "", menu_item_inop)
	menuItem("menu_hsi", "sk10", "", menu_item_inop)
	menuItem("menu_hsi", "sk11", "BACK", menu_main)
	menuItem("menu_hsi", "sk12", "", menu_item_inop)
	
	-- ALT_UNIT {"", "","", "", "", "METERS", "", "IN", "HPA", "", "BACK", "MSG"}
	menuItem("menu_alt", "sk1", "", menu_item_inop)
	menuItem("menu_alt", "sk2", "", menu_item_inop)
	menuItem("menu_alt", "sk3", "", menu_item_inop)
	menuItem("menu_alt", "sk4", "", menu_item_inop)
	menuItem("menu_alt", "sk5", "", menu_item_inop)
	menuItem("menu_alt", "sk6", "METERS", alt_meters)
	menuItem("menu_alt", "sk7", "", menu_item_inop)
	menuItem("menu_alt", "sk8", "IN", alt_in)
	menuItem("menu_alt", "sk9", "HPA", alt_hpa)
	menuItem("menu_alt", "sk10", "", menu_item_inop)
	menuItem("menu_alt", "sk11", "BACK", menu_pfd)
	menuItem("menu_alt", "sk12", "", menu_item_inop)
	
	-- XPDR		{"", "","STDBY", "ON", "ALT", "GND", "VFR", "CODE", "IDENT", "", "BACK", "MSG"}
	menuItem("menu_xpdr", "sk1", "", menu_item_inop)
	menuItem("menu_xpdr", "sk2", "", menu_item_inop)
	menuItem("menu_xpdr", "sk3", "STDBY", xpdr_stby)
	menuItem("menu_xpdr", "sk4", "ON", xpdr_on)
	menuItem("menu_xpdr", "sk5", "ALT", xpdr_alt)
	menuItem("menu_xpdr", "sk6", "GND", xpdr_gnd)
	menuItem("menu_xpdr", "sk7", "VFR", xpdr_vfr)
	menuItem("menu_xpdr", "sk8", "CODE", menu_code)
	menuItem("menu_xpdr", "sk9", "IDENT", xpdr_ident)
	menuItem("menu_xpdr", "sk10", "", menu_item_inop)
	menuItem("menu_xpdr", "sk11", "BACK", menu_main)
	menuItem("menu_xpdr", "sk12", "", menu_item_inop)
	
	-- CODE		{"0", "1", "2","3", "4", "5", "6", "7", "IDENT", "BKSP", "BACK", ""}
	menuItem("menu_code", "sk1", "0", xpdr0)
	menuItem("menu_code", "sk2", "1", xpdr1)
	menuItem("menu_code", "sk3", "2", xpdr2)
	menuItem("menu_code", "sk4", "3", xpdr3)
	menuItem("menu_code", "sk5", "4", xpdr4)
	menuItem("menu_code", "sk6", "5", xpdr5)
	menuItem("menu_code", "sk7", "6", xpdr6)
	menuItem("menu_code", "sk8", "7", xpdr7)
	menuItem("menu_code", "sk9", "IDENT", xpdr_ident)
	menuItem("menu_code", "sk10", "BKSP", xpdr_bksp)
	menuItem("menu_code", "sk11", "BACK", menu_main)
	menuItem("menu_code", "sk12", "", menu_item_inop)
	
	skmenu.setPage = "menu_main"
	skmenu("build")

end