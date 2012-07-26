--[[
****
More Ores
by Calinou
Rewritten by MarkTraceur
Version 2012-06-24
Licensed under GPLv3 or later, see http://www.gnu.org/licenses/gpl-3.0.html
****
--]]

-- Utility functions

local default_stone_sounds = default.node_sound_stone_defaults()

local stick = 'default:stick'
local recipes = {
	sword = {{'m'}, {'m'}, {stick}},
	shovel = {{'m'}, {stick}, {stick}},
	axe = {{'m', 'm'}, {'m', stick}, {'' , stick}},
	pick = {{'m', 'm', 'm'}, {'', stick, ''}, {'', stick, ''}}
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
		if oredef.makes.ingot then
			minetest.register_craft({
				output = 'craft "'..fulltoolname..'" 1',
				recipe = get_tool_recipe(item_base..'_ingot', toolname)
			})
		end
	end
end

-- Add everything (compact(ish)!)

local modname = 'moreores'

local oredefs = {
	gold = {
		makes = {ore=true, block=true, lump=true, ingot=true, chest=true},
		tools = {
			pick = {
				cracky={times={[1]=2.00, [2]=0.50, [3]=0.30}, uses=70, maxlevel=1}
			},
			shovel = {
				crumbly={times={[1]=0.60, [2]=0.25, [3]=0.15}, uses=70, maxlevel=1}
			},
			axe = {
				choppy={times={[1]=1.70, [2]=0.40, [3]=0.35}, uses=70, maxlevel=1},
				fleshy={times={[2]=0.90, [3]=0.30}, uses=70, maxlevel=1}
			},
			sword = {
				fleshy={times={[2]=0.60, [3]=0.20}, uses=70, maxlevel=1},
				snappy={times={[2]=0.60, [3]=0.20}, uses=70, maxlevel=1},
				choppy={times={[3]=0.65}, uses=70, maxlevel=0}
			}
		},
		punchint = 0.85
	},
	silver = {
		makes = {ore=true, block=true, lump=true, ingot=true, chest=true},
		tools = {
			pick = {
				cracky={times={[1]=2.60, [2]=1.00, [3]=0.60}, uses=100, maxlevel=1}
			},
			shovel = {
				crumbly={times={[1]=1.10, [2]=0.40, [3]=0.25}, uses=100, maxlevel=1}
			},
			axe = {
				choppy={times={[1]=2.50, [2]=0.80, [3]=0.50}, uses=100, maxlevel=1},
				fleshy={times={[2]=1.10, [3]=0.60}, uses=100, maxlevel=1}
			},
			sword = {
				fleshy={times={[2]=0.70, [3]=0.30}, uses=100, maxlevel=1},
				snappy={times={[2]=0.70, [3]=0.30}, uses=100, maxlevel=1},
				choppy={times={[3]=0.80}, uses=100, maxlevel=0}
			}
		},
		punchint = 1.0
	},
	copper = {
		makes = {ore=true, block=false, lump=true, ingot=true, chest=false},
		tools = {}
	},
	tin = {
		makes = {ore=true, block=false, lump=true, ingot=true, chest=false},
		tools = {}
	},
	bronze = {
		makes = {ore=false, block=true, lump=false, ingot=true, chest=true},
		tools = {
			pick = {
				cracky={times={[1]=3.00, [2]=1.20, [3]=0.80}, uses=160, maxlevel=1}
			},
			shovel = {
				crumbly={times={[1]=1.50, [2]=0.50, [3]=0.30}, uses=160, maxlevel=1}
			},
			axe = {
				choppy={times={[1]=3.00, [2]=1.00, [3]=0.60}, uses=160, maxlevel=1},
				fleshy={times={[2]=1.30, [3]=0.70}, uses=160, maxlevel=1}
			},
			sword = {
				fleshy={times={[2]=0.80, [3]=0.40}, uses=160, maxlevel=1},
				snappy={times={[2]=0.80, [3]=0.40}, uses=160, maxlevel=1},
				choppy={times={[3]=0.90}, uses=160, maxlevel=0}
			}
		},
		punchint = 1.0
	},
	mithril = {
		makes = {ore=true, block=true, lump=true, ingot=true, chest=false},
		tools = {
			pick = {
				cracky={times={[1]=2.25, [2]=0.55, [3]=0.35}, uses=200, maxlevel=1}
			},
			shovel = {
				crumbly={times={[1]=0.70, [2]=0.35, [3]=0.20}, uses=200, maxlevel=1}
			},
			axe = {
				choppy={times={[1]=1.75, [2]=0.45, [3]=0.45}, uses=200, maxlevel=1},
				fleshy={times={[2]=0.95, [3]=0.30}, uses=200, maxlevel=1}
			},
			sword = {
				fleshy={times={[2]=0.65, [3]=0.25}, uses=200, maxlevel=1},
				snappy={times={[2]=0.70, [3]=0.25}, uses=200, maxlevel=1},
				choppy={times={[3]=0.65}, uses=200, maxlevel=0}
			}
		},
		punchint = 0.45
	}
}

for orename,def in pairs(oredefs) do
	add_ore(modname, orename, def)
end

-- Copper rail (special item!)

minetest.register_craft({
	output = 'moreores:copper_rail 15',
	recipe = {
		{'moreores:copper_ingot', '', 'moreores:copper_ingot'},
		{'moreores:copper_ingot', 'default:stick', 'moreores:copper_ingot'},
		{'moreores:copper_ingot', '', 'moreores:copper_ingot'}
	}
})

-- Bronze has some special cases (because it's made from copper + tin)

minetest.register_craft( {
	output = 'craft "moreores:bronze_ingot"',
	recipe = {
		{ 'craft "moreores:tin_ingot"'},
		{ 'craft "moreores:copper_ingot"'}
	}
})

minetest.register_craft( {
	output = 'craft "moreores:bronze_ingot"',
	recipe = {
		{ 'craft "moreores:copper_ingot"'},
		{ 'craft "moreores:tin_ingot"'}
	}
})

-- unique items

minetest.register_node('moreores:copper_rail', {
	description = 'Copper Rail',
	drawtype = 'raillike',
	tiles = {'moreores_copper_rail.png', 'moreores_copper_rail_curved.png', 'moreores_copper_rail_t_junction.png', 'moreores_copper_rail_crossing.png'},
	inventory_image = 'moreores_copper_rail.png',
	wield_image = 'moreores_copper_rail.png',
	paramtype = 'light',
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = 'fixed',
		--fixed = <default>
	},
	groups = {bendy=2,snappy=1,dig_immediate=2}
})

-- Ore generation

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
	generate_ore("moreores:mineral_copper", "default:stone", minp, maxp, get_next_seed(), 1/12/12/12, 8, -31000, 64)
	generate_ore("moreores:mineral_tin", "default:stone", minp, maxp, get_next_seed(), 1/9/9/9, 2, -31000, 8)
	generate_ore("moreores:mineral_silver", "default:stone", minp, maxp, get_next_seed(), 1/11/11/11, 5, -31000, 2)
	generate_ore("moreores:mineral_gold", "default:stone", minp, maxp, get_next_seed(), 1/13/13/13, 5, -31000, -64)
	generate_ore("moreores:mineral_mithril", "default:stone", minp, maxp, get_next_seed(), 1/7/7/7, 1, -31000, -512)
end)
