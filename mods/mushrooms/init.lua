--[[

Bugs thats needed to fix:
    * all mushrooms:spores_**** are make brown mushrooms =(
    * optimization is fucking bad
]]
math.randomseed(os.time())

local SPORE_DIG_RARITY = 100
local NEEDED_LIGHT = 10 
local MUSHROOMS_GROW_INTERVAL = 120
local SPORING_INTERVAL = 360
local CHANCE = 3


--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
local PLUS_MINECRAFT_LIKE_GROW = false -- WRONG!!! BAD!!! NAHUI NE NUZHNO!!!|
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^--+

local MUSHROOMS = {
    "red",
    "white",
    "brown",
}

local GROW_NORMAL_NODES = { -- for MINECRAFTLIKE GROW 
    "default:dirt_with_grass",
    "default:dirt",
    "default:stone",
    "default:cobble",
    "default:mossycobble",
}

local function lol(node) -- ololo
    for _, node_name in ipairs(GROW_NORMAL_NODES) do
        if node.name == node_name then return true end
    end
end

local function lol_m(node) -- ololo
    for _, node_name in ipairs(MUSHROOMS) do
        if node.name == "mushrooms:dirt_spored_mushroom_" .. node_name then return true end
        return false
    end
end

-- Nodes
minetest.register_node(":default:dirt", {
	tiles = {"default_dirt.png"},
	inventory_image = minetest.inventorycube("default_dirt.png"),
	is_ground_content = true,
	material = minetest.digprop_dirtlike(1.0),
    extra_drop = 'craft "mushrooms:spores" 1',
    extra_drop_rarity = SPORE_DIG_RARITY,
})

for _, color in ipairs(MUSHROOMS) do
    mname = "mushroom_" .. color
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    minetest.register_node( "mushrooms:" .. mname, {
	    drawtype = "plantlike",
        tiles = {"mushrooms_" .. mname .. ".png"},
	    inventory_image = "mushrooms_" .. mname .. ".png",
	    paramtype = "light",
	    is_ground_content = true,
        sunlight_propagates = true,
	    walkable = false,
        material = minetest.digprop_constanttime(0.4),
	    furnace_burntime = -1,
        wall_mounted = false,
        visual_scale = 1.0,
        selection_box = {
    		type = "fixed",
    		fixed = {-1/5, -1/2, -1/5, 1/5, 1/40, 1/5},
    	},
    }) 
-->->->->->->->->->->->->->->->->->->->
    minetest.register_node("mushrooms:dirt_spored_" .. mname , {
	    tiles = {"default_dirt.png^mushrooms_dirt_spored.png"},
	    inventory_image = minetest.inventorycube("default_dirt.png^mushrooms_dirt_spored.png"),
    	is_ground_content = true,
	    walkable = true,
	    cookresult_itemstring = 'node "default:dirt" 1',
	    material = minetest.digprop_dirtlike(1.6),
        extra_drop = 'craft "mushrooms:spores_' .. mname .. '" 1',
        extra_drop_rarity = 2,
    })
-->->->->->->->->->->->->->->->->->->->
    minetest.register_node("mushrooms:cobble_spored_" .. mname , {
	    tiles = {"default_cobble.png^mushrooms_dirt_spored.png"},
	    inventory_image = minetest.inventorycube("default_cobble.png^mushrooms_dirt_spored.png"),
	    is_ground_content = true,
	    walkable = true,
	    cookresult_itemstring = 'node "stone" 1',
	    material = minetest.digprop_stonelike(1.5),
        extra_drop = 'craft "mushrooms:spores_' .. mname .. '" 1',
        extra_drop_rarity = 2,
    })
-->->->->->->->->->->->->->->->->->->->
    minetest.register_node("mushrooms:dirt_with_grass_spored_" .. mname , {
    	tiles = {"default_grass.png", "default_dirt.png^mushrooms_dirt_spored.png", "default_dirt.png^mushrooms_dirt_spored.png^default_grass_side.png"},
    	inventory_image = minetest.inventorycube("default_dirt.png^mushrooms_dirt_spored.png^default_grass_side.png"),
    	is_ground_content = true,
	    walkable = true,
	    cookresult_itemstring = 'node "default:dirt" 1',
    	material = minetest.digprop_dirtlike(1.6),
        extra_drop = 'craft "mushrooms:spores_' .. mname .. '" 1',
        extra_drop_rarity = 2,
    })
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
end-- Nodes end

-- ABMs
for _, color in ipairs(MUSHROOMS) do
    mname = "mushrooms:mushroom_" .. color
--+++++++++++++++++++++++++++++++++++++
    if PLUS_MINECRAFT_LIKE_GROW == true then -- PLUS_MINECRAFT_LIKE_GROW
    minetest.register_abm({  -- WRONG GROW STYLE !!!!!!!1111111111!!!!!!!!!!!!!!!!!!!!!1111!1111111111!!!!!!11111111!
        nodenames = mname,
        interval = MUSHROOMS_GROW_INTERVAL,
        chance = CHANCE,
            action = function(pos, node, _, __)
                local l = minetest.env:get_node_light({x = pos.x,y=pos.y+1,z=pos.z}, nil)
                local p = pos
                local under_node = minetest.env:get_node({x = pos.x, y = pos.y-1, z = pos.z})
                if lol(under_node) and (l >= (NEEDED_LIGHT)) then
                    local rnd = math.random(1, 12)
                    local new_m_pos
                        if rnd == 1 then
                            new_m_pos = {x = pos.x+1, y = pos.y, z = pos.z}
                        elseif rnd == 2 then
                            new_m_pos = {x = pos.x-1, y = pos.y, z = pos.z}
                        elseif rnd == 3 then
                            new_m_pos = {x = pos.x, y = pos.y, z = pos.z+1}
                        elseif rnd == 4 then
                            new_m_pos = {x = pos.x, y = pos.y, z = pos.z-1}
                        elseif rnd == 5 then
                            new_m_pos = {x = pos.x+1, y = pos.y, z = pos.z+1}
                        elseif rnd == 6 then
                            new_m_pos = {x = pos.x-1, y = pos.y, z = pos.z+1}
                        elseif rnd == 7 then
                            new_m_pos = {x = pos.x+1, y = pos.y, z = pos.z-1}
                        elseif rnd == 8 then 
                            new_m_pos = {x = pos.x-1, y = pos.y, z = pos.z-1}
                        else return 0; end

                            local try_node = minetest.env:get_node(new_m_pos)
                        --------
                            local new_m_pos_under = {x = new_m_pos.x, y = pos.y - 1, z = new_m_pos.z}
                            local try_node_under = minetest.env:get_node(new_m_pos_under)
                        --------  

                            local new_m_pos_under_under = {x = new_m_pos.x, y = pos.y - 2, z = new_m_pos.z}
                            local try_node_under_under = minetest.env:get_node(new_m_pos_under_under)
                        --------
                            local new_m_pos_above = {x = new_m_pos.x, y = pos.y + 1, z = new_m_pos.z}
                            local try_node_above = minetest.env:get_node(new_m_pos_above)
                        --------
                            local nname = node.name
                            if (try_node.name == "air") and lol(try_node_under) then
                                minetest.env:add_node(new_m_pos, { name = nname })
                            elseif (try_node_above.name == "air") and lol(try_node) then
                                minetest.env:add_node(new_m_pos_above, { name = nname })
                            elseif (try_node_under.name == "air") and lol(try_node_under_under) then
                                minetest.env:add_node(new_m_pos_under, { name = nname }) --end
                            end
                end
            end
    })
    end -- PLUS_MINECRAFT_LIKE_GROW
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    minetest.register_abm({
        nodenames = {   "mushrooms:dirt_spored_mushroom_" .. color, 
                        "mushrooms:cobble_spored_mushroom_" .. color,
                        "mushrooms:dirt_with_grass_spored_mushroom_" .. color},
        interval = MUSHROOMS_GROW_INTERVAL,
        chance = CHANCE,
            action = function(pos, node, _, __)
if (math.random(1,20) >1) then return 0; end
                local p_above = {x = pos.x, y = pos.y + 1, z = pos.z}
                local n_above = minetest.env:get_node(p_above)
                local l = minetest.env:get_node_light({x = pos.x,y=pos.y+1,z=pos.z}, nil)
                if (n_above.name == "air") and (l >= NEEDED_LIGHT) then
                    --rnd = math.random(1, 10)
                    --if 1 == 1 then
                        minetest.env:remove_node(p_above)
                        minetest.env:add_node(p_above,{name = "mushrooms:mushroom_" .. color,})
                    --end
                end
            end
    })

    minetest.register_abm({
        nodenames = "mushrooms:dirt_spored_mushroom_" .. color,
        interval = SPORING_INTERVAL,
        chance = CHANCE,
            action = function(pos, node, _, __)
if (math.random(1,5) > 1) then return 0; end
                local p = pos
                local p_above = {x = pos.x, y = pos.y + 1, z = pos.z}
                local n_above = minetest.env:get_node(p_above)
                local l = minetest.env:get_node_light({x = pos.x,y=pos.y+1,z=pos.z}, nil)
                local l_above = minetest.env:get_node_light({x = pos.x,y=pos.y+2,z=pos.z}, nil)

                local function replace_node(pos,node_name)
                    minetest.env:remove_node(pos)
                    minetest.env:add_node(pos,{name = node_name})
                end

                if n_above.name ~= "air" and n_above.name ~= "mushrooms:dirt_spored_mushroom_" .. color and
                        n_above.name ~= "mushrooms:dirt_with_grass_spored_mushroom_" .. color and
                        n_above.name ~= "mushrooms:cobble_spored_mushroom_" .. color and
                        n_above.name ~= "mushrooms:mushroom_" .. color
                       
                        then replace_node(p,"default:dirt")
                        return true
                        

                elseif (l >= NEEDED_LIGHT)then
                    local new_p
                    local rnd = math.random(1,5)
                    if rnd == 1 then new_p = {x = pos.x+1, y = pos.y, z = pos.z}
                    elseif rnd == 2 then new_p = {x = pos.x-1, y = pos.y, z = pos.z}
                    elseif rnd == 3 then new_p = {x = pos.x, y = pos.y, z = pos.z-1}
                    elseif rnd == 4 then new_p = {x = pos.x, y = pos.y, z = pos.z+1}
                    else new_p = {x = pos.x, y = pos.y - 1, z = pos.z} end
                    local new_n = minetest.env:get_node(new_p)

                    if (new_n.name == "default:dirt_with_grass") then 
                        replace_node(new_p,"mushrooms:dirt_with_grass_spored_mushroom_" .. color)
                    elseif new_n.name == "default:dirt" then 
                        replace_node(new_p,"mushrooms:dirt_spored_mushroom_" .. color)
                    elseif new_n.name == "default:cobble" then 
                        replace_node(new_p,"mushrooms:cobble_spored_mushroom_" .. color)
                    end
                    return true
                elseif (l_above >= NEEDED_LIGHT)then
                    local new_p
                    local rnd = math.random(1,4)
                    if rnd == 1 then new_p = {x = pos.x+1, y = pos.y, z = pos.z}
                    elseif rnd == 2 then new_p = {x = pos.x-1, y = pos.y, z = pos.z}
                    elseif rnd == 3 then new_p = {x = pos.x, y = pos.y, z = pos.z-1}
                    else new_p = {x = pos.x, y = pos.y, z = pos.z+1} end
                    local new_n = minetest.env:get_node(new_p)

                    if (new_n.name == "default:dirt_with_grass") then 
                        replace_node(new_p,"mushrooms:dirt_with_grass_spored_mushroom_" .. color)
                    elseif new_n.name == "default:dirt" then 
                        replace_node(new_p,"mushrooms:dirt_spored_mushroom_" .. color)
                    elseif new_n.name == "default:cobble" then 
                        replace_node(new_p,"mushrooms:cobble_spored_mushroom_" .. color)
                    end
                    return true
                end
            end
    })
    minetest.register_abm({
        nodenames = "mushrooms:cobble_spored_mushroom_" .. color,
        interval = SPORING_INTERVAL,
        chance = CHANCE,
            action = function(pos, node, _, __)
if (math.random(1,5) > 1) then return 0; end
                local p = pos
                local p_above = {x = pos.x, y = pos.y + 1, z = pos.z}
                local n_above = minetest.env:get_node(p_above)
                local l = minetest.env:get_node_light({x = pos.x,y=pos.y+1,z=pos.z}, nil)
                local l_above = minetest.env:get_node_light({x = pos.x,y=pos.y+2,z=pos.z}, nil)

                local function replace_node(pos,node_name)
                    minetest.env:remove_node(pos)
                    minetest.env:add_node(pos,{name = node_name})
                end

                if n_above.name ~= "air" and n_above.name ~= "mushrooms:dirt_spored_mushroom_" .. color and
                        n_above.name ~= "mushrooms:dirt_with_grass_spored_mushroom_" .. color and
                        n_above.name ~= "mushrooms:cobble_spored_mushroom_" .. color and
                        n_above.name ~= "mushrooms:mushroom_" .. color
                       
                        then replace_node(p,"default:cobble")
                        return true
                        

                elseif (l >= NEEDED_LIGHT)then
                    local new_p
                    local rnd = math.random(1,5)
                    if rnd == 1 then new_p = {x = pos.x+1, y = pos.y, z = pos.z}
                    elseif rnd == 2 then new_p = {x = pos.x-1, y = pos.y, z = pos.z}
                    elseif rnd == 3 then new_p = {x = pos.x, y = pos.y, z = pos.z-1}
                    elseif rnd == 4 then new_p = {x = pos.x, y = pos.y, z = pos.z+1}
                    else new_p = {x = pos.x, y = pos.y - 1, z = pos.z} end
                    local new_n = minetest.env:get_node(new_p)

                    if (new_n.name == "default:dirt_with_grass") then 
                        replace_node(new_p,"mushrooms:dirt_with_grass_spored_mushroom_" .. color)
                    elseif new_n.name == "default:dirt" then 
                        replace_node(new_p,"mushrooms:dirt_spored_mushroom_" .. color)
                    elseif new_n.name == "default:cobble" then 
                        replace_node(new_p,"mushrooms:cobble_spored_mushroom_" .. color)
                    end
                    return true
                elseif (l_above >= NEEDED_LIGHT)then
                    local new_p
                    local rnd = math.random(1,4)
                    if rnd == 1 then new_p = {x = pos.x+1, y = pos.y, z = pos.z}
                    elseif rnd == 2 then new_p = {x = pos.x-1, y = pos.y, z = pos.z}
                    elseif rnd == 3 then new_p = {x = pos.x, y = pos.y, z = pos.z-1}
                    else new_p = {x = pos.x, y = pos.y, z = pos.z+1} end
                    local new_n = minetest.env:get_node(new_p)

                    if (new_n.name == "default:dirt_with_grass") then 
                        replace_node(new_p,"mushrooms:dirt_with_grass_spored_mushroom_" .. color)
                    elseif new_n.name == "default:dirt" then 
                        replace_node(new_p,"mushrooms:dirt_spored_mushroom_" .. color)
                    elseif new_n.name == "default:cobble" then 
                        replace_node(new_p,"mushrooms:cobble_spored_mushroom_" .. color)
                    end
                    return true
                end
            end
    })
    minetest.register_abm({
        nodenames = "mushrooms:dirt_with_grass_spored_mushroom_" .. color,
        interval = SPORING_INTERVAL,
        chance = CHANCE,
            action = function(pos, node, _, __)
if (math.random(1,5) > 1) then return 0; end
                local p = pos
                local p_above = {x = pos.x, y = pos.y + 1, z = pos.z}
                local n_above = minetest.env:get_node(p_above)
                local l = minetest.env:get_node_light({x = pos.x,y=pos.y+1,z=pos.z}, nil)
                local l_above = minetest.env:get_node_light({x = pos.x,y=pos.y+2,z=pos.z}, nil)

                local function replace_node(pos,node_name)
                    minetest.env:remove_node(pos)
                    minetest.env:add_node(pos,{name = node_name})
                end

                if n_above.name ~= "air" and n_above.name ~= "mushrooms:dirt_spored_mushroom_" .. color and
                        n_above.name ~= "mushrooms:dirt_with_grass_spored_mushroom_" .. color and
                        n_above.name ~= "mushrooms:cobble_spored_mushroom_" .. color and
                        n_above.name ~= "mushrooms:mushroom_" .. color
                       
                        then replace_node(p,"default:dirt_with_grass")
                        return true
                        

                elseif (l >= NEEDED_LIGHT)then
                    local new_p
                    local rnd = math.random(1,5)
                    if rnd == 1 then new_p = {x = pos.x+1, y = pos.y, z = pos.z}
                    elseif rnd == 2 then new_p = {x = pos.x-1, y = pos.y, z = pos.z}
                    elseif rnd == 3 then new_p = {x = pos.x, y = pos.y, z = pos.z-1}
                    elseif rnd == 4 then new_p = {x = pos.x, y = pos.y, z = pos.z+1}
                    else new_p = {x = pos.x, y = pos.y - 1, z = pos.z} end
                    local new_n = minetest.env:get_node(new_p)

                    if (new_n.name == "default:dirt_with_grass") then 
                        replace_node(new_p,"mushrooms:dirt_with_grass_spored_mushroom_" .. color)
                    elseif new_n.name == "default:dirt" then 
                        replace_node(new_p,"mushrooms:dirt_spored_mushroom_" .. color)
                    elseif new_n.name == "default:cobble" then 
                        replace_node(new_p,"mushrooms:cobble_spored_mushroom_" .. color)
                    end
                    return true
                elseif (l_above >= NEEDED_LIGHT)then
                    local new_p
                    local rnd = math.random(1,4)
                    if rnd == 1 then new_p = {x = pos.x+1, y = pos.y, z = pos.z}
                    elseif rnd == 2 then new_p = {x = pos.x-1, y = pos.y, z = pos.z}
                    elseif rnd == 3 then new_p = {x = pos.x, y = pos.y, z = pos.z-1}
                    else new_p = {x = pos.x, y = pos.y, z = pos.z+1} end
                    local new_n = minetest.env:get_node(new_p)

                    if (new_n.name == "default:dirt_with_grass") then 
                        replace_node(new_p,"mushrooms:dirt_with_grass_spored_mushroom_" .. color)
                    elseif new_n.name == "default:dirt" then 
                        replace_node(new_p,"mushrooms:dirt_spored_mushroom_" .. color)
                    elseif new_n.name == "default:cobble" then 
                        replace_node(new_p,"mushrooms:cobble_spored_mushroom_" .. color)
                    end
                    return true
                end
            end
    })
--[[
    minetest.register_abm({
        nodenames = "mushrooms:dirt_spored_mushroom_" .. color,
        interval = MUSHROOMS_GROW_INTERVAL/2,
        chance = CHANCE,
            action = function(pos, node, _, __)
                p = {x = pos.x, y = pos.y+1, z = pos.z}
                n = minetest.env:get_node(p)

                if not lol_m(n) then
                        minetest.env:remove_node(pos)
                        minetest.env:add_node(pos,{name = "mushrooms:dirt_with_grass_spored_mushroom_" .. color,})
                end
            end
    })]]
end-- ABMs end

-- CraftItems
minetest.register_craftitem("mushrooms:spores", {
    image = "mushrooms_spores.png",
    stack_max = 99,
    --cookresult_itemstring = itemstring (result of cooking),
    --furnace_cooktime = <cooking time>,
    furnace_burntime = -1,
    usable = true,
    dropcount = 10,
    liquids_pointable = false,
    on_place_on_ground = minetest.craftitem_place_item,
    on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
            p = pointed_thing.under
			n = minetest.env:get_node(p)
            --p = {x = p.x, y = p.y, z = p.z}
			if n.name == "default:dirt" then
				minetest.env:remove_node(p)
                rnd = math.random(1, 3)
                if rnd == 1 then minetest.env:add_node(p, {name="mushrooms:dirt_spored_mushroom_red"})
                elseif rnd == 2 then minetest.env:add_node(p, {name="mushrooms:dirt_spored_mushroom_brown"})
				else minetest.env:add_node(p, {name="mushrooms:dirt_spored_mushroom_white"}) end
				return true
			elseif n.name == "default:dirt_with_grass" then
                minetest.env:remove_node(p)
                rnd = math.random(1, 3)
                if rnd == 1 then minetest.env:add_node(p, {name="mushrooms:dirt_with_grass_spored_mushroom_red"})
                elseif rnd == 2 then minetest.env:add_node(p, {name="mushrooms:dirt_with_grass_spored_mushroom_brown"})
				else minetest.env:add_node(p, {name="mushrooms:dirt_with_grass_spored_mushroom_white"}) end
				return true
            elseif n.name == "default:cobble" then
				minetest.env:remove_node(p)
                rnd = math.random(1, 3)
                if rnd == 1 then minetest.env:add_node(p, {name="mushrooms:cobble_spored_mushroom_red"})
                elseif rnd == 2 then minetest.env:add_node(p, {name="mushrooms:cobble_spored_mushroom_brown"})
				else minetest.env:add_node(p, {name="mushrooms:cobble_spored_mushroom_white"}) end
				return true
            end
		end
		return false
	end,
}) 
for _, color in ipairs(MUSHROOMS) do
    mname = "mushroom_" .. color

    minetest.register_craftitem("mushrooms:spores_" .. mname, {
        image = "mushrooms_spores.png",
        stack_max = 99,
        --cookresult_itemstring = itemstring (result of cooking),
        --furnace_cooktime = <cooking time>,
        furnace_burntime = -1,
        usable = true,
        dropcount = 10,
        liquids_pointable = false,
        on_place_on_ground = minetest.craftitem_place_item,
        on_use = function(item, player, pointed_thing)
	    	if pointed_thing.type == "node" then
                p = pointed_thing.under
	    		n = minetest.env:get_node(p)
                --p = {x = p.x, y = p.y, z = p.z}
	    		if n.name == "default:dirt" then
	    			minetest.env:remove_node(p)
                    minetest.env:add_node(p, {name="mushrooms:dirt_spored_" .. mname})
	    			return true
	    		elseif n.name == "default:dirt_with_grass" then
	    			minetest.env:remove_node(p)
                    minetest.env:add_node(p, {name="mushrooms:dirt_with_grass_spored_" .. mname})
	    			return true
                elseif n.name == "default:cobble" then
	    			minetest.env:remove_node(p)
                    minetest.env:add_node(p, {name="mushrooms:cobble_spored_" .. mname})
	    			return true
                end
	    	end
	    	return false
	    end,
    })
end-- CraftItems end

-- Recipes
for _, color in ipairs(MUSHROOMS) do
    minetest.register_craft({
	    output = 'craft "mushrooms:spores_mushroom_' .. color .. '" 1', 
	    recipe = {
		    {'node "mushrooms:mushroom_'.. color .. '" 1',},
	    }
    })
end -- Recipes


local spored_dirt_gen = function( minp, maxp )
			local pos = {
				x = math.random( minp.x, maxp.x ),
				y = math.random( minp.y, maxp.y ),
				z = math.random( minp.z, maxp.z ),
			}
						if math.random(1,5) > 1 then return true
						else
							local n = minetest.env:get_node( pos )
							if n.name == "default:dirt_with_grass" then
print("Pumpkin generated above " .. pos.x .. ' ' .. pos.y .. ' ' .. pos.z)
                            local rnd = math.random(1,3)
                            if (rnd == 1) then 
								minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z}, { name = "mushrooms:dirt_with_grass_spored_mushroom_red" } )
minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z}, { name = "mushrooms:mushroom_red" } )
print("Spored " .. pos.x .. ' ' .. pos.y+1 .. ' ' .. pos.z .. ":red mushrooms")
                            elseif(rnd == 2) then
								minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z}, { name = "mushrooms:dirt_with_grass_spored_mushroom_white" } )
minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z}, { name = "mushrooms:mushroom_white" } )

print("Spored " .. pos.x .. ' ' .. pos.y .. ' ' .. pos.z .. ":white mushrooms")
                            else 
								minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z}, { name = "mushrooms:dirt_with_grass_spored_mushroom_brown" } )

minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z}, { name = "mushrooms:mushroom_brown" } )

print("Spored " .. pos.x .. ' ' .. pos.y .. ' ' .. pos.z .. ":brown mushrooms")
                            end

							end
						end
end


minetest.register_on_generated( spored_dirt_gen )


print("[Mushrooms] Loaded!")
