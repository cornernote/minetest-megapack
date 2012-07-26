minetest.register_tool("mese_starter_kit:sword_mese", {
	description = "Mese Sword",
	image = "mese_starter_kit_sword.png",
	tool_digging_properties = {
		basetime = 0,
		dt_weight = 0,
		dt_crackiness = 3,
		dt_crumbliness = 3,
		dt_cuttability = 0,
		basedurability = 1337,
		dd_weight = 0,
		dd_crackiness = 0,
		dd_crumbliness = 0,
		dd_cuttability = 0,
	},
})

minetest.register_craft({
	output = 'tool "mese_starter_kit:sword_mese"',
	recipe = {
		{'default:mese'},
		{'default:mese'},
		{'default:stick'},
	}
})
minetest.register_tool("mese_starter_kit:axe_mese", {
	description = "Mese Axe",
	image = "mese_starter_kit_axe.png",
	tool_digging_properties = {
		basetime = 0,
		dt_weight = 1,
		dt_crackiness = -2,
		dt_crumbliness = 0,
		dt_cuttability = -3,
		basedurability = 500,
		dd_weight = 0,
		dd_crackiness = 0,
		dd_crumbliness = 0,
		dd_cuttability = 0,
	},
})

minetest.register_craft({
	output = 'tool "mese_starter_kit:axe_mese"',
	recipe = {
		{'default:mese', 'default:mese', ''},
		{'default:mese', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})
minetest.register_tool("mese_starter_kit:spade_mese", {
	description = "Mese Spade",
	image = "mese_starter_kit_spade.png",
	tool_digging_properties = {
		basetime = 0,
		dt_weight = 0,
		dt_crackiness = 3,
		dt_crumbliness = -1,
		dt_cuttability = 1,
		basedurability = 1000,
		dd_weight = 0,
		dd_crackiness = 0,
		dd_crumbliness = 0,
		dd_cuttability = 0,
	},
})

minetest.register_craft({
	output = 'tool "mese_starter_kit:spade_mese"',
	recipe = {
		{'default:mese'},
		{'default:stick'},
		{'default:stick'},
	}
})
