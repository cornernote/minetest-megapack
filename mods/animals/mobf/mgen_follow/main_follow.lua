-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file main_follow.lua
--! @brief component containing a targeted movement generator
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup mgen_follow Follow movement generator
--! @brief A movement generator creating movement that trys to follow a moving 
--! target or reach a given point on map
--! @ingroup framework_int
--! @{ 
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @class mgen_follow
--! @brief a movement generator trying to follow or reach a target
mgen_follow = {}

--!@}

--! @brief movement generator identifier
--! @memberof mgen_follow
mgen_follow.name = "follow_mov_gen"


-------------------------------------------------------------------------------
-- name: callback(entity,now)
--
--! @brief main callback to make a mob follow its target
--! @memberof mgen_follow
--
--! @param entity mob to generate movement for
--! @param now current time
-------------------------------------------------------------------------------
function mgen_follow.callback(entity,now)

	dbg_mobf.fmovement_lvl3("MOBF: Follow mgen callback called")	
	
	--check max speed limit
	mgen_follow.checkspeed(entity)
	
	if entity.dynamic_data.movement.target ~= nil or
		entity.dynamic_data.movement.guardspawnpoint then
		dbg_mobf.fmovement_lvl3("MOBF:   Target available")
		--calculate distance to target
		local basepos  = entity.getbasepos(entity)
		
		local targetpos = entity.dynamic_data.spawning.spawnpoint	
		if entity.dynamic_data.movement.guardspawnpoint ~= true then
			dbg_mobf.fmovement_lvl3("MOBF:   moving target selected")
			targetpos = entity.dynamic_data.movement.target:getpos()
		end
		
		local distance = mobf_calc_distance_2d(basepos,targetpos)
		
		local yaccel = environment.get_default_gravity(basepos,
							entity.environment.media,
							entity.data.movement.canfly)
		dbg_mobf.fmovement_lvl3("MOBF:   default gravity is " .. yaccel )
		
		if mobf_line_of_sight({x=basepos.x,y=basepos.y+1,z=basepos.z},
						 {x=targetpos.x,y=targetpos.y+1,z=targetpos.z})  == false then
			dbg_mobf.fmovement_lvl3("MOBF:   no line of sight")
			--TODO teleport support?
			--TODO other ways to handle this?
			--return						 
		end
		dbg_mobf.fmovement_lvl3("MOBF:   line of sight")
		
		local max_distance = entity.dynamic_data.movement.max_distance
		
		if max_distance == nil then
			max_distance = 1
		end
		
		--check if mob needs to move towards target
		dbg_mobf.fmovement_lvl3("MOBF: max distance is set to : " .. max_distance)
		if distance > max_distance then
		
			if (entity.dynamic_data.movement.last_next_to_target ~= nil ) then
				local time_since_next_to_target =
					now - entity.dynamic_data.movement.last_next_to_target
					
				dbg_mobf.fmovement_lvl3("MOBF:   time since next to target: " .. time_since_next_to_target .. 
											" delay: " .. dump(entity.data.movement.teleportdelay) ..
											" teleportsupport: " .. dump(entity.dynamic_data.movement.teleportsupport))
	
				if (entity.dynamic_data.movement.teleportsupport) and
					time_since_next_to_target > entity.data.movement.teleportdelay then
	
					entity.object:setvelocity({x=0,y=0,z=0})
					entity.object:setacceleration({x=0,y=0,z=0})
					entity.object:moveto(targetpos)
					entity.dynamic_data.movement.last_next_to_target = now
					return
				end
			end

			dbg_mobf.fmovement_lvl3("MOBF:   distance:" .. distance)
			if basepos.y == targetpos.y then
				dbg_mobf.fmovement_lvl3("MOBF:   same height")
				local accel_to_set = movement_generic.get_accel_to(targetpos,entity)
				accel_to_set.y = yaccel
				dbg_mobf.fmovement_lvl3("MOBF:   setting acceleration to: " .. printpos(accel_to_set));
				entity.object:setacceleration(accel_to_set)
			else
				dbg_mobf.fmovement_lvl3("MOBF:   not same height")
				if basepos.y > targetpos.y then
					dbg_mobf.fmovement_lvl3("MOBF:   target below")
					local accel_to_set = movement_generic.get_accel_to(targetpos,entity)
					accel_to_set.y = yaccel
					dbg_mobf.fmovement_lvl3("MOBF:   setting acceleration to: " .. printpos(accel_to_set));
					entity.object:setacceleration(accel_to_set)
				else
					dbg_mobf.fmovement_lvl3("MOBF:   above")
					--TODO check if movement in this direction is possible or if we need to jump
					local accel_to_set = movement_generic.get_accel_to(targetpos,entity)
					accel_to_set.y = yaccel
					dbg_mobf.fmovement_lvl3("MOBF:   setting acceleration to: " .. printpos(accel_to_set));
					local current_velocity = entity.object:getvelocity()
					local predicted_pos = movement_generic.predict_next_block(basepos,current_velocity,accel_to_set)
					local pos_state  = environment.pos_is_ok(predicted_pos,entity)
					
					if pos_state == "collision_jumpable" then			
						local pos_to_set = entity.object:getpos()
						pos_to_set.y = pos_to_set.y + 1.1
						entity.object:moveto(pos_to_set)
					end
					entity.object:setacceleration(accel_to_set)
				end
			end
		--nothing to do
		else
			dbg_mobf.fmovement_lvl3("MOBF:   next to target")
			entity.object:setvelocity({x=0,y=0,z=0})
			entity.object:setacceleration({x=0,y=0,z=0})
			entity.dynamic_data.movement.last_next_to_target = now
		end
	
	else	
		--TODO evaluate if this is an error case	
	end
end


-------------------------------------------------------------------------------
-- name: initialize()
--
--! @brief initialize movement generator
--! @memberof mgen_follow
--! @public
-------------------------------------------------------------------------------
function mgen_follow.initialize(entity,now)
--intentionaly doing nothing this function is for symmetry reasons only
end

-------------------------------------------------------------------------------
-- name: init_dynamic_data(entity,now)
--
--! @brief initialize dynamic data required by movement generator
--! @memberof mgen_follow
--! @public
--
--! @param entity mob to initialize dynamic data
--! @param now current time
-------------------------------------------------------------------------------
function mgen_follow.init_dynamic_data(entity,now)

	local pos = entity.object:getpos()


	local data = {
			target = nil,
			guardspawnpoint = false,
			moving = true,
			max_distance = entity.data.movement.max_distance,
			}
	
	if entity.data.movement.guardspawnpoint ~= nil and
		entity.data.movement.guardspawnpoint then
			dbg_mobf.fmovement_lvl3("MOBF: setting guard point to: " .. printpos(entity.dynamic_data.spawning.spawnpoint))
			data.guardspawnpoint = true
		end
		
		if entity.data.movement.teleportdelay~= nil then
			data.last_next_to_target = now
			data.teleportsupport = true
		end
	
	entity.dynamic_data.movement = data
end

-------------------------------------------------------------------------------
-- name: checkspeed(entity)
--
--! @brief check if mobs speed is within it's limits and correct if necessary
--! @memberof mgen_follow
--! @private
--
--! @param entity mob to initialize dynamic data
-------------------------------------------------------------------------------
function mgen_follow.checkspeed(entity)

	local current_velocity = entity.object:getvelocity()

	local xzspeed = math.sqrt(math.pow(current_velocity.x,2)+
	                          math.pow(current_velocity.z,2))

	if (xzspeed > entity.data.movement.max_speed) then
		local velocity_to_set = {x = current_velocity.x/2 , y= current_velocity.y, z= current_velocity.z/2}
	
		entity.object:setvelocity(velocity_to_set)
	end	
end



--register this movement generator
registerMovementGen(mgen_follow.name,mgen_follow)