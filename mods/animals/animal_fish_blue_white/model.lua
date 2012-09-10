function x(val) 
 return ((val -80) / 160)
end

function z(val) 
 return ((val -80) / 160)
end

function y(val)
	return ((val + 80) / 160)
end

local textures_fish_blue_white = {
			"animal_fish_blue_white_bottom.png",
			"animal_fish_blue_white_top.png",
			"animal_fish_blue_white_front.png",
			"animal_fish_blue_white_back.png",
			"animal_fish_blue_white_right.png",
			"animal_fish_blue_white_left.png",
}

local nodebox_fish_blue_white = {

	--head
	{ x(120), y(-70), z(85), x(130), y(-80), z(75)},
	{ x(110), y(-60), z(85), x(120), y(-90), z(75)},
	
	--body
	{ x(35), y(-50), z(90), x(110), y(-100), z(70)},

	--fins
	--left
	{ x(90), y(-95), z(70), x(100), y(-110),z(65)},
	{ x(85), y(-95), z(70), x(90), y(-105),z(65)},
	
	--right
	{ x(90), y(-95), z(95), x(100), y(-110),z(90)},
	{ x(85), y(-95), z(95), x(90), y(-105),z(90)},
	
	--backfin
	{ x(30), y(-55), z(85), x(35), y(-95),z(75)},
	{ x(25), y(-60), z(85), x(30), y(-90),z(75)},
	{ x(15), y(-55), z(85), x(25), y(-95),z(75)},
	{ x(10), y(-50), z(85), x(15), y(-100),z(75)},
	{ x(0), y(-50), z(85), x(10), y(-65),z(75)},
	{ x(0), y(-85), z(85), x(10), y(-100),z(75)},
}


minetest.register_node("animal_fish_blue_white:box_fish_blue_white", {
	tiles = textures_fish_blue_white,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = nodebox_fish_blue_white
		},
		})