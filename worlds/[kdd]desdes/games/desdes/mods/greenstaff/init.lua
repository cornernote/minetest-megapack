--crafting items

minetest.register_craftitem("greenstaff:greenstaff", {
	description = "Green Staff",
	inventory_image = "greenstaff_greenstaff.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
		n = minetest.env:get_node(pointed_thing.under)
		nt = minetest.env:get_node(pointed_thing.above)
			if n.name == "default:dirt" then
			minetest.env:add_node(pointed_thing.under, {name = "default:dirt_with_grass"})
			end
			if n.name == "default:cobble" then
			minetest.env:add_node(pointed_thing.under, {name = "default:mossycobble"})
			end
			if n.name == "default:dirt_with_grass" and nt.name == "air" then
			minetest.env:add_node(pointed_thing.above, {name = "default:junglegrass"})
			end

			if n.name == "default:stone" then
			minetest.env:add_node(pointed_thing.under, {name = "default:dirt"})
			end
		end
	end,
})


minetest.register_craft({
	output = 'greenstaff:greenstaff',
	recipe = {
		{'default:junglegrass'},
		{'default:mese'},
		{'default:stick'},
	}
})
