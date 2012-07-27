--[[
Workers Mod
By LocaL_ALchemisT (prof_awang@yahoo.com)
License: WTFPL
Version: 0.0
--]]

-- NODES

minetest.register_node("workers:harvester", {
	description = "Harvey The Harvester",
	tile_images = {"harvey_body.png", "harvey_body.png", "harvey_left.png",
		"harvey_right.png", "harvey_back.png", "harvey_front.png"},
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
		local name = player:get_player_name()
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
		if meta:get_int("status") == 0 then return end
		
		if meta:get_int("start_work") == 0 then --if the harvester hasn't moved yet
			if player:get_player_name() == master then
				meta:set_int("start_work",1)
				minetest.chat_send_player(master, "Harvey: I will go now, Master.")
			else
				minetest.chat_send_player(player:get_player_name(), "Harvey: You are not "..master.."!")
				player:set_hp(player:get_hp()-4)
				minetest.chat_send_player(master, "Harvey: Master, "..player:get_player_name().." punched me!")
			end
		elseif meta:get_int("start_work") == 1 then --if the harvester has moved
			if player:get_player_name() == master then
				player:get_inventory():add_item("main", "workers:harvester")
				print(meta:get_string("material")..": "..meta:get_int("quantity"))
				if meta:get_int("quantity") > 0 then
					player:get_inventory():add_item("main", "\""..meta:get_string("material").."\" "..meta:get_int("quantity"))
					minetest.chat_send_player(master, "Harvey: I have collected "..meta:get_int("quantity").." "..meta:get_string("material")..", Master.")
				end
				minetest.chat_send_player(master, "Harvey: Pleasure to work for you, Master.")
				minetest.env:remove_node(pos)
			else
				minetest.chat_send_player(player:get_player_name(), "Harvey: You are not "..master.."!")
				player:set_hp(player:get_hp()-6)
				minetest.chat_send_player(master, "Harvey: Master, "..player:get_player_name().." punched me!")
			end
		end
		print (meta:get_int("start_work"))
	end,
})

-- ACTIONS

local dir = {
	[0] = function(p) return {x=p.x,y=p.y,z=p.z-1} end, --back
	[1] = function(p) return {x=p.x-1,y=p.y,z=p.z} end, --left
	[2] = function(p) return {x=p.x,y=p.y,z=p.z+1} end, --front
	[3] = function(p) return {x=p.x+1,y=p.y,z=p.z} end, --right
}

local peek = function(p,name)
	if minetest.env:get_node(p).name == name then return true end
end

faceTo = function(p,n,lim)
	if peek(dir[n](p),"air") then return {pos = dir[n](p),face = n} end
	n = n+1
	lim = lim+1
	if n > 3 then n = 0 end
	if lim < 4 then return faceTo(p,n,lim)
	else return nil end
end

shouldFall = function(p)
	local np = {x=p.x,y=p.y-1,z=p.z}
	if peek(np,"air") or peek(np,"default:water_source") or peek(np,"default:water_flowing") then return shouldFall(np)
	else return p end
end

local meta_copy = function(m0,m1)
	m1:set_string("infotext",m0:get_string("infotext"))
	m1:set_string("text",m0:get_string("text"))
	m1:set_string("master",m0:get_string("master"))
	m1:set_string("material",m0:get_string("material"))
	m1:set_int("quantity",m0:get_int("quantity"))
	m1:set_int("status",m0:get_int("status"))
	m1:set_int("start_work",m0:get_int("start_work"))
	m1:set_int("previousdir",m0:get_int("previousdir"))
end

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
								minetest.chat_send_player(meta:get_string("master"), "Harvey: I am at "..minetest.pos_to_string(p)..", Master")
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
					meta_copy(meta,meta2)
					minetest.env:remove_node(p)
					if meta2:get_int("status") == 1 then
						minetest.chat_send_player(meta:get_string("master"), "Harvey: I am at "..minetest.pos_to_string(p)..", Master")
					end
				else
					if meta:get_int("status") == 1 then
						minetest.chat_send_player(meta:get_string("master"), "Harvey: Sorry Master, I cannot move. I am at "..minetest.pos_to_string(p))
					end
				end
				if meta:get_int("status") == 1 then meta:set_int("status",2) end
				
			else print(meta:get_int("quantity").." "..meta:get_string("material").." gathered.") end
			
			if meta:get_int("status") == 5 then meta:set_int("status",1)
			else meta:set_int("status",meta:get_int("status")+1) end
		end
	end,
})

-- RECIPES

minetest.register_craft({
	output = "workers:harvester",
	recipe = {
		{"default:dirt","default:chest","default:dirt"},
		{"default:dirt","default:mese","default:dirt"},
		{"default:dirt","default:dirt","default:dirt"}
	}
})

-- ALIASES

minetest.register_alias("harvey","workers:harvester")
minetest.register_alias("harvester","workers:harvester")