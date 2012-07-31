local players = {}

minetest.register_on_joinplayer(function(player)
	table.insert(players, player)
end)

minetest.register_on_leaveplayer(function(player)
	table.remove(players, player)
end)

function round(num) 
        if num >= 0 then return math.floor(num+.5) 
        else return math.ceil(num-.5) end
end

local player_positions = {}

minetest.register_globalstep(function(dtime)
	for i,player in ipairs(players) do
		local wielded = player:get_wielded_item()
		if wielded:get_name() == "default:torch" then
			local pos = player:getpos()
			local ontop = {x=round(pos.x),y=round(pos.y)+i,z=round(pos.z)}

			local player_name = player:get_player_name()
			if player_positions[player_name] == nil then
				player_positions[player_name] = {}
				player_positions[player_name]["x"] = ontop.x;
				player_positions[player_name]["y"] = ontop.y;
				player_positions[player_name]["z"] = ontop.z;
			end

			if player_positions[player_name]["x"] ~= ontop.x or player_positions[player_name]["y"] ~= ontop.y or player_positions[player_name]["z"] ~= ontop.z then
				local is_air  = minetest.env:get_node_or_nil(ontop)
				-- print('newpos '..minetest.pos_to_string(ontop)..' on '..is_air.name)
				if is_air ~= nil and (is_air.name == "air" or is_air.name == "walking_light:light")then
					-- print('set '..minetest.pos_to_string(ontop))
					if is_air.name == "air" then
						minetest.env:add_node(ontop,{type="node",name="walking_light:light"})
					end
					-- print('remove ('..player_positions[player_name]["x"]..','..player_positions[player_name]["y"]..','..player_positions[player_name]["z"]..')')
					minetest.env:remove_node({x=player_positions[player_name]["x"], y=player_positions[player_name]["y"], z=player_positions[player_name]["z"]})
					player_positions[player_name]["x"] = ontop.x
					player_positions[player_name]["y"] = ontop.y
					player_positions[player_name]["z"] = ontop.z
				end
			end
		else
			local pos = player:getpos()
			local ontop = {x=round(pos.x),y=round(pos.y)+i,z=round(pos.z)}
			local is_air  = minetest.env:get_node_or_nil(ontop)
			if is_air ~= nil and is_air.name == "walking_light:light" then
				minetest.env:remove_node(ontop)
			end
			if player_positions[player_name] ~= nil then
				minetest.env:remove_node({x=player_positions[player_name]["x"], y=player_positions[player_name]["y"], z=player_positions[player_name]["z"]})
			end
		end
	end
end)

minetest.register_node("walking_light:light", {
	drawtype = "glasslike",
	tile_images = {"walking_light.png"},
	inventory_image = minetest.inventorycube("walking_light.png"),
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	light_propagates = true,
	sunlight_propagates = true,
	light_source = 15,
	selection_box = {
        type = "fixed",
        fixed = {0, 0, 0, 0, 0, 0},
    },
})
