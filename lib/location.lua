------------------------------------------------
-- location specific functions
------------------------------------------------


function init_location_lib()

	local tbl_location = {}
		
	local function position_update(longitude, latitude, heading)
	
		tbl_location["lon"] = longitude
		tbl_location["lat"] = latitude
		tbl_location["hdg"] = heading
		
	end
	
	function get_position()
		return tbl_location.lon, tbl_location.lat, tbl_location.hdg
	end
	
	xpl_dataref_subscribe(
				  "sim/flightmodel/position/longitude", "DOUBLE",
				  "sim/flightmodel/position/latitude", "DOUBLE",
				  "sim/cockpit/gyros/psi_ind_degm3", "FLOAT",
				  position_update)
end