minetest.register_node("farming:rubber_sapling", {
	description = "Rubber Tree Sapling",
	drawtype = "plantlike",
	tiles = {"farming_rubber_sapling.png"},
	inventory_image = "farming_rubber_sapling.png",
	wield_image = "farming_rubber_sapling.png",
	paramtype = "light",
	walkable = false,
	groups = {dig_immediate=3,flammable=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("farming:rubber_tree_full", {
	description = "Rubber Tree",
	tiles = {"default_tree_top.png", "default_tree_top.png", "farming_rubber_tree_full.png"},
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	drop = "default:tree",
	sounds = default.node_sound_wood_defaults(),
	
	on_dig = function(pos, node, digger)
		minetest.node_dig(pos, node, digger)
		minetest.env:remove_node(pos)
	end,
	
	after_destruct = function(pos, oldnode)
		oldnode.name = "farming:rubber_tree_empty"
		minetest.env:set_node(pos, oldnode)
	end
})


minetest.register_node("farming:rubber_tree_empty", {
	tiles = {"default_tree_top.png", "default_tree_top.png", "farming_rubber_tree_empty.png"},
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2, not_in_creative_inventory=1},
	drop = "default:tree",
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_abm({
	nodenames = {"farming:rubber_tree_empty"},
	interval = 60,
	chance = 15,
	action = function(pos, node)
		node.name = "farming:rubber_tree_full"
		minetest.env:set_node(pos, node)
	end
})

minetest.register_node("farming:rubber_leaves", {
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_leaves.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2, not_in_creative_inventory=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'farming:rubber_sapling'},
				rarity = 20,
			},
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

local generate_rubber_tree = function(pos)
	node = {name = ""}
	for dy=1,4 do
		pos.y = pos.y+dy
		if minetest.env:get_node(pos).name ~= "air" then
			return
		end
		pos.y = pos.y-dy
	end
	node.name = "farming:rubber_tree_full"
	for dy=0,4 do
		pos.y = pos.y+dy
		minetest.env:set_node(pos, node)
		pos.y = pos.y-dy
	end
	
	node.name = "farming:rubber_leaves"
	pos.y = pos.y+3
	for dx=-2,2 do
		for dz=-2,2 do
			for dy=0,3 do
				pos.x = pos.x+dx
				pos.y = pos.y+dy
				pos.z = pos.z+dz
				
				if dx == 0 and dz == 0 and dy==3 then
					if minetest.env:get_node(pos).name == "air" and math.random(1, 5) <= 4 then
						minetest.env:set_node(pos, node)
					end
				elseif dx == 0 and dz == 0 and dy==4 then
					if minetest.env:get_node(pos).name == "air" and math.random(1, 5) <= 4 then
						minetest.env:set_node(pos, node)
					end
				elseif math.abs(dx) ~= 2 and math.abs(dz) ~= 2 then
					if minetest.env:get_node(pos).name == "air" then
						minetest.env:set_node(pos, node)
					end
				else
					if math.abs(dx) ~= 2 or math.abs(dz) ~= 2 then
						if minetest.env:get_node(pos).name == "air" and math.random(1, 5) <= 4 then
							minetest.env:set_node(pos, node)
						end
					end
				end
				
				pos.x = pos.x-dx
				pos.y = pos.y-dy
				pos.z = pos.z-dz
			end
		end
	end
end

minetest.register_abm({
	nodenames = {"farming:rubber_sapling"},
	interval = 60,
	chance = 15,
	action = function(pos, node)
		generate_rubber_tree(pos)
	end
})

minetest.register_on_generated(function(minp, maxp, blockseed)
	if math.random(1, 100) ~= 1 then
		return
	end
	local tmp = {x=(maxp.x-minp.x)/2+minp.x, y=(maxp.y-minp.y)/2+minp.y, z=(maxp.z-minp.z)/2+minp.z}
	local pos = minetest.env:find_node_near(tmp, maxp.x-minp.x, {"default:dirt_with_grass"})
	if pos ~= nil then
		generate_rubber_tree({x=pos.x, y=pos.y+1, z=pos.z})
	end
end)

minetest.register_craftitem("farming:bucket_rubber", {
	inventory_image = "farming_bucket_rubber.png",
	stack_max = 1,
})

local bucket_tmp = {
	source = "farming:rubber_tree_full",
	itemname = "farming:bucket_rubber"
}
bucket.liquids["farming:rubber_tree_full"] = bucket_tmp

-- ========= FUEL =========
minetest.register_craft({
	type = "fuel",
	recipe = "farming:rubber_sapling",
	burntime = 10
})
