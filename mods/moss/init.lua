math.randomseed(os.time())

minetest.register_abm(
{nodenames = {"cobble"},
interval = 10,
chance = 30,
action = function(pos, node, active_object_count, active_object_count_wider)

near_air = false
        near_moss = false
        near_water = false
        for i=-1,1 do
            for j=-1,1 do
                for k=-1,1 do
                    p = {x=pos.x+i, y=pos.y+j, z=pos.z+k}
                    n = minetest.env:get_node(p)
                    if (n.name=="air") then
                        near_air = true
                    end
                    if (n.name=="default:mossycobble") then
                        near_moss = true
                    end
                    if (n.name=="default:water_flowing") or (n.name=="default:water_source") then
                        near_water = true
                    end
                end
            end
        end

    
        if (near_water) and (near_air) then
            if (math.random(0, 10)<1) then
                minetest.env:add_node(pos, {name="mossycobble"})
            end
        elseif (near_water) and (near_air) and (near_moss) then
            minetest.env:add_node(pos, {name="mossycobble"})
        end
end
})


