-- Various blocks and such
-- by RAPHAEL

-- whitepane
minetest.register_craft({
	output = 'various:whitepane 3',
	recipe = {
		{'flowers:cotton', 'flowers:cotton', 'flowers:cotton'},
	}
})

minetest.register_node("various:whitepane", {
	description = "white pane",
	drawtype = "signlike",
	tiles = {"various_whitepane.png"},
	inventory_image = "various_whitepane.png",
	wield_image = "various_whitepane.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	material = minetest.digprop_constanttime(0.5),
	legacy_wallmounted = true,
})
-- end whitepane

-- redpane
minetest.register_craft({
	output = 'various:redpane 3',
	recipe = {
		{'flowers:flower_rose', 'flowers:flower_rose', 'flowers:flower_rose'},
	}
})

minetest.register_node("various:redpane", {
	description = "Red Pane",
	drawtype = "signlike",
	tiles = {"various_redpane.png"},
	inventory_image = "various_redpane.png",
	wield_image = "various_redpane.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	material = minetest.digprop_constanttime(0.5),
	legacy_wallmounted = true,
})
-- end redpane

-- purplepane
minetest.register_craft({
	output = 'various:purplepane 3',
	recipe = {
		{'flowers:flower_viola', 'flowers:flower_viola', 'flowers:flower_viola'},
	}
})

minetest.register_node("various:purplepane", {
	description = "purple Pane",
	drawtype = "signlike",
	tiles = {"various_purplepane.png"},
	inventory_image = "various_purplepane.png",
	wield_image = "various_purplepane.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	material = minetest.digprop_constanttime(0.5),
	legacy_wallmounted = true,
})
-- end purplepane

-- yellowpane
minetest.register_craft({
	output = 'various:yellowpane 3',
	recipe = {
		{'flowers:flower_dandelion_yellow', 'flowers:flower_dandelion_yellow', 'flowers:flower_dandelion_yellow'},
	}
})

minetest.register_node("various:yellowpane", {
	description = "yellow Pane",
	drawtype = "signlike",
	tiles = {"various_yellowpane.png"},
	inventory_image = "various_yellowpane.png",
	wield_image = "various_yellowpane.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	material = minetest.digprop_constanttime(0.5),
	legacy_wallmounted = true,
})
-- end yellowpane

-- woodpane
minetest.register_craft({
	output = 'various:woodpane 3',
	recipe = {
		{'default:wood', 'default:wood', 'default:wood'},
	}
})

minetest.register_node("various:woodpane", {
	description = "wood Pane",
	drawtype = "signlike",
	tiles = {"default_wood.png"},
	inventory_image = "default_wood.png",
	wield_image = "default_wood.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	material = minetest.digprop_constanttime(0.5),
	legacy_wallmounted = true,
})
-- end woodpane

-- greenpane
minetest.register_craft({
	output = 'various:greenpane',
	recipe = {
		{'default:leaves', 'default:leaves', 'default:leaves'},
	}
})

minetest.register_node("various:greenpane", {
	description = "green Pane",
	drawtype = "signlike",
	tiles = {"various_greenpane.png"},
	inventory_image = "various_greenpane.png",
	wield_image = "various_greenpane.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	material = minetest.digprop_constanttime(0.5),
	legacy_wallmounted = true,
})
-- end greenpane

-- bluepane
minetest.register_craft({
	output = 'various:bluepane 5',
	recipe = {
		{'default:leaves', 'moreores:mithril_lump', 'default:leaves'},
	}
})

minetest.register_node("various:bluepane", {
	description = "blue Pane",
	drawtype = "signlike",
	tiles = {"various_bluepane.png"},
	inventory_image = "various_bluepane.png",
	wield_image = "various_bluepane.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	material = minetest.digprop_constanttime(0.5),
	legacy_wallmounted = true,
})
-- end bluepane

-- bedblockgreen
minetest.register_craft({
	output = 'node "various:bedblockgreen" 2',
	recipe = {
		{'node "various:greenpane"', 'node "various:greenpane"'},
		{'node "flowers:cotton"', 'node "flowers:cotton"'},
	}
})

minetest.register_node("various:bedblockgreen", {
	description = "Green Bedblock",
	tiles = {"various_greenpane.png", "various_bedblockgreen.png"},
	inventory_image = minetest.inventorycube("various_greenpane.png", "various_bedblockgreen.png"),
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.0),
})
-- end bedblockgreen

-- bedblockpurple
minetest.register_craft({
	output = 'node "various:bedblockpurple" 2',
	recipe = {
		{'node "various:purplepane"', 'node "various:purplepane"'},
		{'node "flowers:cotton"', 'node "flowers:cotton"'},
	}
})

minetest.register_node("various:bedblockpurple", {
	description = "purple Bedblock",
	tiles = {"various_purplepane.png", "various_bedblockpurple.png"},
	inventory_image = minetest.inventorycube("various_purplepane.png", "various_bedblockpurple.png"),
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.0),
})
-- end bedblockpurple

-- bedblockred
minetest.register_craft({
	output = 'node "various:bedblockred" 2',
	recipe = {
		{'node "various:redpane"', 'node "various:redpane"'},
		{'node "flowers:cotton"', 'node "flowers:cotton"'},
	}
})

minetest.register_node("various:bedblockred", {
	description = "red Bedblock",
	tiles = {"various_redpane.png", "various_bedblockred.png"},
	inventory_image = minetest.inventorycube("various_redpane.png", "various_bedblockred.png"),
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.0),
})
-- end bedblockred

-- bedblockwhite
minetest.register_craft({
	output = 'node "various:bedblockwhite" 2',
	recipe = {
		{'node "various:whitepane"', 'node "various:whitepane"'},
		{'node "flowers:cotton"', 'node "flowers:cotton"'},
	}
})

minetest.register_node("various:bedblockwhite", {
	description = "white Bedblock",
	tiles = {"various_whitepane.png", "various_bedblockwhite.png"},
	inventory_image = minetest.inventorycube("various_whitepane.png", "various_bedblockwhite.png"),
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.0),
})
-- end bedblockwhite

-- bedblockyellow
minetest.register_craft({
	output = 'node "various:bedblockyellow" 2',
	recipe = {
		{'node "various:yellowpane"', 'node "various:yellowpane"'},
		{'node "flowers:cotton"', 'node "flowers:cotton"'},
	}
})

minetest.register_node("various:bedblockyellow", {
	description = "yellow Bedblock",
	tiles = {"various_yellowpane.png", "various_bedblockyellow.png"},
	inventory_image = minetest.inventorycube("various_yellowpane.png", "various_bedblockyellow.png"),
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.0),
})
-- end bedblockyellow

--lamp
-- minetest.register_node("various:lamp", {
-- 	description = "Lamp",
-- 	drawtype = "torchlike",
-- 	tiles = {"various_lamp_on_floor.png", "various_lampp_on_ceiling.png", "various_lamp.png"},
-- 	inventory_image = "various_lamp_on_floor.png",
-- 	wield_image = "various_lamp_on_floor.png",
-- 	paramtype = "light",
-- 	paramtype2 = "wallmounted",
-- 	sunlight_propagates = true,
-- 	walkable = false,
-- 	light_source = LIGHT_MAX-1,
-- 	selection_box = {
-- 		type = "wallmounted",
-- 		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
-- 		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
-- 		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
-- 	},
-- 	material = minetest.digprop_constanttime(0.0),
-- 	legacy_wallmounted = true,
-- })
-- end lamp

-- Thors Pick
minetest.register_craft({
	output = 'various:thorspick',
	recipe = {
		{'default:mese', 'default:mese', 'default:mese'},
		{'default:mese', 'default:stick', 'default:mese'},
		{'default:mese', 'default:stick', 'default:mese'},
	}
})

minetest.register_tool("various:thorspick", {
	description = "Thors Pickaxe",
	inventory_image = "default_tool_mesepick.png",
	tool_digging_properties = {
		basetime = 0,
		dt_weight = 0,
		dt_crackiness = 0,
		dt_crumbliness = 0,
		dt_cuttability = 0,
		basedurability = 5000,
		dd_weight = 0,
		dd_crackiness = 0,
		dd_crumbliness = 0,
		dd_cuttability = 0,
	},
})
-- end thors pick

-- adobe block
minetest.register_craft({
	output = 'node "various:adobe" 15',
	recipe = {
		{'node "default:dirt"','node "default:dirt"', 'node "default:dirt"'},
		{'node "default:dirt"','node "bucket:bucket_water"', 'node "default:dirt"'},
		{'node "default:dirt"','node "default:dirt"', 'node "default:dirt"'},
	}
})

minetest.register_node("various:adobe", {
	description = "Adobe Block",
	tiles = {"various_adobe.png"},
	inventory_image = minetest.inventorycube("various_adobe.png"),
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.0),
})
-- end adobe block

-- thatch
minetest.register_craft({
	output = 'node "various:thatch" 15',
	recipe = {
		{'node "default:junglegrass"','node "default:stick"', 'node "default:junglegrass"'},
		{'node "default:junglegrass"','node "default:stick"', 'node "default:junglegrass"'},
		{'node "default:junglegrass"','node "default:stick"', 'node "default:junglegrass"'},
	}
})

minetest.register_node("various:thatch", {
	description = "Thatch Block",
	tiles = {"various_thatch.png"},
	inventory_image = minetest.inventorycube("various_thatch.png"),
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.0),
})
-- end thatch

-- spyblock
minetest.register_craft({
	output = 'node "various:spyblock" 1',
	recipe = {
		{'node "default:stick"','node "default:stick"', 'node "default:stick"'},
		{'node "default:stick"','node "default:glass"', 'node "default:stick"'},
		{'node "default:stick"','node "default:stick"', 'node "default:stick"'},
	}
})

minetest.register_node("various:spyblock", {
	description = "Spy Block",
	tiles = {"various_spyblock.png"},
	inventory_image = minetest.inventorycube("various_spyblock_inv.png"),
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.0),
})
-- end spyblock

-- megusta roger sign
minetest.register_craft({
	output = 'various:megustarogersign',
	recipe = {
		{'default:wood', 'default:sign_wall', 'default:wood'},
	}
})

minetest.register_node("various:megustarogersign", {
	description = "MeGusta Roger Sign",
	drawtype = "signlike",
	tiles = {"various_megustaroger.png"},
	inventory_image = "various_megustaroger.png",
	wield_image = "various_megustaroger.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	metadata_name = "sign",
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	material = minetest.digprop_constanttime(0.5),
	legacy_wallmounted = true,
})
-- end megusta roger sign

-- wood plank block
minetest.register_craft({
	output = 'node "various:woodblock" 15',
	recipe = {
		{'node "default:wood"', 'node "default:wood"'},
		{'node "default:tree"', 'node "default:tree"'},
	}
})

minetest.register_node("various:woodblock", {
	description = "Wood Block",
	tiles = {"various_woodblock.png"},
	inventory_image = minetest.inventorycube("various_woodblock.png"),
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.0),
})
-- end wood plank block

--start lawngrass
minetest.register_craft({
	output = 'node "various:lawngrass" 15',
	recipe = {
		{'node "default:leaves"', 'node "default:leaves"'},
		{'node "default:dirt"', 'node "default:dirt"'},
	}
})

minetest.register_node("various:lawngrass", {
	description = "Lawn Grass",
	tiles = {"various_lawngrass.png", "default_dirt.png", "default_dirt.png^various_lawngrass_side.png"},
	inventory_image = minetest.inventorycube("various_lawngrass.png"),
	is_ground_content = true,
	material = minetest.digprop_dirtlike(0.75),
})
--end lawngrass


