minetest.register_craft( {
	output = 'tablemod:table 2',
	recipe = {
		{ 'default:wood','default:wood', 'default:wood' },
		{ 'default:stick', '', 'default:stick' },
	},
})
minetest.register_craft( {
	output = 'tablemod:chair 4',
	recipe = {
		{ 'default:stick',''},
		{ 'default:wood','default:wood' },
		{ 'default:stick','default:stick' },
	},
})
minetest.register_craft( {
	output = 'tablemod:hardwood_table 2',
	recipe = {
		{ 'building_blocks:hardwood ','building_blocks:hardwood ', 'building_blocks:hardwood ' },
		{ 'default:stick', '', 'default:stick' },
	},
})
minetest.register_craft( {
	output = 'tablemod:hardwood_chair 4',
	recipe = {
		{ 'default:stick',''},
		{ 'building_blocks:hardwood ','building_blocks:hardwood ' },
		{ 'default:stick','default:stick' },
	},
})
minetest.register_node("tablemod:table", {
	description = 'Table',
	tiles = {
		"tablemod_wood.png",
		"tablemod_wood.png",
		"tablemod_wood_s1.png",
		"tablemod_wood_s1.png",
		"tablemod_wood_s2.png",
		"tablemod_wood_s2.png",
	},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
		node_box = {
		type = "fixed",
		fixed = {
			{-0.4,-0.5,-0.4, -0.3,0.4,-0.3},
			{0.3,-0.5,-0.4, 0.4,0.4,-0.3},
			{-0.4,-0.5,0.3, -0.3,0.4,0.4},
			{0.3,-0.5,0.3, 0.4,0.4,0.4},
			{-0.5,0.4,-0.5, 0.5,0.5,0.5},
			{-0.4,-0.2,-0.3, -0.3,-0.1,0.3},
			{0.3,-0.2,-0.4, 0.4,-0.1,0.3},
			{-0.3,-0.2,-0.4, 0.4,-0.1,-0.3},
			{-0.3,-0.2,0.3, 0.3,-0.1,0.4},
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2}
})
minetest.register_node("tablemod:chair", {
	description = 'Chair',
	tiles = {
		"tablemod_wood.png",
		"tablemod_wood.png",
		"tablemod_wood_s1.png",
		"tablemod_wood_s1.png",
		"tablemod_wood_s2.png",
		"tablemod_wood_s2.png",
	},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
		node_box = {
		type = "fixed",
		fixed = {
			{-0.3,-0.5,0.2, -0.2,0.5,0.3},
			{0.2,-0.5,0.2, 0.3,0.5,0.3},
			{-0.3,-0.5,-0.3, -0.2,-0.1,-0.2},
			{0.2,-0.5,-0.3, 0.3,-0.1,-0.2},
			{-0.3,-0.1,-0.3, 0.3,0,0.2},
			{-0.2,0.1,0.25, 0.2,0.4,0.26}
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2}
})
minetest.register_node("tablemod:hardwood_table", {
	description = 'Table',
	tiles = {
		"tablemod_hardwood.png",
		"tablemod_hardwood.png",
		"tablemod_hardwood_s1.png",
		"tablemod_hardwood_s1.png",
		"tablemod_hardwood_s2.png",
		"tablemod_hardwood_s2.png",
	},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
		node_box = {
		type = "fixed",
		fixed = {
			{-0.4,-0.5,-0.4, -0.3,0.4,-0.3},
			{0.3,-0.5,-0.4, 0.4,0.4,-0.3},
			{-0.4,-0.5,0.3, -0.3,0.4,0.4},
			{0.3,-0.5,0.3, 0.4,0.4,0.4},
			{-0.5,0.4,-0.5, 0.5,0.5,0.5},
			{-0.4,-0.2,-0.3, -0.3,-0.1,0.3},
			{0.3,-0.2,-0.4, 0.4,-0.1,0.3},
			{-0.3,-0.2,-0.4, 0.4,-0.1,-0.3},
			{-0.3,-0.2,0.3, 0.3,-0.1,0.4},
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2}
})
minetest.register_node("tablemod:hardwood_chair", {
	description = 'Chair',
	tiles = {
		"tablemod_hardwood.png",
		"tablemod_hardwood.png",
		"tablemod_hardwood_s1.png",
		"tablemod_hardwood_s1.png",
		"tablemod_hardwood_s2.png",
		"tablemod_hardwood_s2.png",
	},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
		node_box = {
		type = "fixed",
		fixed = {
			{-0.3,-0.5,0.2, -0.2,0.5,0.3},
			{0.2,-0.5,0.2, 0.3,0.5,0.3},
			{-0.3,-0.5,-0.3, -0.2,-0.1,-0.2},
			{0.2,-0.5,-0.3, 0.3,-0.1,-0.2},
			{-0.3,-0.1,-0.3, 0.3,0,0.2},
			{-0.2,0.1,0.25, 0.2,0.4,0.26}
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2}
})

