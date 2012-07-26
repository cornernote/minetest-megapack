--Wool Mod MK2 - Test Subject; using flowers for wool now - this is only to make white, for the others, you will need to make your own.

minetest.register_node("wool:flower", {
	description = "FLower",
	drawtype = "plantlike",
	tiles = {"wool_flower.png"},
	inventory_image = "wool_flower.png",
	wield_image = "wool_flower.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("wool:white", {
	description = "White",
	tiles = {"wool_white.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:grey", {
	description = "Grey",
	tiles = {"wool_grey.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:dgrey", {
	description = "Dark Grey",
	tiles = {"wool_dgrey.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:black", {
	description = "Black",
	tiles = {"wool_black.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:red", {
	description = "Red",
	tiles = {"wool_red.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:pink", {
	description = "Pink",
	tiles = {"wool_pink.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:dred", {
	description = "Dark Red",
	tiles = {"wool_dred.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:blue", {
	description = "Blue",
	tiles = {"wool_blue.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:lblue", {
	description = "Light Blue",
	tiles = {"wool_lblue.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:dblue", {
	description = "Dark Blue",
	tiles = {"wool_dblue.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:green", {
	description = "Green",
	tiles = {"wool_green.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:lgreen", {
	description = "Light Green",
	tiles = {"wool_lgreen.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:dgreen", {
	description = "Dark Green",
	tiles = {"wool_dgreen.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:yellow", {
	description = "Yellow",
	tiles = {"wool_yellow.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:lyellow", {
	description = "Light Yellow",
	tiles = {"wool_lyellow.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:dyellow", {
	description = "Dark Yellow",
	tiles = {"wool_dyellow.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:orange", {
	description = "Orange",
	tiles = {"wool_orange.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:lorange", {
	description = "Light Orange",
	tiles = {"wool_lorange.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:dorange", {
	description = "Dark Orange",
	tiles = {"wool_dorange.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:cyan", {
	description = "Cyan",
	tiles = {"wool_cyan.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:lcyan", {
	description = "Light Cyan",
	tiles = {"wool_lcyan.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:dcyan", {
	description = "Dark Cyan",
	tiles = {"wool_dcyan.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:brown", {
	description = "Brown",
	tiles = {"wool_brown.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:lbrown", {
	description = "Light Brown",
	tiles = {"wool_lbrown.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:dbrown", {
	description = "Light Brown",
	tiles = {"wool_dbrown.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:magenta", {
	description = "Magenta",
	tiles = {"wool_magenta.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:lmagenta", {
	description = "Light Magenta",
	tiles = {"wool_lmagenta.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:dmagenta", {
	description = "Dark Magenta",
	tiles = {"wool_dmagenta.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:gold", {
	description = "Gold",
	tiles = {"wool_gold.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:khaki", {
	description = "Khaki",
	tiles = {"wool_khaki.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:navy", {
	description = "Navy",
	tiles = {"wool_navy.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("wool:terra", {
	description = "Terracotta",
	tiles = {"wool_terra.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

-- Crafting Defs

minetest.register_craft({
	output = 'wool:white 16',
	recipe = {
		{'default:coal_lump', 'default:sand'},
	}
})

minetest.register_craft({
	output = 'wool:white 16',
	recipe = {
		{'wool:flower', 'wool:flower'},
		{'wool:flower', 'wool:flower'},
	}
})

minetest.register_craft({
	output = 'wool:grey 16',
	recipe = {
		{'wool:white', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'wool:dgrey 16',
	recipe = {
		{'wool:grey', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'wool:black 16',
	recipe = {
		{'wool:dgrey', 'default:coal_lump'},
	}
})

minetest.register_craft({
	output = 'wool:red 16',
	recipe = {
		{'wool:white', 'default:apple'},
	}
})

minetest.register_craft({
	output = 'wool:pink 16',
	recipe = {
		{'wool:red', 'wool:white'},
	}
})

minetest.register_craft({
	output = 'wool:dred 16',
	recipe = {
		{'wool:red', 'wool:black'},
	}
})

minetest.register_craft({
	output = 'wool:blue 16',
	recipe = {
		{'wool:white', 'default:mese'},
	}
})

minetest.register_craft({
	output = 'wool:blue 16',
	recipe = {
		{'wool:cyan', 'wool:magenta'},
	}
})

minetest.register_craft({
	output = 'wool:lblue 16',
	recipe = {
		{'wool:blue', 'wool:white'},
	}
})

minetest.register_craft({
	output = 'wool:dblue 16',
	recipe = {
		{'wool:blue', 'wool:black'},
	}
})

minetest.register_craft({
	output = 'wool:green 16',
	recipe = {
		{'wool:white', 'default:leaves,'},
	}
})

minetest.register_craft({
	output = 'wool:green 16',
	recipe = {
		{'wool:white', 'wool:cactus'},
	}
})

minetest.register_craft({
	output = 'wool:green 16',
	recipe = {
		{'wool:white', 'default:junglegrass'},
	}
})

minetest.register_craft({
	output = 'wool:lgreen 16',
	recipe = {
		{'wool:green', 'wool:white'},
	}
})

minetest.register_craft({
	output = 'wool:yellow 16',
	recipe = {
		{'wool:white', 'default:sand'},
	}
})

minetest.register_craft({
	output = 'wool:lyellow 16',
	recipe = {
		{'wool:yellow', 'wool:white'},
	}
})

minetest.register_craft({
	output = 'wool:dyellow 16',
	recipe = {
		{'wool:yellow', 'wool:black'},
	}
})

minetest.register_craft({
	output = 'wool:orange 16',
	recipe = {
		{'wool:red', 'wool:yellow'},
	}
})

minetest.register_craft({
	output = 'wool:lorange 16',
	recipe = {
		{'wool:orange', 'wool:white'},
	}
})

minetest.register_craft({
	output = 'wool:dorange 16',
	recipe = {
		{'wool:orange', 'wool:black'},
	}
})

minetest.register_craft({
	output = 'wool:cyan 16',
	recipe = {
		{'wool:white', 'default:jungletree'},
	}
})

minetest.register_craft({
	output = 'wool:lcyan 16',
	recipe = {
		{'wool:cyan', 'wool:white'},
	}
})

minetest.register_craft({
	output = 'wool:dcyan 16',
	recipe = {
		{'wool:cyan', 'wool:black'},
	}
})

minetest.register_craft({
	output = 'wool:brown 16',
	recipe = {
		{'wool:white', 'default:dirt'},
	}
})

minetest.register_craft({
	output = 'wool:lbrown 16',
	recipe = {
		{'wool:brown', 'wool:white'},
	}
})

minetest.register_craft({
	output = 'wool:dbrown 16',
	recipe = {
		{'wool:brown', 'wool:black'},
	}
})

minetest.register_craft({
	output = 'wool:magenta 16',
	recipe = {
		{'wool:red', 'wool:cyan'},
	}
})

minetest.register_craft({
	output = 'wool:magenta 16',
	recipe = {
		{'wool:pink', 'wool:cyan'},
	}
})

minetest.register_craft({
	output = 'wool:dmagenta 16',
	recipe = {
		{'wool:magenta', 'wool:black'},
	}
})

minetest.register_craft({
	output = 'wool:lmagenta 16',
	recipe = {
		{'wool:magenta', 'wool:white'},
	}
})

minetest.register_craft({
	output = 'wool:khaki 16',
	recipe = {
		{'wool:lbrown', 'wool:white'},
	}
})

minetest.register_craft({
	output = 'wool:navy 16',
	recipe = {
		{'wool:dblue', 'wool:black'},
	}
})

minetest.register_craft({
	output = 'wool:terra 16',
	recipe = {
		{'wool:brown', 'wool:red'},
	}
})

minetest.register_craft({
	output = 'wool:gold 16',
	recipe = {
		{'wool:orange', 'wool:yellow'},
	}
})

-- Mese Gen.

dofile(minetest.get_modpath("wool").."/mese.lua")

-- FLower Generation by Kddkadenz; used his desert mod w. changes.

