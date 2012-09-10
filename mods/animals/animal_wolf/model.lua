function x(val) 
 return ((val -80) / 160)
end

function z(val) 
 return ((val -80) / 160)
end

function y(val)
	return ((val + 80) / 160)
end

local textures_wolf = {"animal_wolf_bottom.png", 
				   		"animal_wolf_top.png",
				   		"animal_wolf_front.png",
				   		"animal_wolf_back.png",
				   		"animal_wolf_left.png",
				   		"animal_wolf_right.png"}
				   		
local textures_tamed_wolf = {"animal_tamed_wolf_bottom.png", 
				   		"animal_tamed_wolf_top.png",
				   		"animal_tamed_wolf_front.png",
				   		"animal_tamed_wolf_back.png",
				   		"animal_tamed_wolf_left.png",
				   		"animal_tamed_wolf_right.png"}

local nodebox_wolf = {
				--nose
				{ x(150),y(-50),z(90),x(160),y(-60),z(70)},
				
				--snut
				{ x(130),y(-50),z(90),x(150),y(-70),z(70)},
				
				--head
				{ x(110),y(-40),z(95),x(130),y(-70),z(65)},
				
				--neck
				{ x(100),y(-50),z(95),x(110),y(-80),z(65)},
				
				--body
				{ x(20),y(-50),z(100),x(100),y(-90),z(60)},
				
				--back
				{ x(10),y(-50),z(95),x(20),y(-80),z(65)},
				
				--tail
				{ x(0),y(-60),z(85),x(10),y(-100),z(75)},
				
				--legs
				--vr
				{ x(90),y(-90),z(95),x(100),y(-130),z(85)},
				--vl
				{ x(90),y(-90),z(75),x(100),y(-130),z(65)},
				--hr
				{ x(20),y(-90),z(95),x(30),y(-130),z(85)},
				--hl
				{ x(20),y(-90),z(75),x(30),y(-130),z(65)},
			}

minetest.register_node("animal_wolf:box_wolf", {
	tiles = textures_wolf,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = nodebox_wolf
		},
		})
		
minetest.register_node("animal_wolf:box_tamed_wolf", {
	tiles = textures_tamed_wolf,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = nodebox_wolf
		},
		})