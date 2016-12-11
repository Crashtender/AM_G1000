function init_menu_library_lib()

	--------------------------------------------------------
	-- Softkey Menu Functions 
	--
	-- This needs to be implemented in the lib folder
	--------------------------------------------------------

	skmenu = setmetatable({}, {
		__call = function(skmenu, param)
			if param == "build" then
				skmenu[skmenu.setPage]()
			else
				skmenu[skmenu.setPage][param]()
			end
		end
	})
		
	function menuItem(menuPage, sk, name, functioncall)
		if skmenu[menuPage] == nil then
			skmenu[menuPage] = setmetatable({}, {
				__call = function(menuPage)
					for key,value in pairs(menuPage) do
						txt_set(_G[key], value.text) -- (_G[key], value.text)
					end
				end
			})	
		end
		
		skmenu[menuPage][sk] = setmetatable({}, {
			__call = function(sk)
				sk.exec()
			end
		})
		
		
		skmenu[menuPage][sk]["text"] = name
		skmenu[menuPage][sk]["exec"] = functioncall
		
	end

	--------------------------------------------------------
	--------------------------------------------------------

end