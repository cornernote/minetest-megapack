-------------------------------------------------------------------------------
-- Animals Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
-- (c) Sapier
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- name: animals_print_usage(player,command,toadd)
--
-- action: send errormessage to player
--
-- param1: player to send to
-- param2: messagecode
-- param3: additional info
-- retval:
------------------------------------------------------------------------------
function animals_print_usage(player,command,toadd) 

	if toadd == nil then
		toadd = ""
	end

	if command == "spawnanimal" then
		print("CMD: ".. player .."> ".. "Usage: /spawnanimal <animalname> <X,Y,Z> " .. toadd)
		minetest.chat_send_player(player, "Usage: /spawnanimal <animalname> <X,Y,Z> " .. toadd)
	end

	if command == "ukn_animal" then
		print("CMD: ".. player .."> "..  "Unknown animal name "..toadd)
		minetest.chat_send_player(player, "Unknown animal name "..toadd)
	end

	if command == "inv_pos" then
		print("CMD: ".. player .."> "..  "Invalid position "..toadd)
		minetest.chat_send_player(player, "Invalid position "..toadd)
	end

	if command == "animal_spawned" then
		print("CMD: ".. player .."> "..  "Animal successfully spawned "..toadd)
		minetest.chat_send_player(player, "Animal successfully spawned "..toadd)
	end

end

-------------------------------------------------------------------------------
-- name: animals_handle_spawn_animal_cmd(name,message)
--
-- action: handle a spawn animal command
--
-- param1: playername
-- param2: message received
-- retval:
------------------------------------------------------------------------------
function animals_handle_spawn_animal_cmd(name,message)
	local start_pos = string.find(message," ")		

	if (start_pos == nil) then
		animals_print_usage(name,"spawnanimal")	
		return true
	end

	start_pos = start_pos +1

	local end_pos = string.find(message," ",start_pos)

	if end_pos == nil then
		animals_print_usage(name,"spawnanimal")	
		return true
	end

	local animalname = string.sub(message,start_pos,end_pos-1)

	if animals_is_known_animal(animalname) ~= true then
		animals_print_usage(name,"ukn_animal", ">"..animalname.."<") 
		return true
	end

	local spawnpoint = {x=0,y=0,z=0}

	start_pos = end_pos +1
	end_pos = string.find(message,",",start_pos)

	if end_pos ~= nil then
		print("Found: ".. string.sub(message,start_pos,end_pos-1).. " as x")
		spawnpoint.x = tonumber(string.sub(message,start_pos,end_pos-1))
	else
		animals_print_usage(name,"spawnanimal")	
		return true
	end

	start_pos = end_pos +1
	end_pos = string.find(message,",",start_pos)

	if end_pos ~= nil then
		print("Found: ".. string.sub(message,start_pos,end_pos-1).. " as y")
		spawnpoint.y = tonumber(string.sub(message,start_pos,end_pos-1))
	else
		animals_print_usage(name,"spawnanimal")	
		return true
	end

	start_pos = end_pos +1

	print("Found: ".. string.sub(message,start_pos).. " as z")
	spawnpoint.z = tonumber(string.sub(message,start_pos))

	if spawnpoint.z == nil then
		animals_print_usage(name,"spawnanimal")	
		return true
	end

	local node_at_spawnpoint = minetest.env:get_node(spawnpoint)

	if animals_pos_is_zero(spawnpoint) or
		node_at_spawnpoint == nil and
		node_at_spawnpoint.name ~= "air" then
		animals_print_usage(name,"inv_pos",printpos(spawnpoint))	
		return true
	end

	print("Spawning animal ".. animalname .." at " .. printpos(spawnpoint))

	local newobject = minetest.env:add_entity(spawnpoint,animalname)

	local newentity = animals_find_entity(newobject)
	
	if newentity ~= nil then
		animals_print_usage(name,"animal_spawned", animalname)
	else
		print("Bug no "..animalname.." has been created!")
	end

end

-------------------------------------------------------------------------------
-- name: animals_handle_list_spawns_cmd(name,message)
--
-- action: print list of all known spawnpoints
--
-- param1: playername
-- param2: message received
-- retval:
------------------------------------------------------------------------------
function animals_handle_list_spawns_cmd(name,message)

	for index,value in pairs(spawning.spawn_points) do
		local tosend = index .. ": " .. value[2] .. " at " .. printpos(value[1])
		print(tosend)
		minetest.chat_send_player(name,tosend)
	end

end

-------------------------------------------------------------------------------
-- name: animals_handle_list_spawns_cmd(name,message)
--
-- action: print list of all current active animals
--
-- param1: playername
-- param2: message received
-- retval:
------------------------------------------------------------------------------
function animals_handle_list_active_animals_cmd(name,message)
	
	local count = 1
	for index,value in pairs(minetest.luaentities) do 
		if value.animals_name ~= nil then
			local tosend = count .. ": " .. value.animals_name .. " at " .. printpos(value.object:getpos())
			print(tosend)
			minetest.chat_send_player(name,tosend)
			count = count +1
		end
	end

end

-------------------------------------------------------------------------------
-- name: animals_handle_add_tools_cmd(name,message)
--
-- action: add toolset for testing
--
-- param1: playername
-- param2: message received
-- retval:
------------------------------------------------------------------------------
function animals_handle_add_tools_cmd(name,message)
	local player = minetest.env:get_player_by_name(name)
	
	if player ~= nil then
		player:get_inventory():add_item("main", "animalmaterials:lasso 20")
		player:get_inventory():add_item("main", "animalmaterials:net 20")
		player:get_inventory():add_item("main", "animalmaterials:scissors 1")
		player:get_inventory():add_item("main", "animalmaterials:glass 10")	
	end

end


function animals_handle_list_animals_cmd(name,message)

	local text = ""
	for i,val in ipairs(animals_registred_animals) do
		text = text .. val .. " "
	end
	minetest.chat_send_player(name, "ANIMALS: "..text)
end

-------------------------------------------------------------------------------
-- name: animals_debug_handler(name,message)
--
-- action: global chat message handler for animals
--
-- param1: playername
-- param2: message received
-- retval:
------------------------------------------------------------------------------
function animals_debug_handler(name,message)

	if message == nil then
		return false
	end

	if string.find(message,"/spawnanimal") ~= nil then
		animals_handle_spawn_animal_cmd(name,message)
		return true
	end

	if string.find(message,"/listspawns") ~= nil then
		animals_handle_list_spawns_cmd(name,message)
		return true
	end

	if string.find(message,"/listactiveanimals") ~= nil then
		animals_handle_list_active_animals_cmd(name,message)
		return true
	end
	
	if string.find(message,"/debug_add_tools") ~= nil then
		animals_handle_add_tools_cmd(name,message)
		return true
	end
	
	if string.find(message,"/listanimals") ~= nil then
		animals_handle_list_animals_cmd(name,message)
		return true
	end
	
--	if string.find(message,"/traceon") ~= nil then
--		luatrace.tron()
--		return true
--	end
	
--	if string.find(message,"/traceoff") ~= nil then
--		luatrace.troff()
--		return true
--	end
	
	return false
end

function animals_init_debug()
	minetest.register_on_chat_message(animals_debug_handler)
end
