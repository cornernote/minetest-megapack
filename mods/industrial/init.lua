-- Industrial Mod
-- by RAPHAEL
--
-- License: Do what you want but give credit where credit is due
--
-- Some code/textures taken from/modded from the following mods:
-- * secret_passages
-- * moreblocks
-- * default
-- * cement
-- * more_fences
--
-- NOTES: I'm not responsible for anything. Use at your own risk.
-- Any and everything in here used under fair use.
--
-- Also chainlink fence disabled by default. It works but is ugly.


-- white brick (because I missed it)
minetest.register_craft({
	output = 'node "industrial:white_brick" 10',
	recipe = {
		{'node "default:stone"', 'node "default:stone"'},
		{'node "default:stone"', 'node "default:stone"'},
	}
})

minetest.register_node("industrial:white_brick", {
	description = "White Brick",
	tiles = {"industrial_white_brick.png"},
	inventory_image = minetest.inventorycube("industrial_white_brick.png"),
	is_ground_content = true,
	groups = {cracky=3},
	material = minetest.digprop_stonelike(1.0),
})
-- end white brick

-- white brick secret passage
minetest.register_node('industrial:whitebricksp', {
	description = "White Stone Secret Passage",
	drawtype = 'allfaces',
	tiles = {'industrial_sp_brick.png'},
	inventory_image = 'industrial_sp_brick.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	climable = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {cracky=3},
	material = minetest.digprop_constanttime(1.0),
	drop = 'NodeItem "industrial:whitebricksp" 1',
})

minetest.register_craft({
	output = 'NodeItem "industrial:whitebricksp" 1',
	recipe = {
		{'node "secret_passage:compoent" 1', 'node "industrial:white_brick" 1', 'node "secret_passage:compoent" 1'},
		{'node "secret_passage:compoent" 1', 'node "industrial:white_brick" 1', 'node "secret_passage:compoent" 1'},
	},
})
-- end white brick secret passage


-- industrial crate
minetest.register_craft({
	output = 'node "industrial:crate" 1',
	recipe = {
		{'node "default:wood"', 'node "default:wood"', 'node "default:wood"'},
		{'', 'node "default:wood"', ''},
		{'node "default:wood"', 'node "default:wood"', 'node "default:wood"'},
	}
})

minetest.register_node("industrial:crate", {
	description = "Industrial Crate",
	tiles = {"industrial_crate_front.png"},
	inventory_image = minetest.inventorycube("industrial_crate_front.png"),
	paramtype = "facedir_simple",
	metadata_name = "chest",
	groups = {snappy=2,choppy=3,oddly_breakable_by_hand=2},
	material = minetest.digprop_woodlike(1.0),
	furnace_burntime = 30,
})
-- end industrial crate

-- industrial safe (some reason it doesn't line up right on placement anymore?)
minetest.register_craft({
	output = 'node "industrial:safe" 1',
	recipe = {
		{'node "default:wood"', 'node "default:wood"', 'node "default:wood"'},
		{'', 'craft "default:steel_ingot"', ''},
		{'node "default:wood"', 'node "default:wood"', 'node "default:wood"'},
	}
})

minetest.register_node("industrial:safe", {
	description = "Industrial Safe",
	tiles = {"industrial_safe_top.png", "industrial_safe_top.png", "industrial_safe_side.png",
		"industrial_safe_side.png", "industrial_safe_side.png", "industrial_safe_lock.png"},
	inventory_image = minetest.inventorycube("industrial_safe_top.png", "industrial_safe_lock.png", "industrial_safe_side.png"),
	paramtype = "facedir_simple",
	metadata_name = "locked_chest",
	groups = {snappy=2,choppy=3,oddly_breakable_by_hand=2},
	material = minetest.digprop_woodlike(1.0),
	furnace_burntime = 30,
})
-- end industrial safe

-- asphalt (what industrial theme is complete without such?)
minetest.register_craft({
	output = 'node "industrial:asphalt" 10',
	recipe = {
		{'craft "default:coal_lump"', 'craft "default:coal_lump"'},
		{'node "default:gravel"', 'node "default:gravel"'},
	}
})

minetest.register_node("industrial:asphalt", {
	description = "Industrial asphalt",
	tiles = {"industrial_asphalt.png"},
	inventory_image = minetest.inventorycube("industrial_asphalt.png"),
	is_ground_content = true,
	groups = {cracky=3},
	material = minetest.digprop_stonelike(5.0),
})
-- end asphalt

-- filingcabinet
minetest.register_craft({
	output = 'node "industrial:filingcabinet" 2',
	recipe = {
		{'node "default:chest"', 'node "default:chest"'},
	}
})
minetest.register_node("industrial:filingcabinet", {
	description = "Industrial filing cabinet",
	tiles = {"industrial_filingcabinetside.png", "industrial_filingcabinetside.png", "industrial_filingcabinetside.png", "industrial_filingcabinetside.png", "industrial_filingcabinetside.png", "industrial_filingcabinetfront.png"},
	inventory_image = minetest.inventorycube("industrial_filingcabinetside.png", "industrial_filingcabinetfront.png", "industrial_filingcabinetside.png"),
	paramtype = "facedir_simple",
	metadata_name = "chest",
	groups = {snappy=2,choppy=3,oddly_breakable_by_hand=2},
	material = minetest.digprop_woodlike(1.0),
	furnace_burntime = 30,
})
-- end filing cabinet

-- random steel color like block for various uses
minetest.register_craft({
	output = 'node "industrial:steelgray" 8',
	recipe = {
		{'node "default:steelblock"', 'node "default:steelblock"', 'node "default:steelblock"'},
	}
})

minetest.register_node("industrial:steelgray", {
	description = "steel gray",
	tiles = {"industrial_steelgray.png"},
	inventory_image = minetest.inventorycube("industrial_steelgray.png"),
	is_ground_content = true,
	groups = {cracky=3},
	material = minetest.digprop_stonelike(5.0),
})
-- end steel block


-- cement looking block because I dont like the updated cement mod (fixed cement mod included)
minetest.register_craft({
	output = 'node "industrial:cement" 1',
	recipe = {
		{'node "default:sand"', 'node "default:gravel"'},
		{'node "default:cobble"', 'node "default:cobble"'},
	}
})

minetest.register_node("industrial:cement", {
	description = "industrial cement",
	tiles = {"industrial_cement.png"},
	inventory_image = minetest.inventorycube("industrial_cement.png"),
	is_ground_content = true,
	groups = {cracky=3},
	material = minetest.digprop_stonelike(1.0),
})
-- end industrial cement


-- dead end sign
minetest.register_craft({
	output = 'industrial:deadendsign',
	recipe = {
		{'industrial:asphalt', 'default:sign_wall'},
	}
})

minetest.register_node("industrial:deadendsign", {
	description = "Dead End Sign",
	drawtype = "signlike",
	tiles = {"industrial_deadend.png"},
	inventory_image = "industrial_deadend.png",
	wield_image = "industrial_deadend.png",
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
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3},
	material = minetest.digprop_constanttime(0.5),
	legacy_wallmounted = true,
})
-- end dead end sign

-- railroad crossing sign
minetest.register_craft({
	output = 'industrial:rrsign',
	recipe = {
		{'default:rail', 'default:sign_wall'},
	}
})

minetest.register_node("industrial:rrsign", {
	description = "Railroad Sign",
	drawtype = "signlike",
	tiles = {"industrial_rrsign.png"},
	inventory_image = "industrial_rrsign.png",
	wield_image = "industrial_rrsign.png",
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
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3},
	material = minetest.digprop_constanttime(0.5),
	legacy_wallmounted = true,
})
-- end railroad crossing sign

-- NOTE: To have high voltage sign, uncomment the following and add jeija to depends.txt 
--       and have jeija installed and working properly
---- start high voltage sign
--minetest.register_craft({
--	output = 'industrial:highvoltagesign',
--	recipe = {
--		{'jeija:mesecon', 'default:sign_wall'},
--	}
--})
--
--minetest.register_node("industrial:highvoltagesign", {
--	description = "High Voltage Sign",
--	drawtype = "signlike",
--	tiles = {"industrial_highvoltagesign.png"},
--	inventory_image = "industrial_highvoltagesign.png",
--	wield_image = "industrial_highvoltagesign.png",
--	paramtype = "light",
--	paramtype2 = "wallmounted",
--	sunlight_propagates = true,
--	walkable = false,
--	metadata_name = "sign",
--	selection_box = {
--		type = "wallmounted",
--		--wall_top = <default>
--		--wall_bottom = <default>
--		--wall_side = <default>
--	},
--	material = minetest.digprop_constanttime(0.5),
--	legacy_wallmounted = true,
--})
---- end high voltage sign

-- exit sign
minetest.register_craft({
	output = 'industrial:exitsign',
	recipe = {
		{'default:wood', 'default:sign_wall'},
	}
})

minetest.register_node("industrial:exitsign", {
	description = "Exit Sign",
	drawtype = "signlike",
	tiles = {"industrial_exitsign.png"},
	inventory_image = "industrial_exitsign.png",
	wield_image = "industrial_exitsign.png",
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
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3},
	groups = {choppy=2,dig_immediate=2},
	material = minetest.digprop_constanttime(0.5),
	legacy_wallmounted = true,
})
-- end exit sign

-- chainlink fence (ugly but you can enable if you want)
--minetest.register_craft({
--	output = 'node "industrial:chainlinkfence" 25',
--	recipe = {
--		{'craft "default:steel_ingot"', 'craft "default:steel_ingot"', 'craft "default:steel_ingot"'},
--		{'craft "default:steel_ingot"', 'craft "default:steel_ingot"', 'craft "default:steel_ingot"'},
--		{'craft "default:fence_wood"', 'craft "default:fence_wood"', 'craft "default:fence_wood"'},
--	}
--})
--
--minetest.register_node("industrial:chainlinkfence", {
--	drawtype = "fencelike",
--	tiles = {"industrial_chainlinkfence.png"},
--	inventory_image = "industrial_chainlinkfence.png",
--	light_propagates = true,
--	paramtype = "light",
--	is_ground_content = true,
--	selection_box = {
--		type = "fixed",
--		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
--	},
--	groups = {cracky=3},
--	material = minetest.digprop_stonelike(2.5),
--})
-- end chainlink fence

-- superwood (long burn times)
minetest.register_craft({
	type = "fuel",
	recipe = "industrial:superwood",
	burntime = 99,
})

minetest.register_node("industrial:superwood", {
	description = "Industrial Superwood",
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	material = minetest.digprop_woodlike(1.0),
})

minetest.register_craft({
	output = 'industrial:superwood 4',
	recipe = {
		{'default:tree', 'default:tree', 'default:tree'},
		{'default:tree', 'default:tree', 'default:tree'},
	}
})
