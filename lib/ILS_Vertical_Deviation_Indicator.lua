------------------------------------------------
-- Vertical Deviation Indicator
------------------------------------------------

function init_VDI_lib()
	
	local img_glidepath_indicator = img_add("magenta_diamond.png",685,275,15,20)
	local img_glideslope_indicator = img_add("green_diamond.png",685,275,15,20)
	local grp_VDI_indicators = group_add(img_glidepath_indicator,img_glideslope_indicator)
	visible(grp_VDI_indicators, false)

	local img_VDI_ID_border = img_add("color_white.png",680,157,24,24)
	local img_VDI_box = img_add("color_black.png",682,159,20,20)
	local txt_VDI_ID = txt_add("G", "-fx-font-family:Arial; -fx-font-size:18px; -fx-fill: lime; -fx-text-alignment:center;" ,  683 , 159 , 18 , 18)
	local img_VDI_top = img_add("color_white.png",680,179,24,2)
	local img_VDI_bottom = img_add("color_white.png",680,390,24,2)
	local img_VDI_left = img_add("color_white.png",680,180,2,210)
	local img_VDI_right = img_add("color_white.png",702,180,2,210)
	local img_VDI_infill = img_add("TR_25_Black.png",682,181,18,208)
	local img_VDI_circle_1 = img_add("VDI_circle.png",686,200,10,10)
	local img_VDI_circle_2 = img_add("VDI_circle.png",686,240,10,10)
	local img_VDI_circle_3 = img_add("VDI_circle.png",686,280,10,10)
	local img_VDI_circle_4 = img_add("VDI_circle.png",686,320,10,10)
	local img_VDI_circle_5 = img_add("VDI_circle.png",686,360,10,10)

	local grp_VDI = group_add(img_VDI_ID_border,
							img_VDI_box,txt_VDI_ID,
							img_VDI_top,img_VDI_bottom,img_VDI_left,img_VDI_right, img_VDI_infill,
							img_VDI_circle_1,img_VDI_circle_2,img_VDI_circle_3,img_VDI_circle_4, img_VDI_circle_5)
	visible(grp_VDI,false)
	
	function show_VDI(condition)
		visible(grp_VDI_indicators, condition)
		visible(grp_VDI,condition)
	end

	local function new_VDI(Vsignal, VDIsignal, VDIsignalGPS, plane_deg, crs1_deg, crs2_deg, vnav_armed)
		VDIsignal = var_cap(VDIsignal,-2.5,2.5)
		VDIsignalGPS = var_cap(VDIsignalGPS,-2.5,2.5)
		
		
		if vnav_armed == 1 then
			-- bij gebruik VNAV: magenta < met magenta V als ID
			txt_set(txt_VDI_ID, "V")
			txt_style(txt_VDI_ID, font)
		else
			-- regulier gebruik: groene ruit <> met groene G als ID			TODO
			txt_set(txt_VDI_ID, "G")
			txt_style(txt_VDI_ID, font)
		end
		-- bij GPS gebruik: magenta ruit <> met magenta G als ID
		
		if Vsignal == 1 then
			if HSI_source == 2 then
				visible(grp_VDI, true)
				visible(img_glidepath_indicator,true)
				move(img_glidepath_indicator, nil, 275 + VDIsignalGPS * 40 ,nil,nil)
			elseif HSI_source == 1 and ( math.abs(plane_deg - crs2_deg) < 107) then
				visible(grp_VDI, true)
				visible(img_glideslope_indicator,true)
				move(img_glideslope_indicator, nil, 275 + VDIsignal * 40 ,nil,nil) 
			elseif HSI_source == 0 and ( math.abs(plane_deg - crs1_deg) < 107) then 
				visible(grp_VDI, true)
				visible(img_glideslope_indicator,true)
				move(img_glideslope_indicator, nil, 275 + VDIsignal * 40 ,nil,nil) 
			else
				visible(grp_VDI, false)
				visible(grp_VDI_indicators, false)
			end
		end
	end
	xpl_dataref_subscribe(
					  "sim/cockpit2/radios/indicators/hsi_display_vertical_pilot", "INT", -- Boolean Vdef signal?
					  "sim/cockpit2/radios/indicators/hsi_vdef_dots_pilot", "FLOAT", -- Dots
					  "sim/cockpit/radios/gps_vdef_dot", "FLOAT", -- Dots
					  "sim/cockpit/gyros/psi_ind_elec_pilot_degm", "FLOAT",
					  "sim/cockpit/radios/nav1_obs_degm" , "FLOAT" ,
					  "sim/cockpit/radios/nav2_obs_degm" , "FLOAT" ,
					  "sim/cockpit2/autopilot/vnav_armed", "INT",
					  new_VDI)
end