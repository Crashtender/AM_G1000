--===================================================================================================
-- Splash screen
--===================================================================================================

function init_splash_lib()
	
	local img_logo = img_add("logo.png", 0, 0, 1024, 768)
				
	function power_splash()
		
		if power_on then
		
			local function timer_callback_end_splash()
			
				visible(img_logo, false)
				
			end
			
			timer_start(5000, nil, timer_callback_end_splash)
			
		end
		
	end
	
end