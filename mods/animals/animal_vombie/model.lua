function x(val) 
 return ((val -80) / 160)
end

function z(val) 
 return ((val -80) / 160)
end

function y(val)
	return ((val + 80) / 160)
end

local textures_vombie = {
			"animal_vombie_vombie_bottom.png",
			"animal_vombie_vombie_top.png",
			"animal_vombie_vombie_back.png",
			"animal_vombie_vombie_front.png",
			"animal_vombie_vombie_right.png",
			"animal_vombie_vombie_left.png",
}

local nodebox_vombie ={
	--head
	{x(95),y(-10), z(65), x(65), y(-40), z(95)},
	
	--neck
	{x(90),y(-40),z(70) , x(70), y(-50),z(90) },
	
	--body
	{x(90),y(-50), z(60), x(70), y(-100), z(100)},

	--legs
	{x(90),y(-100), z(60),x(70), y(-160),z(79) },
	{x(90),y(-100), z(81),x(70), y(-160), z(100)},
	
	--shoulders
	{x(89),y(-50), z(58), x(71),y(-68),z(60)},
	{x(89),y(-50), z(100),x(71) ,y(-68),z(102)},
	
	--left arm
	{x(139),y(-50),z(45),x(71),y(-63),z(58)},
	
	--right arm
	{x(89),y(-50),z(102),x(71),y(-100),z(115)},
	{x(115),y(-87),z(102),x(71),y(-100),z(115)},
	
}

minetest.register_node("animal_vombie:box_vombie", {
	tiles = textures_vombie,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = nodebox_vombie
		},
		groups = vombie_groups
		})