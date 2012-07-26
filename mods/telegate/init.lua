--[[
Telegate Mod
By LocaL_ALchemisT (prof_awang@yahoo.com)
License: WTFPL
Version: 1.0
--]]

local telegate = {
	default_coord = {label="Origin", x=0, y=0, z=0},
	coord = function(str,player)
		
		local x,y,z,label = string.match(str, "^(-?%d+),(-?%d+),(-?%d+),?(.*)$")
		if label == "" then label = "Unknown" end
		
		if x==nil or y==nil or z==nil or 
		string.len(x) > 6 or string.len(y) > 6 or string.len(z) > 6 then return nil end

		x = math.floor(tonumber(x))
		y = math.floor(tonumber(y))
		z = math.floor(tonumber(z))
		
		local lim = 32765
		if x > lim or x < -lim or y > lim or y < -lim or z > lim or z < -lim then
			minetest.chat_send_player(player:get_player_name(), "Only values between "..lim.." and "..-lim.." accepted.")
			return nil
		end
		print(minetest.pos_to_string({x=x, y=y, z=z}) or "Oops")
		return {label=label, x=x, y=y, z=z}
	end
}

-- CORE

minetest.register_node("telegate:core", {
	description = "Telegate Core",
	tile_images = {"telegate_core.png"},
	is_ground_content = true,
	metadata_name = "sign",
	groups = {oddly_breakable_by_hand=3},
	after_place_node = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		local default = telegate.default_coord
		local isNearCore = false
		meta:set_string("formspec", "hack:sign_text_input")
		meta:set_string("infotext", "Destination: "..default.label.." ("..default.x..","..default.y..","..default.z..")")
		meta:set_string("text", default.x..","..default.y..","..default.z..","..default.label)
		
		meta:set_string("label",default.label)
		meta:set_float("x",default.x)
		meta:set_float("y",default.y)
		meta:set_float("z",default.z)
		
		for x = -1,1 do
			for y = -1,1 do
				for z = -1,1 do
					if (x ~= 0 or y ~= 0 or z ~= 0) and isNearCore == false then
						local p = {x=pos.x+x,y=pos.y+y,z=pos.z+z}
						if minetest.env:get_node(p).name == "telegate:core" then
							meta2 = minetest.env:get_meta(p)
							meta:set_string("infotext",meta2:get_string("infotext"))
							meta:set_string("text",meta2:get_string("text"))
							
							meta:set_string("label",meta2:get_string("label"))
							meta:set_float("x",meta2:get_float("x"))
							meta:set_float("y",meta2:get_float("y"))
							meta:set_float("z",meta2:get_float("z"))
							minetest.chat_send_player(player:get_player_name(),"Another Core detected at "..minetest.pos_to_string(p)..", set to "..meta:get_string("infotext"))
							isNearCore = true
						end
					end
				end
			end
		end
	end,
	on_receive_fields = function(pos, formname, fields, player)
		local meta = minetest.env:get_meta(pos)
		fields.text = fields.text or ""
		print((player:get_player_name() or "").." input \""..fields.text..
				"\" to core at "..minetest.pos_to_string(pos))
		local coord = telegate.coord(fields.text,player)
		if coord ~= nil then
			meta:set_string("text", coord.x..","..coord.y..","..coord.z..","..coord.label)
			meta:set_string("infotext", "Destination: "..coord.label.." ("..coord.x..","..coord.y..","..coord.z..")")
		
			meta:set_string("label",coord.label)
			meta:set_float("x",coord.x)
			meta:set_float("y",coord.y)
			meta:set_float("z",coord.z)
			minetest.chat_send_player(player:get_player_name(), meta:get_string("infotext"))
		else
			minetest.chat_send_player(player:get_player_name(), "Enter input as \"X,Y,Z,Location\" without decimals.")
		end
	end,
})

-- PLASMA

minetest.register_node("telegate:plasma", {
	description = "Plasma",
	inventory_image = minetest.inventorycube("telegate_plasma.png"),
	--drawtype = "flowingliquid",
	tile_images = {"telegate_plasma.png"},
	alpha = 80,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	post_effect_color = {a=80, r=50, g=200, b=50},
	special_materials = {
		{image="telegate_plasma.png", backface_culling=false},
		{image="telegate_plasma.png", backface_culling=true},
	},
	groups = {},
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local p = {x=pos.x,y=pos.y+1,z=pos.z}
			if minetest.env:get_node(p).name == "telegate:core" or minetest.env:get_node(p).name == "telegate:plasma" then
				meta2 = minetest.env:get_meta(p)
				meta:set_string("infotext",meta2:get_string("infotext"))
				
				meta:set_string("label",meta2:get_string("label"))
				meta:set_float("x",meta2:get_float("x"))
				meta:set_float("y",meta2:get_float("y"))
				meta:set_float("z",meta2:get_float("z"))
			end
	end,
})

-- LOCKED CORE

minetest.register_node("telegate:core_locked", {
	description = "Locked Telegate Core",
	tile_images = {"telegate_core_locked.png"},
	is_ground_content = true,
	metadata_name = "sign",
	groups = {oddly_breakable_by_hand=3},
	after_place_node = function(pos,player)
		local meta = minetest.env:get_meta(pos)
		local default = telegate.default_coord
		local isNearCore = false
		meta:set_string("formspec", "hack:sign_text_input")
		meta:set_string("infotext", "Destination: "..default.label.." ("..default.x..","..default.y..","..default.z..") Owner: "..player:get_player_name())
		meta:set_string("text", default.x..","..default.y..","..default.z..","..default.label)
		
		meta:set_string("label",default.label)
		meta:set_float("x",default.x)
		meta:set_float("y",default.y)
		meta:set_float("z",default.z)
		meta:set_string("owner",player:get_player_name())
		
		for x = -1,1 do
			for y = -1,1 do
				for z = -1,1 do
					if (x ~= 0 or y ~= 0 or z ~= 0) and isNearCore == false then
						local p = {x=pos.x+x,y=pos.y+y,z=pos.z+z}
						if minetest.env:get_node(p).name == "telegate:core_locked" then
							if player:get_player_name() == meta2:get_string("owner") then
								meta2 = minetest.env:get_meta(p)
								meta:set_string("infotext",meta2:get_string("infotext"))
								meta:set_string("text",meta2:get_string("text"))
							
								meta:set_string("label",meta2:get_string("label"))
								meta:set_float("x",meta2:get_float("x"))
								meta:set_float("y",meta2:get_float("y"))
								meta:set_float("z",meta2:get_float("z"))
								minetest.chat_send_player(player:get_player_name(),"Another Locked Core detected at "..minetest.pos_to_string(p)..", set to "..meta:get_string("infotext"))
								isNearCore = true
							else
								minetest.chat_send_player(player:get_player_name(),"Another Locked Core detected at "..minetest.pos_to_string(p)..", but it is not yours (owner: "..meta2:get_string("owner")..")")
							end
						end
					end
				end
			end
		end
	end,
	on_receive_fields = function(pos, formname, fields, player)
		local meta = minetest.env:get_meta(pos)
		fields.text = fields.text or ""
		print((player:get_player_name() or "").." input \""..fields.text..
				"\" to locked core at "..minetest.pos_to_string(pos))
		local coord = telegate.coord(fields.text,player)
		if player:get_player_name() ~= meta:get_string("owner") then
			minetest.chat_send_player(player:get_player_name(), "Denied: Unauthorized User")
			minetest.chat_send_player(meta:get_string("owner"), player:get_player_name().." tried to set data on your locked core at "..minetest.pos_to_string(pos))
			return
		end
		if coord ~= nil then
			meta:set_string("text", coord.x..","..coord.y..","..coord.z..","..coord.label)
			meta:set_string("infotext", "Destination: "..coord.label.." ("..coord.x..","..coord.y..","..coord.z..") Owner: "..meta:get_string("owner"))
		
			meta:set_string("label",coord.label)
			meta:set_float("x",coord.x)
			meta:set_float("y",coord.y)
			meta:set_float("z",coord.z)
			minetest.chat_send_player(player:get_player_name(), meta:get_string("infotext"))
		else
			minetest.chat_send_player(player:get_player_name(), "Enter input as \"X,Y,Z,Location\" without decimals.")
		end
	end,
	on_dig = function(pos, node, player)
	local meta = minetest.env:get_meta(pos)
		if player:get_player_name() ~= meta:get_string("owner") then
			minetest.chat_send_player(player:get_player_name(), "Denied: Unauthorized User. Inflicting damage upon user")
			minetest.chat_send_player(meta:get_string("owner"), player:get_player_name().." tried to remove your locked core at "..minetest.pos_to_string(pos))
			player:set_hp(player:get_hp()-6)
			minetest.sound_play("telegate_pew", {pos = pos, gain = 1.0, max_hear_distance = 10,})
		else
			minetest.node_dig(pos, node, player)
		end
	end,
})

-- LOCKED PLASMA

minetest.register_node("telegate:plasma_locked", {
	description = "Locked Plasma",
	inventory_image = minetest.inventorycube("telegate_plasma_locked.png"),
	--drawtype = "flowingliquid",
	tile_images = {"telegate_plasma_locked.png"},
	alpha = 80,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	post_effect_color = {a=80, r=200, g=50, b=50},
	special_materials = {
		{image="telegate_plasma_locked.png", backface_culling=false},
		{image="telegate_plasma_locked.png", backface_culling=true},
	},
	groups = {},
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local p = {x=pos.x,y=pos.y+1,z=pos.z}
			if minetest.env:get_node(p).name == "telegate:core_locked" or minetest.env:get_node(p).name == "telegate:plasma_locked" then
				meta2 = minetest.env:get_meta(p)
				meta:set_string("infotext",meta2:get_string("infotext"))
				
				meta:set_string("label",meta2:get_string("label"))
				meta:set_float("x",meta2:get_float("x"))
				meta:set_float("y",meta2:get_float("y"))
				meta:set_float("z",meta2:get_float("z"))
				meta:set_string("owner",meta2:get_string("owner"))
			end
	end,
})

-- ABM

minetest.register_abm({
	nodenames = {"telegate:core","telegate:plasma"},
	interval = 1,
	chance = 1,
	action = function(pos, node, _, _)
		local below = pos
		below.y = below.y-1
		local n = minetest.env:get_node(below)
		if n.name == "air" then
			minetest.env:add_node(below, {name="telegate:plasma"})
		end
	end,
})

minetest.register_abm({
	nodenames = {"telegate:core_locked","telegate:plasma_locked"},
	interval = 1,
	chance = 1,
	action = function(pos, node, _, _)
		local below = pos
		below.y = below.y-1
		local n = minetest.env:get_node(below)
		if n.name == "air" then
			minetest.env:add_node(below, {name="telegate:plasma_locked"})
		end
	end,
})

minetest.register_abm({
	nodenames = {"telegate:plasma"},
	interval = 1,
	chance = 1,
	action = function(pos, node, _, _)
		local above = {x=pos.x,y=pos.y+1,z=pos.z}
		local n = minetest.env:get_node(above)
		if n.name ~= "telegate:core" and n.name ~= "telegate:plasma" then
			minetest.env:remove_node(pos)
		else
			meta = minetest.env:get_meta(pos)
			meta2 = minetest.env:get_meta(above)
			meta:set_string("infotext",meta2:get_string("infotext"))
			
			meta:set_string("label",meta2:get_string("label"))
			meta:set_float("x",meta2:get_float("x"))
			meta:set_float("y",meta2:get_float("y"))
			meta:set_float("z",meta2:get_float("z"))
		end
	end,
})

minetest.register_abm({
	nodenames = {"telegate:plasma_locked"},
	interval = 1,
	chance = 1,
	action = function(pos, node, _, _)
		local above = {x=pos.x,y=pos.y+1,z=pos.z}
		local n = minetest.env:get_node(above)
		if n.name ~= "telegate:core_locked" and n.name ~= "telegate:plasma_locked" then
			minetest.env:remove_node(pos)
		else
			meta = minetest.env:get_meta(pos)
			meta2 = minetest.env:get_meta(above)
			meta:set_string("infotext",meta2:get_string("infotext"))
			
			meta:set_string("label",meta2:get_string("label"))
			meta:set_float("x",meta2:get_float("x"))
			meta:set_float("y",meta2:get_float("y"))
			meta:set_float("z",meta2:get_float("z"))
		end
	end,
})

minetest.register_abm({
	nodenames = {"telegate:plasma"},
	interval = 1,
	chance = 1,
	action = function(pos, node, _, _)
		local objs = minetest.env:get_objects_inside_radius(pos, 0.7071)
		for k, player in pairs(objs) do
			if player:get_player_name()~=nil then 
				local meta = minetest.env:get_meta(pos)
				local dest={x=meta:get_float("x"), y=meta:get_float("y"), z=meta:get_float("z")}
				local isSafe = false
				
				repeat
					local n = minetest.env:get_node(dest)
					if n.name == "air" or n.name == "default:water_source" or n.name == "default:water_flowing" then
						local p={x=dest.x,y=dest.y+1,z=dest.z}
						local n = minetest.env:get_node(p)
						if n.name == "air" or n.name == "default:water_source" or n.name == "default:water_flowing" then
							isSafe = true
						else
							dest.y = dest.y + 1
						end
					else
						dest.y = dest.y + 1
					end
				until isSafe == true
				minetest.sound_play("telegate_bzz", {pos = pos, gain = 1.0, max_hear_distance = 10,})
				player:moveto(dest, false)
				minetest.sound_play("telegate_bzz", {pos = dest, gain = 1.0, max_hear_distance = 10,})
				print("Player teleported to "..minetest.pos_to_string(dest).." from "..minetest.pos_to_string(pos))
			end
		end
	end	
})

minetest.register_abm({
	nodenames = {"telegate:plasma_locked"},
	interval = 1,
	chance = 1,
	action = function(pos, node, _, _)
		local objs = minetest.env:get_objects_inside_radius(pos, 0.7071)
		for k, player in pairs(objs) do
			if player:get_player_name()~=nil then 
				local meta = minetest.env:get_meta(pos)
				if player:get_player_name() ~= meta:get_string("owner") then
					minetest.chat_send_player(player:get_player_name(), "Denied: Unauthorized User. Inflicting damage upon user")
					minetest.chat_send_player(meta:get_string("owner"), player:get_player_name().." tried to teleport using your locked core at "..minetest.pos_to_string(pos))
					player:set_hp(player:get_hp()-6)
					minetest.sound_play("telegate_pew", {pos = pos, gain = 1.0, max_hear_distance = 10,})
					return
				end
				local dest={x=meta:get_float("x"), y=meta:get_float("y"), z=meta:get_float("z")}
				local isSafe = false
				
				repeat
					local n = minetest.env:get_node(dest)
					if n.name == "air" or n.name == "default:water_source" or n.name == "default:water_flowing" then
						local p={x=dest.x,y=dest.y+1,z=dest.z}
						local n = minetest.env:get_node(p)
						if n.name == "air" or n.name == "default:water_source" or n.name == "default:water_flowing" then
							isSafe = true
						else
							dest.y = dest.y + 1
						end
					else
						dest.y = dest.y + 1
					end
				until isSafe == true
				minetest.sound_play("telegate_bzz", {pos = pos, gain = 1.0, max_hear_distance = 10,})
				player:moveto(dest, false)
				minetest.sound_play("telegate_bzz", {pos = dest, gain = 1.0, max_hear_distance = 10,})
				print("Player teleported to "..minetest.pos_to_string(dest).." from "..minetest.pos_to_string(pos))
			end
		end
	end	
})

-- RECIPES

minetest.register_craft({
	output = "telegate:core",
	recipe = {
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"default:steel_ingot","default:glass","default:steel_ingot"},
		{"default:mese","default:mese","default:mese"}
	}
})

minetest.register_craft({
	output = "telegate:core_locked",
	recipe = {
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"default:mese","default:glass","default:mese"},
		{"default:mese","default:mese","default:mese"}
	}
})

-- ALIASES

minetest.register_alias("telecore", "telegate:core")
minetest.register_alias("telecore_locked", "telegate:core_locked")