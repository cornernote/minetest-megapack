--[[
****
More Blocks
by Calinou
Version 12.05.28
****
--]]

-- Crafting

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
	tiles = {"moreblocks_junglewood.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:stonebrick", {
	description = "Stone Bricks",
	tiles = {"moreblocks_stonebrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:circlestonebrick", {
	description = "Circle Stone Bricks",
	tiles = {"moreblocks_circlestonebrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:ironstonebrick", {
	description = "Iron Stone Bricks",
	tiles = {"moreblocks_ironstonebrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:stonesquare", {
	description = "Stonesquare",
	tiles = {"moreblocks_stonesquare.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:plankstone", {
	description = "Plankstone",
	tiles = {"moreblocks_plankstone.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:ironglass", {
	description = "Iron Glass",
	drawtype = "glasslike",
	tiles = {"moreblocks_ironglass.png"},
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
	tiles = {"moreblocks_coalglass.png"},
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
	tiles = {"moreblocks_cleanglass.png"},
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})


minetest.register_node("moreblocks:cactusbrick", {
	description = "Cactus Brick",
	tiles = {"moreblocks_cactusbrick.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:cactuschecker", {
	description = "Cactus Checker",
	tiles = {"moreblocks_cactuschecker.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:emptybookshelf", {
	description = "Empty Bookshelf",
	tiles = {"default_wood.png", "default_wood.png", "moreblocks_emptybookshelf.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=3,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("moreblocks:oerkkiblock", {
	description = "Oerkki Block",
	tiles = {"moreblocks_oerkkiblock.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:coalstone", {
	description = "Coalstone",
	tiles = {"moreblocks_coalstone.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:ironstone", {
	description = "Ironstone",
	tiles = {"moreblocks_ironstone.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:coalchecker", {
	description = "Coalchecker",
	tiles = {"moreblocks_coalchecker.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:ironchecker", {
	description = "Ironchecker",
	tiles = {"moreblocks_ironchecker.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:trapstone", {
	description = "Trapstone",
	tiles = {"moreblocks_trapstone.png"},
	walkable = false,
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("moreblocks:trapglass", {
	description = "Trapglass",
	drawtype = "glasslike",
	tiles = {"moreblocks_trapglass.png"},
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
	tiles = {"moreblocks_junglewood.png"},
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
	tiles = {"default_tree.png", "default_tree.png", "moreblocks_horizontaltree.png",
		"moreblocks_horizontaltree.png", "default_tree_top.png", "default_tree_top.png"},
	paramtype2 = "facedir",
	groups = {tree=1,snappy=2,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	furnace_burntime = 30,
})

minetest.register_node("moreblocks:horizontaljungletree", {
	description = "Horizontal Jungletree",
	tiles = {"default_jungletree.png", "default_jungletree.png", "moreblocks_horizontaljungletree.png",
		"moreblocks_horizontaljungletree.png", "default_jungletree_top.png", "default_jungletree_top.png"},
	paramtype2 = "facedir",
	groups = {tree=1,snappy=2,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	furnace_burntime = 30,
})

minetest.register_node("moreblocks:allfacestree", {
	description = "All-faces Tree",
	tiles = {"default_tree_top.png"},
	groups = {tree=1,snappy=2,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	furnace_burntime = 30,
})

minetest.register_node("moreblocks:glowglass", {
	description = "Glowglass",
	drawtype = "glasslike",
	tiles = {"moreblocks_glowglass.png"},
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
	tiles = {"moreblocks_glowglass.png"},
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
	tiles = {"moreblocks_rope.png"},
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