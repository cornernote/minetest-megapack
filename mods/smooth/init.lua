

--To add a new smooth node you have to define the node also

--the node that will be checked for corresponding BOTTOM_NODE
local NODE = { 
    "default:dirt",
    "default:dirt_with_grass",
    "default:cobble",
    "default:wood",
    "default:tree",
}

-- the node below it that will be replaced the NEW
local BOTTOM_NODE = {
    "default:stone",
    "default:stone",
    "default:stone",
    "default:dirt",
    "default:dirt"
}

-- the node to which it will change
local NEW = {
    "smooth:dirt_stone",
    "smooth:dirt_stone",
    "smooth:cobble_stone",
    "smooth:wood_grass",
    "smooth:tree_grass",
}

local TOP = {
    "false",
    "false",
    "false",
    "true",
    "true",
}

--register abm for node changes
for i, node in ipairs(NODE) do
    minetest.register_abm(
    {nodenames = {NODE[i]},
    interval = 30,
    chance = 3,
    action = function(pos)
        
        local bottom = {x=pos.x, y=pos.y-1, z=pos.z}

        local node = minetest.env:get_node(bottom)
        
        if (node.name==BOTTOM_NODE[i]) then
            if TOP[i] == "false" then
                minetest.env:remove_node(bottom)
                minetest.env:add_node(bottom, {name=NEW[i]})
            else
                minetest.env:remove_node(pos)
                minetest.env:add_node(pos, {name=NEW[i]})
            end
        end
    end})
end

--fix previous mods

minetest.register_alias("dirtystone:dirty_stone", "smooth:dirt_stone")
minetest.register_alias("dirtystone:cobbly_stone", "smooth:cobble_stone")

--define the NEW nodes
minetest.register_node("smooth:dirt_stone", {
	description = "Stone",
	tile_images = {"smooth_dirt_stone" .. "_top.png", "default_stone.png", "default_stone.png^" .. "smooth_dirt_stone" .. ".png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'default:cobble',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("smooth:cobble_stone", {
	description = "Stone",
	tile_images = {"smooth_cobble_stone" .. "_top.png", "default_stone.png", "default_stone.png^" .. "smooth_cobble_stone" .. ".png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'default:cobble',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("smooth:wood_grass", {
	description = "Wood",
	tile_images = {"default_wood.png", "default_wood.png", "default_wood.png^smooth_grass.png"},
	is_ground_content = true,
	drop = 'default:wood',
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("smooth:tree_grass", {
	description = "Tree",
	tile_images = {"default_tree_top.png", "default_tree_top.png", "default_tree.png^smooth_grass.png"},
	is_ground_content = true,
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	drop = 'default:tree',
})
