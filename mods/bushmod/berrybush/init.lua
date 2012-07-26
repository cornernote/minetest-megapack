--GENERATION

minetest.register_on_generated(function(minp, maxp)
    for x = minp.x, maxp.x do
        for z = minp.z, maxp.z do
            for ly = minp.y, maxp.y do
                local y = maxp.y + minp.y - ly
		if minetest.env:get_node({x = x, y = y, z = z}).name == "default:dirt_with_grass" then
			local i = math.random(1,555)
			if minetest.env:get_node({x = x, y = y + 1, z = z}).name == "air" then
					if i == 3 then
					minetest.env:add_node({x = x, y = y + 1, z = z}, {name="berrybush:berrybush"})
					end
			end
		end
	    end
        end
    end
end
)


--NODES

minetest.register_node("berrybush:berrybush", {
	description = "Bush",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_leaves.png^bushmod_berry.png"},
	paramtype = "light",
	groups = {snappy=3},
	drop = { items = {'berrybush:berry_sapling', 'berrybush:berry'},
		max_items = 1,
		items = {
			{
				items = {'berrybush:berry_sapling', 'berrybush:berry'},
				rarity = 1,
			},
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("berrybush:berry", {
	description = "Berry",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"bushmod_berry.png"},
	inventory_image = "bushmod_berry.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	groups = {fleshy=3,dig_immediate=3},
	on_use = minetest.item_eat(4),
	sounds = default.node_sound_defaults(),
})


minetest.register_node("berrybush:berry_sapling", {
	description = "Berry Bush Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"bushmod_berry_sapling.png"},
	inventory_image = "bushmod_berry_sapling.png",
	wield_image = "bushmod_berry_sapling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3},
	sounds = default.node_sound_defaults(),
})


--GROWING

minetest.register_abm(
        {nodenames = {"berrybush:berry_sapling"},
        interval = 1,
        chance = 100,
        action = function(pos)
		pos_t = {x = pos.x, y = pos.y + 1, z = pos.z}
		n_t = minetest.env:get_node(pos_t)

		pos_d = {x = pos.x, y = pos.y - 1, z = pos.z}
		n_d = minetest.env:get_node(pos_d)
		
		local s = math.random(3,5)
		
		--if s==3 then
		--	if n_1.name == "air" then
		--	minetest.env:add_node(pos, {name="default:leaves"})
		--	end
		--end

		if s==4 then
			if n_t.name == "air" and n_d.name == "default:dirt_with_grass" then
			minetest.env:add_node(pos, {name="berrybush:berrybush"})
			end
		end
            	
        end,
})
