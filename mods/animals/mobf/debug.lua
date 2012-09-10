-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file debug.lua
--! @brief contains debug functions for mob framework
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--!
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @defgroup debug_in_game In game debugging functions
--! @brief debugging functions to be called from in game
--! @ingroup framework_int
--! @{

-------------------------------------------------------------------------------
-- name: mobf_print_usage(player,command,toadd)
--
--! @brief send errormessage to player
--
--! @param player name of player to print usage
--! @param command display usage for this command
--! @param toadd additional information to transfer to player
-------------------------------------------------------------------------------
function mobf_print_usage(player, command, toadd)

	if toadd == nil then
		toadd = ""
	end

	if command == "spawnmob" then
		print("CMD: ".. player .."> ".. "Usage: /spawnmob <mobname> <X,Y,Z> " .. toadd)
		minetest.chat_send_player(player, "Usage: /spawnmob <mobname> <X,Y,Z> " .. toadd)
	end

	if command == "ukn_mob" then
		print("CMD: ".. player .."> "..  "Unknown mob name "..toadd)
		minetest.chat_send_player(player, "Unknown mob name "..toadd)
	end

	if command == "inv_pos" then
		print("CMD: ".. player .."> "..  "Invalid position "..toadd)
		minetest.chat_send_player(player, "Invalid position "..toadd)
	end

	if command == "mob_spawned" then
		print("CMD: ".. player .."> "..  "Mob successfully spawned "..toadd)
		minetest.chat_send_player(player, "Mob successfully spawned "..toadd)
	end

end

-------------------------------------------------------------------------------
-- name: mobf_handle_spawn_mob_cmd(name,message)
--
--! @brief handle a spawn mob command
--
--! @param name name of player
--! @param message message received
------------------------------------------------------------------------------
function mobf_handle_spawn_mob_cmd(name,message)
	local start_pos = string.find(message," ")		

	if (start_pos == nil) then
		mobf_print_usage(name,"spawnmob")	
		return true
	end

	start_pos = start_pos +1

	local end_pos = string.find(message," ",start_pos)

	if end_pos == nil then
		mobf_print_usage(name,"spawmob")	
		return true
	end

	local mobname = string.sub(message,start_pos,end_pos-1)

	if mobf_is_known_mob(mobname) ~= true then
		mobf_print_usage(name,"ukn_mob", ">"..mobname.."<") 
		return true
	end

	local spawnpoint = {x=0,y=0,z=0}

	start_pos = end_pos +1
	end_pos = string.find(message,",",start_pos)

	if end_pos ~= nil then
		print("Found: ".. string.sub(message,start_pos,end_pos-1).. " as x")
		spawnpoint.x = tonumber(string.sub(message,start_pos,end_pos-1))
	else
		mobf_print_usage(name,"spawnmob")	
		return true
	end

	start_pos = end_pos +1
	end_pos = string.find(message,",",start_pos)

	if end_pos ~= nil then
		print("Found: ".. string.sub(message,start_pos,end_pos-1).. " as y")
		spawnpoint.y = tonumber(string.sub(message,start_pos,end_pos-1))
	else
		mobf_print_usage(name,"spawnmob")	
		return true
	end

	start_pos = end_pos +1

	print("Found: ".. string.sub(message,start_pos).. " as z")
	spawnpoint.z = tonumber(string.sub(message,start_pos))

	if spawnpoint.z == nil then
		mobf_print_usage(name,"spawnmob")	
		return true
	end

	local node_at_spawnpoint = minetest.env:get_node(spawnpoint)

	if mobf_pos_is_zero(spawnpoint) or
		node_at_spawnpoint == nil and
		node_at_spawnpoint.name ~= "air" then
		mobf_print_usage(name,"inv_pos",printpos(spawnpoint))	
		return true
	end

	print("Spawning mob ".. mobname .." at " .. printpos(spawnpoint))

	local newobject = minetest.env:add_entity(spawnpoint,mobname)

	local newentity = mobf_find_entity(newobject)
	
	if newentity ~= nil then
		mobf_print_usage(name,"mob_spawned", mobname)
	else
		print("Bug no "..mobname.." has been created!")
	end

end

-------------------------------------------------------------------------------
-- name: mobf_handle_list_active_mobs_cmd(name,message)
--
--! @brief print list of all current active mobs
--
--! @param name name of player
--! @param message message received
------------------------------------------------------------------------------
function mobf_handle_list_active_mobs_cmd(name,message)
	
	local count = 1
	for index,value in pairs(minetest.luaentities) do 
		if value.data.name ~= nil then
			local tosend = count .. ": " .. value.data.name .. " at " .. printpos(value.object:getpos())
			print(tosend)
			minetest.chat_send_player(name,tosend)
			count = count +1
		end
	end

end

-------------------------------------------------------------------------------
-- name: mobf_handle_add_tools_cmd(name,message)
--
--! @brief add toolset for testing
--
--! @param name name of player
--! @param message message received
------------------------------------------------------------------------------
function mobf_handle_add_tools_cmd(name,message)
	local player = minetest.env:get_player_by_name(name)
	
	if player ~= nil then
		player:get_inventory():add_item("main", "animalmaterials:lasso 20")
		player:get_inventory():add_item("main", "animalmaterials:net 20")
		player:get_inventory():add_item("main", "animalmaterials:scissors 1")
		player:get_inventory():add_item("main", "animalmaterials:glass 10")	
	end

end

-------------------------------------------------------------------------------
-- name: mobf_handle_list_mobs_cmd(name,message)
--
--! @brief list all registred mobs
--
--! @param name name of player
--! @param message message received
------------------------------------------------------------------------------
function mobf_handle_list_mobs_cmd(name,message)

	local text = ""
	for i,val in ipairs(mobf_registred_mob) do
		text = text .. val .. " "
	end
	minetest.chat_send_player(name, "MOBF: "..text)
end

-------------------------------------------------------------------------------
-- name: mobf_debug_handler(name,message)
--
--! @brief global chat message handler for mob framework
--
--! @param name name of player
--! @param message message received
------------------------------------------------------------------------------
function mobf_debug_handler(name,message)

	if message == nil then
		return false
	end

	if string.find(message,"/spawnmob") ~= nil then
		mobf_handle_spawn_mob_cmd(name,message)
		return true
	end

	if string.find(message,"/listactivemobs") ~= nil then
		mobf_handle_list_active_mobs_cmd(name,message)
		return true
	end
	
	if string.find(message,"/debug_add_tools") ~= nil then
		mobf_handle_add_tools_cmd(name,message)
		return true
	end
	
	if string.find(message,"/listmobs") ~= nil then
		mobf_handle_list_mobs_cmd(name,message)
		return true
	end
	
	if string.find(message,"/traceon") ~= nil then
		luatrace.tron()
		return true
	end
	
	if string.find(message,"/traceoff") ~= nil then
		luatrace.troff()
		return true
	end
	
	return false
end

-------------------------------------------------------------------------------
-- name: mobf_debug_handler(name,message)
--
--! @brief initialize debug commands chat handler
--
------------------------------------------------------------------------------
function mobf_init_debug()
	minetest.register_on_chat_message(mobf_debug_handler)
end

--!@}
