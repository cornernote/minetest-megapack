local density    = 0.05

-------------------------------------------------------------------------------
-- name: calc_friction(speed,pos)
--
-- action: calculate friction resulting of speed and position
--
-- param1: speed you are traveling at
-- param2: position to check
-- retval: xz-friction
-------------------------------------------------------------------------------
function calc_friction(speed,pos)

	local current_node = minetest.env:get_node(pos)	

	local friction_factor = 0.9

	if current_node ~= nil then

		--TODO add mor friction factors
		if is_slider(current_node.name) then
			friction_factor = 0.1
		end
		if current_node.name == "air" then
			friction_factor = 0
		end	
	end

	return { x= speed.x * friction_factor * -1,
	         z= speed.z * friction_factor * -1 }
end


-------------------------------------------------------------------------------
-- name: calc_gravity(slidertype)
--
-- action: calculate acceleration based upon gravity and slidertype
--
-- param1: sliderype to calculate gravity
-- retval: xz-gravity
-------------------------------------------------------------------------------
function calc_gravity(slidertype)

	local gravity_x = 0
	local gravity_z = 0

	if slidertype == "x-u" or slidertype == "x-b" then
		gravity_x = - 0.25 * sliders_gravity
	end

	if slidertype == "x+u" or slidertype == "x+b" then
		gravity_x = 0.25 * sliders_gravity
	end

	if slidertype == "z-u" or slidertype == "z-b" then
		gravity_z = - 0.25 * sliders_gravity
	end

	if slidertype == "z+u" or slidertype == "z+b" then
		gravity_z = 0.25 * sliders_gravity
	end

	return {x = gravity_x,z=gravity_z}
end


-------------------------------------------------------------------------------
-- name: calc_resistance(speed)
--
-- action: calculate resistance based upon speed and density
--
-- param1: slidertype to calculate gravity
-- retval: xz-gravity
-------------------------------------------------------------------------------
function calc_resistance(speed)

	local x_resistance = math.pow(speed.x,2) * density
	local z_resistance = math.pow(speed.z,2) * density

	if speed.x > 0 then
		x_resistance = -x_resistance
	end

	if speed.y > 0 then
		y_resistance = -y_resistance
	end
	
	return { x = x_resistance,
		 z = z_resistance  }
end



