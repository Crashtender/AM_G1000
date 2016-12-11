------------------------------------------------ 
-- CAS Crew Alerting System 
------------------------------------------------ 

function init_CAS_lib() 
   local item_height = 20 
   local img_CAS_brdr = img_add("color_white.png", 873, 420, 134, 20) 
   local img_CAS_bckgnd = img_add("color_black.png", 875, 423, 130, 20) 
   grp_CAS = group_add(img_CAS_brdr, img_CAS_bckgnd, txt_CAS_items) 
   visible(grp_CAS, false) 
	
   -- WARNINGS : RED 
   local warnings = {} 
   local warning_text = {} 
	
	local img_warning_bckg = img_add("color_red.png", 1000, 748, 20, 20)
	local txt_warning = txt_add("WARNING", font_SoftKeys, 1000, 748, 20, 20)
	grp_warning_annunciator = group_add(img_warning_bckg, txt_warning)
	
   -- CAUTION YELLOW: 
   local cautions = {} 
   local caution_text = {} 
   local warnings_count = 0 -- number of warning items 
   local cautions_count = 0 -- number of caution items 
   local total_CAS_count = 0 -- total number of CAS items 
   local cas_items = 0 -- limitted number for visible items 
   local mem_total_CAS_count = 999 
	
	local img_warning_bckg = img_add("color_yellow.png", 1000, 748, 20, 20)
	local txt_warning = txt_add("CAUTION", font_SoftKeys_pressed, 1000, 748, 20, 20)
	grp_warning_annunciator = group_add(img_warning_bckg, txt_warning)
	
   ------------------------------------------------------------------------------------------------------------------
	for i=1, 14 do
		warning_text[i] = txt_add("", font_annunciator_warning, 878, 424, 126, item_height) 
	end

	for j=1, 30 do
		caution_text[j] = txt_add("", font_annunciator_caution, 878, 424, 126, item_height) 
	end
   ------------------------------------------------------------------------------------------------------------------
   
   -- CAS Display Inhibits 
   -- Inhibits prevent certain CAS messages from being displayed during the following conditions: 

   -- Engine off 
   -- Engine on 
   -- Aircraft on ground 
   -- Takeoff (TOPI - Take-off Operation Phase inhibits) 
   -- Aircraft in air 
   -- Landing (LOPI - Landing Operation Phase inhibits) 

   -- TOPI Activates 
   ------------------- 
   -- Transitions from on-ground to in-air 
   -- IAS transitions > 50 knots  (on either PFD) 

   -- TOPI Deactivates 
   ------------------- 
   -- > 25 sec airborn 
   -- IAS < 40 knots (on either PFD) 
   -- Radar altitude (if available) > 400 ft AGL 
   -- Pressure altitude > 400 ft above field elevation 
   -- Active > 90 sec 

   -- LOPI Activates 
   ------------------- 
   -- Transitions from in-air to on-ground 
   -- Radar altitude (if available) < 400 ft AGL 
   -- Pressure altitude < 400 ft above field elevation 
   -- IAS transitions > 50 knots  (on either PFD) 

   -- LOPI Deactivates 
   ------------------- 
   -- > 25 sec on ground 
   -- IAS < 40 knots (on either PFD) 
   -- Radar altitude (if available) > 600 ft AGL 
   -- Pressure altitude > 600 ft above field elevation 
   -- Active > 90 sec 

	local engine_off = false 
	local engine_on = false 
	local aircraft_on_ground = false 
	local TOPI = false 
	local aircraft_in_air = false 
	local LOPI = false 
   
	function new_CAS_phase(engine, ground, iasPilot, iasCoPilot, pAltPilot, pAltCoPilot) 
		if engine[1] or engine[2] == 1 then 
			engine_on = true 
			engine_off = false 
			--print("engine on") 
			 if ground == 1 then 
				aircraft_on_ground = true 
				--print("aircraft on ground") 
				aircraft_in_air = false 
			 else 
				aircraft_on_ground = false 
				aircraft_in_air = true 
				--print("aircraft in air") 
			 end 
		  else 
         engine_on = false 
         engine_off = true 
         --print("engine off") 
         if ground == 1 then 
            aircraft_on_ground = true 
            --print("aircraft on ground") 
            aircraft_in_air = false 
         else 
            aircraft_on_ground = false 
            aircraft_in_air = true 
            --print("aircraft in air") 
         end 
      end 
      local TOPI_start_time = 0 
      if aircraft_on_ground == true then 
         if iasPilot > 50 or ground == 0 then 
            aircraft_on_ground = false 
            TOPI = true 
            TOPI_start_time = os.clock() 
            --print("TOPI") 
         end 
      end 
      if TOPI then 
         if    (os.clock() - TOPI_start_time) > 25 or iasCoPilot < 40 or iasPilot < 40 or pAltPilot > 400 or pAltCoPilot > 400 then 
            TOPI = false 
            aircraft_in_air = true 
            TOPI_start_time = 0 
            --print("aircraft_in_air") 
         end 
      end 
      local LOPI_start_time = 0 
      if aircraft_in_air then 
         if ground == 1 or pAltPilot < 400 or pAltCoPilot < 400 then 
            aircraft_in_air = false 
            LOPI = true 
            LOPI_start_time = os.clock() 
            --print("LOPI") 
         end 
      end 
      if LOPI then 
         if (os.clock() - LOPI_start_time) > 25 or iasPilot < 40 or iasCoPilot < 40 or pAltPilot > 600 or pAltCoPilot > 600 then 
            LOPI = false 
         end 
      end 
   end 
	xpl_dataref_subscribe(   "sim/flightmodel/engine/ENGN_running", "INT[8]", 
                     "sim/flightmodel/failures/onground_any", "INT", 
                     "sim/cockpit2/gauges/indicators/airspeed_kts_pilot", "FLOAT", 
                     "sim/cockpit2/gauges/indicators/airspeed_kts_copilot", "FLOAT", 
                     "sim/flightmodel/misc/h_ind", "FLOAT", 
                     "sim/flightmodel/misc/h_ind_copilot", "FLOAT", 
                     new_CAS_phase) 
   ------------------------------------------------------------------------------------------------------- 
	function hide_CAS()
		for k, v in pairs(warning_text) do 
			txt_set(warning_text[k], "")
		end  

		for k, v in pairs(caution_text) do 
			txt_set(caution_text[k], "") 
		end
		
		visible(grp_CAS, false)
  end
   
	function build_CAS()
		if power_on then
		  -- If there are already CAS messages, clear the list 
		  hide_CAS()
		  -- Build new list 
		  -- If there are no messages remove items from screen 
		  if total_CAS_count > 0 then   -- If there are CAS messages.... 
					-- build WARNING items 
					local i = 1 
			for k, v in pairs(warnings) do 
			  if v == 1 then 
							txt_set(warning_text[i],k)
							move(warning_text[i], 877, 464 - (cas_items * item_height) + (item_height*i), 126, item_height)
							i=i+1 
						end 
			end
			 -- build CAUTION items 
			 local j = 1 
			for k, v in pairs(cautions) do 
				if v == 1 then 
								txt_set(caution_text[j],k)
								move(caution_text[j], 877, 464 - (cas_items * item_height) + (warnings_count * item_height) + (item_height*j), 126, item_height)
								j=j+1 
				end 
			 end
			 move(img_CAS_brdr, 873, 460 - (item_height*cas_items) + item_height, 134, item_height * cas_items + 4) 
			 move(img_CAS_bckgnd, 875, 462 - (item_height*cas_items) + item_height, 130, item_height * cas_items) 
			 visible(grp_CAS, true) 
		 end
      end 
   end 
   
   
   ------------------------------------------------------------------------------------------------------- 

	-- engine_off = false 
	-- engine_on = false 
	-- aircraft_on_ground = false 
	-- TOPI = false 
	-- aircraft_in_air = false 
	-- LOPI = false
	
	local function new_annunciator()
		if power_on then
		
		
	
	--[[
	function new_annunciator(batt_chg_hi, cabin_alt, pilot_door, rel_door, eng_fire, flap1pos, flap2pos, fuel_tank, fuel_press, engn_ITT, oil_press, oilP_yellow_lo, oilP_yellow_hi, park_brake, engn_trq, red_lo_trq, fuel_pmp, batt_amps, batt_yellow_lo, batt_on, bleed_fail, chip, kg_fuel_tank, igniter, bat_low, oilT, pitot_HT_off, prop_deice, starter_on, low_vac) 
		
			-- BAT OVERHEAT Battery temperature over 70°C 
			warnings["BAT CHG HI"] = batt_chg_hi 
			
			-- BLEED TEMP Bleed temperature high X X 
			-- TODO warnings["BLEED TEMP"] 
			
			-- CABIN ALTITUDE Cabin altitude over 10,000 ft TODO 
			if cabin_alt > 10000 then 
				warnings["CABIN ALTITUDE"] = 1 
			else 
				warnings["CABIN ALTITUDE"] = 0 
			end 
			-- CABIN DIFF PRESS Cabin pressure differential over 6.2 psi X 
			-- TODO warnings["CABIN DIFF PRESS"] 
			
			-- DOOR Pilot or cabin door open 
			warnings["DOOR"] = pilot_door --or rel_door -- y   boolean   cabin door is open or rel door is open 
			
			-- FIRE Engine compartment fire (temperature over 200°C; if installed) 
			warnings["FIRE"] = eng_fire   -- y   boolean   engine fire - per engine 
			
			-- FLAPS ASYM Dissymmetry between left- and right-hand flaps 
			-- TODO flap1pos, flap2pos warnings["FLAPS ASYM"] 
			
			-- FUEL OFF Fuel tank selectors set to “Off” 
			if fuel_tank < 1 then 
				warnings["FUEL OFF"] = 1 
			else 
				warnings["FUEL OFF"] = 0 
			end 
			
			-- FUEL PRESS Fuel pressure below 10 psi 
			warnings["FUEL PRESS"] = fuel_press 
			
			-- ITT Engine start: ITT over 1000°C, 870°C (5 s), or 840°C (20 s) 
			local tmr840e1 
			local tmr870e1 
			local itt_tmr1_triggered = false 
			
			function callback_itt() 
				if running == timer_running(tmr840e1) then 
					timer_stop(tmr840e1)
				end 
				if running == timer_running(tmr870e1)then
					timer_stop(tmr870e1)
				end 
				itt_tmr_triggered = true 
			end 
			
			if engn_ITT[1] > 839 and eng_ITT[1] < 841 then 
				tmr840e1 = timer_start(20000, nil, callback_itt) 
			end 
			
			if engn_ITT[1] > 869 and eng_ITT[1] < 871 then 
				tmr870e1 = timer_start(5000, nil, callback_itt) 
			end 
			
			if engn_ITT[1] > 1000 or itt_tmr1_triggered then 
				warnings["ITT"] = 1 
			else 
				warnings["ITT"] = 0 
			end 
			
			-- Engine running: ITT over 840°C 
			-- TODO? also captured above with 20 sec delay 
			
			-- OIL PRESS Oil pressure below 60 psi 
			if oil_press[1] ~= nil then 
				if oil_press[1] < oilP_yellow_lo then 
					warnings["OIL PRESS"] = 1 
				else 
					warnings["OIL PRESS"] = 0 
				end 
			end 
			
			-- OXYGEN Oxygen cylinder closed 
			-- TODO 
			
			-- PARK BRAKE Parking brake applied 
			if park_brake > 0 then 
				warnings["PARK BRAKE"] = 1 
			else 
				warnings["PARK BRAKE"] = 0 
			end 
			
			-- TORQUE Torque greater than or equal to 121.4% maximum torque 
			if engn_trq[1] > red_lo_trq then 
				warnings["TORQUE"] = 1 
			else 
				warnings["TORQUE"] = 0 
			end 
			
			
			--------------------------------------------------------------------------------- 
			-- CAUTIONS 
			--------------------------------------------------------------------------------- 
			
			
			-- AUTO SEL Fuel timer off or out of service X 
			-- TODO
			
			-- AUX BOOST PMP ON Electric fuel pump running (manual or automatic mode) 
			cautions["BOOST PMP ON"] = fuel_pmp 
			
			-- BAT AMP Battery current over 50 A while on ground X X X 
			if batt_amps[1] > batt_yellow_lo then 
				cautions["BAT AMP"] = 1 
			else 
				cautions["BAT AMP"] = 0 
			end 
			
			-- BAT OFF Battery off X 
			cautions["BAT OFF"] = not batt_on 
			
			-- BLEED OFF Flow control and shut-off valve/shut-off valve closed X X X 
			cautions["BLEED OFF"] = bleed_fail[1] 
			
			-- -- CHIP Oil chip detector on (if installed) X X 
			cautions["CHIP"] = chip 
			
			-- FRONT CARGO DOOR Forward baggage door open X 
			-- 
			
			-- FUEL IMBALANCE Fuel tanks imbalanced by more than 15 USGAL for >30 seconds 
			local tmr_fuel_imbalance 
			
			function callback_fuel_imbalance() 
				cautions["FUEL IMBALANCE"] = 1 
			end 
			
			if math.abs(kg_fuel_tank[1] - kg_fuel_tank[2]) > (15 * 3.79) then 
				tmr_fuel_imbalance = timer_start(30000, nil, callback_fuel_imbalance) 
			else 
			if running == timer_running(tmr_fuel_imbalance) then timer_stop(tmr_fuel_imbalance) end 
			cautions["FUEL IMBALANCE"] = 0 
			end 
			
			-- FUEL LOW L-R* Fuel quantity less than or equal to 9.1 USGAL in specified tank 
			if kg_fuel_tank[1] < (9.1 * 3.79) then 
				cautions["FUEL LOW L"] = 1 
			else 
				cautions["FUEL LOW L"] = 0 
			end 
			
			if kg_fuel_tank[2] < (9.1 * 3.79) then 
				cautions["FUEL LOW L"] = 1 
			else 
				cautions["FUEL LOW L"] = 0 
			end 
			
			-- GPU DOOR GPU receptacle door not closed X X 
			
			-- IGNITION Ignition exciter running 
			cautions["IGNITION"] = igniter[1] 
			
			-- INERT SEP FAIL Inertial separator failure X X 
			-- 
			
			-- INERT SEP ON Inertial separator extended 
			-- 
			
			-- LOW LVL FAIL L-R* Low fuel level sensor failure for specified tank 
			-- 
			-- LOW VOLTAGE Battery voltage below 26 V X X 
			cautions["LOW VOLTAGE"] = bat_low 
			
			-- MAIN GEN Starter generator unconnected X X 
			-- 
			
			-- OIL PRESS Oil pressure between 60 and 100 psi X 
			if oil_press[1] ~= nil then 
				if oil_press[1] > oilP_yellow_lo and oil_press[1]  < oilP_yellow_hi then 
					cautions["OIL PRESS"] = 1 
				else 
					cautions["OIL PRESS"] = 0 
				end 
			end 
			
			-- OIL TEMP Oil temperature below 0°C or above 104°C X 
			if oilT < 0 or oilT > 104 then 
				cautions["OIL TEMP"] = 1 
			else 
				cautions["OIL TEMP"] = 0 
			end 
			
			-- PITOT HT ON L-R* Specified pitot heat (left or right) on while engine off X 
			cautions["PITOT HT ON"] = not pitot_HT_off 
			
			-- PITOT NO HT L-R* Specified pitot heat (left or right) off X 
			cautions["PITOT NO HT"] = pitot_HT_off 
			
			-- PROP DEICE FAIL Prop deice selected and not on X X 
			-- 
			-- PROP DEICE ON Prop deice on while engine off X 
			cautions["PROP DEICE ON"] = prop_deice 
			
			-- REAR CARGO DOOR Rear cargo door open X 
			-- 
			
			-- STALL HEAT ON Stall warning heat on while engine off X 
			-- 
			
			-- STALL NO HEAT Stall warning heat off X 
			-- 
			
			-- STARTER Starter generator running 
			cautions["STARTER"] = starter_on[1] 
			
			-- VACUUM LOW Vacuum pressure less than 3.75 in Hg X X 
			cautions["VACUUM LOW"] = low_vac ]]
			----------------------------------------------------------------------------------- 
			warnings_count = 0 
			for k, v in pairs(warnings) do 
				if v == 1 then
					warnings_count = warnings_count + 1 
				end
			end 
			----------------------------------------------------------------------------------- 
			----------------------------------------------------------------------------------- 
			cautions_count = 0 
			for k, v in pairs(cautions) do 
				if v == 1 then 
					cautions_count = cautions_count + 1 
				end
			end 
			----------------------------------------------------------------------------------- 
			----------------------------------------------------------------------------------- 
			total_CAS_count = warnings_count + cautions_count 
			-- limitted number for visible items 
			if total_CAS_count > 14 then 
				cas_items = 14 
			else 
				cas_items = total_CAS_count 
			end 
			----------------------------------------------------------------------------------- 
			----------------------------------------------------------------------------------- 
			if total_CAS_count == mem_total_CAS_count then 
				-- 
			else 
				build_CAS() 
			end 
			mem_total_CAS_count = total_CAS_count 
			----------------------------------------------------------------------------------- 
		end
	end 
	xpl_dataref_subscribe(	"sim/cockpit/warnings/annunciators/battery_charge_hi", "INT",   -- y   boolean   battery is charging too rapidly - may overheat 
							"sim/cockpit/warnings/annunciators/cabin_altitude_12500", "INT",   -- y   boolean   cabin altitude at or above 12500 
							"sim/cockpit/warnings/annunciators/cabin_door_open", "INT",   -- y   boolean   cabin door is open 
							"sim/operation/failures/rel_door_open", "INT",   -- y   boolean   cabin door is open 
							"sim/cockpit/warnings/annunciators/engine_fires", "INT[8]",   -- y   boolean   engine fire - per engine 
							"sim/flightmodel2/controls/flap1_deploy_ratio", "FLOAT", 
							"sim/flightmodel2/controls/flap2_deploy_ratio", "FLOAT", 
							"sim/cockpit/engine/fuel_tank_selector", "INT", 
							"sim/cockpit/warnings/annunciators/fuel_pressure_low", "INT[8]",   -- y   boolean   fuel pressure low - per engine 
							"sim/flightmodel/engine/ENGN_ITT_c", "FLOAT[8]", 
							"sim/flightmodel/engine/ENGN_oil_press_psi", "FLOAT[8]",   -- y   boolean   fuel pressure low - per engine 
							"sim/aircraft/limits/yellow_lo_oilP", "FLOAT", 
							"sim/aircraft/limits/yellow_hi_oilP", "FLOAT", 
							"sim/flightmodel/controls/parkbrake", "FLOAT", 
							"sim/flightmodel/engine/ENGN_TRQ", "FLOAT[8]", 
							"sim/aircraft/limits/red_lo_TRQ", "FLOAT", 
							"sim/cockpit/engine/fuel_pump_on", "INT[8]", 
							"sim/cockpit2/electrical/battery_amps", "FLOAT[8]", 
							"sim/aircraft/limits/yellow_lo_bat_amp", "FLOAT", 
							"sim/cockpit2/electrical/battery_on", "INT", 
							"sim/cockpit/warnings/annunciators/bleed_air_fail", "INT[8]", 
							"sim/cockpit/warnings/annunciators/chip_detect", "INT", 
							"sim/flightmodel/weight/m_fuel", "FLOAT[9]", 
							"sim/cockpit/warnings/annunciators/igniter_on", "INT[8]", 
							"sim/cockpit/warnings/annunciators/low_voltage","INT", 
							"sim/cockpit2/transmissions/indicators/oil_temperature", "INT", 
							"sim/cockpit/warnings/annunciators/pitot_heat_off", "INT", 
							"sim/cockpit2/ice/ice_prop_heat_on", "INT", 
							"sim/cockpit/engine/igniters_on", "INT[8]", 
							"sim/cockpit2/annunciators/low_vacuum", "INT", 
							new_annunciator) 
	
	warning_status = 0
	caution_status = 0
	
	local function warning_set()
		warning_status = 1
		visible(grp_warning_annunciator, true)
	end
	
	local function warning_reset()
		warning_status = 0
		visible(grp_warning_annunciator, false)
	end
	
	local function caution_set()
		caution_status = 1
		visible(grp_caution_annunciator, true)
	end
	
	local function caution_reset()
		caution_status = 0
		visible(grp_caution_annunciator, false)
	end
	
	local function alert_status(warning, caution) --, warning_acknowledged, caution_acknowledged)
		if warning == 1 then
			warning_set()
		elseif caution == 1 then
			caution_set()
		else
			warning_reset()
			caution_reset()
		end
	end
	xpl_dataref_subscribe("sim/cockpit/warnings/annunciators/master_caution", "INT",
							"sim/cockpit/warnings/annunciators/master_warning", "INT", alert_status)
	
	function annunciation_toggle()
		xpl_command("sim/annunciator/clear_master_caution")
		xpl_command("sim/annunciator/clear_master_warning")
	end
	
end 
