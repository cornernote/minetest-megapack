COOLING_RATE = 60
IRON_FORMATION_RATE = 32
--Molten rock takes 10 times longer to turn into stone than lava takes to turn into molten rock.
COOlING_RATIO = 10

--Nodes/Items
minetest.register_node("lavacooling:moltenrock", {
	description = "Molten Rock",
	inventory_image = minetest.inventorycube("lavacooling_moltenrock.png"),
	tiles = {
		"lavacooling_moltenrock.png"
	},
	paramtype = "light",
	light_source = 10,
	groups = {cracky=3, hot=3, igniter=1},
		sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("lavacooling:obsidian_shard", {
	description = "Obsidian Shard",
	inventory_image = "lavacooling_obsidian_shard.png",
})

minetest.register_node("lavacooling:obsidian", {
	description = "Obsidian",
	tiles = {"lavacooling_obsidian.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
	drop = {
		items = {
			{
			items = {"lavacooling:obsidian"},
			rarity = 6,
			},
		},
	},
})

minetest.register_node("lavacooling:pumice", {
	description = "Pumice",
	tiles = {"lavacooling_pumice.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

--Crafts
minetest.register_craft({
	type = "fuel",
	recipe = "lavacooling:moltenrock",
	burntime = 30,
})

minetest.register_craft({
	output = "lavacooling:obsidian_shard 3",
	recipe = {
		{"lavacooling:obsidian"},
	}
})

--ABMs
minetest.register_abm ({
	nodenames = {"default:lava_source", "default:lava_flowing"},
	neighbors = {"default:water_source", "default:water_flowing"},
	interval = 1.0,
	chance = 1,
	action = function (pos)
		minetest.env: add_node (pos, {name = "lavacooling:obsidian"})
	end,
})

minetest.register_abm ({
	nodenames = {"lavacooling:moltenrock"},
	neighbors = {"default:water_source", "default:water_flowing"},
	interval = 1.0,
	chance = 1,
	action = function (pos)
		if minetest.env: get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "default:water_source" or minetest.env: get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "default:water_flowing"
		then
		minetest.env: add_node (pos, {name = "lavacooling:pumice"})
		else
		minetest.env: add_node (pos, {name = "default:stone"})
		end
	end,
})

minetest.register_abm ({
	nodenames = {"default:lava_source", "default:lava_flowing"},
	neighbors = {"air"},
	interval = 5.0,
	chance = COOLING_RATE,
	action = function (pos)
		minetest.env: add_node (pos, {name = "lavacooling:moltenrock"})
	end,
})

minetest.register_abm ({
	nodenames = {"lavacooling:moltenrock"},
	interval = 5.0,
	chance = COOLING_RATE*COOlING_RATIO,
	action = function (pos)
		if minetest.env: get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" and minetest.env: get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "lavacooling:moltenrock"
		then
		minetest.env: add_node (pos, {name = "lavacooling:pumice"})
		else
		minetest.env: add_node (pos, {name = "default:stone"})
		end
	end,
})

minetest.register_abm ({
	nodenames = {"lavacooling:moltenrock"},
	interval = 5.0,
	chance = COOLING_RATE*IRON_FORMATION_RATE*COOlING_RATIO,
	action = function (pos)
		minetest.env: add_node (pos, {name = "default:stone_with_iron"})
	end,
})
