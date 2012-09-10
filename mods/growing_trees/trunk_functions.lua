
--find a trunk node exactly one level below current position
--with a distance of at most 1
function growing_trees_get_trunk_below(pos) 

	local pos_below = {x=pos.x,y=pos.y-1,z=pos.z}

	if growing_trees_pos_is_type(trunk_static_type,pos_below) then
		return pos_below
	end
	
	for x = pos.x - 1, pos.x + 1 do
		for z = pos.z - 1, pos.z + 1 do
            local runpos = {x = x, y = pos.y-1, z = z}
            if growing_trees_pos_is_type(trunk_static_type,runpos) then
                return runpos
            end
		end
	end

	return nil
end


--find a trunk node exactly above pos with 
--distance at most one
function growing_trees_get_trunk_above(pos) 

	local pos_above = {x=pos.x,y=pos.y+1,z=pos.z}

	if growing_trees_pos_is_type(trunk_static_type,pos_above) then
		return pos_above
	end
	
	for x = pos.x - 1, pos.x + 1 do
		for z = pos.z - 1, pos.z + 1 do
		    local runpos = {x = x, y = pos.y+1, z = z}
			if growing_trees_pos_is_type(trunk_static_type,runpos) then
				return runpos
			end
		end
	end

	return nil
end

--calculate size of trunk pos is element of in blocks
function growing_trees_get_tree_size(pos)

	local node = minetest.env:get_node(pos)
	local root = pos
	
	if not growing_trees_pos_is_type(trunk_static_type,pos) then
		return 0
	end
	
	local size=0
	
	local runpos = pos;
	
	while runpos ~= nil and 
	   growing_trees_pos_is_type(trunk_static_type,runpos) do
		size = size+1;
	
		runpos = growing_trees_get_trunk_above(runpos)
	end
	
	runpos = growing_trees_get_trunk_below(pos) 
	
	if runpos ~= nil then
	    root = runpos
	end
	
	while runpos ~= nil and 
	   growing_trees_pos_is_type(trunk_static_type,runpos) do
		size = size+1;
	
		runpos = growing_trees_get_trunk_below(runpos)
		
		if (runpos ~= nil) then
		    root = runpos
		end
	end
	
	return size,root
end


-------------------------------------------------------------------------------
-- name: growing_trees_get_random_next_to(pos)
--
--! @brief get a random position next to pos at same height level
--
--! @param pos start searching around pos
--! @return pos to grow to
-------------------------------------------------------------------------------
function growing_trees_get_random_next_to(pos)

	local dirs = {
			{x= 1, z= 0},
			{x= 0, z= 1},
			{x=-1, z= 0},
			{x= 0, z=-1}	
	}
	
	local dir = dirs[math.random(1,#dirs)]

	return {x=pos.x+dir.x,y=pos.y,z=pos.z+dir.z}
end

-------------------------------------------------------------------------------
-- name: growing_trees_make_trunk_big(root,height)
--
--! @brief replace trunk by big trunk
--
--! @param root position to start
--! @param height heigth to replace
-------------------------------------------------------------------------------
function growing_trees_make_trunk_big(root,height)
    growing_trees_debug("error","Growing_Trees: replacing small trunk at: " .. printpos(root))
    local ymax = root.y+height
    
    local runy = root.y
    local current_pos = root
    
    while runy <  (ymax - (height/2)) and
        current_pos ~= nil do
        minetest.env:remove_node(current_pos)
        minetest.env:add_node(current_pos,{type=node,name="growing_trees:big_trunk"})
        
        local neighbour = growing_trees_next_to(current_pos, { "growing_trees:trunk" },false)
        
        if neighbour ~= nil then
            minetest.env:remove_node(neighbour)
            minetest.env:add_node(neighbour,{type=node,name="growing_trees:big_trunk"})
            current_pos = neighbour
        end
        
        current_pos = growing_trees_get_trunk_above(current_pos)
        
        runy = runy + 1
    end
    
    while runy <  ymax and
        current_pos ~= nil do
        minetest.env:remove_node(current_pos)
        minetest.env:add_node(current_pos,{type=node,name="growing_trees:medium_trunk"})
        
        local neighbour = growing_trees_next_to(current_pos, { "growing_trees:trunk" },false)
        
        if neighbour ~= nil then
            minetest.env:remove_node(neighbour)
            minetest.env:add_node(neighbour,{type=node,name="growing_trees:medium_trunk"})
            current_pos = neighbour
        end
        
        current_pos = growing_trees_get_trunk_above(current_pos)
        
        runy = runy + 1
    end
    
end