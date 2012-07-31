--[[
Workers Mod
By LocaL_ALchemisT (prof_awang@yahoo.com)
License: WTFPL
Version: 1.0
--]]

minetest.register_craft({
	output = "workers:harvester",
	recipe = {
		{"default:dirt","default:chest","default:dirt"},
		{"default:dirt","default:mese","default:dirt"},
		{"default:dirt","default:dirt","default:dirt"}
	}
})

minetest.register_craft({
	output = "workers:gardener",
	recipe = {
		{"default:dirt","default:shovel_steel","default:dirt"},
		{"default:dirt","default:mese","default:dirt"},
		{"default:dirt","default:dirt","default:dirt"}
	}
})

minetest.register_craft({
	output = "workers:miner",
	recipe = {
		{"default:dirt","default:pick_steel","default:dirt"},
		{"default:dirt","default:mese","default:dirt"},
		{"default:dirt","default:dirt","default:dirt"}
	}
})