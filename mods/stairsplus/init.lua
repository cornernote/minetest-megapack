--[[
****
Stairs+
by Calinou
Version 12.06.18
Licensed under WTFPL.
****
--]]

stairsplus = {}

-- Node will be called stairsplus:stair_<subname>
function stairsplus.register_stair(subname, recipeitem, groups, images, description)
	minetest.register_node("stairsplus:stair_" .. subname, {
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

		minetest.register_node("stairsplus:stair_" .. subname .. "_inverted", {
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
	
		minetest.register_node("stairsplus:stair_" .. subname .. "_wall", {
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
		output = 'stairsplus:stair_' .. subname .. ' 8',
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'stairsplus:stair_' .. subname .. ' 8',
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'stairsplus:stair_' .. subname .. '_inverted' .. ' 8',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{recipeitem, recipeitem, ""},
			{recipeitem, "", ""},
		},
	})
	
	minetest.register_craft({
		output = 'stairsplus:stair_' .. subname .. '_inverted' .. ' 8',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{"", recipeitem, recipeitem},
			{"", "", recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'stairsplus:stair_' .. subname .. '_inverted' .. ' 1',
		recipe = {
			{'stairsplus:stair_' .. subname},
		},
	})
	
	minetest.register_craft({
		output = 'stairsplus:stair_' .. subname .. '_inverted' .. ' 1',
		recipe = {
			{'stairs:stair_' .. subname},
		},
	})
	
	minetest.register_craft({
		output = 'stairsplus:stair_' .. subname .. ' 1',
		recipe = {
			{'stairsplus:stair_' .. subname .. '_inverted'},
		},
	})
	
	minetest.register_craft({
		output = 'stairsplus:stair_' .. subname .. '_wall' .. ' 7',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{"", "", recipeitem},
			{"", "", recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'stairsplus:stair_' .. subname .. '_wall' .. ' 7',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{recipeitem, ""	, ""},
			{recipeitem, "", ""},
		},
	})
end

-- Node will be called stairsplus:slab_<subname>
function stairsplus.register_slab(subname, recipeitem, groups, images, description)
	minetest.register_node("stairsplus:slab_" .. subname, {
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
	
	minetest.register_node("stairsplus:slab_" .. subname .. "_inverted", {
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
	
	minetest.register_node("stairsplus:slab_" .. subname .. "_wall", {
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
		output = 'stairsplus:slab_' .. subname .. ' 6',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'stairsplus:slab_' .. subname .. '_wall' .. ' 6',
		recipe = {
			{recipeitem},
			{recipeitem},
			{recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'stairsplus:slab_' .. subname .. '_inverted' .. ' 1',
		recipe = {
			{'stairsplus:slab_' .. subname},
		},
	})
	
	minetest.register_craft({
		output = 'stairsplus:slab_' .. subname .. ' 1',
		recipe = {
			{'stairsplus:slab_' .. subname .. '_inverted'},
		},
	})
end

-- Node will be called stairsplus:panel_<subname>
function stairsplus.register_panel(subname, recipeitem, groups, images, description)
	minetest.register_node("stairsplus:panel_" .. subname .. "_bottom", {
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
	
	minetest.register_node("stairsplus:panel_" .. subname .. "_top", {
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
	
	minetest.register_node("stairsplus:panel_" .. subname .. "_vertical", {
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
		output = 'stairsplus:panel_' .. subname .. '_bottom' .. ' 8',
		recipe = {
			{recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'stairsplus:panel_' .. subname .. '_vertical' .. ' 8',
		recipe = {
			{recipeitem},
			{recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'stairsplus:panel_' .. subname .. '_top' .. ' 1',
		recipe = {
			{'stairsplus:panel_' .. subname .. '_bottom'},
		},
	})
	
	minetest.register_craft({
		output = 'stairsplus:panel_' .. subname .. '_bottom' .. ' 1',
		recipe = {
			{'stairsplus:panel_' .. subname .. '_top'},
		},
	})
end

-- Nodes will be called stairsplus:{stair,slab}_<subname>
function stairsplus.register_stair_and_slab_and_panel(subname, recipeitem, groups, images, desc_stair, desc_slab, desc_panel)
	stairsplus.register_stair(subname, recipeitem, groups, images, desc_stair)
	stairsplus.register_slab(subname, recipeitem, groups, images, desc_slab)
	stairsplus.register_panel(subname, recipeitem, groups, images, desc_panel)
end

stairsplus.register_stair_and_slab_and_panel("wood", "default:wood",
		{snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		{"default_wood.png"},
		"Wooden Stair",
		"Wooden Slab",
		"Wooden Panel")

stairsplus.register_stair_and_slab_and_panel("stone", "default:stone",
		{cracky=3},
		{"default_stone.png"},
		"Stone Stair",
		"Stone Slab",
		"Stone Panel")

stairsplus.register_stair_and_slab_and_panel("cobble", "default:cobble",
		{cracky=3},
		{"default_cobble.png"},
		"Cobblestone Stair",
		"Cobblestone Slab",
		"Cobblestone Panel")
		
stairsplus.register_stair_and_slab_and_panel("mossycobble", "default:mossycobble",
		{cracky=3},
		{"default_mossycobble.png"},
		"Mossy Cobblestone Stair",
		"Mossy Cobblestone Slab",
		"Mossy Cobblestone Panel")

stairsplus.register_stair_and_slab_and_panel("brick", "default:brick",
		{cracky=3},
		{"default_brick.png"},
		"Brick Stair",
		"Brick Slab",
		"Brick Panel")

stairsplus.register_stair_and_slab_and_panel("sandstone", "default:sandstone",
		{crumbly=2,cracky=2},
		{"default_sandstone.png"},
		"Sandstone Stair",
		"Sandstone Slab",
		"Sandstone Panel")
		
stairsplus.register_stair_and_slab_and_panel("steelblock", "default:steelblock",
		{snappy=1,bendy=2,cracky=1,melty=2,level=2},
		{"default_steel_block.png"},
		"Steel Block Stair",
		"Steel Block Slab",
		"Steel Block Panel")
