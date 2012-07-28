---
--Bones
--Copyright (C) 2012 Bad_Command
--
--This library is free software; you can redistribute it and/or
--modify it under the terms of the GNU Lesser General Public
--License as published by the Free Software Foundation; either
--version 2.1 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU Lesser General Public
--License along with this library; if not, write to the Free Software
--Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
----

bones.replaceable_node_types = {
	"default:lava_source", 
	"default:lava_flowing", 
	"default:water_source", 
	"default:water_flowing", 
	"air"
}

bones.inventory_take = function(pos, listname, index, count, player)
	local meta = minetest.env:get_meta(pos)
	if not bones.privilege(meta, player) then
		minetest.log("action", player:get_player_name()..
				" tried to access bones belonging to "..
				meta:get_string("owner").." at "..
				minetest.pos_to_string(pos))
		return
	end
	local fresh = meta:get_int("fresh") or 1
	if fresh > 0 then
		fresh = "fresh"
	else
		fresh = "old"
	end
	minetest.log("action", player:get_player_name()..
			" picks from "..meta:get_string("owner").."'s "..fresh.." bones at "..minetest.pos_to_string(pos))
	--return minetest.node_metadata_inventory_take_allow_all(pos, listname, index, count, player)
end

bones.privilege=function(meta, player)
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if not privs["interact"] then
		return false
	end
	local fresh = meta:get_int("fresh") or 0
	if fresh > 0 and name ~= meta:get_string("owner") and not privs["server"] then
		return false
	end
	return true
end

bones.action=function(pos, node, active_object_count, active_object_count_wider)
	local meta = minetest.env:get_meta(pos)
	local fresh = meta:get_int("fresh") or 0
	local bonetime = meta:get_float("bonetime") or 0
	if fresh > 0 and worldtime_get() - bonetime >  bones.age_after then
		local name = meta:get_string("owner") or ""
		meta:set_string("infotext", name .. "'s old bones")
		meta:set_int("fresh", -1)
	end
end	

bones.create = function(player, pos) 
	local name = player:get_player_name()
	minetest.env:set_node(pos, {name="bones:bones", param1=0, param2=0})
	local meta = minetest.env:get_meta(pos)
	meta:set_string("formspec",
			"invsize[8,9;]"..
			"list[current_name;main;0,0;8,4;]"..
			"list[current_player;main;0,5;8,4;]")
	meta:set_string("infotext", name .. "'s fresh bones")
	meta:set_string("owner", name)
	meta:set_float("bonetime", worldtime_get())
	meta:set_int("fresh", 1)

	-- test to see if node was created
	local node = minetest.env:get_node_or_nil(pos)
	if node == nil or node.name ~= "bones:bones" then
		minetest.log("error", 'Bones:  Failed to create bones node for '..name)
		return false
	end

	local bones_inv = meta:get_inventory()
	bones_inv:set_size("main", 8*4)
	local player_inv = player:get_inventory()
	if ( player_inv == nil ) then
		minetest.log("error", 'Bones:  Unable to get player '..name..' inventory')
		return false
	end
	

	for i=1,32 do
		local stack = player_inv:get_stack("main", i)
		if stack ~= nil and not stack:is_empty() then
			bones_inv:set_stack("main", i, stack:to_table())
			player_inv:set_stack("main", i, nil)
		end
	end
	for i=1,9 do
		local stack = player_inv:get_stack("craft", i)
		if stack ~= nil and not stack:is_empty() then
			local leftover = bones_inv:add_item("main", stack)
			if leftover ~= nil and not leftover:is_empty() then
				minetest.env:add_item({
					x=pos.x, 
					y=pos.y + 1.1, 
					z=pos.z}, leftover)
			end
			player_inv:set_stack("craft", i, nil)			
		end
	end
	return true
end

bones.settle_type = function(nodename) 
	for i=1,#bones.replaceable_node_types do
		if nodename == bones.replaceable_node_types[i] then
			return true
		end
	end
	return false
end

bones.settle_bones = function(pos) 
	local nextpos = pos; 
	local node

	-- find ground beneath player
	repeat
		pos = nextpos
		nextpos = {x=pos.x, y=pos.y-1, z=pos.z}
		node = minetest.env:get_node_or_nil(nextpos)
	until node == nil or not bones.settle_type(node.name) 

	node = minetest.env:get_node_or_nil(pos)

	-- if the player is inside rock or something
	if node == nil or not bones.settle_type(node.name) then
		-- find nearby empty node
		pos = minetest.env:find_node_near(pos, 3, bones.replaceable_node_types)
	end

	-- if nothing nearby is empty
	if pos == nil then
		return nil
	end

	return pos;--{x=math.floor(pos.x*10)/10, y=math.floor(pos.y*10)/10, z=math.floor(pos.z*10)/10}
end

bones.pos_to_string = function(pos) 
	return math.floor(pos.x + 0.5) .. "," .. math.floor(pos.y+0.5) .. "," .. math.floor(pos.z+0.5)
end

bones.on_dieplayer = function(player) 
	if player == nil then
		minetest.log("error", 'Unknown player died (player = nil)')
		return
	end

	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	local inv = player:get_inventory()

	if not privs["interact"] or (inv:is_empty("main") and inv:is_empty("craft")) then
		return
	end
	
	local playerpos = player:getpos()
	playerpos = { 
		x=math.floor(playerpos.x+0.5),
		y=math.floor(playerpos.y+0.5),
		z=math.floor(playerpos.z+0.5)
	}
	local bonepos = bones.settle_bones(playerpos);
	if bonepos == nil then
		minetest.log("action", player:get_player_name().." dies at "..minetest.pos_to_string(playerpos)..' without dropping gear.')
		minetest.chat_send_player(name, 'Bones:  There was no room to drop your bones.  You get to keep your gear.')
		return
	else
		if bones.create(player, bonepos) then
			minetest.log("action", player:get_player_name().." dies at "..minetest.pos_to_string(playerpos)..', gear dropped at '..minetest.pos_to_string(bonepos))
			minetest.chat_send_player(name, 
				'Bones:  Your bones were left at '..bones.pos_to_string(bonepos)..
				'.  Go there to find your gear.  Bones stay fresh for '..
				(math.floor(bones.age_after/360+0.5)/10)..'hrs.')
		else
			minetest.chat_send_player(name, 'Bones:  Lucky you!  You get to respawn with your bones.')			
		end
	end
end
