local ABM_DELAY = 3600

local TREE_GROW_DELAY = ABM_DELAY -- 2 hrs
local DENSITY = 3 -- allow 3 trunks in one 'cross'
local MINIMUM_LIGHT = 8 -- light needed for the trees to grow
local maxTrue = 0 -- Added by Nubelite
local ABM_CHANCE = 20
local maxHeight = 10  -- Max height of a tree, this can varry on the tree growth pattern and its surroundings

minetest.register_abm({
    nodenames = { "irontrees:iron_leaves" },
    interval = TREE_GROW_DELAY,
    chance = ABM_CHANCE,

    action = function(pos, node, active_object_count, active_object_count_wider)
	maxTrue = 0
        if (minetest.env:get_node_light(pos, nil) < MINIMUM_LIGHT) then
            return
        end

        local trunk_count = 0
        
        -- Check for trunks in area
        for i = -1, 1 do
        for j = -1, -1 do
        for k = -1, 1 do
            local current_node = {
                x = pos.x + i,
                y = pos.y + j,
                z = pos.z + k
            }
-- maximum hieght for growth, checks whats under the current node
	    local aboveMax = { -- Added by Nubelite
		x = pos.x,	-- Added by Nubelite
		y = pos.y - maxHeight,	-- Added by Nubelite
		z = pos.z,	-- Added by Nubelite
	    }
            if(math.abs(i) + math.abs(j) + math.abs(k) == 1) then
                if(minetest.env:get_node(current_node).name == "irontrees:irontree")
		and (minetest.env:get_node(aboveMax).name ~= "irontrees:irontree") then-- Added by Nubelite
                trunk_count = trunk_count + 1 else
		maxTrue = 1	-- Added by Nubelite
                end
		
            end
        end
        end
        end

        -- If there is at least 1 trunk and there are not many of them...
        if (trunk_count > 0) and (trunk_count < DENSITY) 
	and (maxTrue == 0) then	-- Added by Nubelite
	    grow_iron_tree(pos)
        end
    end
}) 

function grow_iron_tree(pos)
    minetest.env:remove_node(pos)
    minetest.env:add_node(pos, {name = "irontrees:irontree"})
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
	    minetest.env:add_node(current_node, {name = "irontrees:iron_leaves"})
	end
    end
    end
    end    
end
