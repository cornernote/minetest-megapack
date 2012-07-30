local BUSHES = {
    "strawberry",
}

local BUSHES_DESCRIPTIONS = {
    "Strawberry",
}

-- Grow junglegrass
grow_blocks_on_surfaces(3600, {
    "default:junglegrass",
}, {
    { name = "default:dirt_with_grass", chance = 3, spacing = 10 },
})

for i, bush_name in ipairs(BUSHES) do
    minetest.register_node("bushes:" .. bush_name .. "_bush", {
	description = BUSHES_DESCRIPTIONS[i] .. " bush",
	drawtype = "plantlike",
	visual_scale = 1.3,
	tiles = { "bushes_" .. bush_name .. "_bush.png" },
	inventory_image = "bushes_" .. bush_name .. "_bush.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	drop = 'bushes:' .. bush_name .. ' 4',
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
    })

    minetest.register_craftitem("bushes:" .. bush_name, {
	description = BUSHES_DESCRIPTIONS[i],
	inventory_image = "bushes_" .. bush_name .. ".png",
	stack_max = 99,
	on_use = minetest.item_eat(1),
    })

    minetest.register_craft({
	output = 'bushes:' .. bush_name .. '_bush',
	recipe = {
	    { 'bushes:' .. bush_name, 'bushes:' .. bush_name, 'bushes:' .. bush_name },
	    { 'bushes:' .. bush_name, 'bushes:' .. bush_name, 'bushes:' .. bush_name },
	}
    })

    grow_blocks_on_surfaces(3600, {
	"bushes:" .. bush_name .. "_bush",
    }, {
	{ name = "default:dirt_with_grass", chance = 2, spacing = 15 },
    })
end

dofile(minetest.get_modpath('bushes') .. '/cooking.lua')
