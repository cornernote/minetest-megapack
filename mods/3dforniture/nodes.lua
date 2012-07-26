-- replacement

minetest.register_node(":default:papyrus", {
	description = "Papyrus",
	drawtype = "nodebox",
	tiles = {
		"forniture_papyrus.png",
		"forniture_papyrus.png",
		"forniture_papyrus_s1.png",
		"forniture_papyrus_s1.png",
		"forniture_papyrus_s2.png",
		"forniture_papyrus_s2.png",
	},
	inventory_image = "default_papyrus.png",
	wield_image = "default_papyrus.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
			--papyrus 1
			{-0.03-0.1,-0.5,-0.03-0.1, 0.03-0.1,0.5,0.03-0.1},
			{-0.06-0.1,-0.02-0.1,-0.06-0.1, 0.06-0.1,0.02-0.1,0.06-0.1},
			--papyrus 2
			{-0.03-0.4,-0.5,-0.03-0.3, 0.03-0.4,0.5,0.03-0.3},
			{-0.06-0.4,-0.02-0.2,-0.06-0.3, 0.06-0.4,0.02-0.2,0.06-0.3},
			--papyrus 3
			{-0.03+0.4,-0.5,-0.03-0.3, 0.03+0.4,0.5,0.03-0.3},
			{-0.06+0.4,-0.02+0.2,-0.06-0.3, 0.06+0.4,0.02+0.2,0.06-0.3},
			--papyrus 4
			{-0.03-0.4,-0.5,-0.03+0.4, 0.03-0.4,0.5,0.03+0.4},
			{-0.06-0.4,0.02+0.4,-0.06+0.4, 0.06-0.4,0.02+0.4,0.06+0.4},
			--papyrus 5
			{-0.03-0.2,-0.5,-0.03+0.2, 0.03-0.2,0.5,0.03+0.2},
			{-0.06-0.2,0.02-0.4,-0.06+0.2, 0.06-0.2,0.02-0.4,0.06+0.2},
			--papyrus 6
			{-0.03+0.1,-0.5,-0.03+0.2, 0.03+0.1,0.5,0.03+0.2},
			{-0.06+0.1,0.02+0.3,-0.06+0.2, 0.06+0.1,0.02+0.3,0.06+0.2},



		},
	},
	groups = {snappy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node(":default:tree", {
	description = "Tree",
	paramtype = "light",
	tiles = {
		"forniture_tree_top.png",
		"forniture_tree_top.png",
		"default_tree.png",
		"default_tree.png",
		"forniture_tree_s1.png",
		"forniture_tree_s1.png",
	},
	is_ground_content = true,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.35,-0.5,-0.4, 0.35,0.5,0.4},
			{-0.4,-0.5,-0.35, 0.4,0.5,0.35},
			{-0.25,-0.5,-0.45, 0.25,0.5,0.45},
			{-0.45,-0.5,-0.25, 0.45,0.5,0.25},
			{-0.15,-0.5,-0.5, 0.15,0.5,0.5},
			{-0.5,-0.5,-0.15, 0.5,0.5,0.15},

		},
	},
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})
--nodes

minetest.register_node("3dforniture:table", {
	description = 'Table',
	tiles = {
		"forniture_wood.png",
		"forniture_wood.png",
		"forniture_wood_s1.png",
		"forniture_wood_s1.png",
		"forniture_wood_s2.png",
		"forniture_wood_s2.png",
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

minetest.register_node("3dforniture:chair", {
	description = 'Chair',
	tiles = {
		"forniture_wood.png",
		"forniture_wood.png",
		"forniture_wood_s1.png",
		"forniture_wood_s1.png",
		"forniture_wood_s2.png",
		"forniture_wood_s2.png",
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
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2}
})

minetest.register_node("3dforniture:bars", {
	description = 'Bars',
	tiles = {
		"forniture_black_metal.png",
		"forniture_black_metal.png",
		"forniture_black_metal_s1.png",
		"forniture_black_metal_s1.png",
		"forniture_black_metal_s2.png",
		"forniture_black_metal_s2.png",
	},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
		node_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.1, -0.4,0.5,0.1},
			{-0.1,-0.5,-0.1, 0.1,0.5,0.1},
			{0.4,-0.5,-0.1, 0.5,0.5,0.1},
			{-0.5,-0.5,-0.05, 0.5,-0.45,0.05},
			{-0.5,0.45,-0.05, 0.5,0.5,0.05}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.1, 0.5, 0.5, 0.1},
	},
	groups = {cracky=1}
})

minetest.register_node("3dforniture:L_binding_bars", {
	description = 'Binding Bars',
	tiles = {
		"forniture_black_metal.png",
		"forniture_black_metal.png",
		"forniture_black_metal_s1.png",
		"forniture_black_metal_s1.png",
		"forniture_black_metal_s2.png",
		"forniture_black_metal_s2.png",
	},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
		node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,-0.5, 0.1,0.5,-0.4},
			{-0.15,-0.5,-0.15, 0.15,0.5,0.15},
			{0.4,-0.5,-0.1, 0.5,0.5,0.1},
			{0,-0.5,-0.05, 0.5,-0.45,0.05},
			{-0.05,-0.5,-0.5, 0.05,-0.45,0},
			{0,0.45,-0.05, 0.5,0.5,0.05},
			{-0.05,0.45,-0.5, 0.05,0.5,0},
			
		},
	},
	groups = {cracky=1,}
})

minetest.register_node("3dforniture:chains", {
	description = 'Chains',
	tiles = {
		"forniture_black_metal.png",
		"forniture_black_metal.png",
		"forniture_black_metal_s1.png",
		"forniture_black_metal_s1.png",
		"forniture_black_metal_s2.png",
		"forniture_black_metal_s2.png",
	},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
		node_box = {
		type = "fixed",
		fixed = {
			--chain a
				--supporting
			{-0.45,0.25,0.45, -0.2,0.5,0.5},
			{-0.35,0.4,0.35, -0.3,0.45,0.45},
			{-0.35,0.3,0.35, -0.3,0.35,0.45},
			{-0.35,0.35,0.3, -0.3,0.4,0.35},
				--link 1
			{-0.4,0.35,0.35, -0.25,0.4,0.4},
			{-0.4,0.15,0.35, -0.25,0.2,0.4},
			{-0.45,0.2,0.35, -0.4,0.35,0.4},
			{-0.25,0.2,0.35, -0.2,0.35,0.4},
				--link 2
			{-0.35,0.2,0.3, -0.3,0.25,0.45},
			{-0.35,0,0.3, -0.3,0.05,0.45},
			{-0.35,0.05,0.25, -0.3,0.2,0.3},
			{-0.35,0.05,0.45, -0.3,0.2,0.5},
				--link 3
			{-0.4,0.05,0.35, -0.25,0.1,0.4},
			{-0.4,-0.15,0.35, -0.25,-0.1,0.4},
			{-0.45,-0.1,0.35, -0.4,0.05,0.4},
			{-0.25,-0.1,0.35, -0.2,0.05,0.4},
				--link 4
			{-0.35,-0.1,0.3, -0.3,-0.05,0.45},
			{-0.35,-0.3,0.3, -0.3,-0.25,0.45},
			{-0.35,-0.25,0.25, -0.3,-0.1,0.3},
			{-0.35,-0.25,0.45, -0.3,-0.1,0.5},
				--link 5
			{-0.4,-0.25,0.35, -0.25,-0.2,0.4},
			{-0.4,-0.45,0.35, -0.25,-0.4,0.4},
			{-0.45,-0.4,0.35, -0.4,-0.25,0.4},
			{-0.25,-0.4,0.35, -0.2,-0.25,0.4},

			--chain b
				--supporting
			{0.2,0.25,0.45, 0.45,0.5,0.5},
			{0.3,0.4,0.35, 0.35,0.45,0.45},
			{0.3,0.3,0.35, 0.35,0.35,0.45},
			{0.3,0.35,0.3, 0.35,0.4,0.35},
				--link 1
			{0.25,0.35,0.35, 0.4,0.4,0.4},
			{0.25,0.15,0.35, 0.4,0.2,0.4},
			{0.2,0.2,0.35, 0.25,0.35,0.4},
			{0.4,0.2,0.35, 0.45,0.35,0.4},
				--link 2
			{0.3,0.2,0.3, 0.35,0.25,0.45},
			{0.3,0,0.3, 0.35,0.05,0.45},
			{0.3,0.05,0.25, 0.35,0.2,0.3},
			{0.3,0.05,0.45, 0.35,0.2,0.5},
				--link 3
			{0.25,0.05,0.35, 0.4,0.1,0.4},
			{0.25,-0.15,0.35, 0.4,-0.1,0.4},
			{0.2,-0.1,0.35, 0.25,0.05,0.4},
			{0.4,-0.1,0.35, 0.45,0.05,0.4},
				--link 4
			{0.3,-0.1,0.3, 0.35,-0.05,0.45},
			{0.3,-0.3,0.3, 0.35,-0.25,0.45},
			{0.3,-0.25,0.25, 0.35,-0.1,0.3},
			{0.3,-0.25,0.45, 0.35,-0.1,0.5},
				---link 5
			{0.25,-0.25,0.35, 0.4,-0.2,0.4},
			{0.25,-0.45,0.35, 0.4,-0.4,0.4},
			{0.2,-0.4,0.35, 0.25,-0.25,0.4},
			{0.4,-0.4,0.35, 0.45,-0.25,0.4},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, 1/4, 1/2, 1/2, 1/2},
	},
	groups = {cracky=1}
})

minetest.register_node("3dforniture:torch_wall", {
	description = "Torch Wall",
	drawtype = "nodebox",
	tiles = {
		"forniture_torch_wall_s.png",
		"forniture_torch_wall_i.png",
		{name="forniture_torch_wall_anim.png", animation={type="vertical_frames", aspect_w=40, aspect_h=40, length=1.0}}},
	
	paramtype = 'light',
	paramtype2 = "facedir",
		node_box = {
		type = "fixed",
		fixed = {
				--torch
			{-0.05,-0.45,0.45, 0.05,-0.35,0.5},
			{-0.05,-0.35,0.4, 0.05,-0.25,0.5},
			{-0.05,-0.25,0.35, 0.05,-0.15,0.45},
			{-0.05,-0.15,0.3, 0.05,-0.05,0.4},
			{-0.05,-0.05,0.25, 0.05,0,0.35},
				-- fire
			{-0.1,0,0.2, 0.1,0.05,0.4},
			{-0.15,0.05,0.15, 0.15,0.15,0.45},
			{-0.1,0.15,0.2, 0.1,0.25,0.4},
			{-0.05,0.25,0.25, 0.05,0.35,0.35},
		},
	},
	sunlight_propagates = true,
	walkable = false,
	light_source = 18,
	selection_box = {
		type = "fixed",
		fixed = {-0.15, -0.45, 0.15, 0.15, 0.35, 0.5},
		},
	groups = {cracky=2}
	
})

minetest.register_node("3dforniture:toilet", {
	description = 'Toilet',
	tiles = {
		"forniture_marble.png",
		"forniture_marble.png",
		"forniture_marble_s1.png",
		"forniture_marble_s1.png",
		"forniture_marble_s2.png",
		"forniture_marble_s2.png",
	},
	drawtype = "nodebox",
	
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = 'facedir',
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2,-0.5,-0.2, 0.2,-0.45,0.5},
			{-0.1,-0.45,-0.1, 0.1,0,0.5},
			{-0.3,-0.2,-0.3, 0.3,0,0.35},
			{-0.25,0,-0.25, 0.25,0.05,0.25},
			{-0.3,0,0.3, 0.3,0.4,0.5},
			{-0.05,0.4,0.35, 0.05,0.45,0.45},
		},
	},
	drop = "3dforniture:toilet",
	groups = {cracky=2,}
	
})

minetest.register_node("3dforniture:toilet_open", {
	description = 'Toilet',
	tiles = {
		"forniture_marble_top_toilet.png",
		"forniture_marble.png",
		"forniture_marble_sb1.png",
		"forniture_marble_sb1.png",
		"forniture_marble_sb2.png",
		"forniture_marble_sb2.png",
	},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = 'facedir',
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2,-0.5,-0.2, 0.2,-0.45,0.5},
			{-0.1,-0.45,-0.1, 0.1,-0.2,0.5},
			{-0.1,-0.2,0.3, 0.1,0,0.5},
			{-0.3,-0.2,0.1, 0.3,0,0.35},
			{-0.3,-0.2,-0.3, -0.1,-0.15,0.1},
			{-0.1,-0.2,-0.3, 0.1,-0.15,-0.1},
			{0.1,-0.2,-0.3, 0.3,-0.15,0.1},
			{-0.3,-0.15,-0.3, -0.2,0,0.1},
			{-0.2,-0.15,-0.3, 0.2,0,-0.2},
			{0.2,-0.15,-0.3, 0.3,0,0.1},
			{-0.25,0,0.2, 0.25,0.5,0.25},
			{-0.3,0,0.3, 0.3,0.4,0.5},

		},
	},
	drop = "3dforniture:toilet",
	groups = {cracky=2,}
})

minetest.register_node("3dforniture:sink", {
	description = 'Sink',
	tiles = {
		"forniture_marble_top_sink.png",
		"forniture_marble.png",
		"forniture_marble_sb1.png",
		"forniture_marble_sb1.png",
		"forniture_marble_sb2.png",
		"forniture_marble_sb2.png",
	},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = 'facedir',
	node_box = {
		type = "fixed",
		fixed = {
			{-0.15,0.35,0.2, 0.15,0.4,0.5},
			{-0.25,0.4,0.4, 0.25,0.45,0.5},
			{-0.25,0.4,0.15, -0.15,0.45,0.4},
			{0.15,0.4,0.15, 0.25,0.45,0.4},
			{-0.15,0.4,0.15, 0.15,0.45,0.2},
			{-0.3,0.45,0.4, 0.3,0.5,0.5},
			{-0.3,0.45,0.1, -0.25,0.5,0.4},
			{0.25,0.45,0.1, 0.3,0.5,0.4},
			{-0.25,0.45,0.1, 0.25,0.5,0.15},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3,0.35,0.1, 0.3,0.5,0.5},
	},
	groups = {cracky=2,}	
})

minetest.register_node("3dforniture:taps", {
	description = 'Taps',
	tiles = {
		"forniture_metal.png",
		"forniture_metal.png",
		"forniture_metal_s1.png",
		"forniture_metal_s1.png",
		"forniture_metal_s2.png",
		"forniture_metal_s2.png",
	},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = 'facedir',
	node_box = {
		type = "fixed",
		fixed = {
			--base
			{-0.25,-0.45,0.49, 0.25,-0.3,0.5},
			{-0.05,-0.4,0.25, 0.05,-0.35,0.5},
			{-0.05,-0.425,0.25,0.05,-0.4,0.3},
			--taps 1
			{-0.2,-0.4,0.45, -0.15,-0.35,0.5},
			{-0.2,-0.45,0.4, -0.15,-0.3,0.45},
			{-0.25,-0.4,0.4, -0.1,-0.35,0.45},
			--taps 2
			{0.15,-0.4,0.45, 0.2,-0.35,0.5},
			{0.15,-0.45,0.4, 0.2,-0.3,0.45},
			{0.1,-0.4,0.4, 0.25,-0.35,0.45},
			
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.25,-0.45,0.25, 0.25,-0.3,0.5},
	},
	groups = {cracky=2,}	
})

minetest.register_node("3dforniture:shower_tray", {
	description = 'Shower Tray',
	tiles = {
		"forniture_marble_base_ducha_top.png",
		"forniture_marble_base_ducha_top.png",
		"forniture_marble_sb1.png",
		"forniture_marble_sb1.png",
		"forniture_marble_sb2.png",
		"forniture_marble_sb2.png",
	},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5, 0.5,-0.45,0.5},
			{-0.5,-0.45,-0.5, 0.5,-0.4,-0.45},
			{-0.5,-0.45,0.45, 0.5,-0.4,0.5},
			{-0.5,-0.45,-0.45, -0.45,-0.4,0.45},
			{0.45,-0.45,-0.45, 0.5,-0.4,0.45},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5,-0.5,-0.5, 0.5,-0.4,0.5},
	},
	groups = {cracky=2,}	
})

minetest.register_node("3dforniture:shower_head", {
	description = 'Shower Head',
	tiles = {
		"forniture_metal.png",
		"forniture_metal.png",
		"forniture_metal_s1.png",
		"forniture_metal_s1.png",
		"forniture_metal_s2.png",
		"forniture_metal_s2.png",
	},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = 'facedir',
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1,-0.5,0.1, 0.1,-0.4,0.3},
			{-0.05,-0.4,0.15, 0.05,-0.3,0.25},
			{-0.05,-0.35,0.25, 0.05,-0.3,0.5},
			{-0.1,-0.4,0.49, 0.1,-0.25,0.5},
			
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.1,-0.5,0.1, 0.1,-0.25,0.5},
	},
	groups = {cracky=2,}	
})
