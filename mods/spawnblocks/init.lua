print (" Loading SpawnBlocks 0.3 ")

minetest.register_node("spawnblocks:redorange", {
	description = "spawnblock",
	tiles = {"redorange.png"},
	is_ground_content = true,
	groups = {cracky=1},
})

minetest.register_node("spawnblocks:yellowblack", {
	description = "spawnblock",
	tiles = {"yellowblack.png"},
	is_ground_content = true,
	groups = {cracky=1},
})

minetest.register_node("spawnblocks:greenblack", {
	description = "spawnblock",
	tiles = {"greenblack.png"},
	is_ground_content = true,
	groups = {cracky=1},
})

minetest.register_node("spawnblocks:greenblue", {
	description = "spawnblock",
	tiles = {"greenblue.png"},
	is_ground_content = true,
	groups = {cracky=1},
})

minetest.register_node("spawnblocks:redblue", {
	description = "spawnblock",
	tiles = {"redblue.png"},
	is_ground_content = true,
	groups = {cracky=1},
})

minetest.register_node("spawnblocks:yellowblue", {
	description = "spawnblock",
	tiles = {"yellowblue.png"},
	is_ground_content = true,
	groups = {cracky=1},
})

minetest.register_node("spawnblocks:blackwhite", {
	description = "spawnblock",
	tiles = {"blackwhite.png"},
	is_ground_content = true,
	groups = {cracky=1},
})

minetest.register_node("spawnblocks:yellowblack", {
	description = "spawnblock",
	tiles = {"yellowblack.png"},
	is_ground_content = true,
	groups = {cracky=1},
})

minetest.register_node("spawnblocks:glowstone", {
	description = "Glowstone",
	drawtype = "glasslike",
	tile_images = {"glowstone.png"},
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 12,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
})

print (" Loaded SpawnBlocks 0.3 ")
	