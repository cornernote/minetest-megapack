--[[
	entertaining alchemistry
			by Hackeridze
					hackeridze@gmail.com
]]

math.randomseed(os.time())

local craftitem_drink = function(hp_change)
	return function(item, user, pointed_thing)
		user:set_hp(user:get_hp() + hp_change)
		user:add_to_inventory_later('craft "alchemistry:bottle_empty" 1')
		return true
	end
end

local alchemistry_recipes = {}

local water_recipe = function(source)
	return {
		{source},
		{source},
		{'craft "alchemistry:bottle_water"'},
	}
end

-- add_chim( "bottle_name", {bottle, recipe}, {"with_%some0%","with_%some1%"}, 
--								{"comes_to_%some3","comes_to_%some4"}, on_drinc_function)
local add_chim = function(name, brecipe, withSHORT, getSHORT, on_drink)
	local bname = "alchemistry:bottle_" .. name
	local with = "alchemistry:bottle_" .. withSHORT
	local get = "alchemistry:bottle_" .. getSHORT


	alchemistry_recipes[get] = {with, bname} -- adding recipe to recipes table

	minetest.register_craft({
		output = 'craft ' .. bname .. '',
		recipe = brecipe,
	})

	minetest.register_craftitem("alchemistry:bottle_water", {
		image = "alchemistry_bottle_water.png", 
		on_place_on_ground = craftitem_place_item,
		on_use = on_drink,
	})
end

local get_result = function(ing1,ing2)
	for result,ingredients in pairs(alchemistry_recipes) do
		if (ingredients[1] == ing1) and (ingredients[2] == ing[2]) or 
					(ingredients[1] == ing2) and (ingredients[2] == ing[1]) then 
			return result
		end
	end
end

------------------------------ Bottles ------------------------------
minetest.register_craft({
	output = 'craft "alchemistry:bottle_empty" 3',
	recipe = {
		{'node "default:glass"', '', 'node "default:glass"'},
		{'', 'node "default:glass"', ''},
	}
})

minetest.register_craftitem("alchemistry:bottle_empty", {
	image = "alchemistry_bottle_empty.png", 
	liquids_pointable = true,
	on_place_on_ground = craftitem_place_item,
	on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "default:water_source" or n.name == "default:water_flowing" then
				player:add_to_inventory_later('craft "alchemistry:bottle_water" 1')
				return true
			end
		end
		return false
	end,
})

minetest.register_craftitem("alchemistry:bottle_water", {
	image = "alchemistry_bottle_water.png", 
	on_place_on_ground = craftitem_place_item,
	on_use = craftitem_drink(0),
})

minetest.register_on_placenode(function(pos, newnode, placer)
	if newnode.name == "alchemistry:alchemistry_table" then
		local meta = minetest.env:get_meta(pos)
		meta:inventory_set_list("ing", {"", ""})
		meta:inventory_set_list("pot", {"", ""})
		meta:set_inventory_draw_spec(
			"invsize[8,9;]"
			.."list[current_name;pot;3,2;2,1;]"
			.."list[current_name;ing;3,0;2,1;]"
			.."list[current_player;main;0,4;8,4;]"
		)

		meta:set_infotext("Alchemistry table")
		meta:set_string("timer", "-999")
		meta:set_string("ings", "")
		meta:set_string("pots", "")
	end
end)
------------------------------ Bottles end ------------------------------


------------------------------ Alch table ------------------------------
minetest.register_node("alchemistry:alchemistry_table", {
	tiles = {"default_stone.png^alchemistry_alchemistry_table.png", "default_stone.png",
	"default_stone.png", "default_stone.png",
	"default_stone.png", "default_stone.png"},
	inventory_image = "default_stone.png^alchemistry_alchemistry_table.png",
	paramtype = "facedir_simple",
	metadata_name = "generic",
	material = minetest.digprop_stonelike(3.0),
})

minetest.register_abm({
	nodenames = {"alchemistry:alchemistry_table"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
   		local meta = minetest.env:get_meta(pos)
		local potlist = meta:inventory_get_list("pot")
		local inglist = meta:inventory_get_list("ing")
		local timer = tonumber(meta:get_string("timer"))
		if potlist == nil or inglist == nil then 
			meta:set_string("timer", "-999")
			return 
		end
		_, ing1 = stackstring_take_item(inglist[1])
		_, ing2 = stackstring_take_item(inglist[2])
		_, pot1 = stackstring_take_item(potlist[1])
		_, pot2 = stackstring_take_item(potlist[2])
		
		if pot1 == nil and pot2 == nil then meta:set_string("timer", -999) meta:set_infotext("Alchemistry table") return end
		if ing1 == nil and ing2 == nil then meta:set_string("timer", -999) meta:set_infotext("Alchemistry table") return end

		if timer > 0 then 
			meta:set_string("timer", timer-1) 
			meta:set_infotext("Alchemistry table, working, "..100-(2*timer).."%")
		else 
			if timer == 0 then 
				local changed = false
				if pot1.name ~= nil and pot2.name ~= nil then
					res = get_result(ing1.name, ing2.name)
					if res ~= nil then
						potlist[1] = ""
						potlist[1], success = stackstring_put_stackstring(potlist[1], res[1])
						potlist[2] = ""
						potlist[2], success = stackstring_put_stackstring(potlist[2], res[2])
						changed = true
					end
				end

				if changed == true then
					if ing1.name ~= nil then inglist[1], _ = stackstring_take_item(inglist[1]) end
					if ing2.name ~= nil then inglist[2], _ = stackstring_take_item(inglist[2]) end
				end
				meta:set_string("timer", -999)
		   		meta:set_infotext("Alchemistry table")
			else if timer < 0 then
				meta:set_string("timer", 50)
				meta:set_infotext("Alchemistry table, working, "..100-(2*timer).."%")
				end
			end
		end
		meta:inventory_set_list("pot", potlist)
		meta:inventory_set_list("ing", inglist)
	end
})
------------------------------ Alch table end ------------------------------

print("[alchemistry] Loaded!")
