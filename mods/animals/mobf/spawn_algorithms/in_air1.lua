-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file in_air1.lua
--! @brief spawn algorithm for birds
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @addtogroup spawn_algorithms
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- name: mobf_spawn_in_air1(mob_name,mob_transform,spawning_data,environment)
--
--! @brief find a place in sky to spawn mob
--
--! @param mob_name name of mob
--! @param mob_transform secondary name of mob
--! @param spawning_data spawning configuration
--! @param environment environment of mob
-------------------------------------------------------------------------------

function mobf_spawn_in_air1(mob_name,mob_transform,spawning_data,environment) 

	minetest.log(LOGLEVEL_INFO,"MOBF:\tregistering in air 1 spawn abm callback for mob "..mob_name)
	
	local media = nil
	
	if environment ~= nil and
		environment.media ~= nil then
		media = environment.media	
	end

	minetest.register_abm({
			nodenames = { "default:dirt", "default:dirt_with_grass" },
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
				
				local node_above = minetest.env:get_node(pos_above)
				
				if node_above.name ~= "air" then
					mobf_warn_long_fct(starttime,"mobf_spawn_in_air1")
					return
				end

				
				local pos_spawn = {
					x = pos.x,
					y = pos.y + 10 + math.floor(math.random(0,10)),
					z = pos.z
				}
				
				local node_spawn = minetest.env:get_node(pos_spawn)



				if node_spawn.name ~= "air" then
					mobf_warn_long_fct(starttime,"mobf_spawn_in_air1")
					return
				end
				
				if mob_name == nil then
					minetest.log(LOGLEVEL_ERROR,"MOBF: Bug!!! mob name not available")
				else
					--print("Try to spawn mob: "..mob_name)				

                    if mobf_mob_around(mob_name,mob_transform,pos,spawning_data.density,true) == 0 then

						local newobject = minetest.env:add_entity(pos_spawn,mob_name)

						local newentity = mobf_find_entity(newobject)

						if newentity == nil then
							minetest.log(LOGLEVEL_ERROR,"MOBF: Bug!!! no "..mob_name.." has been created!")
						end

						minetest.log(LOGLEVEL_INFO, "MOBF: Spawning "..mob_name.." in air "..printpos(pos_spawn))
					end
				end
				mobf_warn_long_fct(starttime,"mobf_spawn_in_air1")
			end,
		})
end

--!@}

spawning.register_spawn_algorithm("in_air1", mobf_spawn_in_air1)