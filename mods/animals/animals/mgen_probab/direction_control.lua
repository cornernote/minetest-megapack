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


direction_control = {}


-------------------------------------------------------------------------------
-- name: predict_next_block(pos,velocity,acceleration)
--
-- action: predict next block based on pos velocity and acceleration
--
-- param1: current position
-- param2: current velocity
-- param3: current acceleration
-- retval: position of next block animal will be
-------------------------------------------------------------------------------
function direction_control.predict_next_block(pos,velocity,acceleration)

	local pos_predicted = direction_control.calc_new_pos(pos,
								acceleration,
								prediction_time,
								velocity
								)
	local count = 1

	--check if after prediction time we would have traveled more than one block and adjust to not predict to far
	while animals_calc_distance(pos,pos_predicted) > 1 do		
	
		pos_predicted = direction_control.calc_new_pos(pos,
								acceleration,
								prediction_time - (count*0.1),
								velocity
								)

		if (prediction_time - (count*0.1)) < 0 then
			minetest.log(LOGLEVEL_WARNING,"ANIMALS: Bug!!!! didn't find a suitable prediction time. Animal will move more than one block within prediction period")
			break
		end

		count = count +1
	end
	
	return pos_predicted

end


-------------------------------------------------------------------------------
-- name: changeaccel(pos,prediction_time,entity)
--
-- action: find a suitable new acceleration for animal
--
-- param1: current position
-- param2: prediction time
-- param3: entity to change accel for
-- retval: x/y/z accel + jump flag
-------------------------------------------------------------------------------
function direction_control.changeaccel(pos,prediction_time,entity,current_velocity)

	local new_accel = direction_control.get_random_acceleration(entity.data.movement.min_accel,
														entity.data.movement.max_accel)

	local pos_predicted = direction_control.predict_next_block(pos,current_velocity,new_accel)

	local maxtries = 5

	local state = environment.pos_is_ok(pos_predicted,entity)

	while  state ~= "ok" do
		dbg_animals.movement_lvl1("ANIMALS: predicted pos " .. printpos(pos_predicted) .. " isn't ok " .. maxtries .. " tries left, state: " .. state)
		local done = false

		--don't loop forever get to save mode and try next time
		if maxtries <= 0 then
			dbg_animals.movement_lvl1("ANIMALS: Aborting acceleration finding for this cycle due to max retries")
			if 	state == "collision_jumpable" then
				dbg_animals.movement_lvl1("Returning "..printpos(new_accel).." as new accel as animal may jump")
				return new_accel
			end
		
			dbg_animals.movement_lvl1("ANIMALS: Didn't find a suitable acceleration: " .. entity.data.name .. printpos(pos))
			--don't slow down animal
			return  {  x=current_velocity.x/-2,
						y=nil,
						z=current_velocity.z/-2 }
		end
		
		--in case animal is already at non perfect surface it's not that bad to get on it again
		if not done and (state == "possible_surface") then
			local current_state = environment.pos_is_ok(pos,entity)
			local probab = math.random()
			
			if current_state == "wrong_surface" or
				current_state == "possible_surface" then
				if probab < 0.3 then
					done = true
				end
			else
				if probab < 0.05 then
					done = true
				end
			end
		end

		--first try to invert acceleration on collision
		if not done and (state == "collision" or
			state == "collision_jumpable") then
			new_accel = { 	x= new_accel.x * -1,
					y= new_accel.y,
					z= new_accel.z * -1}

			pos_predicted = direction_control.predict_next_block(pos,current_velocity,new_accel)
			if environment.pos_is_ok(pos_predicted,entity) == "ok" then
				done = true
			end

		end

		--generic way to find new acceleration
		if not done then
			new_accel = direction_control.get_random_acceleration(entity.data.movement.min_accel,
														entity.data.movement.max_accel)
		
			pos_predicted = direction_control.predict_next_block(pos,current_velocity,new_accel)
		end

		state = environment.pos_is_ok(pos_predicted,entity)
		maxtries = maxtries -1
	end

	return new_accel

end

-------------------------------------------------------------------------------
-- name: get_random_acceleration(minaccel,maxaccel)
--
-- action: get a random x/z acceleration within a specified acceleration range
--
-- param1: minimum acceleration to use
-- param2: maximum acceleration
-- retval: x/y/z acceleration
-------------------------------------------------------------------------------
function direction_control.get_random_acceleration(minaccel,maxaccel)

	--calc random absolute value
	local rand_x = (math.random() * (maxaccel - minaccel)) + minaccel
	local rand_z = (math.random() * (maxaccel - minaccel)) + minaccel

	--randomize direction

	if math.random() < 0.5 then
		rand_x = rand_x * -1
	end

	if math.random() < 0.5 then
		rand_z = rand_z * -1
	end

	return {
		x = rand_x,
		y = nil,
		z = rand_z
		}
end

-------------------------------------------------------------------------------
-- name: calc_new_pos(pos,acceleration,prediction_time)
--
-- action: calc the position an animal would be after a specified time
--         this doesn't handle velocity changes due to colisions
--
-- param1: current position
-- param2: acceleration to be set
-- param3: time to pass
-- param4: current velocity
-- retval: position after specified time
-------------------------------------------------------------------------------
function direction_control.calc_new_pos(pos,acceleration,prediction_time,current_velocity)	

	local predicted_pos = {x=pos.x,y=pos.y,z=pos.z}

	predicted_pos.x = predicted_pos.x + current_velocity.x * prediction_time + (acceleration.x/2)*math.exp(prediction_time,2)
	predicted_pos.z = predicted_pos.z + current_velocity.z * prediction_time + (acceleration.z/2)*math.exp(prediction_time,2)


	return predicted_pos
end

-------------------------------------------------------------------------------
-- name: precheck_movement(entity,movement_state)
--
-- action: check if x/z movement results in invalid position and change
--         movement if required
--
-- param1: entity to generate movement
-- param2: current state of movement
-- retval: -
-------------------------------------------------------------------------------
function direction_control.precheck_movement(entity,movement_state,pos_predicted,pos_predicted_state)

	--next block animal is to be isn't a place where it can be so we need to change something
	if pos_predicted_state ~= "ok" then
		local invalid_pos_handled = false

		-- animal would walk onto water
		if movement_state.changed == false and pos_predicted_state == "above_water" then
			dbg_animals.movement_lvl1("animal is going to walk on water")
			local new_pos = movement_generic.get_suitable_pos_same_level(movement_state.basepos,1,entity)

			if new_pos ~= nil then
				
				movement_state.accel_to_set = movement_generic.get_accel_to(new_pos,entity)
				movement_state.changed = true	
			else
				minetest.log(LOGLEVEL_ERROR,"ANIMALS: BUG!!! didn't find a way to stop animal at"..printpos(movement_state.basepos)..
								"from running into water")
				--TODO delete animal??
			end			
		end

		if movement_state.changed == false and pos_predicted_state == "collision_jumpable" then
			dbg_animals.movement_lvl1("animal is about to collide")
			if environment.pos_is_ok({x=pos_predicted.x,y=pos_predicted.y+1,z=pos_predicted.z},entity) == "ok" then
				if math.random() < entity.animals_mpattern.jump_up then
					local node_at_predicted_pos = minetest.env:get_node(pos_predicted)
					dbg_animals.movement_lvl2("ANIMALS: velocity is:" .. printpos(movement_state.current_velocity) .. " position is: "..printpos(pos) ) 
					dbg_animals.movement_lvl2("ANIMALS: estimated position was: "..printpos(pos_predicted))
					dbg_animals.movement_lvl2("ANIMALS: predicted node state is: " .. environment.pos_is_ok(pos_predicted,entity))
					--if node_at_predicted_pos ~= nil then
						--dbg_animals.movement_lvl1("ANIMALS: jumping onto: " .. node_at_predicted_pos.name)
					--end
					movement_state.accel_to_set = { x=0,y=nil,z=0 }
					movement_state.changed = true
					
					--todo check if y pos is ok?!
					local jumppos = {x=pos_predicted.x,y=movement_state.centerpos.y+1,z=pos_predicted.z}
					
					dbg_animals.movement_lvl2("ANIMALS: animal " ..entity.data.name .. " is jumping, moving to:" .. printpos(jumppos))
					dbg_animals.movement_lvl2("ANIMALS: target pos node state is: " .. environment.pos_is_ok(jumppos,entity))
					
					entity.object:moveto(jumppos)
					--TODO set movement state positions
					--movement_state.basepos=
					--movement_state.centerpos=
				end
			end
		end

		--redirect animal to block thats not above its current level
		--or jump if possible
		if movement_state.changed == false and pos_predicted_state == "collision" then			
			dbg_animals.movement_lvl1("ANIMALS: animal is about to collide")

			local new_pos = movement_generic.get_suitable_pos_same_level(movement_state.basepos,1,entity)
		
			--there is at least one direction to go
			if new_pos ~= nil then				
				movement_state.accel_to_set = movement_generic.get_accel_to(new_pos,entity)
				movement_state.changed = true
			
			else
				local jumppos = nil
				--there ain't any acceptable pos at same level try to find one above current position
				new_pos = movement_generic.get_suitable_pos_same_level({ x=movement_state.basepos.x,
																		 y=movement_state.basepos.y+1,
																		 z=movement_state.basepos.z},
																		1,entity)																		
				
				if new_pos ~= nil then
					jumppos = {x=new_pos.x,y=movement_state.centerpos.y+1,z=new_pos.z}					
				end
				
				--there ain't any acceptable pos at same level try to find one below current position
				new_pos = movement_generic.get_suitable_pos_same_level({ x=movement_state.basepos.x,
																		 y=movement_state.basepos.y-1,
																		 z=movement_state.basepos.z},
																		1,entity)																		
				
				if new_pos ~= nil then
					jumppos = {x=new_pos.x,y=movement_state.centerpos.y-1,z=new_pos.z}					
				end
				
				
				if jumppos ~= nil then
					dbg_animals.movement_lvl2("ANIMALS: animal " ..entity.data.name .. " seems to be locked in, moving to:" .. printpos(jumppos))
					entity.object:moveto(jumppos)
					
					movement_state.accel_to_set = { x=0,y=nil,z=0 }
					movement_state.changed = true
				end				
			end
		end		

		
		--generic try to solve situation eg wrong surface
		if movement_state.changed == false and
			invalid_pos_handled == false then
			dbg_animals.movement_lvl1("ANIMALS: generic try to resolve state " .. pos_predicted_state .. " for animal " .. entity.data.name .. " "..printpos(movement_state.basepos))
			movement_state.accel_to_set = direction_control.changeaccel(movement_state.basepos,prediction_time,
										entity,movement_state.current_velocity)
			if movement_state.accel_to_set ~= nil then
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
function direction_control.random_movement_handler(entity,movement_state)	
	if movement_state.changed == false and
		(math.random() < entity.animals_mpattern.random_acceleration_change or 
		movement_state.force_change) then		

		movement_state.accel_to_set = direction_control.changeaccel(movement_state.basepos,prediction_time,
							entity,movement_state.current_velocity)
		if movement_state.accel_to_set ~= nil then
			--retain current y acceleration
			movement_state.accel_to_set.y = movement_state.current_acceleration.y
			movement_state.changed = true	
		end
		dbg_animals.movement_lvl1("ANIMALS: randomly changing speed from "..printpos(movement_state.current_acceleration).." to "..printpos(movement_state.accel_to_set))
	end
end