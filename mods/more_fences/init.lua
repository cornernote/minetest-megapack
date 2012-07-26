-- Crafting
minetest.register_craft({
	output = 'node "more_fences:fence_iron" 2',
	recipe = {
		{'craft "default:steel_ingot"', 'craft "default:steel_ingot"', 'craft "default:steel_ingot"'},
		{'craft "default:steel_ingot"', 'craft "default:steel_ingot"', 'craft "default:steel_ingot"'},
	}
})
minetest.register_craft({
	output = 'node "more_fences:fence_cobble" 2',
	recipe = {
		{'node "cobble"', 'node "cobble"', 'node "cobble"'},
		{'node "cobble"', 'node "cobble"', 'node "cobble"'},
	}
})
minetest.register_craft({
	output = 'node "more_fences:fence_stone" 2',
	recipe = {
		{'node "default:stone"', 'node "default:stone"', 'node "default:stone"'},
		{'node "default:stone"', 'node "default:stone"', 'node "default:stone"'},
	}
})
minetest.register_craft({
	output = 'node "more_fences:fence_brick" 2',
	recipe = {
		{'node "default:brick"', 'node "default:brick"', 'node "default:brick"'},
		{'node "default:brick"', 'node "default:brick"', 'node "default:brick"'},
	}
})
minetest.register_craft({
	output = 'node "more_fences:fence_mese" 2',
	recipe = {
		{'node "default:mese"', 'node "default:mese"', 'node "default:mese"'},
		{'node "default:mese"', 'node "default:mese"', 'node "default:mese"'},
	}
})
minetest.register_craft({
	output = 'node "more_fences:fence_cactus" 2',
	recipe = {
		{'node "default:cactus"', 'node "default:cactus"', 'node "default:cactus"'},
		{'node "default:cactus"', 'node "default:cactus"', 'node "default:cactus"'},
	}
})
minetest.register_craft({
	output = 'node "more_fences:fence_sandstone" 2',
	recipe = {
		{'node "default:sandstone"', 'node "default:sandstone"', 'node "default:sandstone"'},
		{'node "default:sandstone"', 'node "default:sandstone"', 'node "default:sandstone"'},
	}
})
-- Nodes
minetest.register_node("more_fences:fence_iron", {
	drawtype = "fencelike",
	tiles = {"default_steel_block.png"},
	inventory_image = "more_fences_iron.png",
	light_propagates = true,
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	material = minetest.digprop_stonelike(2.5),
})

minetest.register_node("more_fences:fence_cobble", {
	drawtype = "fencelike",
	tiles = {"default_cobble.png"},
	inventory_image = "more_fences_cobble.png",
	light_propagates = true,
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	material = minetest.digprop_stonelike(0.9),
})
minetest.register_node("more_fences:fence_stone", {
	drawtype = "fencelike",
	tiles = {"default_stone.png"},
	inventory_image = "more_fences_stone.png",
	light_propagates = true,
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	material = minetest.digprop_stonelike(2.5),
})
minetest.register_node("more_fences:fence_brick", {
	drawtype = "fencelike",
	tiles = {"default_brick.png"},
	inventory_image = "more_fences_brick.png",
	light_propagates = true,
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	material = minetest.digprop_stonelike(1.0),
})
minetest.register_node("more_fences:fence_mese", {
	drawtype = "fencelike",
	tiles = {"default_mese.png"},
	inventory_image = "more_fences_mese.png",
	light_propagates = true,
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	material = minetest.digprop_stonelike(1.0),
})
minetest.register_node("more_fences:fence_cactus", {
	drawtype = "fencelike",
	tiles = {"default_cactus_side.png"},
	inventory_image = "more_fences_cactus.png",
	light_propagates = true,
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	material = minetest.digprop_stonelike(1.0),
})
minetest.register_node("more_fences:fence_sandstone", {
	drawtype = "fencelike",
	tiles = {"default_sandstone.png"},
	inventory_image = "more_fences_sandstone.png",
	light_propagates = true,
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	material = minetest.digprop_stonelike(1.0),
})

print("[MoreFences by sfan5] Loaded!")