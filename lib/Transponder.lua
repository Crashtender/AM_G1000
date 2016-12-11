------------------------------------------------
-- Transponder Data Box
------------------------------------------------

function init_transponder_lib(vfr_code)

	-- Visual elements
	
	local img_XPDR_border = img_add("color_white.png" , 721 , 718 , 182 , 24)
	local img_XPDR_box = img_add("color_black.png" , 722 , 719 , 180 , 22)
	local txt_XPDR_prefix = txt_add("XPDR", "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: white; -fx-text-alignment:left;" , 725 , 720 , 60 , 20)
	local txt_XPDR = txt_add("8888", "-fx-font-family:Arial; -fx-font-size:16px; -fx-fill:LIME; -fx-font-weight:bold; -fx-text-alignment:left;" , 780 , 720 , 50 , 20)
	local txt_XPDR_status = txt_add("","-fx-font-family:Arial; -fx-font-size:16px; -fx-fill:LIME; -fx-font-weight:bold; -fx-text-alignment:left;" , 820 , 720 , 40 , 20)
	local grp_XPDR_box = group_add(img_XPDR_border,img_XPDR_box,txt_XPDR_prefix,txt_XPDR,txt_XPDR_status)
	visible(grp_XPDR_box,false)
	
	local img_XPDR_code_border1 = img_add("color_green.png" , 770 , 720 , 50 , 1)
	local img_XPDR_code_border2 = img_add("color_green.png" , 770 , 740 , 50 , 1)
	local img_XPDR_code_border3 = img_add("color_green.png" , 770 , 720 , 1 , 21)
	local img_XPDR_code_border4 = img_add("color_green.png" , 820 , 720 , 1 , 21)
	local grp_XPDR_code_border = group_add(img_XPDR_code_border1,img_XPDR_code_border2,img_XPDR_code_border3,img_XPDR_code_border4)
	visible(grp_XPDR_code_border,false)

	
	function power_XPDR_box(condition)
		visible(grp_XPDR_box,condition)
	end

	local XPDR_offset = 1
	local new_XPDR_code = {_,_,_,_}

	local function XPDR_timer_activate()
		visible(grp_XPDR_code_border, false)
		xpl_dataref_write("sim/cockpit2/radios/actuators/transponder_code", "INT", table.concat(new_XPDR_code)+0)
		XPDR_offset = 1
		SK_menu = SK_menu_Main
		SK_menu_printScreen()
		new_XPDR_code = {_,_,_,_}
	end

	local function XPDR_timer_reset()
		visible(grp_XPDR_code_border, false)
		txt_set(txt_XPDR, string.format("%04d",XPDR_current_code))
		SK_menu = SK_menu_Main
		SK_menu_printScreen()
	end

	function xpdr0()
		if XPDR_offset ~= 5 then
			new_XPDR_code[XPDR_offset] = 0
			XPDR_offset = XPDR_offset + 1
			txt_set(txt_XPDR, table.concat(new_XPDR_code))
			if XPDR_offset == 5 then
				timer_stop(tmr_XPDR_reset_timer)
				tmr_XPDR_activation_timer = timer_start(5000,nil,XPDR_timer_activate)
			end
	   end
	end

	function xpdr1()
		if XPDR_offset ~= 5 then
			new_XPDR_code[XPDR_offset] = 1
			XPDR_offset = XPDR_offset + 1
			txt_set(txt_XPDR, table.concat(new_XPDR_code))
			if XPDR_offset == 5 then
				timer_stop(tmr_XPDR_reset_timer)
				tmr_XPDR_activation_timer = timer_start(5000,nil,XPDR_timer_activate)
			end
	   end
	end

	function xpdr2()
		if XPDR_offset ~= 5 then
			new_XPDR_code[XPDR_offset] = 2
			XPDR_offset = XPDR_offset + 1
			txt_set(txt_XPDR, table.concat(new_XPDR_code))
			if XPDR_offset == 5 then
				timer_stop(tmr_XPDR_reset_timer)
				tmr_XPDR_activation_timer = timer_start(5000,nil,XPDR_timer_activate)
			end
	   end
	end

	function xpdr3()
		if XPDR_offset ~= 5 then
			new_XPDR_code[XPDR_offset] = 3
			XPDR_offset = XPDR_offset + 1
			txt_set(txt_XPDR, table.concat(new_XPDR_code))
			if XPDR_offset == 5 then
				timer_stop(tmr_XPDR_reset_timer)
				tmr_XPDR_activation_timer = timer_start(5000,nil,XPDR_timer_activate)
			end
	   end
	end

	function xpdr4()
		if XPDR_offset ~= 5 then
			new_XPDR_code[XPDR_offset] = 4
			XPDR_offset = XPDR_offset + 1
			txt_set(txt_XPDR, table.concat(new_XPDR_code))
			if XPDR_offset == 5 then
				timer_stop(tmr_XPDR_reset_timer)
				tmr_XPDR_activation_timer = timer_start(5000,nil,XPDR_timer_activate)
			end
	   end
	end

	function xpdr5()
		if XPDR_offset ~= 5 then
			new_XPDR_code[XPDR_offset] = 5
			XPDR_offset = XPDR_offset + 1
			txt_set(txt_XPDR, table.concat(new_XPDR_code))
			if XPDR_offset == 5 then
				timer_stop(tmr_XPDR_reset_timer)
				tmr_XPDR_activation_timer = timer_start(5000,nil,XPDR_timer_activate)
			end
	   end
	end

	function xpdr6()
		if XPDR_offset ~= 5 then
			new_XPDR_code[XPDR_offset] = 6
			XPDR_offset = XPDR_offset + 1
			txt_set(txt_XPDR, table.concat(new_XPDR_code))
			if XPDR_offset == 5 then
				timer_stop(tmr_XPDR_reset_timer)
				tmr_XPDR_activation_timer = timer_start(5000,nil,XPDR_timer_activate)
			end
	   end
	end

	function xpdr7()
		if XPDR_offset ~= 5 then
			new_XPDR_code[XPDR_offset] = 7
			XPDR_offset = XPDR_offset + 1
			txt_set(txt_XPDR, table.concat(new_XPDR_code))
			if XPDR_offset == 5 then
				timer_stop(tmr_XPDR_reset_timer)
				tmr_XPDR_activation_timer = timer_start(5000,nil,XPDR_timer_activate)
			end
	   end
	end

	function xpdr_bksp()
		if XPDR_offset > 1 then
		   if XPDR_offset == 5 then
			   timer_stop(tmr_XPDR_activation_timer)
		   end
		   new_XPDR_code[XPDR_offset-1] = "_"
		   XPDR_offset = XPDR_offset-1
		   txt_set(txt_XPDR, table.concat(new_XPDR_code))
	   end
	end

	function xpdr_stby()
		xpl_command("sim/transponder/transponder_standby")
	end

	function xpdr_on()
		xpl_command("sim/transponder/transponder_on")
	end

	function xpdr_alt()
		xpl_command("sim/transponder/transponder_alt")
	end

	function xpdr_gnd()
		xpl_command("sim/transponder/transponder_ground")
	end

	function xpdr_vfr()
		xpl_dataref_write("sim/cockpit2/radios/actuators/transponder_code", "INT", vfr_code)
	end

	function xpdr_ident()
		xpl_command("sim/transponder/transponder_ident")
	end
	
	local function on_ground(onground)
		if onground then xpdr_stby()
		else xpdr_alt() end
	end
	xpl_dataref_subscribe("sim/flightmodel/failures/onground_any", "INT", on_ground)

	
	local function new_XPDR(code,mode,failure,ID)
		txt_set(txt_XPDR, string.format("%04d",code))
		XPDR_current_code = code
		if mode == 0 then txt_set(txt_XPDR_status, "OFF") end
		if mode == 1 then txt_set(txt_XPDR_status, "STBY") end
		if mode == 2 then txt_set(txt_XPDR_status, "TST") end
		if mode == 3 then txt_set(txt_XPDR_status, "ALT") end
		if mode == 4 then txt_set(txt_XPDR_status, "GND") end
		if mode == 5 then txt_set(txt_XPDR_status, "") end
		if ID == 1 then txt_set(txt_XPDR_status, "IDNT") end
	end
  
	xpl_dataref_subscribe(
					  "sim/cockpit/radios/transponder_code", "INT",
					  "sim/cockpit/radios/transponder_mode", "INT", --(off=0,stdby=1,on=2,test=3)
					  "sim/operation/failures/rel_xpndr", "INT",
					  "sim/cockpit/radios/transponder_id", "INT",
					  new_XPDR)

end