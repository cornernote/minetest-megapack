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

spawning = {}
spawning.spawn_points = {}

-------------------------------------------------------------------------------
-- name: update_spawnpoint_list(toadd)
--
-- action: check if element in spawnpoint list and update if necessary
--
-- param1: check spawnpoint
-- retval: -
-------------------------------------------------------------------------------
function spawning.update_spawnpoint_list(toupdate)
	toupdate[1] = animals_round_pos(toupdate[1])

	local found = false
	dbg_animals.spawning_lvl2("Updating "..toupdate[2].." at "..printpos(toupdate[1]))
	for index,value in pairs(spawning.spawn_points) do 
		if value[1].x == toupdate[1].x and
			value[1].y == toupdate[1].y and
			value[1].z == toupdate[1].z and
			value[2] == toupdate[2] then
			found = true
		end
	end

	if found ~= true then
		dbg_animals.spawning_lvl2("Need to add spawn point "..printpos(toupdate[1]).." for "..toupdate[2].." to list")
		table.insert(spawning.spawn_points,toupdate)	
	end
end

-------------------------------------------------------------------------------
-- name: remove_from_spawnpoint_list(toremove)
--
-- action: find and remove spawnpoint from list
--
-- param1: point to remove
-- retval: -
-------------------------------------------------------------------------------
function spawning.remove_from_spawnpoint_list(toremove)
	toremove[1] = animals_round_pos(toremove[1])

	dbg_animals.spawning_lvl2("Removing "..toremove[2].." at "..printpos(toremove[1]))
	for index,value in pairs(spawning.spawn_points) do 
		if value[1].x == toremove[1].x and
			value[1].y == toremove[1].y and
			value[1].z == toremove[1].z and
			value[2] == toremove[2] then
			table.remove(spawning.spawn_points,index)		
		end
	end
end

-------------------------------------------------------------------------------
-- name: remove(entity)
--
-- action: remove an animal
--
-- param1: entity to remove
-- retval: -
-------------------------------------------------------------------------------
function spawning.remove(entity)
	if entity ~= nil then
		entity.dynamic_data.spawning.removed = true
		spawning.remove_from_spawnpoint_list({
									entity.dynamic_data.spawning.spawnpoint,
									entity.data.modname..":"..entity.data.name
									})
		entity.object:remove()
	else
		minetest.log(LOGLEVEL_ERROR,"Trying to delete an an non existant animal")
	end
end

-------------------------------------------------------------------------------
-- name: init_dynamic_data(entity)
--
-- action: initialize dynamic data required for spawning
--
-- param1: entity to remove
-- retval: -
-------------------------------------------------------------------------------
function spawning.init_dynamic_data(entity,now)
	local data = {
		player_spawned = false,
		removed = false,
		ts_dense_check = now,
		spawnpoint = entity.object:getpos(),
		original_spawntime = now,
	}
	
	entity.dynamic_data.spawning = data
end

-------------------------------------------------------------------------------
-- name: check_population_density(animal)
--
-- action: check if there are to many animals within a specific range
--
-- param1: entity to check
-- retval: -
-------------------------------------------------------------------------------
function spawning.check_population_density(animal,now)

	-- don't check if animal is player spawned
	if animal.dynamic_data.spawning.player_spawned == true then
		dbg_animals.spawning_lvl1("ANIMALS: animal is player spawned skipping pop dense check")
		return
	end


	--don't do population check while fighting
	if animal.dynamic_data.combat ~= nil and
		animal.dynamic_data.combat.target ~= "" then
		return
	end


	--only check every 15 seconds
	if animal.dynamic_data.spawning.ts_dense_check + 15 > now then
		return	
	end

	animal.dynamic_data.spawning.ts_dense_check = now

	local entitypos = animals_round_pos(animal.object:getpos())

	--animal either not initialized completely or a bug
	if animals_pos_is_zero(entitypos) then
		return
	end
	
	local secondary_name = ""
	if animal.data.harvest ~= nil then
		secondary_name = animal.data.harvest.transform_to
	end

	local animal_count = animals_around(animal.data.modname..":"..animal.data.name,
										secondary_name,
										entitypos,
										animal.data.spawning.density,
										true)
	if  animal_count > 3 then
		animal.animals_removed = true
		minetest.log(LOGLEVEL_NOTICE,"ANIMALS: Too many "..animal.data.name.." at one place dying",animal.dynamic_data.spawning.player_spawned)
		spawning.remove(animal)
	else
		dbg_animals.spawning_lvl1("Density ok only "..animal_count.." animals around")
	end
end


-------------------------------------------------------------------------------
-- name: replace_entity(pos,name,spawnpos,health)
--
-- action: replace animal at a specific position by a new one
--
-- param1: entity to replace
-- param2: name of the animal to add
-- retval: entity added or nil on error
-------------------------------------------------------------------------------
function spawning.replace_entity(entity,name)
	dbg_animals.spawning_lvl2("ANIMALS: replacing entity " .. entity.data.name .. " by " .. name)

	-- get data to be transfered to new entity
	local pos             = entity.object:getpos()
	local health          = entity.object:get_hp()
	local playerspawned   = entity.dynamic_data.spawning.player_spawned
	local spawnpoint      = entity.dynamic_data.spawning.spawnpoint
	local oldname         = entity.data.name

	--delete current animal
	dbg_animals.spawning_lvl2("ANIMALS: removing " ..  entity.data.name)
	spawning.remove(entity)

	local newobject = minetest.env:add_entity(pos,name)
	local newentity = animals_find_entity(newobject)

	if newentity ~= nil then
		dbg_animals.spawning_lvl2("ANIMALS: " ..  name .. " added")
		newentity.dynamic_data.spawning.player_spawned = playerspawned

		--replace spawnpoint by old animals one
		spawning.remove_from_spawnpoint_list({newentity.dynamic_data.spawning.spawnpoint,name})
		newentity.dynamic_data.spawning.spawnpoint = spawnpoint
		spawning.update_spawnpoint_list({spawnpoint,name})

		newentity.object:set_hp(health)		
	else
		minetest.log(LOGLEVEL_ERROR,"ANIMALS:Bug no "..name.." has been created")
	end

	return newentity
end

-------------------------------------------------------------------------------
-- name: spawned_around(animal,animals2,pos,range)
--
-- action: check if any animal already spawned within range of pos
--
-- param1: name of animal
-- param2: secondary name of animal
-- param3: position to check
-- param4: range to check
-- retval: -
-------------------------------------------------------------------------------
function spawning.spawned_around(animals_name_to_check,animal_transform,pos,range)
	local mindistance = -1

	for index,value in pairs(spawning.spawn_points) do 

		local entitypos = animals_round_pos(value[1])

		if entitypos.x == 0 and
			entitypos.y == 0 and
			entitypos.z == 0 then
			minetest.log(LOGLEVEL_ERROR,"ANIMALS: BUG!!! there's an animal with spawnpoint (0,0,0) this is a reserved location not used to spawn animals!")
			return true
		end

		dbg_animals.spawning_lvl1("ANIMALS: entity at "..printpos(entitypos).." ".. printpos(value[1])..
							" looking for:"..animals_name_to_check.." or ".. animal_transform ..
							" current: " ..value[2]..
							" range:"..range)

		if 	value[2] ~= nil and
			(value[2] == animals_name_to_check or
			value[2] == animal_transform) then
			local distance = animals_calc_distance_2d(pos,value[1])

			if  distance < range then
				dbg_animals.spawning_lvl2("Found "..animals_name_to_check.. " or "..animal_transform .. " within specified range of "..range)
				return true
			end

			if distance < mindistance or
				mindistance < 0 then
				mindistance = distance
			end
		end
	end

	--if (mindistance == -1) then
		--for index,value in pairs(minetest.luaentities) do 
		--	local entitypos = animals_round_pos(value.object:getpos())			
			--print("entity at ("..entitypos.x..","..entitypos.y..","..entitypos.z..") looking for:"..animals_name_to_check)
		--end
		--print("Didn't find any entity named "..animals_name_to_check.. " or "..animal_transform.." at all")
		--animals_print_spawn_statistics()
	--end
	dbg_animals.spawning_lvl3("Minimum distance to another spawnpoint was ".. mindistance)
	return false
end


------------------------------------------------------------------------------
-- name: animals_print_spawn_statistics()
--
-- action: print current spawn statistics
--
-- retval: -
-------------------------------------------------------------------------------
function animals_print_spawn_statistics()

	local entity_count = 0	
	local animals_entity_count_all = 0
	local animals_entity_count = {}

	for i,val_clean in ipairs(animals_registred_animals) do
		animals_entity_count[val_clean] = 0
	end

	for index,value in pairs(minetest.luaentities) do 

		if value.animals_name ~= nil then
			animals_entity_count[value.animals_name] = animals_entity_count[value.animals_name] +1
			animals_entity_count_all = animals_entity_count_all +1
		else
			print("no name for entity with texture 1: "..value.textures[1])		
		end
		
		entity_count = entity_count +1
	end

	print("Table of entitys:")

		for i,value in ipairs(animals_registred_animals) do

		print(value.." -> " .. animals_entity_count[value])

	end

	print("Number of animals entitys: "..animals_entity_count_all)
	print("Total number of entitys  : "..entity_count)
end

--include spawn algorithms
dofile (animals_modpath .. "/spawn_algorithms/at_night.lua")
dofile (animals_modpath .. "/spawn_algorithms/forrest.lua")
dofile (animals_modpath .. "/spawn_algorithms/in_shallow_water.lua")
dofile (animals_modpath .. "/spawn_algorithms/shadows.lua")
dofile (animals_modpath .. "/spawn_algorithms/willow.lua")
dofile (animals_modpath .. "/spawn_algorithms/in_air1.lua")
dofile (animals_modpath .. "/spawn_algorithms/none.lua")