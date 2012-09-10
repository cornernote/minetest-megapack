-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file spawning.lua
--! @brief component containing spawning features
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--

--! @defgroup spawning Spawn mechanisms
--! @brief all functions and variables required for automatic mob spawning 
--! @ingroup framework_int
--! @{
--
--! @defgroup spawn_algorithms Spawn algorithms 
--! @brief spawn algorithms provided by mob framework (can be extended by mods)
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
--! @class spawning
--! @brief spawning features
spawning = {}

--!@}

--! @brief registry for spawn algorithms
--! @memberof spawning
--! @private
mobf_spawn_algorithms = {}


-------------------------------------------------------------------------------
-- name: remove_uninitialized(entity,staticdata)
-- @function [parent=#spawning] remove_uninitialized
--
--! @brief remove a spawn point based uppon staticdata supplied
--! @memberof spawning
--
--! @param entity to remove
--! @param staticdata of mob
-------------------------------------------------------------------------------
function spawning.remove_uninitialized(entity, staticdata)
	--entity may be known in spawnlist
	if staticdata ~= nil then
		local permanent_data = mobf_deserialize_permanent_entity_data(staticdata)
		if (permanent_data.spawnpoint ~= nil) then
		
			--prepare information required to remove entity
			entity.dynamic_data = {}
			entity.dynamic_data.spawning = {}
			entity.dynamic_data.spawning.spawnpoint = permanent_data.spawnpoint
			
			spawning.remove(entity)
		end
	else
		--directly remove it can't be known to spawnlist
		entity.object:remove()
	end	
end

-------------------------------------------------------------------------------
-- name: remove(entity)
-- @function [parent=#spawning] remove
--
--! @brief remove a mob
--! @memberof spawning
--
--! @param entity mob to remove
-------------------------------------------------------------------------------
function spawning.remove(entity)
	dbg_mobf.spawning_lvl3("MOBF: --> remove")
	if entity ~= nil then
		entity.dynamic_data.spawning.removed = true
		entity.object:remove()
	else
		minetest.log(LOGLEVEL_ERROR,"Trying to delete an an non existant mob")
	end
	
	dbg_mobf.spawning_lvl3("MOBF: <-- remove")
end

-------------------------------------------------------------------------------
-- name: init_dynamic_data(entity)
-- @function [parent=#spawning] init_dynamic_data
--
--! @brief initialize dynamic data required for spawning
--! @memberof spawning
--
--! @param entity mob to initialize dynamic data
--! @param now current time
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
-- name: check_population_density(mob)
-- @function [parent=#spawning] check_population_density
--
--! @brief check and fix if there are too many mobs within a specific range
--! @memberof spawning
--
--! @param entity mob to check
--! @param now current time
-------------------------------------------------------------------------------
function spawning.check_population_density(entity,now)

	-- don't check if mob is player spawned
	if entity.dynamic_data.spawning.player_spawned == true then
		dbg_mobf.spawning_lvl1("MOBF: mob is player spawned skipping pop dense check")
		return
	end


	--don't do population check while fighting
	if entity.dynamic_data.combat ~= nil and
		entity.dynamic_data.combat.target ~= "" then
		return
	end


	--only check every 15 seconds
	if entity.dynamic_data.spawning.ts_dense_check + 15 > now then
		return	
	end

	entity.dynamic_data.spawning.ts_dense_check = now

	local entitypos = mobf_round_pos(entity.object:getpos())

	--mob either not initialized completely or a bug
	if mobf_pos_is_zero(entitypos) then
		return
	end
	
	local secondary_name = ""
	if entity.data.harvest ~= nil then
		secondary_name = entity.data.harvest.transform_to
	end

	local mob_count = mobf_mob_around(entity.data.modname..":"..entity.data.name,
										secondary_name,
										entitypos,
										entity.data.spawning.density,
										true)
	if  mob_count > 3 then
		entity.dynamic_data.spawning.removed = true
		minetest.log(LOGLEVEL_NOTICE,"MOBF: Too many "..entity.data.name.." at one place dying",entity.dynamic_data.spawning.player_spawned)
		spawning.remove(entity)
	else
		dbg_mobf.spawning_lvl1("Density ok only "..mob_count.." mobs around")
	end
end


-------------------------------------------------------------------------------
-- name: replace_entity(pos,name,spawnpos,health)
-- @function [parent=#spawning] replace_entity
--
--! @brief replace mob at a specific position by a new one
--! @memberof spawning
--
--! @param entity mob to replace
--! @param name of the mob to add
--! @return entity added or nil on error
-------------------------------------------------------------------------------
function spawning.replace_entity(entity,name)
	dbg_mobf.spawning_lvl3("MOBF: --> replace_entity(".. entity.data.name .. "|" .. name .. ")")

	-- get data to be transfered to new entity
	local pos             = entity.object:getpos()
	local health          = entity.object:get_hp()
	local playerspawned   = entity.dynamic_data.spawning.player_spawned
	local spawnpoint      = { 
								x=entity.dynamic_data.spawning.spawnpoint.x,
								y=entity.dynamic_data.spawning.spawnpoint.y,
								z=entity.dynamic_data.spawning.spawnpoint.z, 
							}
	local oldname         = entity.data.name

	--delete current mob
	dbg_mobf.spawning_lvl2("MOBF: replace_entity 2 : removing " ..  entity.data.name)
	spawning.remove(entity)

	local newobject = minetest.env:add_entity(pos,name)
	local newentity = mobf_find_entity(newobject)

	if newentity ~= nil then
		dbg_mobf.spawning_lvl2("MOBF: replace_entity 3 : " ..  name .. 
						" added at " .. printpos(newentity.dynamic_data.spawning.spawnpoint) .. 
						" resetting spawnpoint to " ..printpos(spawnpoint))
		newentity.dynamic_data.spawning.player_spawned = playerspawned

		--replace spawnpoint by old mobs one
		newentity.dynamic_data.spawning.spawnpoint = spawnpoint
		dbg_mobf.spawning_lvl2("MOBF: replace_entity 4 : adding " .. printpos(spawnpoint))
		
		newentity.object:set_hp(health)		
	else
		minetest.log(LOGLEVEL_ERROR,"MOBF: replace_entity 4 : Bug no "..name.." has been created")
	end
	dbg_mobf.spawning_lvl3("MOBF: <-- replace_entity")
	return newentity
end

------------------------------------------------------------------------------
-- name: lifecycle()
-- @function [parent=#spawning] lifecycle
--
--! @brief check mob lifecycle
--! @memberof spawning
--! @ingroup framework_int
--
--! @return true/false still alive dead
-------------------------------------------------------------------------------
function spawning.lifecycle(entity,now)

	if entity.dynamic_data.spawning.original_spawntime ~= nil then
	
		local lifetime = 3600*48
		
		if entity.data.spawning.lifetime ~= nil then
			lifetime = entity.data.spawning.lifetime
		end
		
		local current_age = now - entity.dynamic_data.spawning.original_spawntime
	
		if current_age > 0 and 
			current_age > lifetime then
			
			entity.object:remove()
			return false
		end
	else
		entity.dynamic_data.spawning.original_spawntime = now
	end

	return true
end

------------------------------------------------------------------------------
-- name: register_spawn_algorithm()
-- @function [parent=#spawning] register_spawn_algorithm
--
--! @brief print current spawn statistics
--! @memberof spawning
--! @ingroup framework_int
--
--! @return true/false successfully added spawn algorithm
-------------------------------------------------------------------------------
function spawning.register_spawn_algorithm(name, algorithm)

	if (mobf_spawn_algorithms[name] ~= nil) then
		return false
	end
		
	mobf_spawn_algorithms[name] = algorithm

	return true
end

--include spawn algorithms
dofile (mobf_modpath .. "/spawn_algorithms/at_night.lua")
dofile (mobf_modpath .. "/spawn_algorithms/forrest.lua")
dofile (mobf_modpath .. "/spawn_algorithms/in_shallow_water.lua")
dofile (mobf_modpath .. "/spawn_algorithms/shadows.lua")
dofile (mobf_modpath .. "/spawn_algorithms/willow.lua")
dofile (mobf_modpath .. "/spawn_algorithms/in_air1.lua")
dofile (mobf_modpath .. "/spawn_algorithms/none.lua")
dofile (mobf_modpath .. "/spawn_algorithms/deep_large_caves.lua")