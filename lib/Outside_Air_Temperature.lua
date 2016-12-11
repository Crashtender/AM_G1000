------------------------------------------------
-- Outside Air Temperature (OAT)
------------------------------------------------

function init_OAT_lib()
  
	img_OAT_border = img_add("color_white.png" , 0, 717 , 89 , 26)
	img_OAT_box = img_add("color_black.png" , 2 , 719 , 85 , 22)
	txt_OAT_prefix = txt_add("OAT     °C", "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: white; -fx-text-alignment:center;" , 2 , 720 , 83 , 20)
	txt_OAT = txt_add("", "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: white; -fx-text-alignment:right;" , 22 , 720 , 40 , 20)
	grp_OAT_box = group_add(img_OAT_border,img_OAT_box,txt_OAT_prefix,txt_OAT)
	visible(grp_OAT_box,false)
  
	function power_OAT_box(condition)
		visible(grp_OAT_box,condition)
	end

	function OAT_position(x_oat, y_oat)
		move(img_OAT_border, x_oat, y_oat , 87 , 24)
		move(img_OAT_box, x_oat+1 , y_oat+1 , 85 , 22)
		move(txt_OAT_prefix, x_oat+2 , y_oat+1 , 83 , 20)
		move(txt_OAT, x_oat+22 , y_oat+2 , 40 , 20)
	end


	function toggle_temp()
		xpl_command("sim/instruments/thermo_units_toggle")
	end

	local function new_OAT(OATc, OATf, OATunit)
		if OATunit == 1 then
		   txt_set(txt_OAT_prefix,"OAT     °C")
		   txt_set(txt_OAT, var_round(OATc,0))
		else
		   txt_set(txt_OAT_prefix,"OAT     °F")
		   txt_set(txt_OAT, var_round(OATf,0))
		end
	end

	xpl_dataref_subscribe(
					  "sim/cockpit2/temperature/outside_air_temp_degc", "FLOAT",
					  "sim/cockpit2/temperature/outside_air_temp_degf", "FLOAT",
					  "sim/cockpit2/temperature/outside_air_temp_is_metric", "INT",
					  new_OAT)
end