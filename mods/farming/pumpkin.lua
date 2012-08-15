minetest.register_craftitem("farming:pumpkin_seed", {
	description = "Pumpkin Seed",
	inventory_image = "farming_pumpkin_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local node = minetest.env:get_node(pointed_thing.under)
		local above = minetest.env:get_node(pointed_thing.above)
		if node.name == "farming:soil" or node.name == "farming:soil_wet" then
			if above.name == "air" then
				above.name = "farming:pumpkin_1"
				minetest.env:set_node(pointed_thing.above, above)
				itemstack:take_item(1)
				return itemstack
			end
		end
	end
})

minetest.register_node("farming:pumpkin_1", {
	paramtype = "light",
	drawtype = "nodebox",
	drop = "",
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("farming:pumpkin_2", {
	paramtype = "light",
	drawtype = "nodebox",
	drop = "",
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("farming:pumpkin", {
	description = "Pumpkin",
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png"},
	stack_max = 1,
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_abm({
	nodenames = {"farming:pumpkin_1", "farming:pumpkin_2"},
	interval = 60,
	chance = 15,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.env:get_node(pos).name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y+1
		if minetest.env:get_node_light(pos) < 8 then
			return
		end
		if node.name == "farming:pumpkin_1" then
			node.name = "farming:pumpkin_2"
			minetest.env:set_node(pos, node)
		elseif node.name == "farming:pumpkin_2" then
			node.name = "farming:pumpkin"
			minetest.env:set_node(pos, node)
		end
	end
})

minetest.register_node("farming:pumpkin_face", {
	description = "Pumpkin",
	paramtype2 = "facedir",
	stack_max = 1,
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_face.png"},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:pumpkin_seed",
	recipe = {"default:sword_wood", "farming:pumpkin"},
	replacements = {
		{"default:sword_wood", "default:sword_wood"},
		{"farming:pumpkin", "farming:pumpkin_face"}
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:pumpkin_seed",
	recipe = {"default:sword_stone", "farming:pumpkin"},
	replacements = {
		{"default:sword_stone", "default:sword_stone"},
		{"farming:pumpkin", "farming:pumpkin_face"}
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:pumpkin_seed",
	recipe = {"default:sword_steel", "farming:pumpkin"},
	replacements = {
		{"default:sword_steel", "default:sword_steel"},
		{"farming:pumpkin", "farming:pumpkin_face"}
	}
})

minetest.register_node("farming:pumpkin_face_light", {
	description = "Pumpkin",
	paramtype2 = "facedir",
	stack_max = 1,
	light_source = LIGHT_MAX-2,
	tiles = {"farming_pumpkin_top.png", "farming_pumpkin_top.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_side.png", "farming_pumpkin_face_light.png"},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:pumpkin_face_light",
	recipe = {"farming:pumpkin_face", "default:torch"}
})
