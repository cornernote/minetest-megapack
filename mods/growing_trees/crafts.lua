-------------------------------------------------------------------------------
-- Growing Trees Mod by Sapier
-- 
-- License GPLv3
--
--! @file crafts.lua
--! @brief file containing craft recieps and item definitions
--! mod
--! @copyright Sapier
--! @author Sapier
--! @date 2012-09-04
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

function growing_trees_place_sprout(pos)
    local pos_above = {x=pos.x,y=pos.y+1,z=pos.z}
    local node = minetest.env:get_node(pos)
    local node_above = minetest.env:get_node(pos_above)

    if node.name == "air" and
        node_above.name == "air" then
        local pos_bottom = { x=pos.x,y=pos.y-1,z=pos.z }

        local bottom_node = minetest.env:get_node(pos_bottom)

        if bottom_node.name == "default:dirt" or
             bottom_node.name == "default:dirt_with_grass" then

            minetest.env:add_node(pos,{type=node,name="growing_trees:trunk"})
            minetest.env:add_node(pos_above,{type=node,name="growing_trees:trunk_sprout"})
            growing_trees_grow_sprout_leaves(pos_above)
            return true
        end
    end
    return false
end


minetest.register_craftitem("growing_trees:sapling", {
        description = "Sapling (growing tree mod)",
        image = "default_sapling.png",
        on_place = function(item,place,pointed_thing)
            if pointed_thing.type == "node" then
                local pos = pointed_thing.above
                if growing_trees_place_sprout(pos) then
                    item:take_item(1)
                end
            end

            return item
        end
    })


minetest.register_craft({
    output = "growing_trees:sapling",
    recipe = {
        {"default:sapling"},
        {"default:sapling"},
    }
})