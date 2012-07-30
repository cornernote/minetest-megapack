-- Cactus growing

local CACTUS_GROW_CHANCE = 15
local CACTUS_GROW_INDIV_CHANCE = 4
local CACTUS_MAX_DENSITY = 3

minetest.register_abm({
    nodenames = { "default:cactus" },
    interval = 3600,
    chance = CACTUS_GROW_CHANCE,
    
    action = function(pos, node, active_object_count, active_object_count_wider)
	-- Check for existing cacti in radius
	local cactus_count = 0
	for i = -1, 1 do
	for j = -1, 1 do
	for k = -1, 1 do
	    local new_pos = {
		x = pos.x + i,
		y = pos.y + j,
		z = pos.z + k,
	    }

	    local node_name = minetest.env:get_node(new_pos)
	    if node_name == "default:cactus" then
		cactus_count = cactus_count + 1
	    end
	end
	end
	end

	if cactus_count > CACTUS_MAX_DENSITY then
	    return
	end

        -- Grow with a chance (choosing which side to grow)
        for i = -1, 1 do
        for j = 0, 1 do
        for k = -1, 1 do
            if(math.abs(i) + math.abs(j) + math.abs(k) == 1) then
                if(math.random(1, 100) <= CACTUS_GROW_INDIV_CHANCE) then
                    local new_pos = {
                        x = pos.x + i,
                        y = pos.y + j,
                        z = pos.z + k
                    }
                    if(minetest.env:get_node(new_pos).name == "air") then
                        minetest.env:add_node(new_pos, {name = "default:cactus"})
                        minetest.log('[nature] A cactus has grown at (' .. new_pos.x .. ',' .. new_pos.y .. ',' .. new_pos.z .. ')')
                    end
                end
            end
        end
        end
        end
    end
})
