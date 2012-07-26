local slopebox = {}
local detail = 100
for i = 0, detail-1 do
	slopebox[i+1]={-0.5, (i/detail)-0.5, (i/detail)-0.5, 0.5, (i/detail)-0.5+(1/detail), 0.5}
end

minetest.register_node("irregular:test1", {
	description = "Irregular Test 1",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	inventory_image = "default_wood.png",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	},
	node_box = {
		type = "fixed",
		fixed = slopebox,
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=3,flammable=2},
})

local cylbox = {}
local detail = 200
local sehne
for i = 1, detail-1 do
	sehne = math.sqrt(0.25 - (((i/detail)-0.5)^2))
	cylbox[i]={(i/detail)-0.5, -0.5, -sehne, (i/detail)+(1/detail)-0.5, 0.5, sehne}
end

minetest.register_node("irregular:test2", {
	description = "Irregular Test 1",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	inventory_image = "default_wood.png",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	},
	node_box = {
		type = "fixed",
		fixed = cylbox,
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=3,flammable=2},
})

