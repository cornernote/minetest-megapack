--[[
Workers Mod
By LocaL_ALchemisT (prof_awang@yahoo.com)
License: WTFPL
Version: 2.0
--]]

dofile(minetest.get_modpath("workers").."/abm.lua")
dofile(minetest.get_modpath("workers").."/fungsi.lua")
dofile(minetest.get_modpath("workers").."/craft.lua")

-- HARVEY THE HARVESTER

minetest.register_node("workers:harvester", {
	description = "Harvey The Harvester",
	tile_images = worker_images("harvey"),
	stack_max = 1,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=2,flammable=1,worker=1},
	legacy_facedir_simple = true,
	after_place_node = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "hack:sign_text_input")
		meta:set_string("infotext", "What should I harvest, Master?")
		meta:set_string("text","mod:node")
		meta:set_string("master",player:get_player_name())
		meta:set_string("material","")
		meta:set_int("quantity",0)
		meta:set_int("status",0)
		meta:set_int("start_work",0)
		if minetest.env:get_node(pos).param2 < 2 then meta:set_int("previousdir",(minetest.env:get_node(pos).param2+2))
		else meta:set_int("previousdir",(minetest.env:get_node(pos).param2-2)) end
		minetest.chat_send_player(player:get_player_name(), "Harvey: Hello, Master.")
	end,
	on_receive_fields = function(pos, formname, fields, player)
		local meta = minetest.env:get_meta(pos)
		local master = meta:get_string("master")
		local name = player:get_player_name()
		if name ~= master then
			defend(player,master,"Harvey")
			return
		end
		fields.text = fields.text or ""
		local itemstack = ItemStack(fields.text)
		local nodename = itemstack:get_name()
		if itemstack:is_empty() then minetest.chat_send_player(name, "Harvey: What do you want me to harvest, Master?")
		elseif not itemstack:is_known() then minetest.chat_send_player(name, "Harvey: What is that, Master?")
		elseif nodename == "default:lava_flowing" or nodename == "default:lava_source" or nodename == "default:water_flowing" or nodename == "default:water_source" or nodename == "air" then minetest.chat_send_player(name, "Harvey: That is forbidden, Master.")
		elseif nodename == "workers:assassin" or nodename == "workers:thief" then minetest.chat_send_player(name, "Harvey: No, Master.")
		else
			minetest.chat_send_player(name, "Harvey: "..nodename..", as you wish, Master.")
			meta:set_string("infotext", "I will harvest "..nodename..", Master.")
			meta:set_string("text",nodename)
			meta:set_string("material",nodename)
			meta:set_int("status",1)
		end
	end,
	on_punch = function(pos, node, player)
		local meta = minetest.env:get_meta(pos)
		local master = meta:get_string("master")
		if player:get_player_name() ~= master then
			defend(player,master,"Harvey")
			return
		end
		if meta:get_int("status") == 0 then return end
		
		if meta:get_int("start_work") == 0 then --if Harvey hasn't moved yet
			meta:set_int("start_work",1)
			minetest.chat_send_player(master, "Harvey: I will go now, Master.")
		else --if Harvey has moved
			player:get_inventory():add_item("main", "workers:harvester")
			print(meta:get_string("material")..": "..meta:get_int("quantity"))
			if meta:get_int("quantity") > 0 then
				player:get_inventory():add_item("main", "\""..meta:get_string("material").."\" "..meta:get_int("quantity"))
				minetest.chat_send_player(master, "Harvey: I have collected "..meta:get_int("quantity").." "..meta:get_string("material")..", Master.")
			end
			minetest.chat_send_player(master, "Harvey: Pleasure to work for you, Master.")
			minetest.env:remove_node(pos)
		end
		print (meta:get_int("start_work"))
	end,
})

-- MORDEC THE MINER

minetest.register_node("workers:miner", {
	description = "Mordec The Miner",
	tile_images = worker_images("mordec"),
	stack_max = 1,
	paramtype = "light",
	light_source = 13,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=2,flammable=1,worker=1},
	legacy_facedir_simple = true,
	
	after_place_node = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
						"invsize[8,7;]"..
						"list[current_player;main;0,3;8,4;]"..
						"list[current_name;wood;0,0;1,1;]"..
						"image[0,1;1,1;default_wood.png]"..
						"list[current_name;ores;2,0;6,2;]")
		local inv = meta:get_inventory()
		inv:set_size("wood", 1)
		inv:set_size("ores", 12)
		meta:set_string("infotext", "Give me wood and i'll start digging, Master")
		meta:set_string("master",player:get_player_name())
		meta:set_int("status",0)
		meta:set_int("start_work",0)
		minetest.chat_send_player(player:get_player_name(), "Mordec: *bzzt* Hello, Master.")
	end,
	
	on_punch = function(pos, node, player)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		local master = meta:get_string("master")
		if player:get_player_name() ~= master then
			defend(player,master,"Mordec")
			return
		end
		
		if inv:get_stack("wood",1):to_table() == nil then return
		elseif inv:get_stack("wood",1):to_table().name ~= "default:wood" then return end
		
		if meta:get_int("start_work") == 0 then --if Mordec hasn't moved yet
			meta:set_int("start_work",1)
			minetest.chat_send_player(master, "Mordec: I will go now, Master.")
		else --if Mordec has moved
			meta:set_int("status",0)
			meta:set_int("start_work",0)
		end
	end,
	
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		local master = meta:get_string("master")
		local inv = meta:get_inventory()
		if not (inv:is_empty("wood") and inv:is_empty("ores")) then
			minetest.chat_send_player(master, "Mordec: *error* I cannot leave yet, Master. There are items in my inventory.")
			return false
		end
		minetest.chat_send_player(master, "Mordec: Pleasure to work for you, Master. *shutdown*")
		return true
	end,
})

-- GARREN THE GARDENER

minetest.register_node("workers:gardener", {
	description = "Garren The Gardener",
	tile_images = worker_images("garren"),
	stack_max = 1,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=2,flammable=1,worker=1},
	legacy_facedir_simple = true,
	
	after_place_node = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
						"invsize[8,6;]"..
						"list[current_player;main;0,2;8,4;]"..
						"list[current_name;plant;2,0;1,1;]"..
						"list[current_name;sapling;5,0;1,1;]"..
						"image[6,0;1,1;default_sapling.png]")
		local inv = meta:get_inventory()
		inv:set_size("plant", 1)
		inv:set_size("sapling", 1)
		meta:set_string("infotext", "Can I have a plant sample and some saplings, Master?")
		meta:set_string("master",player:get_player_name())
		meta:set_int("status",0)
		meta:set_int("start_work",0)
		if minetest.env:get_node(pos).param2 < 2 then meta:set_int("previousdir",(minetest.env:get_node(pos).param2+2))
		else meta:set_int("previousdir",(minetest.env:get_node(pos).param2-2)) end
		meta:set_int("clockwise",0)
		minetest.chat_send_player(player:get_player_name(), "Garren: Hello, Master.")
	end,
	
	on_punch = function(pos, node, player)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		local master = meta:get_string("master")
		if player:get_player_name() ~= master then
			defend(player,master,"Garren")
			return
		end
		
		if inv:get_stack("sapling",1):to_table() == nil then return
		elseif inv:get_stack("sapling",1):to_table().name ~= "default:sapling" then return end
		
		if meta:get_int("start_work") == 0 then --if Garren hasn't moved yet
			meta:set_int("start_work",1)
			minetest.chat_send_player(master, "Garren: I will go now, Master.")
		else --if Garren has moved
			meta:set_int("status",0)
			meta:set_int("start_work",0)
		end
	end,
	
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		local master = meta:get_string("master")
		local inv = meta:get_inventory()
		if not (inv:is_empty("plant") and inv:is_empty("sapling")) then
			minetest.chat_send_player(master, "Garren: I cannot leave yet, Master. There are items in my inventory.")
			return false
		end
		minetest.chat_send_player(master, "Garren: Pleasure to work for you, Master.")
		return true
	end,
})

-- BENJO THE BUILDER

minetest.register_node("workers:builder", {
	description = "Benjo The Builder",
	tile_images = worker_images("benjo"),
	stack_max = 1,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=2,flammable=1,worker=1},
	legacy_facedir_simple = true,
	
	after_place_node = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
						"invsize[8,6;]"..
						"list[current_player;main;0,2;8,4;]"..
						"list[current_name;plan;2,0;1,1;]"..
						"list[current_name;material;5,0;1,1;]"..
						"image[6,0;1,1;default_brick.png]")
		local inv = meta:get_inventory()
		inv:set_size("plan", 1)
		inv:set_size("material", 1)
		meta:set_string("infotext", "I can build simple structures, Master")
		meta:set_string("master",player:get_player_name())
		meta:set_int("start_work",0)
		minetest.chat_send_player(player:get_player_name(), "Benjo: Hello, Master.")
	end,
	
	on_punch = function(pos, node, player)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		local master = meta:get_string("master")
		if player:get_player_name() ~= master then
			defend(player,master,"Benjo")
			return
		end
		
		if inv:is_empty("plan") or inv:is_empty("material") then return end
		
		if meta:get_int("start_work") == 0 then --if Benjo hasn't moved yet
			meta:set_int("start_work",1)
			minetest.chat_send_player(master, "Benjo: Right away, Master.")
		end
	end,
	
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		local master = meta:get_string("master")
		local inv = meta:get_inventory()
		if not (inv:is_empty("plan")) and not (inv:is_empty("material")) then
			minetest.chat_send_player(master, "Benjo: I cannot leave yet, Master. There are items in my inventory.")
			return false
		end
		minetest.chat_send_player(master, "Benjo: Pleasure to work for you, Master.")
		return true
	end,
})

-- GREDO THE GUARD

minetest.register_node("workers:guard", {
	description = "Gredo The Guard",
	tile_images = worker_images("gredo"),
	stack_max = 1,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=2,flammable=1},
	legacy_facedir_simple = true,
	
	after_place_node = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
						"invsize[8,6;]"..
						"list[current_name;catch;0,0;8,1;]"..
						"list[current_player;main;0,2;8,4;]")
		local inv = meta:get_inventory()
		inv:set_size("catch", 8)
		meta:set_string("infotext", "I catch'em when I see'em, Boss.")
		meta:set_string("master",player:get_player_name())
		meta:set_int("status",0)
		minetest.chat_send_player(player:get_player_name(), "Gredo: Hello, Boss.")
	end,
	
	on_punch = function(pos, node, player)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		local master = meta:get_string("master")
		if player:get_player_name() ~= master then
			minetest.chat_send_player(player:get_player_name(), "Gredo: Hands off!")
			minetest.chat_send_player(master, "Gredo: "..player:get_player_name().."'s picking up a fight, Boss.")
			player:set_hp(player:get_hp()-8)
		end
	end,
	
	on_metadata_inventory_take = function(pos, listname, index, count, player)
		local meta = minetest.env:get_meta(pos)
		local master = meta:get_string("master")
		if player:get_player_name() ~= master then
			player:set_hp(player:get_hp()-8)
			minetest.chat_send_player(master, "Gredo: Hands off!")
			return
		end
		return minetest.node_metadata_inventory_take_allow_all(pos, listname, index, count, player)
	end,
	
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		local master = meta:get_string("master")
		local inv = meta:get_inventory()
		if not (inv:is_empty("catch")) then
			minetest.chat_send_player(master, "Gredo: Better take these intruders first, Boss.")
			return false
		end
		minetest.chat_send_player(master, "Gredo: Pleasure to work for you, Boss.")
		return true
	end,
})

-- ASVARD THE ASSASSIN

minetest.register_node("workers:assassin", {
	description = "Asvard The Assassin",
	tile_images = worker_images("asvard"),
	stack_max = 1,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=2,flammable=1,badguy=1},
	legacy_facedir_simple = true,
	after_place_node = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "hack:sign_text_input")
		meta:set_string("infotext", "Give me name, Master")
		meta:set_string("text","")
		meta:set_string("master",player:get_player_name())
		meta:set_string("target","")
		meta:set_int("status",0)
		meta:set_int("start_work",0)
		minetest.chat_send_player(player:get_player_name(), "Asvard: ...Master.")
		minetest.sound_play("asvard_00", {pos = pos, gain = 1.0, max_hear_distance = 10,})
	end,
	on_receive_fields = function(pos, formname, fields, player)
		local meta = minetest.env:get_meta(pos)
		local master = meta:get_string("master")
		local name = player:get_player_name()
		if name ~= master then
			player:set_hp(0)
			return
		end
		fields.text = fields.text or ""
		meta:set_string("target",fields.text)
		if meta:get_string("target") == "" then minetest.chat_send_player(name, "Asvard: Name your target, Master.")
		else
			if meta:get_string("target") == name then minetest.chat_send_player(name, "Asvard: Are you sure, Master?")
			else minetest.chat_send_player(name, "Asvard: "..meta:get_string("target")..", as you wish, Master.") end
			
			meta:set_string("infotext", "..."..meta:get_string("target"))
			meta:set_string("text",meta:get_string("target"))
			meta:set_int("status",1)
		end
	end,
	on_punch = function(pos, node, player)
		local meta = minetest.env:get_meta(pos)
		local master = meta:get_string("master")
		if player:get_player_name() ~= master then
			player:set_hp(0)
			return
		end
		if meta:get_int("status") == 0 then return end
		
		if meta:get_int("start_work") == 0 then
			meta:set_int("start_work",1)
		else
			minetest.sound_play("asvard_00", {pos = pos, gain = 1.0, max_hear_distance = 10,})
			minetest.env:remove_node(pos)
			minetest.env:add_item(pos,"default:sword_steel")
		end
	end,
})

-- TOCO THE THIEF

minetest.register_node("workers:thief", {
	description = "Toco The Thief",
	--drawtype = "glasslike",
	tile_images = worker_images("toco"),
	stack_max = 1,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=2,flammable=1,badguy=1},
	legacy_facedir_simple = true,
	
	after_place_node = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
						"invsize[8,9;]"..
						"list[current_name;loot;0,0;8,4;]"..
						"list[current_player;main;0,5;8,4;]")
		local inv = meta:get_inventory()
		inv:set_size("loot", 32)
		meta:set_string("master",player:get_player_name())
		meta:set_int("status",0)
		minetest.chat_send_player(player:get_player_name(), "Toco: Hey, Boss.")
	end,
	
	on_punch = function(pos, node, player)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		local master = meta:get_string("master")
		if player:get_player_name() ~= master then
			minetest.chat_send_player(player:get_player_name(), "Toco: Ouch!")
			for i = 1,32 do
				if not inv:get_stack("loot",i):is_empty() then
					print("not nil")
					minetest.env:add_item({x = pos.x + (math.random(1,5)-3), y = pos.y, z = pos.z + (math.random(1,5)-3)},inv:get_stack("loot", i))
					inv:set_stack("loot", i, inv:remove_item("loot", i))
					return
				end
			end
		end
	end,
	
	on_metadata_inventory_take = function(pos, listname, index, count, player)
		local meta = minetest.env:get_meta(pos)
		local master = meta:get_string("master")
		if player:get_player_name() ~= master then
			player:set_hp(player:get_hp()-3)
			minetest.chat_send_player(master, "Toco: Hands off!")
			return
		end
		return minetest.node_metadata_inventory_take_allow_all(pos, listname, index, count, player)
	end,
	
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		local master = meta:get_string("master")
		local inv = meta:get_inventory()
		if not (inv:is_empty("loot")) then
			minetest.chat_send_player(master, "Toco: You sure you don't wanna have these loots, Boss?")
			return false
		end
		if player:get_player_name() ~= master then
			minetest.chat_send_player(player:get_player_name(), "Toco: You're not gonna take me anywhere!")
			minetest.env:remove_node(pos)
			return false
		end
		minetest.chat_send_player(master, "Toco: Pleasure to work for you, Boss.")
		return true
	end,
})

-- CARDON THE COP

minetest.register_node("workers:cop", {
	description = "Cardon The Cop",
	tile_images = worker_images("cardon"),
	stack_max = 1,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=2,flammable=1,goodguy=1},
	legacy_facedir_simple = true,
	
	after_place_node = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("infotext", "I won't let them get away, Boss")
		meta:set_string("master",player:get_player_name())
		meta:set_string("criminal","")
		meta:set_int("status",0)
		minetest.chat_send_player(player:get_player_name(), "Cardon: Officer Cardon at your service.")
	end,
	
	on_punch = function(pos, node, player)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		local master = meta:get_string("master")
		if player:get_player_name() ~= master then
			defend(player,master,"Cardon")
			return
		end
	end,
	
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		local master = meta:get_string("master")
		local inv = meta:get_inventory()
		minetest.chat_send_player(master, "Cardon: Pleasure to work for you, Boss.")
		return true
	end,
})

-- BENJO'S PLANS

minetest.register_craftitem("workers:plan_house", {
	description = "House Plan",
	inventory_image = "plan_house.png",
	stack_max = 1,
})

minetest.register_craftitem("workers:plan_hut", {
	description = "Hut Plan",
	inventory_image = "plan_hut.png",
	stack_max = 1,
})

minetest.register_craftitem("workers:plan_pool", {
	description = "Pool Plan",
	inventory_image = "plan_pool.png",
	stack_max = 1,
})

minetest.register_craftitem("workers:plan_moat", {
	description = "Moat Plan",
	inventory_image = "plan_moat.png",
	stack_max = 1,
})

minetest.register_craftitem("workers:plan_tower", {
	description = "Tower Plan",
	inventory_image = "plan_tower.png",
	stack_max = 1,
})

minetest.register_craftitem("workers:plan_ubunker", {
	description = "Underground Bunker Plan",
	inventory_image = "plan_ubunker.png",
	stack_max = 1,
})

minetest.register_craftitem("workers:plan_wall", {
	description = "9x9 Wall Plan",
	inventory_image = "plan_wall.png",
	stack_max = 1,
})

minetest.register_craftitem("workers:plan_lavapool", {
	description = "Lava Pool Plan",
	inventory_image = "plan_lavapool.png",
	stack_max = 1,
})

minetest.register_craftitem("workers:plan_lavamoat", {
	description = "Lava Moat Plan",
	inventory_image = "plan_lavamoat.png",
	stack_max = 1,
})

-- ALIASES

minetest.register_alias("harvey","workers:harvester")
minetest.register_alias("harvester","workers:harvester")

minetest.register_alias("garren","workers:gardener")
minetest.register_alias("gardener","workers:gardener")

minetest.register_alias("mordec","workers:miner")
minetest.register_alias("miner","workers:miner")

minetest.register_alias("benjo","workers:builder")
minetest.register_alias("builder","workers:builder")

minetest.register_alias("gredo","workers:guard")
minetest.register_alias("guard","workers:guard")

minetest.register_alias("asvard","workers:assassin")
minetest.register_alias("assassin","workers:assassin")

minetest.register_alias("toco","workers:thief")
minetest.register_alias("thief","workers:thief")

minetest.register_alias("cardon","workers:cop")
minetest.register_alias("cop","workers:cop")