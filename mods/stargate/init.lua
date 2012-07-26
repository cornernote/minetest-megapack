--Stargate Mod
--Modified by SegFault22
--modified from an original mod that makes teleporters, creator of that is unknown (and, over 50% of the data has been changed, making this unique)
--Please read through the mod code here to find where you will input toe coordinates of the stargates
--IF you need any help, ask SegFault22
--
--Blocks 

minetest.register_node("stargate:gateblock", {
	description = "Stargate Ring Block",
	tiles = {"stargate_gateblock.png"},
	is_ground_content = true,
	light_source = LIGHT_MAX-0.1,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("stargate:naqueda_crystals", {
	description = "Naqueda Crystals",
	tiles = {"stargate_naqueda_crystals.png"},
	is_ground_content = true,
	light_source = LIGHT_MAX-0.1,
	groups = {cracky=2},
	drawtype = "plantlike",
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "stargate:naqueda_crystal" 4',
})

minetest.register_craftitem("stargate:naqueda_crystal", {
	description = "Naqueda Crystal",
	inventory_image = "stargate_naqueda_crystal.png",
})

minetest.register_craft({
	output = 'node "stargate:gateblock" 1',
	recipe = {
		{'craft "mese', 'craft "steelblock"', 'craft "mese"'},
		{'craft "steelblock"', 'craft "stargate:naqueda_crystal"', 'craft "steelblock"'},
		{'craft "mese', 'craft "steelblock"', 'craft "mese"'},
	}
})

local function generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, ore_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local chunk_size = 3
	if ore_per_chunk <= 4 then
		chunk_size = 2
	end
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	--print("generate_ore num_chunks: "..dump(num_chunks))
	for i=1,num_chunks do
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.env:get_node(p2).name == wherein then
						minetest.env:set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
	--print("generate_ore done")
end

minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("stargate:naqueda_crystals", "default:stone", minp, maxp, seed+21,   1/25/25/25,    1, -31000,  -475)
end)

--STARGATE A
minetest.register_on_punchnode(function(p, node, puncher)
	if node.name == "default:glass" then
	local name = puncher:get_player_name()
--top row
	if minetest.env:get_node({x = p.x, y = p.y + 2, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x + 1, y = p.y + 2, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x - 1, y = p.y + 2, z = p.z}).name == "stargate:gateblock" then	
	if minetest.env:get_node({x = p.x + 2, y = p.y + 2, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x - 2, y = p.y + 2, z = p.z}).name == "stargate:gateblock" then
--middle row
	if minetest.env:get_node({x = p.x + 2, y = p.y, z = p.z}).name == "stargate:gateblock" then	
	if minetest.env:get_node({x = p.x - 2, y = p.y, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x + 2, y = p.y + 1, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x + 2, y = p.y - 1, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x - 2, y = p.y + 1, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x - 2, y = p.y - 1, z = p.z}).name == "stargate:gateblock" then
--bottom row
	if minetest.env:get_node({x = p.x + 1, y = p.y - 2, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x - 1, y = p.y - 2, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x, y = p.y - 2, z = p.z}).name == "stargate:gateblock" then
	pos_sur = p
	minetest.chat_send_player(name, "Teleporting to stargate B...")
-- Set the coordinates of stargate B here (or where you want people to teleport to on using stargate B)
	puncher:setpos({x = pos_sur.x - 1, y = -20000, z = pos_sur.z + 1})
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end)
--
--STARGATE B
minetest.register_on_punchnode(function(p, node, puncher)
	if node.name == "default:steelblock" then
	local name = puncher:get_player_name()
	if minetest.env:get_node({x = p.x, y = p.y + 2, z = p.z}).name == "stargate:gateblock" then
--top row
	if minetest.env:get_node({x = p.x + 1, y = p.y + 2, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x - 1, y = p.y + 2, z = p.z}).name == "stargate:gateblock" then	
	if minetest.env:get_node({x = p.x + 2, y = p.y + 2, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x - 2, y = p.y + 2, z = p.z}).name == "stargate:gateblock" then
--middle row
	if minetest.env:get_node({x = p.x + 2, y = p.y, z = p.z}).name == "stargate:gateblock" then	
	if minetest.env:get_node({x = p.x - 2, y = p.y, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x + 2, y = p.y + 1, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x + 2, y = p.y - 1, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x - 2, y = p.y + 1, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x - 2, y = p.y - 1, z = p.z}).name == "stargate:gateblock" then
--bottom row
	if minetest.env:get_node({x = p.x + 1, y = p.y - 2, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x - 1, y = p.y - 2, z = p.z}).name == "stargate:gateblock" then
	if minetest.env:get_node({x = p.x, y = p.y - 2, z = p.z}).name == "stargate:gateblock" then
	pos_sur = p
	minetest.chat_send_player(name, "Teleporting to stargate A...")
--Set the coordiantes of the stargate A here (or where you wish for people to teleport to on use of the stargate)
--NOTE: you have to set the coordinates here as if stargate B is at 0,0,0 (invert coordinates)
	puncher:setpos({x = pos_sur.x + 1, y = pos_sur.y + 20000, z = pos_sur.z - 1})
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end)
