minetest.register_node("jungletree:sapling", {
	description = "jungletree sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"jungletree_sapling.png"},
	inventory_image = "jungletree_sapling.png",
	wield_image = "default_sapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3,flammable=2},

})

minetest.register_node("jungletree:tree", {
	description = "Tree",
	tiles = {"default_tree_top.png", "default_tree_top.png", "jungletree_bark.png"},
	is_ground_content = true,
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
})


local function add_tree_branch(pos)

    minetest.env:add_node(pos, {name="jungletree:tree"})

    for i = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do

        for k = math.floor(math.random(2)), -math.floor(math.random(2)), -1 do

            local p = {x=pos.x+i, y=pos.y, z=pos.z+k}
            local n = minetest.env:get_node(p)
            
            if (n.name=="air") then

                minetest.env:add_node(p, {name="default:leaves"})

            end
            
            local chance = math.abs(i+k)
            
            if (chance < 1) then

                p = {x=pos.x+i, y=pos.y+1, z=pos.z+k}
                n = minetest.env:get_node(p)

                if (n.name=="air") then
                    minetest.env:add_node(p, {name="default:leaves"})
                end

            end

        end

    end

end

minetest.register_abm({
    nodenames = {"jungletree:sapling"},
    interval = 10,
    chance = 1,
    action = function(pos, node)
        
        local height = 5 + math.random(15)
        
        if height < 10 then

            for i = height, -1, -1 do
                
                local p = {x=pos.x, y=pos.y+i, z=pos.z}
                minetest.env:add_node(p, {name="jungletree:tree"})
                
                if i == height then
                    
                    add_tree_branch({x=pos.x, y=pos.y+height+math.random(0, 1), z=pos.z})
                    
                    add_tree_branch({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z})
                    add_tree_branch({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z})
                    add_tree_branch({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1})
                    add_tree_branch({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1})
                
                end
                
                if height <= 0 then
                    minetest.env:add_node({x=pos.x+1, y=pos.y+i-math.random(2), z=pos.z}, {name="jungletree:tree"})
                    minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z+1}, {name="jungletree:tree"})
                    minetest.env:add_node({x=pos.x-1, y=pos.y+i-math.random(2), z=pos.z}, {name="jungletree:tree"})
                    minetest.env:add_node({x=pos.x, y=pos.y+i-math.random(2), z=pos.z-1}, {name="jungletree:tree"})
                end

                if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then
                    branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
                    add_tree_branch(branch_pos)
                end

            end

        else
        
            for i = height, -2, -1 do
                
                if (math.sin(i/height*i) < 0.2 and i > 3 and math.random(0,2) < 1.5) then

                    branch_pos = {x=pos.x+math.random(0,1), y=pos.y+i, z=pos.z-math.random(0,1)}
                    add_tree_branch(branch_pos)

                end

                if i < math.random(0,1) then

                    minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z+1}, {name="jungletree:tree"})
                    minetest.env:add_node({x=pos.x+2, y=pos.y+i, z=pos.z-1}, {name="jungletree:tree"})
                    minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-2}, {name="jungletree:tree"})
                    minetest.env:add_node({x=pos.x-1, y=pos.y+i, z=pos.z}, {name="jungletree:tree"})

                end

                if i == height then

                    add_tree_branch({x=pos.x+1, y=pos.y+i, z=pos.z+1})
                    add_tree_branch({x=pos.x+2, y=pos.y+i, z=pos.z-1})
                    add_tree_branch({x=pos.x, y=pos.y+i, z=pos.z-2})
                    add_tree_branch({x=pos.x-1, y=pos.y+i, z=pos.z})
                    
                    add_tree_branch({x=pos.x+1, y=pos.y+i, z=pos.z+2})
                    add_tree_branch({x=pos.x+3, y=pos.y+i, z=pos.z-1})
                    add_tree_branch({x=pos.x, y=pos.y+i, z=pos.z-3})
                    add_tree_branch({x=pos.x-2, y=pos.y+i, z=pos.z})
                    
                    add_tree_branch({x=pos.x+1, y=pos.y+i, z=pos.z})
                    add_tree_branch({x=pos.x+1, y=pos.y+i, z=pos.z-1})
                    add_tree_branch({x=pos.x, y=pos.y+i, z=pos.z-1})
                    add_tree_branch({x=pos.x, y=pos.y+i, z=pos.z})

                else

                    minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z}, {name="jungletree:tree"})
                    minetest.env:add_node({x=pos.x+1, y=pos.y+i, z=pos.z-1}, {name="jungletree:tree"})
                    minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z-1}, {name="jungletree:tree"})
                    minetest.env:add_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="jungletree:tree"})

                end

            end

        end

    end,
})

--function anti_generate(node, surfaces, minp, maxp, height_min, height_max, spread, habitat_size, habitat_nodes) 




minetest.register_on_generated(function(minp, maxp, seed)
     
     generate("jungletree:sapling", {"default:dirt_with_grass"}, minp, maxp, 0, 20, 10, 50, {"default:water_source"})
     
end)


