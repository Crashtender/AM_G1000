-- Terrain

function init_terrain_lib()

-- TRAFFIC ANNUNCIATOR
	img_terrain_annun_border = img_add("color_black.png", 600, 70, 104, 24)
	img_terrain_annun_bg = img_add("color_yellow.png", 602, 72, 100, 20)
	txt_terrain_annun = txt_add("TERRAIN", font, 605, 75, 90, 18)
	grp_terrain_annun = group_add(img_terrain_annun_border,img_terrain_annun_bg,txt_terrain_annun)
	visible(grp_terrain_annun, true)

	function terrain_annun_visibility(condition)
		visible(grp_terrain_annun, condition)
	end
	xpl_dataref_subscribe("sim/cockpit2/annunciators/GPWS", "INT", terrain_annun_visibility)

end