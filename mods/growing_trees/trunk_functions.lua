
function growing_trees_get_trunk_below(pos) 

	local pos_below = {x=pos.x,y=pos.y-1,z=pos.z} 

	local node_below = minetest.env:get_node(pos_below)

	if node_below.name == "growing_trees:trunk" then
		return pos_below
	end
	
	for x = pos.x - 1, pos.x + 1 do
		for z = pos.z - 1, pos.z + 1 do
			n = minetest.env:get_node_or_nil({x = x, y = pos.y-1, z = z})
			if (n ~= nil)
				and (n.name ~= 'ignore')
				and ("growing_trees:trunk" == n.name) then
				return {x = x, y = pos.y-1, z = z}
			end
		end
	end

	return nil
end


function growing_trees_get_trunk_above(pos) 

	local pos_below = {x=pos.x,y=pos.y+1,z=pos.z} 

	local node_below = minetest.env:get_node(pos_below)

	if node_below.name == "growing_trees:trunk" then
		return pos_below
	end
	
	for x = pos.x - 1, pos.x + 1 do
		for z = pos.z - 1, pos.z + 1 do
			n = minetest.env:get_node_or_nil({x = x, y = pos.y+1, z = z})
			if (n ~= nil)
				and (n.name ~= 'ignore')
				and ("growing_trees:trunk" == n.name) then
				return {x = x, y = pos.y+1, z = z}
			end
		end
	end

	return nil
end


function growing_trees_get_tree_size(pos)

	local node = minetest.env:get_node(pos)
	
	if (node.name ~= "growing_trees:trunk") then
		return 0
	end
	
	local size=0
	
	local runnode = node;
	local runpos = pos;
	
	while runpos ~= nil and runnode.name == "growing_trees:trunk" do
		size = size+1;
	
		runpos = growing_trees_get_trunk_above(runpos)
		
		if (runpos ~= nil) then
			runnode = minetest.env:get_node(runpos)
		end
	end
	
	runpos = growing_trees_get_trunk_below(pos) 
	
	if runpos ~= nil then
		runnode = minetest.env:get_node(runpos)
	end
	
	while runpos ~= nil and runnode.name == "growing_trees:trunk" do
		size = size+1;
	
		runpos = growing_trees_get_trunk_below(runpos)
		
		if (runpos ~= nil) then
			runnode = minetest.env:get_node(runpos)
		end
	end
	
	return size
end


function growing_trees_get_random_next_to(pos)

	if math.random() < 0.5 then
		if math.random() < 0.5 then
			return {x=pos.x,y=pos.y,z=pos.z+1}
		else
			return {x=pos.x,y=pos.y,z=pos.z-1}
		end
	else
		if math.random() < 0.5 then
			return {x=pos.x+1,y=pos.y,z=pos.z}
		else
			return {x=pos.x-1,y=pos.y,z=pos.z}
		end
	end
end