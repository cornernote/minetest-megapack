-- grass mod

minetest.register_node("grass:grass", {
	tiles = {"grass_grass.png"},
	inventory_image = "grass_grass.png",
	visual_scale = PLANTS_VISUAL_SCALE,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -0.3, 1/2},
	},
	description = "Grass",
	drawtype = "plantlike",
	visual_scale = 1.19,
	wield_image = "grass_grass.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
	drop = {
		max_items = 3,
		items = {
			{
				items = {'wheat:wheat_seeds'},
				rarity = 10,
			},
		}
	},
	stack_max = 128,
})

minetest.register_abm({
	nodenames = { "default:dirt_with_grass" },
	interval = 16000,
	chance = 50,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local p_top = {
			x = pos.x,
			y = pos.y + 1,
			z = pos.z
		}
		local n_top = minetest.env:get_node(p_top)
		if (n_top.name == "air") then
			minetest.env:add_node(p_top, { name = "grass:grass" })
		end
	end
})
