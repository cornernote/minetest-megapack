-- Irontree

minetest.register_node("irontrees:irontree", {
    description = "Irontree",
    tiles = { "irontrees_irontree_top.png", "irontrees_irontree_top.png", "irontrees_irontree.png" },
    is_ground_content = true,
    groups = { choppy = 2, tree = 1 },
    sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("irontrees:iron_leaves", {
    description = "Irontree leaves",
    tiles = { "irontrees_iron_leaves.png" },
    is_ground_content = true,
    groups = { snappy = 3, leafdecay = 3 },
    paramtype = "light",
    drawtype = "allfaces_optional",
    sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft({
    output = 'irontrees:irontree 1',
    recipe = {
        { 'default:iron_lump 1' },
        { 'default:tree 1' },
    }
})

minetest.register_craft({
    type = "cooking",
    output = "default:iron_lump",
    recipe = "irontrees:irontree",
    cooktime = 4,
})

minetest.register_craft({
    output = 'default:iron_lump',
    recipe = {
	{ 'irontrees:iron_leaves 1', 'irontrees:iron_leaves 1', 'irontrees:iron_leaves 1' },
	{ 'irontrees:iron_leaves 1', 'irontrees:iron_leaves 1', 'irontrees:iron_leaves 1' },
	{ 'irontrees:iron_leaves 1', 'irontrees:iron_leaves 1', 'irontrees:iron_leaves 1' },
    }
})

local modpath = minetest.get_modpath("irontrees")
dofile(modpath .. "/growing.lua")
dofile(modpath .. "/saplings.lua")
