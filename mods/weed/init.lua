--[[

Weed mod (based on wheat and baking mods)
VERSION: 0.0.2
LICENSE: GPLv3
TODO: 

]]

PLANTS_GROW_INTERVAL = 120 -- interval in ABMs for plants
PLANTS_GROW_CHANCE = 6 -- chance in ABMs for plants
PLANTS_VISUAL_SCALE = 1.19 -- visualscale for plants



local weed_STATES = {
    '1',
    '2', 
    '3',
    '4',
    '5',
    '6',
    '7',
    --'final',
}
NODES_TO_DELETE_IF_THEY_ABOVE_AIR = {
    "weed:weed_1",
    "weed:weed_2",
    "weed:weed_3",
    "weed:weed_4",
    "weed:weed_5",
    "weed:weed_6",
    "weed:weed_7",
    "weed:weed_final",
    "weed:big_grass",
}

local DIRT_BED_TO_GRASS = {
    "weed:weed_1",
    "weed:weed_2",
    "weed:weed_3",
    "weed:weed_4",
    "weed:weed_5",
    "weed:weed_6",
    "weed:weed_7",
    "weed:weed_final",

}

local LIGHT = 5 -- amount of light neded to weed grow

local check_water = function(pos)
    --[[for x = pos.x - 2, pos.x + 2 do
        for x = pos.z - 2, pos.z + 2 do
            n = minetest.env:get_node_or_nil({x = x, pos.z, z = z})
            if (n == nil) or (n.name == "default:water_source") or (n.name == "default:water_flowing") then
				return true
			end
        end
    end]]
    return true
end
-- ABMs
minetest.register_abm({
    nodenames = {"weed:weed_1","weed:weed_2","weed:weed_3","weed:weed_4",
                                           "weed:weed_5","weed:weed_6","weed:weed_7"},
    interval = PLANTS_GROW_INTERVAL/3*2,
    chance = PLANTS_GROW_CHANCE/2,
        action = function(pos, node, _, __)
            local l = minetest.env:get_node_light(pos, nil)
            local p = pos
            local rnd = math.random(1, 3)
            p.y = p.y - 1 -- it will change pos too, that cause using p.y = p.y + 1
            local under_node = minetest.env:get_node(p)
            if (l >= LIGHT) and (under_node.name == "weed:dirt_bed") and (rnd == 1) then
                local nname  --= 'weed:weed_final' 
                if node.name == "weed:weed_1" then 

                        nname = 'weed:weed_2'

                elseif node.name == "weed:weed_2" then

                        nname = 'weed:weed_3'

                elseif  node.name == 'weed:weed_3' then

                        nname = 'weed:weed_4'

                elseif  node.name == 'weed:weed_4' then

                        nname = 'weed:weed_5'

                elseif  node.name == 'weed:weed_5' then

                        nname = 'weed:weed_6'

                elseif  node.name == 'weed:weed_6' then

                        nname = 'weed:weed_7'
                    
                else nname = 'weed:weed_final' end
                p.y = p.y + 1
                minetest.env:remove_node(pos)
                minetest.env:add_node(pos, { name = nname })
            end
        end
}) 

minetest.register_abm({
    nodenames = NODES_TO_DELETE_IF_THEY_ABOVE_AIR,
    interval = 3,
    chance = 1,
        action = function(pos, node, _, __)
            local p = {x = pos.x,y = pos.y -1,z = pos.z}
            --p.y = p.y - 1 -- it will change pos too, that cause using p.y = p.y + 1
            local under_node = minetest.env:get_node(p)
            if (under_node.name == "air") then
                --p.y = p.y + 1
                minetest.env:remove_node(pos)
                minetest.env:add_node(p, {name = node.name})
            end
        end
})
minetest.register_abm({
    nodenames = "weed:dirt_bed",
    interval = 40,
    chance = 3,
        action = function(pos, node, _, __)
            local p = {x = pos.x,y = pos.y +1,z = pos.z}
            local above_node = minetest.env:get_node(p)

            for i, plant in ipairs(DIRT_BED_TO_GRASS) do
                if (above_node.name == plant) then return; end             
            end
            minetest.env:remove_node(pos)
            minetest.env:add_node(pos, {name = "default:dirt"})
        end
})-- ABMs end

-- Nodes
for i, state in ipairs(weed_STATES) do
    minetest.register_node("weed:weed_" .. state, {
	    drawtype = "plantlike",
        tiles = {"weed_weed_" .. state .. ".png"},
	    inventory_image = "weed_weed_" .. state .. ".png",
	    paramtype = "light",
	    is_ground_content = true,
	    walkable = false,
        material = minetest.digprop_constanttime(0.2),
		drop = {
			items = {
				{
					items = {'weed:weed_nug'},
					rarity = 10,
				},
			},
		},
        wall_mounted = false,
        visual_scale = PLANTS_VISUAL_SCALE,
        selection_box = {
    		type = "fixed",
    		fixed = {-1/2, -1/2, -1/2, 1/2, -0.4, 1/2},
    	},
    })
	-- Fuel
	minetest.register_craft({
		type = "fuel",
		recipe = "weed:weed_" .. state,
		burntime = 2,
	})
end

minetest.register_node("weed:weed_final", {
	    drawtype = "plantlike",
        tiles = {"weed_weed_final.png"},
	    inventory_image = "weed_weed_final.png",
	    paramtype = "light",
	    is_ground_content = true,
	    walkable = false,
        material = minetest.digprop_constanttime(0.25),
		drop = {
			max_items = 1,
			items = {
				{
					items = {'weed:weed_nug 10'},
					rarity = 1.5,
				},
				{
					items = {'weed:weed_nug'},
				}
			}
		},
        wall_mounted = false,
        visual_scale = PLANTS_VISUAL_SCALE,
        selection_box = {
    		type = "fixed",
    		fixed = {-1/2, -1/2, -1/2, 1/2, -0.4, 1/2},
    	},
}) 

minetest.register_node("weed:dirt_bed", {
	description = "Weed dirt bed",
	tiles = {"weed_bed.png", "default_dirt.png"},
	inventory_image = minetest.inventorycube("default_dirt.png"),
	is_ground_content = true,
	material = minetest.digprop_dirtlike(1.0),
	drop = {
		max_items = 1,
		items = {
			{
				items = {'default:dirt'},
			}
		}
	},
})

minetest.register_node("weed:big_grass", {
	    drawtype = "plantlike",
	    paramtype = "facedir_simple",
        tiles = {"weed_big_grass.png"},
	    inventory_image = "weed_big_grass.png",
	    paramtype = "light",
	    is_ground_content = true,
	    walkable = false,
        material = minetest.digprop_constanttime(0.1),
		drop = {
			max_items = 1,
			items = {
				{
					items = {'weed:weed_nug'},
					rarity = 10,
				},
			},
		},
        visual_scale = PLANTS_VISUAL_SCALE,
        selection_box = {
    		type = "fixed",
    		fixed = {-1/2, -1/2, -1/2, 1/2, -0.3, 1/2},
    	},
})-- Nodes end

-- Craftitems
minetest.register_craftitem("weed:weed_nug", {
	description = "weed nug (and seeds)",
    image = "weed_weed_nug.png",
    stack_max = 99,
    usable = true,
    dropcount = 10,
    liquids_pointable = false,
    on_place = minetest.item_place,
    on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "weed:dirt_bed" then
				minetest.env:add_node(pointed_thing.above, {name="weed:weed_1"})
				item:take_item()
			end
		end
		return item
	end,
}) -- Craftitems end

-- Fuel
minetest.register_craft({
    type = "fuel",
    recipe = "weed:weed_nug",
    burntime = 1,
})
	
minetest.register_craft({
    type = "fuel",
    recipe = "weed:big_grass",
    burntime = 2,
})

minetest.register_craft({
    type = "fuel",
    recipe = "weed:weed_final",
    burntime = 2,
})

minetest.register_craft({ --TODO: find a better recipe
    output = 'node "weed:dirt_bed" 2',
    recipe = {
        {'node "default:dirt" 1', 'node "default:sand" 1', 'node "default:dirt" 1'},
    },
})

------

minetest.register_craftitem("weed:flour", {
	image = "weed_flour.png",
	on_place = minetest.item_place
})

minetest.register_craftitem("weed:brownie", {
	image = "weed_brownie.png",
	on_place = minetest.item_place,
	on_use = minetest.item_eat(6)
})

minetest.register_craftitem("weed:brownie_dough", {
	image = "weed_brownie_dough.png",
	on_place = minetest.item_place,
})

minetest.register_craft({
	output = 'weed:flour 1',
	recipe = {
		{'wheat:wheat_seeds', 'wheat:wheat_seeds'},
		{'wheat:wheat_seeds', 'wheat:wheat_seeds'},
	}
})

minetest.register_craft({
	output = 'weed:brownie_dough 1',
	recipe = {
		{'weed:flour', 'weed:flour', 'weed:flour'},
		{'weed:flour', 'weed:weed_form_water', 'weed:flour'},
		{'weed:flour', 'weed:flour', 'weed:flour'},
	}
})

minetest.register_craft({
	output = 'weed:weed_form_empty 1',
	recipe = {
		{'default:wood', '', 'default:wood'},
		{'default:wood', 'default:wood', 'default:wood'},
	}
})

minetest.register_craftitem("weed:weed_form_empty", {
	description = "Empty weed form",
	image = "weed_weed_form.png",
	stack_max = 1,
	liquids_pointable = true,
	on_place = minetest.item_place,
	on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "default:water_source" then
				minetest.env:add_node(pointed_thing.under, {name="air"})
				local leftover = player:get_inventory():add_item("main", ItemStack('weed:weed_form_water 1'))
				if leftover:is_empty() then
					item:take_item()
				else
					minetest.chat_send_player(player:get_player_name(), 'Not enough space in inventory!')
				end
			end
		end
		return item
	end,
})

minetest.register_craftitem("weed:weed_form_water", {
	description = "weed form with water",
	image = "weed_weed_form_water.png",
	stack_max = 1,
	liquids_pointable = true,
	on_place = minetest.item_place,
	on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "default:water_source" then
				-- unchanged
			elseif n.name == "default:lava_source" or n.name == "default:lava_flowing" then
				minetest.env:add_node(pointed_thing.under, {name="default:cobble"})
			else
				minetest.env:add_node(pointed_thing.above, {name="default:water_flowing"})
			end
			local leftover = digger:get_inventory():add_item("main", ItemStack('weed:weed_form_empty 1'))
			if leftover:is_empty() then
				item:take_item()
			else
				minetest.chat_send_player(digger:get_player_name(), 'Not enough space in inventory!')
			end
		end
		return item
	end,
})

minetest.register_craft({
    type = "cooking",
    output = "weed:brownie",
    recipe = "weed:brownie_dough",
    cooktime = 10,
	replacements = {
        {"weed:brownie_dough", "weed:weed_form_empty"},  --- this is not work!!!
    },
})

print("[weed mod] Loaded!")
