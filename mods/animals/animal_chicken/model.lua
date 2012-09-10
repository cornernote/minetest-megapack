function x(val) 
 return ((val -80) / 160)
end

function z(val) 
 return ((val -80) / 160)
end

function y(val)
	return ((val + 80) / 160)
end

local textures_chicken = {
			"animal_chicken_chicken_bottom.png",
			"animal_chicken_chicken_top.png",
			"animal_chicken_chicken_front.png",
			"animal_chicken_chicken_back.png",
			"animal_chicken_chicken_left.png",
			"animal_chicken_chicken_right.png",
}

local nodebox_chicken ={

	--body
	{x(50),y(-60),z(100),x(110),y(-90),z(60)},
	
	--body lower
	{x(60),y(-90),z(90),x(100),y(-100),z(70)},
	
	--tail
	{x(40),y(-60),z(90),x(50),y(-80),z(70)},
	{x(30),y(-54),z(85),x(40),y(-70),z(75)},
	
	--neck
	{x(110),y(-45),z(88),x(120),y(-80),z(72)},
	{x(120),y(-40),z(88),x(130),y(-70),z(72)},
	
	{x(130),y(-48),z(83),x(140),y(-54),z(77)},
	
	--feet
	{x(78),y(-100),z(88),x(82),y(-110),z(85)},
	{x(75),y(-110),z(88),x(85),y(-112),z(85)},
	
	{x(78),y(-100),z(75),x(82),y(-110),z(72)},
	{x(75),y(-110),z(75),x(85),y(-112),z(72)},
	
}

minetest.register_node("animal_chicken:box_chicken", {
	tiles = textures_chicken,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = nodebox_chicken
		},
		groups = chicken_groups
		})