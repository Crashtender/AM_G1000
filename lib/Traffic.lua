-- Traffic

function init_traffic_lib()
  
	-- TRAFFIC ANNUNCIATOR
	img_traffic_annun_border = img_add("traffic_non_threat.png", 250, 95, 69, 22)
	img_traffic_annun_bg = img_add("color_yellow.png", 252, 97, 65, 18)
	txt_traffic_annun = txt_add("TRAFFIC", font_annunciator_black, 254, 98, 65, 18)
	grp_traffic_annun = group_add(img_traffic_annun_border,img_traffic_annun_bg,txt_traffic_annun)
	visible(grp_traffic_annun, false)
	
	-- multiplayer location array
	local TIS_scale = 200 

	function set_TIS_scale(value)
		TIS_scale = value or 200
	end

	local mpap = {} -- MultiPlayer AirPlanes

	for i = 1, 19 do
		mpap[i]={}
		mpap[i]["x"] = 0
		mpap[i]["y"] = 0
		mpap[i]["z"] = 0
		mpap[i]["hdg"] = 0
	end

	local own_x, own_y,own_z,own_hdg

	local img_plane_1 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_2 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_3 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_4 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_5 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_6 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_7 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_8 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_9 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_10 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_11 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_12 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_13 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_14 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_15 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_16 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_17 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_18 = img_add("traffic_non_threat.png", 0, 0, 5, 5)
	local img_plane_19 = img_add("traffic_non_threat.png", 0, 0, 5, 5)

	font = "-fx-font-family:Arial; -fx-font-size:10px; -fx-fill: black; -fx-text-alignment:left;" 

	local alt_plane_1 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_2 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_3 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_4 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_5 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_6 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_7 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_8 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_9 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_10 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_11 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_12 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_13 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_14 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_15 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_16 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_17 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_18 = txt_add("", font, 0, 0, 50, 15)
	local alt_plane_19 = txt_add("", font, 0, 0, 50, 15)

	grp_plane_icons = group_add(img_plane_1,img_plane_2,img_plane_3,img_plane_4,img_plane_5,
								img_plane_6,img_plane_7,img_plane_8,img_plane_9,img_plane_10,
								img_plane_11,img_plane_12,img_plane_13,img_plane_14,img_plane_15,
								img_plane_16,img_plane_17,img_plane_18,img_plane_19,img_plane_20,
								alt_plane_1,alt_plane_2,alt_plane_3,alt_plane_4,alt_plane_5,
								alt_plane_6,alt_plane_7,alt_plane_8,alt_plane_9,alt_plane_10,
								alt_plane_11,alt_plane_12,alt_plane_13,alt_plane_14,alt_plane_15,
								alt_plane_16,alt_plane_17,alt_plane_18,alt_plane_19)
	visible(grp_plane_icons, true)
  
	function traffic_annun_visibility(condition)
		visible(grp_traffic_annun, condition)
	end

	
	-- Create array for the multiplayer airplanes
	function new_TIS_data(	self_x,self_y,self_z,self_hdg,
								x1,y1,z1,hdg1,x2,y2,z2,hdg2,x3,y3,z3,hdg3,x4,y4,z4,hdg4,x5,y5,z5,hdg5,
								x6,y6,z6,hdg6,x7,y7,z7,hdg7,x8,y8,z8,hdg8,x9,y9,z9,hdg9,x10,y10,z10,hdg10,
								x11,y11,z11,hdg11,x12,y12,z12,hdg12,x13,y13,z13,hdg13,x14,y14,z14,hdg14,x15,y15,z15,hdg15,
								x16,y16,z16,hdg16,x17,y17,z17,hdg17,x18,y18,z18,hdg18,x19,y19,z19,hdg19)
		
		own_x, own_y,own_z,own_hdg = self_x,self_y,self_z,self_hdg
		-- Fill array with multiplayer plane data
		mpap[1]["x"], mpap[1]["y"], mpap[1]["z"], mpap[1]["hdg"] = x1,y1,z1,hdg1
		mpap[2]["x"], mpap[2]["y"], mpap[2]["z"], mpap[2]["hdg"] = x2,y2,z2,hdg2
		mpap[3]["x"], mpap[3]["y"], mpap[3]["z"], mpap[3]["hdg"] = x3,y3,z3,hdg3
		mpap[4]["x"], mpap[4]["y"], mpap[4]["z"], mpap[4]["hdg"] = x4,y4,z4,hdg4
		mpap[5]["x"], mpap[5]["y"], mpap[5]["z"], mpap[5]["hdg"] = x5,y5,z5,hdg5
		mpap[6]["x"], mpap[6]["y"], mpap[6]["z"], mpap[6]["hdg"] = x6,y6,z6,hdg6
		mpap[7]["x"], mpap[7]["y"], mpap[7]["z"], mpap[7]["hdg"] = x7,y7,z7,hdg7
		mpap[8]["x"], mpap[8]["y"], mpap[8]["z"], mpap[8]["hdg"] = x8,y8,z8,hdg8
		mpap[9]["x"], mpap[9]["y"], mpap[9]["z"], mpap[9]["hdg"] = x9,y9,z9,hdg9
		mpap[10]["x"], mpap[10]["y"], mpap[10]["z"], mpap[10]["hdg"] = x10,y10,z10,hdg10
		mpap[11]["x"], mpap[11]["y"], mpap[11]["z"], mpap[11]["hdg"] = x11,y11,z11,hdg11
		mpap[12]["x"], mpap[12]["y"], mpap[12]["z"], mpap[12]["hdg"] = x12,y12,z12,hdg12
		mpap[13]["x"], mpap[13]["y"], mpap[13]["z"], mpap[13]["hdg"] = x13,y13,z13,hdg13
		mpap[14]["x"], mpap[14]["y"], mpap[14]["z"], mpap[14]["hdg"] = x14,y14,z14,hdg14
		mpap[15]["x"], mpap[15]["y"], mpap[15]["z"], mpap[15]["hdg"] = x15,y15,z15,hdg15
		mpap[16]["x"], mpap[16]["y"], mpap[16]["z"], mpap[16]["hdg"] = x16,y16,z16,hdg16
		mpap[17]["x"], mpap[17]["y"], mpap[17]["z"], mpap[17]["hdg"] = x17,y17,z17,hdg17
		mpap[18]["x"], mpap[18]["y"], mpap[18]["z"], mpap[18]["hdg"] = x18,y18,z18,hdg18
		mpap[19]["x"], mpap[19]["y"], mpap[19]["z"], mpap[19]["hdg"] = x19,y19,z19,hdg19
		
		if x1 ~= 0 and y1 ~=0 and  math.abs( z1 - self_z ) < 3500 then 
			visible(img_plane_1, true)
			visible(img_plane_1, true)
		else
			visible(img_plane_1, false)
			visible(img_plane_1, false)
		end
		
		if x2 ~= 0 and y2 ~=0 and  math.abs( z2 - self_z ) < 3500 then 
			visible(img_plane_2, true)
			visible(img_plane_2, true)
		else
			visible(img_plane_2, false)
			visible(img_plane_2, false)
		end
		
		
		if x3 ~= 0 and y3 ~=0 and  math.abs( z3 - self_z ) < 3500 then 
			visible(img_plane_3, true)
			visible(img_plane_3, true)
		else
			visible(img_plane_3, false)
			visible(img_plane_3, false)
		end
		
		
		if x4 ~= 0 and y4 ~=0 and  math.abs( z4 - self_z ) < 3500 then 
			visible(img_plane_4, true)
			visible(img_plane_4, true)
		else
			visible(img_plane_4, false)
			visible(img_plane_4, false)
		end
		
		
		if x5 ~= 0 and y5 ~=0 and  math.abs( z5 - self_z ) < 3500 then 
			visible(img_plane_5, true)
			visible(img_plane_5, true)
		else
			visible(img_plane_5, false)
			visible(img_plane_5, false)
		end
		
		
		if x6 ~= 0 and y6 ~=0 and  math.abs( z6 - self_z ) < 3500 then 
			visible(img_plane_6, true)
			visible(img_plane_6, true)
		else
			visible(img_plane_6, false)
			visible(img_plane_6, false)
		end
		
		
		if x7 ~= 0 and y7 ~=0 and  math.abs( z7 - self_z ) < 3500 then 
			visible(img_plane_7, true)
			visible(img_plane_7, true)
		else
			visible(img_plane_7, false)
			visible(img_plane_7, false)
		end
		
		
		if x8 ~= 0 and y8 ~=0 and  math.abs( z8 - self_z ) < 3500 then 
			visible(img_plane_8, true)
			visible(img_plane_8, true)
		else
			visible(img_plane_8, false)
			visible(img_plane_8, false)
		end
		
		
		if x9 ~= 0 and y9 ~=0 and  math.abs( z9 - self_z ) < 3500 then 
			visible(img_plane_9, true)
			visible(img_plane_9, true)
		else
			visible(img_plane_9, false)
			visible(img_plane_9, false)
		end
		
		
		if x10 ~= 0 and y10 ~=0 and  math.abs( z10 - self_z ) < 3500 then 
			visible(img_plane_10, true)
			visible(img_plane_10, true)
		else
			visible(img_plane_10, false)
			visible(img_plane_10, false)
		end
		
		
		if x11 ~= 0 and y11 ~=0 and  math.abs( z11 - self_z ) < 3500 then 
			visible(img_plane_11, true)
			visible(img_plane_11, true)
		else
			visible(img_plane_11, false)
			visible(img_plane_11, false)
		end
		
		
		if x12 ~= 0 and y12 ~=0 and  math.abs( z12 - self_z ) < 3500 then 
			visible(img_plane_12, true)
			visible(img_plane_12, true)
		else
			visible(img_plane_12, false)
			visible(img_plane_12, false)
		end
		
		
		if x13 ~= 0 and y13 ~=0 and  math.abs( z13 - self_z ) < 3500 then 
			visible(img_plane_13, true)
			visible(img_plane_13, true)
		else
			visible(img_plane_13, false)
			visible(img_plane_13, false)
		end
		
		
		if x14 ~= 0 and y14 ~=0 and  math.abs( z14 - self_z ) < 3500 then 
			visible(img_plane_14, true)
			visible(img_plane_14, true)
		else
			visible(img_plane_14, false)
			visible(img_plane_14, false)
		end
		
		
		if x15 ~= 0 and y15 ~=0 and  math.abs( z15 - self_z ) < 3500 then 
			visible(img_plane_15, true)
			visible(img_plane_15, true)
		else
			visible(img_plane_15, false)
			visible(img_plane_15, false)
		end
		
		
		if x16 ~= 0 and y16 ~=0 and  math.abs( z16 - self_z ) < 3500 then 
			visible(img_plane_16, true)
			visible(img_plane_16, true)
		else
			visible(img_plane_16, false)
			visible(img_plane_16, false)
		end
		
		
		if x17 ~= 0 and y17 ~=0 and  math.abs( z17 - self_z ) < 3500 then 
			visible(img_plane_17, true)
			visible(img_plane_17, true)
		else
			visible(img_plane_17, false)
			visible(img_plane_17, false)
		end
		
		
		if x18 ~= 0 and y18 ~=0 and   math.abs( z18 - self_z ) < 3500 then 
			visible(img_plane_18, true)
			visible(img_plane_18, true)
		else
			visible(img_plane_18, false)
			visible(img_plane_18, false)
		end
		
		
		if x19 ~= 0 and y19 ~=0 and   math.abs( z19 - self_z ) < 3500 then 
			visible(img_plane_19, true)
			visible(img_plane_19, true)
		else
			visible(img_plane_19, false)
			visible(img_plane_19, false)
		end
		
	end
	xpl_dataref_subscribe(	"sim/flightmodel/position/local_x", "DOUBLE",
							"sim/flightmodel/position/local_y", "DOUBLE",
							"sim/flightmodel/position/local_z", "DOUBLE",
							"sim/flightmodel/position/mag_psi", "FLOAT",
							"sim/multiplayer/position/plane1_x", "DOUBLE",
							"sim/multiplayer/position/plane1_y", "DOUBLE",
							"sim/multiplayer/position/plane1_z", "DOUBLE",
							"sim/multiplayer/position/plane1_psi", "FLOAT",
							"sim/multiplayer/position/plane2_x", "DOUBLE",
							"sim/multiplayer/position/plane2_y", "DOUBLE",
							"sim/multiplayer/position/plane2_z", "DOUBLE",
							"sim/multiplayer/position/plane2_psi", "FLOAT",
							"sim/multiplayer/position/plane3_x", "DOUBLE",
							"sim/multiplayer/position/plane3_y", "DOUBLE",
							"sim/multiplayer/position/plane3_z", "DOUBLE",
							"sim/multiplayer/position/plane3_psi", "FLOAT",
							"sim/multiplayer/position/plane4_x", "DOUBLE",
							"sim/multiplayer/position/plane4_y", "DOUBLE",
							"sim/multiplayer/position/plane4_z", "DOUBLE",
							"sim/multiplayer/position/plane4_psi", "FLOAT",
							"sim/multiplayer/position/plane5_x", "DOUBLE",
							"sim/multiplayer/position/plane5_y", "DOUBLE",
							"sim/multiplayer/position/plane5_z", "DOUBLE",
							"sim/multiplayer/position/plane5_psi", "FLOAT",
							"sim/multiplayer/position/plane6_x", "DOUBLE",
							"sim/multiplayer/position/plane6_y", "DOUBLE",
							"sim/multiplayer/position/plane6_z", "DOUBLE",
							"sim/multiplayer/position/plane6_psi", "FLOAT",
							"sim/multiplayer/position/plane7_x", "DOUBLE",
							"sim/multiplayer/position/plane7_y", "DOUBLE",
							"sim/multiplayer/position/plane7_z", "DOUBLE",
							"sim/multiplayer/position/plane7_psi", "FLOAT",
							"sim/multiplayer/position/plane8_x", "DOUBLE",
							"sim/multiplayer/position/plane8_y", "DOUBLE",
							"sim/multiplayer/position/plane8_z", "DOUBLE",
							"sim/multiplayer/position/plane8_psi", "FLOAT",
							"sim/multiplayer/position/plane9_x", "DOUBLE",
							"sim/multiplayer/position/plane9_y", "DOUBLE",
							"sim/multiplayer/position/plane9_z", "DOUBLE",
							"sim/multiplayer/position/plane9_psi", "FLOAT",
							"sim/multiplayer/position/plane10_x", "DOUBLE",
							"sim/multiplayer/position/plane10_y", "DOUBLE",
							"sim/multiplayer/position/plane10_z", "DOUBLE",
							"sim/multiplayer/position/plane10_psi", "FLOAT",
							"sim/multiplayer/position/plane11_x", "DOUBLE",
							"sim/multiplayer/position/plane11_y", "DOUBLE",
							"sim/multiplayer/position/plane11_z", "DOUBLE",
							"sim/multiplayer/position/plane11_psi", "FLOAT",
							"sim/multiplayer/position/plane12_x", "DOUBLE",
							"sim/multiplayer/position/plane12_y", "DOUBLE",
							"sim/multiplayer/position/plane12_z", "DOUBLE",
							"sim/multiplayer/position/plane12_psi", "FLOAT",
							"sim/multiplayer/position/plane13_x", "DOUBLE",
							"sim/multiplayer/position/plane13_y", "DOUBLE",
							"sim/multiplayer/position/plane13_z", "DOUBLE",
							"sim/multiplayer/position/plane13_psi", "FLOAT",
							"sim/multiplayer/position/plane14_x", "DOUBLE",
							"sim/multiplayer/position/plane14_y", "DOUBLE",
							"sim/multiplayer/position/plane14_z", "DOUBLE",
							"sim/multiplayer/position/plane14_psi", "FLOAT",
							"sim/multiplayer/position/plane15_x", "DOUBLE",
							"sim/multiplayer/position/plane15_y", "DOUBLE",
							"sim/multiplayer/position/plane15_z", "DOUBLE",
							"sim/multiplayer/position/plane15_psi", "FLOAT",
							"sim/multiplayer/position/plane16_x", "DOUBLE",
							"sim/multiplayer/position/plane16_y", "DOUBLE",
							"sim/multiplayer/position/plane16_z", "DOUBLE",
							"sim/multiplayer/position/plane16_psi", "FLOAT",
							"sim/multiplayer/position/plane17_x", "DOUBLE",
							"sim/multiplayer/position/plane17_y", "DOUBLE",
							"sim/multiplayer/position/plane17_z", "DOUBLE",
							"sim/multiplayer/position/plane17_psi", "FLOAT",
							"sim/multiplayer/position/plane18_x", "DOUBLE",
							"sim/multiplayer/position/plane18_y", "DOUBLE",
							"sim/multiplayer/position/plane18_z", "DOUBLE",
							"sim/multiplayer/position/plane18_psi", "FLOAT",
							"sim/multiplayer/position/plane19_x", "DOUBLE",
							"sim/multiplayer/position/plane19_y", "DOUBLE",
							"sim/multiplayer/position/plane19_z", "DOUBLE",
							"sim/multiplayer/position/plane19_psi", "FLOAT",
							new_TIS_data)


	function plot_TIS(x, y, w, h)
		local delta = 15
		-- Traffic Information Service is updated every 5 seconds
		-- move(img_plane_1, (( x + w/2 + (mpap[1]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[1]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_1, ( x + w/2 + (mpap[1]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[1]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_1, var_round((mpap[1]["y"] - own_y), 0))
	
	
		-- move(img_plane_2, (( x + w/2 + (mpap[2]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[2]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_2, (( x + w/2 + (mpap[2]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[2]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_2, var_round((mpap[2]["y"] - own_y), 0))
		
		-- move(img_plane_3, (( x + w/2 + (mpap[3]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[3]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_3, ( x + w/2 + (mpap[3]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[3]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_3, var_round((mpap[3]["y"] - own_y), 0))
		
		-- move(img_plane_4, (( x + w/2 + (mpap[4]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[4]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_4, ( x + w/2 + (mpap[4]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[4]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_4, var_round((mpap[4]["y"] - own_y), 0))
		
		-- move(img_plane_5, (( x + w/2 + (mpap[5]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[5]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_5, ( x + w/2 + (mpap[5]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[5]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_5, var_round((mpap[5]["y"] - own_y), 0))
		
		-- move(img_plane_6, (( x + w/2 + (mpap[6]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[6]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_6, ( x + w/2 + (mpap[6]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[6]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_6, var_round((mpap[6]["y"] - own_y), 0))
		
		-- move(img_plane_7, (( x + w/2 + (mpap[7]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[7]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_7, ( x + w/2 + (mpap[7]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[7]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_7, var_round((mpap[7]["y"] - own_y), 0))
		
		-- move(img_plane_8, (( x + w/2 + (mpap[8]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[8]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_8, ( x + w/2 + (mpap[8]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[8]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_8, var_round((mpap[8]["y"] - own_y), 0))
		
		-- move(img_plane_9, (( x + w/2 + (mpap[9]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[9]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_9, ( x + w/2 + (mpap[9]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[9]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_9, var_round((mpap[9]["y"] - own_y), 0))
		
		-- move(img_plane_10, (( x + w/2 + (mpap[10]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[10]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_10, ( x + w/2 + (mpap[10]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[10]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_10, var_round((mpap[10]["y"] - own_y), 0))
		
		-- move(img_plane_11, (( x + w/2 + (mpap[11]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[11]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_11, ( x + w/2 + (mpap[11]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[11]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_11, var_round((mpap[11]["y"] - own_y), 0))
		
		-- move(img_plane_12, (( x + w/2 + (mpap[12]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[12]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_12, ( x + w/2 + (mpap[12]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[12]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_12, var_round((mpap[12]["y"] - own_y), 0))
		
		-- move(img_plane_13, (( x + w/2 + (mpap[13]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[13]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_13, ( x + w/2 + (mpap[13]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[13]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_13, var_round((mpap[13]["y"] - own_y), 0))
		
		-- move(img_plane_14, (( x + w/2 + (mpap[14]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[14]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_14, ( x + w/2 + (mpap[14]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[14]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_14, var_round((mpap[14]["y"] - own_y), 0))
		
		-- move(img_plane_15, (( x + w/2 + (mpap[15]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[15]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_15, ( x + w/2 + (mpap[15]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[15]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_15, var_round((mpap[15]["y"] - own_y), 0))
		
		-- move(img_plane_16, (( x + w/2 + (mpap[16]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[16]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_16, ( x + w/2 + (mpap[16]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[16]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_16, var_round((mpap[16]["y"] - own_y), 0))
		
		-- move(img_plane_17, (( x + w/2 + (mpap[17]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[17]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_17, ( x + w/2 + (mpap[17]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[17]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_17, var_round((mpap[17]["y"] - own_y), 0))
		
		-- move(img_plane_18, (( x + w/2 + (mpap[18]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[18]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_18, ( x + w/2 + (mpap[18]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[18]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_18, var_round((mpap[18]["y"] - own_y), 0))
		
		-- move(img_plane_19, (( x + w/2 + (mpap[19]["x"] - own_x)/TIS_scale) - 15 ), (( y + h/2 + (mpap[19]["z"] - own_z)/TIS_scale) - 15 ), nil, nil)
		-- move(alt_plane_19, ( x + w/2 + (mpap[19]["x"] - own_x)/TIS_scale) + delta, ( y + h/2 + (mpap[19]["z"] - own_z)/TIS_scale) + delta, nil, nil)
		-- txt_set(alt_plane_19, var_round((mpap[19]["y"] - own_y), 0))
	end
	
	local tis_update_timer
	
	function show_TIS(condition)
		if condition == true then
			tis_update_timer = timer_start(5000, 5000, plot_TIS(1,1,500,500) )
		elseif condition == false then 
			timer_stop ( tis_update_timer )
		end
	end
	
end

