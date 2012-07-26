-- Crafting
minetest.register_craft({
	output = 'node "coalmod:coalblock" 1',
	recipe = {
		{'craft "default:lump_of_coal"', 'craft "default:lump_of_coal"', 'craft "default:lump_of_coal"'},
		{'craft "default:lump_of_coal"', 'craft "default:lump_of_coal"', 'craft "default:lump_of_coal"'},
		{'craft "default:lump_of_coal"', 'craft "default:lump_of_coal"', 'craft "default:lump_of_coal"'},
	}
})
minetest.register_craft({
	output = 'craft "default:lump_of_coal" 9',
	recipe = {
		{'node "coalmod:coalblock"'},
	}
})
minetest.register_craft({
	output = 'ToolItem "coalmod:CoalPick" 1',
	recipe = {
		{'craft "default:lump_of_coal"', 'craft "default:lump_of_coal"', 'craft "default:lump_of_coal"'},
		{'', 'craft "default:Stick"', ''},
		{'', 'craft "default:Stick"', ''},
	}
})
minetest.register_craft({
	output = 'ToolItem "coalmod:CoalShovel" 1',
	recipe = {
		{'craft "default:lump_of_coal"'},
		{'craft "default:Stick"'},
		{'craft "default:Stick"'},
	}
})
minetest.register_craft({
	output = 'ToolItem "coalmod:CoalAxe" 1',
	recipe = {
		{'craft "default:lump_of_coal"', 'craft "default:lump_of_coal"'},
		{'craft "default:lump_of_coal"', 'craft "default:"'},
		{'', 'craft "default:Stick"'},
	}
})
minetest.register_craft({
	output = 'ToolItem "coalmod:CoalSword" 1',
	recipe = {
		{'craft "default:lump_of_coal"'},
		{'craft "default:lump_of_coal"'},
		{'craft "default:Stick"'},
	}
})
-- Blocks
minetest.register_node("coalmod:coalblock", {
	tiles = {"block_coalblock.png"},
	inventory_image = minetest.inventorycube("block_coalblock.png"),
	is_ground_content = true,
	material = minetest.digprop_stonelike(5.0),
})
-- Tools
minetest.register_tool("coalmod:CoalPick", {
	image = "tool_coalpick.png",
	basetime = 1.0,
	dt_weight = 0,
	dt_crackiness = -0.5,
	dt_crumbliness = 2,
	dt_cuttability = 0,
	basedurability = 333,
	dd_weight = 0,
	dd_crackiness = 0,
	dd_crumbliness = 0,
	dd_cuttability = 0,
})
minetest.register_tool("coalmod:CoalShovel", {
	image = "tool_coalshovel.png",
	basetime = 1.0,
	dt_weight = 0.5,
	dt_crackiness = 2,
	dt_crumbliness = -1.5,
	dt_cuttability = 0.0,
	basedurability = 330,
	dd_weight = 0,
	dd_crackiness = 0,
	dd_crumbliness = 0,
	dd_cuttability = 0,
})
minetest.register_tool("coalmod:CoalAxe", {
	image = "tool_coalaxe.png",
	basetime = 1.0,
	dt_weight = 0.5,
	dt_crackiness = -0.2,
	dt_crumbliness = 1,
	dt_cuttability = -0.5,
	basedurability = 330,
	dd_weight = 0,
	dd_crackiness = 0,
	dd_crumbliness = 0,
	dd_cuttability = 0,
})
minetest.register_tool("coalmod:CoalSword", {
	image = "tool_coalsword.png",
	basetime = 2.0,
	dt_weight = 3,
	dt_crackiness = 0,
	dt_crumbliness = 1,
	dt_cuttability = -1,
	basedurability = 330,
	dd_weight = 0,
	dd_crackiness = 0,
	dd_crumbliness = 0,
	dd_cuttability = 0,
})
print("[CoalMod by sfan5] Loaded!" )