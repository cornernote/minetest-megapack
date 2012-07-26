local list = {}
local invLength = 56
local function updateInventory(meta, start)
	local node
	local name
	local count = 0
	local inv = meta:get_inventory()
	local invStart = meta:get_int("start")
	if start < 0 then
		start = 0
	end
	inv:set_size("next", 0)
	inv:set_size("previous", 0)
	if not inv:is_empty("main") then
		for var=0,inv:get_size("main"),1 do
			inv:set_stack("main", var, nil)
		end
	end
	local modName = meta:get_string("infotext")
	local everything = false
	if modName == "" then
		everything = true
	end
	for name in pairs(list) do
		local str = list[name].name:sub(0,modName:len())
		if everything then
			modName = str
		end
		if modName == str then
			if count >= start then
				inv:add_item("main", list[name].name)
			end
			count = count+1
		end
	end
	inv:set_size("next", 1)
	inv:set_size("previous", 1)
	meta:set_int("start", start)
end
local function getModName(pos)
	local sign  = minetest.env:find_node_near(pos, .6, "default:sign_wall")
	if sign == nil then
		sign = minetest.env:find_node_near(pos, .6, "locked_sign:sign_wall_locked")
	end
	local meta
	local chestMeta = minetest.env:get_meta(pos)
	local modName = ""
	if sign == nil then
		modName = ""
	else
		meta = minetest.env:get_meta(sign)
		local str = meta:get_string("infotext")
		modName = str:sub(2,str:len()-1)
	end
	chestMeta:set_string("infotext", modName)
	updateInventory(minetest.env:get_meta(pos), 0)
end
minetest.register_node("creative_inventory:creativeChest", {
	description = "Creative Chest",
	tile_images = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[14,9;]"..
				"list[current_name;main;0,0;14,4;]"..
				"list[current_name;previous;6,4;1,1;]"..
				"list[current_name;next;7,4;1,1;]"..
				"list[current_player;main;3,5;8,4;]")
		meta:set_string("infotext", "Creative Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", invLength)
		inv:set_size("previous", 1)
		inv:set_size("next", 1)
		meta:set_int("start", 0)
		getModName(pos)
	end,
	on_punch = function(pos, node, puncher)
		getModName(pos)
	end,
	can_dig = function(pos,player)
		return true
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		print(meta:get_int("start"))
		if to_list == "previous" then
			updateInventory(meta, meta:get_int("start")-invLength)
		end
		if to_list == "next" then
			updateInventory(meta, meta:get_int("start")+invLength)		end
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    	on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    	on_metadata_inventory_take = function(pos, listname, index, count, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_take_allow_all(pos, listname, index, count, player)
	end,
})
minetest.register_on_joinplayer(function(obj)
	if minetest.setting_get('creative_mode') == '1' then
		minetest.add_to_creative_inventory('creative_inventory:creativeChest')
		local node
		for node in pairs(minetest.registered_items) do
			table.insert(list, {name = node})
		end
		table.sort(list, function(a,b)
			if a.name ~= nil and b.name ~= nil then
				return a.name < b.name
			end
		end)
	end
end)