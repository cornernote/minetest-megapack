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

function animals_spawn_in_air1(animal_name,animal_transform,spawning_data,environment) 

	print("\tregistering in air 1 spawn abm callback for animal "..animal_name)
	
	local media = nil
	
	if environment ~= nil and
		environment.media ~= nil then
		media = environment.media	
	end

	minetest.register_abm({
			nodenames = { "default:dirt", "default:dirt_with_grass" },
			neighbors = media,
			interval = 10,
			chance = math.floor(1/spawning_data.rate),
			action = function(pos, node, active_object_count, active_object_count_wider)
			
				local pos_above = {
					x = pos.x,
					y = pos.y + 1,
					z = pos.z
				}
				
				local node_above = minetest.env:get_node(pos_above)
				
				if node_above.name ~= "air" then
					return
				end

				
				local pos_spawn = {
					x = pos.x,
					y = pos.y + 10 + math.floor(math.random(0,10)),
					z = pos.z
				}
				
				local node_spawn = minetest.env:get_node(pos_spawn)



				if node_spawn.name ~= "air" then
					return
				end
				
				if animal_name == nil then
					print("ANIMALS: Bug!!! Animal name not available")
				else
					--print("Try to spawn animal: "..animal_name)				

					if spawning.spawned_around(animal_name,animal_transform,pos_spawn,spawning_data.density) == false then

						local newobject = minetest.env:add_entity(pos_spawn,animal_name)

						local newentity = animals_find_entity(newobject)

						if newentity == nil then
							print("Bug no "..animal_name.." has been created!")
						end

						print("Spawning "..animal_name.." in air "..printpos(pos_spawn))
					end
				end
			end,
		})
end

animals_spawn_algorithms["in_air1"] = animals_spawn_in_air1