-- Tree growing

dofile(minetest.get_modpath("nature") .. "/trees.lua")

local ABM_DELAY = 7200
local ABM_CHANCE = 1

local TREE_GROW_DELAY = ABM_DELAY
local DENSITY = 3 -- allow <number> trunks in the radius
local MINIMUM_LIGHT = 0 -- light needed for the trees to grow
local maxHeight = 15  -- Max height of a tree, this can varry on the tree growth pattern and its surroundings

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
	 local aboveMax = {
		x = pos.x,  		
		y = pos.y - maxHeight, 	 
		z = pos.z, 	 	
	   	}
	 local nodeunder = {
		x = pos.x,  		
		y = pos.y - 1, 	 
		z = pos.z, 	 	
	   	}
	local grandom = math.random(8) -- Added by Nubelite
	local prandom = math.random(-1,1)
	local growpos
	local growposunder

        if (all_trunks > 0) and (all_trunks < DENSITY)
	and (minetest.env:get_node(nodeunder).name == "default:tree"
	or minetest.env:get_node(nodeunder).name == "default:jungletree")
	and minetest.env:get_node(aboveMax).name ~= "air" 
	and minetest.env:get_node(aboveMax).name ~= "default:tree"  -- Added by Nubelite
	and minetest.env:get_node(aboveMax).name ~= "default:jungletree" then   -- Added by Nubelite then
          --  minetest.env:remove_node(pos)
            if(math.random(1, all_trunks) <= trunk_count) then
		if grandom <= 4 then -- Added by Nubelite
                minetest.env:add_node(pos, {name = "default:tree"})
		else if grandom <= 6 then -- Added by Nubelite
		 growpos = {  
		x = pos.x + prandom,  		
		y = pos.y, 	 
		z = pos.z, 
	   	}
		 growposunder = { 
		x = pos.x + prandom,
		y = pos.y - 1,
		z = pos.z,
	   	}
                minetest.env:add_node(growposunder, {name = "default:tree"})
		minetest.env:add_node(growpos, {name = "default:tree"})
		else
		 growpos = {  
		x = pos.x,  		
		y = pos.y, 	 
		z = pos.z + prandom, 
	   	}
		 growposunder = { 
		x = pos.x,
		y = pos.y - 1,
		z = pos.z + prandom,
	   	}
                minetest.env:add_node(growposunder, {name = "default:tree"})
		minetest.env:add_node(growpos, {name = "default:tree"})
		end
		end
            else
		if grandom <= 4 then -- Added by Nubelite
                minetest.env:add_node(pos, {name = "default:jungletree"})
		else if grandom <= 6 then -- Added by Nubelite
		 growpos = {  
		x = pos.x + prandom,  		
		y = pos.y, 	 
		z = pos.z, 
	   	}
		 growposunder = { 
		x = pos.x + prandom,
		y = pos.y - 1,
		z = pos.z,
	   	}
                minetest.env:add_node(growposunder, {name = "default:jungletree"})
		minetest.env:add_node(growpos, {name = "default:jungletree"})
		else
		 growpos = {  
		x = pos.x,  		
		y = pos.y, 	 
		z = pos.z + prandom, 
	   	}
		 growposunder = { 
		x = pos.x,
		y = pos.y - 1,
		z = pos.z + prandom,
	   	}
                minetest.env:add_node(growposunder, {name = "default:jungletree"})
		minetest.env:add_node(growpos, {name = "default:jungletree"})
		end
		end
		


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
-- maximum hieght for growth, checks whats under the current node
                if(minetest.env:get_node(current_node).name == "air") then
                    minetest.env:add_node(current_node, {name = "default:leaves"})
                end
            end
            end
            end
        end
    end
})
