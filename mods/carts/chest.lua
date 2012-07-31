minetest.register_node("carts:chest", {
	description = "Box",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"default_wood.png"},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	node_box = {
		type = "fixed",
		fixed = {
					-- outsides
					{-0.5, -0.5, -0.5, -0.5, 0.5, 0.5},
					{-0.5, -0.5, -0.5, 0.5, 0.5, -0.5},
					{0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
					{0.5, 0.5, 0.5, -0.5, -0.5, 0.5},
					
					-- insides
					{-0.4, -0.5, -0.4, -0.4, 0.5, 0.4},
					{-0.4, -0.5, -0.4, 0.4, 0.5, -0.4},
					{0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
					{0.4, 0.5, 0.4, -0.4, -0.5, 0.4},
					
					-- upper margin
					{-0.5, 0.5, -0.5, 0.4, 0.5, -0.4},
					{0.5, 0.5, -0.5, 0.4, 0.5, 0.4},
					{0.5, 0.5, 0.5, -0.4, 0.5, 0.4},
					{-0.5, 0.5, 0.5, -0.4, 0.5, -0.4},
					
					-- base
					{-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
					{-0.5, -0.4, -0.5, 0.5, -0.4, 0.5},
				}
	},
})

minetest.register_node("carts:pickup_plate", {
	description = "Pickup plate",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"default_wood.png"},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	node_box = {
		type = "fixed",
		fixed = {
					-- outsides
					{-0.5, -0.5, -0.5, -0.5, -0.4, 0.5},
					{-0.5, -0.5, -0.5, 0.5, -0.4, -0.5},
					{0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
					{0.5, -0.4, 0.5, -0.5, -0.5, 0.5},
					
					-- base
					{-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
					{-0.5, -0.4, -0.5, 0.5, -0.4, 0.5},
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
					{-0.5, -0.4, -0.5, 0.5, -0.4, 0.5},
				}
	},
})

minetest.register_craft({
	output = '"carts:chest" 1',
	recipe = {
		{'default:wood', '', 'default:wood'},
		{'default:wood', 'default:wood', 'default:wood'}
	}
})

minetest.register_craft({
	output = '"carts:pickup_plate" 1',
	recipe = {
		{'default:wood', 'default:wood', 'default:wood'},
		{'default:wood', '', 'default:wood'}
	}
})
