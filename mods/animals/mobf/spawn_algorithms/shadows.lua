-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file shadows.lua
--! @brief spawn algorithm for in shadow spawning
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @addtogroup spawn_algorithms
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- name: mobf_spawn_in_shadows(mob_name,mob_transform,spawning_data,environment)
--
--! @brief find a place with low light to spawn an mob
--
--! @param mob_name name of mob
--! @param mob_transform secondary name of mob
--! @param spawning_data spawning configuration
--! @param environment environment of mob
-------------------------------------------------------------------------------

function mobf_spawn_in_shadows(mob_name,mob_transform,spawning_data,environment) 

	minetest.log(LOGLEVEL_INFO,"MOBF:\tregistering shadow spawn abm callback for mob "..mob_name)
	
	local media = nil
	
	if environment ~= nil and
		environment.media ~= nil then
		media = environment.media	
	end

	minetest.register_abm({
			nodenames = { "default:stone" },
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
					dbg_mobf.spawning_lvl1("MOBF: not spawning due to 0 pos")
					mobf_warn_long_fct(starttime,"mobf_spawn_in_shadows")
					return
				end

				--check if there s enough space above to place mob
				if mobf_air_above(pos,spawning_data.height) ~= true then
					dbg_mobf.spawning_lvl3("MOBF: height requirement not met")
					mobf_warn_long_fct(starttime,"mobf_spawn_in_shadows")
					return
				end

				local node_above = minetest.env:get_node(pos_above)

				if mob_name == nil then
					minetest.log(LOGLEVEL_ERROR,"MOBF: Bug!!! mob name not available")
				else
					dbg_mobf.spawning_lvl3("MOBF: trying to spawn " .. mob_name)
                    if mobf_mob_around(mob_name,mob_transform,pos,spawning_data.density,true) == 0 then

						local maxlight = mobf_max_light_around(pos,3,0.5)
						if  maxlight < 3 then

							local newobject = minetest.env:add_entity(pos_above,mob_name)

							local newentity = mobf_find_entity(newobject)

							if newentity == nil then
								minetest.log(LOGLEVEL_ERROR,"MOBF: unable to create mob " .. mob_name .. " at pos " .. printpos(pos))
							else
								minetest.log(LOGLEVEL_INFO,"MOBF: Spawning "..mob_name.." in shadows at position "..printpos(pos) .. " maxlight was: " .. maxlight)
							end
						else
						dbg_mobf.spawning_lvl3("MOBF: too much light next to " ..printpos(pos) .. " light: " .. maxlight )
						end
					else
						dbg_mobf.spawning_lvl3("MOBF: too many mobs next to " ..printpos(pos))
					end
				end
			mobf_warn_long_fct(starttime,"mobf_spawn_in_shadows")
			end,
		})
end

--!@}

spawning.register_spawn_algorithm("shadows", mobf_spawn_in_shadows)