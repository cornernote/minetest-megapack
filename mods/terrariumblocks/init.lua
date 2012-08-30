--[[
TerarriumBlocks
by Fifi
Version 1.
Code is licensed under BSD license, while all textures are licensed on CC BY-SA rules.
Based on More Blocks, by Calinou.
--]]


-- New crafting recipes registration.

-- Bricks:

minetest.register_craft({
	output = 'node "terrariumblocks:carbon_brick" 4',
	recipe = {
		{'node "terrariumblocks:carbon_fibre_block"', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'node "terrariumblocks:tin_brick" 4',
	recipe = {
		{'moreores:tin_lump', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'node "terrariumblocks:tin_brick" 5',
	recipe = {
		{'moreores:tin_ingot', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'node "terrariumblocks:copper_brick" 4',
	recipe = {
		{'moreores:copper_lump', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'node "terrariumblocks:copper_brick" 5',
	recipe = {
		{'moreores:copper_ingot', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'node "terrariumblocks:bronze_brick" 4',
	recipe = {
		{'moreores:bronze_lump', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:bronze_brick 5',
	recipe = {
		{'moreores:bronze_ingot', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'node "terrariumblocks:rusty_brick" 4',
	recipe = {
		{'default:iron_lump', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:rusty_brick 5',
	recipe = {
		{'default:steel_ingot', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:silver_brick 4',
	recipe = {
		{'moreores:silver_lump', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:silver_brick 5',
	recipe = {
		{'moreores:silver_ingot', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:golden_brick 4',
	recipe = {
		{'moreores:gold_lump', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:golden_brick 5',
	recipe = {
		{'moreores:gold_ingot', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:mithril_brick 4',
	recipe = {
		{'moreores:mithril_lump', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:mithril_brick 5',
	recipe = {
		{'moreores:mithril_ingot', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:marble_brick 6',
	recipe = {
		{'terrariumblocks:marble', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:granite_brick 8',
	recipe = {
		{'terrariumblocks:granite', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:porphyry_brick 8',
	recipe = {
		{'terrariumblocks:porphyry', 'node "default:stone"'},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:sandstone_brick 8',
	recipe = {
		{'default:sandstone', 'default:sandstone'},
		{'default:sandstone', 'default:sandstone'},
	}
})

-- Other materials:

minetest.register_craft({
	output = 'terrariumblocks:carbon_fibre_block 6',
	recipe = {
		{'default:coal_lump', 'default:coal_lump'},
		{'default:coal_lump', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:marble',
	type = 'cooking',
	recipe = 'default:stone'
})

minetest.register_craft({
	output = 'terrariumblocks:granite 16',
	type = 'cooking',
	recipe = 'lavacooling:moltenrock'
})

minetest.register_craft({
	output = 'terrariumblocks:porphyry 4',
	type = 'cooking',
	recipe = 'default:gravel'
})

minetest.register_craft({
	output = 'terrariumblocks:stonewall 27',
	recipe = {
		{'', 'default:stone', ''},
		{'default:stone', 'default:stone', 'default:stone'},
		{'', 'default:stone', ''},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:plankedwall 27',
	recipe = {
		{'terrariumblocks:stonewall', 'default:tree'},
	}
})

minetest.register_craft({
	output = 'terrariumblocks:woodenbeam 8',
	recipe = {
		{'default:tree'},
		{'default:tree'},
	}
})


-- New blocks registration.

-- Bricks:

minetest.register_node("terrariumblocks:carbon_brick", {
	description = "Carbon Bricks",
	tile_images = {"terrariumblocks_carbonbrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:tin_brick", {
	description = "Tin Bricks",
	tile_images = {"terrariumblocks_tinbrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:copper_brick", {
	description = "Copper Bricks",
	tile_images = {"terrariumblocks_copperbrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:bronze_brick", {
	description = "Bronze Bricks",
	tile_images = {"terrariumblocks_bronzebrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:rusty_brick", {
	description = "Rusty Bricks",
	tile_images = {"terrariumblocks_rustybrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:silver_brick", {
	description = "Silver Bricks",
	tile_images = {"terrariumblocks_silverbrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:golden_brick", {
	description = "Golden Bricks",
	tile_images = {"terrariumblocks_goldenbrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:mithril_brick", {
	description = "Mithril Bricks",
	tile_images = {"terrariumblocks_mithrilbrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:marble_brick", {
	description = "Marble Bricks",
	tile_images = {"terrariumblocks_marblebrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:granite_brick", {
	description = "Granite Bricks",
	tile_images = {"terrariumblocks_granitebrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:porphyry_brick", {
	description = "Porphyry Bricks",
	tile_images = {"terrariumblocks_porphyrybrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:sandstone_brick", {
	description = "Sandstone Bricks",
	tile_images = {"terrariumblocks_sandstonebrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

-- Other materials:

minetest.register_node("terrariumblocks:carbon_fibre_block", {
	description = "Carbon Fibre Block",
	tile_images = {"terrariumblocks_carbonfibreblock.png"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:marble", {
	description = "Marble",
	tile_images = {"terrariumblocks_marble.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:granite", {
	description = "Granite",
	tile_images = {"terrariumblocks_granite.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:porphyry", {
	description = "Porphyry",
	tile_images = {"terrariumblocks_porphyry.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:stonewall", {
	description = "Stone wall",
	tile_images = {"terrariumblocks_stonewall.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:plankedwall", {
	description = "Planked wall",
	tile_images = {"terrariumblocks_stonewall.png", "terrariumblocks_stonewall.png", "terrariumblocks_plankedwall.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("terrariumblocks:woodenbeam", {
	description = "Wooden beam",
	tile_images = {"terrariumblocks_woodenbeam_top_and_bottom.png", "terrariumblocks_woodenbeam_top_and_bottom.png", "terrariumblocks_woodenbeam.png"},
	is_ground_content = true,
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})


-- Technical stuff.

terrariumblocks = {}

-- Node will be called terrariumblo9cks:stair_<subname>.

function terrariumblocks.register_stair(subname, recipeitem, groups, images, description)
	minetest.register_node("terrariumblocks:stair_" .. subname, {
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

		minetest.register_node("terrariumblocks:stair_" .. subname .. "_inverted", {
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
	
		minetest.register_node("terrariumblocks:stair_" .. subname .. "_wall", {
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
		output = 'terrariumblocks:stair_' .. subname .. ' 8',
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'terrariumblocks:stair_' .. subname .. ' 8',
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'terrariumblocks:stair_' .. subname .. '_inverted' .. ' 8',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{recipeitem, recipeitem, ""},
			{recipeitem, "", ""},
		},
	})
	
	minetest.register_craft({
		output = 'terrariumblocks:stair_' .. subname .. '_inverted' .. ' 8',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{"", recipeitem, recipeitem},
			{"", "", recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'terrariumblocks:stair_' .. subname .. '_inverted' .. ' 1',
		recipe = {
			{'terrariumblocks:stair_' .. subname},
		},
	})
	
	minetest.register_craft({
		output = 'terrariumblocks:stair_' .. subname .. '_inverted' .. ' 1',
		recipe = {
			{'stairs:stair_' .. subname},
		},
	})
	
	minetest.register_craft({
		output = 'terrariumblocks:stair_' .. subname .. ' 1',
		recipe = {
			{'terrariumblocks:stair_' .. subname .. '_inverted'},
		},
	})
	
	minetest.register_craft({
		output = 'terrariumblocks:stair_' .. subname .. '_wall' .. ' 7',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{"", "", recipeitem},
			{"", "", recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'terrariumblocks:stair_' .. subname .. '_wall' .. ' 7',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{recipeitem, ""	, ""},
			{recipeitem, "", ""},
		},
	})
end

-- Node will be called terrariumblocks:slab_<subname>.

function terrariumblocks.register_slab(subname, recipeitem, groups, images, description)
	minetest.register_node("terrariumblocks:slab_" .. subname, {
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
	
	minetest.register_node("terrariumblocks:slab_" .. subname .. "_inverted", {
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
	
	minetest.register_node("terrariumblocks:slab_" .. subname .. "_wall", {
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
		output = 'terrariumblocks:slab_' .. subname .. ' 6',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'terrariumblocks:slab_' .. subname .. '_wall' .. ' 6',
		recipe = {
			{recipeitem},
			{recipeitem},
			{recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'terrariumblocks:slab_' .. subname .. '_inverted' .. ' 1',
		recipe = {
			{'terrariumblocks:slab_' .. subname},
		},
	})
	
	minetest.register_craft({
		output = 'terrariumblocks:slab_' .. subname .. ' 1',
		recipe = {
			{'terrariumblocks:slab_' .. subname .. '_inverted'},
		},
	})
end

-- Node will be called terrariumblocks:panel_<subname>.

function terrariumblocks.register_panel(subname, recipeitem, groups, images, description)
	minetest.register_node("terrariumblocks:panel_" .. subname .. "_bottom", {
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
	
	minetest.register_node("terrariumblocks:panel_" .. subname .. "_top", {
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
	
	minetest.register_node("terrariumblocks:panel_" .. subname .. "_vertical", {
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
		output = 'terrariumblocks:panel_' .. subname .. '_bottom' .. ' 8',
		recipe = {
			{recipeitem, recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'terrariumblocks:panel_' .. subname .. '_vertical' .. ' 8',
		recipe = {
			{recipeitem},
			{recipeitem},
		},
	})
	
	minetest.register_craft({
		output = 'terrariumblocks:panel_' .. subname .. '_top' .. ' 1',
		recipe = {
			{'terrariumblocks:panel_' .. subname .. '_bottom'},
		},
	})
	
	minetest.register_craft({
		output = 'terrariumblocks:panel_' .. subname .. '_bottom' .. ' 1',
		recipe = {
			{'terrariumblocks:panel_' .. subname .. '_top'},
		},
	})
end

-- Nodes will be called terrariumblocks:{stair,slab}_<subname>.

function terrariumblocks.register_stair_and_slab_and_panel(subname, recipeitem, groups, images, desc_stair, desc_slab, desc_panel)
	terrariumblocks.register_stair(subname, recipeitem, groups, images, desc_stair)
	terrariumblocks.register_slab(subname, recipeitem, groups, images, desc_slab)
	terrariumblocks.register_panel(subname, recipeitem, groups, images, desc_panel)
end


-- Stairs, slabs and panels registration.

-- Bricks:

terrariumblocks.register_stair_and_slab_and_panel("carbon_brick", "terrariumblocks:carbon_brick",
		{cracky=3},
		{"terrariumblocks_carbonbrick.png"},
		"Carbon Bricks Stairs",
		"Carbon Bricks Slab",
		"Carbon Bricks Panel")

terrariumblocks.register_stair_and_slab_and_panel("tin_brick", "terrariumblocks:tin_brick",
		{cracky=3},
		{"terrariumblocks_tinbrick.png"},
		"Tin Bricks Stairs",
		"Tin Bricks Slab",
		"Tin Bricks Panel")

terrariumblocks.register_stair_and_slab_and_panel("copper_brick", "terrariumblocks:copper_brick",
		{cracky=3},
		{"terrariumblocks_copperbrick.png"},
		"Copper Bricks Stairs",
		"Copper Bricks Slab",
		"Copper Bricks Panel")

terrariumblocks.register_stair_and_slab_and_panel("bronze_brick", "terrariumblocks:bronze_brick",
		{cracky=3},
		{"terrariumblocks_bronzebrick.png"},
		"Bronze Bricks Stairs",
		"Bronze Bricks Slab",
		"Bronze Bricks Panel")

terrariumblocks.register_stair_and_slab_and_panel("rusty_brick", "terrariumblocks:rusty_brick",
		{cracky=3},
		{"terrariumblocks_rustybrick.png"},
		"Rusty Bricks Stairs",
		"Rusty Bricks Slab",
		"Rusty Bricks Panel")

terrariumblocks.register_stair_and_slab_and_panel("silver_brick", "terrariumblocks:silver_brick",
		{cracky=3},
		{"terrariumblocks_silverbrick.png"},
		"Silver Bricks Stairs",
		"Silver Bricks Slab",
		"Silver Bricks Panel")

terrariumblocks.register_stair_and_slab_and_panel("golden_brick", "terrariumblocks:golden_brick",
		{cracky=3},
		{"terrariumblocks_goldenbrick.png"},
		"Golden Bricks Stairs",
		"Golden Bricks Slab",
		"Golden Bricks Panel")

terrariumblocks.register_stair_and_slab_and_panel("mithril_brick", "terrariumblocks:mithril_brick",
		{cracky=3},
		{"terrariumblocks_mithrilbrick.png"},
		"Mithril Bricks Stairs",
		"Mithril Bricks Slab",
		"Mithril Bricks Panel")

terrariumblocks.register_stair_and_slab_and_panel("marble_brick", "terrariumblocks:marble_brick",
		{cracky=3},
		{"terrariumblocks_marblebrick.png"},
		"Marble Bricks Stairs",
		"Marble Bricks Slab",
		"Marble Bricks Panel")

terrariumblocks.register_stair_and_slab_and_panel("granite_brick", "terrariumblocks:granite_brick",
		{cracky=3},
		{"terrariumblocks_granitebrick.png"},
		"Granite Bricks Stairs",
		"Granite Bricks Slab",
		"Granite Bricks Panel")

terrariumblocks.register_stair_and_slab_and_panel("porphyry_brick", "terrariumblocks:porphyry_brick",
		{cracky=3},
		{"terrariumblocks_porphyrybrick.png"},
		"Porphyry Bricks Stairs",
		"Porphyry Bricks Slab",
		"Porphyry Bricks Panel")

terrariumblocks.register_stair_and_slab_and_panel("sandstone_brick", "terrariumblocks:sandstone_brick",
		{cracky=3},
		{"terrariumblocks_sandstonebrick.png"},
		"Sandstone Bricks Stairs",
		"Sandstone Bricks Slab",
		"Sandstone Bricks Panel")

-- Other materials:

terrariumblocks.register_stair_and_slab_and_panel("carbon_fibre_block", "terrariumblocks:carbon_fibre_block",
		{cracky=1},
		{"terrariumblocks_carbonfibreblock.png"},
		"Carbon Fibre Stairs",
		"Carbon Fibre Slab",
		"Carbon Fibre Panel")

terrariumblocks.register_stair_and_slab_and_panel("marble", "terrariumblocks:marble",
		{cracky=3},
		{"terrariumblocks_marble.png"},
		"Marble Stairs",
		"Marble Slab",
		"Marble Panel")

terrariumblocks.register_stair_and_slab_and_panel("granite", "terrariumblocks:granite",
		{cracky=3},
		{"terrariumblocks_granite.png"},
		"Granite Stairs",
		"Granite Slab",
		"Granite Panel")

terrariumblocks.register_stair_and_slab_and_panel("porphyry", "terrariumblocks:porphyry",
		{cracky=3},
		{"terrariumblocks_porphyry.png"},
		"Porphyry Stairs",
		"Porphyry Slab",
		"Porphyry Panel")

