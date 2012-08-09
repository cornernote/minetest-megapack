local textures_wool = {"animals_sheep_wool.png", 
				   "animals_sheep_wool.png",
				   "animals_sheep_front.png",
				   "animals_sheep_wool.png",
				   "animals_sheep_wool.png",
				   "animals_sheep_wool.png"}
				   
local textures_naked = {"animals_sheep_no_wool.png", 
				   "animals_sheep_no_wool.png",
				   "animals_sheep_no_wool_front.png",
				   "animals_sheep_no_wool.png",
				   "animals_sheep_no_wool.png",
				   "animals_sheep_no_wool.png"}

local nodebox_sheep = {
				-- legs
				{-0.25, -0.25-0.25, -0.2, -0.15, 0.125-0.25, -0.1},
				{0.15, 0.125-0.25, -0.1, 0.25, -0.25-0.25, -0.2},
				{-0.15, 0.125-0.25, 0.1, -0.25, -0.25-0.25, 0.2},
				{0.25, -0.25-0.25, 0.2, 0.15, 0.125-0.25, 0.1},
				
				-- body
				{-0.25, 0.125-0.25, -0.2, 0.25, 0.35-0.25, 0.2},
				
				-- head
				{0.25, 0.275-0.25, -0.1, 0.5, 0.5-0.25, 0.1},
			}

minetest.register_node("animal_sheep:box_wool", {
	tiles = textures_wool,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = nodebox_sheep
		},
		groups = sheep_groups
		})
		
minetest.register_node("animal_sheep:box_naked", {
	tiles = textures_naked,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = nodebox_sheep
		},
		groups = sheep_groups
		})