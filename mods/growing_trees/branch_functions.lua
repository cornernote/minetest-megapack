-------------------------------------------------------------------------------
-- Growing Trees Mod by Sapier
-- 
-- License GPLv3
--
--! @file branch_functions.lua
--! @brief contains any branch related function used by growing trees mod
--! @copyright Sapier
--! @author Sapier
--! @date 2012-09-04
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- name: growing_trees_min_distance(pos)
--
--! @brief get minimum "free" space up and down for a specific pos
--
--! @param pos position to check
--! @return minimum number of free nodes
-------------------------------------------------------------------------------
function growing_trees_min_distance(pos)

	local runpos = {x=pos.x,y=pos.y-1,z=pos.z}

	local runnode = minetest.env:get_node(runpos)

	local distance_down = 0

	while runnode ~= nil and (
	       runnode.name == "air" or
	       growing_trees_node_is_type(leaves_type,runnode.name)) do
		distance_down = distance_down +1
		runpos = {x=runpos.x,y=runpos.y-1,z=runpos.z}
		runnode = minetest.env:get_node(runpos)
	end
	
	
	local distance_up = 0
	
	runpos = {x=pos.x,y=pos.y+1,z=pos.z}
	runnode = minetest.env:get_node(runpos)
	
	while runnode ~= nil and (
           runnode.name == "air" or
           growing_trees_node_is_type(leaves_type,runnode.name)) do
		distance_up = distance_up +1
		runpos = {x=runpos.x,y=runpos.y+1,z=runpos.z}
		runnode = minetest.env:get_node(runpos)
	end

	if (distance_down < distance_up) then
		return distance_down
	else
		return distance_up
	end
end

-------------------------------------------------------------------------------
-- name: growing_trees_next_to_branch(pos,origin)
--
--! @brief check if position is next to another branch
--
--! @param pos position to check
--! @param origin not to consider
--! @return true/false
-------------------------------------------------------------------------------
function growing_trees_next_to_branch(pos,origin)

	local node_at_pos = minetest.env:get_node(pos)	
	growing_trees_debug("verbose","Growing_Trees: looking for branch next to  " .. dump(pos) .. " type is " .. dump(node_at_pos.name))
	
	if origin ~= nil then
		local node_origin = minetest.env:get_node(origin)
		growing_trees_debug("verbose","Growing_Trees: found branch origin at  " .. dump(origin) .. " type is " .. dump(node_origin.name))
	end
	
	local neighbourpos = growing_trees_neighbour_positions(pos,true)
	
	for i,value in ipairs(neighbourpos) do
		if (growing_trees_pos_is_type(branch_type,value)) and 
			not issamepos(value,origin) then
			return true
		else
			local node = minetest.env:get_node(value)
			growing_trees_debug("verbose","Growing_Trees: node at  " .. printpos(value) .. " of type " .. node.name .. " didn't match")
		end
	end
	
	growing_trees_debug("info","Growing_Trees: not found another branch next to  " .. printpos(pos))
	return false
end

-------------------------------------------------------------------------------
-- name: growing_trees_next_to(pos,tolookfor,ytoo)
--
--! @brief find out if a pos is next to a element of type "tolookfor" 
--
--! @param pos position to check
--! @param tolookfor table of node types to look for
--! @param ytoo consider y direction too
--! @return position of neighbouring element or nil
-------------------------------------------------------------------------------
function growing_trees_next_to(pos,tolookfor,ytoo)

	growing_trees_debug("verbose","Growing_Trees: looking for type at pos " .. printpos(pos) .. " try-y: " ..dump(ytoo) )

	if pos == nil then
		growing_trees_debug("error","Growing_Trees: growing_trees_next_to trying to look for at nil pos")
	end

	local neighbourpos = growing_trees_neighbour_positions(pos,ytoo)
	
	for i,value in ipairs(neighbourpos) do
		if (growing_trees_pos_is_type(tolookfor,value)) then
			return value
		else
			local node = minetest.env:get_node(value)
			growing_trees_debug("verbose","Growing_Trees: node at  " .. printpos(value) .. " of type " .. node.name .. " didn't match")
		end
	end
	
	growing_trees_debug("info","Growing_Trees: not found any of " .. dump(tolookfor) .. " next to " ..printpos(pos))
	return nil
end

-------------------------------------------------------------------------------
-- name: growing_get_branch_next_to(pos,branch)
--
-- @brief find next branch element not already known to be a branch element
--
-- @param position pos to check
-- @param branch table containing known branch positions
-- @return position of next branch element
-------------------------------------------------------------------------------
function growing_trees_get_next_new_branch_element(pos,branch)

	if pos == nil then
		growing_trees_debug("error","Growing_Trees: growing_trees_get_next_new_branch_element trying to look for at nil pos")
	end
	
	local neighbourpos = growing_trees_neighbour_positions(pos,ytoo)
	for i,value in ipairs(neighbourpos) do
		if not contains(branch,value) and
			growing_trees_pos_is_type(branch_static_type,value) then
			growing_trees_debug("verbose","Growing_Trees: found branch element at " .. printpos(value) .. " next to " ..printpos(pos))
			return value
		end
	end
	
	growing_trees_debug("info","Growing_Trees: not found another branch element next to " ..printpos(pos))
	return nil
end

-------------------------------------------------------------------------------
-- name: growing_trees_get_tree_information(pos)
--
-- @brief get information about tree starting evaluation from branch sprout
--
-- @param pos start tree evaluation
-- @return branch_length,trunk height,root of trunk
-------------------------------------------------------------------------------
function growing_trees_get_tree_information(pos)

	local distance = 0
	local treesize = 0
	local tree_root = nil
	
	local branch = {}
	local current_pos = pos
	local nextpos = current_pos
	
	local node_at_start = minetest.env:get_node(pos)
	growing_trees_debug("verbose","Growing_Trees: fetching tree information starting at " .. printpos(pos) .. " -> " ..node_at_start.name)
	
	while nextpos ~= nil do
		distance = distance +1
		current_pos = nextpos
		nextpos = growing_trees_get_next_new_branch_element(current_pos,branch)
		table.insert(branch,nextpos)
	end
	
	growing_trees_debug("verbose","Growing_Trees: looking for trunk next to " .. printpos(current_pos))
	local pos_of_trunk = growing_trees_next_to(current_pos,trunk_static_type,false)
	
	if (pos_of_trunk ~= nil) then
		growing_trees_debug("verbose","Growing_Trees: fetching trunk information next to " .. printpos(pos_of_trunk))
		treesize,tree_root = growing_trees_get_tree_size(pos_of_trunk)
	else
		growing_trees_debug("error","Growing_Trees: trunk not found")
	end
	
	return distance,treesize,tree_root
end

-------------------------------------------------------------------------------
-- name: growing_trees_get_branch_growpos(pos)
--
--! @brief get a new branchpos next to current sprout
--
--! @param pos start searching around pos
--! @return pos to grow to
-------------------------------------------------------------------------------
function growing_trees_get_branch_growpos(pos)
	growing_trees_debug("info","Growing_Trees: trying to get growpos next to " .. printpos(pos))
	--grow to preferred direction
	if math.random() < 0.5 then
		local origin = growing_trees_next_to(pos,branch_type,true)
		
		if origin == nil then 
		    origin = growing_trees_next_to(pos,trunk_static_type,false)
		end
			
		if origin ~= nil then
		    growing_trees_debug("info","Growing_Trees: got origin for " .. printpos(pos) .. " at: " .. printpos(origin))
			if origin.x ~= pos.x then
				if origin.x < pos.x then
					return {x=pos.x+1,y=pos.y,z=pos.z}
				else
					return {x=pos.x-1,y=pos.y,z=pos.z}
				end
			end
			
			if origin.z ~= pos.z then
				if origin.z < pos.z then
					return {x=pos.x,y=pos.y,z=pos.z+1}
				else
					return {x=pos.x,y=pos.y,z=pos.z-1}
				end
			end
		else
		    --if origin couln't be found grow to random direction
		    growing_trees_debug("error","Growing_Trees: unable to find origin for branch at: " .. printpos(pos))
			return growing_trees_get_random_next_to(pos)
		end
	else
	    --grow to random direction
	    growing_trees_debug("verbose","Growing_Trees: random growpos selection around " .. printpos(pos))
		return growing_trees_get_random_next_to(pos)
	end

end

-------------------------------------------------------------------------------
-- name:  growing_trees_grow_leaves(pos)
--
--! @brief grow leaves around pos
--
--! @param pos center of growth
-------------------------------------------------------------------------------
function growing_trees_grow_leaves(pos)

	for x = pos.x - 1, pos.x + 1 do
	for y = pos.y - 1, pos.y + 1 do
	for z = pos.z - 1, pos.z + 1 do	
		local currentpos = {x = x, y = y, z = z}
		
		local current_node = minetest.env:get_node(currentpos)
		
		if current_node ~= nil and
			current_node.name == "air" then
			if growing_trees_next_to(currentpos,branch_type,true) ~= nil or
				growing_trees_next_to(currentpos,leaves_type,true) ~= nil and
				math.random() < 0.4 then
				if math.random() < 0.05 and
				   growing_trees_next_to(currentpos,{ "default:apple" },true) then
				   minetest.env:add_node(currentpos,{type="node",name="default:apple"})
				else
				   minetest.env:add_node(currentpos,{type="node",name="growing_trees:leaves"})
				end
			end
		end
	
	end
	end
	end

	for x = pos.x - 2, pos.x + 2 do
	for y = pos.y - 2, pos.y + 2 do
	for z = pos.z - 2, pos.z + 2 do	
		local currentpos = {x = x, y = y, z = z}
		
		local distance = growing_trees_calc_distance(pos,currentpos)
        
	        if distance <= 2 then
			if current_node ~= nil and
				current_node.name == "air" then
				
				if growing_trees_next_to(currentpos,branch_type,true) ~= nil or
					growing_trees_next_to(currentpos,leaves_type,true) ~= nil and 
					math.random() < 0.2 then
					minetest.env:add_node(currentpos,{type="node",name="growing_trees:leaves"})
				end
			end
		end	
	end
	end
	end

end

-------------------------------------------------------------------------------
-- name:  growing_trees_grow_sprout_leaves(pos)
--
--! @brief grow leaves around trunk sprout pos
--
--! @param pos center of growth
-------------------------------------------------------------------------------
function growing_trees_grow_sprout_leaves(pos)
	for x = pos.x - 1, pos.x + 1 do
	for y = pos.y - 1, pos.y + 1 do
	for z = pos.z - 1, pos.z + 1 do	
		local currentpos = {x = x, y = y, z = z}
		
		local distance = growing_trees_calc_distance(pos,currentpos)
        
        if distance <= 1.5 then
			local current_node = minetest.env:get_node(currentpos)
			
			if current_node ~= nil and
				current_node.name == "air" then
				
				if growing_trees_next_to(currentpos,trunk_type,true) ~= nil or
					growing_trees_next_to(currentpos,leaves_type,true) ~= nil and 
					math.random() < 0.3 then
					minetest.env:add_node(currentpos,{type="node",name="growing_trees:leaves"})
				end
			end
	   end
	end
	end
	end
	
	local treesize = growing_trees_get_tree_size({x=pos.x,y=pos.y-1,z=pos.z})
	
	if treesize > 2 and
	   treesize < 6 then
	   
	    for x = pos.x - 3, pos.x + 3 do
	    for y = pos.y - 3, pos.y + 3 do
	    for z = pos.z - 3, pos.z + 3 do 
	        local currentpos = {x = x, y = y, z = z}
	        local current_node = minetest.env:get_node(currentpos)
	        
	        if current_node ~= nil and
                    current_node.name == "air" then
	            local distance = growing_trees_calc_distance(pos,currentpos)
	            if distance <= 3 then
	                if growing_trees_next_to(currentpos,branch_type,true) ~= nil or
	                    growing_trees_next_to(currentpos,leaves_type,true) ~= nil and 
	                    math.random() < 0.2 then
	                    minetest.env:add_node(currentpos,{type="node",name="growing_trees:leaves"})
	                end
	            end
	        end 
	    end
	    end
	    end
	end
end

-------------------------------------------------------------------------------
-- name:  growing_trees_place_branch(pos)
--
--! @brief place correct branch type
--
--! @param pos to place branch
-------------------------------------------------------------------------------
function growing_trees_place_branch(pos)
    local branch_type = growing_trees_get_branch_type(pos)
                
    if branch_type == "xx" then
        minetest.env:remove_node(pos)
        minetest.env:add_node(pos,{type=node,name="growing_trees:branch_xx"})
    end
    
    if branch_type == "zz" then
        minetest.env:remove_node(pos)
        minetest.env:add_node(pos,{type=node,name="growing_trees:branch_zz"})
    end
    
    if branch_type == "xpzp" then
        minetest.env:remove_node(pos)
        minetest.env:add_node(pos,{type=node,name="growing_trees:branch_xpzp"})
    end
    
    if branch_type == "xpzm" then
        minetest.env:remove_node(pos)
        minetest.env:add_node(pos,{type=node,name="growing_trees:branch_xpzm"})
    end
    
    if branch_type == "xmzp" then
        minetest.env:remove_node(pos)
        minetest.env:add_node(pos,{type=node,name="growing_trees:branch_xmzp"})
    end
    
    if branch_type == "xmzm" then
        minetest.env:remove_node(pos)
        minetest.env:add_node(pos,{type=node,name="growing_trees:branch_xmzm"})
    end
end