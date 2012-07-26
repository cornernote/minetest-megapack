
minetest.register_craftitem("baking:flour", {
	image = "baking_flour.png",
	on_place_on_ground = minetest.craftitem_place_item
})

minetest.register_craftitem("baking:bread", {
	image = "baking_bread.png",
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = minetest.item_eat(6)
})

minetest.register_craftitem("baking:ratburger", {
	image = "baking_ratburger.png",
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = minetest.item_eat(11)
})

minetest.register_craftitem("baking:bread_dough", {
	image = "baking_bread_dough.png",
	on_place_on_ground = minetest.craftitem_place_item,
	cookresult_itemstring = 'craft "baking:bread" 1',
	furnace_cooktime = 10.0
})

minetest.register_craft({
	output = 'craft "baking:flour" 1',
	recipe = {
		{'craft "wheat:wheat_seeds"', 'craft "wheat:wheat_seeds"'},
		{'craft "wheat:wheat_seeds"', 'craft "wheat:wheat_seeds"'},
	}
})

minetest.register_craft({
	output = 'craft "baking:ratburger" 1',
	recipe = {
		{'craft "baking:bread"'},
		{'craft "cooked_rat"'},
		{'craft "baking:bread"'},
	}
})

minetest.register_craft({
	output = 'craft "baking:bread_dough" 1',
	recipe = {
		{'craft "baking:flour"', 'craft "baking:flour"', 'craft "baking:flour"'},
		{'craft "baking:flour"', 'craft "baking:baking_form_water"', 'craft "baking:flour"'},
		{'craft "baking:flour"', 'craft "baking:flour"', 'craft "baking:flour"'},
	}
})

minetest.register_craft({
	output = 'craft "baking:baking_form_empty" 1',
	recipe = {
		{'node "default:wood"', '', 'node "default:wood"'},
		{'', 'node "default:wood"', ''},
	}
})

minetest.register_craftitem("baking:baking_form_empty", {
	image = "baking_baking_form.png",
	stack_max = 1,
	liquids_pointable = true,
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "default:water_source" then
				minetest.env:add_node(pointed_thing.under, {name="air"})
				player:add_to_inventory_later('craft "baking:baking_form_water" 1')
				return true
			end
		end
		return false
	end,
})

minetest.register_craftitem("baking:baking_form_water", {
	image = "baking_baking_form_water.png",
	stack_max = 1,
	liquids_pointable = true,
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "default:water_source" then
				-- unchanged
			elseif n.name == "default:lava_source" or n.name == "default:lava_flowing" then
				minetest.env:add_node(pointed_thing.under, {name="default:cobble"})
			else
				minetest.env:add_node(pointed_thing.above, {name="default:water_flowing"})
			end
			player:add_to_inventory_later('craft "baking:baking_form_empty" 1')
			return true
		end
		return false
	end,
})

--[[
add_grow_type("baking:wheat", {
{name = "default:dirt", odds = 50, max_height = 3},
{name = "default:dirt_with_grass", odds = 50, max_height = 3},      <<<--- NOT NEDED
{name = "default:dirt_with_grass_footsteps", odds = 50, max_height = 3}
})]]


-- brick_oven

minetest.register_node("baking:brick_oven", {
	tiles = {"default_brick.png", "default_brick.png",
		"default_brick.png", "default_brick.png",
		"default_brick.png", "default_furnace_front.png"},
	--inventory_image = "furnace_front.png",
	inventory_image = minetest.inventorycube("default_brick.png", "default_furnace_front.png"),
	paramtype = "facedir_simple",
	metadata_name = "generic",
	material = minetest.digprop_stonelike(3.0),
})

minetest.register_on_placenode(function(pos, newnode, placer)
	if newnode.name == "baking:brick_oven" then
		local meta = minetest.env:get_meta(pos)
		meta:inventory_set_list("fuel", {""})
		meta:inventory_set_list("src", {""})
		meta:inventory_set_list("dst", {"","","",""})
		meta:set_inventory_draw_spec(
			"invsize[8,9;]"
			.."list[current_name;fuel;2,3;1,1;]"
			.."list[current_name;src;2,1;1,1;]"
			.."list[current_name;dst;5,1;2,2;]"
			.."list[current_player;main;0,5;8,4;]"
		)

		meta:set_infotext("Oven: inactive")
		meta:set_string("cur_fuel", "")
		meta:set_string("cur_src", "")
		meta:set_string("cook_timer", "0")
		meta:set_string("fuel_timer", "0")
	end
end)


baking_food_items = {"baking:bread_dough", "rat", ":rat"} --,"corn:corn_seeds","corn:corn_bowl"}

minetest.register_abm({
	nodenames = {"baking:brick_oven"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.env:get_meta(pos)
		local fuellist = meta:inventory_get_list("fuel")
		local srclist = meta:inventory_get_list("src")
		local dstlist = meta:inventory_get_list("dst")
		local cook_timer = tonumber(meta:get_string("cook_timer"))

		if fuellist == nil or srclist == nil or dstlist == nil then
			if cook_timer ~= -1 then
				meta:set_infotext("Oven: inactive")
				meta:set_string("cook_timer", "-1")
			end
			return
		end
		_, srcitem = stackstring_take_item(srclist[1])
		_, fuelitem = stackstring_take_item(fuellist[1])

		if not srcitem or not fuelitem then
			if cook_timer ~= -1 then
				meta:set_infotext("Oven: inactive")
				meta:set_string("cook_timer", "-1")
			end
			return
		end

		local fuel_burntime = 0

		if fuelitem.type == "node" then
			local prop = minetest.registered_nodes[fuelitem.name]
			if prop == nil then
				if cook_timer ~= -1 then
					meta:set_infotext("Oven: inactive")
					meta:set_string("cook_timer", "-1")
				end
				return
			end
			if prop.furnace_burntime < 0 then return end
			fuel_burntime = prop.furnace_burntime
		elseif fuelitem.type == "craft" then
			local prop = minetest.registered_craftitems[fuelitem.name]
			if prop == nil then
				if cook_timer ~= -1 then
					meta:set_infotext("Oven: inactive")
					meta:set_string("cook_timer", "-1")
				end
				return
			end
			if prop.furnace_burntime < 0 then return end
			fuel_burntime = prop.furnace_burntime
		else
			if cook_timer ~= -1 then
				meta:set_infotext("Oven: inactive")
				meta:set_string("cook_timer", "-1")
			end
			return
		end

		local cur_fuel = meta:get_string("cur_fuel")
		local cur_src = meta:get_string("cur_src")

		if cur_fuel ~= fuelitem.name or cur_src ~= srcitem.name then
			if cur_fuel ~= fuelitem.name then
				meta:set_string("fuel_timer", "0")
			end
			meta:set_string("cur_fuel", fuelitem.name)
			meta:set_string("cur_src", srcitem.name)
			meta:set_string("cook_timer", "0")
			meta:set_infotext("Oven: inactive")
			return
		end

		local resultstack = nil
		if srcitem.type == "craft" then
			local prop = minetest.registered_craftitems[srcitem.name]
			if prop == nil then
				if cook_timer ~= -1 then
					meta:set_infotext("Oven: inactive")
					meta:set_string("cook_timer", "-1")
				end
				return
			end
			if prop.cookresult_itemstring == "" then return end
			if prop.furnace_cooktime == nil then prop.furnace_cooktime = 1.0 end

			-- check if food type
			for _, n in pairs(baking_food_items) do
				if srcitem.name == n then
					local fuel_timer = tonumber(meta:get_string("fuel_timer"))
					fuel_timer = fuel_timer + 1
					meta:set_string("fuel_timer", fuel_timer)

					-- here is why you would use the oven instead of the normal furnace
					-- cooktime is cut in half, but it only works for items listed in baking_food_items
					if cook_timer >= math.ceil(prop.furnace_cooktime/2) then
						resultstack = prop.cookresult_itemstring
					else
						meta:set_infotext("Oven: cooking "..math.abs(100*(cook_timer/math.ceil(prop.furnace_cooktime/2))).."%")
						cook_timer = cook_timer + 1
						meta:set_string("cook_timer", cook_timer)
						return
					end
					break
				end
			end
		else
			return
		end

		if resultstack == nil then
			return
		end

		dstlist[1], success = stackstring_put_stackstring(dstlist[1], resultstack)
		if not success then
			return
		end

		local fuel_timer = tonumber(meta:get_string("fuel_timer"))
		if fuel_timer > fuel_burntime then
			fuellist[1], _ = stackstring_take_item(fuellist[1])
			meta:set_string("fuel_timer", "0")
		end
		srclist[1], _ = stackstring_take_item(srclist[1])

		meta:inventory_set_list("fuel", fuellist)
		meta:inventory_set_list("src", srclist)
		meta:inventory_set_list("dst", dstlist)

		meta:set_string("cook_timer", "0")
		meta:set_infotext("Oven: cooking ")
	end
})

minetest.register_craft({
	output = 'node "baking:brick_oven" 1',
	recipe = {
		{'node "default:brick"', 'node "default:brick"', 'node "default:brick"'},
		{'node "default:brick"', '', 'node "default:brick"'},
		{'node "default:brick"', 'node "default:brick"', 'node "default:brick"'},
	}
})

print("[Baking] Loaded!")
