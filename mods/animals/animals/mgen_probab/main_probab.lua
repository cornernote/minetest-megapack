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



movement_gen = {}


--movement generator prediction time
prediction_time = 2

mov_patterns_defined = {}

dofile (animals_modpath .. "/mgen_probab/movement_patterns/dont_move.lua")
dofile (animals_modpath .. "/mgen_probab/movement_patterns/run_and_jump_low.lua")
dofile (animals_modpath .. "/mgen_probab/movement_patterns/stop_and_go.lua")
dofile (animals_modpath .. "/mgen_probab/movement_patterns/stop_and_go_meadow.lua")
dofile (animals_modpath .. "/mgen_probab/movement_patterns/swim_pattern1.lua")
dofile (animals_modpath .. "/mgen_probab/movement_patterns/swim_pattern2.lua")
dofile (animals_modpath .. "/mgen_probab/movement_patterns/flight_pattern1.lua")

dofile (animals_modpath .. "/mgen_probab/height_level_control.lua")
dofile (animals_modpath .. "/mgen_probab/direction_control.lua")

movement_gen.name = "probab_mov_gen"

function movement_gen.initialize() 
		for index,value in ipairs(mov_patterns_defined) do 

		print ("\tregistering pattern "..index.." -> "..value.name)
		animals_movement_patterns[value.name] = value
	end
end

-------------------------------------------------------------------------------
-- name: generator(entity)
--
-- action: main movement generation function
--
-- param1: entity to generate movement
-- retval: -
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
	--                  CHECK ANIMALS POSITION                               --
	--                                                                       --
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	dbg_animals.pmovement_lvl1("ANIMALS: position check for animal ".. entity.data.name .. " "..printpos(movement_state.basepos))
	movement_state.default_y_accel = environment.get_default_gravity(movement_state.basepos,
								entity.animals_mpattern.environment.media,
								entity.animals_mpattern.movement_canfly)
	movement_state.now			   = animals_get_current_time()

	--check current position	
	--movement state is modified by this function
	local retval = movement_generic.fix_current_pos(entity, movement_state)

	--animal has been removed due to unfixable problems
	if retval.abort_processing then		
		return
	end
	
	--read additional information required for further processing
	movement_state.centerpos            = entity.object:getpos()	
	movement_state.current_acceleration = entity.object:getacceleration()
	movement_state.current_velocity 	= entity.object:getvelocity()
	       
	if movement_state.changed then
		minetest.log(LOGLEVEL_WARNING,"ANIMALS WARN:position got fixed ".. entity.data.name)
	end
	
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--                                                                       --
	--                  CHECK ANIMALS MOVEMENT ITSELF                        --
	--                                                                       --
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	dbg_animals.pmovement_lvl1("ANIMALS: movement hard limits check for animal ".. entity.data.name .. " "..printpos(movement_state.basepos))
	
	movement_gen.fix_runaway(entity,movement_state)
	movement_gen.fix_to_slow(entity,movement_state)
	
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	--                                                                       --
	--    DO / PREPARE CHANGES THAT NEED TO BE DONE BECAUSE OF ANIMAL IS     --
	--          PREDICTED TO BE SOMEWHERE WHERE IT SHOULDN'T BE              --
	--                                                                       --
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------
	dbg_animals.pmovement_lvl1("ANIMALS: movement check for animal ".. entity.data.name .. " "..printpos(movement_state.basepos))
	
	--skip if movement already got changed
	if movement_state.changed == false then
		--predict next block animal will be
		local pos_predicted = direction_control.predict_next_block( movement_state.basepos,
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
	--                  DO RANDOM CHANGES TO ANIMAL MOVEMENT                 --
	--                                                                       --
	---------------------------------------------------------------------------
	---------------------------------------------------------------------------	
	dbg_animals.pmovement_lvl1("ANIMALS: randomized movement for animal ".. entity.data.name .. " "..printpos(movement_state.basepos))
	
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
-- action: check and apply the changes from movement_state
--
-- param1: entity to generate movement
-- param2: movement to apply
-- retval: -
-------------------------------------------------------------------------------
function movement_gen.apply_movement_changes(entity,movement_state)
	if movement_state.changed then
	
		--check if there is a acceleration to set
		if movement_state.accel_to_set == nil then
			movement_state.accel_to_set = {x=0,
							y=movement_state.default_y_accel,
							z=0}
			entity.object:setvelocity({x=0,y=0,z=0})
			minetest.log(LOGLEVEL_ERROR,"ANIMALS BUG!!!! set accel requested but no accel given!")
		end

		--check if gravity is set
		if movement_state.accel_to_set.y == nil then
			
			--print("fixing y movement: ".. printpos(movement_state.accel_to_set))
			movement_state.accel_to_set.y = movement_state.current_acceleration.y
		end

		-- make sure non flying animals have default acceleration
		if entity.animals_mpattern.movement_canfly == false then
			movement_state.accel_to_set.y = movement_state.default_y_accel
			
			if movement_state.default_y_accel == 0 then
				print("ANIMALS BUG!!! " .. entity.data.name .. " animal that can't fly has acceleration 0!")
			end
		end


		--if math.abs (accel_to_set.y - y_default_accel) > 0.001 then
			--dbg_animals.pmovement_lvl1("Setting y-acceleration to: ".. accel_to_set.y .. " default:".. y_default_accel .. " name " .. entity.animals_name .. " at: " .. printpos(entity.object:getpos()))
		--end

		dbg_animals.pmovement_lvl1("ANIMALS: setting acceleration to " ..printpos(movement_state.accel_to_set) )
		entity.dynamic_data.movement.acceleration = movement_state.accel_to_set
		entity.object:setacceleration(movement_state.accel_to_set)
	end
end

-------------------------------------------------------------------------------
-- name: callback(entity,now)
--
-- action: generate a movement pattern with mixed stop and go phases
--
-- param1: entity to generate movement
-- param2: current time
-- retval: -
-------------------------------------------------------------------------------
function movement_gen.callback(entity,now)
	if entity.dynamic_data.movement.started then

		local delta_t = now - entity.dynamic_data.movement.ts_state_changed
		
		--case we are not moving
		if entity.dynamic_data.movement.moving == false then			
			
			local start_chance = entity.animals_mpattern.start_movement + 
									( 	delta_t * 
										entity.animals_mpattern.start_stop_delta_time_factor * 
										entity.animals_mpattern.start_movement
										)

			if math.random() < start_chance then
				dbg_animals.pmovement_lvl2("ANIMALS: animal starts to move, chance was:" .. start_chance .. 
											" deltatime was: " .. delta_t .. 
											" entity:", entity)
				
				--give movement gen chance to start movement
				movement_gen.generator(entity)
				entity.dynamic_data.movement.moving = true
				entity.dynamic_data.movement.ts_state_changed = now
			end
		else

			local stop_chance = entity.animals_mpattern.stop_movement + 
									( 	delta_t * 
										entity.animals_mpattern.start_stop_delta_time_factor * 
										entity.animals_mpattern.stop_movement)

			--random chance of stopping
			if math.random() < stop_chance then
				dbg_animals.pmovement_lvl2("ANIMALS: animal stops to move, chance was:" .. stop_chance .. 
											" deltatime was: " .. delta_t .. 
											" entity:", entity)
											
				entity.dynamic_data.movement.acceleration = {x=0,
												y=environment.get_default_gravity(entity.object:getpos(),
														entity.animals_mpattern.environment.media,
														entity.animals_mpattern.movement_canfly),
												z=0}
				entity.object:setacceleration(entity.dynamic_data.movement.acceleration)
				entity.object:setvelocity({x=0,y=0,z=0})
				entity.dynamic_data.movement.moving = false
				entity.dynamic_data.movement.ts_state_changed = now
			else
				dbg_animals.pmovement_lvl2("ANIMALS: " .. entity.data.name .. " calling movement callback")
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
-- action: initialize dynamic data required by movement generator
--
-- param1: entity to initialize
-- param2: current time
-- retval: -
-------------------------------------------------------------------------------
function movement_gen.init_dynamic_data(entity,now)

	local accel_to_set = {x=0,y=9.81,z=0}
	local pos = entity.object:getpos()

		--initialize acceleration values
	accel_to_set.y = environment.get_default_gravity(pos,
					entity.animals_mpattern.environment.media,
					entity.animals_mpattern.movement_canfly)

	local data = {
			started				= false,
			acceleration		= accel_to_set,
			moving				= false,
			changing_levels     = false,
			ts_state_changed	= now,
			ts_random_jump		= now,
			ts_orientation_upd  = now,
			}
	
	entity.dynamic_data.movement = data
end

-------------------------------------------------------------------------------
-- name: fix_runaway(entity,movement_state)
--
-- action: fix runaway speed animals
--
-- param1: entity to calculate direction
-- param2: current state of movement
-- retval: -
-------------------------------------------------------------------------------
function movement_gen.fix_runaway(entity,movement_state)
	--avoid animals racing away
	local xzspeed = math.sqrt(math.exp(movement_state.current_velocity.x,2)+
	                          math.exp(movement_state.current_velocity.z,2))

	if xzspeed > entity.data.movement.max_speed then
		dbg_animals.pmovement_lvl3("ANIMALS: too fast! vxz=" .. xzspeed)
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
-- action: check if animals motion is below its minimal speed (e.g. flying birds)
--
-- param1: entity to calculate direction
-- param2: current state of movement
-- retval: -
-------------------------------------------------------------------------------
function movement_gen.fix_to_slow(entity,movement_state)
	local xzspeed = math.sqrt(math.pow(movement_state.current_velocity.x,2) + 
								math.pow(movement_state.current_velocity.z,2) )
	                          
	dbg_animals.pmovement_lvl3("ANIMALS: x=" .. movement_state.current_velocity.x .. 
										" z=" ..movement_state.current_velocity.z ..
										" xz=" .. xzspeed)
	
	--this ain't perfect to avoid flying animals standing in air 
	--but it's a quick solution to fix most of the problems
	if entity.data.movement.min_speed ~= nil and
		xzspeed < entity.data.movement.min_speed then
		
		dbg_animals.pmovement_lvl3("ANIMALS: too slow! vxz=" .. xzspeed)
		--use normal speed change handling
		movement_state.force_change = true
	end
end


--register this movement generator
registerMovementGen(movement_gen.name,movement_gen)