------------------------------------------------
-- Wind Data
------------------------------------------------

function init_wind_lib()

	local img_wind_outer_border = img_add("color_black.png" , 245 , 465 , 80 , 50)
	local img_wind_inner_border = img_add("color_white.png" , 246 , 466 , 78 , 48)
	local img_wind_text_box = img_add("color_black.png" , 247 , 467 , 76 , 46)
	local img_wind_arrow1 = img_add("wind_arrow.png",nil,nil,nil,nil)
	local img_wind_arrow_north = img_add("wind_arrow.png",265 , 475 , 5 , 20)
	local img_wind_arrow_south = img_add("wind_arrow.png",265 , 475 , 5 , 20)
	img_rotate(img_wind_arrow_east, 180)
	local img_wind_arrow_east = img_add("wind_arrow.png",265 , 475 , 5 , 20)
	img_rotate(img_wind_arrow_east, 90)
	local img_wind_arrow_west = img_add("wind_arrow.png",265 , 475 , 5 , 20)
	img_rotate(img_wind_arrow_west, -90)

	--option 1 txts
	local txt_wind_head_tail_speed =txt_add("", font_wind,220 , 495 , 60 , 20)
	local txt_wind_xwind_speed =  txt_add("", font_wind,245 , 475 , 60 , 20)

	--option 2 txts
	local txt_wind_speed = txt_add("", font_wind2,250 , 480 , 60 , 20)

	--option 3 txts
	local txt_wind_trueheading = txt_add("", font_wind,260 , 477 , 60 , 20)
	local txt_wind_trueheading_speed = txt_add("", font_wind,260 , 495 , 60 , 20)

	local grp_wind_opt1 = group_add(img_wind_outer_border,img_wind_inner_border, img_wind_text_box, txt_wind_head_tail_speed,txt_wind_xwind_speed, img_wind_arrow_north, img_wind_arrow_south, img_wind_arrow_east, img_wind_arrow_west)
	local grp_wind_opt2 = group_add(img_wind_outer_border,img_wind_inner_border, img_wind_text_box, txt_wind_speed, img_wind_arrow1)
	local grp_wind_opt3 = group_add(img_wind_outer_border,img_wind_inner_border, img_wind_text_box, txt_wind_trueheading, txt_wind_trueheading_speed, img_wind_arrow1)
	visible(grp_wind_opt1,false)
	visible(grp_wind_opt2,false)
	visible(grp_wind_opt3,false)
	  

	wind_option = 0

	function wind1()
		wind_option = 1
		visible(grp_wind_opt2,false)
		visible(grp_wind_opt3,false)
		visible(grp_wind_opt1,true)
	end

	function wind2()
		wind_option = 2
		visible(grp_wind_opt1,false)
		visible(grp_wind_opt3,false)
		visible(grp_wind_opt2,true)
	end

	function wind3()
		wind_option = 3
		visible(grp_wind_opt1,false)
		visible(grp_wind_opt2,false)
		visible(grp_wind_opt3,true)
	end

	function wind_off()
		wind_option = 0
		visible(grp_wind_opt1,false)
		visible(grp_wind_opt2,false)
		visible(grp_wind_opt3,false)
	end


	local function new_wind(wind_heading, truespeed, plane_heading)

		wind_heading_relative = -(wind_heading-plane_heading)
		
		if wind_heading_relative < 0 then
			wind_heading_relative = 360 + wind_heading_relative
		end
		
		if wind_option == 0 then
			
		elseif wind_option == 1 then
			
			truespeedX = var_round((math.cos(wind_heading_relative-180) * truespeed),0)
			truespeedY = var_round((math.sin(wind_heading_relative-180) * truespeed),0)
			
			rotateX = 0
			rotateY = 0
			
			if truespeedX > 0 then
				visible(img_wind_arrow_west, true)
				visible(img_wind_arrow_east, false)
			else
				visible(img_wind_arrow_west, false)
				visible(img_wind_arrow_east, true)
			end
			
			if truespeedY > 0 then
				visible(img_wind_arrow_north, true)
				visible(img_wind_arrow_south, false)
			else
				visible(img_wind_arrow_north, false)
				visible(img_wind_arrow_south, true)
			end
			
			txt_set(txt_wind_xwind_speed, math.abs(truespeedX))
			txt_set(txt_wind_head_tail_speed, math.abs(truespeedY))
			
		 elseif wind_option == 2 then
			move(img_wind_arrow1,260 , 475 , 9 , 26)
			img_rotate(img_wind_arrow1,(wind_heading_relative))
			
			txt_set(txt_wind_speed, var_round(truespeed,0) )
			
		 elseif wind_option == 3 then
			move(img_wind_arrow1,265 , 480 , 8 , 23)
			img_rotate(img_wind_arrow1,var_round(wind_heading-180,0) )
			
			txt_set(txt_wind_trueheading, string.format("%3d" .. "\°T" , var_round(wind_heading,0)) )
			txt_set(txt_wind_trueheading_speed, string.format("%3d" .. "KTS" , var_round(truespeed,0)) )
		 end
	end

	xpl_dataref_subscribe(
						"sim/cockpit2/gauges/indicators/wind_heading_deg_mag", "FLOAT",
						"sim/cockpit2/gauges/indicators/wind_speed_kts", "FLOAT",
						"sim/cockpit/gyros/psi_vac_ind_degm", "FLOAT",
						new_wind)
end