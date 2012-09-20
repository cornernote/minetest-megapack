-------------------------------------------------------------------------------
-- Growing Trees Mod by Sapier
-- 
-- License GPLv3
--
--! @file abms.lua
--! @brief file containing abms doing growing
--! mod
--! @copyright Sapier
--! @author Sapier
--! @date 2012-09-04
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
--
-- grow trunk abm
--
-------------------------------------------------------------------------------
minetest.register_abm({
        nodenames = { "growing_trees:trunk_sprout" },
        interval = 30,
        chance = 5,
        action = function(pos, node, active_object_count, active_object_count_wider)

            growing_trees_debug("verbose","Growing_Trees: trunk_sprout ABM###################")
            
            local trunktop = growing_trees_get_trunk_below(pos)
            
            if trunktop == nil then
                growing_trees_debug("error","Growing_Trees: sprout not ontop of tree")
                return
            end
            
            local treesize,tree_root = growing_trees_get_tree_size(trunktop)
            
            if treesize > (SLOWDOWN_TREE_GROWTH_SIZE + ((MAX_TREE_SIZE - SLOWDOWN_TREE_GROWTH_SIZE)/2)) then
                local root_node = minetest.env:get_node(tree_root)
                growing_trees_debug("verbose","Growing_Trees: Tree should have big trunk does it have? " .. root_node.name)
                if root_node ~= nil and
                    root_node.name ~= "growing_trees:big_trunk" then
                   
                   growing_trees_make_trunk_big(tree_root,SLOWDOWN_TREE_GROWTH_SIZE)
                end
            end
            
            --print("Treesize: " .. treesize)
            if (treesize > MAX_TREE_SIZE) then
                minetest.env:remove_node(pos)
                minetest.env:add_node(pos,{type=node,name="growing_trees:trunk_top"})
                growing_trees_debug("info","Growing_Trees: maximum tree size reached")
                return
            end
            
            --reduce growing speed for trees larger then 10
            if (treesize > SLOWDOWN_TREE_GROWTH_SIZE ) then
                if math.random() > 1/treesize then
                	growing_trees_debug("info","Growing_Trees: not growing due to reduced growth speed")
                    return
                end
            end
            local grown = false

            if math.random() > 0.2 then
                --print("growing straight")
                local pos_above = {x= pos.x,y=pos.y+1,z=pos.z}
                
                local node_above = minetest.env:get_node(pos_above)
                
                if node_above.name == "air" or
                    growing_trees_node_is_type(leaves_type,node_above.name) then
                    
                    minetest.env:remove_node(pos)
                    minetest.env:add_node(pos,{type=node,name="growing_trees:trunk"})
                    minetest.env:add_node(pos_above,{type=node,name="growing_trees:trunk_sprout"})
                
                    grown = true
                end
            end
            
            if not grown then
                if growing_trees_next_to(pos,trunk_static_type) == false then
                    --print("growing horizontaly")
                    --decide which direction to grow trunk
                    local pos_to_grow_to = growing_trees_get_random_next_to(pos)
                    local node_at_pos_to_grow = minetest.env:get_node(pos_to_grow_to)
    
                    --check if pos is feasable
                    if node_at_pos_to_grow.name == "air" or
                        growing_trees_node_is_type(leaves_type,node_at_pos_to_grow.name) then
                    
	                    minetest.env:remove_node(pos)
	                    minetest.env:add_node(pos,{type=node,name="growing_trees:trunk"})
	                    
	                    minetest.env:add_node(pos_to_grow_to,{type=node,name="growing_trees:trunk_sprout"})
	                    
	                    grown = true
	                end
                else
                    growing_trees_debug("verbose","Not growing horizontaly twice")
                end
            end
			growing_trees_debug("verbose","Growing_Trees: trunk_sprout ABM*******************")
        end
    })
    

-------------------------------------------------------------------------------
--
-- create branch abm
--
-------------------------------------------------------------------------------
minetest.register_abm({
        nodenames = trunk_static_type,
        interval = 15,
        chance = 5,
        
        action = function(pos, node, active_object_count, active_object_count_wider)
            	growing_trees_debug("verbose","Growing_Trees: branch_add ABM###################")
            
                local treesize,tree_root = growing_trees_get_tree_size(pos)
                
                --don't add branches to trees to small
                if treesize < 4 then
                	growing_trees_debug("verbose","Growing_Trees: branch_abm ABM*******************")
                    return
                end
                
                local growpos = growing_trees_get_random_next_to(pos)
                local node_at_pos = minetest.env:get_node(pos)
                
                if growing_trees_is_tree_structure(growpos) == false and
                    ( node_at_pos.name == "air" or 
                      growing_trees_node_is_type(leaves_type,node_at_pos.name)) then
                
                    local distance       = growing_trees_min_distance(growpos)
                    local next_to_branch = growing_trees_next_to_branch(growpos,nil)
                    --print("branch sprout add function, distance to ground: " .. distance)
                    
                    if distance > 2 and
                         next_to_branch == false then
                        minetest.env:remove_node(growpos)
                        minetest.env:add_node(growpos,{type=node,name="growing_trees:branch_sprout"})
                    else
                        growing_trees_debug("verbose","Growing_Trees: NOT adding branch: " .. distance ..  " ntb: " .. dump(next_to_branch) )
                    end
                else
                    growing_trees_debug("info","unable to get valid growpos for branch")
                end
                
                growing_trees_debug("verbose","Growing_Trees: branch_add ABM********************")
        end
    })

-------------------------------------------------------------------------------
--
-- grow branch abm
--
-------------------------------------------------------------------------------
minetest.register_abm({
        nodenames = { "growing_trees:branch_sprout" },
        interval = 60,
        chance = 5,
        
        action = function(pos, node, active_object_count, active_object_count_wider)
        	growing_trees_debug("verbose","Growing_Trees: branch_sprout ABM###################")
            local growpos = growing_trees_get_branch_growpos(pos)
            
            if growpos == nil then
            	growing_trees_debug("verbose","Growing_Trees: no growpos found next to " .. dump(pos))
            	return
            end
            local node_at_pos = minetest.env:get_node(growpos)
            growing_trees_debug("verbose","Growing_Trees: fetching growpos information: " .. printpos(growpos) .. " -> " .. node_at_pos.name)
            local tree_structure = growing_trees_is_tree_structure(growpos)
            local next_to_branch = growing_trees_next_to_branch(growpos,pos)
            
            growing_trees_debug("verbose","Growing_Trees: evaluating growpos information " .. dump(tree_structure) .. " " .. dump(next_to_branch))
            if  tree_structure == false and
                next_to_branch == false and
                ( node_at_pos.name == "air" or 
                  growing_trees_node_is_type(leaves_type,node_at_pos.name)) then
                growing_trees_debug("verbose","valid growing pos found:" .. printpos(growpos) .. " -> " .. node_at_pos.name )
                
                local branch = {}
                local distance_from_trunk,treesize,tree_root = growing_trees_get_tree_information(pos,branch)
                
                if treesize == 0 or
                	tree_root == nil then
                	growing_trees_debug("info","Growing_Trees: unable to get tree information")
                	return
                end
                
                local top_distance = (tree_root.y + treesize) - pos.y
                --print ("Treesize: " .. treesize .. " Distance: " .. distance_from_trunk)
                
                if (top_distance < 0) then
                    growing_trees_debug("error","Growing_Trees: top_distance calculation wrong")
                    top_distance = treesize
                end
                growing_trees_debug("verbose","Growing_Trees: Tree information treesize: " .. treesize .. 
                                                " distance from trunk: " .. distance_from_trunk .. 
                                                " distance to top: " .. top_distance .. " root_pos: " .. printpos(tree_root))
                
                if (treesize > MAX_TREE_SIZE) then
                    growing_trees_debug("info","Growing_Trees: branch maximum tree size reached")
                    if math.random() < 0.1 then
                        growing_trees_debug("info","Growing_Trees: aborting branch growth")
                        minetest.env:remove_node(pos)
                        minetest.env:add_node(pos,{type=node,name="growing_trees:leaves"})
                        return
                    end
                end
                
                if treesize ~= 0 and
                    distance_from_trunk < treesize/4 and
                    ((top_distance > treesize/8) or (distance_from_trunk < top_distance)) 
                    then
                    growing_trees_debug("info","Growing_Trees: growing branch to " .. printpos(growpos))
                    
                    minetest.env:remove_node(growpos)
                    minetest.env:add_node(growpos,{type=node,name="growing_trees:branch_sprout"})

                    growing_trees_place_branch(pos)
                end
            else
                --TODO check why this happens
                growing_trees_debug("info","Growing_Trees: Position " .. printpos(growpos) .. " invalid to grow branch to ts: " .. dump(tree_structure) .. " ntb: " ..dump(next_to_branch))
            end
            
            growing_trees_debug("verbose","Growing_Trees: branch_sprout ABM*******************")
        end
        })

-------------------------------------------------------------------------------
--
-- remove leaves abm
--
-------------------------------------------------------------------------------
minetest.register_abm({
        nodenames = { "growing_trees:leaves" },
        interval = 10,
        chance = 2,
        
        action = function(pos, node, active_object_count, active_object_count_wider)
        
                if math.random() < 0.3 then 
                    minetest.env:remove_node(pos)
                end
            end
            
        })

-------------------------------------------------------------------------------
--
-- grow leaves abms
--
-------------------------------------------------------------------------------
minetest.register_abm({
        nodenames = { "growing_trees:trunk_sprout" },
        interval = 5,
        chance = 2,
        action = function(pos, node, active_object_count, active_object_count_wider)
             growing_trees_grow_sprout_leaves(pos)
        end
        })

minetest.register_abm({
        nodenames = branch_static_type,
        interval = 5,
        chance = 2,
        action = function(pos, node, active_object_count, active_object_count_wider)
                growing_trees_grow_leaves(pos)
            end
            
        })