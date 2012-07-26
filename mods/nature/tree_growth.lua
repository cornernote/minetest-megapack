-- Tree growing

dofile(minetest.get_modpath("nature") .. "/trees.lua")

local ABM_DELAY = 9600

local TREE_GROW_DELAY = ABM_DELAY
local DENSITY = 3 -- allow <number> trunks in the radius
local MINIMUM_LIGHT = 8 -- light needed for the trees to grow

local ABM_CHANCE = 40

minetest.register_abm({
    nodenames = { "default:leaves" },
    interval = TREE_GROW_DELAY,
    chance = ABM_CHANCE,

    action = function(pos, node, active_object_count, active_object_count_wider)
        if(minetest.env:get_node_light(pos, nil) < MINIMUM_LIGHT) then
            return
        end

        local trunk_count = 0
        local jungle_trunk_count = 0
        
        -- Check for trunks in area
        for i = -1, 1 do
        for j = -1, -1 do
        for k = -1, 1 do
            local current_node = {
                x = pos.x + i,
                y = pos.y + j,
                z = pos.z + k
            }
            if(math.abs(i) + math.abs(j) + math.abs(k) == 1) then
                if(minetest.env:get_node(current_node).name == "default:tree") then
                trunk_count = trunk_count + 1
                elseif(minetest.env:get_node(current_node).name ==
                "default:jungletree") then
                    jungle_trunk_count = jungle_trunk_count + 1
                end
            end
        end
        end
        end

        local all_trunks = trunk_count + jungle_trunk_count
        
        -- If there is at least 1 trunk and there are not many of them...
        if (all_trunks > 0) and (all_trunks < DENSITY) then
            minetest.env:remove_node(pos)
            if(math.random(1, all_trunks) <= trunk_count) then
                minetest.env:add_node(pos, {name = "default:tree"})
            else
                minetest.env:add_node(pos, {name = "default:jungletree"})
            end
            print ('[nature] A trunk has grown at (' .. pos.x .. ',' .. pos.y .. ',' .. pos.z .. ')')
            for i = -1, 1 do
            for j = -1, 1 do
            for k = -1, 1 do
                local current_node = {
                    x = pos.x + i,
                    y = pos.y + j,
                    z = pos.z + k
                }
                if(minetest.env:get_node(current_node).name == "air") then
                    minetest.env:add_node(current_node, {name = "default:leaves"})
                end
            end
            end
            end
        end
    end
})
