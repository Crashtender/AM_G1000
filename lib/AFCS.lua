-- AFCS
function init_AFCS_annun_lib()
  
	img_AFCS_annun_border = img_add("color_black.png", 250, 72, 49, 22)
	img_AFCS_annun_bg = img_add("color_red.png", 252, 74, 45, 18)
	txt_AFCS_annun = txt_add("AFCS", font_annunciator_black, 255, 75, 45, 18)
	grp_AFCS_annun = group_add(img_AFCS_annun_border,img_AFCS_annun_bg,txt_AFCS_annun)
	visible(grp_AFCS_annun, false)
  
  function AFCS_visibility(condition)
	visible(grp_AFCS_annun, condition)
  end
  
  -- xpl_dataref_subscribe("", "", AFCS_visibility)
  
end