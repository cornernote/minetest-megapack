
minetest.register_craft({
	output = 'scaffolding:scaffolding',
	recipe = {
		{'default:stick', '', 'default:stick'},
		{'', 'default:stick', ''},
		{'default:stick', '', 'default:stick'},
	}
})

minetest.register_node("scaffolding:scaffolding", {
	description = "scaffolding",
	tiles = {"scaffolding.png"},
	drawtype = "normal",
	is_ground_content = true,
	groups = {dig_immediate=3,choppy=2,flammable=3},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	type = "fuel",
	recipe = "scaffolding:scaffolding",
	burntime = 15,
})

