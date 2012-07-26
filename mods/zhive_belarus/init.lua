math.randomseed(os.time())
--[[

Author: Victor Hackeridze hackeridze@gmail.com
LICENSE: GPLv3
TODO:

]]
local POTATO_DIRT = {
	'1',
	'2', 
}


-- Nodes
for i, state in ipairs(POTATO_DIRT) do
	minetest.register_node("zhive_belarus:dirt_with_potato_" .. state, {
		tiles = {"wheat_bed.png", "default_dirt.png"},
		inventory_image = "wheat_bed.png",
		is_ground_content = true,
		material = minetest.digprop_dirtlike(1.2),
		drop = 'craft "zhive_belarus:potato" '.. state,
	})
minetest.register_abm({
	nodenames = "zhive_belarus:dirt_with_potato_" .. state,
	interval = 60,
	chance = 1,
		action = function(pos, node, _, __)
			local p = {x = pos.x,y = pos.y+1,z = pos.z}
			local n = minetest.env:get_node(p)
				if (n.name == "zhive_belarus:sprout_6") then
					minetest.env:remove_node(pos)
					minetest.env:add_node(pos,{name = "zhive_belarus:dirt_with_potato_" .. state+1})
				elseif (n.name == "air") then
					minetest.env:add_node(p,{name = "zhive_belarus:sprout_1"})
				end
		end
})
end
minetest.register_node("zhive_belarus:dirt_with_potato_3", {
		tiles = {"wheat_bed.png", "default_dirt.png"},
		inventory_image = "wheat_bed.png",
		is_ground_content = true,
		material = minetest.digprop_dirtlike(1.2),
		drop = 'craft "zhive_belarus:potato" 3',
	})

minetest.register_abm({
	nodenames = "zhive_belarus:dirt_with_potato_3",
	interval = 40,
	chance = 2,
		action = function(pos, node, _, __)
			local p = {x = pos.x,y = pos.y+1,z = pos.z}
			local n = minetest.env:get_node(p)
				if (n.name == "air") then
					minetest.env:add_node(p,{name = "zhive_belarus:sprout_1"})
				end
		end
})


local POTATO_SPROUT_STATES = {
	'1',
	'2', 
	'3',
	'4',
	'5',
}

local LIGHT = 5 -- amount of light neded to pumpkin grow

for i, state in ipairs(POTATO_SPROUT_STATES) do
	minetest.register_abm({
		nodenames = {"zhive_belarus:sprout_" .. state,},
		interval = 30,
		chance = 2,
			action = function(pos, node, _, __)
if(math.random(1,2) ~= 1) then return; end
				local l = minetest.env:get_node_light(pos, nil)
				if (l > LIGHT) then
					minetest.env:remove_node(pos)
					minetest.env:add_node(pos, {name = "zhive_belarus:sprout_" .. state + 1})
				end

			end
	}) 
minetest.register_node("zhive_belarus:sprout_" .. state, {
	drawtype = "plantlike",
	tiles = {"zhive_belarus_sprout_" .. state .. ".png"},
	inventory_image = "zhive_belarus_sprout_" .. state .. ".png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	material = minetest.digprop_constanttime(0.3),
	furnace_burntime = 2,
	drop = "",
	wall_mounted = false,
	visual_scale = PLANTS_VISUAL_SCALE,
		selection_box = {
			type = "fixed",
			fixed = {-0.1, -1/2, -0.1, 0.1, -0.1, 0.1},
		},
	})
end


minetest.register_node("zhive_belarus:sprout_6", {
	drawtype = "plantlike",
	tiles = {"zhive_belarus_sprout_6.png"},
	inventory_image = "zhive_belarus_sprout_6.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	material = minetest.digprop_constanttime(0.3),
	furnace_burntime = 2,
	drop = "",
	wall_mounted = false,
	visual_scale = PLANTS_VISUAL_SCALE,
		selection_box = {
			type = "fixed",
			fixed = {-0.1, -1/2, -0.1, 0.1, -0.1, 0.1},
		},
	})

minetest.register_abm({
	nodenames = {"zhive_belarus:sprout_1","zhive_belarus:sprout_2","zhive_belarus:sprout_3",
"zhive_belarus:sprout_4","zhive_belarus:sprout_5","zhive_belarus:sprout_6"},
	interval = 5,
	chance = 1,
		action = function(pos, node, _, __)
			local p = {x = pos.x,y = pos.y -1,z = pos.z}
			--p.y = p.y - 1 -- it will change pos too, that cause using p.y = p.y + 1
			local under_node = minetest.env:get_node(p)
			if (under_node.name == "air") or ((under_node.name ~= "zhive_belarus:dirt_with_potato_1") and (under_node.name ~= "zhive_belarus:dirt_with_potato_2") and (under_node.name ~= "zhive_belarus:dirt_with_potato_3")) then
				--p.y = p.y + 1
				minetest.env:remove_node(pos)
			end
		end
})

-- Craftitems
minetest.register_craftitem("zhive_belarus:potato", {
	image = "zhive_belarus_potato.png",
	stack_max = 99,
	cookresult_itemstring = 'craft "zhive_belarus:baked_potato" 1',
	furnace_cooktime = 20,
	liquids_pointable = false,
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "wheat:dirt_bed" then
				minetest.env:remove_node(pointed_thing.under)
				minetest.env:add_node(pointed_thing.under, {name="zhive_belarus:dirt_with_potato_1"})
				return true
			end
		end
		return false
	end,
}) 

minetest.register_craftitem("zhive_belarus:baked_potato", {
	image = "zhive_belarus_baked_potato.png",
	stack_max = 99,
	liquids_pointable = false,
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = minetest.item_eat(4)
}) -- Craftitems end

minetest.register_on_dignode(function(pos, oldnode, digger)
	if(oldnode.name == "default:dirt_with_grass")then
		if(math.random(1,100) == 1) then digger:add_to_inventory_later('craft "zhive_belarus:potato"')
		end
	end
end)


print("[zhive_belarus] Loaded!")
