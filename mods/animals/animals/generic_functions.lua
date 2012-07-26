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

animals_registred_animals = {}
-------------------------------------------------------------------------------
-- name: printpos(pos)
--
-- action: convert pos to string of type "(X,Y,Z)"
--
-- param1: position to convert
-- retval: string with coordinates of pos
-------------------------------------------------------------------------------
function printpos(pos)
	if pos ~= nil then
		if pos.y ~= nil then
			return "("..pos.x..","..pos.y..","..pos.z..")"
		else
			return "("..pos.x..", ? ,"..pos.z..")"
		end
	end
	return ""
end

-------------------------------------------------------------------------------
-- name: animals_get_current_time()
--
-- action: alias to get current time
--
-- retval: current time in seconds
-------------------------------------------------------------------------------
function animals_get_current_time()
	return os.time(os.date('*t'))
end

-------------------------------------------------------------------------------
-- name: animals_round_pos(pos)
--
-- action: calculate integer position
--
-- param1: position to be rounded
-- retval: rounded position
-------------------------------------------------------------------------------
function animals_round_pos(pos)

	return { 	x=math.floor(pos.x + 0.5),
			y=math.floor(pos.y + 0.5),
			z=math.floor(pos.z + 0.5)
		 }

end

-------------------------------------------------------------------------------
-- name: animals_calc_distance(pos1,pos2)
--
-- action: calculate 3d distance between to points
--
-- param1: position 1
-- param2: position 2
-- retval: scalar value, distance
-------------------------------------------------------------------------------
function animals_calc_distance(pos1,pos2)
	return math.sqrt( 	math.pow(pos1.x-pos2.x,2) + 
				math.pow(pos1.y-pos2.y,2) +
				math.pow(pos1.z-pos2.z,2))
end

-------------------------------------------------------------------------------
-- name: animals_calc_distance_2d(pos1,pos2)
--
-- action: calculate 2d distance between to points
--
-- param1: position 1
-- param2: position 2
-- retval: scalar value, distance
-------------------------------------------------------------------------------
function animals_calc_distance_2d(pos1,pos2)
	return math.sqrt( 	math.pow(pos1.x-pos2.x,2) + 
				math.pow(pos1.z-pos2.z,2))
end

-------------------------------------------------------------------------------
-- name: animals_find_entity(newobject) DEPRECATED
--
-- action: find entity by object reference
--
-- param1: object reference
-- retval: entity added or nil on error
-------------------------------------------------------------------------------
function animals_find_entity(newobject)
	return newobject:get_luaentity()
end




-------------------------------------------------------------------------------
-- name: animals_is_node_in_cube(tofind,pos,range)
--
-- action: check if specific nodes are within range of specified position
--
-- param1: name of animal
-- param2: position to check
-- param3: range to check
-- retval: -
-------------------------------------------------------------------------------
function animals_is_node_in_cube(nodename, node_pos, radius)
	for x = node_pos.x - radius, node_pos.x + radius do
		for y = node_pos.y - radius, node_pos.y + radius do
			for z = node_pos.z - radius, node_pos.z + radius do
				n = minetest.env:get_node_or_nil({x = x, y = y, z = z})
				if (n ~= nil)
					and (n.name ~= 'ignore')
					and (nodename == n.name) then
					return true
				end
			end
		end
	end

	return false
end

-------------------------------------------------------------------------------
-- name: animals_max_light_around(pos,range,daytime)
--
-- action: check if specific nodes are within range of specified position
--
-- param1: name of animal
-- param2: position to check
-- param3: range to check
-- retval: -
-------------------------------------------------------------------------------
function animals_max_light_around(pos,distance,daytime)

	local max_light = 0

	for y_run=pos.y,pos.y-distance,-1 do
		for z_run=pos.z-distance,pos.z+distance,1 do
			for x_run=pos.x-distance,pos.x+distance,1 do
				local current_pos = {x=x_run,y=y_run,z=z_run }
				local node = minetest.env:get_node(current_pos)

				if node.name == "air" then 
					local current_light = minetest.env:get_node_light(current_pos,daytime)

					if current_light > max_light then
						max_light = current_light
					end
				end		
			end
		end
	end

	return max_light
end


-------------------------------------------------------------------------------
-- name: animals_around(animal,pos,range)
--
-- action: get number of animals within range of pos
--
-- param1: name of animal
-- param2: secondary name of animal
-- param3: position to check
-- param4: range to check
-- retval: -
-------------------------------------------------------------------------------
function animals_around(animals_name_to_check,animal_transform,pos,range,ignore_playerspawned)
	local count = 0
	local objectcount = 0

	local objectlist = minetest.env:get_objects_inside_radius(pos,range)
	
	if animal_transform == nil then
		animal_transform = ""
	end

	for index,value in pairs(objectlist) do 

		local entity = animals_find_entity(value)

		dbg_animals.generic_lvl1("ANIMALS: entity at "..printpos(pos)..
							" looking for: "..animals_name_to_check ..
							" or " .. animal_transform )
		
		--any animal is required to have a name so we may use this to decide
		--if an entity is an animal or not
		if 	entity ~= nil and
			entity.data ~= nil and
			entity.dynamic_data ~= nil then

			if entity.dynamic_data.spawning.removed == false then
	
				if entity.data.modname..":"..entity.data.name == animals_name_to_check or
					entity.data.modname..":"..entity.data.name == animal_transform then
					if (ignore_playerspawned and entity.dynamic_data.spawning.player_spawned) or
						ignore_playerspawned ~= false then	
						dbg_animals.generic_lvl1("ANIMALS: Found "..animals_name_to_check.. " or "..animal_transform .. " within specified range of "..range)
						count = count + 1
					end
				end

			end

		end

		objectcount = objectcount +1
	end

	dbg_animals.generic_lvl2("ANIMALS: found " .. objectcount .. " within range " .. count .. " of them are relevant animals ")

	return count
end

-------------------------------------------------------------------------------
-- name: animals_line_of_sightX(pos1,pos2)
--
-- action: find and remove spawnpoint from list
-- TODO add code to minetest to get this working!
--
-- param1: start position of los check
-- param2: end position of los check
-- retval: true/false
-------------------------------------------------------------------------------
function animals_line_of_sightX(pos1,pos2)
	return minetest.env:get_line_of_sight(pos1,pos2)
end

-------------------------------------------------------------------------------
-- name: animals_line_of_sight(pos1,pos2)
--
-- action: find and remove spawnpoint from list
--
-- param1: start position of los check
-- param2: end position of los check
-- retval: true/false
-------------------------------------------------------------------------------
function animals_line_of_sight(pos1,pos2) 

	--print("Checking line of sight between "..printpos(pos1).." and "..printpos(pos2))
	local distance = animals_calc_distance(pos1,pos2)

	local normalized_vector = {	x=(pos2.x-pos1.x)/distance,
					y=(pos2.y-pos1.y)/distance,
					z=(pos2.z-pos1.z)/distance}


	local line_of_sight = true	

	for i=1,distance, 1 do
		local tocheck = { x=pos1.x + (normalized_vector.x * i),
					y=pos1.y + (normalized_vector.y *i),
					z=pos1.z + (normalized_vector.z *i)}
		
		local node = minetest.env:get_node(tocheck)


		if minetest.registered_nodes[node.name].sunlight_propagates ~= true then
				--print("No line of sight between "..printpos(pos1).." and "..printpos(pos2) .. " due to " .. node.name)
				line_of_sight = false
				break
		end
	end

	return line_of_sight
end

-------------------------------------------------------------------------------
-- name: dump(table)
--
-- action: recursive parse a tabpe
--
-- param1: table to parse
-- retval: string containing structure and data of table
-------------------------------------------------------------------------------
function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
                if type(k) ~= 'number' then k = '"'..k..'"' end
                s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end


-------------------------------------------------------------------------------
-- name: animals_get_direction(pos1,pos2)
--
-- action: get normalized direction from pos1 to pos2
--
-- param1: source point
-- param2: destination point
-- retval: xyz direction
-------------------------------------------------------------------------------
function animals_get_direction(pos1,pos2)

	local x_raw = pos2.x -pos1.x
	local y_raw = pos2.y -pos1.y
	local z_raw = pos2.z -pos1.z


	local x_abs = math.abs(x_raw)
	local y_abs = math.abs(y_raw)
	local z_abs = math.abs(z_raw)

	if 	x_abs >= y_abs and
		x_abs >= z_abs then

		y_raw = y_raw * (1/x_abs)
		z_raw = z_raw * (1/x_abs)

		x_raw = x_raw/x_abs

	end

	if 	y_abs >= x_abs and
		y_abs >= z_abs then


		x_raw = x_raw * (1/y_abs)
		z_raw = z_raw * (1/y_abs)

		y_raw = y_raw/y_abs

	end

	if 	z_abs >= y_abs and
		z_abs >= x_abs then

		x_raw = x_raw * (1/z_abs)
		y_raw = y_raw * (1/z_abs)

		z_raw = z_raw/z_abs

	end

	return {x=x_raw,y=y_raw,z=z_raw}

end


-------------------------------------------------------------------------------
-- name: animals_pos_is_zero(pos)
--
-- action: check if position is (0,0,0)
--
-- param1: position to check
-- retval: true/false
-------------------------------------------------------------------------------

function animals_pos_is_zero(pos)

	if pos.x ~= 0 then
		return false
	end
	
	if	pos.y ~= 0 then
		return false
	end
	
	if pos.z ~= 0 then
		return false
	end

	return true
end

-------------------------------------------------------------------------------
-- name: animals_air_above(pos,height)
--
-- action: check if theres at least height air abov pos
--
-- param1: position to check
-- param2: height to check
-- retval: true/false
-------------------------------------------------------------------------------
function animals_air_above(pos,height)

	for i=1, height, 1 do
		local pos_above = {
			x = pos.x,
			y = pos.y + 1*1,
			z = pos.z
			}
		local node_above = minetest.env:get_node(pos_above)

		if node_above.name ~= "air" then
			return false
		end
	end

	return true
end


-------------------------------------------------------------------------------
-- name: animals_ground_distance(pos)
--
-- action: get number of blocks above solid ground
--
-- param1: position to check
-- retval: number of blocks to ground
-------------------------------------------------------------------------------
function animals_ground_distance(pos)

	local node_to_check = minetest.env:get_node(pos)

	local count = 0
	
	while node_to_check ~= nil and (
			node_to_check.name == "air" or
			node_to_check.name == "default:water_source" or
			node_to_check.name == "default:water_flowing") do
		
		count = count +1		
		--print("Checking node below " .. node_to_check.name .. " pos: ".. printpos(pos))
		pos = {x=pos.x,y=pos.y-1,z=pos.z};
		node_to_check = minetest.env:get_node(pos)
	end

	return count
end

-------------------------------------------------------------------------------
-- name: animals_surface_distance(pos)
--
-- action: get number of blocks above solid ground
--
-- param1: position to check
-- retval: number of blocks to ground
-------------------------------------------------------------------------------
function animals_surface_distance(pos)

	local node_to_check = minetest.env:get_node(pos)

	local count = 0
	
	while node_to_check ~= nil and 
			node_to_check.name == "air" do
		
		count = count +1		
		--print("Checking node below " .. node_to_check.name .. " pos: ".. printpos(pos))
		pos = {x=pos.x,y=pos.y-1,z=pos.z};
		node_to_check = minetest.env:get_node(pos)
	end

	return count
end

-------------------------------------------------------------------------------
-- name: animals_air_distance(pos)
--
-- action: get number of blocks below waterline
--
-- param1: position to check
-- retval: number of blocks to air
-------------------------------------------------------------------------------
function animals_air_distance(pos)

	local node_to_check = minetest.env:get_node(pos)

	local count = 0
	
	while node_to_check ~= nil and (
			node_to_check.name == "default:water_source" or
			node_to_check.name == "default:water_flowing") do
		
		count = count +1		
		--print("Checking node below " .. node_to_check.name .. " pos: ".. printpos(pos))
		pos = {x=pos.x,y=pos.y+1,z=pos.z};
		node_to_check = minetest.env:get_node(pos)
	end

	if node_to_check.name == "air" then
		return count
	else
		return -1
	end
end

-------------------------------------------------------------------------------
-- name: animals_above_water(pos)
--
-- action: is next non air block water?
--
-- param1: position to check
-- retval: true/false
-------------------------------------------------------------------------------
function animals_above_water(pos)

	local node_to_check = minetest.env:get_node(pos)
	
	while node_to_check ~= nil and 
			node_to_check.name == "air" do
			
			if node_to_check.name == "default:water_source" or
					node_to_check.name == "default:water_flowing" then
				return true			
			end
			--print("Checking node below " .. node_to_check.name .. " pos: ".. printpos(pos))
			pos = {x=pos.x,y=pos.y-1,z=pos.z};
			node_to_check = minetest.env:get_node(pos)
	end

	return false
end


function set_yaw(entity,yaw)
	entity.object:setyaw(yaw)
end

function get_velocity(entity)
	return entity.object:getvelocity()
end
