local sliders_speedaddon = 3

-------------------------------------------------------------------------------
-- name: calc_accel(own_pos, hitter_pos)
--
-- action: calculate aceleration resulting from player hitting object in free move
--
-- param1: position of block
-- param2: position of player
-- retval: xz-speed
-------------------------------------------------------------------------------
function calc_accel(own_pos, hitter_pos)
	local x_delta = own_pos.x - hitter_pos.x
	local z_delta = own_pos.z - hitter_pos.z 

	--print("MB at ".. printpos(own_pos) .. " got hit from " .. printpos(hitter_pos))

	local x_speed_to_add = 0
	local z_speed_to_add = 0

	if x_delta ~= 0 then
		x_speed_to_add = sliders_speedaddon * ( math.abs(x_delta) / (math.abs(x_delta) + math.abs(z_delta))) 
	else
		x_speed_to_add = sliders_speedaddon
	end

	if z_delta ~= 0 then
		z_speed_to_add = sliders_speedaddon * ( math.abs(z_delta) / (math.abs(x_delta) + math.abs(z_delta))) 
	else
		z_speed_to_add = sliders_speedaddon
	end	

	if x_delta < 0 then
		x_speed_to_add = x_speed_to_add * -1
	end

	if z_delta < 0 then
		z_speed_to_add = z_speed_to_add * -1
	end

	return {x=x_delta,z=z_delta}	
end

-------------------------------------------------------------------------------
-- name: calc_accel(own_pos, hitter_pos)
--
-- action: calculate aceleration resulting from player hitting object in slider linked mode
--
-- param1: position of block
-- param2: position of player
-- retval: xz-speed
-------------------------------------------------------------------------------
function calc_accel_on_sliders(own_pos,hitter_pos)

	local slidertype =  detect_slider_type(own_pos)

	if slidertype == "inv" then
		print("Not on sliders")
		local speedchange = calc_accel(own_pos,hitter_pos)
		return {dir=slidertype,x=speedchange.x,z=speedchange.z}
	end


	local x_delta = own_pos.x - hitter_pos.x
	local z_delta = own_pos.z - hitter_pos.z 


	-- straight movement
	if slidertype == "x" then
		if x_delta < 0 then
			return { dir=slidertype,x=-sliders_speedaddon,z=0 }
		else
			return { dir=slidertype,x=sliders_speedaddon,z=0 }
		end
	end


	if slidertype == "z" then
		if z_delta < 0 then
			return { dir=slidertype,x=0,z=-sliders_speedaddon }
		else
			return { dir=slidertype,x=0,z=sliders_speedaddon }
		end
		
	end

	local speedchange = calc_accel(own_pos,hitter_pos)

	--start from corner
	if slidertype == "x+" then

		if math.abs(speedchange.x) > math.abs(speedchange.z) then
			print("x dir:"..speedchange.x)
			if speedchange.x > 0 then
				return {dir=slidertype,x=sliders_speedaddon,z=0}
			end
		else
			print("z dir")
			if speedchange.z < 0 then
				return {dir=slidertype,x=0,z=-sliders_speedaddon}
			end
		end
		
	end

	if slidertype == "x-" then
		if math.abs(speedchange.x) > math.abs(speedchange.z) then
			if speedchange.x < 0 then
				return {dir=slidertype,x=-sliders_speedaddon,z=0}
			end
		else
			if speedchange.z < 0 then
				return {dir=slidertype,x=0,z=-sliders_speedaddon}
			end
		end
	end


	if slidertype == "z+" then
		if math.abs(speedchange.z) > math.abs(speedchange.x) then
			if speedchange.z > 0 then
				return {dir=slidertype,z=sliders_speedaddon,x=0}
			end
		else
			if speedchange.x > 0 then
				return {dir=slidertype,z=0,x=sliders_speedaddon}
			end
		end
	end

	if slidertype == "z-" then
		if math.abs(speedchange.z) > math.abs(speedchange.x) then
			if speedchange.z > 0 then
				return {dir=slidertype,z=sliders_speedaddon,x=0}
			end
		else
			if speedchange.x < 0 then
				return {dir=slidertype,z=0,x=-sliders_speedaddon}
			end
		end
	end


	--unknown or invalid slidertype
	return {dir="inv",x=0,z=0}

end
