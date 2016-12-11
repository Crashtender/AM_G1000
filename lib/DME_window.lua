------------------------------------------------
-- DME window
------------------------------------------------

function init_DME_lib()

	
	-- DME window
	local dme_window = img_add("DME_window.png", 285, 590, 25, 80)
	local dme_window_sqr = img_add("color_black.png", 225, 590, 60, 80)
	local txt_dme_window_title = txt_add("DME", font_BRG_white_l, 228, 592, 90, 20)
	local txt_dme_window_tuning_mode = txt_add("SRC", font_BRG_cyan_l, 228, 611, 90, 20)
	local txt_dme_window_frequency = txt_add("888.88", font_BRG_cyan_l, 228, 630, 90, 20)
	local txt_dme_window_distance = txt_add("88.8".." NM", font_BRG_white_l, 228, 649, 100, 20)
	
	local grp_dme = group_add(
							dme_window,
							dme_window_sqr,
							txt_dme_window_title,
							txt_dme_window_tuning_mode,
							txt_dme_window_frequency,
							txt_dme_window_distance
							)
	
	visible(grp_dme, false)
	
	local dme_visible = false
	
	function select_dme()
		if dme_visible then
			visible(grp_dme, false)
			dme_visible = false
		else
			HSI_360()
			visible(grp_dme, true)
			dme_visible = true
		end
	end
	
	function dme_HSI_arc()
		visible(grp_dme, false)
		dme_visible = false
	end
	
	DME_source = 1
	
	function set_DME_source(src)
		DME_source = src
	end
	
	local function new_DME(nav1_frequency_hz, nav2_frequency_hz, nav1_has_dme, nav2_has_dme, nav1_dme_dist_m, nav2_dme_dist_m)
		if DME_source == 1 then
			txt_set(txt_dme_window_tuning_mode, "NAV 1")
			txt_set(txt_dme_window_frequency, new_var_format(nav1_frequency_hz/100,2) )
			if nav1_has_dme == 1 then
				txt_set(txt_dme_window_distance, (new_var_format(nav1_dme_dist_m,1)).." NM" )
			else
				txt_set(txt_dme_window_distance, "__._ NM")
			end
		elseif DME_source == 2 then
			txt_set(txt_dme_window_tuning_mode, "NAV 2")
			txt_set(txt_dme_window_frequency, new_var_format(nav2_frequency_hz/100,2) )
			txt_set(txt_dme_window_distance, new_var_format(nav2_dme_dist_m,1) )
			if nav2_has_dme == 1 then
				txt_set(txt_dme_window_distance, (new_var_format(nav2_dme_dist_m,1)).." NM" )
			else
				txt_set(txt_dme_window_distance, "__._ NM")
			end
		end
	end

	xpl_dataref_subscribe(
						"sim/cockpit2/radios/actuators/nav1_frequency_hz", "INT",
						"sim/cockpit2/radios/actuators/nav2_frequency_hz", "INT",
						"sim/cockpit2/radios/indicators/nav1_has_dme", "INT",
						"sim/cockpit2/radios/indicators/nav2_has_dme", "INT",
						"sim/cockpit/radios/nav1_dme_dist_m", "FLOAT",
						"sim/cockpit/radios/nav2_dme_dist_m", "FLOAT",		
						new_DME)

end
