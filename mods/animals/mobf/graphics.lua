-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file graphics.lua
--! @brief graphics related parts of mob
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @class graphics
--! @brief graphic features
graphics = {}

-------------------------------------------------------------------------------
-- name: update_orientation_simple(entity,velocity)
--
--! @brief calculate direction of mob to face
--! @memberof graphics
--
--! @param entity mob to calculate direction
--! @param current_velocity data to calculate direction from
-------------------------------------------------------------------------------
function graphics.update_orientation_simple(entity,current_velocity)
	local x_abs = math.abs(current_velocity.x)
	local z_abs = math.abs(current_velocity.z)
	if x_abs > z_abs then
		if current_velocity.x > 0 then
			entity.object:setyaw(0)
		else
			entity.object:setyaw(3.14)
		end
	else
		if current_velocity.z >0 then
			entity.object:setyaw(1.57)
		else
			entity.object:setyaw(4.71)
		end
	end
end

-------------------------------------------------------------------------------
-- name: update_orientation(entity)
--
--! @brief callback for calculating a mobs direction
--! @memberof graphics
--
--! @param entity mob to calculate direction
--! @param now current time
-------------------------------------------------------------------------------
function graphics.update_orientation(entity,now)

	local new_orientation = 0

--	if entity.dynamic_data.movement.ts_orientation_upd + 1 < now and
	if	entity.dynamic_data.movement.moving then

		dbg_mobf.movement_lvl3("MOBF: Updating orientation")
		--entity.dynamic_data.movement.ts_orientation_upd = now

		local current_velocity = entity.object:getvelocity()
		local acceleration = entity.object:getacceleration()
		local pos = entity.getbasepos(entity)
		
		dbg_mobf.movement_lvl2("MOBF: vel: (" .. current_velocity.x .. ",".. current_velocity.z .. ") " .. 
											"accel: (" ..acceleration.x .. "," .. acceleration.z .. ")")
		
		--predict position mob will be in 0.25 seconds
		local predicted_pos = movement_generic.calc_new_pos(pos,acceleration,0.25,current_velocity)
			
		local delta_x = predicted_pos.x - pos.x
		local delta_z = predicted_pos.z - pos.z

		--legacy 2d mode
	if (entity.data.graphics_3d == nil) or
		minetest.setting_getbool("mobf_disable_3d_mode") then
			graphics.update_orientation_simple(entity,{x=delta_x, z=delta_z})
		-- 3d mode
		else
			--predict position mob will be in 0.5 seconds		
			
			if (delta_x ~= 0 ) and
				(delta_z ~= 0) then
				
				local direction = 0
				
				if ( delta_x > 0 and delta_z > 0 ) or
					(delta_x < 0 and delta_z < 0) then
				 	direction = math.atan2(delta_x,delta_z)
				else
					direction = math.atan2(delta_x * -1,delta_z * -1)
				end
				entity.object:setyaw(direction)
				
				dbg_mobf.movement_lvl2("MOBF: x-delta: " .. delta_x .. " z-delta: " .. delta_z .. " direction: " .. direction)
			elseif (delta_x ~= 0) or
					(delta_z ~= 0) then
					dbg_mobf.movement_lvl2("MOBF: at least speed for one direction is 0")
					graphics.update_orientation_simple(entity,{x=delta_x,z=delta_z})
			else
				dbg_mobf.movement_lvl3("MOBF: not moving")
			end
		end
	end

end

-------------------------------------------------------------------------------
-- name: set_draw_mode(entity,id)
--
--! @brief set the drawmode for an mob entity
--! @memberof graphics
--
--! @param entity mob to set drawmode for
--! @param id identifyer of drawmode to set
-------------------------------------------------------------------------------
function graphics.set_draw_mode(entity,id)

	--2D mode
	if (entity.data.graphics_3d == nil) or
		minetest.setting_getbool("mobf_disable_3d_mode") then
	
		if id == "init" then
			entity.object:setsprite({x=0,y=0}, 1, 0, true)
		end
		
		if id == "burning" then
			entity.object:setsprite({x=0,y=1}, 1, 0, true)
		end
	
	--3D mode
	else
	
	
	end
end