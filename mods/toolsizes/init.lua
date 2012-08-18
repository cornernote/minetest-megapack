--[[
ToolSizes mod by GloopMaster
ver. 0.1
licensing: GPLv3(code) WTFPL(textures)
code referenced: default mod, workbench mod
dependancies: default mod, workbench mod, OPTIONAL: moreores mod, gloopores mod
description: Adds sized tools, various blocks, and a lot of crafts for the workbench mod.
--]]

dofile(minetest.get_modpath("toolsizes").."/config.lua")

local stick = 'default:stick'
local recipes = {
	sword_med = {{'', 'm', ''}, {'', 'm', ''}, {'m', 'm', 'm'}, {'', stick, ''}},
	shovel_med = {{'', 'm', ''}, {'m', 'm', 'm'}, {'', stick, ''}, {'', stick, ''}},
	axe_med = {{'m', 'm', ''}, {'m', stick, 'm'}, {'m' , stick, ''}, {'', stick, ''}},
	pick_med = {{'m', 'm', 'm', 'm'}, {'', stick, '', ''}, {'', stick, '', ''}, {'', stick, '', ''}},
	sword_large = {{'', '', 'm', '', ''}, {'', '', 'm', '', ''}, {'', 'm', 'm', 'm', ''}, {'m', 'm', stick, 'm', 'm'}, {'', '', stick, '', ''}},
	shovel_large = {{'', '', 'm', '', ''}, {'', 'm', 'm', 'm', ''}, {'m', 'm', stick, 'm', 'm'}, {'', '', stick, '', ''}, {'', '', stick, '', ''}},
	axe_large = {{'', 'm', 'm', '', ''}, {'m', 'm', stick, 'm', 'm'}, {'', 'm' , stick, '', ''}, {'', '', stick, '', ''}, {'', '', stick, '', ''}},
	pick_large = {{'m', 'm', 'm', 'm', 'm'}, {'m', '', stick, '', 'm'}, {'', '', stick, '' ,''}, {'', '', stick, '', ''}, {'', '', stick, '', ''}}
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

local function add_tools(modname, mineral_name, matdef)
    local firstlet = string.upper(string.sub(mineral_name, 1, 1))
    local upcase_name = firstlet..string.sub(mineral_name, 2)
    local toolimg_base = "workbenchcrafts"..'_'..mineral_name..'_'
	local tool_base = modname..':'
	local tool_post = '_'..mineral_name

	for toolname, tooldef in pairs(matdef.tools) do
		local tflet = string.upper(string.sub(toolname, 1, 1))
		local upcase_toolname = tflet..string.sub(toolname, 2)
		local tdef = {
			description = upcase_name..' '..upcase_toolname,
			inventory_image = toolimg_base..toolname..'.png',
			tool_capabilities = {
				max_drop_level=3,
				groupcaps=tooldef
			}
		}
		
		if toolname == "pick_med" then
			tdef.wield_scale = {x=1.25,y=1.25,z=1}
			tdef.description = "Medium "..upcase_name.." Pickaxe"
			tdef.tool_capabilities.full_punch_inverval = 1.2
		end
		if toolname == "shovel_med" then
			tdef.wield_scale = {x=1.25,y=1.25,z=1}
			tdef.description = "Medium "..upcase_name.." Shovel"
			tdef.tool_capabilities.full_punch_inverval = 1.2
		end
		if toolname == "axe_med" then
			tdef.wield_scale = {x=1.25,y=1.25,z=1}
			tdef.description = "Medium "..upcase_name.." Axe"
			tdef.tool_capabilities.full_punch_inverval = 1.2
		end
		if toolname == "sword_med" then
			tdef.wield_scale = {x=1.25,y=1.25,z=1}
			tdef.description = "Medium "..upcase_name.." Sword"
			tdef.tool_capabilities.full_punch_inverval = 1.2
		end
		if toolname == "pick_large" then
			tdef.wield_scale = {x=1.5,y=1.5,z=1}
			tdef.description = "Large "..upcase_name.." Pickaxe"
			tdef.tool_capabilities.full_punch_inverval = 1.5
		end
		if toolname == "shovel_large" then
			tdef.wield_scale = {x=1.5,y=1.5,z=1}
			tdef.description = "Large "..upcase_name.." Shovel"
			tdef.tool_capabilities.full_punch_inverval = 1.5
		end
		if toolname == "axe_large" then
			tdef.wield_scale = {x=1.5,y=1.5,z=1}
			tdef.description = "Large "..upcase_name.." Axe"
			tdef.tool_capabilities.full_punch_inverval = 1.5
		end
		if toolname == "sword_large" then
			tdef.wield_scale = {x=1.5,y=1.5,z=1}
			tdef.description = "Large "..upcase_name.." Sword"
			tdef.tool_capabilities.full_punch_inverval = 1.5
		end
		
		local fulltoolname = tool_base..toolname..tool_post
		minetest.register_tool(fulltoolname, tdef)
		minetest.register_alias(toolname..tool_post, fulltoolname)
		minetest.register_craft({
			output = 'craft "'..fulltoolname..'" 1',
			recipe = get_tool_recipe(matdef.material, toolname)
		})
	end
end


local modname = 'toolsizes'

matdefs = {
	wood = {
		tools = {
			pick_med = {
				cracky={times={[2]=1.33, [3]=0.80}, uses=15, maxlevel=1}
			},
			shovel_med = {
				crumbly={times={[1]=2.00, [2]=0.53, [3]=0.33}, uses=15, maxlevel=1}
			},
			axe_med = {
				choppy={times={[2]=0.93, [3]=0.53}, uses=15, maxlevel=1},
				fleshy={times={[2]=1.00, [3]=0.53}, uses=15, maxlevel=1}
			},
			sword_med = {
				fleshy={times={[2]=0.73, [3]=0.40}, uses=15, maxlevel=1},
				snappy={times={[2]=0.66, [3]=0.33}, uses=15, maxlevel=1},
				choppy={times={[3]=0.66}, uses=30, maxlevel=1}
			},
			pick_large = {
				cracky={times={[2]=1.00, [3]=0.60}, uses=20, maxlevel=1}
			},
			shovel_large = {
				crumbly={times={[1]=1.50, [2]=0.40, [3]=0.25}, uses=20, maxlevel=1}
			},
			axe_large = {
				choppy={times={[2]=0.70, [3]=0.40}, uses=20, maxlevel=1},
				fleshy={times={[2]=0.75, [3]=0.40}, uses=20, maxlevel=1}
			},
			sword_large = {
				fleshy={times={[2]=0.55, [3]=0.30}, uses=20, maxlevel=1},
				snappy={times={[2]=0.50, [3]=0.25}, uses=20, maxlevel=1},
				choppy={times={[3]=0.50}, uses=40, maxlevel=1}
			},
		},
		material = "default:wood"
	},
	stone = {
		tools = {
			pick_med = {
				cracky={times={[1]=2.00, [2]=0.80, [3]=0.53}, uses=30, maxlevel=2}
			},
			shovel_med = {
				crumbly={times={[1]=1.00, [2]=0.46, [3]=0.40}, uses=30, maxlevel=2}
			},
			axe_med = {
				choppy={times={[1]=2.00, [2]=0.66, [3]=0.40}, uses=30, maxlevel=2},
				fleshy={times={[2]=0.86, [3]=0.46}, uses=30, maxlevel=2}
			},
			sword_med = {
				fleshy={times={[2]=0.53, [3]=0.26}, uses=30, maxlevel=2},
				snappy={times={[2]=0.53, [3]=0.26}, uses=30, maxlevel=2},
				choppy={times={[3]=0.60}, uses=40, maxlevel=1}
			},
			pick_large = {
				cracky={times={[1]=1.50, [2]=0.60, [3]=0.45}, uses=40, maxlevel=2}
			},
			shovel_large = {
				crumbly={times={[1]=1.00, [2]=0.33, [3]=0.30}, uses=40, maxlevel=2}
			},
			axe_large = {
				choppy={times={[1]=1.50, [2]=0.50, [3]=0.30}, uses=40, maxlevel=2},
				fleshy={times={[2]=0.65, [3]=0.35}, uses=40, maxlevel=2}
			},
			sword_large = {
				fleshy={times={[2]=0.40, [3]=0.20}, uses=40, maxlevel=2},
				snappy={times={[2]=0.40, [3]=0.20}, uses=40, maxlevel=2},
				choppy={times={[3]=0.45}, uses=60, maxlevel=1}
			},
		},
		material = "default:cobble"
	},
	steel = {
		tools = {
			pick_med = {
				cracky={times={[1]=2.66, [2]=1.06, [3]=0.66}, uses=45, maxlevel=2}
			},
			shovel_med = {
				crumbly={times={[1]=1.00, [2]=0.46, [3]=0.40}, uses=45, maxlevel=2}
			},
			axe_med = {
				choppy={times={[1]=2.00, [2]=1.06, [3]=0.66}, uses=45, maxlevel=2},
				fleshy={times={[2]=0.73, [3]=0.40}, uses=60, maxlevel=2}
			},
			sword_med = {
				fleshy={times={[1]=1.33, [2]=0.60, [3]=0.26}, uses=15, maxlevel=2},
				snappy={times={[2]=0.46, [3]=0.20}, uses=60, maxlevel=2},
				choppy={times={[3]=0.46}, uses=60, maxlevel=1}
			},
			pick_large = {
				cracky={times={[1]=2.00, [2]=0.80, [3]=0.50}, uses=60, maxlevel=3}
			},
			shovel_large = {
				crumbly={times={[1]=0.75, [2]=0.35, [3]=0.40}, uses=60, maxlevel=3}
			},
			axe_large = {
				choppy={times={[1]=1.50, [2]=0.80, [3]=0.50}, uses=30, maxlevel=2},
				fleshy={times={[2]=0.55, [3]=0.30}, uses=80, maxlevel=2}
			},
			sword_large = {
				fleshy={times={[1]=1.00, [2]=0.40, [3]=0.20}, uses=20, maxlevel=3},
				snappy={times={[2]=0.35, [3]=0.15}, uses=80, maxlevel=3},
				choppy={times={[3]=0.35}, uses=80, maxlevel=2}
			},
		},
		material = "default:steel_ingot"
	},
	mese = {
		tools = {
			pick_med = {
				cracky={times={[1]=1.33, [2]=0.66, [3]=0.33}, uses=30, maxlevel=3},
				crumbly={times={[1]=1.33, [2]=0.66, [3]=0.33}, uses=30, maxlevel=3},
				snappy={times={[1]=1.33, [2]=0.66, [3]=0.33}, uses=30, maxlevel=3}
			},
			pick_large = {
				cracky={times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=40, maxlevel=3},
				crumbly={times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=40, maxlevel=3},
				snappy={times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=40, maxlevel=3}
			},
		},
		material = "default:mese"
	},
	gold = {
		tools = {
			pick_med = {
				cracky={times={[1]=1.33, [2]=0.33, [3]=0.20}, uses=105, maxlevel=2}
			},
			shovel_med = {
				crumbly={times={[1]=0.40, [2]=0.16, [3]=0.10}, uses=105, maxlevel=2}
			},
			axe_med = {
				choppy={times={[1]=1.13, [2]=0.26, [3]=0.23}, uses=105, maxlevel=2},
				fleshy={times={[2]=0.60, [3]=0.20}, uses=105, maxlevel=2}
			},
			sword_med = {
				fleshy={times={[2]=0.40, [3]=0.13}, uses=105, maxlevel=2},
				snappy={times={[2]=0.40, [3]=0.13}, uses=105, maxlevel=2},
				choppy={times={[3]=0.43}, uses=105, maxlevel=2}
			},
			pick_large = {
				cracky={times={[1]=1.00, [2]=0.25, [3]=0.15}, uses=140, maxlevel=3}
			},
			shovel_large = {
				crumbly={times={[1]=0.30, [2]=0.125, [3]=0.075}, uses=140, maxlevel=3}
			},
			axe_large = {
				choppy={times={[1]=0.85, [2]=0.20, [3]=0.175}, uses=140, maxlevel=3},
				fleshy={times={[2]=0.45, [3]=0.15}, uses=140, maxlevel=2}
			},
			sword_large = {
				fleshy={times={[2]=0.30, [3]=0.10}, uses=140, maxlevel=3},
				snappy={times={[2]=0.30, [3]=0.10}, uses=140, maxlevel=3},
				choppy={times={[3]=0.325}, uses=140, maxlevel=2}
			},
		},
		material = "moreores:gold_ingot"
	},
	silver = {
		tools = {
			pick_med = {
				cracky={times={[1]=1.73, [2]=0.66, [3]=0.40}, uses=150, maxlevel=2}
			},
			shovel_med = {
				crumbly={times={[1]=0.73, [2]=0.26, [3]=0.16}, uses=150, maxlevel=2}
			},
			axe_med = {
				choppy={times={[1]=1.66, [2]=0.53, [3]=0.33}, uses=150, maxlevel=2},
				fleshy={times={[2]=0.73, [3]=0.40}, uses=150, maxlevel=2}
			},
			sword_med = {
				fleshy={times={[2]=0.46, [3]=0.26}, uses=150, maxlevel=2},
				snappy={times={[2]=0.46, [3]=0.26}, uses=150, maxlevel=2},
				choppy={times={[3]=0.53}, uses=150, maxlevel=1}
			},
			pick_large = {
				cracky={times={[1]=1.30, [2]=0.50, [3]=0.40}, uses=200, maxlevel=2}
			},
			shovel_large = {
				crumbly={times={[1]=0.55, [2]=0.20, [3]=0.125}, uses=200, maxlevel=2}
			},
			axe_large = {
				choppy={times={[1]=1.25, [2]=0.40, [3]=0.50}, uses=200, maxlevel=2},
				fleshy={times={[2]=0.55, [3]=0.30}, uses=200, maxlevel=2}
			},
			sword_large = {
				fleshy={times={[2]=0.35, [3]=0.15}, uses=200, maxlevel=2},
				snappy={times={[2]=0.35, [3]=0.15}, uses=200, maxlevel=2},
				choppy={times={[3]=0.40}, uses=200, maxlevel=2}
			},
		},
		material = "moreores:silver_ingot"
	},
	bronze = {
		tools = {
			pick_med = {
				cracky={times={[1]=2.00, [2]=0.80, [3]=0.53}, uses=240, maxlevel=2}
			},
			shovel_med = {
				crumbly={times={[1]=1.00, [2]=0.33, [3]=0.20}, uses=240, maxlevel=2}
			},
			axe_med = {
				choppy={times={[1]=2.00, [2]=0.66, [3]=0.40}, uses=240, maxlevel=2},
				fleshy={times={[2]=0.86, [3]=0.46}, uses=240, maxlevel=2}
			},
			sword_med = {
				fleshy={times={[2]=0.53, [3]=0.26}, uses=240, maxlevel=2},
				snappy={times={[2]=0.53, [3]=0.26}, uses=240, maxlevel=2},
				choppy={times={[3]=0.60}, uses=240, maxlevel=1}
			},
			pick_large = {
				cracky={times={[1]=1.50, [2]=0.60, [3]=0.40}, uses=320, maxlevel=2}
			},
			shovel_large = {
				crumbly={times={[1]=0.75, [2]=0.25, [3]=0.15}, uses=320, maxlevel=2}
			},
			axe_large = {
				choppy={times={[1]=1.50, [2]=0.50, [3]=0.40}, uses=320, maxlevel=2},
				fleshy={times={[2]=0.65, [3]=0.45}, uses=320, maxlevel=2}
			},
			sword_large = {
				fleshy={times={[2]=0.40, [3]=0.20}, uses=320, maxlevel=2},
				snappy={times={[2]=0.40, [3]=0.20}, uses=320, maxlevel=2},
				choppy={times={[3]=0.45}, uses=320, maxlevel=2}
			},
		},
		material = "moreores:bronze_ingot"
	},
	mithril = {
		tools = {
			pick_med = {
				cracky={times={[1]=1.50, [2]=0.36, [3]=0.23}, uses=300, maxlevel=2}
			},
			shovel_med = {
				crumbly={times={[1]=0.46, [2]=0.23, [3]=0.13}, uses=300, maxlevel=2}
			},
			axe_med = {
				choppy={times={[1]=1.16, [2]=0.30, [3]=0.30}, uses=300, maxlevel=2},
				fleshy={times={[2]=0.63, [3]=0.20}, uses=300, maxlevel=2}
			},
			sword_med = {
				fleshy={times={[2]=0.43, [3]=0.16}, uses=300, maxlevel=2},
				snappy={times={[2]=0.46, [3]=0.16}, uses=300, maxlevel=2},
				choppy={times={[3]=0.43}, uses=300, maxlevel=2}
			},
			pick_large = {
				cracky={times={[1]=1.125, [2]=0.275, [3]=0.175}, uses=400, maxlevel=3}
			},
			shovel_large = {
				crumbly={times={[1]=0.35, [2]=0.175, [3]=0.10}, uses=400, maxlevel=3}
			},
			axe_large = {
				choppy={times={[1]=0.875, [2]=0.225, [3]=0.225}, uses=400, maxlevel=3},
				fleshy={times={[2]=0.475, [3]=0.15}, uses=400, maxlevel=3}
			},
			sword_large = {
				fleshy={times={[2]=0.325, [3]=0.125}, uses=400, maxlevel=3},
				snappy={times={[2]=0.35, [3]=0.125}, uses=400, maxlevel=3},
				choppy={times={[3]=0.325}, uses=400, maxlevel=3}
			},
		},
		material = "moreores:mithril_ingot"
	},
	arol = {
		tools = {
			pick_med = {
				cracky={times={[1]=2.00, [2]=0.80, [3]=0.53}, uses=450, maxlevel=2}
			},
			shovel_med = {
				crumbly={times={[1]=1.00, [2]=0.50, [3]=0.30}, uses=450, maxlevel=2}
			},
			axe_med = {
				choppy={times={[1]=2.00, [2]=0.66, [3]=0.46}, uses=450, maxlevel=2},
				fleshy={times={[2]=0.86, [3]=0.46}, uses=450, maxlevel=2}
			},
			sword_med = {
				fleshy={times={[2]=0.66, [3]=0.53}, uses=450, maxlevel=2},
				snappy={times={[2]=0.66, [3]=0.53}, uses=450, maxlevel=2},
				choppy={times={[3]=0.66}, uses=450, maxlevel=1}
			},
			pick_large = {
				cracky={times={[1]=1.50, [2]=0.60, [3]=0.40}, uses=600, maxlevel=3}
			},
			shovel_large = {
				crumbly={times={[1]=0.75, [2]=0.375, [3]=0.225}, uses=600, maxlevel=3}
			},
			axe_large = {
				choppy={times={[1]=1.50, [2]=0.50, [3]=0.35}, uses=600, maxlevel=3},
				fleshy={times={[2]=0.65, [3]=0.35}, uses=600, maxlevel=3}
			},
			sword_large = {
				fleshy={times={[2]=0.50, [3]=0.40}, uses=600, maxlevel=3},
				snappy={times={[2]=0.50, [3]=0.40}, uses=600, maxlevel=3},
				choppy={times={[3]=0.60}, uses=600, maxlevel=2}
			},
		},
		material = "gloopores:arol_ingot"
	},
	alatro = {
		tools = {
			pick_med = {
				cracky={times={[2]=0.43, [3]=0.26}, uses=60, maxlevel=1}
			},
			shovel_med = {
				crumbly={times={[2]=0.40, [3]=0.23}, uses=60, maxlevel=1}
			},
			axe_med = {
				choppy={times={[2]=0.43, [3]=0.26}, uses=60, maxlevel=1},
				fleshy={times={[2]=0.43, [3]=0.26}, uses=60, maxlevel=1}
			},
			sword_med = {
				fleshy={times={[2]=0.53, [3]=0.40}, uses=60, maxlevel=1},
				snappy={times={[2]=0.53, [3]=0.40}, uses=60, maxlevel=1},
				choppy={times={[3]=0.53}, uses=60, maxlevel=0}
			},
			pick_large = {
				cracky={times={[2]=0.325, [3]=0.20}, uses=80, maxlevel=2}
			},
			shovel_large = {
				crumbly={times={[2]=0.30, [3]=0.175}, uses=80, maxlevel=2}
			},
			axe_large = {
				choppy={times={[2]=0.325, [3]=0.20}, uses=80, maxlevel=2},
				fleshy={times={[2]=0.325, [3]=0.20}, uses=80, maxlevel=2}
			},
			sword_large = {
				fleshy={times={[2]=0.40, [3]=0.30}, uses=80, maxlevel=2},
				snappy={times={[2]=0.40, [3]=0.30}, uses=80, maxlevel=2},
				choppy={times={[3]=0.40}, uses=80, maxlevel=1}
			},
		},
		material = "gloopores:alatro_ingot"
	}
}

for matname,def in pairs(matdefs) do
	add_tools(modname, matname, def)
end