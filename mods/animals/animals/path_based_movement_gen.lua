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


p_mov_gen = {}

-------------------------------------------------------------------------------
-- name: validate_position(current_pos,origin,destination)
--
-- action: check if current position is on movement path to destination
--
-- param1: current_pos
-- param2: origin of movement
-- param3: destination of movement
-- retval: -
-------------------------------------------------------------------------------
function p_mov_gen.validate_path_position(current_pos,origin,destination)



end

-------------------------------------------------------------------------------
-- name: validate_position(current_pos,origin,destination)
--
-- action: check if there's a direct path from pos1 to pos2 for this animal
--
-- param1: animal to check
-- param2: position1
-- param3: position2
-- retval: -
-------------------------------------------------------------------------------
function p_mov_gen.direct_path_available(entity,pos1,pos2)



end

-------------------------------------------------------------------------------
-- name: find_destination(entity,current_pos)
--
-- action: find a suitable destination for this animal
--
-- param1: animal to get destination for
-- param2: current position
-- retval: -
-------------------------------------------------------------------------------
function p_mov_gen.find_destination(entity,current_pos)

	--TODO
end

-------------------------------------------------------------------------------
-- name: set_speed(entity,destination)
--
-- action: set speed to destination for an animal
--
-- param1: animal to get destination for
-- param2: destination of animal
-- retval: -
-------------------------------------------------------------------------------
function p_mov_gen.set_speed(entity,destination)


end

-------------------------------------------------------------------------------
-- name: fix_position(entity,current_pos)
--
-- action: check if animal is in a valid position and fix it if necessary
--
-- param1: animal to get destination for
-- param2: position of animal
-- retval: -
-------------------------------------------------------------------------------
function p_mov_gen.fix_position(entity,current_pos)


end

-------------------------------------------------------------------------------
-- name: update_movement(entity,now)
--
-- action: check and update current movement state
--
-- param1: animal to move
-- param2: current time
-- retval: -
-------------------------------------------------------------------------------
function p_mov_gen.update_movement(entity,now)

	--position of base block (different from center for ground based animals)
	local pos 			= entity.getbasepos(entity)
	local centerpos     = entity.object:getpos()
	
	
	--validate current position for animal
	p_mov_gen.fix_position(entity,pos)
	
	--validate position is on path	
	if p_mov_gen.validate_path_position(pos
						entity.dynamic_data.p_movement.origin,
						entity.dynamic_data.p_movement.destination)
						== false then
						
		--validate target is reachable
		if p_mov_gen.direct_path_available(entity,pos,entity.dynamic_data.p_movement.destination) then
		
			--set new direction to target
			 p_mov_gen.set_speed(entity,dynamic_data.p_movement.destination)
		else -- get new destination
			dynamic_data.p_movement.destination = p_mov_gen.find_destination(entity,pos)
			
			if dynamic_data.p_movement.destination ~= nil then
				p_mov_gen.set_speed(entity,dynamic_data.p_movement.destination)
			else
				minetest.log(LOGLEVEL_ERROR,"ANIMALS: BUG !!! unable to find a destination for an animal!")
			end
		end			
	end
end


-------------------------------------------------------------------------------
-- name: callback(entity,now)
--
-- action: path based movement generator callback
--
-- param1: animal to do movement
-- param2: current time
-- retval: -
-------------------------------------------------------------------------------
function p_mov_gen.callback(entity,now)

	-- animal is in movement do movement handling
	if entity.dynamic_data.p_movement.in_movement then
		p_mov_gen.update_movement(entity,now)
	
	else
	-- calculate start movement chance	
	--TODO
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
function p_mov_gen.init_dynamic_data(entity,now)

	local pos = entity.object:getpos()

	local data = {
			origin              = pos,
			targetlist			= nil,
			eta                 = nil,
			last_move_stop      = now,
			in_movement         = false
			}
	
	entity.dynamic_data.p_movement = data
end