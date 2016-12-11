------------------------------------------------
-- COM radios
------------------------------------------------

function init_COM_radio_lib(volume_sensitivity, COM_preset_freq)

	local txt_COM1_title = txt_add("COM1", "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 965, 5, 100, 20)
	local txt_COM1_act_freq = txt_add("888.888", font_NavCom_white, 810, 3, 100, 20)
	local txt_COM1_stby_freq = txt_add("888.888", font_NavCom_white, 900, 3, 100, 20)

	local txt_COM2_title = txt_add("COM2", "-fx-font-family:Arial; -fx-font-size:14px; -fx-fill: white; -fx-font-weight:bold; -fx-text-alignment:left;", 965, 30, 100, 20)
	local txt_COM2_act_freq = txt_add("888.888", font_NavCom_white, 810, 28, 100, 20)
	local txt_COM2_stby_freq = txt_add("888.888", font_NavCom_white, 900, 28, 100, 20)

	local grp_COM_titles = group_add(txt_COM1_title,txt_COM2_title)
	visible(grp_COM_titles, false)
	local grp_COM_frequencies = group_add(txt_COM1_act_freq,txt_COM1_stby_freq,txt_COM2_act_freq,txt_COM2_stby_freq)

	local img_COM_transfer = img_add("switch_active.png", 873, 9, 20, 10)
	
	local img_COM_box_L = img_add("color_green.png", 897, 2, 2, 20)
	local img_COM_box_R = img_add("color_green.png", 959, 2, 2, 22)
	local img_COM_box_T = img_add("color_green.png", 897, 2, 63, 2)
	local img_COM_box_B = img_add("color_green.png", 897, 22, 63, 2)
	group_obj_add(grp_COM_frequencies, img_COM_box_B, img_COM_box_L, img_COM_box_R, img_COM_box_T, img_COM_transfer)
	visible(grp_COM_frequencies, false)
	
	local function timer_callback_COM_startup()
		visible(grp_COM_frequencies, true)
	end
		
	function power_COM_radios(condition)
		visible(grp_COM_titles, condition)
		visible(grp_COM_frequencies, false)
		if condition == true then
			tmr_COM_startup = timer_start(6500, nil, timer_callback_COM_startup)	
		end
	end
	
	local COM_tuning = 1 -- which COM radio is selected for tuning
	
	----------------
	-- COM VOLUME --
	----------------
	local radio_memory_volume = 0
	local radio_volume_setting = 1
	
	local function new_COM_vol(vol)
		radio_volume_setting = vol
	end
	xpl_dataref_subscribe("sim/operation/sound/radio_volume_ratio", "FLOAT", new_COM_vol)
	
	function dial_COM_vol_up()
		if radio_volume_setting < 1 then
			local new_volume = radio_volume_setting + volume_sensitivity
			xpl_dataref_write("sim/operation/sound/radio_volume_ratio", "FLOAT", new_volume)
		end
	end


	function dial_COM_vol_down()
		if radio_volume_setting > 0 then
			local new_volume = radio_volume_setting - volume_sensitivity
			xpl_dataref_write("sim/operation/sound/radio_volume_ratio", "FLOAT", new_volume)
		end
	end


	function COM_vol_pressed()
		if radio_volume_setting == 0 then 
			xpl_dataref_write("sim/operation/sound/radio_volume_ratio", "FLOAT", radio_memory_volume)
		else 
			radio_volume_setting = 0
		end
	end


	-------------
	-- COM XFR --
	-------------
	function COM_XFR_pressed()
		if COM_tuning == 1 then
			xpl_command("sim/radios/com1_standy_flip")
			fsx_event("COM_STBY_RADIO_SWAP")
		elseif COM_tuning == 2 then
			xpl_command("sim/radios/com2_standy_flip")
			fsx_event("COM2_RADIO_SWAP")
		end
	end


	---------
	-- COM --
	---------

	function stby_COM_fine_up()
		if COM_tuning == 1 then
			xpl_command("sim/radios/stby_com1_fine_up")
			fsx_event("KEY_COM_RADIO_FRACT_INC_CARRY")
		elseif COM_tuning == 2 then
			xpl_command("sim/radios/stby_com2_fine_up")
			fsx_event("KEY_COM2_RADIO_FRACT_INC_CARRY")
		end
	end

	function stby_COM_fine_down()
		if COM_tuning == 1 then
			xpl_command("sim/radios/stby_com1_fine_down")
			fsx_event("KEY_COM_RADIO_FRACT_DEC_CARRY")
		elseif COM_tuning == 2 then
			xpl_command("sim/radios/stby_com2_fine_down")
			fsx_event("KEY_COM2_RADIO_FRACT_DEC_CARRY")
		end
	end

	function stby_COM_coarse_up()
		if COM_tuning == 1 then
			xpl_command("sim/radios/stby_com1_coarse_up")
			fsx_event("KEY_COM_RADIO_WHOLE_INC")
		elseif COM_tuning == 2 then
			xpl_command("sim/radios/stby_com2_coarse_up")
			fsx_event("KEY_COM2_RADIO_WHOLE_INC")
		end
	end

	function stby_COM_coarse_down()
		if COM_tuning == 1 then
			xpl_command("sim/radios/stby_com1_coarse_down")
			fsx_event("KEY_COM_RADIO_WHOLE_DEC")
		elseif COM_tuning == 2 then
			xpl_command("sim/radios/stby_com2_coarse_down")
			fsx_event("KEY_COM2_RADIO_WHOLE_DEC")
		end
	end
	
	function COM_preset()
		if COM_tuning == 1 then
			xpl_dataref_write("sim/cockpit2/radios/actuators/com1_frequency_hz_833", "INT", COM_preset_freq)
		elseif COM_tuning == 2 then
			xpl_dataref_write("sim/cockpit2/radios/actuators/com2_frequency_hz_833", "INT", COM_preset_freq)
		end
	end


	local function draw_COM_box(COM)

		local box_offset = 0
		
		if COM == 1 then 
			box_offset = 0
		elseif COM == 2 then 
			box_offset = 25
		end
		
		move(img_COM_box_L, 897, box_offset + 3, nil, nil)
		move(img_COM_box_R, 959, box_offset + 3, nil, nil)
		move(img_COM_box_T, 897, box_offset + 3, nil, nil)
		move(img_COM_box_B, 897, box_offset + 23, nil, nil)
		
		move(img_COM_transfer, 873, box_offset + 9, nil, nil)
	end

	function COM_PUSH_1_2_pressed()
		if COM_tuning == 1 then
			COM_tuning = 2
			draw_COM_box(2)
		elseif COM_tuning == 2 then
			COM_tuning = 1
			draw_COM_box(1)
		end
	end

	local function new_com_freq(com1act, com1stby, com2act, com2stby)
		txt_set(txt_COM1_act_freq, new_var_format(com1act/1000, 3))
		txt_set(txt_COM1_stby_freq, new_var_format(com1stby/1000, 3))
		txt_set(txt_COM2_act_freq, new_var_format(com2act/1000, 3))
		txt_set(txt_COM2_stby_freq, new_var_format(com2stby/1000, 3))	
	end
	
	local function new_com_freq_FSX(com1act, com1stby, com2act, com2stby)
		new_com_freq(com1act*100+0.01, com1stby*100+0.01, com2act*100+0.01, com2stby*100+0.01)
	end

	xpl_dataref_subscribe(
						"sim/cockpit2/radios/actuators/com1_frequency_hz_833", "INT",
						"sim/cockpit2/radios/actuators/com1_standby_frequency_hz_833", "INT",
						"sim/cockpit2/radios/actuators/com2_frequency_hz_833", "INT",
						"sim/cockpit2/radios/actuators/com2_standby_frequency_hz_833", "INT",
						new_com_freq)

	fsx_variable_subscribe(	"COM ACTIVE FREQUENCY:1", "Mhz",
							"COM STANDBY FREQUENCY:1", "Mhz",
							"COM ACTIVE FREQUENCY:2", "Mhz",
							"COM STANDBY FREQUENCY:2", "Mhz",
							new_com_freq_FSX)


end



