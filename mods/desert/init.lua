--desert mod
--by kddekadenz

--License of code & textures: CC-BY 3.0
--be sure to credit me at least in one line of the code based upon this

 

--RANDOM NUMBER GEN

math.randomseed(3)

--INITIAL STUFF
minetest.register_on_newplayer(function(player)
player:get_inventory():add_item('main', 'desert:cactusstick 10')
end)

--Desert Landscape modification

minetest.register_on_generated(function(minp, maxp)
	for x = minp.x, maxp.x do
		for z = minp.z, maxp.z do
			for ly = minp.y, maxp.y do
			local y = maxp.y + minp.y - ly
			local n = minetest.env:get_node({x = x, y = y, z = z})
			local nt1 = minetest.env:get_node({x = x, y = y + 1, z = z})
			local nt2 = minetest.env:get_node({x = x, y = y + 2, z = z})
				if n.name == "default:stone" then
					if nt1.name == "default:dirt" or nt2.name == "default:dirt" or nt1.name == "default:sand" or 						nt2.name == "default:sand" then
					minetest.env:add_node({x = x, y = y, z = z}, {name = "default:sandstone"})
					end
				end
			end
		end
	end
end)


minetest.register_on_generated(function(minp, maxp)
	for x = minp.x, maxp.x do
		for z = minp.z, maxp.z do
			for ly = minp.y, maxp.y do
			local y = maxp.y + minp.y - ly
			local n = minetest.env:get_node({x = x, y = y, z = z})
				if n.name == "default:dirt" or n.name == "default:dirt_with_grass" then
					minetest.env:add_node({x = x, y = y, z = z}, {name = "default:sand"})
				end
			end
		end
	end
end)


minetest.register_on_generated(function(minp, maxp)
	for x = minp.x, maxp.x do
		for z = minp.z, maxp.z do
			for ly = minp.y, maxp.y do
			local y = maxp.y + minp.y - ly
			local n = minetest.env:get_node({x = x, y = y, z = z})
				if n.name == "default:junglegrass" then
				local pos = {x = x, y = y, z = z}
				local pos_1 = {x = pos.x, y = pos.y - 1, z = pos.z}
				local n_1 = minetest.env:get_node(pos_1)

				local pos_top_1 = {x = pos.x, y = pos.y + 1, z = pos.z}

				local pos_top_2 = {x = pos.x, y = pos.y + 2, z = pos.z}

				local pos_top_3 = {x = pos.x, y = pos.y + 3, z = pos.z}

				local i = math.random(3,20)	
	
				if i==5 then
					if n_1.name ~= "default:sand" then
					minetest.env:remove_node(pos)
					return true
					end
			       		minetest.env:add_node(pos, {name="desert:palm_tree"})
					minetest.env:add_node(pos_top_1, {name="desert:palm_tree"})
					minetest.env:add_node(pos_top_2, {name="desert:palm_tree"})
					minetest.env:add_node(pos_top_3, {name="desert:palm_leaves"})
					return true
				end
				minetest.env:remove_node(pos)
				return true

				end
			end
		end
	end
end)


minetest.register_on_generated(function(minp, maxp)
	for x = minp.x, maxp.x do
		for z = minp.z, maxp.z do
			for ly = minp.y, maxp.y do
			local y = maxp.y + minp.y - ly
			local n = minetest.env:get_node({x = x, y = y, z = z})
			local nt = minetest.env:get_node({x = x, y = y + 1, z = z})
			local nd = minetest.env:get_node({x = x, y = y - 1, z = z})
				if n.name == "default:water_source" then
					if nt.name ~= "default:water_source" and nd.name ~= "default:water_source" then
					end
					minetest.env:add_node({x = x, y = y, z = z}, {name="default:sand"})
					--return true
				end
			end
		end
	end
end)

minetest.register_on_generated(function(minp, maxp)
	for x = minp.x, maxp.x do
		for z = minp.z, maxp.z do
			for ly = minp.y, maxp.y do
			local y = maxp.y + minp.y - ly
			local n = minetest.env:get_node({x = x, y = y, z = z})
				if n.name == "default:leaves" or n.name == "default:apple" then
				minetest.env:remove_node({x = x, y = y, z = z})
				end
			end
		end
	end
end)

minetest.register_on_generated(function(minp, maxp)
	for x = minp.x, maxp.x do
		for z = minp.z, maxp.z do
			for ly = minp.y, maxp.y do
			local y = maxp.y + minp.y - ly
			local n = minetest.env:get_node({x = x, y = y, z = z})
				if n.name == "default:tree" then
				minetest.env:add_node({x = x, y = y, z = z}, {name="default:cactus"} )
				end
			end
		end
	end
end)

minetest.register_abm(
        {nodenames = {"default:dirt_with_grass"},
        interval = 0,
        chance = 1,
        action = function(pos)
                minetest.env:add_node(pos, {name="default:sand"})
        end,
})

minetest.register_abm(
        {nodenames = {"default:dirt"},
        interval = 0,
        chance = 1,
        action = function(pos)
               minetest.env:add_node(pos, {name="default:sand"})
        end,
})

minetest.register_abm(
        {nodenames = {"default:papyrus"},
        interval = 0,
        chance = 1,
        action = function(pos)
                minetest.env:remove_node(pos)
        end,
})

minetest.register_abm(
        {nodenames = {"default:leaves"},
        interval = 0,
        chance = 1,
        action = function(pos)
                minetest.env:remove_node(pos)
        end,
})

minetest.register_abm(
        {nodenames = {"default:tree"},
        interval = 0,
        chance = 1,
        action = function(pos)
                minetest.env:add_node(pos, {name="default:cactus"})
        end,
})

minetest.register_abm(
        {nodenames = {"default:apple"},
        interval = 0,
        chance = 1,
        action = function(pos)
                minetest.env:remove_node(pos)
        end,
})

minetest.register_abm(
        {nodenames = {"default:jungletree"},
        interval = 0,
        chance = 1,
        action = function(pos)
                minetest.env:remove_node(pos)
        end,
})

--minetest.register_abm(
--        {nodenames = {"default:junglegrass"},
--        interval = 0,
--        chance = 1,
--        action = function(pos)
--                minetest.env:remove_node(pos)
--        end,
--})

minetest.register_abm(
        {nodenames = {"default:sand"},
	neighbors = {"default:water_source", "default:water_flowing"},
        interval = 0,
        chance = 1200,
        action = function(pos)
		pos_top = {x = pos.x, y = pos.y + 1, z = pos.z}
		n_top = minetest.env:get_node(pos_top)
		if n_top.name == "air" then
		minetest.env:add_node(pos, {name="desert:sand_with_grass"})
		return true
		end
        end,
})


-- ABM's

--minetest.register_abm(
--        {nodenames = {"desert:sand_with_grass"},
--	neighbors ~= {"default:water_source", "default:water_flowing"},
--        interval = 0,
--        chance = 100,
--        action = function(pos)
--		minetest.env:add_node(pos, {name="default:sand"})
--        end,
--})

minetest.register_abm(
        {nodenames = {"desert:sand_with_grass"},
	neighbors = {"default:water_source", "default:water_flowing"},
        interval = 0,
        chance = 50000,
        action = function(pos)
		pos_top = {x = pos.x, y = pos.y + 1, z = pos.z}
		n_top = minetest.env:get_node(pos_top)
		if n_top.name == "air" then
		minetest.env:add_rat(pos_top)
		return true
		end
            	
        end,
})

minetest.register_abm(
        {nodenames = {"default:cactus"},
	neighbors = {"default:sand"},
        interval = 0,
        chance = 5000,
        action = function(pos)
		k = math.random(2,5)		
		
		pos_1 = {x = pos.x + k, y = pos.y, z = pos.z}
		pos_1_dn = {x = pos.x + k, y = pos.y - 1, z = pos.z}
		n_1 = minetest.env:get_node(pos_1)
		n_1_dn = minetest.env:get_node(pos_1_dn)

		pos_2 = {x = pos.x - k, y = pos.y, z = pos.z}
		pos_2_dn = {x = pos.x - k, y = pos.y - 1, z = pos.z}
		n_2 = minetest.env:get_node(pos_2)
		n_2_dn = minetest.env:get_node(pos_2_dn)

		pos_3 = {x = pos.x, y = pos.y, z = pos.z + k}
		pos_3_dn = {x = pos.x, y = pos.y - 1, z = pos.z + k}
		n_3 = minetest.env:get_node(pos_3)
		n_3_dn = minetest.env:get_node(pos_3_dn)

		pos_4 = {x = pos.x, y = pos.y, z = pos.z - k}
		pos_4_dn = {x = pos.x, y = pos.y - 1, z = pos.z - k}
		n_4 = minetest.env:get_node(pos_4)
		n_4_dn = minetest.env:get_node(pos_4_dn)
		
		local i = math.random(1,4)
		
		if i==1 then
			if n_1.name == "air" and n_1_dn.name == "default:sand" then
			minetest.env:add_node(pos_1, {name="desert:cactus_sapling"})
			nodeupdate(pos_1)
			return true
			end
		end

		if i==2 then
			if n_2.name == "air" and n_2_dn.name == "default:sand" then
			minetest.env:add_node(pos_2, {name="desert:cactus_sapling"})
			nodeupdate(pos_2)
			return true
			end
		end

		if i==3 then
			if n_3.name == "air" and n_4_dn.name == "default:sand" then
			minetest.env:add_node(pos_3, {name="desert:cactus_sapling"})
			nodeupdate(pos_3)
			return true
			end
		end

		if i==4 then
			if n_4.name == "air" and n_4_dn.name == "default:sand" then
			minetest.env:add_node(pos_4, {name="desert:cactus_sapling"})
			nodeupdate(pos_4)
			return true
			end
		end
            	
        end,
})

minetest.register_abm(
        {nodenames = {"desert:cactus_sapling"},
        interval = 1,
        chance = 100,
        action = function(pos)
		pos_1 = {x = pos.x, y = pos.y + 1, z = pos.z}
		n_1 = minetest.env:get_node(pos_1)

		pos_2 = {x = pos.x, y = pos.y + 2, z = pos.z}
		n_2 = minetest.env:get_node(pos_2)

		pos_3 = {x = pos.x, y = pos.y + 3, z = pos.z}
		n_3 = minetest.env:get_node(pos_3)

		pos_4 = {x = pos.x, y = pos.y + 4, z = pos.z}
		n_4 = minetest.env:get_node(pos_4)

		pos_dn = {x = pos.x, y = pos.y - 1, z = pos.z}
		n_dn = minetest.env:get_node(pos_dn)
		
		local i = math.random(3,5)
		
		if i==3 then
			if n_1.name == "air" and n_2.name == "air" and n_dn.name == "default:sand" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="default:cactus"})
			minetest.env:add_node(pos_1, {name="default:cactus"})
			minetest.env:add_node(pos_2, {name="default:cactus"})
			return true
			end
		end

		if i==4 then
			if n_1.name == "air" and n_2.name == "air" and n_3.name == "air"  and n_dn.name == "default:sand" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="default:cactus"})
			minetest.env:add_node(pos_1, {name="default:cactus"})
			minetest.env:add_node(pos_2, {name="default:cactus"})
			minetest.env:add_node(pos_3, {name="default:cactus"})
			return true
			end
		end

		if i==5 then
			if n_1.name == "air" and n_2.name == "air" and n_3.name == "air" and n_4.name == "air"  
			and n_dn.name == "default:sand" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="default:cactus"})
			minetest.env:add_node(pos_1, {name="default:cactus"})
			minetest.env:add_node(pos_2, {name="default:cactus"})
			minetest.env:add_node(pos_3, {name="default:cactus"})
			minetest.env:add_node(pos_4, {name="default:cactus"})
			return true
			end
		end
            	
        end,
})

minetest.register_abm(
        {nodenames = {"desert:palm_leaves"},
        interval = 1,
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
		
			if n_1.name == "default:sand" and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top, {name="desert:palm_leaves"})
			return true
			end

			if n_1.name == "desert:palm_tree" and n_2.name == "default:sand" and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top, {name="desert:palm_leaves"})
			return true
			end

			if n_1.name == "desert:palm_tree" and n_2.name == "desert:palm_tree" and n_3.name == "default:sand" 
			and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top, {name="desert:palm_leaves"})
			return true
			end


			if n_1.name == "desert:sand_with_grass" and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top, {name="desert:palm_leaves"})
			return true
			end

			if n_1.name == "desert:palm_tree" and n_2.name == "desert:sand_with_grass" and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top, {name="desert:palm_leaves"})
			return true
			end

			if n_1.name == "desert:palm_tree" and n_2.name == "desert:palm_tree" and n_3.name == "desert:sand_with_grass" 
			and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top, {name="desert:palm_leaves"})
			return true
			end

        end,
})

minetest.register_abm(
        {nodenames = {"desert:cactus_sapling"},
	neighbors = {"desert:sand_with_grass"},
        interval = 1,
        chance = 60,
        action = function(pos)
		pos_1 = {x = pos.x, y = pos.y + 1, z = pos.z}
		n_1 = minetest.env:get_node(pos_1)

		pos_2 = {x = pos.x, y = pos.y + 2, z = pos.z}
		n_2 = minetest.env:get_node(pos_2)

		pos_3 = {x = pos.x, y = pos.y + 3, z = pos.z}
		n_3 = minetest.env:get_node(pos_3)

		pos_4 = {x = pos.x, y = pos.y + 4, z = pos.z}
		n_4 = minetest.env:get_node(pos_4)

		pos_dn = {x = pos.x, y = pos.y - 1, z = pos.z}
		n_dn = minetest.env:get_node(pos_dn)
		
		local i = math.random(3,5)
		
		if i==3 then
			if n_1.name == "air" and n_2.name == "air" and n_dn.name == "desert:sand_with_grass" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="default:cactus"})
			minetest.env:add_node(pos_1, {name="default:cactus"})
			minetest.env:add_node(pos_2, {name="default:cactus"})
			return true
			end
		end

		if i==4 then
			if n_1.name == "air" and n_2.name == "air" and n_3.name == "air"  and n_dn.name == "desert:sand_with_grass" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="default:cactus"})
			minetest.env:add_node(pos_1, {name="default:cactus"})
			minetest.env:add_node(pos_2, {name="default:cactus"})
			minetest.env:add_node(pos_3, {name="default:cactus"})
			return true
			end
		end

		if i==5 then
			if n_1.name == "air" and n_2.name == "air" and n_3.name == "air" and n_4.name == "air"  
			and n_dn.name == "desert:sand_with_grass" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="default:cactus"})
			minetest.env:add_node(pos_1, {name="default:cactus"})
			minetest.env:add_node(pos_2, {name="default:cactus"})
			minetest.env:add_node(pos_3, {name="default:cactus"})
			minetest.env:add_node(pos_4, {name="default:cactus"})
			return true
			end
		end
            	
        end,
})

minetest.register_abm(
        {nodenames = {"desert:palm_leaves"},
	neighbors = {"desert:sand_with_grass"},
        interval = 1,
        chance = 60,
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
		
			if n_1.name == "default:sand" and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top, {name="desert:palm_leaves"})
			return true
			end

			if n_1.name == "desert:palm_tree" and n_2.name == "default:sand" and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top, {name="desert:palm_leaves"})
			return true
			end

			if n_1.name == "desert:palm_tree" and n_2.name == "desert:palm_tree" and n_3.name == "default:sand" 
			and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top, {name="desert:palm_leaves"})
			return true
			end


			if n_1.name == "desert:sand_with_grass" and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top, {name="desert:palm_leaves"})
			return true
			end

			if n_1.name == "desert:palm_tree" and n_2.name == "desert:sand_with_grass" and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top, {name="desert:palm_leaves"})
			return true
			end

			if n_1.name == "desert:palm_tree" and n_2.name == "desert:palm_tree" and n_3.name == "desert:sand_with_grass" 
			and n_top.name == "air" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top, {name="desert:palm_leaves"})
			return true
			end

        end,
})
minetest.register_abm(
        {nodenames = {"default:junglegrass"},
        interval = 0,
        chance = 1,
        action = function(pos)

		pos_1 = {x = pos.x, y = pos.y - 1, z = pos.z}
		n_1 = minetest.env:get_node(pos_1)

		pos_top_1 = {x = pos.x, y = pos.y + 1, z = pos.z}

		pos_top_2 = {x = pos.x, y = pos.y + 2, z = pos.z}

		pos_top_3 = {x = pos.x, y = pos.y + 3, z = pos.z}

		local i = math.random(3,20)	
	
		if i==5 then
			if n_1.name ~= "default:sand" then
			minetest.env:remove_node(pos)
			return true
			end
               		minetest.env:add_node(pos, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top_1, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top_2, {name="desert:palm_tree"})
			minetest.env:add_node(pos_top_3, {name="desert:palm_leaves"})
			return true
		end
		minetest.env:remove_node(pos)
		return true
        end,
})

minetest.register_abm(
        {nodenames = {"desert:palm_tree"},
        interval = 5,
        chance = 25,
        action = function(pos)

		pos_1 = {x = pos.x + 1, y = pos.y, z = pos.z}
		n_1 = minetest.env:get_node(pos_1)

		pos_2 = {x = pos.x - 1, y = pos.y, z = pos.z}
		n_2 = minetest.env:get_node(pos_2)

		pos_3 = {x = pos.x, y = pos.y, z = pos.z + 1}
		n_3 = minetest.env:get_node(pos_3)

		pos_4 = {x = pos.x, y = pos.y, z = pos.z - 1}
		n_4 = minetest.env:get_node(pos_4)
		
		pos_1_dn = {x = pos.x, y = pos.y - 1, z = pos.z}
		n_1_dn = minetest.env:get_node(pos_1_dn)

		pos_2_dn = {x = pos.x, y = pos.y - 2, z = pos.z}
		n_2_dn = minetest.env:get_node(pos_2_dn)

		pos_top = {x = pos.x, y = pos.y + 1, z = pos.z}
		n_top = minetest.env:get_node(pos_top)
		
		
		local i = math.random(1,4)
		
		if i==1 then
			if n_1.name == "air" and n_1_dn.name == "desert:palm_tree" and n_2_dn.name == "desert:palm_tree"
			and n_top.name == "desert:palm_leaves" then
			minetest.env:add_node(pos_1, {name="desert:palm_fruit_1"})
			nodeupdate(pos_1)
			return true
			end
		end

		if i==2 then
			if n_2.name == "air" and n_1_dn.name == "desert:palm_tree" and n_2_dn.name == "desert:palm_tree"
			and n_top.name == "desert:palm_leaves" then
			minetest.env:add_node(pos_2, {name="desert:palm_fruit_1"})
			nodeupdate(pos_2)
			return true
			end
		end

		if i==3 then
			if n_3.name == "air" and n_1_dn.name == "desert:palm_tree" and n_2_dn.name == "desert:palm_tree"
			and n_top.name == "desert:palm_leaves" then
			minetest.env:add_node(pos_3, {name="desert:palm_fruit_1"})
			nodeupdate(pos_3)
			return true
			end
		end

		if i==4 then
			if n_4.name == "air" and n_1_dn.name == "desert:palm_tree" and n_2_dn.name == "desert:palm_tree"
			and n_top.name == "desert:palm_leaves" then
			minetest.env:add_node(pos_4, {name="desert:palm_fruit_1"})
			nodeupdate(pos_4)
			return true
			end
		end
            	
        end,
})

minetest.register_abm(
        {nodenames = {"desert:palm_fruit_1"},
        interval = 3,
        chance = 100,
        action = function(pos)
		minetest.env:remove_node(pos)
		minetest.env:add_node(pos, {name="desert:palm_fruit_2"})
        end,
})

minetest.register_abm(
        {nodenames = {"desert:palm_fruit_2"},
	neighbors = {"desert:palm_tree"},
        interval = 1,
        chance = 1,
        action = function(pos)
		pos_dn = {x = pos.x, y = pos.y - 1, z = pos.z}
		n_dn = minetest.env:get_node(pos_dn)
		if n_dn.name == "air" then
		minetest.env:remove_node(pos)
		minetest.env:add_node(pos_dn, {name="desert:palm_fruit_2"})
		return true
		end            	
        end,
})

--minetest.register_abm(
--        {nodenames = {"default:stone"},
--	neighbors = {"default:sand"},
--        interval = 0,
--        chance = 1,
--        action = function(pos)
--               minetest.env:add_node(pos, {name="default:sandstone"})
--        end,
--})


--NEW ITEMS

--tools

minetest.register_tool("desert:pick_sandstone", {
	description = "Sandstone Pickaxe",
	inventory_image = "des_cactus_sandstonepick.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			cracky={times={[1]=1.50, [2]=0.80, [3]=0.60}, maxwear=0.05, maxlevel=1}
		}
	},
})

minetest.register_tool("desert:shovel_sandstone", {
	description = "Sandstone Shovel",
	inventory_image = "des_cactus_sandstoneshovel.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			crumbly={times={[1]=0.80, [2]=0.50, [3]=0.30}, maxwear=0.05, maxlevel=1}
		}
	},
})

minetest.register_tool("desert:axe_sandstone", {
	description = "Sandstone Axe",
	inventory_image = "des_cactus_sandstoneaxe.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			choppy={times={[1]=1.50, [2]=1.00, [3]=0.60}, maxwear=0.05, maxlevel=1},
			fleshy={times={[2]=1.30, [3]=0.70}, maxwear=0.05, maxlevel=1}
		}
	},
})

minetest.register_tool("desert:sword_sandstone", {
	description = "Sandstone Sword",
	inventory_image = "des_cactus_sandstonesword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			fleshy={times={[2]=0.80, [3]=0.40}, maxwear=0.05, maxlevel=1},
			snappy={times={[2]=0.80, [3]=0.40}, maxwear=0.05, maxlevel=1},
			choppy={times={[3]=0.90}, maxwear=0.05, maxlevel=0}
		}
	}
})


--crafting items

minetest.register_craftitem("desert:cactusstick", {
	description = "Cactusstick",
	inventory_image = "des_cactus_stick.png",
})


--nodes

minetest.register_node("desert:cactus_food", {
	description = "Cooked cactus",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"des_cactus_food.png"},
	inventory_image = "des_cactus_food.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy=3},
	on_use = minetest.item_eat(2),
})

minetest.register_node("desert:cactus_sapling", {
	description = "Cactus sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"des_cactus_sapling.png"},
	inventory_image = "des_cactus_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	damage_per_second = 2,
	groups = {snappy=3},
})

minetest.register_node("desert:sand_with_grass", {
	description = "Sand with grass",
	tiles = {"default_grass.png", "default_sand.png", "default_sand.png^default_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'default:sand',
})

--minetest.register_node("desert:quicksand", {
--	description = "Quicksand",
--	inventory_image = minetest.inventorycube("default_sand.png"),
--	drawtype = "liquid",
--	tiles = {"default_sand.png"},
--	paramtype = "light",
--	walkable = false,
--	pointable = false,
--	diggable = false,
--	buildable_to = true,
--	liquidtype = "source",
--	liquid_alternative_flowing = "air",
--	liquid_alternative_source = "air",
--	liquid_viscosity = LAVA_VISC,
--	damage_per_second = 4*2,
--	post_effect_color = {a=192, r=255, g=64, b=0},
--	special_materials = {
--		-- New-style lava source material (mostly unused)
--		{image="default_sand.png", backface_culling=false},
--	},
--})

minetest.register_node("desert:cactus_spikes", {
	description = "Cactus spikes",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"des_cactus_spikes.png"},
	inventory_image = "des_cactus_spikes.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	damage_per_second = 10,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
})

minetest.register_node("desert:palm_tree", {
	description = "Palm wood",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"des_palm_tree.png"},
	inventory_image = "des_palm_tree.png",
	paramtype = "light",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
})

minetest.register_node("desert:palm_leaves", {
	description = "Palm leaves",
	drawtype = "plantlike",
	visual_scale = 1.18,
	tiles = {"des_palm_leaves.png"},
	inventory_image = "des_palm_leaves.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy=3},
})

minetest.register_node("desert:palm_fruit_1", {
	description = "Green palm fruit",
	drawtype = "plantlike",
	visual_scale = 1.18,
	tiles = {"des_palm_fruit_1.png"},
	inventory_image = "des_palm_fruit_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {snappy=3},
})

minetest.register_node("desert:palm_fruit_2", {
	description = "Palm fruit",
	drawtype = "plantlike",
	visual_scale = 1.18,
	tiles = {"des_palm_fruit_2.png"},
	inventory_image = "des_palm_fruit_2.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	material = minetest.digprop_constanttime(0.1),
	groups = {snappy=3},
	on_use = minetest.item_eat(4),
})

--CRAFTING

minetest.register_craft({
	output = 'desert:pick_sandstone',
	recipe = {
		{'default:sandstone', 'default:sandstone', 'default:sandstone'},
		{'', 'desert:cactusstick', ''},
		{'', 'desert:cactusstick', ''},
	}
})

minetest.register_craft({
	output = 'desert:shovel_sandstone',
	recipe = {
		{'default:sandstone'},
		{'desert:cactusstick'},
		{'desert:cactusstick'},
	}
})

minetest.register_craft({
	output = 'desert:axe_sandstone',
	recipe = {
		{'default:sandstone', 'default:sandstone'},
		{'default:sandstone', 'desert:cactusstick'},
		{'', 'desert:cactusstick'},
	}
})

minetest.register_craft({
	output = 'desert:sword_sandstone',
	recipe = {
		{'default:sandstone'},
		{'default:sandstone'},
		{'desert:cactusstick'},
	}
})

minetest.register_craft({
	output = 'desert:cactusstick 4',
	recipe = {
		{'default:cactus'},
	}
})

minetest.register_craft({
	output = 'default:torch 4',
	recipe = {
		{'default:coal_lump'},
		{'desert:cactusstick'},
	}
})

minetest.register_craft({
	output = 'default:pick_stone',
	recipe = {
		{'default:cobble', 'default:cobble', 'default:cobble'},
		{'', 'desert:cactusstick', ''},
		{'', 'desert:cactusstick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_steel',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'', 'desert:cactusstick', ''},
		{'', 'desert:cactusstick', ''},
	}
})

minetest.register_craft({
	output = 'default:pick_mese',
	recipe = {
		{'default:mese', 'default:mese', 'default:mese'},
		{'', 'desert:cactusstick', ''},
		{'', 'desert:cactusstick', ''},
	}
})

minetest.register_craft({
	output = 'default:shovel_stone',
	recipe = {
		{'default:cobble'},
		{'desert:cactusstick'},
		{'desert:cactusstick'},
	}
})

minetest.register_craft({
	output = 'default:shovel_steel',
	recipe = {
		{'default:steel_ingot'},
		{'desert:cactusstick'},
		{'desert:cactusstick'},
	}
})

minetest.register_craft({
	output = 'default:axe_stone',
	recipe = {
		{'default:cobble', 'default:cobble'},
		{'default:cobble', 'desert:cactusstick'},
		{'', 'desert:cactusstick'},
	}
})

minetest.register_craft({
	output = 'default:axe_steel',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'desert:cactusstick'},
		{'', 'desert:cactusstick'},
	}
})

minetest.register_craft({
	output = 'default:sword_stone',
	recipe = {
		{'default:cobble'},
		{'default:cobble'},
		{'desert:cactusstick'},
	}
})

minetest.register_craft({
	output = 'default:sword_steel',
	recipe = {
		{'default:steel_ingot'},
		{'default:steel_ingot'},
		{'desert:cactusstick'},
	}
})

minetest.register_craft({
	output = 'default:chest',
	recipe = {
		{'default:cactus', 'default:cactus', 'default:cactus'},
		{'default:cactus', '', 'default:cactus'},
		{'default:cactus', 'default:cactus', 'default:cactus'},
	}
})

minetest.register_craft({
	output = 'default:chest_locked',
	recipe = {
		{'default:cactus', 'default:cactus', 'default:cactus'},
		{'default:cactus', 'default:steel_ingot', 'default:cactus'},
		{'default:cactus', 'default:cactus', 'default:cactus'},
	}
})

minetest.register_craft({
	output = 'desert:cactus_spikes 2',
	recipe = {
		{'desert:cactusstick', 'desert:cactusstick', 'desert:cactusstick'},
		{'desert:cactusstick', 'desert:cactusstick', 'desert:cactusstick'},
	}
})

minetest.register_craft({
	output = 'default:wood 2',
	recipe = {
		{'desert:palm_tree'},
	}
})

-- COOKING RECIPES

minetest.register_craft({
	type = "cooking",
	output = "desert:cactus_food",
	recipe = "default:cactus",
})



-- FUEL

minetest.register_craft({
	type = "fuel",
	recipe = "desert:cactusstick",
	burntime = 4,
})



-- MISC

minetest.register_on_dignode(function(p, node)
	if node.name == "default:cactus" then
		local i = math.random(1,5)
		
		if i==1 then
			minetest.env:add_node(p, {name="desert:cactus_sapling"})
			nodeupdate(p)
		end
	end
end)
