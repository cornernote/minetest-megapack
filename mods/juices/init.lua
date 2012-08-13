-- Juices Mod
-- by mrtux (vortexlabs on the MT forums)
-- License: LGPL for code, wtfpl for graphics

-- Specify all the items
minetest.register_craftitem("juices:apple_juice", {
	description = "Apple Juice",
	inventory_image = "juices_applejuice.png",
	on_use = minetest.item_eat(8),
})
minetest.register_craftitem("juices:water", {
	description = "Water",
	inventory_image = "juices_water.png",
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem("juices:cup", {
	description = "Empty cup",
	inventory_image = "juices_cup.png",
})

-- Register crafting recipies
minetest.register_craft({
	output = 'juices:cup 2',
	recipe = {
		{'default:glass', '', 'default:glass'},
		{'default:glass', '', 'default:glass'},
		{'default:glass', 'default:glass', 'default:glass'},
	}
})
minetest.register_craft({
	output = 'juices:water',
	recipe = {
		{'default:water_source'},
		{'juices:cup'},
	}
})
minetest.register_craft({
	output = 'juices:apple_juice',
	recipe = {
		{'default:apple'},
		{'default:water_source'},
		{'juices:cup'},
	}
})
minetest.register_craft({
	output = 'juices:apple_juice',
	recipe = {
		{'default:apple'},
		{'juices:water'},
	}
})


-- Mod loaded message 
print("[Juices] Mod loaded!")