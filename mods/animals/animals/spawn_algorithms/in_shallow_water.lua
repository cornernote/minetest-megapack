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
-- name: animals_spawn_in_shallow_water(animal)
--
-- action: find a place in water to spawn animal
--
-- param1: name of animal
-- retval: -
-------------------------------------------------------------------------------

function animals_spawn_in_shallow_water(animal_name,animal_transform,spawning_data,environment) 

	print("\tregistering shallow water spawn abm callback for animal "..animal_name)
	
	local media = nil
	
	if environment ~= nil and
		environment.media ~= nil then
		media = environment.media	
	end

	minetest.register_abm({
			nodenames = { "default:water_source" },
			neighbors = media,
			interval = 10,
			chance = math.floor(1/spawning_data.rate),
			action = function(pos, node, active_object_count, active_object_count_wider)
				local pos_above = {
					x = pos.x,
					y = pos.y + 1,
					z = pos.z
				}

				--never try to spawn an animal at pos (0,0,0) it's initial entity spawnpos and
				--used to find bugs in initial spawnpoint setting code
				if animals_pos_is_zero(pos) then
					return
				end

				--check if water is to deep
				if animals_air_distance(pos) < 10 then
					return
				end

				if animal_name == nil then
					print("ANIMALS: Bug!!! Animal name not available")
				else
					--print("Try to spawn animal: "..animal_name)
				
					if spawning.spawned_around(animal_name,animal_transform,pos,spawning_data.density) == false then

						if animals_is_node_in_cube("default:dirt",pos,10) or
							animals_is_node_in_cube("default:dirt_with_grass",pos,10) then

							local newobject = minetest.env:add_entity(pos,animal_name)

							local newentity = animals_find_entity(newobject)

							if newentity == nil then
								print("Bug no "..animal_name.." has been created!")
							end

							print("Spawning "..animal_name.." in shallow water "..printpos(pos))
						--else
							--print(printpos(pos).." not next to ground")
						end			
					end
				end
			end,
		})
end

animals_spawn_algorithms["in_shallow_water"] = animals_spawn_in_shallow_water