-------------------------------------------------------------------------------
-- Growing Trees Mod by Sapier
-- 
-- License GPLv3
--
--! @file type_declarations.lua
--! @brief file containing node to type mappings
--! @copyright Sapier
--! @author Sapier
--! @date 2012-09-04
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

branch_type = {
            "growing_trees:branch",
            "growing_trees:branch_ukn",
            "growing_trees:branch_zz",
            "growing_trees:branch_xx",
            "growing_trees:branch_xpzp",
            "growing_trees:branch_xpzm",
            "growing_trees:branch_xmzp",
            "growing_trees:branch_xmzm",
            "growing_trees:branch_sprout",
            }
            
branch_static_type = {
            "growing_trees:branch",
            "growing_trees:branch_ukn",
            "growing_trees:branch_zz",
            "growing_trees:branch_xx",
            "growing_trees:branch_xpzp",
            "growing_trees:branch_xpzm",
            "growing_trees:branch_xmzp",
            "growing_trees:branch_xmzm",
}
            
trunk_type = {
            "growing_trees:trunk_top",
			"growing_trees:trunk",
			"growing_trees:medium_trunk",
			"growing_trees:big_trunk",
			"growing_trees:trunk_sprout"
}

trunk_static_type = {
			"growing_trees:trunk",
			"growing_trees:medium_trunk",
			"growing_trees:big_trunk",
}

leaves_type = {
			"growing_tree:leaves"
}

-------------------------------------------------------------------------------
-- name: growing_trees_node_is_type(table_to_check,name)
--
-- @brief check if a table contains a specific element
--
-- @param table_to_check table or string to search in
-- @param name name to search
-- @return true/false
-------------------------------------------------------------------------------
function growing_trees_node_is_type(type_declaration,name)
    if type(type_declaration) == "table" then
        for i,v in ipairs(type_declaration) do
            if v == name then
                return true
            end
        end
    end    
    return false
end

-------------------------------------------------------------------------------
-- name: growing_trees_pos_is_type(table_to_check,name)
--
-- @brief check if a table contains a specific element
--
-- @param table_to_check table or string to search in
-- @param name name to search
-- @return true/false
-------------------------------------------------------------------------------
function growing_trees_pos_is_type(type_declaration,pos)
	local node = minetest.env:get_node(pos)
	
	if node ~= nil then
		if type(type_declaration) == "table" then
			for i,v in ipairs(type_declaration) do
				
				if v == node.name then
					return true
				end
			end
		end
	end
	return false
end