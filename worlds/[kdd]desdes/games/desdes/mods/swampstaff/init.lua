--crafting items

minetest.register_craftitem("swampstaff:swampstaff", {
	description = "Green Staff",
	inventory_image = "swampstaff_swampstaff.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
		n = minetest.env:get_node(pointed_thing.under)
		nt = minetest.env:get_node(pointed_thing.above)
			if n.name == "default:dirt" or n.name == "default:dirt_with_grass" then
			minetest.env:add_node(pointed_thing.under, {name = "default:water_source"})
			minetest.env:add_node({x=pointed_thing.under.x, y=pointed_thing.under.y - 1, z=pointed_thing.under.z}, {name = 				"default:gravel"})
			minetest.env:remove_node({x=pointed_thing.under.x, y=pointed_thing.under.y - 2, z=pointed_thing.under.z})
			end
		end
	end,
})


minetest.register_craft({
	output = 'swampstaff:swampstaff',
	recipe = {
		{'default:gravel'},
		{'default:mese'},
		{'default:stick'},
	}
})
