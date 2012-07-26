-- Papyrus growing

local PAPYRUS_GROW_CHANCE = 20

minetest.register_abm({
    nodenames = { "default:papyrus" },
    interval = 3600,
    chance = PAPYRUS_GROW_CHANCE,

    action = function(pos, node, active_object_count, active_object_count_wider)
        if (minetest.env:get_node_light(pos, nil) < 6) then
            return
        end

        local under = {
            x = pos.x,
            y = pos.y - 1,
            z = pos.z
        }
        
	-- Grow up
        local above = {
            x = pos.x,
            y = pos.y + 1,
            z = pos.z
        }
        if(minetest.env:get_node(above).name == "air") then
            minetest.env:add_node(above, {name = "default:papyrus"})
            minetest.log('[nature] A papyrus has grown at (' .. above.x .. ',' .. above.y .. ',' .. above.z .. ')')
        end
    end
})
