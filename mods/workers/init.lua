--[[
Workers Mod
By LocaL_ALchemisT (prof_awang@yahoo.com)
License: WTFPL
Version: 1.0
--]]

dofile(minetest.get_modpath("workers").."/fungsi.lua")
dofile(minetest.get_modpath("workers").."/craft.lua")
local STAT_LIM = 5

-- HARVEY THE HARVESTER

minetest.register_node("workers:harvester", {
	description = "Harvey The Harvester",
	tile_images = worker_images("harvey"),
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=2,flammable=1},
	legacy_facedir_simple = true,
	after_place_node = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "hack:sign_text_input")
		meta:set_string("infotext", "What should I harvest, Master?")
		meta:set_string("text","mod:node")
		meta:set_string("master",player:get_player_name() or "")
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
		print(itemstack:to_string())
		local nodename = itemstack:get_name()
		if itemstack:is_empty() then minetest.chat_send_player(name, "Harvey: What do you want me to harvest, Master?")
		elseif not itemstack:is_known() then minetest.chat_send_player(name, "Harvey: What is that, Master?")
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

minetest.register_abm({
	nodenames = {"workers:harvester"},
	interval = 2,
	chance = 1,
	action = function(p, node, _, _)
		local meta = minetest.env:get_meta(p)
		local hasMaterial = false
		if meta:get_int("start_work") == 1 then
			for x = -1,1 do
				for y = 0,1 do
					for z = -1,1 do
						local pp = {x=p.x+x,y=p.y+y,z=p.z+z}
						if peek(pp,meta:get_string("material")) then
							minetest.env:remove_node(pp)
							meta:set_int("quantity",meta:get_int("quantity")+1)
							if hasMaterial == false then hasMaterial = true end
							if meta:get_int("status") == 1 then
								speak(meta:get_string("master"), "Harvey: I am at "..minetest.pos_to_string(p)..", Master")
								meta:set_int("status",2)
							end
						end
					end
				end
			end
			
			if hasMaterial == false then
				local where = faceTo(p,meta:get_int("previousdir"),0)
				if where ~= nil then
					local np = shouldFall(where.pos)
					meta:set_int("previousdir",where.face)
					minetest.env:add_node(np,{name="workers:harvester",param2=where.face})
					local meta2 = minetest.env:get_meta(np)
					meta2:from_table(meta:to_table())
					minetest.env:remove_node(p)
					if meta2:get_int("status") == STAT_LIM then
						speak(meta:get_string("master"), "Harvey: I am at "..minetest.pos_to_string(p)..", Master")
					end
				else
					if meta:get_int("status") == STAT_LIM then
						speak(meta:get_string("master"), "Harvey: Sorry Master, I cannot move. I am at "..minetest.pos_to_string(p))
					end
				end
			else print(meta:get_int("quantity").." "..meta:get_string("material").." gathered.") end
			
			if meta:get_int("status") == STAT_LIM then meta:set_int("status",1)
			else meta:set_int("status",meta:get_int("status")+1) end
		end
	end,
})

-- MORDEC THE MINER

minetest.register_node("workers:miner", {
	description = "Mordec The Miner",
	tile_images = worker_images("mordec"),
	paramtype = "light",
	light_source = 13,
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=2,flammable=1},
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
		meta:set_string("master",player:get_player_name() or "my Master")
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

minetest.register_abm({
	nodenames = {"workers:miner"},
	interval = 2,
	chance = 1,
	action = function(p, node, _, _)
		local meta = minetest.env:get_meta(p)
		local inv = meta:get_inventory()
		if meta:get_int("start_work") == 0 then return end
		
		if inv:get_stack("wood",1):to_table() == nil then
			meta:set_int("status",0)
			meta:set_int("start_work",0)
			speak(meta:get_string("master"), "Mordec: I am at "..minetest.pos_to_string(p)..", Master. I am out of wood.")
			return
		end
		local isFull = true
		for i = 1,12 do
			local orestack = inv:get_stack("ores",i)
			if orestack:get_free_space() > 0 then isFull = false end
		end
		if isFull == true then
			meta:set_int("start_work",0)
			speak(meta:get_string("master"), "Mordec: I am at "..minetest.pos_to_string(p)..", Master. My inventory is full.")
			return
		end
		
		local orelist = inv:get_list("ores")
		for x = -1,1 do
			for y = -1,0 do
				for z = -1,1 do
					local pp = {x=p.x+x,y=p.y+y,z=p.z+z}
					if minetest.env:get_node(pp).name ~= "workers:miner"
					and minetest.env:get_node(pp).name ~= "default:ladder"
					and minetest.env:get_node(pp).name ~= "air"
					and minetest.env:get_node(pp).name ~= "default:water_source"
					and minetest.env:get_node(pp).name ~= "default:water_flowing"
					and minetest.env:get_node(pp).name ~= "default:lava_source"
					and minetest.env:get_node(pp).name ~= "default:lava_flowing" then
						local ore = get_ore(minetest.env:get_node(pp).name)
						if ore ~= nil and ore ~= "air" then inv:add_item("ores",ore) end
						minetest.env:remove_node(pp)
					end
				end
			end
		end
		local np = shouldFall_miner(p)
		minetest.env:add_node(np,{name="workers:miner",param2=minetest.env:get_node(p).param2})
		local meta2 = minetest.env:get_meta(np)
		meta2:from_table(meta:to_table())
		meta2:get_inventory():remove_item("wood",'"default:wood" 1')
		minetest.env:remove_node(p)
		if meta2:get_int("status") == 0 then minetest.env:add_node(p,{name="default:torch"}) end
		if meta2:get_int("status") == STAT_LIM then
			speak(meta2:get_string("master"), "Mordec: I am at "..minetest.pos_to_string(p)..", Master")
		end
		
		if meta2:get_int("status") == STAT_LIM then meta2:set_int("status",0)
		else meta2:set_int("status",meta2:get_int("status")+1) end
	end,
})

-- GARREN THE GARDENER

minetest.register_node("workers:gardener", {
	description = "Garren The Gardener",
	tile_images = worker_images("garren"),
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=2,flammable=1},
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
		meta:set_string("master",player:get_player_name() or "my Master")
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

minetest.register_abm({
	nodenames = {"workers:gardener"},
	interval = 2,
	chance = 1,
	action = function(p, node, _, _)
		local meta = minetest.env:get_meta(p)
		local inv = meta:get_inventory()
		local plant = inv:get_stack("plant",1):to_table()
		local sapling = inv:get_stack("sapling",1):to_table()
		
		if meta:get_int("start_work") == 0 then return end
		
		if sapling == nil then
			meta:set_int("status",0)
			meta:set_int("start_work",0)
			speak(meta:get_string("master"), "Garren: I am at "..minetest.pos_to_string(p)..", Master. I am out of sapling.")
			return
		end
		
		local where = nil
		if meta:get_int("clockwise") == 0 then
			where = anticlockwise(p,meta:get_int("previousdir"))
			if where == nil then
				where = clockwise(p,meta:get_int("previousdir"))
				meta:set_int("clockwise",1)
			end
		elseif meta:get_int("clockwise") == 1 then
			where = clockwise(p,meta:get_int("previousdir"))
			if where == nil then
				where = clockwise(p,meta:get_int("previousdir"))
				meta:set_int("clockwise",0)
			end
		end
		if where == nil then where = faceTo(p,meta:get_int("previousdir"),0) end
		
		if where ~= nil then
			local np = shouldFall(where.pos)
			meta:set_int("previousdir",where.face)
			minetest.env:add_node(np,{name="workers:gardener",param2=where.face})
			local meta2 = minetest.env:get_meta(np)
			meta2:from_table(meta:to_table())
			minetest.env:remove_node(p)
			
			local inv2 = meta2:get_inventory()
			if plant.name == "default:jungletree" and sapling.count >= 9 then
				for h = 0,3 do minetest.env:add_node({x = p.x,y = p.y+h,z = p.z},{name=plant.name}) end
				for x = -1,1 do
					for y = 2,4 do
						for z = -1,1 do
							if minetest.env:get_node({x = p.x+x,y = p.y+y,z = p.z+z}).name == "air" then
								minetest.env:add_node({x = p.x+x,y = p.y+y,z = p.z+z},{name="default:leaves"})
							end
						end
					end
				end
				inv2:remove_item("sapling",'"default:sapling" 9')
			elseif (plant.name == "default:cactus" or plant.name == "default:papyrus") and sapling.count >= 3 then
				for h = 0,2 do minetest.env:add_node({x = p.x,y = p.y+h,z = p.z},{name=plant.name}) end
				inv2:remove_item("sapling",'"default:sapling" 3')
			elseif (plant.name == "default:junglegrass" or plant.name == "default:dry_shrub") then
				minetest.env:add_node(p,{name=plant.name})
				inv2:remove_item("sapling","default:sapling")
			else
				minetest.env:add_node(p,{name="default:sapling"})
				inv2:remove_item("sapling","default:sapling")
			end
			
			if meta2:get_int("status") == STAT_LIM then
				speak(meta:get_string("master"), "Garren: I am at "..minetest.pos_to_string(p)..", Master")
			end
		else
			if meta:get_int("status") == STAT_LIM then
				speak(meta:get_string("master"), "Garren: Sorry Master, I cannot move. I am at "..minetest.pos_to_string(p))
			end
		end
		
		if meta:get_int("status") == STAT_LIM then meta:set_int("status",0)
		else meta:set_int("status",meta:get_int("status")+1) end
	end,
})

-- ALIASES

minetest.register_alias("harvey","workers:harvester")
minetest.register_alias("harvester","workers:harvester")

minetest.register_alias("garren","workers:gardener")
minetest.register_alias("gardener","workers:gardener")

minetest.register_alias("mordec","workers:miner")
minetest.register_alias("miner","workers:miner")