-- NODES
-- Bomb
minetest.register_node("morefire:bomb", {
    description = "Bomb",
    tiles = {
        "fire_bomb_top.png",
        "fire_bomb_bottom.png",
        "fire_bomb.png",
    },
    --[[
    inventory_image = minetest.inventorycube(
        "fire_bomb_top.png",
        "fire_bomb.png",
        "fire_bomb.png"
    ),
    ]]
    material = minetest.digprop_stonelike(1.0),
    --furnace_burntime = 20,
})

-- ENTITIES
-- Explosion
minetest.register_node("morefire:explosion", {
    drawtype = "plantlike",
    paramtype = "light",
    visual_scale = 0,
    buildable_to = false,
    tiles = { "fire_fire_transp.png" },
    is_ground_content = true,
    walkable = false,
    pointable = false,
    sunlight_propagates = true,
    post_effect_color = {a = 180, r = 255, g = 0, b = 0},
    material = minetest.digprop_leaveslike(1.0)
})

-- CRAFTS
-- Bomb
minetest.register_craft({
    output = 'morefire:bomb 1',
    recipe = {
        {'default:iron_lump', 'default:mese', 'default:iron_lump' },
        {'default:mese', 'default:coal_lump', 'default:mese' },
        {'default:iron_lump', 'default:mese', 'default:iron_lump' },
    }
})

minetest.register_craft({
    type = "fuel",
    recipe = "morefire:bomb",
    burntime = 20,
})

minetest.register_craft({
    type = "fuel",
    recipe = "morefire:explosion",
    burntime = 1,
})
