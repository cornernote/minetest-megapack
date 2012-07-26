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



mgen_follow = {}


mgen_follow.name = "follow_mov_gen"


-------------------------------------------------------------------------------
-- name: callback(entity,now)
--
-- action: generate a movement pattern with mixed stop and go phases
--
-- param1: entity to generate movement
-- param2: current time
-- retval: -
-------------------------------------------------------------------------------
function mgen_follow.callback(entity,now)

	dbg_animals.fmovement_lvl3("ANIMALS; Follow mgen callback called")
	
	if entity.dynamic_data.movement.target ~= nil then
		dbg_animals.fmovement_lvl3("ANIMALS:   Target detected")
		--calculate distance to target
		local basepos  = entity.getbasepos(entity)
		local targetpos = entity.dynamic_data.movement.target:getpos()
		local distance = animals_calc_distance_2d(basepos,targetpos)
		
		if animals_line_of_sight({x=basepos.x,y=basepos.y+1,z=basepos.z},
						 {x=targetpos.x,y=targetpos.y+1,z=targetpos.z})  == false then
			dbg_animals.fmovement_lvl3("ANIMALS:   no line of sight")
			--TODO teleport support?
			return						 
		end
		dbg_animals.fmovement_lvl3("ANIMALS:   line of sight")
		
		--check if animal needs to move towards target
		if distance > 1 then

			dbg_animals.fmovement_lvl3("ANIMALS:   distance:" .. distance)
			if basepos.y == targetpos.y then
				dbg_animals.fmovement_lvl3("ANIMALS:   same height")
				local speed_to_set = movement_generic.get_accel_to(targetpos,entity)
				entity.object:setacceleration(speed_to_set)
			else
				dbg_animals.fmovement_lvl3("ANIMALS:   not same height")
				if basepos.y > targetpos.y then
					dbg_animals.fmovement_lvl3("ANIMALS:   target below")
					local accel_to_set = movement_generic.get_accel_to(targetpos,entity)
					dbg_animals.fmovement_lvl3("ANIMALS:   setting acceleration to: " .. printpos(accel_to_set));
					entity.object:setacceleration(accel_to_set)
				else
					dbg_animals.fmovement_lvl3("ANIMALS:   above")
					--TODO check if movement in this direction is possible or if we need to jump
					local accel_to_set = movement_generic.get_accel_to(targetpos,entity)
					dbg_animals.fmovement_lvl3("ANIMALS:   setting acceleration to: " .. printpos(accel_to_set));
					entity.object:setacceleration(accel_to_set)
				end
			end
		--nothing to do
		else
			dbg_animals.fmovement_lvl3("ANIMALS:   next to target")
			entity.object:setvelocity({x=0,y=0,z=0})
		end
	
	else	
		--TODO evaluate if this is an error case	
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
function mgen_follow.init_dynamic_data(entity,now)

	local accel_to_set = {x=0,y=9.81,z=0}
	local pos = entity.object:getpos()

		--initialize acceleration values
	accel_to_set.y = environment.get_default_gravity(pos,
					entity.animals_mpattern.environment.media,
					entity.animals_mpattern.movement_canfly)

	local data = {
			target = nil,
			ts_orientation_upd  = now,
			}
	
	entity.dynamic_data.movement = data
end



--register this movement generator
registerMovementGen(mgen_follow.name,mgen_follow)