------------------------------------------------ 
-- ILS
------------------------------------------------

function init_ILS_lib(instrument_operator)
  
	local img_ILS_marker_black = img_add("color_black.png",666,120,28,28)
	local img_ILS_marker_white = img_add("color_white.png",668,122,24,24)
	local img_ILS_marker_yellow = img_add("color_yellow.png",670,124,20,20)
	local img_ILS_marker_cyan = img_add("color_cyan.png",670,124,20,20)
	local txt_ILS_marker = txt_add("","-fx-font-family:Arial; -fx-font-size:16px; -fx-fill: black; -fx-text-alignment:center; -fx-font-weight:bold;",672,126,16,16)

	local grp_ILS_O = group_add(img_ILS_marker_black,img_ILS_marker_white,img_ILS_marker_cyan)
	local grp_ILS_M = group_add(img_ILS_marker_black,img_ILS_marker_white,img_ILS_marker_yellow)
	local grp_ILS_I = group_add(img_ILS_marker_black,img_ILS_marker_white)
	visible(grp_ILS_O, false)
	visible(grp_ILS_M, false)
	visible(grp_ILS_I, false)
						  
	local function new_ILS_annunciator(O,M,I)
		if O == 1 then
			txt_set(txt_ILS_marker, "O")
			visible(txt_ILS_marker,true)
		elseif M == 1 then
			txt_set(txt_ILS_marker, "M")
			visible(txt_ILS_marker,true)
		elseif I == 1 then
			txt_set(txt_ILS_marker, "I")
			visible(txt_ILS_marker,true)
		else 
			visible(txt_ILS_marker,false)
		end
		visible(grp_ILS_O, O==1 )
		visible(grp_ILS_M, M==1 )
		visible(grp_ILS_I, I==1 )
	end

	xpl_dataref_subscribe("sim/cockpit2/radios/indicators/outer_marker_lit", "INT",
						  "sim/cockpit2/radios/indicators/middle_marker_lit", "INT",
						  "sim/cockpit2/radios/indicators/inner_marker_lit", "INT",
						  new_ILS_annunciator)

end
