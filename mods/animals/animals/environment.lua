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
environment = {}

-------------------------------------------------------------------------------
-- name: animals_is_in_environment(nodename,environment)
--
-- action: check if nodename is in environment
--
-- param1: name to check
-- param2: environment
-- retval: true/false
------------------------------------------------------------------------------
--animals_is_in_environment(nodename,environment)
function environment.is_media_element(nodename,media)

	--security check
	if media == false then
	    minetest.log(LOGLEVEL_ERROR,"ANIMALS: BUG!!!! no environment specified!")
		return false
	end
	
	for i,v in ipairs(media) do
		if v == nodename then
			return true
		end
	end
	
	dbg_animals.environment_lvl2("ANIMALS: " .. nodename .. " is not within environment list:")
	
	for i,v in ipairs(media) do
		dbg_animals.environment_lvl2("ANIMALS: " .. v)
	end
	
	return false
end

-------------------------------------------------------------------------------
-- name: get_absolute_min_max_pos(env, pos)
--
-- action: check if nodename is in environment
--
-- param1: environment animal should be
-- param2: position it is
-- retval: minpos,maxpos
------------------------------------------------------------------------------
function environment.get_absolute_min_max_pos(env,pos)
	
	local node = minetest.env:get_node(pos)

	--if is not within environment it should be return current position
	--as min max
	if environment.is_media_element(node.name,env.media) == false then
		return pos.y,pos.y
	end
	
	local min_y = env.min_height_above_ground
	local max_y = env.max_height_above_ground

	--a fully generic check isn't possible here so we need to use media
	--specific ways ... it's ugly but works
	if node.name == "air" then
		min_y = min_y + ( pos.y - animals_surface_distance(pos))
		max_y = max_y + ( pos.y - animals_surface_distance(pos))
	end
	
	if node.name == "default:water" or
		node.name == "defailt:water_flowing" then
		-- water animals do use min/max directly
	end
	
	if node.name == "default:lava" or 
		node.name == "default:lava_flowing" then
		--not implemented by now
	end

	return min_y,max_y
end


--TOREMOVE
--function animals_min_max_y_pos(environment, min, max, pos)
--
--	local min_y = min
--	local max_y = max

--	if animals_is_in_environment("air", environment) then
--		min_y = min_y + ( pos.y - animals_surface_distance(pos))
--		max_y = max_y + ( pos.y - animals_surface_distance(pos))
--	end
--
--	return min_y,max_y
--end

-------------------------------------------------------------------------------
-- name: is_jumpable_surface(name)
--
-- action: check if name is a surface an animal may jump onto
--
-- param1: name to check
-- retval: true/false
-------------------------------------------------------------------------------
function environment.is_jumpable_surface(name)

	
	if 	name == "default:dirt" or
		name == "default:dirt_with_grass" or
		name == "default:stone" or
		name == "default:sand" or
		name == "default:clay"
		then
		return true
	end

	dbg_animals.environment_lvl1("ANIMALS: is "..name.." a jumpable surface?")
	return false
end

-------------------------------------------------------------------------------
-- name: checkdurfacek(pos,surfaces)
--
-- action: check if a position is suitable for an animal
--
-- param1: position to check
-- param2: surfaces valid
-- retval: true on valid surface false if not
-------------------------------------------------------------------------------
function environment.checksurface(pos,surface)
	
	--if no surfaces are specified any surface is treated as ok
	if surface == nil then
		return "ok"
	end
	
	local pos_below = {x=pos.x,y=pos.y-1,z=pos.z}
	
	local node_below = minetest.env:get_node(pos_below)
	
	
	if node_below == nil then
		return "ok"
	end
	
	for i,v in ipairs(surface.good) do
		if node_below.name == v then
			return "ok"
		end
	end
	
	for i,v in ipairs(surface.possible) do
		if node_below.name == v then
			return "possible_surface"
		end
	end
	
	return "wrong_surface"

end

-------------------------------------------------------------------------------
-- name: pos_is_ok(pos,entity)
--
-- action: check if a position is suitable for an animal
--
-- param1: position to check
-- retval: suitability of position for animal
--           -ok                    -->position is ok
--           -collision             -->position is within a node
--           -collision_jumpable    -->position is within a node that can be jumped onto
--           -drop                  -->position is a drop
--           -drop_above_water      -->position is to far above water
--           -above_water           -->position is right over water
--           -in_water              -->position is within a water node(source or flow)
--			 -in_air                -->position is in air
--           -above_limit           -->position is above level limit
--           -below_limit           -->position is below level limit
--           -wrong_surface         -->position is above surface animal shouldn't be
--           -invalid               -->unable to check position
-------------------------------------------------------------------------------
function environment.pos_is_ok(pos,entity)

	local min_ground_distance   = 0
	local max_ground_distance   = 0

	if entity.animals_mpattern.movement_canfly == false then
		max_ground_distance = 1	
	end
	


	dbg_animals.environment_lvl1("Checking pos "..printpos(pos))

	if pos == nil then
		minetest.log(LOGLEVEL_ERROR,"ANIMALS: BUG!!!! checking pos with nil value this won't work")
		return "invalid"	
	end
	
	local node = minetest.env:get_node(pos)

	if node == nil then
		minetest.log(LOGLEVEL_ERROR,"ANIMALS: BUG!!!! checking position with invalid node")
		return "invalid"
	end

	if environment.is_media_element(node.name,entity.animals_mpattern.environment.media) == true then

			--following return codes are only usefull for non flying
			if entity.animals_mpattern.movement_canfly == false then

				if animals_above_water(pos) then
					if ground_distance > regular_ground_distance then
						return "drop_above_water"
					end

					return "above_water"
				end

				local ground_distance = animals_ground_distance(pos)

				if ground_distance > max_ground_distance then
					return "drop"
				else
					return environment.checksurface(pos,entity.animals_mpattern.environment.surfaces)
				end
			else
				return environment.checksurface(pos,entity.animals_mpattern.environment.surfaces) 
			end
	end
	
	dbg_animals.environment_lvl1("Animals pos "..printpos(pos) .. " isn't ok " .. node.name .. " for animal " .. entity.data.name)

	--position is not ok gather some usefull information
	local pos_above = {x=pos.x,y=pos.y+1,z=pos.z}	
	local node_above = minetest.env:get_node(pos_above)

	if node_above == nil then
		minetest.log(LOGLEVEL_ERROR,"ANIMALS: BUG!!!! checking position with invalid node above")
		return "invalid"
	end

	if 	environment.is_media_element(node_above.name,entity.animals_mpattern.environment.media) and
		environment.is_jumpable_surface(node.name,entity.animals_mpattern.environment) then
		return "collision_jumpable"
	end

	if node.name == "default:water_source" or 
		node.name == "default:water_flowing" then
		return "in_water"
	end

	if node.name == "air" then
		return "in_air"
	end

	return "collision"

end

-------------------------------------------------------------------------------
-- name: get_default_gravity(pos,environment,canfly)
--
-- action: get default acceleration depending on animals medium and pos
--
-- param1: position to check
-- param2: animals movement medium
-- retval: y-accel
------------------------------------------------------------------------------
function environment.get_default_gravity(pos,media,canfly)

	local node = minetest.env:get_node(pos)

	--if an animal can't fly or isn't within it's medium default acceleration 
	-- for it's current medium is applied
	if canfly == false or
		environment.is_media_element(node.name,media) == false
		then
		if (node.name == "air") then			
			return -9.81
		end
		
		if node.name == "default:water_source" or
			node.name == "default:water_flowing" then
			return -2.5
		end
		
		if node.name == "default:lava" then
			return 0.1
		end
		
		--animal is at invalid position thus returning default air acceleration
		return -9.81
	end
		
	return 0
end