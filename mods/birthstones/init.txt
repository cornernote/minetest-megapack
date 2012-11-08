minetest.register_node( "birthstones:diamondore", {
	description = "Diamond Ore",
	tile_images = { "default_stone.png^Diamond_overlay.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "birthstones:diamond" 1',
})
minetest.register_node( "birthstones:alexandriteore", {
	description = "Alexandrite Ore",
	tile_images = { "default_stone.png^Alexandrite_overlay.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "birthstones:alexandrite" 1',
})
minetest.register_node( "birthstones:amethystore", {
	description = "Amethyst Ore",
	tile_images = { "default_stone.png^Amethyst_overlay.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "birthstones:amethyst" 1',
})
minetest.register_node( "birthstones:aquamarineore", {
	description = "Aquamarine Ore",
	tile_images = { "default_stone.png^Aquamarine_overlay.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "birthstones:aquamarine" 1',
})
minetest.register_node( "birthstones:emeraldore", {
	description = "Emerald Ore",
	tile_images = { "default_stone.png^Emerald_overlay.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "birthstones:emerald" 1',
})
minetest.register_node( "birthstones:garnetore", {
	description = "Garnet Ore",
	tile_images = { "default_stone.png^Garnet_overlay.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "birthstones:garnet" 1',
})
minetest.register_node( "birthstones:opalore", {
	description = "Opal Ore",
	tile_images = { "default_stone.png^Opal_overlay.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "birthstones:opal" 1',
})
minetest.register_node( "birthstones:peridotore", {
	description = "Peridot Ore",
	tile_images = { "default_stone.png^Peridot_overlay.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "birthstones:peridot" 1',
})
minetest.register_node( "birthstones:rubyore", {
	description = "Ruby Ore",
	tile_images = { "default_stone.png^Ruby_overlay.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "birthstones:ruby" 1',
})
minetest.register_node( "birthstones:sapphireore", {
	description = "Sapphire Ore",
	tile_images = { "default_stone.png^Sapphire_overlay.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "birthstones:sapphire" 1',
})
minetest.register_node( "birthstones:topazore", {
	description = "Topaz Ore",
	tile_images = { "default_stone.png^Topaz_overlay.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "birthstones:topazore" 1',
})
minetest.register_node( "birthstones:topazore", {
	description = "Topaz Ore",
	tile_images = { "default_stone.png^Topaz_overlay.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "birthstones:topaz" 1',
})
minetest.register_node( "birthstones:zirconore", {
	description = "Zircon Ore",
	tile_images = { "default_stone.png^Zircon_overlay.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "birthstones:zircon" 1',
})



minetest.register_craftitem( "birthstones:alexandrite", {
	description = "Alexandrite (January)",
	inventory_image = "Alexandrite.png",
	on_place_on_ground = minetest.craftitem_place_item,
})
minetest.register_craftitem( "birthstones:amethyst", {
	description = "Amethyst (February)",
	inventory_image = "Amethyst.png",
	on_place_on_ground = minetest.craftitem_place_item,
})
minetest.register_craftitem( "birthstones:aquamarine", {
	description = "Aquamarine (March)",
	inventory_image = "Aquamarine.png",
	on_place_on_ground = minetest.craftitem_place_item,
})
minetest.register_craftitem( "birthstones:diamond", {
	description = "Diamond (April)",
	inventory_image = "Diamond.png",
	on_place_on_ground = minetest.craftitem_place_item,
})
minetest.register_craftitem( "birthstones:emerald", {
	description = "Emerald (May)",
	inventory_image = "Emerald.png",
	on_place_on_ground = minetest.craftitem_place_item,
})
minetest.register_craftitem( "birthstones:garnet", {
	description = "Garnet (June)",
	inventory_image = "Garnet.png",
	on_place_on_ground = minetest.craftitem_place_item,
})
minetest.register_craftitem( "birthstones:opal", {
	description = "Opal (July)",
	inventory_image = "Opal.png",
	on_place_on_ground = minetest.craftitem_place_item,
})
minetest.register_craftitem( "birthstones:peridot", {
	description = "Peridot (August)",
	inventory_image = "Peridot.png",
	on_place_on_ground = minetest.craftitem_place_item,
})
minetest.register_craftitem( "birthstones:ruby", {
	description = "Ruby (September)",
	inventory_image = "Ruby.png",
	on_place_on_ground = minetest.craftitem_place_item,
})
minetest.register_craftitem( "birthstones:sapphire", {
	description = "Sapphire (October)",
	inventory_image = "Sapphire.png",
	on_place_on_ground = minetest.craftitem_place_item,
})
minetest.register_craftitem( "birthstones:topaz", {
	description = "Topaz (November)",
	inventory_image = "Topaz.png",
	on_place_on_ground = minetest.craftitem_place_item,
})
minetest.register_craftitem( "birthstones:zircon", {
	description = "Zircon (December)",
	inventory_image = "Zircon.png",
	on_place_on_ground = minetest.craftitem_place_item,
})



minetest.register_node( "birthstones:alexandriteblock", {
	description = "Alexandrite Block",
	tile_images = { "Alexandrite_block.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node( "birthstones:amethystblock", {
	description = "Amethyst Block",
	tile_images = { "Amethyst_block.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node( "birthstones:aquamarineblock", {
	description = "Aquamarine Block",
	tile_images = { "Aquamarine_block.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node( "birthstones:diamondblock", {
	description = "Diamond Block",
	tile_images = { "Diamond_block.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node( "birthstones:emeraldblock", {
	description = "Emerald Block",
	tile_images = { "Emerald_block.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node( "birthstones:garnetblock", {
	description = "Garnet Block",
	tile_images = { "Garnet_block.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node( "birthstones:opalblock", {
	description = "Opal Block",
	tile_images = { "Opal_block.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node( "birthstones:peridotblock", {
	description = "Peridot Block",
	tile_images = { "Peridot_block.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node( "birthstones:rubyblock", {
	description = "Ruby Block",
	tile_images = { "Ruby_block.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node( "birthstones:sapphireblock", {
	description = "Sapphire Block",
	tile_images = { "Sapphire_block.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node( "birthstones:topazblock", {
	description = "Topaz Block",
	tile_images = { "Topaz_block.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node( "birthstones:zirconblock", {
	description = "Zircon Block",
	tile_images = { "Zircon_block.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

local function registerblockrecipe(name, blockname)

minetest.register_craft({
	output = blockname,
	recipe = {{name, name, name},
		{name, name, name},
		{name, name, name}
		}
})

end

registerblockrecipe('birthstones:alexandrite', 'birthstones:alexandriteblock')
registerblockrecipe('birthstones:amethyst', 'birthstones:amethystblock')
registerblockrecipe('birthstones:aquamarine', 'birthstones:aquamarineblock')
registerblockrecipe('birthstones:diamond', 'birthstones:diamondblock')
registerblockrecipe('birthstones:emerald', 'birthstones:emeraldblock')
registerblockrecipe('birthstones:garnet', 'birthstones:garnetblock')
registerblockrecipe('birthstones:opal', 'birthstones:opalblock')
registerblockrecipe('birthstones:peridot', 'birthstones:peridotblock')
registerblockrecipe('birthstones:ruby', 'birthstones:rubyblock')
registerblockrecipe('birthstones:sapphire', 'birthstones:sapphireblock')
registerblockrecipe('birthstones:topaz', 'birthstones:topazblock')
registerblockrecipe('birthstones:zircon', 'birthstones:zirconblock')

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
end

minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("birthstones:alexandriteore", "default:stone", minp, maxp, seed+21,   1/10/10/10,    10, -31000,  -40)
end)
minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("birthstones:amethystore", "default:stone", minp, maxp, seed+21,   1/10/10/10,    10, -31000,  -50)
end)
minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("birthstones:aquamarineore", "default:stone", minp, maxp, seed+21,   1/10/10/10,    10, -31000,  -10)
end)
minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("birthstones:diamondore", "default:stone", minp, maxp, seed+21,   1/10/10/10,    4, -31000,  -300)
end)
minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("birthstones:emeraldore", "default:stone", minp, maxp, seed+21,   1/10/10/10,    10, -31000,  -100)
end)
minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("birthstones:garnetore", "default:stone", minp, maxp, seed+21,   1/10/10/10,    10, -31000,  -70)
end)
minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("birthstones:peridotore", "default:stone", minp, maxp, seed+21,   1/10/10/10,    10, -31000,  -60)
end)
minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("birthstones:rubyore", "default:stone", minp, maxp, seed+21,   1/10/10/10,    10, -31000,  -120)
end)
minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("birthstones:sapphireore", "default:stone", minp, maxp, seed+21,   1/10/10/10,    10, -31000,  -120)
end)
minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("birthstones:topazore", "default:stone", minp, maxp, seed+21,   1/10/10/10,    10, -31000,  -80)
end)
minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("birthstones:zirconore", "default:stone", minp, maxp, seed+21,   1/10/10/10,    10, -31000,  -70)
end)