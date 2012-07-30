-- Papyrus growing

local PAPYRUS_GROW_CHANCE = 10

minetest.register_abm({
    nodenames = { "default:papyrus" },
    interval = 1200,
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
-- maximum hieght for growth, checks whats under the current node
	   local aboveMax = {  -- Added by Nubelite
		x = pos.x,  	-- Added by Nubelite
		y = pos.y - 5,  -- Added by Nubelite
		z = pos.z, 	 -- Added by Nubelite
	    }
        if(minetest.env:get_node(above).name == "air")
	    and (minetest.env:get_node(aboveMax).name ~= "default:papyrus") then  -- Added by Nubelite
            minetest.env:add_node(above, {name = "default:papyrus"})
            minetest.log('[nature] A papyrus has grown at (' .. above.x .. ',' .. above.y .. ',' .. above.z .. ')')
        end
    end
})
