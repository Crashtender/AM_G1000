
--===================================================================================================
--
-- EXTRA NEEDED FUNCTIONS
--
--===================================================================================================
function init_extra_functions_lib()

	--===================================================================================================
	--
	--		GLOBAL VARIABLES 
	--
	--===================================================================================================
	-- create variation in the math.random function basing it on the OS time
	math.randomseed( os.time() )

	---============================================================
	-- rounds a number to the nearest decimal places
	
	function round(val, decimal)
		if (decimal) then
			return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
		else
			return math.floor(val+0.5)
		end
	end

	--===================================================================
	
	function new_var_format(amount, decimal)
		local str_amount, formatted, famount, remain

		decimal = decimal or 2  -- default 2 decimal places
		
		famount = math.abs(round(amount,decimal))
		famount = math.floor(famount)

		remain = round(math.abs(amount) - famount, decimal)

			-- attach the decimal portion
		if (decimal > 0) then
			remain = string.sub(tostring(remain),3)
			formatted = famount .. "." .. remain ..
						string.rep("0", decimal - string.len(remain))
		end
		
		return formatted
	end
	--===================================================================
	-- New geo rotate function
	-- ============================

	-- After defining the image position and the center point of rotation this function
	-- calculates the radius and then moves the image along the given angle relative to
	-- the center of rotation.

	function img_geo_rotate_relative (img_id, img_x, img_y, img_width, img_height, x_center, y_center, degrees)
	
		x_img_center = img_x + (img_width / 2)
		y_img_center = img_y + (img_height / 2)
		radius = math.sqrt((x_center - x_img_center)^2 + (y_center - y_img_center)^2)
		local x_new_img_anchor
		local y_new_img_anchor
		
		if radius == 0 then
		   x_new_img_anchor = img_x
		   y_new_img_anchor = img_y
		else
		
		   current_rad = 0
		   
		   if math.asin((y_img_center - y_center)/radius) < 0 then
			   current_rad = 2 * math.pi - math.acos((x_img_center - x_center)/radius)
		   else
			   current_rad = math.acos((x_img_center - x_center)/radius)
		   end
		   
			displacement_rad = math.rad(degrees)
			new_rad = current_rad + displacement_rad
			x_new_img_center = radius * math.cos(new_rad) + x_center
			y_new_img_center = radius * math.sin(new_rad) + y_center
			x_new_img_anchor = var_round(x_new_img_center - (img_width / 2), 0)
			y_new_img_anchor = var_round(y_new_img_center - (img_height / 2), 0)
			
			move(img_id, x_new_img_anchor, y_new_img_anchor, img_width, img_height)
		end
	end
	
	--===================================================================
	-- DeepPrint
	--===================================================================

	-- Used to investigate the tables while debugging
	
	function DeepPrint (e)
		-- if e is a table, we should iterate over its elements
		if type(e) == "table" then
			for k,v in pairs(e) do -- for every element in the table
				print(k)
				DeepPrint(v)       -- recursively repeat the same procedure
			end
		print("-------------------------------------------------")
		else -- if not, we can just print it
			print(e)
		end
	end
	
end