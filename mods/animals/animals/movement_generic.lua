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

movement_generic = {}

-------------------------------------------------------------------------------
-- name: movement_generic.get_suitable_pos_same_level(pos_raw,maxsearcharea,entity)
--
-- action: find a position suitable around a specific position
--
-- param1: position to look at
-- param2: max range to look for suitable position
-- retval: position found
-------------------------------------------------------------------------------
function movement_generic.get_suitable_pos_same_level(pos_raw,maxsearcharea,entity)

	local pos = animals_round_pos(pos_raw)

	dbg_animals.movement_lvl1("ANIMALS: Starting pos is "..printpos(pos).." max search area is "..maxsearcharea)

	local e1 = "|"
	local e2 = "|"
	local e3 = "|"
	local e4 = "|"

	--search next position on solid ground
	for search=1, maxsearcharea,1 do
		--TODO randomize search order

		--find along edge 1
		for current=-search,search,1 do
			local pos_tocheck = { x= pos.x + current,y=pos.y,z=pos.z -search}		
			local pos_state = environment.pos_is_ok(pos_tocheck,entity)

			dbg_animals.movement_lvl1("ANIMALS: state of "..printpos(pos_tocheck).." is ".. pos_state)

			if pos_state == "ok" then
				dbg_animals.movement_lvl1("found new pos")
				return pos_tocheck
			elseif pos_state == "collision_jumpabe" then
				dbg_animals.movement_lvl1("found new pos above")
				return {x=pos_tocheck.x,y=pos_tocheck.y+1,z=pos_tocheck.z}
			else
				e1 = e1..pos_state.."|"
			end			
		end

		--find along edge 2
		for current=-(search-1),(search-1),1 do
			local pos_tocheck = { x= pos.x + search,y=pos.y,z=pos.z + current}		
			local pos_state = environment.pos_is_ok(pos_tocheck,entity)
			
			dbg_animals.movement_lvl1("ANIMALS: state of "..printpos(pos_tocheck).." is ".. pos_state)

			if pos_state == "ok" then
				dbg_animals.movement_lvl1("found new pos")
				return pos_tocheck
			else
				e2 = e2..pos_state.."|"
			end			
		end

		--find along edge 3

		for current=search,-search,-1 do
			local pos_tocheck = { x= pos.x + current,y=pos.y,z=pos.z + search}		
			local pos_state = environment.pos_is_ok(pos_tocheck,entity)

			dbg_animals.movement_lvl1("ANIMALS: state of "..printpos(pos_tocheck).." is ".. pos_state)

			if pos_state == "ok" then
				dbg_animals.movement_lvl1("found new pos")
				return pos_tocheck
			else
				e3 = e3..pos_state.."|"
			end			
		end

		--find along edge 4
		for current=(search-1),-(search-1),-1 do
			local pos_tocheck = { x= pos.x -search,y=pos.y,z=pos.z + current}		
			local pos_state = environment.pos_is_ok(pos,entity)

			dbg_animals.movement_lvl1("ANIMALS: state of "..printpos(pos_tocheck).." is ".. pos_state)

			if pos_state == "ok" then
				dbg_animals.movement_lvl1("found new pos")
				return pos_tocheck
			else
				e4 = e4..pos_state.."|"
			end			
		end
	end

--	print("ANIMALS: Bug !!! didn't find a suitable position to place animal")
	print("Surrounding of " .. printpos(pos_raw) .. "was:")
	print(e1)
	print("          " .. e2)
	print(e4)
	print(e3)

	return nil
end

-------------------------------------------------------------------------------
-- name: movement_generic.get_accel_to(old_pos,entity) 
--
-- action: calculate a random speed directed from old_pos to new_pos
--
-- param1: source position
-- param2: entity
-- retval: x/y/z speed
-------------------------------------------------------------------------------
--
function movement_generic.get_accel_to(new_pos,entity)

	if new_pos == nil or entity == nil then
		minetest.log(LOGLEVEL_CRITICAL,"ANIMALS: movement_generic.get_accel_to : Invalid parameters")
	end
	
	local old_pos  = entity.object:getpos()
	local node 	   = minetest.env:get_node(old_pos)
	local maxaccel = entity.data.movement.max_accel
	local minaccel = entity.data.movement.min_accel
	
	local yaccel = environment.get_default_gravity(old_pos,
							entity.animals_mpattern.environment.media,
							entity.animals_mpattern.movement_canfly)

	--TODO calc y speed for flying animals

	local x_diff = new_pos.x - old_pos.x
	local z_diff = new_pos.z - old_pos.z

	local rand_x = (math.random() * (maxaccel - minaccel)) + minaccel
	local rand_z = (math.random() * (maxaccel - minaccel)) + minaccel

	if x_diff < 0 then
		rand_x = rand_x * -1
	end

	if z_diff < 0 then
		rand_z = rand_z * -1
	end

	return { x=rand_x,y=yaccel,z=rand_z }
end

-------------------------------------------------------------------------------
-- name: movement_generic.fix_current_pos(entity,default_y_accel)
--
-- action: check current position for validity and try to fix
--
-- param1: entity to generate movement
-- param2: default y acceleration (gravity)
-- retval: {
--		speed_to_set = {x,y,z}
--		speed_changed = true/false
--              force_speed_change = true/false
--	}
-------------------------------------------------------------------------------
function movement_generic.fix_current_pos(entity,movement_state)

	--check if current pos is ok
	local current_state = environment.pos_is_ok(movement_state.basepos,entity)

	

	movement_state.accel_to_set = { x=0,
									y=movement_state.default_y_accel,
									z=0 }

	if entity.animals_acceleration ~= nil then
		movement_state.accel_to_set = entity.animals_acceleration
	end

	local abort_processing = false

	--states ok drop and wrong_surface don't require an imediate action
	if current_state ~= "ok" and
		current_state ~= "drop" and
		current_state ~= "wrong_surface" and
		current_state ~= "possible_surface" then
		dbg_animals.movement_lvl1("ANIMALS: BUG !!! somehow your animal managed to get where it shouldn't be, trying to fix")

		--stop animal from moving at all
		entity.object:setacceleration({x=0,y=movement_state.default_y_accel,z=0})
		movement_state.force_change = true

		--animal is currently in whater try to find a suitable position 1 level above current level
		if current_state == "in_water" then
			local targetpos = movement_generic.get_suitable_pos_same_level({x=movement_state.basepos.x,
																				y=movement_state.basepos.y+1,
																				z=movement_state.basepos.z},
																			1,
																			entity)

			if targetpos ~= nil then
				minetest.log(LOGLEVEL_WARNING,"ANIMALS: Your animal dropt into water moving to "..
						printpos(targetpos).." state: "..
						environment.pos_is_ok(targetpos,entity))
				
				entity.object:moveto(targetpos)
				movement_state.accel_to_set.y = environment.get_default_gravity(targetpos,
								entity.animals_mpattern.environment.media,
								entity.animals_mpattern.movement_canfly)
			else
				minetest.log(LOGLEVEL_ERROR,"ANIMALS: BUG !!! didn't find a way out of water, for animal at: " .. printpos(movement_state.basepos) .. " drowning animal")
				abort_processing = true
		
				spawning.remove(entity)
			end
		end

		if current_state == "in_air" then
			--TODO die?
		end

		--animal is most likely to fall in water soon find a dry place around
		if current_state == "above_water" then
			dbg_animals.movement_lvl1("ANIMALS: animal is lurking around above water")
			local targetpos = movement_generic.get_suitable_pos_same_level({x=movement_state.basepos.x,
																			 y=movement_state.basepos.y,
																			 z=movement_state.basepos.z},1,entity)
	
			--try a large jump
			--if targetpos == nil then
			--	local targetpos = movement_generic.get_suitable_pos_same_level({x=pos.x,y=pos.y+1,z=pos.z},1,entity)
			--end

			if targetpos ~= nil then
--simple way of fixing
				dbg_animals.movement_lvl1("Animal ".. entity.animals_name .. " above water, moving to "..printpos(targetpos).." state: "..environment.pos_is_ok(targetpos,entity))
				entity.object:moveto(targetpos)	
				
				--after moving there might be a new default accel
				movement_state.default_y_accel = environment.get_default_gravity(pos,
								entity.animals_mpattern.environment.media,
								entity.animals_mpattern.movement_canfly)
								
				movement_state.basepos = targetpos				

--more sophisticated way of fixing... but doesn't work right now		
--				entity.object:moveto(animals_fix_y_pos(movement_state.basepos))	
--				speed_to_set =  animals_get_speed_to(movement_state.basepos,targetpos,
--									entity.animals_min_speed,
--									entity.animals_max_speed)
--				speed_to_set.y = 0
--				speed_changed = true
			else
				minetest.log(LOGLEVEL_ERROR,"ANIMALS: BUG !!! didn't find a way from water, animal is most likely to drown soon")
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
			dbg_animals.movement_lvl1("ANIMALS: Animal is on wrong surface it will slowly take damage")
		
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


	return {	abort_processing=abort_processing,	 }
end

-------------------------------------------------------------------------------
-- name: update_orientation(entity)
--
-- action: calculate direction to face
--
-- param1: entity to calculate direction
-- retval: -
-------------------------------------------------------------------------------
function update_orientation(entity,now)

	local new_orientation = 0

	if entity.dynamic_data.movement.ts_orientation_upd + 1 < now and
		entity.dynamic_data.movement.moving then

		entity.dynamic_data.movement.ts_orientation_upd = now

		current_velocity = get_velocity(entity)
		--current_velocity = entity.object:getvelocity()

		local x_abs = math.abs(current_velocity.x)
		local z_abs = math.abs(current_velocity.z)

		if x_abs > z_abs then
			if current_velocity.x > 0 then
				set_yaw(entity,0)
				--entity.object:setyaw(0)
			else
				set_yaw(entity,3.14)
				--entity.object:setyaw(3.14)
			end
		else
			if current_velocity.z >0 then
				set_yaw(entity,1.57)
				--entity.object:setyaw(1.57)
			else
				set_yaw(entity,4.71)
				--entity.object:setyaw(4.71)
			end
		end
	end

end