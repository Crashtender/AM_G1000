------------------------------------------------
-- Horizontal Situation Indicator (HSI)
------------------------------------------------

function init_HSI_lib(instrument_operator)

	-- Turn Rate Indicator --
	local img_compas_top = img_add("compas_top.png" , 397 , 422 , 125 , 28)

	-- Compas Rose --
	local img_compas_rose = img_add("compas_rose.png", 315 , 444 , 291 , 291)
	local img_HSI_tickmark_1 = img_add("color_white.png", 342 , 479 , 15 , 2)
	img_rotate(img_HSI_tickmark_1, 45)
	local img_HSI_tickmark_2 = img_add("color_white.png", 564 , 479 , 15 , 2)
	img_rotate(img_HSI_tickmark_2, -45)
	local img_HSI_tickmark_3 = img_add("color_white.png", 295 , 588 , 15 , 2)
	local img_HSI_tickmark_4 = img_add("color_white.png", 607 , 588 , 15 , 2)
	local img_HSI_tickmark_5 = img_add("color_white.png", 342 , 698 , 15 , 2)
	img_rotate(img_HSI_tickmark_5, -45)
	local img_HSI_tickmark_6 = img_add("color_white.png", 564 , 698 , 15 , 2)
	img_rotate(img_HSI_tickmark_6, 45)
	local grp_HSI_tickmarks = group_add(img_HSI_tickmark_1,img_HSI_tickmark_2, img_HSI_tickmark_3, img_HSI_tickmark_4, img_HSI_tickmark_5, img_HSI_tickmark_6)
	visible(grp_HSI_tickmarks, false)

	-- Turn rate trend
	local img_turn_trend_right = img_add("turn_trend_right.png" , 307 , 436 , 306 , 306)
	local img_turn_trend_left = img_add("turn_trend_left.png" , 307 , 436 , 306 , 306)
	img_turn_trend_left_pointer = img_add("triangle_magenta.png", 367, 460, 16, 13)
	img_rotate(img_turn_trend_left_pointer, -125)
	img_turn_trend_right_pointer = img_add("triangle_magenta.png", 537, 460, 16, 13)
	img_rotate(img_turn_trend_right_pointer, 125)
	viewport_rect(img_turn_trend_left , 207 , 436 , 253 , 350)
	viewport_rect(img_turn_trend_right , 460 , 436 , 253 , 350)
	local grp_turnrate = group_add(img_turn_trend_right,img_turn_trend_left, img_turn_trend_left_pointer, img_turn_trend_right_pointer)
	visible(grp_turnrate, false)

	-- Heading Bug --
	local img_HDG_bug = img_add("heading_bug.png", 448 , 444 , 25, 8)

	-- Current Heading box --
	local img_hdg_box_pointer = img_add("color_white.png", 452 , 424 , 16 , 16)
	img_rotate(img_hdg_box_pointer, 45)
	local img_hdg_box = img_add("color_black.png" , 425 , 401 , 70 , 32)
	
	local txt_Current_HDG = txt_add("000" , "-fx-font-family:Arial; -fx-font-size:26px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:right;" , 435 , 403 , 54 , 52)
	
	-- Set Heading box --
	local img_hdg_set_box_border = img_add("color_white.png" , 273 , 423 , 89 , 28)
	local img_hdg_set_box = img_add("color_black.png" , 275 , 425 , 85 , 24)
	local txt_hdg_set_value = txt_add("", "-fx-font-family:Arial; -fx-font-size:20px; -fx-fill: cyan; -fx-text-alignment:right;" ,  300 , 427 , 50 , 24)
	local txt_hdg_set_title = txt_add("HDG               ", "-fx-font-family:Arial; -fx-font-size:12px; -fx-fill: cyan; -fx-text-alignment:center;" , 275 , 435 , 85 , 20)
	local grp_HDG_set_box = group_add(img_hdg_set_box_border,img_hdg_set_box,txt_hdg_set_value,txt_hdg_set_title)
	visible(grp_HDG_set_box, false)

	-- Course box --
	local img_crs_set_box_border = img_add("color_white.png" , 548 , 423 , 89 , 28)
	local img_crs_set_box = img_add("color_black.png" , 550 , 425 , 85 , 24)
	local txt_crs_set_value = txt_add("", "-fx-font-family:Arial; -fx-font-size:20px; -fx-fill: gold; -fx-text-alignment:right;" ,  573 , 427 , 50 , 24)
	local txt_crs_set_title = txt_add("CRS               ", "-fx-font-family:Arial; -fx-font-size:12px; -fx-fill: gold; -fx-text-alignment:center;" , 548 , 435 , 85 , 20)
	local grp_course_box = group_add(img_crs_set_box_border,img_crs_set_box,txt_crs_set_value,txt_crs_set_title)
	visible(grp_course_box,false)

	-- Needles --
	local img_GPS_needle = img_add("GPS_needle.png" , 449 , 449 , 22 , 278)
	local img_GPS_center_needle = img_add("color_magenta.png" , 458 , 529 , 4 , 120)
	
	local img_VOR1_needle = img_add("VOR1_needle.png" , 449 , 449 , 22 , 278)
	local img_VOR1_center_needle = img_add("color_green.png" , 458 , 529 , 4 , 120)
	
	local img_VOR2_needle = img_add("VOR2_needle.png" , 449 , 449 , 22 , 278)
	local img_VOR2_center_needle = img_add("VOR2_center_needle.png" , 454 , 529 , 12 , 120)
	grp_center_needles = group_add(img_GPS_center_needle, img_VOR1_center_needle, img_VOR2_center_needle)
	
	local img_needle_deflection_bckg = img_add("color_black.png" , 373 , 711 , 174 , 25)
	visible(img_needle_deflection_bckg, false)
	
	local img_GPS_tofrom = img_add("triangle_green.png" , 450 , 519 , 16 , 13)
	local img_VOR1_tofrom = img_add("triangle_green.png" , 452 , 519 , 16 , 13)
	local img_VOR2_tofrom = img_add("triangle_green.png" , 452 , 519 , 16 , 13)
	
	local img_needle_deflection = img_add("needle_deflection.png" , 388 , 585 , 144 , 8)
	
	local grp_GPS_needle = group_add(img_GPS_needle,img_GPS_tofrom,img_GPS_center_needle)
	visible(grp_GPS_needle,false)
	local grp_VOR1_needle = group_add(img_VOR1_needle,img_VOR1_tofrom,img_VOR1_center_needle)
	visible(grp_VOR1_needle,false)
	local grp_VOR2_needle = group_add(img_VOR2_needle,img_VOR2_tofrom,img_VOR2_center_needle)
	visible(grp_VOR2_needle,false)
	
	-- Airplane icon --
	local img_airplane_icon = img_add("airplane_icon.png" , 440 , 569 , 40 , 40)
	local grp_HSI = group_add(img_hdg_box_pointer,img_hdg_box, txt_Current_HDG, img_compas_top, img_compas_rose,img_HDG_bug,img_needle_deflection,img_airplane_icon,img_HSI_tickmark_1,img_HSI_tickmark_2,img_HSI_tickmark_3,img_HSI_tickmark_4,img_HSI_tickmark_5,img_HSI_tickmark_6)
	visible(grp_HSI,false)

	local txt_source = txt_add("NAV1", font_HSI_green, 400 , 529 , 50 , 18)
	local txt_flight_fase = txt_add("TEST", font_HSI_green, 470 , 529 , 50 , 18)
	local grp_HSI_txts = group_add(txt_source,txt_flight_fase)
	visible(grp_HSI_txts, false)
	
	function power_HSI(power)
		visible(grp_HSI,power)
		visible(grp_HSI_txts, power)
		visible(grp_HDG_set_box, power)
		visible(grp_course_box, power)
		visible(grp_HSI_tickmarks, power)
		if power == false then
			visible(grp_VOR1_needle,power)
			visible(grp_VOR2_needle,power)
			visible(grp_turnrate, power)
		end
	end
	
	-- HSI modus 360/arc
	local HSI_modus = "360"
			
	function HSI_360()
		if power_on then
			HSI_modus = "360"
			-- Turn Rate Indicator --
			move(img_compas_top, 410 , 422 , 99 , 28)

			-- Compas Rose --
			move(img_compas_rose, 315 , 444 , 291 , 291)
			visible(grp_HSI_tickmarks, true)

			-- Turn rate trend
			move(img_turn_trend_right, 307 , 436 , 306 , 306)
			move(img_turn_trend_left, 307 , 436 , 306 , 306)
			
			move(img_turn_trend_left_pointer, 384, 447, 16, 13)
			move(img_turn_trend_right_pointer, 520, 447, 16, 13)

			-- Heading Bug --
			move(img_HDG_bug, 448 , 444 , 25, 290)

			-- Heading box --
			move(img_hdg_box_pointer, 452 , 424 , 16 , 16)
			move(img_hdg_box, 425 , 401 , 70 , 32)
			move(txt_Current_HDG, 435 , 403 , 54 , 52)

			-- Set Heading box --
			move(img_hdg_set_box_border, 273 , 423 , 89 , 28)
			move(img_hdg_set_box, 275 , 425 , 85 , 24)
			move(txt_hdg_set_value,  300 , 427 , 50 , 24)
			move(txt_hdg_set_title, 275 , 435 , 85 , 20)

			-- Course box --
			move(img_crs_set_box_border, 548 , 423 , 89 , 28)
			move(img_crs_set_box, 550 , 425 , 85 , 24)
			move(txt_crs_set_value,  573 , 427 , 50 , 24)
			move(txt_crs_set_title, 548 , 435 , 85 , 20)
			
			-- info
			move(txt_source, 400 , 529 , nil , nil)
			move(txt_flight_fase, 470 , 529 , nil , nil)
			
			 -- -- Needles --
			visible(img_needle_deflection_bckg, false)
			move(img_needle_deflection, 388 , 585 , 144 , 8)
			
			move(img_GPS_needle, 449 , 449 , 22 , 278)
			move(img_GPS_tofrom, 452 , 519 , nil , nil)
			move(img_GPS_center_needle, 458 , 529 , 4 , 120)
			
			move(img_VOR1_needle, 449 , 449 , 22 , 278)
			move(img_VOR1_tofrom, 452 , 519 , nil , nil)
			move(img_VOR1_center_needle, 458 , 529 , 4 , 120)
			
			move(img_VOR2_needle, 449 , 449 , 22 , 278)
			move(img_VOR2_tofrom, 452 , 519 , nil , nil)
			move(img_VOR2_center_needle, 454 , 529 , 12 , 120)
			
			if HSI_source == 0 then 
				visible(img_VOR1_center_needle, true)
			elseif HSI_source == 1 then
				visible(img_VOR2_center_needle, true)
			elseif HSI_source == 2 then
				visible(img_GPS_center_needle, true)
			end
		end
	end

	function HSI_arc()
	
		brg_HSI_arc()
		dme_HSI_arc()
		
		HSI_modus = "arc"
		-- Turn Rate Indicator --
		move(img_compas_top, 378 , 545 , 163 , 42)

		-- Compas Rose --
		move(img_compas_rose, 210 , 574 , 500 , 500)
		visible(grp_HSI_tickmarks, false)

		-- Turn rate trend
		move(img_turn_trend_right, 197 , 560 , 526 , 526)
		move(img_turn_trend_left, 197 , 560 , 526 , 526)
		
		move(img_turn_trend_left_pointer, 330, 580, 24, 20)
		move(img_turn_trend_right_pointer, 565, 580, 24, 20)

		-- Heading Bug --
		move(img_HDG_bug, 439 , 574 ,  43, 500)

		-- Heading box --
		move(img_hdg_box_pointer, 452 , 555, 16 , 16)
		move(img_hdg_box, 425 , 532 , 70 , 32)
		move(txt_Current_HDG, 435 , 532 , 54 , 52)

		-- Set Heading box --
		move(img_hdg_set_box_border, 243 , 563 , 89 , 28)
		move(img_hdg_set_box, 245 , 565 , 85 , 24)
		move(txt_hdg_set_value,  270 , 567 , 50 , 24)
		move(txt_hdg_set_title, 245 , 575 , 85 , 20)

		-- Course box --
		move(img_crs_set_box_border, 589 , 563 , 89 , 28)
		move(img_crs_set_box, 591 , 565 , 85 , 24)
		move(txt_crs_set_value,  613 , 567 , 50 , 24)
		move(txt_crs_set_title, 591 , 575 , 85 , 20)
		
		-- info
		move(txt_source, 400 , 680 , nil , nil)
		move(txt_flight_fase, 470 , 680 , nil , nil)
		
		 -- -- Needles --
		visible(img_needle_deflection_bckg, true)
		img_rotate(img_needle_deflection , 0)
		move(img_needle_deflection, 388 , 720 , 144 , 8)
		
		visible(img_GPS_center_needle, false)
		move(img_GPS_needle, 442 , 579 , 37 , 478)
		move(img_GPS_tofrom, 450 , 717 , nil , nil)
		
		visible(img_VOR1_center_needle, false)
		move(img_VOR1_needle, 442 , 579 , 37 , 478)
		move(img_VOR1_tofrom, 452 , 717 , nil , nil)
		
		visible(img_VOR2_center_needle, false)
		move(img_VOR2_needle, 442 , 579 , 37 , 478)
		move(img_VOR2_tofrom, 452 , 717 , nil , nil)
		
		visible(img_airplane_icon, false)
	end

	HSI_source = 0 --  0 for Nav1, 1 for Nav2, 2 for GPS
	
	function cdi_select()
		if		HSI_source == 0 then
			xpl_command("sim/autopilot/hsi_select_nav_2")
		elseif	HSI_source == 1 then
			xpl_command("sim/autopilot/hsi_select_nav_1") --  TODO ; replace with code below when GPS is available
			-- xpl_command("sim/autopilot/hsi_select_gps")
		-- elseif	HSI_source == 2 then
			-- xpl_command("sim/autopilot/hsi_select_nav_1")	
		end
	end
	
	function new_HSI_source(pilot_HSI_source, copilot_HSI_source)
		
		if power_on then
			if instrument_operator == 1 then
				HSI_source = pilot_HSI_source
			elseif instrument_operator == 2 then
				HSI_source = copilot_HSI_source
			end
			visible(img_VOR1_center_needle, false)
			visible(img_VOR2_center_needle, false)
			visible(img_GPS_center_needle, false)
			
			if HSI_source == 0 then
		
				txt_style(txt_NAV1_act_freq, font_NavCom_green)
				txt_style(txt_NAV2_act_freq, font_NavCom_white)
				visible(grp_VOR1_needle,true)
				visible(grp_VOR2_needle,false)
				visible(grp_GPS_needle,false)
				txt_set(txt_source, "NAV1")
				txt_style(txt_source,font_HSI_green)
				txt_style(txt_flight_fase,font_HSI_green)
				txt_set(txt_flight_fase, "")
				
				if 	HSI_modus == "360" then 
					visible(img_VOR1_center_needle, true)
				else
					visible(img_VOR1_center_needle, false)
				end
			   
			elseif HSI_source == 1 then
			
				txt_style(txt_NAV1_act_freq, font_NavCom_white)
				txt_style(txt_NAV2_act_freq, font_NavCom_green)
				visible(grp_VOR1_needle,false)
				visible(grp_VOR2_needle,true)
				visible(grp_GPS_needle,false)
				txt_set(txt_source, "NAV2")
				txt_style(txt_source,font_HSI_green)
				txt_style(txt_flight_fase,font_HSI_green)
				txt_set(txt_flight_fase, "")
				
				if 	HSI_modus == "360" then 
					visible(img_VOR2_center_needle, true)
				else
					visible(img_VOR2_center_needle, false)
				end
			
			elseif HSI_source == 2 then
				
				txt_style(txt_NAV1_act_freq, font_NavCom_white)
				txt_style(txt_NAV2_act_freq, font_NavCom_white)
				visible(grp_VOR1_needle,false)
				visible(grp_VOR2_needle,false)
				visible(grp_GPS_needle,true)
				txt_set(txt_source, "GPS")
				txt_style(txt_source,font_HSI_magenta)
				txt_style(txt_flight_fase,font_HSI_magenta)
				txt_set(txt_flight_fase, "INOP")
				
				if 	HSI_modus == "360" then 
					visible(img_GPS_center_needle, true)
				else
					visible(img_GPS_center_needle, false)
				end
			end
		end
	end

	xpl_dataref_subscribe(	"sim/cockpit2/radios/actuators/HSI_source_select_pilot" , "INT" ,
							"sim/cockpit2/radios/actuators/HSI_source_select_copilot" , "INT" ,
							new_HSI_source)


	local function new_HSI(	pilot_source, copilot_source, 
							pilot_compasHDG, copilot_compasHDG, 
							apheading, 
							pilot_turn_rate_hdg, copilot_turn_rate_hdg,
							nav1crs, 
							pilot_nav1hdef, copilot_nav1hdef,
							nav1fromto, 
							nav2crs,
							pilot_nav2hdef, copilot_nav2hdef, 
							nav2fromto,
							gpshdef, groundtrack, gpsfromto)
		local x , y
		if power_on then
		
			local source
			if instrument_operator == 1 then source = pilot_source else source = copilot_source end
				
			local compasHDG
			if instrument_operator == 1 then compasHDG = pilot_compasHDG else compasHDG = copilot_compasHDG end
				
			local turn_rate_hdg
			if instrument_operator == 1 then turn_rate_hdg = pilot_turn_rate_hdg else turn_rate_hdg = copilot_turn_rate_hdg end
				
			local nav1hdef
			if instrument_operator == 1 then nav1hdef = pilot_nav1hdef else nav1hdef = copilot_nav1hdef end
				
			local nav2hdef
			if instrument_operator == 1 then nav2hdef = pilot_nav2hdef else nav2hdef = copilot_nav2hdef end
			
			-- Turn the compas_rose
			img_rotate(img_compas_rose, -compasHDG )
			
			--Set Current Heading text
			txt_set(txt_Current_HDG , string.format("%03d" .. "\°" , var_round(compasHDG,0)) )
			
			-- Set selected heading text
			txt_set(txt_hdg_set_value, string.format("%03d" .. "\°" , var_round(apheading,0)) )
			
			-- Rotate heading bug
			img_rotate(img_HDG_bug,(apheading - compasHDG))
			
			-- Turn rate indicator
			if turn_rate_hdg < -24 then 
				visible(img_turn_trend_left_pointer, true)
			else
				visible(img_turn_trend_left_pointer, false)
			end
			
			if turn_rate_hdg > 24 then 
				visible(img_turn_trend_right_pointer, true)
			else
				visible(img_turn_trend_right_pointer, false)
			end
			
			local turn_rate_hdg = var_cap(turn_rate_hdg, -24, 24)
			
			if turn_rate_hdg < 0 then
				img_rotate(img_turn_trend_left, turn_rate_hdg)
			else
				img_rotate(img_turn_trend_right, turn_rate_hdg)
			end
			
			if source == 0 then
			
				-- Set Course text
			   txt_set(txt_crs_set_value, string.format("%03d" .. "\°" , var_round(nav1crs,0)) )
			   nav1hdef = var_cap(nav1hdef , -2 , 2)
			   deflection = var_round(nav1hdef * 34 , 0)               -- 34 pixels per dot deflection
			   
			   -- Rotate needles
			   
			   img_rotate(img_VOR1_needle , -compasHDG + nav1crs)
				if HSI_modus == "360" then
					x , y = geo_rotate_coordinates ( -compasHDG + nav1crs + 90 , deflection )
					img_rotate(img_needle_deflection , -compasHDG + nav1crs) 
					img_rotate(img_VOR1_center_needle , -compasHDG + nav1crs)
					img_move(img_VOR1_center_needle, 458 + x, 529 + y, nil, nil)
					img_geo_rotate_relative (img_VOR1_tofrom, 452, 519, 16, 13, 460, 589, -compasHDG + nav1crs)
					img_rotate(img_VOR1_tofrom , -compasHDG + nav1crs)
					
				elseif HSI_modus == "arc" then
					move(img_VOR1_tofrom, 452 + deflection, nil, nil, nil)
					img_rotate(img_VOR1_tofrom, nav1fromto * 180)
				end
			
			
			elseif source == 1 then
				
				-- Set Course text
			   txt_set(txt_crs_set_value, string.format("%03d" .. "\°" , var_round(nav2crs,0)) )
			   nav2hdef = var_cap(nav2hdef , -2 , 2)
			   deflection = var_round(nav2hdef * 34 , 0)
			   
			   -- Rotate needles
			   img_rotate(img_VOR2_needle , -compasHDG + nav2crs)
			   if HSI_modus == "360" then
					x , y = geo_rotate_coordinates ( -compasHDG + nav2crs + 90 , deflection )
					img_rotate(img_needle_deflection , -compasHDG + nav2crs)
					img_rotate(img_VOR2_center_needle , -compasHDG + nav2crs)
					img_move(img_VOR2_center_needle, 454 + x, 529 + y, nil, nil)
					img_geo_rotate_relative (img_VOR2_tofrom, 452, 519, 16, 13, 460, 589, -compasHDG + nav2crs)
					img_rotate(img_VOR2_tofrom , -compasHDG + nav1crs)
				elseif HSI_modus == "arc" then
					move(img_VOR2_tofrom, 452 + deflection, nil, nil, nil)
					img_rotate(img_VOR2_tofrom, nav1fromto * 180)
				end	
			   
			elseif source == 2 then
				
			--	Set Course text
				txt_set(txt_crs_set_value, string.format("%03d" .. "\°" , var_round(groundtrack,0)) )
				gpshdef = var_cap(gpshdef , -2 , 2)
			   deflection = var_round(gpshdef * 34 , 0)
				
			 --	Rotate needles
				img_rotate(img_GPS_needle , -compasHDG + groundtrack)
				if HSI_modus == "360" then 
					x , y = geo_rotate_coordinates ( -compasHDG + groundtrack + 90 , deflection )
					img_rotate(img_needle_deflection , -compasHDG + groundtrack)
					img_rotate(img_VOR2_center_needle , -compasHDG + groundtrack)
					img_move(img_VOR2_center_needle, 458 + x, 529 + y, nil, nil)
					img_geo_rotate_relative (img_GPS_tofrom, 452, 519, 16, 13, 460, 589, -compasHDG + groundtrack)
					img_rotate(img_GPS_tofrom , -compasHDG + groundtrack)
				elseif HSI_modus == "arc" then
					move(img_GPS_tofrom, 452 + deflection, nil, nil, nil)
					img_rotate(img_GPS_tofrom, gpsfromto * 180)
				end			
			end	
		end
	end

	xpl_dataref_subscribe(
					  "sim/cockpit2/radios/actuators/HSI_source_select_pilot" , "INT" ,
					  "sim/cockpit2/radios/actuators/HSI_source_select_copilot" , "INT" ,
					  "sim/cockpit/gyros/psi_ind_elec_pilot_degm", "FLOAT",
					  "sim/cockpit/gyros/psi_ind_elec_pilot_degm", "FLOAT", ---------------------
					  "sim/cockpit/autopilot/heading_mag" , "FLOAT" ,
					  "sim/cockpit2/gauges/indicators/turn_rate_roll_deg_pilot" , "FLOAT" ,
					  "sim/cockpit2/gauges/indicators/turn_rate_roll_deg_copilot" , "FLOAT" ,
					  "sim/cockpit/radios/nav1_obs_degm" , "FLOAT" , -----------------------
					  "sim/cockpit2/radios/indicators/nav1_hdef_dots_pilot" , "FLOAT" ,
					  "sim/cockpit2/radios/indicators/nav1_hdef_dots_copilot" , "FLOAT" ,
					  "sim/cockpit2/radios/indicators/nav1_fromto", "INT",
					  "sim/cockpit/radios/nav2_obs_degm" , "FLOAT" , --------------------------
					  "sim/cockpit2/radios/indicators/nav2_hdef_dots_pilot" , "FLOAT" ,
					  "sim/cockpit2/radios/indicators/nav2_hdef_dots_pilot" , "FLOAT" ,
					  "sim/cockpit2/radios/indicators/nav2_fromto", "INT",
					  "sim/cockpit2/radios/indicators/gps_hdef_dots_pilot" , "FLOAT" ,
					  "sim/cockpit/gps/course", "FLOAT" ,
					  "sim/cockpit2/radios/indicators/gps_fromto", "INT",
					  new_HSI)
	
	HSI_360()
end