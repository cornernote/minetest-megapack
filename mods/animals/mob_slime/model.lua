local textures_slime_L = {"mob_slime_L.png"}
local textures_slime_M = {"mob_slime_L.png"}
local textures_slime_S = {"mob_slime_L.png"}

local nodebox_slime_L = {
				{-0.5,-0.4,-0.5, 0.5,0.4,0.5}
			}
			
local nodebox_slime_M = {
				{-0.3,-0.2,-0.3, 0.3,0.2,0.3}
			}
			
local nodebox_slime_S = {
				{-0.15,-0.1,-0.15,0.15,0.1,0.15}
			}

minetest.register_node("mob_slime:box_slime_L", {
	tiles = textures_slime_L,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = nodebox_slime_L
		},
		})
		
minetest.register_node("mob_slime:box_slime_M", {
	tiles = textures_slime_L,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = nodebox_slime_M
		},
		})
		
minetest.register_node("mob_slime:box_slime_S", {
	tiles = textures_slime_L,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = nodebox_slime_S
		},
		})