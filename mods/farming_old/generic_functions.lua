-------------------------------------------------------------------------------
-- name: farming_get_current_time()
--
-- action: alias to get current time
--
-- retval: current time in seconds
-------------------------------------------------------------------------------
function farming_get_current_time()
	return os.time(os.date('*t'))
end

-------------------------------------------------------------------------------
-- name: is_water_nearby(position,distance)
--
-- action: is water within distance of position
--
-- param1: position
-- param2: distance
-- retval: -
-------------------------------------------------------------------------------
function is_water_nearby(position,distance)

	if distance < 0 then
		return true
	end

	--water needs to be somewhere below! the crop within it's max distance
	for y_run=position.y,position.y-distance,-1 do
		for z_run=position.z-distance,position.z+distance,1 do
			for x_run=position.x-distance,position.x+distance,1 do
				local current_pos = {x=x_run,y=y_run,z=z_run }
				local node = minetest.env:get_node(current_pos)

				if node.name == "default:water_source" then 
					return true
				end

				if node.name == "default:water_flowing" then 
					return true
				end		
			end
		end
	end

	return false
end

-------------------------------------------------------------------------------
-- name: is_plowable(nodename)
--
-- action: is node a plowable node
--
-- param1: name of node
-- retval: -
-------------------------------------------------------------------------------
function is_plowable(nodename)

	if nodename == "default:dirt" then
		return true
	end

	if nodename == "default:dirt_with_grass" then
		return true
	end
	
	return false
end

-------------------------------------------------------------------------------
-- name: farming_find_entity(newobject)
--
-- action: find entity by object reference
--
-- param1: object reference
-- retval: entity added or nil on error
-------------------------------------------------------------------------------
function farming_find_entity(newobject)

	for index,value in pairs(minetest.luaentities) do 
		if value.object == newobject then
			return value
		end
	end

	return nil
end

-------------------------------------------------------------------------------
-- name: check_node_below(pos)
--
-- action: check if there really is a dirtbed below
--
-- param1: position
-- retval: entity added or nil on error
-------------------------------------------------------------------------------
function check_node_below(pos)

	--print("checking position:"..printpos(pos))

	local node_at = minetest.env:get_node(pos)

	if node_at ~= nil then
		--print("Node is of type: "..node_at.name)	

		if is_plowable(node_at.name) then

			minetest.env:remove_node(pos)
			minetest.env:add_node(pos,{name="farming:plowed"})
			return true
		else
			if node_at.name == "farming:plowed" then
				return true
			end
		end
	end

	return false
end


-------------------------------------------------------------------------------
-- name: dump(table)
--
-- action: dump table to a text
--
-- param1: table
-- retval: -
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
-- name: damage_wielded_item(player,damage)
--
-- action: damage the wielded item by amount
--
-- param1: player
-- param2: damage to do
-- retval: -
-------------------------------------------------------------------------------
function damage_wielded_item(player,damage)
	local tool = player:get_wielded_item()
	if tool ~= nil then
		tool:add_wear(-damage)
		player:set_wielded_item(tool)
	end
end
