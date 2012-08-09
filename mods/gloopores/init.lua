-- GloopOres ver. 0.0.0-beta1
-- Original code: MoreOres mod by: Calinou with the help of MarkTraceur and Kotolegokot
-- License: GPLv3 (credit Calinou, not me)
-- Textures: WTFPL
-- ALL CREDIT GOES TO CALINOU AND MARKTRACEUR AND KOTOLEGOKOT!
-- ALL CREDIT GOES TO CALINOU AND MARKTRACEUR AND KOTOLEGOKOT!
-- I TAKE NO CREDIT. AT ALL. THIS IS FINAL. DO NOT YELL AT ME THAT THIS IS NOT MY CODE!!! BECAUSE I KNOW THAT!!!

local default_stone_sounds = default.node_sound_stone_defaults()

local recipes = {
	sword = {{'m'}, {'m'}, {"default:stick"}},
	shovel = {{'m'}, {"default:stick"}, {"default:stick"}},
	axe = {{'m', 'm'}, {'m', "default:stick"}, {'' , "default:stick"}},
	pick = {{'m', 'm', 'm'}, {'', "default:stick", ''}, {'', "default:stick", ''}}
}

local function get_tool_recipe(craftitem, toolname)
	local orig = recipes[toolname]
	local complete = {}
	for i, row in ipairs(orig) do
		local thisrow = {}
		for j, col in ipairs(row) do
			if col == 'm' then
				table.insert(thisrow, craftitem)
			else
				table.insert(thisrow, col)
			end
		end
		table.insert(complete, thisrow)
	end
	return complete
end

local function add_ore(modname, mineral_name, oredef)
    local firstlet = string.upper(string.sub(mineral_name, 1, 1))
    local upcase_name = firstlet..string.sub(mineral_name, 2)
    local img_base = modname..'_'..mineral_name
    local toolimg_base = modname..'_tool_'..mineral_name
	local tool_base = modname..':'
	local tool_post = '_'..mineral_name
    local item_base = tool_base..mineral_name
	local ingot = item_base..'_ingot'
	local lumpitem = item_base..'_lump'
	local ingotcraft = 'craft "'..ingot..'"'

	if oredef.makes.ore then
		local mineral_img_base = modname..'_mineral_'..mineral_name
		minetest.register_node(modname..':mineral_'..mineral_name, {
			description = upcase_name..' Ore',
			tiles = {'default_stone.png^'..mineral_img_base..'.png'},
			is_ground_content = true,
			groups = {cracky=3},
			sounds = default_stone_sounds,
			drop = 'craft "'..item_base..'_lump" 1'
		})
	end

	if oredef.makes.block then
		local blockitem = item_base..'_block'
		minetest.register_node(blockitem, {
			description = upcase_name .. ' Block',
			tiles = { img_base..'_block.png' },
			is_ground_content = true,
			groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
			sounds = default_stone_sounds
		})
		minetest.register_alias(mineral_name..'_block', blockitem)
		local ingotrow = {ingot, ingot, ingot}
		local nodeblockitem = 'node "'..blockitem..'"'
		minetest.register_craft( {
			output = nodeblockitem,
			recipe = {ingotrow, ingotrow, ingotrow}
		})
		minetest.register_craft( {
			output = 'craft "'..ingot..'" 9',
			recipe = {
				{ nodeblockitem }
			}
		})
	end

	if oredef.makes.lump then
		minetest.register_craftitem(lumpitem, {
			description = upcase_name..' Lump',
			inventory_image = img_base..'_lump.png',
			on_place_on_ground = minetest.craftitem_place_item
		})
		minetest.register_alias(mineral_name.."_lump", lumpitem)
		if oredef.makes.ingot then
			minetest.register_craft({
				type = 'cooking',
				output = ingot,
				recipe = lumpitem
			})
		end
	end

	if oredef.makes.ingot then
		minetest.register_craftitem(ingot, {
			description = upcase_name..' Ingot',
			inventory_image = img_base..'_ingot.png',
			on_place_on_ground = minetest.craftitem_place_item
		})
		minetest.register_alias(mineral_name.."_ingot", ingot)
		if oredef.makes.chest then
			minetest.register_craft( {
				output = 'node "default:chest_locked" 1',
				recipe = {
					{ ingotcraft },
					{ 'node "default:chest"' }
				}
			})
			wood = 'node "default:wood"'
			woodrow = {wood,wood,wood}
			minetest.register_craft( {
				output = 'node "default:chest_locked" 1',
				recipe = {
					woodrow,
					{wood, ingotcraft, wood},
					woodrow
				}
			})
		end
	end

	for toolname, tooldef in pairs(oredef.tools) do
		local tflet = string.upper(string.sub(toolname, 0, 1))
		local upcase_toolname = tflet..string.sub(toolname, 1)
		local tdef = {
			description = upcase_name..' '..upcase_toolname,
			inventory_image = toolimg_base..toolname..'.png',
			tool_capabilities = {
				max_drop_level=3,
				groupcaps=tooldef
			}
		}

		if toolname == 'sword' then
			tdef.full_punch_interval = oredef.punchint
		end
		local fulltoolname = tool_base..toolname..tool_post
		minetest.register_tool(fulltoolname, tdef)
		minetest.register_alias(toolname..tool_post, fulltoolname)
		if oredef.makes.ingot then
			minetest.register_craft({
				output = 'craft "'..fulltoolname..'" 1',
				recipe = get_tool_recipe(item_base..'_ingot', toolname)
			})
		end
	end
end


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
	if (y_max-chunk_size+1 <= y_min) then return end
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
	math.randomseed(os.time())
	local current_seed = seed + math.random(10,100)
	local function get_next_seed()
		current_seed = current_seed + 1
		return current_seed
	end
	generate_ore("gloopores:mineral_alatro", "default:stone", minp, maxp, get_next_seed(), 1/9/9/9, 6, 0, 256)
	generate_ore("gloopores:mineral_kalite", "default:stone", minp, maxp, get_next_seed(), 1/12/12/12, 3, -31000, 10)
	generate_ore("gloopores:mineral_arol", "default:stone", minp, maxp, get_next_seed(), 1/11/11/11, 3, -31000, -20)
	generate_ore("gloopores:mineral_talinite", "default:stone", minp, maxp, get_next_seed(), 1/13/13/13, 2, -31000, -512)
	generate_ore("gloopores:mineral_akalin", "default:desert_stone", minp, maxp, get_next_seed(), 1/5/5/5, 6, -31000, 256)
	generate_ore("gloopores:mineral_desert_coal", "default:desert_stone", minp, maxp, get_next_seed(), 1/6/6/6, 8, -31000, 64)
	generate_ore("gloopores:mineral_desert_iron", "default:desert_stone", minp, maxp, get_next_seed(), 1/7/7/7, 5, -31000, 15)
end)

local modname = 'gloopores'

local oredefs = {
	alatro = {
		makes = {ore=true, block=true, lump=true, ingot=true, chest=false},
		tools = {
			pick = {
				cracky={times={[2]=0.65, [3]=0.40}, uses=40, maxlevel=1}
			},
			shovel = {
				crumbly={times={[2]=0.60, [3]=0.35}, uses=40, maxlevel=1}
			},
			axe = {
				choppy={times={[2]=0.65, [3]=0.40}, uses=40, maxlevel=1},
				fleshy={times={[2]=0.65, [3]=0.40}, uses=40, maxlevel=1}
			},
			sword = {
				fleshy={times={[2]=0.80, [3]=0.60}, uses=40, maxlevel=1},
				snappy={times={[2]=0.80, [3]=0.60}, uses=40, maxlevel=1},
				choppy={times={[3]=0.80}, uses=40, maxlevel=0}
			}
		},
		punchint = 1.00
	},
	kalite = {
		makes = {ore=true, block=false, lump=false, ingot=false, chest=false},
		tools = {},
		punchint = 0.80
	},
	arol = {
		makes = {ore=true, block=false, lump=true, ingot=true, chest=false},
		tools = {
			pick = {
				cracky={times={[1]=3.00, [2]=1.20, [3]=0.80}, uses=300, maxlevel=1}
			},
			shovel = {
				crumbly={times={[1]=1.50, [2]=0.75, [3]=0.45}, uses=300, maxlevel=1}
			},
			axe = {
				choppy={times={[1]=3.00, [2]=1.00, [3]=0.70}, uses=300, maxlevel=1},
				fleshy={times={[2]=1.30, [3]=0.70}, uses=300, maxlevel=1}
			},
			sword = {
				fleshy={times={[2]=1.00, [3]=0.80}, uses=300, maxlevel=1},
				snappy={times={[2]=1.00, [3]=0.80}, uses=300, maxlevel=1},
				choppy={times={[3]=1.20}, uses=300, maxlevel=0}
			}
		},
		punchint = 0.60
	},
	talinite = {
		makes = {ore=true, block=false, lump=true, ingot=true, chest=false},
		tools = {},
		punchint = 0.45
	},
	akalin = {
		makes = {ore=false, block=true, lump=true, ingot=true, chest=false},
		tools = {},
		punchint = 0.80
	}
}

for orename,def in pairs(oredefs) do
	add_ore(modname, orename, def)
end

minetest.register_craftitem("gloopores:kalite_lump", {
	description = 'Kalite Lump',
	inventory_image = 'gloopores_kalite_lump.png',
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = minetest.item_eat(1),
})

minetest.register_node("gloopores:kalite_torch", {
	description = "Kalite Torch",
	drawtype = "torchlike",
	tiles = {"gloopores_kalite_torch_on_floor.png", "gloopores_kalite_torch_on_ceiling.png", "gloopores_kalite_torch.png"},
	inventory_image = "gloopores_kalite_torch_on_floor.png",
	wield_image = "gloopores_kalite_torch_on_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = LIGHT_MAX-1,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {choppy=2,dig_immediate=3,flammable=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})

minetest.register_craft({
	output = "gloopores:kalite_torch 4",
	recipe = {
		{"gloopores:kalite_lump"},
		{"default:stick"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "gloopores:kalite_lump",
	burntime = 60,
})

minetest.register_node("gloopores:talinite_block", {
	description = 'Talinite Block',
	tiles = {'gloopores_talinite_block.png'},
	is_ground_content = true,
	light_source = LIGHT_MAX,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_alias('gloopores:talinite_block', "talinite_block")
local ingotrow = {"gloopores:talinite_ingot", "gloopores:talinite_ingot", "gloopores:talinite_ingot"}
minetest.register_craft( {
	output = "gloopores:talinite_block",
	recipe = {ingotrow, ingotrow, ingotrow}
})
minetest.register_craft( {
	output = 'craft "gloopores:talinite_ingot" 9',
	recipe = {
		{'gloopores:talinite_block'}
	}
})

minetest.register_node('gloopores:mineral_akalin', {
	description = 'Akalin Ore',
	tiles = {'default_desert_stone.png^gloopores_mineral_akalin.png'},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default_stone_sounds,
	drop = 'craft "gloopores:akalin_lump" 1'
})

minetest.register_node('gloopores:mineral_desert_coal', {
	description = 'Coal Ore',
	tiles = {'default_desert_stone.png^default_mineral_coal.png'},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default_stone_sounds,
	drop = 'craft "default:coal_lump" 1'
})

minetest.register_node('gloopores:mineral_desert_iron', {
	description = 'Iron Ore',
	tiles = {'default_desert_stone.png^default_mineral_iron.png'},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default_stone_sounds,
	drop = 'craft "default:iron_lump" 1'
})
--