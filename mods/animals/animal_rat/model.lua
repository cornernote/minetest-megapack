function x(val) 
 return ((val -80) / 160)
end

function z(val) 
 return ((val -80) / 160)
end

function y(val)
	return ((val + 80) / 160)
end

local textures_rat = {
			"animal_rat_bottom.png",
			"animal_rat_top.png",
			"animal_rat_front.png",
			"animal_rat_back.png",
			"animal_rat_right.png",
			"animal_rat_left.png",
}

local nodebox_rat = {

	--head
	{x(120), y(-70), z(85), x(130), y(-80), z(75) },
	
	--body
	{x(60), y(-65), z(90), x(120), y(-80),z(70)},
	
	--tail
	{x(30), y(-77.5), z(81.25), x(60), y(-80), z(78.75)},
	
	--legs
	--vr
	{ x(110), y(-80), z(87.5), x(115), y(-90), z(85)},
	
	--vl
	{ x(110), y(-80), z(75), x(115), y(-90), z(72.5)},
	
	--hr
	{ x(65), y(-80), z(87.5), x(70), y(-90), z(85)},
	
	--hl
	{ x(65), y(-80), z(75), x(70), y(-90), z(72.5)},
}


minetest.register_node("animal_rat:box_rat", {
	tiles = textures_rat,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = nodebox_rat
		},
		})