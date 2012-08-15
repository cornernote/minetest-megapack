local players = {}
local player_positions = {}
local last_wielded = {}

function round(num) 
        if num >= 0 then return math.floor(num+.5) 
        else return math.ceil(num-.5) end
end

minetest.register_on_joinplayer(function(player)
	table.insert(players, player)
	
	local player_name = player:get_player_name()
	
	last_wielded[player_name] = player:get_wielded_item():get_name()
	-- leerer String falls die Fackel auf der ersten Position im Inventar liegt
	
	local pos = player:getpos()
	local rounded_pos = {x=round(pos.x),y=round(pos.y),z=round(pos.z)}
	
	player_positions[player_name] = {}
	player_positions[player_name]["x"] = rounded_pos.x;
	player_positions[player_name]["y"] = rounded_pos.y;
	player_positions[player_name]["z"] = rounded_pos.z;
end)

minetest.register_on_leaveplayer(function(player)
	table.remove(players, player)
	
	local player_name = player:get_player_name()
	
	last_wielded[player_name] = nil
	
	player_positions[player_name]["x"] = nil
	player_positions[player_name]["y"] = nil
	player_positions[player_name]["z"] = nil
	player_positions[player_name] = nil
end)



minetest.register_globalstep(function(dtime)
	for i,player in ipairs(players) do
		local player_name = player:get_player_name()
		local wielded_item = player:get_wielded_item():get_name()
		if wielded_item == "default:torch" or wielded_item == "walking_light:pick_mese" then
			-- Fackel ist in der Hand
			local pos = player:getpos()
			local rounded_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}

			if (last_wielded[player_name] ~= "default:torch" and last_wielded[player_name] ~= "walking_light:pick_mese") or (player_positions[player_name]["x"] ~= rounded_pos.x or player_positions[player_name]["y"] ~= rounded_pos.y or player_positions[player_name]["z"] ~= rounded_pos.z) then
				-- Fackel gerade in die Hand genommen oder zu neuem Node bewegt
				local is_air  = minetest.env:get_node_or_nil(rounded_pos)
				if is_air ~= nil and is_air.name == "air" then
					-- wenn an aktueller Position "air" ist, Fackellicht setzen
					-- print('newpos '..minetest.pos_to_string(rounded_pos)..' on '..is_air.name)
					minetest.env:add_node(rounded_pos,{type="node",name="walking_light:light"})
				elseif is_air == nil then
					-- wenn Spieler beim Start schon Fackel in der Hand hält
					minetest.env:add_node(rounded_pos,{type="node",name="walking_light:light"})
				end
				local old_pos = {x=player_positions[player_name]["x"], y=player_positions[player_name]["y"], z=player_positions[player_name]["z"]}
				repeat
					local is_light  = minetest.env:get_node_or_nil(old_pos)
					if is_light ~= nil and is_light.name == "walking_light:light" and (last_wielded[player_name] == "default:torch" or last_wielded[player_name] == "walking_light:pick_mese") then
						-- print('remove '..minetest.pos_to_string(old_pos))
						minetest.env:remove_node(old_pos)
					end
				until minetest.env:get_node_or_nil(old_pos) ~= "walking_light:light"
				-- gemerkte Position ist nun die gerundete neue Position
				player_positions[player_name]["x"] = rounded_pos.x
				player_positions[player_name]["y"] = rounded_pos.y
				player_positions[player_name]["z"] = rounded_pos.z
			end

			last_wielded[player_name] = wielded_item;
		elseif last_wielded[player_name] == "default:torch" or last_wielded[player_name] == "walking_light:pick_mese" then
			-- Fackel nicht in der Hand, aber beim letzten Durchgang war die Fackel noch in der Hand
			local pos = player:getpos()
			local rounded_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}
			repeat
				local is_light  = minetest.env:get_node_or_nil(rounded_pos)
				if is_light ~= nil and is_light.name == "walking_light:light" then
					minetest.env:remove_node(rounded_pos)
				end
			until minetest.env:get_node_or_nil(rounded_pos) ~= "walking_light:light"

			local old_pos = {x=player_positions[player_name]["x"], y=player_positions[player_name]["y"], z=player_positions[player_name]["z"]}
			repeat
				is_light  = minetest.env:get_node_or_nil(old_pos)
				if is_light ~= nil and is_light.name == "walking_light:light" then
					minetest.env:remove_node(old_pos)
				end
			until minetest.env:get_node_or_nil(old_pos) ~= "walking_light:light"

			last_wielded[player_name] = wielded_item
		end


	end
end)

minetest.register_node("walking_light:light", {
	drawtype = "glasslike",
	tile_images = {"walking_light.png"},
	-- tile_images = {"walking_light_debug.png"},
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
minetest.register_tool("walking_light:pick_mese", {
	description = "Mese Pickaxe with light",
	inventory_image = "walking_light_mesepick.png",
	wield_image = "default_tool_mesepick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			cracky={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3},
			crumbly={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3},
			snappy={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3}
		}
	},
})

minetest.register_craft({
	output = 'walking_light:pick_mese',
	recipe = {
		{'default:torch'},
		{'default:pick_mese'},
	}
})