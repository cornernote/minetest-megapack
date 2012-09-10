-------------------------------------------------------------------------------
-- Growing Trees Mod by Sapier
-- 
-- License GPLv3
--
--! @file model_selection.lua
--! @brief file containing functions for detecting which model to use
--! mod
--! @copyright Sapier
--! @author Sapier
--! @date 2012-09-04
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

function growing_trees_get_branch_type(pos)

    local pos_xp1 = {x=pos.x+1,y=pos.y,z=pos.z}
    local pos_xm1 = {x=pos.x-1,y=pos.y,z=pos.z}
    local pos_zp1 = {x=pos.x,y=pos.y,z=pos.z+1}
    local pos_zm1 = {x=pos.x,y=pos.y,z=pos.z-1}
    
    local xp1 = growing_trees_is_tree_structure(pos_xp1)
    local xm1 = growing_trees_is_tree_structure(pos_xm1)
    local zp1 = growing_trees_is_tree_structure(pos_zp1)
    local zm1 = growing_trees_is_tree_structure(pos_zm1)
    
    
    if (not zm1) and 
       (not zp1) and 
       (xp1 or xm1) then
       return "xx"
    end
    
    if (not xm1) and 
       (not xp1) and 
       (zp1 or zm1) then
       return "zz"
    end
    
    if (not xm1) and
       (not zm1) and
       xp1 and
       zp1 then
       return "xpzp"
    end
    
    if (not xp1) and
       (not zp1) and
       xm1 and
       zm1 then
       return "xmzm"
    end
    
    if (not xp1) and
       (not zm1) and
       xm1 and
       zp1 then
       return "xmzp"
    end
    
    if (not xm1) and
       (not zp1) and
       xp1 and
       zm1 then
       return "xpzm"
    end
    
    

    return "ukn"
end