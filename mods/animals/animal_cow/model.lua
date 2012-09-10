function x(val) 
 return ((val -80) / 160)
end

function z(val) 
 return ((val -80) / 160)
end

function y(val)
	return ((val + 80) / 160)
end

local textures_cow = {
			"animals_cow_bottom.png",
			"animals_cow_top.png",
			"animals_cow_front.png",
			"animals_cow_back.png",
			"animals_cow_left.png",
			"animals_cow_right.png",
}

local nodebox_cow ={
	--snut
	{ x(140), y(-70), z(90),  x(160), y(-90), z(70) },
	--head
	{ x(120), y(-60), z(90),  x(140), y(-90), z(70) },
	--neck
	{ x(110), y(-50), z(110), x(120), y(-90), z(50) },
	
	--body
	{ x(10),  y(-50), z(110), x(110), y(-110),z(50) },
	
	--tail
	{ x(0),   y(-50), z(85),  x(10),  y(-120),z(75) },
	
	--legs
	--vl
	{ x(90), y(-110), z(110), x(100),   y(-160),   z(100) },
	{ x(80), y(-110), z(110), x(90),    y(-130),   z(100) },
	--vr
	{ x(90), y(-110), z(60),  x(100),   y(-160),   z(50) },
	{ x(80), y(-110), z(60),  x(90),    y(-130),   z(50) },
	
	--hl
	{ x(10), y(-110), z(110), x(20),    y(-160),   z(100) },
	{ x(10), y(-110), z(110), x(30),    y(-130),   z(100) },
	--hr
	{ x(10), y(-110), z(60),  x(20),    y(-160),   z(50) },
	{ x(10), y(-110), z(60),  x(30),    y(-130),   z(50) },

	
	--udder
	{ x(30), y(-110), z(90),  x(50),    y(-130),   z(70) }
}

minetest.register_node("animal_cow:box_cow", {
	tiles = textures_cow,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = nodebox_cow
		},
		groups = cow_groups
		})