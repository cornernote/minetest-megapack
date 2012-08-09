--[[
Workers Mod
By LocaL_ALchemisT (prof_awang@yahoo.com)
License: WTFPL
Version: 2.0
--]]

local STAT_LIM = 8

-- HARVEY THE HARVESTER

minetest.register_abm({
	nodenames = {"workers:harvester"},
	interval = 2,
	chance = 1,
	action = function(p, node, _, _)
		local meta = minetest.env:get_meta(p)
		local hasMaterial = false
		if meta:get_int("start_work") == 0 then return end
		if meta:get_int("quantity") >= 99 then
			meta:set_int("start_work",0)
			speak(meta:get_string("master"), "Harvey: I am at "..minetest.pos_to_string(p)..", Master. My inventory is full.")
		end
		
		for y = 0,1 do
			for x = -1,1 do
				for z = -1,1 do
					local pp = {x=p.x+x,y=p.y+y,z=p.z+z}
					if peek(pp,meta:get_string("material")) and meta:get_int("quantity") <= 99 then
						minetest.env:remove_node(pp)
						meta:set_int("quantity",meta:get_int("quantity")+1)
						if hasMaterial == false then hasMaterial = true end
						if meta:get_int("status") == 1 then speak(meta:get_string("master"), "Harvey: I am at "..minetest.pos_to_string(p)..", Master")	end
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
	end,
})

-- MORDEC THE MINER

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
			if orestack:to_table() ~= nil then
				local o = orestack:to_table().name
				if o == "default:cobble" or o == "default:sand" or o == "default:dirt" or o == "default:desert_sand"
				or o == "default:gravel" or o == "default:desert_stone" then
					if orestack:to_table().count == 99 then
						inv:remove_item("ores", orestack)
						minetest.env:add_item({x = p.x + (math.random(1,3)-2), y = p.y, z = p.z + (math.random(1,3)-2)},''..o..' 99')
					end
				end
			end
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
					and minetest.env:get_node(pp).name ~= "workers:hunter"
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
		if meta2:get_int("status") == 0 then minetest.env:add_node(p,{name="default:torch"})
		minetest.sound_play("mordec_00", {pos = pos, gain = 1.0, max_hear_distance = 6,}) end
		if meta2:get_int("status") == STAT_LIM then
			speak(meta2:get_string("master"), "Mordec: I am at "..minetest.pos_to_string(p)..", Master")
		end
		
		if meta2:get_int("status") == STAT_LIM then meta2:set_int("status",0)
		else meta2:set_int("status",meta2:get_int("status")+1) end
	end,
})

-- GARREN THE GARDENER

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
				where = anticlockwise(p,meta:get_int("previousdir"))
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
			-- jungletree
			if plant.name == "default:jungletree" and sapling.count >= 9 then
				for h = 0,3 do minetest.env:add_node({x = p.x,y = p.y+h,z = p.z},{name=plant.name}) end
				for x = -1,1 do
					for y = 2,4 do
						for z = -1,1 do
							local pt = {x = p.x+x,y = p.y+y,z = p.z+z}
							if minetest.env:get_node(pt).name == "air" then
								minetest.env:add_node(pt,{name="default:leaves"})
							end
						end
					end
				end
				inv2:remove_item("sapling",'"default:sapling" 9')
			-- appletree
			elseif plant.name == "default:apple" and sapling.count >= 3 then
				for h = 0,3 do minetest.env:add_node({x = p.x,y = p.y+h,z = p.z},{name="default:tree"}) end
				for x = -1,1 do
					for y = 2,4 do
						for z = -1,1 do
							local pt = {x = p.x+x,y = p.y+y,z = p.z+z}
							if minetest.env:get_node(pt).name == "air" then
								if math.random(1,2) == 1 then minetest.env:add_node(pt,{name="default:leaves"})
								else minetest.env:add_node(pt,{name="default:apple"}) end
							end
						end
					end
				end
				inv2:remove_item("sapling",'"default:sapling" 3')
			-- cactus or papyrus
			elseif (plant.name == "default:cactus" or plant.name == "default:papyrus") and sapling.count >= 3 then
				for h = 0,2 do minetest.env:add_node({x = p.x,y = p.y+h,z = p.z},{name=plant.name}) end
				inv2:remove_item("sapling",'"default:sapling" 3')
			-- junglegrass or dry shrub
			elseif (plant.name == "default:junglegrass" or plant.name == "default:dry_shrub") then
				minetest.env:add_node(p,{name=plant.name})
				inv2:remove_item("sapling","default:sapling")
			-- everything else
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

-- BENJO THE BUILDER

minetest.register_abm({
	nodenames = {"workers:builder"},
	interval = 2,
	chance = 1,
	action = function(p, node, _, _)
		local meta = minetest.env:get_meta(p)
		if meta:get_int("start_work") == 0 then return end
		
		local master = meta:get_string("master")
		local inv = meta:get_inventory()
		local plan = inv:get_stack("plan",1):to_table().name
		local material = inv:get_stack("material",1):to_table().name
		print(material)
		local allowed = {"default:stone","default:cobble","default:mossycobble","default:tree","default:jungletree","default:wood",
						 "default:brick","default:clay","default:desert_stone","default:glass","default:steelblock","default:cactus",
						 "default:dirt"}
		local pass = false
		for i = 1,13 do
			if material == allowed[i] then pass = true end
		end
		if pass == false then
			minetest.chat_send_player(master, "Benjo: I can't use this material, Master.")
			meta:set_int("start_work",0)
		return end
		
		local bp = nil
		-- house
		if plan == "workers:plan_house" then
			print("house")
			for y = -1,3 do
				for x = -2,2 do
					for z = -3,3 do
						bp = {x=p.x+x,y=p.y+y,z=p.z+z}
						if x~=0 and y~=0 and z~=0 then minetest.env:remove_node(bp) end
						if y == -1 or y == 3 then
							minetest.env:add_node(bp,{name=material})
						elseif x*x == 4 or z*z == 9 then
							minetest.env:add_node(bp,{name=material})
							if ((x==0 and z*z==9) or (x*x==4 and (z==0 or z*z==4))) and y==1 then minetest.env:remove_node(bp) end
						end
					end
				end
			end
		-- hut
		elseif plan == "workers:plan_hut" then
			print("hut")
			for y = -1,2 do
				for x = -1,1 do
					for z = -1,1 do
						bp = {x=p.x+x,y=p.y+y,z=p.z+z}
						if x~=0 and y~=0 and z~=0 then minetest.env:remove_node(bp) end
						if y == -1 or y == 2 then
							minetest.env:add_node(bp,{name=material})
						elseif x*x == 1 or z*z == 1 then
							minetest.env:add_node(bp,{name=material})
							if ((x==0 and z*z==1) or (x*x==1 and z==0)) and y==1 then minetest.env:remove_node(bp) end
						end
					end
				end
			end
			minetest.env:remove_node(dir[minetest.env:get_node(p).param2](p))
		-- pool
		elseif plan == "workers:plan_pool" or plan == "workers:plan_lavapool" then
			print("pool")
			for y = -4,-1 do
				for x = -2,2 do
					for z = -3,3 do
						bp = {x=p.x+x,y=p.y+y,z=p.z+z}
						minetest.env:remove_node(bp)
						if y == -4 or (x*x >= 4 or z*z >= 9) then
							minetest.env:add_node(bp,{name=material})
						elseif y == -2 then
							if plan == "workers:plan_pool" then minetest.env:add_node(bp,{name="default:water_source"})
							else
								minetest.env:add_node(bp,{name="default:lava_source"})
								minetest.chat_send_player(master, "Benjo will be burnt!")
							end
						end
					end
				end
			end
		-- moat
		elseif plan == "workers:plan_moat" or plan == "workers:plan_lavamoat" then
			print("moat")
			for y = -3,-1 do
				for x = -10,10 do
					for z = -10,10 do
						bp = {x=p.x+x,y=p.y+y,z=p.z+z}
						if x*x >= 25 or z*z >= 25 then
							minetest.env:remove_node(bp)
							if y == -3 or (x*x <= 25 and z*z <= 25) or (x*x >= 100 or z*z >= 100) then
								minetest.env:add_node(bp,{name=material})
							elseif y == -2 then
								if plan == "workers:plan_moat" then minetest.env:add_node(bp,{name="default:water_source"})
								else minetest.env:add_node(bp,{name="default:lava_source"}) end
							end
						end
					end
				end
			end
		-- 9x9 wall
		elseif plan == "workers:plan_wall" then
			print("wall")
			local fp = dir[minetest.env:get_node(p).param2](p)
			for y = -4,4 do
				for l = -4,4 do
					if (fp.x-p.x) ~= 0 then bp = {x=fp.x,y=fp.y+y,z=fp.z+l}
					elseif (fp.z-p.z) ~= 0 then bp = {x=fp.x+l,y=fp.y+y,z=fp.z} end
					minetest.env:remove_node(bp)
					minetest.env:add_node(bp,{name=material})
				end
			end
		-- underground bunker
		elseif plan == "workers:plan_ubunker" then
			print("underground bunker")
			for y = -6,-2 do
				for x = -2,2 do
					for z = -3,3 do
						bp = {x=p.x+x,y=p.y+y,z=p.z+z}
						minetest.env:remove_node(bp)
						if y == -6 or y == -2 then minetest.env:add_node(bp,{name=material})
						elseif x*x == 4 or z*z == 9 then minetest.env:add_node(bp,{name=material}) end
					end
				end
			end
			for y = -3,-1 do
				bp = {x=p.x,y=p.y+y,z=p.z}
				minetest.env:remove_node(bp)
			end
			local np = shouldFall_miner(p)
			minetest.env:add_node(np,{name="workers:builder",param2=minetest.env:get_node(p).param2})
			local meta2 = minetest.env:get_meta(np)
			meta2:from_table(meta:to_table())
			minetest.env:remove_node(p)
			meta = minetest.env:get_meta(np)
			inv = meta:get_inventory()
		-- tower
		elseif plan == "workers:plan_tower" then
			print("tower")
			local fp = dir[minetest.env:get_node(p).param2](p)
			for y = -1,5 do
				for x = -1,1 do
					for z = -1,1 do
						bp = {x=p.x+x,y=p.y+y,z=p.z+z}
						if x~=0 and y~=0 and z~=0 then minetest.env:remove_node(bp) end
						if y == -1 then minetest.env:add_node(bp,{name=material})
						elseif x*x == 1 or z*z == 1 then minetest.env:add_node(bp,{name=material})
						else if y~=0 then minetest.env:add_node(bp,{name="default:ladder",param2=3}) end end
					end
				end
			end
			for y = 0,1 do minetest.env:remove_node({x=fp.x,y=fp.y+y,z=fp.z}) end
			for y = 5,6 do
				for x = -2,2 do
					for z = -2,2 do
						bp = {x=p.x+x,y=p.y+y,z=p.z+z}
						minetest.env:remove_node(bp)
						if (x*x)+(z*z) > 2 then minetest.env:add_node(bp,{name=material}) end
						if ((x*x==1 and z*z==4) or (x*x==4 and z*z==1)) and y==6 then minetest.env:remove_node(bp) end
					end
				end
			end
		end
		inv:remove_item("plan",plan)
		inv:add_item("plan","default:paper")
		minetest.chat_send_player(master, "Benjo: Done, Master.")
		meta:set_int("start_work",0)
	end,
})

-- GREDO THE GUARD

minetest.register_abm({
	nodenames = {"workers:guard"},
	interval = 2,
	chance = 1,
	action = function(p, node, _, _)
		local meta = minetest.env:get_meta(p)
		local inv = meta:get_inventory()
		local master = meta:get_string("master")
		
		local isFull = true
		for i = 1,8 do
			local orestack = inv:get_stack("catch",i)
			if orestack:get_free_space() > 0 then isFull = false end
		end
		if isFull == true then
			if meta:get_int("status") == STAT_LIM then
				speak(master, "Gredo: I am at "..minetest.pos_to_string(p)..", Boss. My inventory is full.")
				meta:set_int("status",1)
			else meta:set_int("status",meta:get_int("status")+1) end
			return
		end
		
		local ep = minetest.env:find_node_near(p, 2, {"group:worker"})
		if ep ~= nil then
			local catch = minetest.env:get_node(ep).name
			local cmaster = minetest.env:get_meta(ep):get_string("master")
			minetest.env:remove_node(ep)
			inv:add_item("catch", catch)
			speak(master, "Gredo: I got "..cmaster.."'s "..catch.." at "..minetest.pos_to_string(ep)..", Boss.")
			minetest.chat_send_player(cmaster, "Gredo: Got your "..catch.." in "..meta:get_string("master").."\'s property. Be careful when you let'em go next time.")
		end
		
		local objs = minetest.env:get_objects_inside_radius(p, 2)
		for k, player in pairs(objs) do
			if player:get_player_name() ~= "" and player:get_player_name() ~= master then
				speak(master, "Gredo: I saw "..player:get_player_name().." at "..minetest.pos_to_string(ep)..", Boss.")
			end
		end
		
		if meta:get_int("status") == STAT_LIM then meta:set_int("status",1)
		else meta:set_int("status",meta:get_int("status")+1) end
	end,
})

-- ASVARD THE ASSASSIN

minetest.register_abm({
	nodenames = {"workers:assassin"},
	interval = 5,
	chance = 1,
	action = function(p, node, _, _)
		local meta = minetest.env:get_meta(p)
		local target = minetest.env:get_player_by_name(meta:get_string("target"))
		
		if meta:get_int("start_work") == 0 then return end
		if target == nil then return end
		
		local tp = target:getpos()
		local mp = {x = p.x + math.floor((tp.x-p.x)/2),y = p.y + math.floor((tp.y-p.y)/2),z = p.z + math.floor((tp.z-p.z)/2)}
		if peek(mp,"air") or peek(mp,"default:water_source") or peek(mp,"default:water_flowing") then mp = shouldFall(mp)
		else mp = shouldRise(mp) end
		minetest.env:add_node(mp,{name="workers:assassin",param2=minetest.dir_to_facedir(
			{x = math.floor(p.x-tp.x),y = math.floor(p.y-tp.y),z = math.floor(p.z-tp.z)})}
		)
		local gp = minetest.env:find_node_near(mp, 2, {"workers:guard"})
		if gp ~= nil then minetest.env:remove_node(gp)
		minetest.chat_send_player(meta:get_string("target"), "Asvard: No guard can stop me.") end
		
		local meta2 = minetest.env:get_meta(mp)
		meta2:from_table(meta:to_table())
		minetest.env:remove_node(p)
		
		local objs = minetest.env:get_objects_inside_radius(mp, 2.1213)
		for k, target in pairs(objs) do target:set_hp(target:get_hp()-5) end
		
		minetest.sound_play("asvard_01", {pos = pos, gain = 1.0, max_hear_distance = 5,})
		if target:get_hp() <= 0 then
			speak(meta2:get_string("master"), "Asvard: I am at "..minetest.pos_to_string(p)..", Boss. My job is done.")
			minetest.env:remove_node(mp)
			minetest.env:add_item(mp,"default:sword_steel")
		end
	end,
})

-- TOCO THE THIEF

minetest.register_abm({
	nodenames = {"workers:thief"},
	interval = 2,
	chance = 1,
	action = function(p, node, _, _)
		local meta = minetest.env:get_meta(p)
		local master = meta:get_string("master")
		local inv = meta:get_inventory()
		
		local isFull = true
		for i = 1,32 do
			local orestack = inv:get_stack("loot",i)
			if orestack:get_free_space() > 0 then isFull = false end
		end
		if isFull == true then
			if meta:get_int("status") == STAT_LIM then
				speak(master, "Toco: I am at "..minetest.pos_to_string(p)..", Boss. My inventory is full.")
				meta:set_int("status",1)
			else meta:set_int("status",meta:get_int("status")+1) end
			return
		end
		
		local cp = minetest.env:find_node_near(p, 2, {"default:chest_locked"})
		if cp ~= nil then
			local chest = minetest.env:get_meta(cp)
			if chest:get_string("owner") ~= master then
				local cinv = chest:get_inventory()
				if not cinv:is_empty("main") then
					for i = 1,32 do
						if inv:room_for_item("loot", cinv:get_stack("main", i)) then
							inv:add_item("loot", cinv:get_stack("main", i))
							cinv:set_stack("main", i, cinv:remove_item("main", i))
						end
					end
					minetest.chat_send_player(master, "Toco: I'm done with the locked chest, Boss.")
				end
			end
		end
		
		local gp = minetest.env:find_node_near(p, 2, {"workers:guard"})
		if gp ~= nil then
			local guard = minetest.env:get_meta(gp)
			if guard:get_string("master") ~= master then
				local ginv = guard:get_inventory()
				if not ginv:is_empty("main") then
					for i = 1,8 do
						if inv:room_for_item("loot", ginv:get_stack("catch", i)) then
							inv:add_item("loot", ginv:get_stack("catch", i))
							ginv:set_stack("main", i, ginv:remove_item("catch", i))
						end
					end
					minetest.chat_send_player(master, "Toco: I'm done with the guard, Boss.")
				end
			end
		end
		
		local objs = minetest.env:get_objects_inside_radius(p, 3.5355)
		for k, player in pairs(objs) do
			if player ~= nil then
				if player:get_player_name() ~= "" and player:get_player_name() ~= master then
					local pinv = player:get_inventory()
					if pinv ~= nil then
						if not pinv:is_empty("main") then
							for i = 1,32 do
								if inv:room_for_item("loot", pinv:get_stack("main", i)) then
									inv:add_item("loot", pinv:get_stack("main", i))
									pinv:set_stack("main", i, pinv:remove_item("main", i))
								end
							end
							minetest.chat_send_player(master, "Toco: Got loot from "..player:get_player_name().."'s pocket, Boss.")
						end
					end
				end
			end
		end
		
		if meta:get_int("status") == STAT_LIM then meta:set_int("status",1)
		else meta:set_int("status",meta:get_int("status")+1) end
	end,
})

-- CARDON THE COP

minetest.register_abm({
	nodenames = {"workers:cop"},
	interval = 1,
	chance = 1,
	action = function(p, node, _, _)
		local meta = minetest.env:get_meta(p)
		local inv = meta:get_inventory()
		local master = meta:get_string("master")
		
		local ap = minetest.env:find_node_near(p, 3, {"workers:assassin"})
		if ap ~= nil then
			local owner = minetest.env:get_meta(ap):get_string("master")
			local target = minetest.env:get_meta(ap):get_string("target")
			minetest.env:remove_node(ap)
			if owner == master then minetest.chat_send_player(master, "Cardon: It's not nice for you to have an assassin, Boss.")
			else minetest.chat_send_player(owner, "Cardon: You better not hiring any assassin again.") end
			
			if target ~= "" then
				if target == owner then minetest.chat_send_player(owner, "Cardon: Sorry, you're under arrest for attempting suicide.")
				else minetest.chat_send_player(owner, "Cardon: Attempting murder, I see. You're under arrest.") end
				local player = minetest.env:get_player_by_name(owner)
				for y = -1,2 do
					for x = -1,1 do
						for z = -1,1 do
							bp = {x=p.x+x,y=p.y+y+10,z=p.z+z}
							minetest.env:remove_node(bp)
							if y == -1 or y == 2 then minetest.env:add_node(bp,{name="default:glass"})
							elseif x*x == 1 or z*z == 1 then minetest.env:add_node(bp,{name="default:glass"}) end
						end
					end
				end
				player:setpos({x=p.x,y=p.y+10,z=p.z})
				np = dir[minetest.env:get_node(p).param2](dir[minetest.env:get_node(p).param2](p))
				if peek(np,"air") or peek(np,"default:water_source") or peek(np,"default:water_flowing") then np = shouldFall(np)
				else np = shouldRise(np) end
				minetest.env:add_node(np,{name="workers:cop",param2=minetest.env:get_node(p).param2})
				local meta2 = minetest.env:get_meta(np)
				meta2:from_table(meta:to_table())
				minetest.env:remove_node(p)
				meta = minetest.env:get_meta(np)
			end
		end
		
		local tp = minetest.env:find_node_near(p, 3, {"workers:thief"})
		if tp ~= nil and meta:get_int("status") == STAT_LIM then
			local owner = minetest.env:get_meta(tp):get_string("master")
			if owner ~= master then speak(master, "Cardon: "..owner.."\'s thief is in this area.")
			else speak(master, "Cardon: Your thief is nearby. Please take it away") end
		end
		
		if meta:get_int("status") == STAT_LIM then meta:set_int("status",1)
		else meta:set_int("status",meta:get_int("status")+1) end
	end,
})

