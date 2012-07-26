minetest.register_node("sand:sand_flowing", {
	description = "Flowing Sand",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "flowingliquid",
	tiles = {"default_sand.png"},
	special_tiles = {
		{name="default_sand.png", backface_culling=false},
		{name="default_sand.png", backface_culling=true},
	},
	paramtype = "light",
	walkable = true,
	pointable = false,
	diggable = true,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "sand:sand_flowing",
	liquid_alternative_source = "sand:sand_source",
	liquid_viscosity = 1,
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("sand:sand_source", {
	description = "Sand Source",
	inventory_image = minetest.inventorycube("default_sand.png"),
	drawtype = "liquid",
	tiles = {"default_sand.png"},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{name="default_sand.png", backface_culling=false},
	},
	paramtype = "light",
	walkable = true,
	pointable = false,
	diggable = true,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "sand:sand_flowing",
	liquid_alternative_source = "sand:sand_source",
	liquid_viscosity = 1,
	groups = {water=3, liquid=3, puts_out_fire=1},
})