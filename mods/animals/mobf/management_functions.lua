-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file management_functions.lua
--! @brief functions needed for mob registration
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

local management_functions_spacer = {} --unused to fix lua doxygen bug only

-------------------------------------------------------------------------------
-- name: mobf_register_mob_item(mob)
--
--! @brief add mob item for catchable mobs
--
--! @param name name of mob
--! @param modname name of mod mob is defined in
--! @param description description to use for mob
-------------------------------------------------------------------------------
function mobf_register_mob_item(name,modname,description)
	minetest.register_craftitem(modname..":"..name, {
			description = description,
			image = modname.."_"..name.."_item.png",
			on_place = function(item, placer, pointed_thing)
				if pointed_thing.type == "node" then
					local pos = pointed_thing.above
			
					local newobject = minetest.env:add_entity(pos,modname..":"..name)

					local newentity = mobf_find_entity(newobject)

					local newpos = newentity.object:getpos()

					if newentity ~= nil then
					
						if newentity.dynamic_data ~= nil then
							-- this can happen if mob is spawned on incorrect place 
							newentity.dynamic_data.spawning.player_spawned = true
							
							if placer:is_player(placer) then
								minetest.log(LOGLEVEL_INFO,"MOBF: mob placed by " .. placer:get_player_name(placer))
								newentity.dynamic_data.spawning.spawner = placer:get_player_name(placer)
							end
							
							if (newentity.data.generic.custom_on_place_handler ~= nil) then
								newentity.data.generic.custom_on_place_handler(newentity, placer, pointed_thing)
							end
						end
						item:take_item()
					else
						minetest.log(LOGLEVEL_ERROR,"MOBF: Bug no "..mob.name.." hasn't been created!")
					end
					return item
					end
				end
		})
end


-------------------------------------------------------------------------------
-- name: entity_at_loaded_pos(entity)
--
--! @brief check if entity is activated at already loaded pos
--! @ingroup framework_mob
--
--! @param pos to check
--! @return true/false
-------------------------------------------------------------------------------
function entity_at_loaded_pos(pos)

	local current_node = minetest.env:get_node(pos)

	if current_node ~= nil then
		if current_node.name == "ignore" then
			minetest.log(LOGLEVEL_WARNING,"MOBF: spawned at unloaded pos!")
			return false
		else
			return true
		end
	end
	minetest.log(LOGLEVEL_WARNING,"MOBF: spawned at invalid pos!")
	return true
end


-------------------------------------------------------------------------------
-- name: mobf_add_mob(mob)
--
--! @brief register a mob within mob framework
--! @ingroup framework_mob
--
--! @param mob a mob declaration
-------------------------------------------------------------------------------
function mobf_add_mob(mob)

	if mob.name == nil or
		mob.modname == nil then
		minetest.log(LOGLEVEL_ERROR,"MOBF: name and modname are mandatory for ALL mobs!")
	end
	
	
	local setgraphics = {}

	--if a random drop is specified for this mob register it
	if mob.random_drop ~= nil then
		random_drop.register(mob.random_drop)
	end
	
	minetest.log(LOGLEVEL_INFO,"MOBF: adding: " .. mob.name)
	if (mob.graphics_3d == nil) or
		minetest.setting_getbool("mobf_disable_3d_mode") then
		if (mob.graphics == nil) then
			minetest.log(LOGLEVEL_ERROR,"MOBF: " .. mob.name .. " 2D mode selected but not available!")
			return
		end
		
		setgraphics.collisionbox    =  {-0.5,
									-0.5 * mob.graphics.visible_height,
									-0.5,
									0.5,
									0.5 * mob.graphics.visible_height,
									0.5}
									
		setgraphics.visual          = "sprite"
		setgraphics.textures        = { mob.modname.."_"..mob.name..".png^[makealpha:128,0,0^[makealpha:128,128,0" }
		setgraphics.visual_size     = mob.graphics.sprite_scale
		setgraphics.spritediv        = mob.graphics.sprite_div
		
	else
		setgraphics.collisionbox    = mob.graphics_3d.collisionbox
		setgraphics.visual          = mob.graphics_3d.visual
		setgraphics.visual_size     = mob.graphics_3d.visual_size
		setgraphics.textures        = mob.graphics_3d.textures
	end
	
	--register mob entity
	minetest.register_entity(":".. mob.modname .. ":"..mob.name,
			 {
				physical        = true,
				collisionbox    = setgraphics.collisionbox,
				visual          = setgraphics.visual,
				textures        = setgraphics.textures,
				visual_size     = setgraphics.visual_size,
				spritediv       = setgraphics.spritediv,
				initial_sprite_basepos 	= {x=0, y=0},
				makes_footstep_sound = true,
				groups          = mob.generic.groups,
				hp_max          = mob.generic.base_health,



		--	actions to be done by mob on its own
			on_step = function(self, dtime)
			
				local starttime = mobf_get_time_ms()
			
				if (self.dynamic_data.initialized == false) then
					if entity_at_loaded_pos(self.object:getpos()) then
						self.activate_handler(self,self.dynamic_data.last_static_data)
						self,self.dynamic_data.last_static_data = nil
					else
						return
					end
				end
			
				self.current_dtime = self.current_dtime + dtime
				
				local now = mobf_get_current_time()
						
				if self.current_dtime < 0.25 then
					return
				end
				
				--check lifetime
				if spawning.lifecycle(self,now) == false then
				    return
				end
				
				mobf_warn_long_fct(starttime,"on_step lifecycle")
				
				--movement generator
				self.dynamic_data.current_movement_gen.callback(self,now)
				
				mobf_warn_long_fct(starttime,"on_step movement")

				--auto transform hook
				transform(self,now)
				
				mobf_warn_long_fct(starttime,"on_step transform")

				--attack hook
				fighting.combat(self,now)
				
				mobf_warn_long_fct(starttime,"on_step combat")

				--agression hook
				fighting.aggression(self,now)
				
				mobf_warn_long_fct(starttime,"on_step aggression")

				--workaround for shortcomings in spawn algorithm
				spawning.check_population_density(self,now)
				
				mobf_warn_long_fct(starttime,"on_step pop dens")

				--random drop hook
				random_drop.callback(self,now)
				
				mobf_warn_long_fct(starttime,"on_step random drop")
				
				--random sound hook
				sound.play_random(self,now)
				
				mobf_warn_long_fct(starttime,"on_step sound")

				--visual change hook
				graphics.update_orientation(self,now)
				
				mobf_warn_long_fct(starttime,"on_step graphics")
				
				if type(self.data.generic.custom_on_step_handler) == "function" then
					self.data.generic.custom_on_step_handler(self,now,dtime)
				end
				
				mobf_warn_long_fct(starttime,"on_step custom")
				
				self.current_dtime = 0
				end,

		--player <-> mob interaction
			on_punch = function(self, hitter)
				if harvesting.callback(self,hitter) == false then	
					fighting.hit(self,hitter)
					end
				end,

		--rightclick is only used for debug reasons by now
			on_rightclick = function(self, clicker)
				local lifetime = mobf_get_current_time() - self.dynamic_data.spawning.original_spawntime
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

		--do basic mob initialization on activation
			on_activate = function(self,staticdata)
				
				self.dynamic_data = {}
				
				self.dynamic_data.initialized = false
				
				
				local pos = self.object:getpos()
				
				if pos ~= nil and
					entity_at_loaded_pos(pos) then
						self.activate_handler(self,staticdata)
					else
						self.dynamic_data.last_static_data = staticdata
					end
					
				end,
			
			
			activate_handler = function(self,staticdata)
			
				local pos = self.object:getpos()
				
				if pos == nil then
					minetest.log(LOGLEVEL_ERROR,"MOBF: mob at nil pos!")
				end
				local current_node = minetest.env:get_node(pos)
				
				--do some initial checks
				if current_node == nil then
					minetest.log(LOGLEVEL_ERROR,"MOBF: trying to activate mob in nil node! removing")
					
					spawning.remove_uninitialized(self,staticdata)
					return
				end
				
			
				if environment.is_media_element(current_node.name,self.environment.media) == false then
					minetest.log(LOGLEVEL_WARNING,"MOBF: trying to activate mob " .. self.data.name .. " at invalid position")
					minetest.log(LOGLEVEL_WARNING,"	Activation at: ".. current_node.name .. " --> removing")
					spawning.remove_uninitialized(self,staticdata)
					return
				end
				
				local now = mobf_get_current_time()
				
				self.dynamic_data.current_movement_gen = getMovementGen(self.data.movement.default_gen)
				
				--read saved data
				local retval = mobf_deserialize_permanent_entity_data(staticdata)


				spawning.init_dynamic_data(self,now)
				
				--set spawnpoint
				if self.dynamic_data.spawning ~= nil then
					if mobf_pos_is_zero(retval.spawnpoint) ~= true then
						self.dynamic_data.spawning.spawnpoint = retval.spawnpoint
					else
						self.dynamic_data.spawning.spawnpoint = mobf_round_pos(pos)
					end
					self.dynamic_data.spawning.player_spawned = retval.playerspawned
					
					if retval.original_spawntime ~= -1 then
						self.dynamic_data.spawning.original_spawntime = retval.original_spawntime
					end
					
					if retval.spawner ~= nil then
						minetest.log(LOGLEVEL_INFO,"MOBF: setting spawner to: " .. retval.spawner)
						self.dynamic_data.spawning.spawner = retval.spawner
					end
				end				

				fighting.init_dynamic_data(self,now)
				random_drop.init_dynamic_data(self,now)
				harvesting.init_dynamic_data(self,now)
				sound.init_dynamic_data(self,now)
				
				self.dynamic_data.current_movement_gen.init_dynamic_data(self,now)
				
				if self.data.generic.armor_groups ~= nil then
					self.object:set_armor_groups(self.data.generic.armor_groups)
				end

				--initialize height level
				--legacy 2D mode
				if (self.data.graphics_3d == nil) or
					minetest.setting_getbool("mobf_disable_3d_mode") then
					pos = environment.fix_base_pos(self, self.data.graphics.visible_height/2)
				else
					pos = environment.fix_base_pos(self, self.data.graphics_3d.collisionbox[2] * self.data.graphics_3d.visual_size.y * -1)
				end

				--initialize sprites
				graphics.set_draw_mode(self,"init")

				--custom on activate handler
				if (self.data.generic.custom_on_activate_handler ~= nil) then
					self.data.generic.custom_on_activate_handler(self)
				end
				
				self.dynamic_data.initialized = true
				end,
				
		--prepare permanent data
			get_staticdata = function(self)
				return mobf_serialize_permanent_entity_data(self)
				end,



		--custom variables for each mob
			data                    = mob,
			environment             = environment_list[mob.generic.envid],
			current_dtime           = 0,

			getbasepos = function(entity)
					local pos = entity.object:getpos()
					local nodeatpos = minetest.env:get_node(pos)
					
					dbg_mobf.generic_lvl2("MOBF: " .. entity.data.name .. " Center Position: " .. printpos(pos) .. " is: " .. nodeatpos.name)

					-- if visual height is more than one block the center of base block is 
					-- below the entities center
					-- legacy 2D mode
					if (entity.data.graphics_3d == nil) or
						minetest.setting_getbool("mobf_disable_3d_mode") then
						if (entity.data.graphics.visible_height > 1) then
							pos.y = pos.y - (entity.data.graphics.visible_height/2) + 0.5
						end
					else
						if (entity.data.graphics_3d.collisionbox[2] < -0.5) then
							pos.y = pos.y + (entity.data.graphics_3d.collisionbox[2] + 0.5)
							dbg_mobf.generic_lvl2("MOBF: collision box lower end: " .. entity.data.graphics_3d.collisionbox[2])
							
						end
					end
					nodeatpos = minetest.env:get_node(pos)
					dbg_mobf.generic_lvl2("MOBF: Base Position: " .. printpos(pos) .. " is: " .. nodeatpos.name)
 	
					return pos
				end
			}
		)
	mobf_register_mob_item(mob.name,mob.modname,mob.generic.description)
	
	--check if a movement pattern was specified
	if mobf_movement_patterns[mob.movement.pattern] == nil then
		minetest.log(LOGLEVEL_WARNING,"MOBF: no movement pattern specified!")
	end

	--register spawn callback to world
	if environment_list[mob.generic.envid] ~= nil then
		local secondary_name = ""		
		if mob.harvest ~= nil then
			secondary_name = mob.harvest.transforms_to
		end
		
		dbg_mobf.generic_lvl3("Environment to use:" , mob.generic.envid)
		
		mobf_spawn_algorithms[mob.spawning.algorithm](mob.modname..":"..mob.name,
															secondary_name,
															mob.spawning,
															environment_list[mob.generic.envid])
	else
		minetest.log(LOGLEVEL_ERROR,"MOBF: specified mob >" .. mob.name .. "< without environment!")
	end

	--register mob name to internal data structures
	table.insert(mobf_registred_mob,mob.modname.. ":"..mob.name)
end

------------------------------------------------------------------------------
-- name: mobf_is_known_mob(name)
--
--! @brief check if mob of name is known
--
--! @param name name to check if it's a mob
--! @return true/false
-------------------------------------------------------------------------------
function mobf_is_known_mob(name)
	for i,val in ipairs(mobf_registred_mob) do
		if name == val then
			return true
		end
	end

	return false
end

