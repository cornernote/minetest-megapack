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
-- name: animals_register_animal_item(animal)
--
-- action: add animal item for catchable animals
--
-- param1: an animal declaration
-- retval: -
-------------------------------------------------------------------------------
function animals_register_animal_item(name,modname,description)
	minetest.register_craftitem(modname..":"..name, {
			description = description,
			image = modname.."_"..name.."_item.png",
			on_place = function(item, placer, pointed_thing)
				if pointed_thing.type == "node" then
					local pos = pointed_thing.above
			
					local newobject = minetest.env:add_entity(pos,modname..":"..name)

					local newentity = animals_find_entity(newobject)

					local newpos = newentity.object:getpos()

					if newentity ~= nil then
					
						if newentity.dynamic_data ~= nil then
							-- this can happen if animal is spawned on incorrect place 
							newentity.dynamic_data.spawning.player_spawned = true
						end
						item:take_item()
					else
						print("Bug no "..animal.name.." hasn't been created!")
					end
					return item
					end
				end
		})
end

-------------------------------------------------------------------------------
-- name: animals_add_animal(animal)
--
-- action: add an animal to internal data structures
--
-- param1: an animal declaration
-- retval: -
-------------------------------------------------------------------------------
function animals_add_animal(animal)

	if animal.name == nil or
		animal.modname == nil then
		minetest.log(LOGLEVEL_ERROR,"ANIMALS: name and modname are mandatory for ALL animals!")
	end

	--if a random drop is specified for this animal register it
	if animal.random_drop ~= nil then
		random_drop.register(animal)
	end

	--register animal entity
	minetest.register_entity(":".. animal.modname .. ":"..animal.name,
			 {
				physical 		= true,
				collisionbox 	= {-0.5,
									-0.5 * animal.graphics.visible_height,
									-0.5,
									0.5,
									0.5 * animal.graphics.visible_height,
									0.5},
				visual 			= "sprite",
				visual_size 	= animal.graphics.sprite_scale,
				textures 		= {animal.modname.."_"..animal.name..".png^[makealpha:128,0,0^[makealpha:128,128,0"},
				spritediv 		= animal.graphics.sprite_div,
				initial_sprite_basepos 	= {x=0, y=0},
				makes_footstep_sound = true,
				groups          = animal.generic.groups,



		--	actions to be done by animal on its own
			on_step = function(self, dtime)
			
				local now = animals_get_current_time()
						
				if self.dynamic_data.last_update == now then
					return
				end
				
				self.dynamic_data.last_update = now
						
				--movement generator
				self.dynamic_data.current_movement_gen.callback(self,now)

				--auto transform hook
				transform(self,now)

				--attack hook
				fighting.combat(self,now)

				--agression hook
				fighting.aggression(self,now)

				--workaround for shortcomings in spawn algorithm
				spawning.check_population_density(self,now)

				--random drop hook
				random_drop.callback(self,now)
				
				--random sound hook
				sound.play_random(self,now)

				--visual change hook
				update_orientation(self,now)	
				end,

		--player <-> animal interaction
			on_punch = function(self, hitter)
				if harvesting.callback(self,hitter) == false then	
					fighting.hit(self,hitter)
					end				
				end,

		--rightclick is only used for debug reasons by now
			on_rightclick = function(self, clicker)
				local lifetime = animals_get_current_time() - self.dynamic_data.spawning.original_spawntime
				print(self.data.name .. " is alive for " .. lifetime .. " seconds")
				if self.dynamic_data.movement.moving == true then
					print("Probab movement state: true")
				end
				if self.dynamic_data.movement.moving == false then
					print("Probab movement state: false")
				end
				
				print("Current accel: " .. printpos(self.object:getacceleration()) .. " Current speed: " .. printpos(self.object:getvelocity()))
				
				--print("Acceleration of ".. self.data.name .. ": " .. printpos(self.object:getacceleration()))
				end,

		--do basic animal initialization on activation
			on_activate = function(self,staticdata)
				--do some initial checks
				local pos = self.object:getpos()
				local current_node = minetest.env:get_node(pos)

				if current_node == nil then
					minetest.log(LOGLEVEL_ERROR,"ANIMALS: trying to activate animal in nil node! removing")
					self.object:remove()
					return
				end
			
				if environment.is_media_element(current_node.name,self.animals_mpattern.environment.media) == false then
					minetest.log(LOGLEVEL_ERROR,"ANIMALS: trying to activate animal " .. self.data.name .. " at invalid position")
					minetest.log(LOGLEVEL_ERROR,"	Activation at: ".. current_node.name .. " --> removing")
					self.object:remove()
					return
				end

				local now = animals_get_current_time()
				
				self.dynamic_data = {}
				
				self.dynamic_data.last_update = now
				self.dynamic_data.current_movement_gen = self.data.movement.default_gen
				
				spawning.init_dynamic_data(self,now)
				fighting.init_dynamic_data(self,now)
				random_drop.init_dynamic_data(self,now)				
				harvesting.init_dynamic_data(self,now)
				sound.init_dynamic_data(self,now)
				
				self.dynamic_data.current_movement_gen.init_dynamic_data(self,now)
				
				if self.data.generic.armor_groups ~= nil then
					self.object:set_armor_groups(self.data.generic.armor_groups)
				end

				--read saved data
				local retval = animals_deserialize_permanent_entity_data(staticdata)

				--set spawnpoint
				if self.dynamic_data.spawning ~= nil then
					if animals_pos_is_zero(retval.spawnpoint) ~= true then
						self.dynamic_data.spawning.spawnpoint = retval.spawnpoint
					else
						self.dynamic_data.spawning.spawnpoint = animals_round_pos(pos)
					end
					self.dynamic_data.spawning.player_spawned = retval.playerspawned
					
					if retval.original_spawntime ~= -1 then
						self.dynamic_data.spawning.original_spawntime = retval.original_spawntime
					end
				end

				--initialize height level
				if self.data.graphics.visible_height > 1 then
					local pos_to_check = {x=pos.x,y=pos.y-0.51,z=pos.z}
					
					local node_pos = minetest.env:get_node(pos)
					local node_pos_check = minetest.env:get_node(pos_to_check)				

					
					if node_pos ~= nil and
						node_pos_check ~= nil then
						--print("ANIMALS: fixing spawn position required? " .. node_pos.name .. " " .. node_pos_check.name)
						if node_pos.name ~= node_pos_check.name then 
							pos.y = pos.y + ((self.data.graphics.visible_height -1)/2)
							--print("ANIMALS: fixing spawn position moving to " ..printpos(pos))
							self.object:moveto(pos)
						end
					end
				end

				--initialize sprites
				self.object:setsprite({x=0,y=0}, 1, 0, true)

				--initialize health
				self.object:set_hp(self.data.generic.base_health)
				--self.dynamic_data.generic = {
				--	health = self.data.generic.base_health
				--	}
				--print("Animal "..self.data.name.." set health to " .. self.data.generic.base_health .. " got " .. self.object:get_hp())

				--add animal to module spawn list
				spawning.update_spawnpoint_list({animals_round_pos(pos),self.data.modname..":"..self.data.name})
				end,
				
		--prepare permanent data
			get_staticdata = function(self)
				return animals_serialize_permanent_entity_data(self)
				end,



		--custom variables for each animal
			data             		= animal,
			animals_mpattern 		= animals_movement_patterns[animal.movement.pattern],

	       	getbasepos = function(entity)
        			local pos = entity.object:getpos()

					-- if visual height is more than one block the center of base block is 
					-- below the entities center
					if (entity.data.graphics.visible_height > 1) then
						pos.y = pos.y - (entity.data.graphics.visible_height/2) + 0.5
					end
 	
        			return pos
        		end				
	
			}
		)

	--only add items for catchable animals
	--if animal.catching ~= nil then
		animals_register_animal_item(animal.name,animal.modname,animal.generic.description)
	--end
	
	--check if a movement pattern was specified
	if animals_movement_patterns[animal.movement.pattern] == nil then
		print("ANIMALS Warning: no movement pattern specified!")
	end

	--register spawn callback to world
	if animals_spawn_algorithms[animal.spawning.algorithm] ~= nil then
		local secondary_name = ""		
		if animal.harvest ~= nil then
			secondary_name = animal.harvest.transforms_to
		end
		
		print("Pattern:" , animal.movement.pattern)
		local dummy6  = animals_movement_patterns[animal.movement.pattern].environment
		
		animals_spawn_algorithms[animal.spawning.algorithm](animal.modname..":"..animal.name,
															secondary_name,
															animal.spawning,
															animals_movement_patterns[animal.movement.pattern].environment)
	else
		--make some log entry
	end

	--register animal name to internal data structures
	table.insert(animals_registred_animals,animal.modname.. ":"..animal.name)
end

------------------------------------------------------------------------------
-- name: animals_is_known_animal(name)
--
-- action: check if animal of name is known
--
-- retval: true/false
-------------------------------------------------------------------------------
function animals_is_known_animal(name)
	for i,val in ipairs(animals_registred_animals) do
		if name == val then
			return true
		end
	end

	return false
end

