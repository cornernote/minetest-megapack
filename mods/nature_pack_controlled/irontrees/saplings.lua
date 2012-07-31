local SAPLING_GROW_DELAY = 9600
local SAPLING_GROW_CHANCE = 10,

-- Iron sapling
minetest.register_node("irontrees:iron_sapling", {
    description = "Irontree sapling",
    is_ground_content = true,
    groups = { snappy = 3 },
    tiles = { "irontrees_iron_sapling.png" },
    drawtype = "plantlike",
    paramtype = "light",
    sunlight_propagates = true;
    sounds = default.node_sound_leaves_defaults(),
})

-- Grow irontrees on the ground

spawn_on_surfaces(
    3600,
    "irontrees:iron_sapling",
    30,
    3,
    "default:dirt_with_grass",
    "irontrees:iron_sapling"
)

-- Growing ABM
minetest.register_abm({
    nodenames = { "irontrees:iron_sapling" },
    interval = SAPLING_GROW_TIME,
    chance = SAPLING_GROW_CHANCE,

    action = function(pos, _, _, _)
	minetest.env:remove_node(pos)
	grow_iron_tree(pos)
    end
})
