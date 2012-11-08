minetest.register_craft({
	output = "camomod:camoblock",
	recipe = {
		{"default:leaves", "default:leaves"},
		{"default:leaves", "default:leaves"},
	}
})
minetest.register_craft({
	output = "camomod:camoladder 4",
	recipe = {
		{"default:ladder 4", "default:tree"}}
})

minetest.register_node("camomod:camoblock", {
	description = "Nonsolid Camoflage Block",
	tiles = {"default_leaves.png"},
     drawtype = "glasslike",
	walkable = false,
 	climbable = true,
	paramtype = "light",
	groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2, flammable=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("camomod:camoladder", {
	description = "Camoflaged Ladder",
	drawtype = "signlike",
	tiles ={"camo_ladder.png"},
	inventory_image = "camo_ladder.png",
	wield_image = "camo_ladder.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	is_ground_content = true,
	walkable = false,
	climbable = true,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3},
	legacy_wallmounted = true,
	sounds = default.node_sound_wood_defaults(),
})
