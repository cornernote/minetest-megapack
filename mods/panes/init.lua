minetest.register_craft({
	output = 'panes:glass_pane 16',
	recipe = {
		{'default:glass', 'default:glass', 'default:glass'},
		{'default:glass', 'default:glass', 'default:glass'},
	}
})

minetest.register_node("panes:glass_pane", {
	description = "Glass Pane",
	drawtype = "torchlike",
	tiles = {"default_glass.png"},
	inventory_image = "default_glass.png",
	wield_image = "default_glass.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = true,
	groups = {choppy=2,dig_immediate=3},
	legacy_wallmounted = false,
	buildable_to = true,
	selection_box = {
		type = "wallmounted",
		wall_side = {-0.5, -0.5, -0.05, 0.5, 0.5, 0.05},
	},
})

minetest.add_to_creative_inventory('panes:glass_Pane')