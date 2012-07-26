minetest.register_on_generated(function(minp, maxp)
    for x = minp.x, maxp.x do
        for z = minp.z, maxp.z do
            for ly = minp.y, maxp.y do
                local y = maxp.y + minp.y - ly
		if minetest.env:get_node({x = x, y = y, z = z}).name == "default:dirt_with_grass" then
			local i = math.random(1,555)
			if minetest.env:get_node({x = x, y = y + 1, z = z}).name == "air" then
					if i == 4 or i == 5 or i == 6 then
					minetest.env:add_node({x = x, y = y + 1, z = z}, {name="default:leaves"})
					end
			end
		end
	    end
        end
    end
end
)
