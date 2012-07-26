function growing_trees_min_distance(pos)

	local runpos = {x=pos.x,y=pos.y-1,z=pos.z}

	local runnode = minetest.env:get_node(runpos)

	local distance_down = 0

	while runnode ~= nil and runnode.name == "air" do
		distance_down = distance_down +1
		runpos = {x=runpos.x,y=runpos.y-1,z=runpos.z}
		runnode = minetest.env:get_node(runpos)
	end
	
	
	local distance_up = 0
	
	runpos = {x=pos.x,y=pos.y+1,z=pos.z}
	runnode = minetest.env:get_node(runpos)
	
	while runnode ~= nil and runnode.name == "air" do
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

function growing_trees_next_to_branch(pos,origin)
	local pos_node = minetest.env:get_node(pos)	
	
	--print("ntb -> pos " .. printpos(pos)..": "..pos_node.name)
	
	if origin ~= nil then
		local pos_origin = minetest.env:get_node(origin)
		--print("ntb -> origin" .. printpos(origin)..": "..pos_origin.name)
	end

	local xplus_pos = {x=pos.x+1,y=pos.y,z=pos.z}
	
	if issamepos(xplus_pos,origin) == false then
		local node_xplus = minetest.env:get_node(xplus_pos)
		--print("ntb -> x+ ".. printpos(xplus_pos) .. ": "..node_xplus.name)
		
		if node_xplus.name == "growing_trees:branch_sprout" or
			node_xplus.name == "growing_trees:branch" then
			return true
		end
	end

	local xminus_pos = {x=pos.x-1,y=pos.y,z=pos.z}
	
	if issamepos(xminus_pos,origin) == false then
		local node_xminus = minetest.env:get_node(xminus_pos)
		--print("ntb -> x- ".. printpos(xminus_pos) .. ": "..node_xminus.name)
		
		if node_xminus.name == "growing_trees:branch_sprout" or
			node_xminus.name == "growing_trees:branch" then
			return true
		end
	end
	
	local zplus_pos = {x=pos.x,y=pos.y,z=pos.z+1}
	
	if issamepos(zplus_pos,origin) == false then
		local node_zplus = minetest.env:get_node(zplus_pos)
		--print("ntb -> z+".. printpos(zplus_pos) .. ": "..node_zplus.name)
		
		if node_zplus.name == "growing_trees:branch_sprout" or
			node_zplus.name == "growing_trees:branch" then
			return true
		end
	end
	
	local zminus_pos = {x=pos.x,y=pos.y,z=pos.z-1}
	
	if issamepos(zminus_pos,origin) == false then
		local node_zminus = minetest.env:get_node(zminus_pos)
		--print("ntb -> z-".. printpos(zminus_pos) .. ": "..node_zminus.name)
		
		if node_zminus.name == "growing_trees:branch_sprout" or
			node_zminus.name == "growing_trees:branch" then
			return true
		end
	end
	
	local yplus_pos = {x=pos.x,y=pos.y+1,z=pos.z}
	
	if issamepos(yplus_pos,origin) == false then
		local node_yplus = minetest.env:get_node(yplus_pos)
		--print("ntb -> y+".. printpos(yplus_pos) .. ": "..node_yplus.name)
		
		if node_yplus.name == "growing_trees:branch_sprout" or
			node_yplus.name == "growing_trees:branch" then
			return true
		end
	end
	
	local yminus_pos = {x=pos.x,y=pos.y-1,z=pos.z}
	
	if issamepos(yminus_pos,origin) == false then
		local node_yminus = minetest.env:get_node(yminus_pos)
		--print("ntb -> y-".. printpos(yminus_pos) .. ": "..node_yminus.name)
		
		if node_yminus.name == "growing_trees:branch_sprout" or
			node_yminus.name == "growing_trees:branch" then
			return true
		end
	end
	
	--print("ntb -> return false")
	return false
end


function growing_get_trunk_next_to(pos)

	return growing_trees_next_to(pos,"growing_trees:trunk",false)
end


function growing_trees_next_to(pos,tolookfor,ytoo)
	local xplus_pos = {x=pos.x+1,y=pos.y,z=pos.z}	
	local node_xplus = minetest.env:get_node(xplus_pos)
	
	--print("x+: " ..node_xplus.name)
	if node_xplus.name == tolookfor then
		return xplus_pos
	end


	local xminus_pos = {x=pos.x-1,y=pos.y,z=pos.z}	
	local node_xminus = minetest.env:get_node(xminus_pos)
	
	--print("x-: " ..node_xminus.name)
	if node_xminus.name == tolookfor then
		return xminus_pos
	end
	

	local zplus_pos = {x=pos.x,y=pos.y,z=pos.z+1}
	local node_zplus = minetest.env:get_node(zplus_pos)
		
	--print("z+: " ..node_zplus.name)
	if node_zplus.name == tolookfor then
		return zplus_pos
	end
	
	
	local zminus_pos = {x=pos.x,y=pos.y,z=pos.z-1}
	local node_zminus = minetest.env:get_node(zminus_pos)
	
	--print("z-: " ..node_zminus.name)
	if node_zminus.name == tolookfor then
		return zminus_pos
	end
	
	if ytoo == true then
		local yplus_pos = {x=pos.x,y=pos.y+1,z=pos.z}
		local node_yplus = minetest.env:get_node(yplus_pos)
			
		--print("y+: " ..node_yplus.name)
		if node_zplus.name == tolookfor then
			return zplus_pos
		end
		
		
		local yminus_pos = {x=pos.x,y=pos.y-1,z=pos.z}
		local node_yminus = minetest.env:get_node(yminus_pos)
		
		--print("y-: " ..node_yminus.name)
		if node_yminus.name == tolookfor then
			return yminus_pos
		end
	
	end
	
	return nil
end

function growing_get_branch_next_to(pos,branch)
	for x = pos.x - 1, pos.x + 1 do
	for y = pos.y - 1, pos.y + 1 do
	for z = pos.z - 1, pos.z + 1 do	
		local currentpos = {x = x, y = y, z = z}
		
		--there may not be more than one difference to be a possible source for branch
		if (x ~= pos.x) and (y == pos.y) and (z == pos.z) or
			(x == pos.x) and (y ~= pos.y) and (z == pos.z) or
			(x == pos.x) and (y == pos.y) and (z ~= pos.z) then
		
			if contains(branch,currentpos) == false then
				n = minetest.env:get_node_or_nil({x = x, y = y, z = z})
				if (n ~= nil) then
					--print(printpos(currentpos).. "->" .. n.name)
					if (n.name ~= 'ignore')
						and ("growing_trees:branch" == n.name) then
						--print("Found branch at: " .. printpos(currentpos));
						return currentpos
					end
				end
			end
		end
	end
	end
	end
	--print("No branch found around:" .. printpos(pos) )
	return nil
end


function growing_trees_get_distance_from_trunk(pos,branch)

	local last_valid_pos = origin
	local current_pos = pos
	local distance = 0
	local nextpos = growing_get_branch_next_to(current_pos,branch)
	table.insert(branch,nextpos)
	local node = minetest.env:get_node(pos)
	
	--print("Find trunk from: " .. node.name);
	
	while nextpos ~= nil do
		distance = distance +1
		
		last_valid_pos = current_pos
		current_pos = nextpos		
		nextpos = growing_get_branch_next_to(current_pos,branch)
		table.insert(branch,nextpos)
	end
	
	local pos_of_trunk = growing_get_trunk_next_to(current_pos)
	
	local treesize = 0
	
	if (pos_of_trunk ~= nil) then
		treesize = growing_trees_get_tree_size(pos_of_trunk)
	else
		print("ERROR trunk not found")
	end
	
	return distance,treesize

end


function growing_trees_get_brach_growpos(pos)

	--grow to preferred direction
	if math.random() < 0.66 then
		local branch =  {}
		table.insert(branch,pos)
		local origin = growing_get_branch_next_to(pos,branch)
		
		if origin == nil then
			origin = growing_get_trunk_next_to(pos)
		end
			
		if origin ~= nil then	
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
			return growing_trees_get_random_next_to(pos)
		end
	else
		return growing_trees_get_random_next_to(pos)
	end

end


function growing_trees_grow_leaves(pos)

	for x = pos.x - 1, pos.x + 1 do
	for y = pos.y - 1, pos.y + 1 do
	for z = pos.z - 1, pos.z + 1 do	
		local currentpos = {x = x, y = y, z = z}
		
		local current_node = minetest.env:get_node(currentpos)
		
		if current_node ~= nil and
			current_node.name == "air" then
			
			if growing_trees_next_to(currentpos,"growing_trees:branch",true) ~= nil or
				growing_trees_next_to(currentpos,"growing_trees:leaves",true) ~= nil and 
				math.random() < 0.3 then					
				minetest.env:add_node(currentpos,{type="node",name="growing_trees:leaves"})
			end
		end
	
	end
	end
	end

	for x = pos.x - 2, pos.x + 2 do
	for y = pos.y - 2, pos.y + 2 do
	for z = pos.z - 2, pos.z + 2 do	
		local currentpos = {x = x, y = y, z = z}
		
		if current_node ~= nil and
			current_node.name == "air" then
			
			if growing_trees_next_to(currentpos,"growing_trees:branch",true) ~= nil or
				growing_trees_next_to(currentpos,"growing_trees:leaves",true) ~= nil and 
				math.random() < 0.2 then					
				minetest.env:add_node(currentpos,{type="node",name="growing_trees:leaves"})
			end
		end
	
	end
	end
	end

end


function growing_trees_grow_sprout_leaves(pos)
	for x = pos.x - 1, pos.x + 1 do
	for y = pos.y - 1, pos.y + 1 do
	for z = pos.z - 1, pos.z + 1 do	
		local currentpos = {x = x, y = y, z = z}
		
		local current_node = minetest.env:get_node(currentpos)
		
		if current_node ~= nil and
			current_node.name == "air" then
			
			if growing_trees_next_to(currentpos,"growing_trees:sprout",true) ~= nil or
				growing_trees_next_to(currentpos,"growing_trees:trunk",true) ~= nil or
				growing_trees_next_to(currentpos,"growing_trees:leaves",true) ~= nil and 
				math.random() < 0.3 then					
				minetest.env:add_node(currentpos,{type="node",name="growing_trees:leaves"})
			end
		end
	
	end
	end
	end

end