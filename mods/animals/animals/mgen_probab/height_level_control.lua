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


height_level_control = {}

-------------------------------------------------------------------------------
-- name: calc_level_change_time(entity)
--
-- action: main movement generation function
--
-- param1: entity to generate movement
-- retval: -
-------------------------------------------------------------------------------
function height_level_control.calc_level_change_time(entity,default_accel) 
	local retval = 1 --default value

	--calculate a reasonable value to stop level change
	if entity.animals_mpattern.movement_canfly == false then --case animal can't fly 
		return 0
	else
		-- if it's a flying animal and left it's normal medium
		if default_accel ~= 0 then 
			retval = 0			
		else
			retval = math.sqrt(2/entity.data.movement.min_accel)
		end
	end

	return retval
end

-------------------------------------------------------------------------------
-- name: precheck_movement(entity,movement_statepos_predicted,pos_predicted_state)
--
-- action: check if there is a level change in progress that may 
-- need to be stopped
--
-- param1: entity to generate movement
-- param2: current state of movement
-- retval: -
-------------------------------------------------------------------------------
function height_level_control.precheck_movement(entity,movement_state,pos_predicted,pos_predicted_state)

	if entity.animals_mpattern.movement_canfly ~= nil and
		entity.dynamic_data.movement.changing_levels == true then
		
		local level_change_time = height_level_control.calc_level_change_time(entity,movement_state.default_y_accel)

		local time_completed = entity.dynamic_data.movement.ts_random_jump + level_change_time

		dbg_animals.pmovement_lvl1("ANIMALS: ".. movement_state.now .. " " .. entity.data.name .. 
			" check complete level change " .. time_completed)

		if entity.dynamic_data.movement.changing_levels and
			time_completed  < movement_state.now then

			dbg_animals.pmovement_lvl2("ANIMALS: ".. movement_state.now .. " " .. entity.data.name .. 
			" level change complete reestablishing default y acceleration " .. movement_state.default_y_accel)
			entity.dynamic_data.movement.changing_levels = false
		
			movement_state.current_velocity.y = 0
			entity.object:setvelocity(movement_state.current_velocity)
		
			movement_state.accel_to_set = movement_state.current_acceleration
			movement_state.accel_to_set.y = movement_state.default_y_accel
			movement_state.changed = true
		end
	end
	
	--animal would fly/swim into height it shouldn't be
	if movement_state.changed == false then	
		local invalid_pos_handled = false
			
		--animal would fly/swim into height it shouldn't be
		if invalid_pos_handled == false and 
			pos_predicted_state == "above_limit" then			
			
			local min_y,max_y = environment.get_absolute_min_max_pos(entity.animals_mpattern.environment,movement_state.basepos)
			
			if (pos.y - max_y) > 10 then
				movement_state.override_height_change_chance = 1
			else
				movement_state.override_height_change_chance = (pos.y - max_y)/10
			end
			
			invalid_pos_handled = true
		end
		
		--animal would fly/swim into height it shouldn't be
		if invalid_pos_handled == false and 
			pos_predicted_state == "below_limit" then
				 
			local min_y,max_y = environment.get_absolute_min_max_pos(entity.animals_mpattern.environment,movement_state.basepos)
				
			if (min_y - pos.y) > 10 then
					movement_state.override_height_change_chance = 1
			else
					movement_state.override_height_change_chance = (min_y - pos.y)/10
			end
		end
	end
end

-------------------------------------------------------------------------------
-- name: random_jump_fly(entity,now,override_height_change_chance,pos,accel_to_set)
--
-- action: apply random jump for flying animals
--
-- param1: entity to apply random jump
-- param2: movement state
-- param3: override
-- retval: is a modification to accel done by random jump code?
-------------------------------------------------------------------------------
function height_level_control.random_jump_fly(entity,movement_state)

	local level_change_time = math.sqrt(2/entity.data.movement.min_accel)
			
	if movement_state.now > (entity.dynamic_data.movement.ts_random_jump + 
		entity.animals_mpattern.random_jump_delay +
		level_change_time) or
		movement_state.override_height_change_chance ~= 0 then

		if entity.dynamic_data.movement.changing_levels  == false or
			movement_state.override_height_change_chance ~= nil then
		
			local accel_to_set = movement_state.current_acceleration
		
			local ydirection = 1

			if math.random() <= 0.5 then
				ydirection = -1
			end

			local targetpos = {x=movement_state.basepos.x,y=movement_state.basepos.y+ydirection,z=movement_state.basepos.z}

			local target_state = environment.pos_is_ok(targetpos,entity);

			dbg_animals.pmovement_lvl2("ANIMALS: " .. entity.data.name .." flying change y accel dir="..ydirection.." ypos="..movement_state.basepos.y..
					" min="..entity.animals_mpattern.environment.min_height_above_ground..
					" max="..entity.animals_mpattern.environment.max_height_above_ground..
					" below="..target_state)

			if (target_state == "ok") then
			
				local min_y, max_y = environment.get_absolute_min_max_pos(entity.animals_mpattern.environment,movement_state.basepos)
			
				dbg_animals.pmovement_lvl2("ANIMALS: check level borders current=".. movement_state.basepos.y .. 
											" min=" .. min_y ..
											" max=" .. max_y)
				if (movement_state.basepos.y > min_y and
					ydirection == -1) or
					(movement_state.basepos.y < max_y and
					ydirection == 1) 
					then
						movement_state.accel_to_set.y = ydirection * entity.data.movement.min_accel
						entity.dynamic_data.movement.ts_random_jump = movement_state.now
						entity.dynamic_data.movement.changing_levels = true
						dbg_animals.pmovement_lvl2("ANIMALS: " .. entity.data.name .. " " .. movement_state.now .. " " .. 
											" changing level within borders: " .. movement_state.accel_to_set.y)	
						movement_state.changed = true
					end
			end
		else
			print("ANIMALS BUG!!! animal shouldn't be changing levels after that time!")
		end
	end

end

-------------------------------------------------------------------------------
-- name: random_jump_ground(entity,movement_state)
--
-- action: apply random jump for ground
--
-- param1: entity to apply random jump
-- param2: movement_state
-- retval: is a modification to accel done by random jump code?
-------------------------------------------------------------------------------
function height_level_control.random_jump_ground(entity,movement_state)

	if movement_state.default_y_accel == 0 then
		minetest.log(LOGLEVEL_ERROR,"ANIMALS BUG!!! ground animal can't have zero default acceleration!!!")
	end
	
	local random_jump_time = 2 * (entity.animals_mpattern.random_jump_initial_speed /
									math.abs(movement_state.default_y_accel))
	
	local next_jump = entity.dynamic_data.movement.ts_random_jump + 
						entity.animals_mpattern.random_jump_delay +
						random_jump_time
						
	dbg_animals.movement_lvl2("ANIMALS: now=" .. movement_state.now .. " time of next jump=" .. next_jump ..
				" | " .. random_jump_time .. " " .. entity.animals_mpattern.random_jump_delay .. " " ..
				entity.dynamic_data.movement.ts_random_jump .. " " .. movement_state.default_y_accel .. " " .. 
				entity.animals_mpattern.random_jump_initial_speed)
	
	if movement_state.now > next_jump then
	
		local ground_distance = animals_ground_distance(movement_state.basepos)
	
		
		--we shouldn't be moving in y direction at that time so probably we are just dropping
		--we can only jump while on solid ground!
		if ground_distance <= 1 then
		
			local current_speed = entity.object:getvelocity();
	
			dbg_animals.pmovement_lvl2("ANIMALS: " .. entity.data.name .." doing random jump ".. 
								"speed: " .. entity.animals_mpattern.random_jump_initial_speed ..
								": ",entity)
	
			current_speed.y = entity.animals_mpattern.random_jump_initial_speed
			
			entity.object:setvelocity(current_speed)
	
			entity.dynamic_data.movement.ts_random_jump = movement_state.now
		else
			dbg_animals.pmovement_lvl2("ANIMALS: " .. entity.data.name .. " Random jump but ground distance was:" .. ground_distance .. 
							" " ..movement_state.current_acceleration.y ..
							" " ..movement_state.default_y_accel)
							
			--this is a workaround for a bug 
			--setting y acceleration to 0 for ground born animals shouldn't be possible
			if movement_state.current_acceleration.y == 0 then
				movement_state.accel_to_set.x = movement_state.current_acceleration.x
				movement_state.accel_to_set.y = movement_state.default_y_accel
				movement_state.accel_to_set.z = movement_state.current_acceleration.z
				movement_state.changed = true		
			end
		end
	end	
end

-------------------------------------------------------------------------------
-- name: random_movement_handler(entity,movement_state)
--
-- action: generate a random y-movement
--
-- param1: entity to apply random jump
-- param2: movement_state
-- retval: is a modification to accel done by random jump code?
-------------------------------------------------------------------------------
function height_level_control.random_movement_handler(entity,movement_state)
	--generate random y movement changes
	if movement_state.changed == false and
		(math.random() < entity.animals_mpattern.random_jump_chance or
		 math.random() < movement_state.override_height_change_chance) then

		dbg_animals.pmovement_lvl1("ANIMALS: Random jump chance for animal " .. entity.data.name .. " "..
						entity.dynamic_data.movement.ts_random_jump .. " "..
						entity.animals_mpattern.random_jump_delay .. " " .. movement_state.now
			)

		local to_set
		--flying/swiming animals do level change on random jump chance
		if entity.animals_mpattern.movement_canfly then
		
			height_level_control.random_jump_fly(entity,movement_state)				
		--ground animals
		else
			height_level_control.random_jump_ground(entity,movement_state)
		end
	end
end