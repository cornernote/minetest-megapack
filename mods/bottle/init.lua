local craftitem_place_item = function(item, player, pos)
	minetest.env:add_item(pos, 'CraftItem "' .. item .. '" 1')
	return true
end

local craftitem_drink = function(hp_change)
	return function(item, user, pointed_thing)
		user:set_hp(user:get_hp() + hp_change)
		user:add_to_inventory_later('CraftItem "bottle:bottle_empty" 1')
		return true
	end
end

minetest.register_craft({
	output = 'CraftItem "bottle:bottle_empty" 3',
	recipe = {
		{'NodeItem "default:glass"', '', 'NodeItem "default:glass"'},
		{'', 'NodeItem "default:glass"', ''},
	}
})

minetest.register_craftitem("bottle:bottle_empty", {
	image = "bottle_empty.png", 
	liquids_pointable = true,
	on_place_on_ground = craftitem_place_item,
	on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "default:water_source" or n.name == "default:water_flowing" then
				player:add_to_inventory_later('CraftItem "bottle:bottle_water" 1')
				return true
			end
		end
		return false
	end,
})

minetest.register_craftitem("bottle:bottle_water", {
	image = "bottle_water.png", 
	on_place_on_ground = craftitem_place_item,
	on_use = craftitem_drink(0),
})

minetest.register_craft({
	output = 'CraftItem "bottle:bottle_applejuice" 1',
	recipe = {
		{'CraftItem "default:apple"'},
		{'CraftItem "default:apple"'},
		{'CraftItem "bottle:bottle_water"'},
	}
})

minetest.register_craftitem("bottle:bottle_caoh2", {
	image = "bottle_CaOH2.png",
	on_place_on_ground = craftitem_place_item,
	on_use = craftitem_drink(-2),
})

minetest.register_craft({
	output = 'CraftItem "bottle:bottle_caoh2" 1',
	recipe = {
		{'CraftItem "moreores:calcium_oxide"'},
		{'CraftItem "moreores:calcium_oxide"'},
		{'CraftItem "bottle:bottle_water"'},
	}
})

minetest.register_craftitem("bottle:bottle_hcn", {
	image = "bottle_HCN.png",
	on_place_on_ground = craftitem_place_item,
	on_use = craftitem_drink(-3),
})

minetest.register_craft({
	output = 'CraftItem "bottle:bottle_hcn" 1',
	recipe = {
		{'node "default:junglegrass"'},
		{'node "default:junglegrass"'},
		{'CraftItem "bottle:bottle_water"'},
	}
})

minetest.register_craftitem("bottle:bottle_cacn2", {
	image = "bottle_CaCN2.png",
	on_place_on_ground = craftitem_place_item,
	on_use = craftitem_drink(-999),
})
--===
minetest.register_craft({
	output = 'CraftItem "bottle:bottle_cacn2" 2',
	recipe = {
		{'craft "bottle:bottle_caoh2" 1'},
		{'craft "bottle:bottle_hcn" 1'},
	}
})
minetest.register_craft({
	output = 'CraftItem "bottle:bottle_cacn2" 2',
	recipe = {
		{'craft "bottle:bottle_hcn" 1'},
		{'craft "bottle:bottle_caoh2" 1'},
	}
})
minetest.register_craft({
	output = 'CraftItem "bottle:bottle_cacn2" 2',
	recipe = {
		{'craft "bottle:bottle_hcn" 1','craft "bottle:bottle_caoh2" 1'},
	}
})
minetest.register_craft({
	output = 'CraftItem "bottle:bottle_cacn2" 2',
	recipe = {
		{'craft "bottle:bottle_caoh2" 1','craft "bottle:bottle_hcn" 1'},
	}
})
--===
minetest.register_craftitem("bottle:bottle_applejuice", {
	image = "bottle_applejuice.png", 
	on_place_on_ground = craftitem_place_item,
	on_use = craftitem_drink(4),
})


minetest.register_craft({
	output = 'CraftItem "bottle:bottle_watermelonjuice" 1',
	recipe = {
		{'CraftItem "watermelon:watermelon_slice"'},
		{'CraftItem "watermelon:watermelon_slice"'},
		{'CraftItem "bottle:bottle_water"'},
	}
})

minetest.register_craftitem("bottle:bottle_watermelonjuice", {
	image = "bottle_watermelonjuice.png", 
	on_place_on_ground = craftitem_place_item,
	on_use = craftitem_drink(5),
})

minetest.register_craft({
	output = 'CraftItem "bottle:bottle_cactusjuice" 1',
	recipe = {
		{'NodeItem "default:cactus"'},
		{'NodeItem "default:cactus"'},
		{'CraftItem "bottle:bottle_water"'},
	}
})

minetest.register_craftitem("bottle:bottle_cactusjuice", {
	image = "bottle_cactusjuice.png", 
	on_place_on_ground = craftitem_place_item,
	on_use = craftitem_drink(3),
})


minetest.register_craft({
	output = 'CraftItem "bottle:bottle_dirtywater" 1',
	recipe = {
		{'NodeItem "default:dirt"'},
		{'NodeItem "default:dirt"'},
		{'CraftItem "bottle:bottle_water"'},
	}
})

minetest.register_craftitem("bottle:bottle_dirtywater", {
	image = "bottle_dirtywater.png", 
	on_place_on_ground = craftitem_place_item,
	on_use = craftitem_drink(-1),
})

print("[Bottle] Loaded!")
