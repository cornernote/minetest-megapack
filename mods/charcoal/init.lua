-- char coal
minetest.register_craftitem("charcoal:charcoal", {
	description = "Charcoal",
	inventory_image = "default_coal_lump.png",
	groups = {coal = 1},
	stack_max = 128,
})
minetest.register_craft({
	type = "fuel",
	recipe = "charcoal:charcoal",
	burntime = 40,
})
minetest.register_craft({
	type = "cooking",
	output = "charcoal:charcoal",
	recipe = "default:tree",
})
minetest.register_craft({
	type = "cooking",
	output = "charcoal:charcoal",
	recipe = "conifers:trunk",
})
minetest.register_craft({
	type = "cooking",
	output = "charcoal:charcoal",
	recipe = "conifers:trunk_reversed",
})
minetest.register_craft({
	output = "default:torch 4",
	recipe = {
		{"default:charcoal:charcoal"},
		{"default:stick"},
	}
})
