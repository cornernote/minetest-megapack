-------------------------------------------------------------------------------
-- name: printpos(pos)
--
-- action: convert pos to string of type "(X,Y,Z)"
--
-- param1: position to convert
-- retval: string with coordinates of pos
-------------------------------------------------------------------------------
function printpos(pos)
	if pos ~= nil then
		if pos.y ~= nil then
			return "("..pos.x..","..pos.y..","..pos.z..")"
		else
			return "("..pos.x..", ? ,"..pos.z..")"
		end
	end
	return ""
end


function issamepos(pos1,pos2) 
	
	if (pos1 == nil) or
		(pos2 == nil) and
		(pos1 ~= pos2) then
		return false
	end
	
	if (pos1.x == pos2.x) and
	   (pos1.y == pos2.y) and
	   (pos1.z == pos2.z) then
	   return true
	end
	
	return false
end


function contains(table_to_check,element) 
	for i,v in ipairs(table_to_check) do
		if issamepos(v,element) then
			return true
		end
	end
	
	return false

end


function growing_trees_is_tree_structure(pos)
	local node = minetest.env:get_node(pos)
	
	if node == nil then
		return false
	end
	
	if node.name == "growing_trees:trunk" or
		node.name == "growing_trees:branch" or
		node.name == "growing_trees:sprout" or
		node.name == "growing_trees:branch_sprout" then
		return true
	end
	
	return false
end