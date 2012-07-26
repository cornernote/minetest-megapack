--NODES

minetest.register_node("ivy:ivy", {
	description = "Ivy",
	drawtype = "plantlike",
	tiles = {"ivy_ivy.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {choppy=2,dig_immediate=2},
	legacy_wallmounted = true,
	drop = 'ivy:ivy',
})



--ABM

--SPREADING

minetest.register_abm(
        {nodenames = {"ivy:ivy"},
        interval = 30,
        chance = 100,
        action = function(pos)		
		
		local i = math.random(1,4)

		local pos_1 = {x = pos.x + i, y = pos.y, z = pos.z}
		local pos_1_dn = {x = pos.x + i, y = pos.y - 1, z = pos.z}
		local n_1 = minetest.env:get_node(pos_1)
		local n_1_dn = minetest.env:get_node(pos_1_dn)

		local pos_2 = {x = pos.x - i, y = pos.y, z = pos.z}
		local pos_2_dn = {x = pos.x - i, y = pos.y - 1, z = pos.z}
		local n_2 = minetest.env:get_node(pos_2)
		local n_2_dn = minetest.env:get_node(pos_2_dn)

		local pos_3 = {x = pos.x, y = pos.y, z = pos.z + i}
		local pos_3_dn = {x = pos.x, y = pos.y - 1, z = pos.z + i}
		local n_3 = minetest.env:get_node(pos_3)
		local n_3_dn = minetest.env:get_node(pos_3_dn)

		local pos_4 = {x = pos.x, y = pos.y, z = pos.z - i}
		local pos_4_dn = {x = pos.x, y = pos.y - 1, z = pos.z - i}
		local n_4 = minetest.env:get_node(pos_4)
		local n_4_dn = minetest.env:get_node(pos_4_dn)
		
		if i==1 then
			if n_1.name == "air" and n_1_dn.name == "default:dirt_with_grass" then
			minetest.env:add_node(pos_1, {name="ivy:ivy"})
			nodeupdate(pos_1)
			return true
			end
		end

		if i==2 then
			if n_2.name == "air" and n_2_dn.name == "default:dirt_with_grass" then
			minetest.env:add_node(pos_2, {name="ivy:ivy"})
			nodeupdate(pos_2)
			return true
			end
		end

		if i==3 then
			if n_3.name == "air" and n_4_dn.name == "default:dirt_with_grass" then
			minetest.env:add_node(pos_3, {name="ivy:ivy"})
			nodeupdate(pos_3)
			return true
			end
		end

		if i==4 then
			if n_4.name == "air" and n_4_dn.name == "default:dirt_with_grass" then
			minetest.env:add_node(pos_4, {name="ivy:ivy"})
			nodeupdate(pos_4)
			return true
			end
		end
        end,
})


--ROTTING

minetest.register_abm(
        {nodenames = {"ivy:ivy"},
        interval = 5,
        chance = 1,
        action = function(pos)
		if minetest.env:get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name ~= "default:dirt_with_grass" and 
		minetest.env:get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name ~= "ivy:ivy" then
		minetest.env:remove_node(pos)
		end

        end,
})


--GROWING

minetest.register_abm(
        {nodenames = {"ivy:ivy"},
        interval = 5,
        chance = 100,
        action = function(pos)
		
		pos_1 = {x = pos.x, y = pos.y - 1, z = pos.z}
		n_1 = minetest.env:get_node(pos_1)

		pos_2 = {x = pos.x, y = pos.y - 2, z = pos.z}
		n_2 = minetest.env:get_node(pos_2)

		pos_3 = {x = pos.x, y = pos.y - 3, z = pos.z}
		n_3 = minetest.env:get_node(pos_3)

		pos_4 = {x = pos.x, y = pos.y - 4, z = pos.z}
		n_4 = minetest.env:get_node(pos_4)

		pos_top = {x = pos.x, y = pos.y + 1, z = pos.z}
		n_top = minetest.env:get_node(pos_top)
		
			if n_1.name == "default:dirt_with_grass" and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="ivy:ivy"})
			minetest.env:add_node(pos_top, {name="ivy:ivy"})
			return true
			end

			if n_1.name == "ivy:ivy" and n_2.name == "default:dirt_with_grass" and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="ivy:ivy"})
			minetest.env:add_node(pos_top, {name="ivy:ivy"})
			return true
			end

			if n_1.name == "ivy:ivy" and n_2.name == "ivy:ivy" and n_3.name == "default:dirt_with_grass" 
			and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="ivy:ivy"})
			minetest.env:add_node(pos_top, {name="ivy:ivy"})
			return true
			end
        end,
})


--GENERATION

minetest.register_on_generated(function(minp, maxp)
    for x = minp.x, maxp.x do
        for z = minp.z, maxp.z do
            for ly = minp.y, maxp.y do
                local y = maxp.y + minp.y - ly
		if minetest.env:get_node({x = x, y = y, z = z}).name == "default:dirt_with_grass" then
			local i = math.random(1,10)
			if minetest.env:get_node({x = x, y = y + 1, z = z}).name == "air" then
				if minetest.env:get_node({x = x + 1, y = y + 1, z = z}).name == "default:tree" or 
				minetest.env:get_node({x = x - 1, y = y + 1, z = z}).name == "default:tree" or
				minetest.env:get_node({x = x, y = y + 1, z = z - 1}).name == "default:tree" or 
				minetest.env:get_node({x = x, y = y + 1, z = z + 1}).name == "default:tree"then
					if i == 3 then
					minetest.env:add_node({x = x, y = y + 1, z = z}, {name="ivy:ivy"})
					end
				end
			end
		end
	    end
        end
    end
end
)
