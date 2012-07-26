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
-- name: animals_spawn_on_willow(animal)
--
-- action: find a place on willow to spawn a animal
--
-- param1: name of animal
-- retval: -
-------------------------------------------------------------------------------

function animals_spawn_on_willow(animal_name,animal_transform,spawning_data,environment) 

	print("\tregistering willow spawn abm callback for animal "..animal_name)
	
	local media = nil
	
	if environment ~= nil and
		environment.media ~= nil then
		media = environment.media	
	end

	minetest.register_abm({
			nodenames = { "default:dirt_with_grass" },
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

				--check if there s enough space above to place animal
				if animals_air_above(pos,spawning_data.height) ~= true then
					return
				end

				local node_above = minetest.env:get_node(pos_above)

				if animal_name == nil then
					print("Animal name not available")
				else
					--print("Try to spawn animal: "..animal_name)				
					if node_above.name == "air" then
						--print("Find animals of same type around:"..animal_name.. " pop dens: ".. population_density)					
						if spawning.spawned_around(animal_name,animal_transform,pos_above,spawning_data.density) == false then
							local newobject = minetest.env:add_entity(pos_above,animal_name)

							local newentity = animals_find_entity(newobject)
							
							if newentity == nil then
								print("Bug no "..animal_name.." has been created!")
							end
							print("Spawning "..animal_name.." on willow at position "..printpos(pos))
						end
					end
				end
			end,
		})
end


animals_spawn_algorithms["willow"] = animals_spawn_on_willow