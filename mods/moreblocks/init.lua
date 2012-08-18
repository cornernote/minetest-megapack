--[[
****
More Blocks
by Calinou
Version 12.08.03
Licensed under WTFPL.
****
--]]


--
-- Aliases
--

minetest.register_alias("stonebrick", "moreblocks:stonebrick")
minetest.register_alias("stonebricks", "moreblocks:stonebrick")
minetest.register_alias("stone_brick", "moreblocks:stonebrick")
minetest.register_alias("stone_bricks", "moreblocks:stonebrick")
minetest.register_alias("stonesquare", "moreblocks:stonesquare")
minetest.register_alias("stonesquares", "moreblocks:stonesquare")
minetest.register_alias("splitstonesquare", "moreblocks:splitstonesquare")
minetest.register_alias("splitstonesquares", "moreblocks:splitstonesquare")
minetest.register_alias("stone_square", "moreblocks:stonesquare")
minetest.register_alias("stone_squares", "moreblocks:stonesquare")
minetest.register_alias("split_stone_square", "moreblocks:splitstonesquare")
minetest.register_alias("split_stone_squares", "moreblocks:splitstonesquare")
minetest.register_alias("split_stonesquare", "moreblocks:splitstonesquare")
minetest.register_alias("split_stonesquares", "moreblocks:splitstonesquare")
minetest.register_alias("coalstone", "moreblocks:coalstone")
minetest.register_alias("ironstone", "moreblocks:ironstone")
minetest.register_alias("coalglass", "moreblocks:coalglass")
minetest.register_alias("ironglass", "moreblocks:ironglass")
minetest.register_alias("glowglass", "moreblocks:glowglass")
minetest.register_alias("superglowglass", "moreblocks:superglowglass")
minetest.register_alias("plankstone", "moreblocks:plankstone")
minetest.register_alias("cactusbrick", "moreblocks:cactusbrick")
minetest.register_alias("cactuschecker", "moreblocks:cactuschecker")
minetest.register_alias("coalchecker", "moreblocks:coalchecker")
minetest.register_alias("ironchecker", "moreblocks:ironchecker")


--
-- Crafting
--

-- junglewood
minetest.register_craft({
	output = "moreblocks:junglewood 4",
	recipe = {
		{"default:jungletree"},
	}
})

-- junglestick
minetest.register_craft({
	output = "moreblocks:junglestick 4",
	recipe = {
		{"moreblocks:junglewood"},
	}
})

-- fence_junglewood
minetest.register_craft({
	output = "moreblocks:fence_junglewood 2",
	recipe = {
		{"moreblocks:junglestick", "moreblocks:junglestick", "moreblocks:junglestick"},
		{"moreblocks:junglestick", "moreblocks:junglestick", "moreblocks:junglestick"},
	}
})

-- stonebrick
minetest.register_craft({
	output = "moreblocks:stonebrick 4",
	recipe = {
		{"default:stone", "default:stone"},
		{"default:stone", "default:stone"},
	}
})

-- circlestonebrick
minetest.register_craft({
	output = "moreblocks:circlestonebrick 8",
	recipe = {
		{"default:stone", "default:stone", "default:stone"},
		{"default:stone", "", "default:stone"},
		{"default:stone", "default:stone", "default:stone"},
	}
})

-- allfacestree
minetest.register_craft({
	output = "moreblocks:allfacestree 8",
	recipe = {
		{"default:tree", "default:tree", "default:tree"},
		{"default:tree", "", "default:tree"},
		{"default:tree", "default:tree", "default:tree"},
	}
})

-- sweeper
minetest.register_craft({
	output = "moreblocks:sweeper 3",
	recipe = {
		{"default:junglegrass"},
		{"default:stick"},
	}
})

-- stonesquare
minetest.register_craft({
	output = "moreblocks:stonesquare 4",
	recipe = {
		{"default:cobble", "default:cobble"},
		{"default:cobble", "default:cobble"},
	}
})

-- splitstonesquare
minetest.register_craft({
	output = "moreblocks:splitstonesquare",
	recipe = {
		{"moreblocks:stonesquare 1"},
	}
})

-- emptybookshelf
minetest.register_craft({
	output = "moreblocks:emptybookshelf",
	recipe = {
		{"moreblocks:sweeper"},
		{"default:bookshelf"},
	}
})

-- ironstonebrick
minetest.register_craft({
	output = "moreblocks:ironstonebrick",
	recipe = {
		{"default:steel_ingot"},
		{"moreblocks:stonebrick"},
	}
})

-- plankstone
minetest.register_craft({
	output = "moreblocks:plankstone 4",
	recipe = {
		{"default:cobble", "default:cobble"},
		{"default:wood", "default:wood"},
	}
})
minetest.register_craft({
	output = "moreblocks:plankstone 4",
	recipe = {
		{"default:wood", "default:stone"},
		{"default:stone", "default:wood"},
	}
})

-- coalchecker
minetest.register_craft({
	output = "moreblocks:coalchecker 4",
	recipe = {
		{"default:stone", "default:coal_lump"},
		{"default:coal_lump", "default:stone"},
	}
})
minetest.register_craft({
	output = "moreblocks:coalchecker 4",
	recipe = {
		{"default:coal_lump", "default:stone"},
		{"default:stone", "default:coal_lump"},
	}
})

-- ironchecker
minetest.register_craft({
	output = "moreblocks:ironchecker 4",
	recipe = {
		{"default:steel_ingot", "default:stone"},
		{"default:stone", "default:steel_ingot"},
	}
})
minetest.register_craft({
	output = "moreblocks:ironchecker 4",
	recipe = {
		{"default:stone", "default:steel_ingot"},
		{"default:steel_ingot", "default:stone"},
	}
})

-- ironglass
minetest.register_craft({
	output = "moreblocks:ironglass",
	recipe = {
		{"default:steel_ingot"},
		{"default:glass"},
	}
})

-- coalglass
minetest.register_craft({
	output = "moreblocks:coalglass",
	recipe = {
		{"default:coal_lump"},
		{"default:glass"},
	}
})

-- cleanglass
minetest.register_craft({
	output = "moreblocks:cleanglass",
	recipe = {
		{"moreblocks:sweeper"},
		{"default:glass"},
	}
})

-- glowglass
minetest.register_craft({
	output = "moreblocks:glowglass",
	recipe = {
		{"default:torch"},
		{"default:glass"},
	}
})

-- superglowglass
minetest.register_craft({
	output = "moreblocks:superglowglass",
	recipe = {
		{"default:torch"},
		{"default:torch"},
		{"default:glass"},
	}
})

-- coalstone
minetest.register_craft({
	output = "moreblocks:coalstone",
	recipe = {
		{"default:coal_lump"},
		{"default:stone"},
	}
})

-- trapstone
minetest.register_craft({
	output = "moreblocks:trapstone 12",
	recipe = {
		{"default:mese"},
		{"default:stone"},
	}
})

-- trapglass
minetest.register_craft({
	output = "moreblocks:trapglass 12",
	recipe = {
		{"default:mese"},
		{"default:glass"},
	}
})

-- ironstone
minetest.register_craft({
	output = "moreblocks:ironstone",
	recipe = {
		{"default:steel_ingot"},
		{"default:stone"},
	}
})

-- cactusbrick
minetest.register_craft({
	output = "moreblocks:cactusbrick",
	recipe = {
		{"default:cactus"},
		{"default:brick"},
	}
})

-- cactuschecker
minetest.register_craft({
	output = "moreblocks:cactuschecker 4",
	recipe = {
		{"default:cactus", "default:stone"},
		{"default:stone", "default:cactus"},
	}
})

-- cactuschecker
minetest.register_craft({
	output = "moreblocks:cactuschecker 4",
	recipe = {
		{"default:stone", "default:cactus"},
		{"default:cactus", "default:stone"},
	}
})

-- oerkkiblock
minetest.register_craft({
	output = "moreblocks:oerkkiblock 9",
	recipe = {
		{"default:iron_lump", "default:coal_lump", "default:iron_lump"},
		{"default:coal_lump", "bookshelf", "default:coal_lump"},
		{"default:iron_lump", "default:coal_lump", "default:iron_lump"},
	}
})

-- oerkkiblock
minetest.register_craft({
	output = "moreblocks:oerkkiblock 9",
	recipe = {
		{"default:coal_lump", "default:iron_lump", "default:coal_lump"},
		{"default:iron_lump", "default:bookshelf", "default:iron_lump"},
		{"default:coal_lump", "default:iron_lump", "default:coal_lump"},
	}
})

-- rope
minetest.register_craft({
	output = "moreblocks:rope",
	recipe = {
		{"default:junglegrass"},
		{"default:junglegrass"},
		{"default:junglegrass"},
	}
})

-- horizontaltree
minetest.register_craft({
	output = "moreblocks:horizontaltree 2",
	recipe = {
		{"default:tree", "default:tree"},
	}
})
minetest.register_craft({
	output = "default:wood 4",
	recipe = {
		{"moreblocks:horizontaltree"},
	}
})
minetest.register_craft({
	output = "default:tree 2",
	recipe = {
		{"moreblocks:horizontaltree"},
		{"moreblocks:horizontaltree"},
	}
})

-- horizontaljungletree
minetest.register_craft({
	output = "moreblocks:horizontaljungletree 2",
	recipe = {
		{"default:jungletree", "default:jungletree"},
	}
})
minetest.register_craft({
	output = "moreblocks:junglewood 4",
	recipe = {
		{"moreblocks:horizontaljungletree"},
	}
})
minetest.register_craft({
	output = "default:jungletree 2",
	recipe = {
		{"moreblocks:horizontaljungletree"},
		{"moreblocks:horizontaljungletree"},
	}
})
-- glowstone
minetest.register_craft({
	output = 'moreblocks:glowstone',
	recipe = {
		{'', 'default:torch', ''},
		{'default:torch', 'moreblocks:stonesquare', 'default:torch'},
		{'', 'default:torch', ''},
	}
})


--
-- Blocks
--

minetest.register_node("moreblocks:junglewood", {
	description = "Jungle Wooden Planks",
	tile_images = {"moreblocks_junglewood.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:stonebrick", {
	description = "Stone Bricks",
	tile_images = {"moreblocks_stonebrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:circlestonebrick", {
	description = "Circle Stone Bricks",
	tile_images = {"moreblocks_circlestonebrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:ironstonebrick", {
	description = "Iron Stone Bricks",
	tile_images = {"moreblocks_ironstonebrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:stonesquare", {
	description = "Stonesquare",
	tile_images = {"moreblocks_stonesquare.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:splitstonesquare", {
	description = "Split Stonesquare",
	tile_images = {"moreblocks_splitstonesquare_top.png", "moreblocks_splitstonesquare.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:plankstone", {
	description = "Plankstone",
	tile_images = {"moreblocks_plankstone.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:ironglass", {
	description = "Iron Glass",
	drawtype = "glasslike",
	tile_images = {"moreblocks_ironglass.png"},
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("moreblocks:coalglass", {
	description = "Coal Glass",
	drawtype = "glasslike",
	tile_images = {"moreblocks_coalglass.png"},
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("moreblocks:cleanglass", {
	description = "Clean Glass",
	drawtype = "glasslike",
	tile_images = {"moreblocks_cleanglass.png"},
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})


minetest.register_node("moreblocks:cactusbrick", {
	description = "Cactus Brick",
	tile_images = {"moreblocks_cactusbrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:cactuschecker", {
	description = "Cactus Checker",
	tile_images = {"moreblocks_cactuschecker.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:emptybookshelf", {
	description = "Empty Bookshelf",
	tile_images = {"default_wood.png", "default_wood.png", "moreblocks_emptybookshelf.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=3,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:oerkkiblock", {
	description = "Oerkki Block",
	tile_images = {"moreblocks_oerkkiblock.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:coalstone", {
	description = "Coalstone",
	tile_images = {"moreblocks_coalstone.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:ironstone", {
	description = "Ironstone",
	tile_images = {"moreblocks_ironstone.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:coalchecker", {
	description = "Coalchecker",
	tile_images = {"moreblocks_coalchecker.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:ironchecker", {
	description = "Ironchecker",
	tile_images = {"moreblocks_ironchecker.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:trapstone", {
	description = "Trapstone",
	tile_images = {"moreblocks_trapstone.png"},
	walkable = false,
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:trapglass", {
	description = "Trapglass",
	drawtype = "glasslike",
	tile_images = {"moreblocks_trapglass.png"},
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("moreblocks:fence_junglewood", {
	description = "Jungle Wood Fence",
	drawtype = "fencelike",
	tile_images = {"moreblocks_junglewood.png"},
	inventory_image = "moreblocks_junglewood_fence.png",
	wield_image = "moreblocks_junglewood_fence.png",
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:horizontaltree", {
	description = "Horizontal Tree",
	tile_images = {"default_tree.png", "default_tree.png", "moreblocks_horizontaltree.png",
		"moreblocks_horizontaltree.png", "default_tree_top.png", "default_tree_top.png"},
	paramtype2 = "facedir",
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	furnace_burntime = 30,
})

minetest.register_node("moreblocks:horizontaljungletree", {
	description = "Horizontal Jungletree",
	tile_images = {"default_jungletree.png", "default_jungletree.png", "moreblocks_horizontaljungletree.png",
		"moreblocks_horizontaljungletree.png", "default_jungletree_top.png", "default_jungletree_top.png"},
	paramtype2 = "facedir",
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	furnace_burntime = 30,
})

minetest.register_node("moreblocks:allfacestree", {
	description = "All-faces Tree",
	tile_images = {"default_tree_top.png"},
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	furnace_burntime = 30,
})

minetest.register_node("moreblocks:glowglass", {
	description = "Glowglass",
	drawtype = "glasslike",
	tile_images = {"moreblocks_glowglass.png"},
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 12,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("moreblocks:superglowglass", {
	description = "Super Glowglass",
	drawtype = "glasslike",
	tile_images = {"moreblocks_glowglass.png"},
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 15	,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("moreblocks:rope", {
	description = "Rope",
	drawtype = "signlike",
	tile_images = {"moreblocks_rope.png"},
	inventory_image = "moreblocks_rope.png",
	wield_image = "moreblocks_rope.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	is_ground_content = true,
	walkable = false,
	climbable = true,
	selection_box = {
		type = "wallmounted",
	},
	groups = {snappy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("moreblocks:glowstone", {
	description = "Glowstone",
	tiles = {"blox_glowstone.png"},
	inventory_image = "blox_glowstone.png",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 30	,
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

-- Items

minetest.register_craftitem("moreblocks:sweeper", {
	description = "Sweeper",
	inventory_image = "moreblocks_sweeper.png",
})

minetest.register_craftitem("moreblocks:junglestick", {
	description = "Jungle Stick",
	inventory_image = "moreblocks_junglestick.png",
})

-- Slabs/Stairss/Panels

-- Code imported from Stairss+ mod. ;)


moreblocks = {}

-- Node will be called moreblocks:stair_<subname>
function moreblocks.register_stair(subname, recipeitem, groups, images, description)
	minetest.register_node("moreblocks:stair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})

		minetest.register_node("moreblocks:stair_" .. subname .. "_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, -0.5, 0.5, 0.5, 0.5},
				{-0.5, -0.5, 0, 0.5, 0, 0.5},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
		minetest.register_node("moreblocks:stair_" .. subname .. "_wall", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, 0, 0.5, 0.5, 0.5},
				{-0.5, -0.5, -0.5, 0, 0.5, 0},
			},
		},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_craft({
		output = 'moreblocks:stair_' .. subname .. ' 8',
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'moreblocks:stair_' .. subname .. ' 8',
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'moreblocks:stair_' .. subname .. '_inverted' .. ' 8',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{recipeitem, recipeitem, ""},
			{recipeitem, "", ""},
		},
	})
	
	minetest.register_craft({
		output = 'moreblocks:stair_' .. subname .. '_inverted' .. ' 8',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{"", recipeitem, recipeitem},
			{"", "", recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'moreblocks:stair_' .. subname .. '_inverted' .. ' 1',
		recipe = {
			{'moreblocks:stair_' .. subname},
		},
	})
	
	minetest.register_craft({
		output = 'moreblocks:stair_' .. subname .. '_inverted' .. ' 1',
		recipe = {
			{'stairs:stair_' .. subname},
		},
	})
	
	minetest.register_craft({
		output = 'moreblocks:stair_' .. subname .. ' 1',
		recipe = {
			{'moreblocks:stair_' .. subname .. '_inverted'},
		},
	})
	
	minetest.register_craft({
		output = 'moreblocks:stair_' .. subname .. '_wall' .. ' 7',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{"", "", recipeitem},
			{"", "", recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'moreblocks:stair_' .. subname .. '_wall' .. ' 7',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{recipeitem, ""	, ""},
			{recipeitem, "", ""},
		},
	})
end

-- Node will be called moreblocks:slab_<subname>
function moreblocks.register_slab(subname, recipeitem, groups, images, description)
	minetest.register_node("moreblocks:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
	minetest.register_node("moreblocks:slab_" .. subname .. "_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
	minetest.register_node("moreblocks:slab_" .. subname .. "_wall", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_craft({
		output = 'moreblocks:slab_' .. subname .. ' 6',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'moreblocks:slab_' .. subname .. '_wall' .. ' 6',
		recipe = {
			{recipeitem},
			{recipeitem},
			{recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'moreblocks:slab_' .. subname .. '_inverted' .. ' 1',
		recipe = {
			{'moreblocks:slab_' .. subname},
		},
	})
	
	minetest.register_craft({
		output = 'moreblocks:slab_' .. subname .. ' 1',
		recipe = {
			{'moreblocks:slab_' .. subname .. '_inverted'},
		},
	})
end

-- Node will be called moreblocks:panel_<subname>
function moreblocks.register_panel(subname, recipeitem, groups, images, description)
	minetest.register_node("moreblocks:panel_" .. subname .. "_bottom", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
	minetest.register_node("moreblocks:panel_" .. subname .. "_top", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})
	
	minetest.register_node("moreblocks:panel_" .. subname .. "_vertical", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0.5, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0.5, 0.5},
		},
		sounds = default.node_sound_stone_defaults(),
	})

	minetest.register_craft({
		output = 'moreblocks:panel_' .. subname .. '_bottom' .. ' 8',
		recipe = {
			{recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'moreblocks:panel_' .. subname .. '_vertical' .. ' 8',
		recipe = {
			{recipeitem},
			{recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'moreblocks:panel_' .. subname .. '_top' .. ' 1',
		recipe = {
			{'moreblocks:panel_' .. subname .. '_bottom'},
		},
	})
	
	minetest.register_craft({
		output = 'moreblocks:panel_' .. subname .. '_bottom' .. ' 1',
		recipe = {
			{'moreblocks:panel_' .. subname .. '_top'},
		},
	})
end

-- Nodes will be called moreblocks:{stair,slab}_<subname>
function moreblocks.register_stair_and_slab_and_panel(subname, recipeitem, groups, images, desc_stair, desc_slab, desc_panel)
	moreblocks.register_stair(subname, recipeitem, groups, images, desc_stair)
	moreblocks.register_slab(subname, recipeitem, groups, images, desc_slab)
	moreblocks.register_panel(subname, recipeitem, groups, images, desc_panel)
end

-- Some stairs/slabs/panels

moreblocks.register_stair_and_slab_and_panel("stonebrick", "moreblocks:stonebrick",
		{cracky=3},
		{"moreblocks_stonebrick.png"},
		"Stone Bricks Stairs",
		"Stone Bricks Slab",
		"Stone Bricks Panel")
		
moreblocks.register_stair_and_slab_and_panel("ironstonebrick", "moreblocks:ironstonebrick",
		{cracky=3},
		{"moreblocks_stonebrick.png"},
		"Iron Stone Bricks Stairs",
		"Iron Stone Bricks Slab",
		"Iron Stone Bricks Panel")
		
moreblocks.register_stair_and_slab_and_panel("stonesquare", "moreblocks:stonesquare",
		{cracky=3},
		{"moreblocks_stonesquare.png"},
		"Stonesquare Stairs",
		"Stonesquare Slab",
		"Stonesquare Panel")
		
moreblocks.register_stair_and_slab_and_panel("splitstonesquare", "moreblocks:splitstonesquare",
		{cracky=3},
		{"moreblocks_splitstonesquare_top.png", "moreblocks_splitstonesquare.png"},
		"Split Stonesquare Stairs",
		"Split Stonesquare Slab",
		"Split Stonesquare Panel")
		
moreblocks.register_stair_and_slab_and_panel("junglewood", "moreblocks:junglewood",
		{snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"moreblocks_junglewood.png"},
		"Jungle Wood Stairs",
		"Jungle Wood Slab",
		"Jungle Wood Panel")
		
moreblocks.register_stair_and_slab_and_panel("circlestonebrick", "moreblocks:circlestonebrick",
		{cracky=3},
		{"moreblocks_circlestonebrick.png"},
		"Stone Stairs",
		"Stone Slab",
		"Stone Panel")
		
moreblocks.register_stair_and_slab_and_panel("plankstone", "moreblocks:plankstone",
		{cracky=3},
		{"moreblocks_junglewood.png"},
		"Plankstone Stairs",
		"Plankstone Slab",
		"Plankstone Panel")