minetest.register_craft({
	type = "fuel",
	recipe = "ironapple:apple_iron",
	burntime = 9,
})

minetest.register_node("ironapple:apple_iron", {
	description = "Iron apple",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"apple_iron.png"},
	inventory_image = "apple_iron.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3,flammable=1},
	on_use = minetest.item_eat(8),
	sounds = default.node_sound_defaults(),
})

minetest.register_craft({
	output = 'ironapple:apple_iron',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', 'default:apple', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
	}
})