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
-- name: animals_deserialize_permanent_entity_data(datastring)
--
-- action: parse datastring and return table of data
--
-- param1: string to deserialize
-- retval: table containing data
-------------------------------------------------------------------------------

function animals_deserialize_permanent_entity_data(staticdata)


	local retval = {spawnpoint={x=0,y=0,z=0},playerspawned=false,original_spawntime=-1}


	if staticdata ~= "" then
		local start_pos = 1
		local end_pos = string.find(staticdata,";")

		if end_pos ~= nil then
			dbg_animals.permanent_store_lvl1("ANIMALS: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as first element")
			if string.sub(staticdata,start_pos,end_pos-1) == "true" then
				retval.playerspawned = true
			end
		end

		start_pos = end_pos +1
		end_pos = string.find(staticdata,";",start_pos)

		if end_pos ~= nil then
			dbg_animals.permanent_store_lvl1("ANIMALS: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as second element")
			retval.spawnpoint.x = tonumber(string.sub(staticdata,start_pos,end_pos-1))
		end

		start_pos = end_pos +1
		end_pos = string.find(staticdata,";",start_pos)

		if end_pos ~= nil then
			dbg_animals.permanent_store_lvl1("ANIMALS: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as third element")
			retval.spawnpoint.y = tonumber(string.sub(staticdata,start_pos,end_pos-1))
		end

		start_pos = end_pos +1
		end_pos = string.find(staticdata,";",start_pos)

		if end_pos ~= nil then
			dbg_animals.permanent_store_lvl1("ANIMALS: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as fourth element")
			retval.spawnpoint.z = tonumber(string.sub(staticdata,start_pos,end_pos-1))
		end
		
		start_pos = end_pos +1
		end_pos = string.find(staticdata,";",start_pos)
		
		if end_pos ~= nil then
			dbg_animals.permanent_store_lvl1("ANIMALS: Found: ".. string.sub(staticdata,start_pos,end_pos-1).. " as fivth element")
			retval.original_spawntime = tonumber(string.sub(staticdata,start_pos,end_pos-1))
		end					
	end

	return retval

end

-------------------------------------------------------------------------------
-- name: animals_serialize_permanent_entity_data(entity)
--
-- action: return string containing all entity data to be preserved
--
-- param1: entity to get data from
-- retval: string containing data
-------------------------------------------------------------------------------
function animals_serialize_permanent_entity_data(entity)
	if entity.dynamic_data ~= nil and
		entity.dynamic_data.spawning ~= nil then
		local player_spawned = "false"
		if entity.dynamic_data.spawning.player_spawned == true then
			player_spawned = "true"				
		end
		dbg_animals.permanent_store_lvl1("ANIMALS: Saving: " .. player_spawned .. ";" ..
									entity.dynamic_data.spawning.spawnpoint.x .. ";"..
									entity.dynamic_data.spawning.spawnpoint.y .. ";"..
									entity.dynamic_data.spawning.spawnpoint.z .. ";")
		return 	player_spawned .. ";" ..
				entity.dynamic_data.spawning.spawnpoint.x .. ";"..
				entity.dynamic_data.spawning.spawnpoint.y .. ";" .. 
				entity.dynamic_data.spawning.spawnpoint.z .. ";" ..
				entity.dynamic_data.spawning.original_spawntime .. ";"
	else
		minetest.log(LOGLEVEL_ERROR,"ANIMALS: No spawning information available on saving animal")
	end
end
