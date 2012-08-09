--[[
Workers Mod
By LocaL_ALchemisT (prof_awang@yahoo.com)
License: WTFPL
Version: 2.0
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

minetest.register_craft({
	output = "workers:builder",
	recipe = {
		{"default:dirt","default:brick","default:dirt"},
		{"default:dirt","default:mese","default:dirt"},
		{"default:dirt","default:dirt","default:dirt"}
	}
})

minetest.register_craft({
	output = "workers:guard",
	recipe = {
		{"default:dirt","default:steelblock","default:dirt"},
		{"default:dirt","default:mese","default:dirt"},
		{"default:dirt","default:dirt","default:dirt"}
	}
})

minetest.register_craft({
	output = "workers:assassin",
	recipe = {
		{"default:dirt","default:sword_steel","default:dirt"},
		{"default:dirt","default:mese","default:dirt"},
		{"default:dirt","default:dirt","default:dirt"}
	}
})

minetest.register_craft({
	output = "workers:thief",
	recipe = {
		{"default:dirt","default:coal_lump","default:dirt"},
		{"default:dirt","default:mese","default:dirt"},
		{"default:dirt","default:dirt","default:dirt"}
	}
})

minetest.register_craft({
	output = "workers:cop",
	recipe = {
		{"default:dirt","workers:guard","default:dirt"},
		{"default:dirt","default:mese","default:dirt"},
		{"default:dirt","default:dirt","default:dirt"}
	}
})

-- BENJO'S PLANS

minetest.register_craft({
	output = "workers:plan_house",
	recipe = {
		{"default:clay_brick","default:clay_brick","default:clay_brick"},
		{"default:clay_brick","                  ","default:clay_brick"},
		{"                  ","default:paper     ","                  "}
	}
})

minetest.register_craft({
	output = "workers:plan_hut",
	recipe = {
		{"                  ","default:clay_brick","                  "},
		{"default:clay_brick","                  ","default:clay_brick"},
		{"                  ","default:paper     ","                  "}
	}
})

minetest.register_craft({
	output = "workers:plan_pool",
	recipe = {
		{"default:clay_brick","bucket:bucket_water","default:clay_brick"},
		{"default:clay_brick","default:clay_brick ","default:clay_brick"},
		{"                  ","default:paper      ","                  "}
	}
})

minetest.register_craft({
	output = "workers:plan_moat",
	recipe = {
		{"bucket:bucket_water","default:clay_brick","bucket:bucket_water"},
		{"default:clay_brick ","default:clay_brick","default:clay_brick "},
		{"                   ","default:paper     ","                   "}
	}
})

minetest.register_craft({
	output = "workers:plan_tower",
	recipe = {
		{"default:clay_brick","                   ","default:clay_brick"},
		{"default:clay_brick","                   ","default:clay_brick"},
		{"                  ","default:paper      ","                  "}
	}
})

minetest.register_craft({
	output = "workers:plan_ubunker",
	recipe = {
		{"default:dirt       ","default:dirt      ","default:dirt      "},
		{"default:clay_brick ","default:clay_brick","default:clay_brick"},
		{"                   ","default:paper     ","                  "}
	}
})

minetest.register_craft({
	output = "workers:plan_wall",
	recipe = {
		{"default:clay_brick","default:clay_brick","default:clay_brick"},
		{"default:clay_brick","default:clay_brick","default:clay_brick"},
		{"                  ","default:paper     ","                  "}
	}
})

minetest.register_craft({
	output = "workers:plan_lavapool",
	recipe = {
		{"default:clay_brick","bucket:bucket_lava","default:clay_brick"},
		{"default:clay_brick","default:clay_brick","default:clay_brick"},
		{"                  ","default:paper     ","                  "}
	}
})

minetest.register_craft({
	output = "workers:plan_lavamoat",
	recipe = {
		{"bucket:bucket_lava","default:clay_brick","bucket:bucket_lava"},
		{"default:clay_brick","default:clay_brick","default:clay_brick"},
		{"                  ","default:paper     ","                  "}
	}
})