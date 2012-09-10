-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file in_shallow_water.lua
--! @brief spawn algorithm for shallow water spawning
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @addtogroup spawn_algorithms
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- name: mobf_spawn_in_shallow_water(mob_name,mob_transform,spawning_data,environment)
--
--! @brief find a place in water to spawn mob
--
--! @param mob_name name of mob
--! @param mob_transform secondary name of mob
--! @param spawning_data spawning configuration
--! @param environment environment of mob
-------------------------------------------------------------------------------

function mobf_spawn_in_shallow_water(mob_name,mob_transform,spawning_data,environment) 

	minetest.log(LOGLEVEL_INFO,"MOBF: \tregistering shallow water spawn abm callback for mob "..mob_name)
	
	local media = nil
	
	if environment ~= nil and
		environment.media ~= nil then
		media = environment.media	
	end

	minetest.register_abm({
			nodenames = { "default:water_source" },
			neighbors = media,
			interval = 60,
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
					mobf_warn_long_fct(starttime,"mobf_spawn_in_shallow_water")
					return
				end

				--check if water is to deep
				if mobf_air_distance(pos) < 10 then
					mobf_warn_long_fct(starttime,"mobf_spawn_in_shallow_water")
					return
				end

				if mob_name == nil then
					minetest.log(LOGLEVEL_ERROR,"MOBF: Bug!!! mob name not available")
				else
					--print("Try to spawn mob: "..mob_name)
				
                    if mobf_mob_around(mob_name,mob_transform,pos,spawning_data.density,true) == 0 then

						if minetest.env:find_node_near(pos, 10, {"default:dirt",
                                                                "default:dirt_with_grass"}) ~= nil then

							local newobject = minetest.env:add_entity(pos,mob_name)

							local newentity = mobf_find_entity(newobject)

							if newentity == nil then
								minetest.log(LOGLEVEL_ERROR,"MOBF: Bug!!! no "..mob_name.." has been created!")
							end

							minetest.log(LOGLEVEL_INFO,"MOBF: Spawning "..mob_name.." in shallow water "..printpos(pos))
						--else
							--print(printpos(pos).." not next to ground")
						end			
					end
				end
				mobf_warn_long_fct(starttime,"mobf_spawn_in_shallow_water")
			end,
		})
end

--!@}

spawning.register_spawn_algorithm("in_shallow_water", mobf_spawn_in_shallow_water)