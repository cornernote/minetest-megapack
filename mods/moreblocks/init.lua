--[[
****
More Blocks
by Calinou
Version 12.08.03
Licensed under WTFPL.
****
--]]

-- Aliases (some of them are about the default mod, some about moreblocks)

-- Additional default aliases

minetest.register_alias("woodpick", "default:pick_wood")
minetest.register_alias("woodenpick", "default:pick_wood")
minetest.register_alias("stonepick", "default:pick_stone")
minetest.register_alias("steelpick", "default:pick_steel")
minetest.register_alias("ironpick", "default:pick_steel")
minetest.register_alias("mesepick", "default:pick_mese")

minetest.register_alias("woodaxe", "default:axe_wood")
minetest.register_alias("woodenaxe", "default:axe_wood")
minetest.register_alias("stoneaxe", "default:axe_stone")
minetest.register_alias("steelaxe", "default:axe_steel")
minetest.register_alias("ironaxe", "default:axe_steel")

minetest.register_alias("woodshovel", "default:shovel_wood")
minetest.register_alias("woodenshovel", "default:shovel_wood")
minetest.register_alias("stoneshovel", "default:shovel_stone")
minetest.register_alias("steelshovel", "default:shovel_steel")
minetest.register_alias("ironshovel", "default:shovel_steel")

minetest.register_alias("woodsword", "default:sword_wood")
minetest.register_alias("woodensword", "default:sword_wood")
minetest.register_alias("stonesword", "default:sword_stone")
minetest.register_alias("steelsword", "default:sword_steel")
minetest.register_alias("ironsword", "default:sword_steel")

minetest.register_alias("grass", "default:dirt_with_grass")
minetest.register_alias("grassblock", "default:dirt_with_grass")
minetest.register_alias("grass_block", "default:dirt_with_grass")

minetest.register_alias("grassfootsteps", "default:dirt_with_grass_footsteps")
minetest.register_alias("grass_footsteps", "default:dirt_with_grass_footsteps")

minetest.register_alias("stick", "default:stick")
minetest.register_alias("sign", "default:sign_wall")
minetest.register_alias("fence", "default:fence_wood")
minetest.register_alias("coal", "default:coal_lump")
minetest.register_alias("iron", "default:iron_lump")
minetest.register_alias("clay", "default:clay_lump")
minetest.register_alias("steel", "default:steel_ingot")
minetest.register_alias("steel_block", "default:steelblock")

-- More Blocks aliases

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

-- Redefinitions of some default crafting recipes

minetest.register_craft({
	output = 'default:sign_wall 4',
	recipe = {
		{'default:wood', 'default:wood', 'default:wood'},
		{'default:wood', 'default:wood', 'default:wood'},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:ladder 3',
	recipe = {
		{'default:stick', '', 'default:stick'},
		{'default:stick', 'default:stick', 'default:stick'},
		{'default:stick', '', 'default:stick'},
	}
})

minetest.register_craft({
	output = 'default:paper 3',
	recipe = {
		{'default:papyrus', 'default:papyrus', 'default:papyrus'},
	}
})

minetest.register_craft({
	output = 'default:rail 16',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:stick', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'default:axe_wood',
	recipe = {
		{'default:wood', 'default:wood'},
		{'default:stick', 'default:wood	'},
		{'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_stone',
	recipe = {
		{'default:cobble', 'default:cobble'},
		{'default:stick', 'default:cobble'},
		{'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'default:axe_steel',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot'},
		{'default:stick', 'default:steel_ingot'},
		{'default:stick', ''},
	}
})

-- Tool repair buff (15% bonus instead of 2%)

minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.15,
})

-- Crafting

minetest.register_craft({
	output = 'default:stick 1',
	recipe = {
		{'node "default:dry_shrub"'},
	}
})

minetest.register_craft({
	output = 'default:sandstone 1',
	recipe = {
		{'default:desert_sand', 'default:desert_sand'},
		{'default:desert_sand', 'default:desert_sand'},
	}
})

minetest.register_craft({
	output = 'default:dirt_with_grass 1',
	recipe = {
		{'node "default:junglegrass"'},
		{'node "default:dirt"'},
	}
})

minetest.register_craft({
	output = 'default:dirt_with_grass 1',
	recipe = {
		{'node "default:mese"'},
		{'node "default:dirt"'},
	}
})

minetest.register_craft({
	output = 'default:mossycobble 1',
	recipe = {
		{'node "default:junglegrass"'},
		{'node "default:cobble"'},
	}
})

minetest.register_craft({
	output = 'default:mossycobble 1',
	recipe = {
		{'node "default:mese"'},
		{'node "default:cobble"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:junglewood" 4',
	recipe = {
		{'node "jungletree"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:junglestick" 4',
	recipe = {
		{'node "moreblocks:junglewood"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:fence_junglewood" 2',
	recipe = {
		{'node "moreblocks:junglestick"', 'node "moreblocks:junglestick"', 'node "moreblocks:junglestick"'},
		{'node "moreblocks:junglestick"', 'node "moreblocks:junglestick"', 'node "moreblocks:junglestick"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:stonebrick" 4',
	recipe = {
		{'node "stone"', 'node "stone"'},
		{'node "stone"', 'node "stone"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:circlestonebrick" 8',
	recipe = {
		{'node "stone"', 'node "stone"', 'node "stone"'},
		{'node "stone"', '', 'node "stone"'},
		{'node "stone"', 'node "stone"', 'node "stone"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:allfacestree" 8',
	recipe = {
		{'node "tree"', 'node "tree"', 'node "tree"'},
		{'node "tree"', '', 'node "tree"'},
		{'node "tree"', 'node "tree"', 'node "tree"'},
	}
})

minetest.register_craft({
	output = 'craft "moreblocks:sweeper" 3',
	recipe = {
		{'node "junglegrass"'},
		{'craft "Stick"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:stonesquare" 4',
	recipe = {
		{'node "cobble"', 'node "cobble"'},
		{'node "cobble"', 'node "cobble"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:splitstonesquare" 1',
	recipe = {
		{'node "moreblocks:stonesquare"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:emptybookshelf" 1',
	recipe = {
		{'craft "moreblocks:sweeper"'},
		{'node "default:bookshelf"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:ironstonebrick" 1',
	recipe = {
		{'craft "default:steel_ingot"'},
		{'node "moreblocks:stonebrick"'},
	}
})

minetest.register_craft({
	output = 'node "default:wood" 4',
	recipe = {
		{'node "moreblocks:horizontaltree"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:junglewood" 4',
	recipe = {
		{'node "moreblocks:horizontaljungletree"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:plankstone" 4',
	recipe = {
		{'node "cobble"', 'node "cobble"'},
		{'node "wood"', 'node "wood"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:plankstone" 4',
	recipe = {
		{'node "wood', 'node "stone"'},
		{'node "stone"', 'node "wood"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:coalchecker" 4',
	recipe = {
		{'node "stone"', 'craft "lump_of_coal"'},
		{'craft "lump_of_coal"', 'node "stone"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:coalchecker" 4',
	recipe = {
		{'craft "lump_of_coal"', 'node "stone"'},
		{'node "stone"', 'craft "lump_of_coal"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:ironchecker" 4',
	recipe = {
		{'craft "steel_ingot"', 'node "stone"'},
		{'node "stone"', 'craft "steel_ingot"'},
	}
})

minetest.register_craft({
	output = 'node "default:chest_locked" 1',
	recipe = {
		{'craft "steel_ingot"'},
		{'node "chest"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:ironchecker" 4',
	recipe = {
		{'node "stone"', 'craft "steel_ingot"'},
		{'craft "steel_ingot"', 'node "stone"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:ironglass" 1',
	recipe = {
		{'craft "steel_ingot"'},
		{'node "glass"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:coalglass" 1',
	recipe = {
		{'craft "lump_of_coal"'},
		{'node "glass"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:cleanglass" 1',
	recipe = {
		{'craft "moreblocks:sweeper'},
		{'node "glass"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:glowglass" 1',
	recipe = {
		{'node "torch"'},
		{'node "glass"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:superglowglass" 1',
	recipe = {
		{'node "torch"'},
		{'node "torch"'},
		{'node "glass"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:coalstone" 1',
	recipe = {
		{'craft "lump_of_coal"'},
		{'node "stone"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:trapstone" 12',
	recipe = {
		{'node "mese"'},
		{'node "stone"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:trapglass" 12',
	recipe = {
		{'node "mese"'},
		{'node "glass"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:ironstone" 1',
	recipe = {
		{'craft "steel_ingot"'},
		{'node "stone"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:cactusbrick" 1',
	recipe = {
		{'node "cactus"'},
		{'node "brick"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:cactuschecker" 4',
	recipe = {
		{'node "cactus"', 'node "stone"'},
		{'node "stone"', 'node "cactus"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:cactuschecker" 4',
	recipe = {
		{'node "stone"', 'node "cactus"'},
		{'node "cactus"', 'node "stone"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:oerkkiblock" 9',
	recipe = {
		{'craft "lump_of_iron', 'craft "lump_of_coal"', 'craft "lump_of_iron"'},
		{'craft "lump_of_coal"', 'node "bookshelf"', 'craft "lump_of_coal"'},
		{'craft "lump_of_iron', 'craft "lump_of_coal"', 'craft "lump_of_iron"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:oerkkiblock" 9',
	recipe = {
		{'craft "lump_of_coal', 'craft "lump_of_iron"', 'craft "lump_of_coal"'},
		{'craft "lump_of_iron"', 'node "bookshelf"', 'craft "lump_of_iron"'},
		{'craft "lump_of_coal"', 'craft "lump_of_iron"', 'craft "lump_of_coal"'},
	}
})

minetest.register_craft({
	output = 'node "sapling" 1',
	recipe = {
		{'node "leaves"', 'node "leaves"', 'node "leaves"'},
		{'node "leaves"', 'node "leaves"', 'node "leaves"'},
		{'', 'craft "Stick"', ''},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:rope" 1',
	recipe = {
		{'node "leaves"'},
		{'node "leaves"'},
		{'node "leaves"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:rope" 1',
	recipe = {
		{'node "leaves"'},
		{'node "junglegrass"'},
		{'node "leaves"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:rope" 1',
	recipe = {
		{'node "junglegrass"'},
		{'node "junglegrass"'},
		{'node "junglegrass"'},
	}
})

minetest.register_craft({
	output = 'craft "steel_ingot" 9',
	recipe = {
		{'node "default:steelblock"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:horizontaltree" 2',
	recipe = {
		{'node "tree"', 'node "tree"'},
	}
})

minetest.register_craft({
	output = 'node "tree" 2',
	recipe = {
		{'node "moreblocks:horizontaltree"'},
		{'node "moreblocks:horizontaltree"'},
	}
})

minetest.register_craft({
	output = 'node "moreblocks:horizontaljungletree" 2',
	recipe = {
		{'node "jungletree"', 'node "jungletree"'},
	}
})

minetest.register_craft({
	output = 'node "jungletree" 2',
	recipe = {
		{'node "moreblocks:horizontaljungletree"'},
		{'node "moreblocks:horizontaljungletree"'},
	}
})

-- Blocks

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