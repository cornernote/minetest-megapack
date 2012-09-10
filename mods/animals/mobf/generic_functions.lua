-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file generic_functions.lua
--! @brief generic functions used in many different places
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--!
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @defgroup gen_func Generic functions
--! @brief functions for various tasks
--! @ingroup framework_int
--! @{

if minetest.setting_getbool("mobf_enable_socket_trace") then
    require "socket"
end

-------------------------------------------------------------------------------
-- name: mobf_get_time_ms()
--
--! @brief get current time in ms
--! @memberof mgen_raster
--! @public
--
--! @return current time in ms
-------------------------------------------------------------------------------
function mobf_get_time_ms()
	if minetest.setting_getbool("mobf_enable_socket_trace") then
		return socket.gettime()*1000
	else
	    return 0
	end
end

-------------------------------------------------------------------------------
-- name: mobf_is_walkable(node)
--
--! @brief check if walkable flag is set for a node
--
--! @param node to check
--! @return true/false
-------------------------------------------------------------------------------
function mobf_is_walkable(node)
	return (node and node.name and minetest.registered_nodes[node.name] and
			minetest.registered_nodes[node.name].walkable)
end

-------------------------------------------------------------------------------
-- name: printpos(pos)
--
--! @brief convert pos to string of type "(X,Y,Z)"
--
--! @param pos position to convert
--! @return string with coordinates of pos
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
-- name: mobf_get_current_time()
--
--! @brief alias to get current time
--
--! @return current time in seconds
-------------------------------------------------------------------------------
function mobf_get_current_time()
	return os.time(os.date('*t'))
end

-------------------------------------------------------------------------------
-- name: mobf_warn_long_fct()
--
--! @brief alias to get current time
--
--! @param starttime time fct started
--! @param fctname name of function
--! @return current time in seconds
-------------------------------------------------------------------------------
function mobf_warn_long_fct(starttime,fctname)
	local delta = mobf_get_time_ms() - starttime
	if delta >200 then
		minetest.log(LOGLEVEL_ERROR,"MOBF: function " .. fctname .. " took too long: " .. delta .. " ms")
	end
end

-------------------------------------------------------------------------------
-- name: mobf_round_pos(pos)
--
--! @brief calculate integer position
--
--! @param pos position to be rounded
--! @return rounded position
-------------------------------------------------------------------------------
function mobf_round_pos(pos)
	if pos == nil then
		return pos
	end

	return { 	x=math.floor(pos.x + 0.5),
			y=math.floor(pos.y + 0.5),
			z=math.floor(pos.z + 0.5)
		 }

end

-------------------------------------------------------------------------------
-- name: mobf_calc_distance(pos1,pos2)
--
--! @brief calculate 3d distance between to points
--
--! @param pos1 first position
--! @param pos2 second position
--! @retval scalar value, distance
-------------------------------------------------------------------------------
function mobf_calc_distance(pos1,pos2)
	return math.sqrt( 	math.pow(pos1.x-pos2.x,2) + 
				math.pow(pos1.y-pos2.y,2) +
				math.pow(pos1.z-pos2.z,2))
end

-------------------------------------------------------------------------------
-- name: mobf_calc_distance_2d(pos1,pos2)
--
--! @brief calculate 2d distance between to points
--
--! @param pos1 first position
--! @param pos2 second position
--! @return scalar value, distance
-------------------------------------------------------------------------------
function mobf_calc_distance_2d(pos1,pos2)
	return math.sqrt( 	math.pow(pos1.x-pos2.x,2) + 
				math.pow(pos1.z-pos2.z,2))
end

-------------------------------------------------------------------------------
-- name: mobf_find_entity(newobject) DEPRECATED
--
--! @brief find entity by object reference
--
--! @param newobject r object reference
--! @return entity object reference points at or nil on error
-------------------------------------------------------------------------------
function mobf_find_entity(newobject)
	return newobject:get_luaentity()
end

-------------------------------------------------------------------------------
-- name: mobf_max_light_around(pos,range,daytime)
--
--! @brief get maximum light level around specified position
--
--! @param pos center of area to search
--! @param distance radius of area
--! @param daytime time of day to check
--! @return highest detected light level 
-------------------------------------------------------------------------------
function mobf_max_light_around(pos,distance,daytime)

	local max_light = 0

	for y_run=pos.y-distance,pos.y+distance,1 do
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
-- name: mobf_mob_around(mob_name,mob_transform_name,pos,range,)
--
--! @brief get number of mobs of specified type within range of pos
--
--! @param mob_name basic name of mob
--! @param mob_transform secondary name of mob
--! @param pos position to check
--! @param range range to check
--! @param ignore_playerspawned ignore mob spawned by players for check
--! @return number of mob found
-------------------------------------------------------------------------------
function mobf_mob_around(mob_name,mob_transform,pos,range,ignore_playerspawned)
	local count = 0
	local objectcount = 0

	local objectlist = minetest.env:get_objects_inside_radius(pos,range)
	
	if mob_transform == nil then
		mob_transform = ""
	end

	for index,value in pairs(objectlist) do 

		local entity = mobf_find_entity(value)

		dbg_mobf.generic_lvl1("MOBF: entity at "..printpos(pos)..
							" looking for: "..mob_name ..
							" or " .. mob_transform )
		
		--any mob is required to have a name so we may use this to decide
		--if an entity is an mob or not
		if 	entity ~= nil and
			entity.data ~= nil and
			entity.dynamic_data ~= nil and
			entity.dynamic_data.spawning ~= nil then

			if entity.dynamic_data.spawning.removed == false then
	
				if entity.data.modname..":"..entity.data.name == mob_name or
					entity.data.modname..":"..entity.data.name == mob_transform then
					if (ignore_playerspawned and entity.dynamic_data.spawning.player_spawned) or
						ignore_playerspawned ~= false then	
						dbg_mobf.generic_lvl1("MOBF: Found "..mob_name.. " or "..mob_transform .. " within specified range of "..range)
						count = count + 1
					end
				end

			end

		end

		objectcount = objectcount +1
	end

	dbg_mobf.generic_lvl2("MOBF: found " .. objectcount .. " within range " .. count .. " of them are relevant mobs ")

	return count
end

-------------------------------------------------------------------------------
-- name: mobf_line_of_sightX(pos1,pos2)
--
--! @brief is there a line of sight between two specified positions
-- TODO add code to minetest to get this working!
--
--! @param pos1 start position of los check
--! @param pos2 end position of los check
--! @return: true/false
-------------------------------------------------------------------------------
function mobf_line_of_sightX(pos1,pos2)
	return minetest.env:get_line_of_sight(pos1,pos2)
end

-------------------------------------------------------------------------------
-- name: mobf_line_of_sight(pos1,pos2)
--
--! @brief is there a line of sight between two specified positions
--
--! @param pos1 start position of los check
--! @param pos2 end position of los check
--! @return: true/false
-------------------------------------------------------------------------------
function mobf_line_of_sight(pos1,pos2) 

	--print("Checking line of sight between "..printpos(pos1).." and "..printpos(pos2))
	local distance = mobf_calc_distance(pos1,pos2)

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
-- name: mobf_get_direction(pos1,pos2)
--
--! @brief get normalized direction from pos1 to pos2
--
--! @param pos1 source point
--! @param pos2 destination point
--! @return xyz direction
-------------------------------------------------------------------------------
function mobf_get_direction(pos1,pos2)

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
-- name: mobf_pos_is_zero(pos)
--
--! @brief check if position is (0,0,0)
--
--! @param pos position to check
--! @return true/false
-------------------------------------------------------------------------------

function mobf_pos_is_zero(pos)

	if pos.x ~= 0 then return false end
	if pos.y ~= 0 then return false end	
	if pos.z ~= 0 then return false end

	return true
end

-------------------------------------------------------------------------------
-- name: mobf_air_above(pos,height)
--
--! @brief check if theres at least height air abov pos
--
--! @param pos position to check
--! @param height min number of air to check
--! @return true/false
-------------------------------------------------------------------------------
function mobf_air_above(pos,height)

	for i=0, height, 1 do
		local pos_above = {
			x = pos.x,
			y = pos.y + 1,
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
-- name: mobf_ground_distance(pos)
--
--! @brief get number of blocks above solid ground
--
--! @param pos position to check
--! @return number of blocks to ground
-------------------------------------------------------------------------------
function mobf_ground_distance(pos)

	local node_to_check = minetest.env:get_node(pos)

	local count = 0
	
	while node_to_check ~= nil and (
			node_to_check.name == "air" or
			node_to_check.name == "default:water_source" or
			node_to_check.name == "default:water_flowing") and
			count < 32 do
		
		count = count +1		
		--print("Checking node below " .. node_to_check.name .. " pos: ".. printpos(pos))
		pos = {x=pos.x,y=pos.y-1,z=pos.z};
		node_to_check = minetest.env:get_node(pos)
	end

	return count
end

-------------------------------------------------------------------------------
-- name: mobf_surface_distance(pos)
--
--! @brief get number of blocks above surface (solid or fluid!)
--
--! @param pos position to check
--! @return number of blocks to ground
-------------------------------------------------------------------------------
function mobf_surface_distance(pos)

	local node_to_check = minetest.env:get_node(pos)

	local count = 0
	
	while node_to_check ~= nil and 
			node_to_check.name == "air" and
			count < 32 do
		
		count = count +1
		
		--print("Checking node below " .. node_to_check.name .. " pos: ".. printpos(pos))
		pos = {x=pos.x,y=pos.y-1,z=pos.z};
		node_to_check = minetest.env:get_node(pos)
	end

	return count
end

-------------------------------------------------------------------------------
-- name: mobf_air_distance(pos)
--
--! @brief get number of blocks below waterline
--
--! @param pos position to check
--! @return number of blocks to air
-------------------------------------------------------------------------------
function mobf_air_distance(pos)

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
-- name: mobf_above_water(pos)
--
--! @brief check if next non-air block below mob is a water block
--
--! @param pos position to check
--! @return true/false
-------------------------------------------------------------------------------
function mobf_above_water(pos)

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

--!@}
