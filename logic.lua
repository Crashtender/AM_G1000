--===================================================================================================
--
--				=========================
--				 G1000 PFD by Crashtender
--				=========================
--
--				Resolution:	1468 x 941 with bezel
--						1024 x 768 screen only mode
--				This instrument is made for cockpit builders.
--				You can either build your own hardware around it
--				or use the G1000 bezel to control this unit.
--				 
--				This version is build for X-plane , 'WYSIWYG'.
--				Future updates can be expected as time permits.
--	
--				Missing features, please contact me on the forum.
--===================================================================================================





--===================================================================================================
--
--		USER SETUP
-- 
-- Over time options here will change. 
-- Some might be implemented in menu's and deleted here completely.
-- Others might appear for the time being.
-- All depends on development choises.
--
--===================================================================================================

-- Tweak the startup time
local startup_routine = false			-- Show the startup routine (the real thing takes about 25-30 seconds) true / false

-- set the time it takes for a 'long-press' response (2 seconds is standard)
local short_press_limit = 2				-- limits the time (in seconds) of a short press

--Units
local map_base_layer = 0 				-- 0=NONE 1=OSM_STANDARD, 2=OSM_CYCLE, 3=OSM_TRANSPORT, 4=OSM_MAPQUEST, 5=OSM_HUMANITARIAN
local vfr_code = 7000					-- transponder code for vfr traffic

local COM_preset_freq = 122800			-- COM preset frequency USE INTEGER!!!!
										-- (default 121.500 = emergency freq) 
										-- (122.800 = UNICOM)

local volume_sensitivity = 0.05			-- amount of volume change per detent (0-1)

-- reversionary_mode = false			-- TODO  set this to true to always have the EIS displayed, or false as in normal operation

local map_update_interval = 1			-- inset map update interval in seconds; lowering value raises processor time and vice versa

-- *********************************************
-- *****   WHICH PLANE ARE YOU GONNA FLY?  *****
-- *********************************************

plane = "C172SP"

-- Choose from the list below
--
-- **** CESSNA
-- =============================================
-- * "C172SP" (Default)
--
--
-- **** DAHER SOCATA
-- =============================================
-- * "TBM850"
--
--
-- Didn't find your favourite plane in this list?
-- Contact me at the forum and we might work it out.


--===================================================================================================
--===================================================================================================
--===================================================================================================
--===================================================================================================
--===================================================================================================
--===================================================================================================
--===================================================================================================
--===================================================================================================

-- !!! DO NOT MAKE CHANGES BELOW HERE !!!
-- !!! DO NOT MAKE CHANGES BELOW HERE !!!
-- !!! DO NOT MAKE CHANGES BELOW HERE !!!



--===================================================================================================
--
--		LAYOUT INITTIALIZATION IN Z-ORDER
--
--===================================================================================================

-- Black background for startup routine
img_add_fullscreen("color_black.png")

--===================================================================================================
local instrument_operator = 1 	-- 1=pilot; 2=copilot

power_on = false
	
init_extra_functions_lib()
init_fonts_lib()
init_location_lib()
init_info_bar_lib()
init_NAV_radio_lib(volume_sensitivity)
init_COM_radio_lib(volume_sensitivity, COM_preset_freq)
init_attitude_lib()
init_flight_director_lib()
init_speed_lib()
init_altimeter_lib(instrument_operator)
init_VDI_lib(instrument_operator)
init_OAT_lib(instrument_operator)
init_time_lib(instrument_operator)
init_wind_lib(instrument_operator)
init_transponder_lib(vfr_code)
init_DME_lib(instrument_operator)
init_BRG_lib(instrument_operator)
init_HSI_lib(instrument_operator)
init_ILS_lib(instrument_operator)
init_inset_map(instrument_operator, map_update_interval)
_G["init_eis_"..plane.."_lib"](instrument_operator)
init_CAS_lib()
init_AFCS_annun_lib()
init_traffic_lib()

init_screen_menu_none_lib()
init_screen_menu_FMS_default_lib()
init_screen_menu_tmr_ref_lib()
init_screen_menu_AUX_sys_setup_lib()

init_bezel_input_lib(instrument_operator, short_press_limit)

init_menu_library_lib()
init_menu_lib()

init_splash_lib()

init_power_lib()

--===================================================================================================
--
--            TEST TEST TEST TEST TEST 
--
--===================================================================================================

-- PRINT ALL GLOBAL VARIABLES
-----------------------------------------------
-- print("-- List  of all Global Variables --")
-- for n in pairs(_G) do 
	-- print(n)
-- end
-- print("-- List  of all Global Variables --")

--===================================================================================================
--
--            INSTRUMENT SPECIAL FUNCTIONS
--
--===================================================================================================

-------------------------------
-- REVERSIONARY MODE --
-------------------------------
-- function reversionary_mode(rev_mode)
-- 	if rev_mode == 1 then
-- 		eis_open()
-- 	else
-- 		eis_close()
-- 	end
-- end
-- am_variable_subscribe("REVERSIONARY_MODE", "INT", reversionary_mode)