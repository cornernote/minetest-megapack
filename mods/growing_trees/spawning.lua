-------------------------------------------------------------------------------
-- Growing Trees Mod by Sapier
-- 
-- License GPLv3
--
--! @file spawning.lua
--! @brief contains spawn algorithm on mapgen
--! mod
--! @copyright Sapier
--! @author Sapier
--! @date 2012-09-04
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

local minimum_tree_distance = 50

function MIN(a,b)
    if a > b then
        return b
    else
        return a
    end
end

function MAX(a,b)
    if a > b then 
        return a
    else
        return b
    end
end


--add trees on generation
minetest.register_on_generated(function(minp, maxp, seed)

    local min_x = MIN(minp.x,maxp.x)
    local min_y = MIN(minp.y,maxp.x)
    local min_z = MIN(minp.z,maxp.z)
    
    local max_x = MAX(minp.x,maxp.x)
    local max_y = MAX(minp.y,maxp.y)
    local max_z = MAX(minp.z,maxp.z)
    
    
    local xdivs = math.floor(((max_x - min_x) / minimum_tree_distance) +1)
    local zdivs = math.floor(((max_z - min_z) / minimum_tree_distance) +1)
    
    --print(min_x .. " " .. max_x .. " # " .. min_z .. " " .. max_z)
    --print("Generating in " .. xdivs .. " | " .. zdivs .. " chunks")
    
    for i = 0, xdivs do
    for j = 0, zdivs do
    
        local x_center = min_x + 0.5 * minimum_tree_distance + minimum_tree_distance * i
        local z_center = min_z + 0.5 * minimum_tree_distance + minimum_tree_distance * i
        
        --check if there is already a growing tree within area
        local trunkpos = minetest.env:find_node_near({ x=x_center,
                                                        y=growing_trees_get_surface(x_center,z_center,min_y,max_y),
                                                        z=z_center},
                                                        minimum_tree_distance/2, {"growing_trees:trunk"})
                                                      
        --randomly try to place new growing tree in area
        if not trunkpos then
            for i= 0, 5 do
                local x_try = math.random(minimum_tree_distance/-2,minimum_tree_distance/2)
                local z_try = math.random(minimum_tree_distance/-2,minimum_tree_distance/2)
                
                local pos = { x= x_center + x_try,
                               z= z_center+z_try }
                
                local surface = growing_trees_get_surface(pos.x,pos.z,min_y,max_y)
                
                if surface then
                    local spawnpos = {x=pos.x,y=surface+1,z=pos.z}
                    --print("Growing_Trees: found surface " .. printpos(spawnpos) .. " try: " .. i)
                    
                    local to_near = minetest.env:find_node_near(spawnpos,4,{"default:tree", "growing_trees:trunk"})
                    local near_enough = minetest.env:find_node_near(spawnpos,8,"default:tree")
                    
                    --print(dump(to_near) .. " | " .. dump(near_enough))
                    
                    if not to_near and
                        near_enough ~= nil then
                       if growing_trees_place_sprout(spawnpos) then
                                growing_trees_debug("info","Growing_Trees: Tree growing at " .. printpos(spawnpos))
                                break
                       end
                    end
                else
                    --print("Growing_Trees: didn't find surface for " .. printpos(pos))
                end
            end
        else
            --print("Growing_Trees: found growing tree at: " .. trunkpos)
        end

    end --for i
    end --for j
    
end
)