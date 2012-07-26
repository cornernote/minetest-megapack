local version = "0.0.2"
-------------------------------------------------------------------------------
-- name: printpos(pos)
--
-- action: convert pos to string of type "(X,Y,Z)"
--
-- param1: position to convert
-- retval: string with coordinates of pos
-------------------------------------------------------------------------------
function printpos(pos)
	return "("..pos.x..","..pos.y..","..pos.z..")"
end

-------------------------------------------------------------------------------
-- name: light_meter_handler(item, player, pointed_thing)
--
-- action: calculate light level above pointed position
--
-- param1: position to convert
-- retval: string with coordinates of pos
-------------------------------------------------------------------------------
function light_meter_handler(item, player, pointed_thing)

	if pointed_thing ~= nil then
		local pos = pointed_thing.above

		if pos ~= nil then

			local pos_above = {x=pos.x,y=pos.y+1,z=pos.z}

			local current_light = minetest.env:get_node_light(pos)
			local light_midnight = minetest.env:get_node_light(pos,0)
			local light_high_noon = minetest.env:get_node_light(pos,0.5)

			local playername = player.get_player_name(player)

			minetest.chat_send_player(playername, "Light level"..printpos(pos).." Now:".. current_light .. ",Midnight:"..light_midnight..",Midday:"..light_high_noon)
		end
	end

	return false
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
-- name: water_meter_handler(item, player, pointed_thing)
--
-- action: calculate distance to water
--
-- param1: position to convert
-- retval: string with coordinates of pos
-------------------------------------------------------------------------------
function water_meter_handler(item, player, pointed_thing)

	if pointed_thing ~= nil then
		local pos = pointed_thing.under		

		if pos ~= nil then
			local playername = player.get_player_name(player)

			for i=1, 5,1 do
		
				if is_water_nearby(pos,i) then
					minetest.chat_send_player(playername, "Water available within distance of ".. i .. " at " .. printpos(pos) ..": YES")
				else
					minetest.chat_send_player(playername, "Water available within distance of ".. i .. " at " .. printpos(pos) ..": NO")
				end
			end
			
		end
	end

	return false
end


--add light meter item
minetest.register_craftitem("light_meter:light_meter", {
	image = "light_meter.png",
	on_use = function(item, player, pointed_thing)
		light_meter_handler(item, player, pointed_thing)
		end
})

minetest.register_craft({
	output = 'craft "light_meter:light_meter" 1',
	recipe = {
		{'node "default:glass"'},
		{'craft "default:stick"'}
	}
})

minetest.register_craftitem("light_meter:water_meter", {
	image = "water_meter.png",
	on_use = function(item, player, pointed_thing)
		water_meter_handler(item, player, pointed_thing)
		end
})

minetest.register_craft({
	output = 'craft "light_meter:water_meter" 1',
	recipe = {
		{'node "default:glass"'},
		{'node "default:glass"'},
		{'craft "default:stick"'}
	}
})


print("Loaded mod light_meter version: " .. version)
