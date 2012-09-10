-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file at_night.lua
--! @brief component containing spawning features
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @addtogroup spawn_algorithms
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- name: mobf_spawn_at_night(mob_name,mob_transform,spawning_data,environment)
--
--! @brief spawn only at night
--
--! @param mob_name name of mob
--! @param mob_transform secondary name of mob
--! @param spawning_data spawning configuration
--! @param environment environment of mob
-------------------------------------------------------------------------------
function mobf_spawn_at_night(mob_name,mob_transform,spawning_data,environment) 

	print("\tregistering night spawn abm callback for mob "..mob_name)
	
	local media = nil
	
	if environment ~= nil and
		environment.media ~= nil then
		media = environment.media	
	end

	minetest.register_abm({
			nodenames = { "default:stone","default:dirt_with_grass","default:dirt" },
			neighbors = media,
			interval = 20,
			chance = math.floor(1/spawning_data.rate),
			action = function(pos, node, active_object_count, active_object_count_wider)
				local starttime = mobf_get_time_ms()
				local pos_above = {
					x = pos.x,
					y = pos.y + 1,
					z = pos.z
				}

				--never try to spawn an mob at pos (0,0,0) it's initial entity spawnpos and
				--used to find bugs in initial spawnpoint setting code
				if mobf_pos_is_zero(pos) then
					mobf_warn_long_fct(starttime,"mobf_spawn_at_night")
					return
				end

				--check if there s enough space above to place mob
				if mobf_air_above(pos,spawning_data.height) ~= true then
					mobf_warn_long_fct(starttime,"mobf_spawn_at_night")
					return
				end


				local node_above = minetest.env:get_node(pos_above)


				if mob_name == nil then
					minetest.log(LOGLEVEL_ERROR, "MOBF: Bug!!! mob name not available")
				else
					--print("Find mobs of same type around:"..mob_name.. " pop dens: ".. population_density)
					if mobf_mob_around(mob_name,mob_transform,pos,spawning_data.density,true) == 0 then
						if minetest.env:get_node_light(pos_above,0.5) == LIGHT_MAX +1 and 
							minetest.env:get_node_light(pos_above,0.0) < 7 and
							minetest.env:get_node_light(pos_above) < 6 then

							local newobject = minetest.env:add_entity(pos_above,mob_name)

							local newentity = mobf_find_entity(newobject)

							if newentity == nil then
								minetest.log(LOGLEVEL_ERROR,"MOBF: Bug!!! no "..mob_name.." has been created!")
							end

							minetest.log(LOGLEVEL_INFO,"MOBF Spawning "..mob_name.." at night at position "..printpos(pos))
						end
					end
				end
				mobf_warn_long_fct(starttime,"mobf_spawn_at_night")
			end,
		})
end

--!@}

spawning.register_spawn_algorithm("at_night", mobf_spawn_at_night)