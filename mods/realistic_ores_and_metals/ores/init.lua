minetest.register_abm({
	nodenames={"default:stone_with_coal"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.env:set_node(pos, {name="default:stone"})
	end,
})

minetest.register_abm({
	nodenames={"default:stone_with_iron"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.env:set_node(pos, {name="default:stone"})
	end,
})

minetest.register_abm({
	nodenames={"default:mese"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.env:set_node(pos, {name="default:stone"})
	end,
})

ORES_LIST = {
	'brown_coal',
	'coal',
	'anthracite',
	'bituminous_coal',
	'magnetite',
	'hematite',
	'limonite',
	'bismuthinite',
	'cassiterite',
	'galena',
	'garnierite',
	'malachite',
	'native_copper',
	'native_gold',
	'native_silver',
	'sphalerite',
	'tetrahedrite',
	'lapis',
}
ORES_DESC_LIST = {
	'Brown coal ore',
	'Coal ore',
	'Anthracite ore',
	'Bituminous coal ore',
	'Magnetite ore',
	'Hematite ore',
	'Limonite ore',
	'Bismuthinite ore',
	'Cassiterite ore',
	'Galena ore',
	'Garnierite ore',
	'Malachite ore',
	'Native copper ore',
	'Native gold ore',
	'Native silver ore',
	'Sphalerite ore',
	'Tetrahedrite ore',
	'Lapis ore',
}

for i=1, #ORES_LIST do
	minetest.register_node("ores:"..ORES_LIST[i], {
		description = ORES_DESC_LIST[i],
		tile_images = {"default_stone.png^ores_"..ORES_LIST[i]..".png"},
		is_ground_content = true,
		groups = {cracky=3},
		drop = 'minerals:'..ORES_LIST[i],
		sounds = default.node_sound_stone_defaults(),
	})
end

local function generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, chunk_size, ore_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
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
end

local function generate_peat(name, wherein, minp, maxp, seed, chunks_per_volume, chunk_size, ore_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
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
						if minetest.env:get_node({x=p2.x, y=p2.y + 1, z=p2.z}).name == 'default:water_source' and
						minetest.env:get_node({x=p2.x, y=p2.y + 2, z=p2.z}).name == 'air' then
							minetest.env:set_node(p2, {name=name})
						end
						if minetest.env:get_node({x=p2.x, y=p2.y + 1, z=p2.z}).name == 'default:water_source' and
						minetest.env:get_node({x=p2.x, y=p2.y + 2, z=p2.z}).name == 'default:water_source' and 
						minetest.env:get_node({x=p2.x, y=p2.y + 3, z=p2.z}).name == 'air' then
							minetest.env:set_node(p2, {name=name})
						end
						
					end
				end
			end
			end
			end
		end
	end
end

minetest.register_on_generated(
function(minp, maxp, seed)
	generate_ore('ores:brown_coal',      "default:stone", minp, maxp, seed+1,  1/8/8/8/8/8, 4,50, -3000,   -1000)
	generate_ore('ores:coal',            "default:stone", minp, maxp, seed+2,  1/8/8/8/8/8, 4,50, -6000,   -3000)
	generate_ore('ores:anthracite',      "default:stone", minp, maxp, seed+3,  1/8/8/8/8/8, 4,50, -31000,  -6000)
	generate_ore('ores:bituminous_coal', "default:stone", minp, maxp, seed+4,  1/8/8/8/8/8, 4,50, -3000,   31000)
	generate_ore('ores:bismuthinite',    "default:stone", minp, maxp, seed+5,  1/8/8/8/8/8, 4,50, -31000,  31000)
	generate_ore('ores:magnetite',       "default:stone", minp, maxp, seed+6,  1/8/8/8/8/8, 4,50, -31000,  31000)
	generate_ore('ores:hematite',        "default:stone", minp, maxp, seed+7,  1/8/8/8/8/8, 4,50, -31000,  31000)
	generate_ore('ores:limonite',        "default:stone", minp, maxp, seed+8,  1/8/8/8/8/8, 4,50, -31000,  31000)
	generate_ore('ores:cassiterite',     "default:stone", minp, maxp, seed+9,  1/8/8/8/8/8, 4,50, -31000,  31000)
	generate_ore('ores:galena',          "default:stone", minp, maxp, seed+10, 1/8/8/8/8/8, 4,50, -31000,  31000)
	generate_ore('ores:garnierite',      "default:stone", minp, maxp, seed+11, 1/8/8/8/8/8, 4,50, -31000,  31000)
	generate_ore('ores:malachite',       "default:stone", minp, maxp, seed+12, 1/8/8/8/8/8, 4,50, -31000,  31000)
	generate_ore('ores:native_copper',   "default:stone", minp, maxp, seed+13, 1/8/8/8/8/8, 4,50, -31000,  31000)
	generate_ore('ores:native_gold',     "default:stone", minp, maxp, seed+14, 1/8/8/8/8/8, 4,50, -31000,  31000)
	generate_ore('ores:native_silver',   "default:stone", minp, maxp, seed+15, 1/8/8/8/8/8, 4,50, -31000,  31000)
	generate_ore('ores:sphalerite',      "default:stone", minp, maxp, seed+16, 1/8/8/8/8/8, 4,50, -31000,  31000)
	generate_ore('ores:tetrahedrite',    "default:stone", minp, maxp, seed+17, 1/8/8/8/8/8, 4,50, -31000,  31000)
	generate_ore('ores:lapis',           "default:stone", minp, maxp, seed+18, 1/8/8/8/8/8, 4,50, -31000,  31000)
	
	--generate_peat("default:peat", "default:dirt", minp, maxp, seed+4, 1/8/16/24,    8, 512, -31000,  31000)
end)