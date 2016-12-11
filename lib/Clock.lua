------------------------------------------------
-- Time
------------------------------------------------

function init_time_lib()

	local img_time_border = img_add("color_white.png" , 902 , 718 , 122 , 24)
	local img_time_box = img_add("color_black.png" , 903 , 719 , 120 , 22)

	local txt_time_prefix = txt_add("", "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: white; -fx-text-alignment:left;" , 906 , 720 , 60 , 20)
	local txt_time = txt_add("", "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: white; -fx-text-alignment:left;" , 955 , 720 , 100 , 20)

	local grp_time_box = group_add(img_time_border,img_time_box,txt_time_prefix,txt_time)
	visible(grp_time_box,false)
	
	function power_time_box(condition)
		visible(grp_time_box, condition)
	end
	

	time_zone = 0   -- 0=SYS 1=LCL 2=ZLU
	txt_set(txt_time_prefix, "SYS")

	function time_zone_set()
		time_zone = time_zone + 1
		if time_zone > 2 then time_zone = 0 end
		
		if time_zone == 0 then
			txt_set(txt_time_prefix, "SYS")
		elseif time_zone == 1 then
			txt_set(txt_time_prefix, "LCL")
		elseif time_zone == 2 then
			txt_set(txt_time_prefix, "ZLU")
		end
	end

	local function new_time(LCLhr, LCLmin, LCLsec, Zhr, Zmin, Zsec)
		if time_zone == 0 then
			txt_set(txt_time, os.date("%H:%M:%S") )
		elseif time_zone == 1 then
			txt_set(txt_time, string.format("%d:%02d:%02d", LCLhr, LCLmin, LCLsec))
		elseif time_zone == 2 then
			txt_set(txt_time, string.format("%d:%02d:%02d", Zhr, Zmin, Zsec))
		end
	end			  
	xpl_dataref_subscribe(
					  "sim/cockpit2/clock_timer/local_time_hours", "INT",
					  "sim/cockpit2/clock_timer/local_time_minutes", "INT",
					  "sim/cockpit2/clock_timer/local_time_seconds", "INT",
					  "sim/cockpit2/clock_timer/zulu_time_hours", "INT",
					  "sim/cockpit2/clock_timer/zulu_time_minutes", "INT",
					  "sim/cockpit2/clock_timer/zulu_time_seconds", "INT",
					  new_time)
		
end