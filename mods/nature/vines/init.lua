-- Vines

local VINE_GROW_CHANCE = 5
local VINE_GROW_DELAY = 1200

-- Nodes
minetest.register_node("vines:vine", {
    description = "Vine",
    walkable = false,
    climbable = true,
    sunlight_propagates = true,
    paramtype = "light",
    tiles = { "vines_vine.png" },
    drawtype = "plantlike",
    inventory_image = "vines_vine.png",
    groups = { snappy = 3 },
    sounds =  default.node_sound_leaves_defaults(),
})

minetest.register_node("vines:vine_rotten", {
    description = "Rotten vine",
    walkable = false,
    climbable = false,
    sunlight_propagates = true,
    paramtype = "light",
    tiles = { "vines_vine_rotten.png" },
    drawtype = "plantlike",
    inventory_image = "vines_vine_rotten.png",
    groups = { snappy = 3 },
    sounds =  default.node_sound_leaves_defaults(),
})

-- ABMs (growing)
minetest.register_abm({
    nodenames = "vines:vine",
    interval = VINE_GROW_DELAY,
    chance = VINE_GROW_CHANCE,

    action = function(pos, node, _, _)
	local under = {
	    x = pos.x,
	    y = pos.y - 1,
	    z = pos.z,
	}
	local under_name = minetest.env:get_node(under).name

	if under_name ~= "vines:vine"
	and under_name ~= "default:dirt"
	and under_name ~= "default:dirt_with_grass" then
	    minetest.env:remove_node(pos)
	    minetest.env:add_node(pos, { name = "vines:vine_rotten" })
	else

	    if(minetest.env:get_node_light(pos, nil) < 4) then
		return
	    end
 
	    local above = {
		x = pos.x,
		y = pos.y + 1,
		z = pos.z,
	    }

	    if minetest.env:get_node(above).name == "air" then
		minetest.env:add_node(above, { name = "vines:vine" })
	    end
	end
    end
})

minetest.register_abm({
    nodenames = "vines:vine_rotten",
    interval = 1200,
    chance = VINE_ROT_CHANCE,

    action = function(pos, node, _, _)
	minetest.env:remove_node(pos)
	local under = {
	    x = pos.x,
	    y = pos.y - 1,
	    z = pos.z,
	}
	local under_name = minetest.env:get_node(under).name

	if under_name == "vines:vine"
	or under_name == "default:dirt"
	or under_name == "default:dirt_with_grass" then
	    minetest.env:add_node(pos, { name = "vines:vine" })
	end
    end
})

-- Growing on the ground
--
grow_blocks_on_surfaces(3600, {
    "vines:vine",
}, {
    { name = "default:dirt_with_grass", chance = 3, spacing = 15 },
})
