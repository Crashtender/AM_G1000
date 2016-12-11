
------------------------------------------------
-- Top info bar
------------------------------------------------

function init_info_bar_lib()

	local img_top_bar = img_add("top_bar.png" , 0, 0, 1024 , 54)
	visible(img_top_bar, false)
	
	local txt_info_top_left = txt_add("", font_NavCom_white, 275, 3, 200, 20)
	local txt_info_top_right = txt_add("", font_NavCom_white, 550, 3, 200, 20)
	
	local txt_info_btm_left = txt_add("", font_NavCom_white, 275, 28, 200, 20)
	local txt_info_btm_mid = txt_add("", font_NavCom_white, 395, 28, 200, 20)
	local txt_info_btm_right = txt_add("", font_NavCom_white, 485, 28, 200, 20)
	
	local grp_info_bar = group_add(txt_info_top_left, txt_info_top_right, txt_info_btm_left, txt_info_btm_mid, txt_info_btm_right)
	visible(grp_info_bar, true)
	
	function power_info_bar(condition)
		visible(img_top_bar, condition)
		visible(grp_info_bar, condition)
	end
	
	function info_top_left(string)
		txt_set(txt_info_top_left, string)
	end
	
	function info_top_right(string)
		txt_set(txt_info_top_right, string)
	end
	
	function info_btm_left(string)
		txt_set(txt_info_btm_left, string)
	end
	
	function info_btm_mid(string)
		txt_set(txt_info_btm_mid, string)
	end
	
	function info_btm_right(string)
		txt_set(txt_info_btm_right, string)
	end
	
end