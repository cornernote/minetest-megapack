-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file main_probab.lua
--! @brief component containing a probabilistic movement generator
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--
--! @defgroup mgen_probab Probabilistic movement generator
--! @brief A movement generator trying to create a random movement
--! @ingroup framework_int
--! @{ 
--
--! @defgroup mpatterns Movement patterns
--! @brief movement patterns used for probabilistic movement gen
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------


--factor used to adjust chances defined as x/per second to on_step frequency
PER_SECOND_CORRECTION_FACTOR = 0.25

--! @class movement_gen
--! @brief a probabilistic movement generator
movement_gen = {}

--! @brief movement patterns known to probabilistic movement gen
mov_patterns_defined = {}

--!@}

dofile (mobf_modpath .. "/mgen_probab/movement_patterns/dont_move.lua")
dofile (mobf_modpath .. "/mgen_probab/movement_patterns/run_and_jump_low.lua")
dofile (mobf_modpath .. "/mgen_probab/movement_patterns/stop_and_go.lua")
dofile (mobf_modpath .. "/mgen_probab/movement_patterns/swim_pattern1.lua")
dofile (mobf_modpath .. "/mgen_probab/movement_patterns/swim_pattern2.lua")
dofile (mobf_modpath .. "/mgen_probab/movement_patterns/flight_pattern1.lua")

dofile (mobf_modpath .. "/mgen_probab/height_level_control.lua")
dofile (mobf_modpath .. "/mgen_probab/direction_control.lua")

--! @brief movement generator identifier
--! @memberof movement_gen
movement_gen.name = "probab_mov_gen"

-------------------------------------------------------------------------------
-- name: register_pattern(pattern)
--
--! @brief initialize movement generator
--! @memberof movement_gen
--
--! @param pattern pattern to register
--! @return true/false
-------------------------------------------------------------------------------
function movement_gen.register_pattern(pattern) 
		print ("\tregistering pattern "..pattern.name)
		if mobf_movement_patterns[pattern.name] == nil then
			mobf_movement_patterns[pattern.name] = pattern
			return true
		else
			return false
		end
end


-------------------------------------------------------------------------------
-- name: initialize(entity)
--
--! @brief initialize movement generator
--! @memberof movement_gen
--
-------------------------------------------------------------------------------
function movement_gen.initialize() 
		for index,value in ipairs(mov_patterns_defined) do 
		movement_gen.register_pattern(value) 
	end
end

-------------------------------------------------------------------------------
-- name: generator(entity)
--
--! @brief main movement generation function
--! @memberof movement_gen
--! @private
--
--! @param entity mob to generate movement for
-------------------------------------------------------------------------------
function movement_gen.generator(entity)

	if entity == nil then
		return
	end
	
	--initialize status datastructure
	local movement_state = {
		basepos         = entity.getbasepos(entity),
		default_y_accel = nil,
		centerpos       = nil,		
		acceleration    = nil,
		velocity        = nil,
		now             = nil,
		
		override_height_change_chance = 0,		
		accel_to_set    = nil,
		force_change    = false,
		changed         = false,
	}
	
	
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--                                                                       --
	--                  CHECK MOB POSITION                                   --
	--                                                                       --
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	dbg_mobf.pmovement_lvl1("MOBF: position check for mob ".. entity.data.name .. " "..printpos(movement_state.basepos))
	movement_state.default_y_accel = environment.get_default_gravity(movement_state.basepos,
								entity.environment.media,
								entity.data.movement.canfly)
	movement_state.now			   = mobf_get_current_time()

	--check current position	
	--movement state is modified by this function
	local retval = movement_gen.fix_current_pos(entity, movement_state)

	--mob has been removed due to unfixable problems
	if retval.abort_processing then		
		return
	end
	
	--read additional information required for further processing
	movement_state.centerpos            = entity.object:getpos()	
	movement_state.current_acceleration = entity.object:getacceleration()
	movement_state.current_velocity 	= entity.object:getvelocity()
	       
	if movement_state.changed then
		minetest.log(LOGLEVEL_WARNING,"MOBF:position got fixed ".. entity.data.name)
	end
	
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--                                                                       --
	--                  CHECK MOB MOVEMENT ITSELF                            --
	--                                                                       --
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	dbg_mobf.pmovement_lvl1("MOBF: movement hard limits check for mob ".. entity.data.name .. " "..printpos(movement_state.basepos))
	
	movement_gen.fix_runaway(entity,movement_state)
	movement_gen.fix_to_slow(entity,movement_state)
	
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--                                                                       --
	--    DO / PREPARE CHANGES THAT NEED TO BE DONE BECAUSE OF MOB IS        --
	--          PREDICTED TO BE SOMEWHERE WHERE IT SHOULDN'T BE              --
	--                                                                       --
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	dbg_mobf.pmovement_lvl1("MOBF: movement check for mob ".. entity.data.name .. " "..printpos(movement_state.basepos))
	
	--skip if movement already got changed
	if movement_state.changed == false then
		--predict next block mob will be
		local pos_predicted = movement_generic.predict_next_block( movement_state.basepos,
																movement_state.current_velocity,
																movement_state.current_acceleration)
																
		local pos_predicted_state = environment.pos_is_ok(pos_predicted,entity)
		
		-- Y-Movement
		if movement_state.changed == false then
		    height_level_control.precheck_movement(entity,movement_state,pos_predicted,pos_predicted_state)
		end	
		
		-- X/Z-Movement
		if movement_state.changed == false then
			direction_control.precheck_movement(entity,movement_state,pos_predicted,pos_predicted_state)	
		end	

	end
	

	
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--                                                                       --
	--                  DO RANDOM CHANGES TO MOB MOVEMENT                    --
	--                                                                       --
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------	
	dbg_mobf.pmovement_lvl1("MOBF: randomized movement for mob ".. entity.data.name .. " "..printpos(movement_state.basepos))
	
	--do randomized changes if not fighting
	height_level_control.random_movement_handler(entity,movement_state)
	direction_control.random_movement_handler(entity,movement_state)

	
	
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--                                                                       --
	--                  APPLY CHANGES CALCULATED BEFORE                      --
	--                                                                       --
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	movement_gen.apply_movement_changes(entity,movement_state)
end


-------------------------------------------------------------------------------
-- name: apply_movement_changes(entity,movement_state)
--
--! @brief check and apply the changes from movement_state
--! @memberof movement_gen
--! @private
--
--! @param entity mob to apply changes
--! @param movement_state changes to apply
-------------------------------------------------------------------------------
function movement_gen.apply_movement_changes(entity,movement_state)
	if movement_state.changed then
	
		--check if there is a acceleration to set
		if movement_state.accel_to_set == nil then
			movement_state.accel_to_set = {x=0,
							y=movement_state.default_y_accel,
							z=0}
			entity.object:setvelocity({x=0,y=0,z=0})
			minetest.log(LOGLEVEL_ERROR,"MOBF BUG!!!! set accel requested but no accel given!")
		end

		--check if gravity is set
		if movement_state.accel_to_set.y == nil then
			
			--print("fixing y movement: ".. printpos(movement_state.accel_to_set))
			movement_state.accel_to_set.y = movement_state.current_acceleration.y
		end

		-- make sure non flying mobs have default acceleration
		if entity.data.movement.canfly == false then
			movement_state.accel_to_set.y = movement_state.default_y_accel
			
			if movement_state.default_y_accel == 0 then
				minetest.log(LOGLEVEL_ERROR,"MOBF BUG!!! " .. entity.data.name .. " mob that can't fly has acceleration 0!")
			end
		end

		dbg_mobf.pmovement_lvl1("MOBF: setting acceleration to " ..printpos(movement_state.accel_to_set) )
		entity.dynamic_data.movement.acceleration = movement_state.accel_to_set
		entity.object:setacceleration(movement_state.accel_to_set)
	end
end

-------------------------------------------------------------------------------
-- name: callback(entity,now)
--
--! @brief generate a movement pattern with mixed stop and go phases
--! @memberof movement_gen
--
--! @param entity mob to generate movement
--! @param now current time
-------------------------------------------------------------------------------
function movement_gen.callback(entity,now)
	if entity.dynamic_data.movement.started then

		local delta_t = now - entity.dynamic_data.movement.ts_state_changed
		
		--case we are not moving
		if entity.dynamic_data.movement.moving == false then			
			
			local start_chance = entity.dynamic_data.movement.mpattern.start_movement + 
									( 	delta_t * 
										entity.dynamic_data.movement.mpattern.start_stop_delta_time_factor * 
										entity.dynamic_data.movement.mpattern.start_movement
										)

			if math.random() < (start_chance * PER_SECOND_CORRECTION_FACTOR) then
				dbg_mobf.pmovement_lvl2("MOBF: mob starts to move, chance was:" .. start_chance .. 
											" deltatime was: " .. delta_t .. 
											" entity:", entity)
				
				--give movement gen chance to start movement
				movement_gen.generator(entity)
				entity.dynamic_data.movement.moving = true
				entity.dynamic_data.movement.ts_state_changed = now
			end
		else

			local stop_chance = entity.dynamic_data.movement.mpattern.stop_movement + 
									( 	delta_t * 
										entity.dynamic_data.movement.mpattern.start_stop_delta_time_factor * 
										entity.dynamic_data.movement.mpattern.stop_movement)

			--random chance of stopping
			if math.random() < (stop_chance * PER_SECOND_CORRECTION_FACTOR)then
				dbg_mobf.pmovement_lvl2("MOBF: mob stops to move, chance was:" .. stop_chance .. 
											" deltatime was: " .. delta_t .. 
											" entity:", entity)
											
				entity.dynamic_data.movement.acceleration = {x=0,
												y=environment.get_default_gravity(entity.object:getpos(),
														entity.environment.media,
														entity.data.movement.canfly),
												z=0}
				entity.object:setacceleration(entity.dynamic_data.movement.acceleration)
				entity.object:setvelocity({x=0,y=0,z=0})
				entity.dynamic_data.movement.moving = false
				entity.dynamic_data.movement.ts_state_changed = now
			else
				dbg_mobf.pmovement_lvl2("MOBF: " .. entity.data.name .. " calling movement callback")
				movement_gen.generator(entity)
			end
		end


	else
		entity.object:setacceleration(entity.dynamic_data.movement.acceleration)
		entity.dynamic_data.movement.started = true
	end

end

-------------------------------------------------------------------------------
-- name: init_dynamic_data(entity,now)
--
--! @brief initialize dynamic data required by movement generator
--! @memberof movement_gen
--
--! @param entity mob to initialize
--! @param now current time
-------------------------------------------------------------------------------
function movement_gen.init_dynamic_data(entity,now)

	local accel_to_set = {x=0,y=9.81,z=0}
	local pos = entity.object:getpos()

		--initialize acceleration values
	accel_to_set.y = environment.get_default_gravity(pos,
					entity.environment.media,
					entity.data.movement.canfly)

	local data = {
			started				= false,
			acceleration		= accel_to_set,
			moving				= false,
			changing_levels     = false,
			ts_state_changed	= now,
			ts_random_jump		= now,
			ts_orientation_upd  = now,
			mpattern            = mobf_movement_patterns[entity.data.movement.pattern],
			}
	
	entity.dynamic_data.movement = data
end

-------------------------------------------------------------------------------
-- name: fix_runaway(entity,movement_state)
--
--! @brief fix runaway speed mobs
--! @memberof movement_gen
--! @private
--
--! @param entity mob to check speed limits
--! @param movement_state current state of movement
-------------------------------------------------------------------------------
function movement_gen.fix_runaway(entity,movement_state)
	--avoid mobs racing away
	local xzspeed = math.sqrt(math.pow(movement_state.current_velocity.x,2)+
	                          math.pow(movement_state.current_velocity.z,2))

	if xzspeed > entity.data.movement.max_speed then
		dbg_mobf.pmovement_lvl3("MOBF: too fast! vxz=" .. xzspeed)
		local newaccel = {x=0,y=movement_state.current_acceleration.y,z=0}
		
		--calculate sign of acceleration
		if movement_state.current_velocity.x > 0 and 
		    movement_state.current_acceleration.x >= 0 then
				newaccel.x = entity.data.movement.min_accel * -1
		else
				newaccel.x = entity.data.movement.min_accel
		end
		
		if movement_state.current_velocity.z > 0 and 
		    movement_state.current_acceleration.z >= 0 then
				newaccel.z = entity.data.movement.min_accel * -1
		else
				newaccel.z = entity.data.movement.min_accel
		end
		
		--calculate relative partition of acceleration based on velocity
		if movement_state.current_velocity.x > 0 and
			movement_state.current_velocity.z > 0 then			
			newaccel.x = newaccel.x * movement_state.current_velocity.x / 
						 (movement_state.current_velocity.x+movement_state.current_velocity.z)
			newaccel.z = newaccel.z * movement_state.current_velocity.z /
						 (movement_state.current_velocity.x+movement_state.current_velocity.z)			
		end
				
		--set acceleration based on min acceleration
		movement_state.accel_to_set = newaccel
		movement_state.changed = true
	end
end

-------------------------------------------------------------------------------
-- name: fix_to_slow(entity,movement_state)
--
--! @brief check if mobs motion is below its minimal speed (e.g. flying birds)
--! @memberof movement_gen
--! @private
--
--! @param entity mob to check speed limits
--! @param movement_state current state of movement
-------------------------------------------------------------------------------
function movement_gen.fix_to_slow(entity,movement_state)
	local xzspeed = math.sqrt(math.pow(movement_state.current_velocity.x,2) + 
								math.pow(movement_state.current_velocity.z,2) )
	                          
	dbg_mobf.pmovement_lvl3("MOBF: x=" .. movement_state.current_velocity.x .. 
										" z=" ..movement_state.current_velocity.z ..
										" xz=" .. xzspeed)
	
	--this ain't perfect to avoid flying mobs standing in air 
	--but it's a quick solution to fix most of the problems
	if entity.data.movement.min_speed ~= nil and
		xzspeed < entity.data.movement.min_speed then
		
		dbg_mobf.pmovement_lvl3("MOBF: too slow! vxz=" .. xzspeed)
		--use normal speed change handling
		movement_state.force_change = true
	end
end

-------------------------------------------------------------------------------
-- name: fix_current_pos(entity,movement_state)
--
--! @brief check current position for validity and try to fix
--! @memberof movement_gen
--! @private
--
--! @param entity to fix position
--! @param movement_state movement state of mob
--! @return { speed_to_set = {x,y,z}, speed_changed = true/false, force_speed_change = true/false }
-------------------------------------------------------------------------------
function movement_gen.fix_current_pos(entity,movement_state)

	--check if current pos is ok
	local current_state = environment.pos_is_ok(movement_state.basepos,entity)

	

	movement_state.accel_to_set = { x=0,
									y=movement_state.default_y_accel,
									z=0 }

	local abort_processing = false

	--states ok drop and wrong_surface don't require an imediate action
	if current_state ~= "ok" and
		current_state ~= "drop" and
		current_state ~= "wrong_surface" and
		current_state ~= "possible_surface" then
		dbg_mobf.movement_lvl1("MOBF: BUG !!! somehow your mob managed to get where it shouldn't be, trying to fix")

		--stop mob from moving at all
		entity.object:setacceleration({x=0,y=movement_state.default_y_accel,z=0})
		movement_state.force_change = true

		--mob is currently in whater try to find a suitable position 1 level above current level
		if current_state == "in_water" then
			local targetpos = environment.get_suitable_pos_same_level({x=movement_state.basepos.x,
																				y=movement_state.basepos.y+1,
																				z=movement_state.basepos.z},
																			1,
																			entity)

			if targetpos ~= nil then
				minetest.log(LOGLEVEL_WARNING,"MOBF: Your mob dropt into water moving to "..
						printpos(targetpos).." state: "..
						environment.pos_is_ok(targetpos,entity))
				
				entity.object:moveto(targetpos)
				movement_state.accel_to_set.y = environment.get_default_gravity(targetpos,
								entity.environment.media,
								entity.data.movement.canfly)
			else
				minetest.log(LOGLEVEL_WARNING,"MOBF: BUG !!! didn't find a way out of water, for mob at: " .. printpos(movement_state.basepos) .. " drowning mob")
				abort_processing = true
				spawning.remove(entity)
			end
		end

		if current_state == "in_air" then
			--TODO die?
		end

		--mob is most likely to fall in water soon find a dry place around
		if current_state == "above_water" then
			dbg_mobf.movement_lvl1("MOBF: mob is lurking around above water")
			local targetpos = environment.get_suitable_pos_same_level({x=movement_state.basepos.x,
																			 y=movement_state.basepos.y,
																			 z=movement_state.basepos.z},1,entity)
	
			if targetpos ~= nil then
                --simple way of fixing
				dbg_mobf.movement_lvl1("mob ".. entity.data.name .. " above water, moving to "..printpos(targetpos).." state: "..environment.pos_is_ok(targetpos,entity))
				entity.object:moveto(targetpos)	
				
				--after moving there might be a new default accel
				movement_state.default_y_accel = environment.get_default_gravity(pos,
								entity.environment.media,
								entity.data.movement.canfly)
								
				movement_state.basepos = targetpos
			else
				minetest.log(LOGLEVEL_WARNING,"MOBF: BUG !!! didn't find a way from water, mob is most likely to drown soon")
			end
		end      
	end
	
	local damagetime = 60
	
	if entity.data.generic.wrong_surface_damage_time ~= nil then
		damagetime = entity.data.generic.wrong_surface_damage_time
	end
	
	if current_state == "wrong_surface" and
		entity.dynamic_data.good_surface ~= nil	then		
		if movement_state.now - entity.dynamic_data.good_surface  > damagetime then
		
			entity.object:set_hp(entity.object:get_hp() - (entity.data.generic.base_health/25))
			dbg_mobf.movement_lvl1("MOBF: mob is on wrong surface it will slowly take damage")
		
			--reset timer for next damage interval
			entity.dynamic_data.good_surface = movement_state.now
			if entity.object:get_hp() <= 0 then
				abort_processing = true
				spawning.remove(entity)
			end	

		end	
	else
		entity.dynamic_data.good_surface = movement_state.now
	end
	
	if current_state == "collision" then
		if not mobf_is_walkable(movement_state.basepos) then
			local targetpos = environment.get_suitable_pos_same_level({x=movement_state.basepos.x,
																		y=movement_state.basepos.y,
																		z=movement_state.basepos.z},
																	1,
																	entity)
			if targetpos == nil then
				local targetpos = environment.get_suitable_pos_same_level({x=movement_state.basepos.x,
																	y=movement_state.basepos.y+1,
																	z=movement_state.basepos.z},
																1,
																entity)
			end
			
			if targetpos ~= nil then
				minetest.log(LOGLEVEL_WARNING,"MOBF: Your mob is within solid block moving to"..
							printpos(targetpos).." state: "..
							environment.pos_is_ok(targetpos,entity))
					
				entity.object:moveto(targetpos)
				movement_state.accel_to_set.y = environment.get_default_gravity(targetpos,
									entity.environment.media,
									entity.data.movement.canfly)
			else
				minetest.log(LOGLEVEL_WARNING,"MOBF: mob " .. entity.data.name .. " was within solid block, removed")
				abort_processing = true
				spawning.remove(entity)
			end
		end
	end

	return {	abort_processing=abort_processing,	 }
end


--register this movement generator
registerMovementGen(movement_gen.name,movement_gen)