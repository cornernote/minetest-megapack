function x(val) 
 return ((val -80) / 160)
end

function z(val) 
 return ((val -80) / 160)
end

function y(val)
	return ((val + 80) / 160)
end

local textures_gull = {
			"animal_gull_gull_bottom.png",
			"animal_gull_gull_top.png",
			"animal_gull_gull_front.png",
			"animal_gull_gull_back.png",
			"animal_gull_gull_left.png",
			"animal_gull_gull_right.png",
}

local nodebox_gull ={

--left wing
{x(75),y(-75),z(30),x(80),y(-77),z(25)},
{x(77),y(-75),z(35),x(85),y(-77),z(30)},
{x(80),y(-75),z(40),x(90),y(-77),z(35)},
{x(80),y(-75),z(45),x(95),y(-77),z(40)},
{x(83),y(-75),z(55),x(100),y(-77),z(45)},
{x(80),y(-75),z(60),x(97),y(-77),z(55)},
{x(80),y(-75),z(73),x(95),y(-77),z(60)},

--right wing
{x(80),y(-75),z(100),x(95),y(-77),z(87)},
{x(80),y(-75),z(105),x(97),y(-77),z(100)},
{x(83),y(-75),z(115),x(100),y(-77),z(105)},
{x(80),y(-75),z(120),x(95),y(-77),z(115)},
{x(80),y(-75),z(125),x(90),y(-77),z(120)},
{x(77),y(-75),z(130),x(85),y(-77),z(125)},
{x(75),y(-75),z(135),x(80),y(-77),z(130)},

--tail
{x(65),y(-77),z(85),x(70),y(-85),z(75)},
{x(60),y(-77),z(87),x(65),y(-81),z(73)},
{x(55),y(-78),z(90),x(60),y(-81),z(70)},
{x(50),y(-78),z(93),x(55),y(-80),z(67)},
{x(47),y(-78),z(90),x(50),y(-80),z(70)},
{x(45),y(-78),z(83),x(47),y(-80),z(77)},

--head
{x(100),y(-75),z(85),x(105),y(-85),z(75)},
{x(105),y(-75),z(83),x(110),y(-80),z(77)},

{x(110),y(-77),z(81),x(114),y(-79),z(79)},

--body
{x(70),y(-75),z(87),x(100),y(-85),z(73)},


}

minetest.register_node("animal_gull:box_gull", {
	tiles = textures_gull,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = nodebox_gull
		},
		groups = gull_groups
		})