math.randomseed(os.time())
--[[

Author: Victor Hackeridze hackeridze@gmail.com
VERSION: 0.1
LICENSE: GPLv3
TODO:

]]

local BOWL = 'craft "baking:baking_form_water" 1'
local LIGHT = 8

local CORN_SPROUT_STATES = {
    '1',
    '2', 
    '3',
}
--local pr_state = '5'
local CORN_COB_STATES = {
    '1',
    '2', 
    '3',
    '4',
}
--local final_state = '5'
-- ABMs
for i, state in ipairs(CORN_SPROUT_STATES) do
    minetest.register_abm({
        nodenames = {"hruschev:corn_sprout_" .. state,},
        interval = 60,
        chance = 2,
            action = function(pos, node, _, __)
if (node.param2 == 1) then return; end

                --local l = minetest.env:get_node_light(pos, nil)
                --local under = {x = pos.x, y = pos.y-1, z = pos.z}
                --local under_ = {x = pos.x, y = pos.y-2, z = pos.z}
                --if (l > LIGHT) then
                    minetest.env:remove_node(pos)
                    minetest.env:add_node(pos, {name = "hruschev:corn_sprout_" .. state + 1})
                node.param2 = 1
                --end

            end
    }) 
    minetest.register_abm({
        nodenames = {"hruschev:corn_sprout_cob_" .. state,},
        interval = 80,
        chance = 1,
            action = function(pos, node, _, __)
if (node.param2 == 1) then return; end

                local l = minetest.env:get_node_light(pos, nil)
                --local under = {x = pos.x, y = pos.y-1, z = pos.z}
                --local under_ = {x = pos.x, y = pos.y-2, z = pos.z}
                if (l > LIGHT) then
                    minetest.env:remove_node(pos)
                    minetest.env:add_node(pos, {name = "hruschev:corn_sprout_cob_" .. state + 1})
                node.param2 = 1
                end

            end
    }) 
end 
minetest.register_abm({
    nodenames = {"hruschev:corn_sprout_4",},
    interval = 90,
    chance = 1,
        action = function(pos, node, _, __)
if (math.random(1,3) > 1) then  return; end
if (node.param2 == 1) then  return; end
            local l = minetest.env:get_node_light(pos, nil)
            local above = {x = pos.x, y = pos.y+1, z = pos.z}
            local n_a = minetest.env:get_node(above)
if (l > LIGHT) then 
            local under = {x = pos.x, y = pos.y-1, z = pos.z}
            local under_ = {x = pos.x, y = pos.y-2, z = pos.z}
            local n_u = minetest.env:get_node(under)
            local n_u_ = minetest.env:get_node(under_)

            if ((n_u_.name == "hruschev:corn_sprout_5") and (n_u.name == "hruschev:corn_sprout_5") 
                        and (n_a.name == "air")) then
                minetest.env:remove_node(pos)
                minetest.env:add_node(pos, {name = "hruschev:corn_sprout_5"})
                minetest.env:add_node(above, {name = "hruschev:corn_sprout_cob_1"})
                node.param2 = 1
            elseif ((n_a.name == "air")) then
                minetest.env:remove_node(pos)
                minetest.env:add_node(pos, {name = "hruschev:corn_sprout_5"})
                minetest.env:add_node(above, {name = "hruschev:corn_sprout_1"})
                node.param2 = 1
            end
elseif ((n_a.name == "air")) then
                minetest.env:remove_node(pos)
                minetest.env:add_node(pos, {name = "hruschev:corn_sprout_5"})
                minetest.env:add_node(above, {name = "hruschev:corn_sprout_1"})
                node.param2 = 1
end
        end
    })
for i, state in ipairs(CORN_COB_STATES) do
    minetest.register_abm({
        nodenames = {"hruschev:corn_sprout_cob_" .. state,},
        interval = 70,
        chance = 1,
            action = function(pos, node, _, __)
if (node.param2 == 1) then return; end

                local l = minetest.env:get_node_light(pos, nil)
                --local under = {x = pos.x, y = pos.y-1, z = pos.z}
                --local under_ = {x = pos.x, y = pos.y-2, z = pos.z}
                if (l > LIGHT) then
                    minetest.env:remove_node(pos)
                    minetest.env:add_node(pos, {name = "hruschev:corn_sprout_cob_" .. state + 1})
                node.param2 = 1
                end

            end
    })
end
--[[
local function check(pos)
    for i = 1, 10 do
        local p = {x = pos.x,y=pos.y+i,z=pos.z}
        local n = minetest.env:get_node(p)
        if (n.name ~= "hruschev:corn_sprout_5" or ) and ((n.name == "hruschev:corn_sprout_%a") or (n.name == "hruschev:corn_sprout_cob_%a")) then return false; end
    end
    return true;
end
minetest.register_abm({
        nodenames = {"hruschev:corn_sprout_5",},
        interval = 10,
        chance = 0.5,
            action = function(pos, node, _, __)
                if (check(pos) == true) then
                    minetest.env:remove_node(pos)
                end
            end
})]] -- ABMs end

-- Nodes
for i, state in ipairs(CORN_SPROUT_STATES) do
    minetest.register_node("hruschev:corn_sprout_" .. state, {
	drawtype = "plantlike",
	tiles = {"corn_sprout_" .. state .. ".png"},
	inventory_image = "corn_sprout_" .. state .. ".png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	material = minetest.digprop_constanttime(0.3),
	furnace_burntime = 2,
	drop = "",
	wall_mounted = false,
    visual_scale = 1,
        selection_box = {
    		type = "fixed",
    		fixed = {-0.1, -1/2, -0.1, 0.1, 1/2, 0.1},
    	},
    param2 = 0
    })
end
    minetest.register_node("hruschev:corn_sprout_5", {
	drawtype = "plantlike",
	tiles = {"corn_sprout_5.png"},
	inventory_image = "corn_sprout_5.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	material = minetest.digprop_constanttime(0.3),
	furnace_burntime = 2,
	drop = "",
	wall_mounted = false,
    visual_scale = 1,
        selection_box = {
    		type = "fixed",
    		fixed = {-0.1, -1/2, -0.1, 0.1, 1/2, 0.1},
    	},
    param2 = 0
    })
    minetest.register_node("hruschev:corn_sprout_4", {
	drawtype = "plantlike",
	tiles = {"corn_sprout_4.png"},
	inventory_image = "corn_sprout_4.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	material = minetest.digprop_constanttime(0.3),
	furnace_burntime = 2,
	drop = "",
	wall_mounted = false,
    visual_scale = 1,
        selection_box = {
    		type = "fixed",
    		fixed = {-0.1, -1/2, -0.1, 0.1, 1/2, 0.1},
    	},
    param2 = 0
    })
for i, state in ipairs(CORN_COB_STATES) do
    minetest.register_node("hruschev:corn_sprout_cob_" .. state, {
	drawtype = "plantlike",
	tiles = {"corn_sprout_cob_" .. state .. ".png"},
	inventory_image = "corn_sprout_cob_" .. state .. ".png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	material = minetest.digprop_constanttime(0.3),
	furnace_burntime = 2,
	drop = "",
	wall_mounted = false,
    visual_scale = 1,
        selection_box = {
    		type = "fixed",
    		fixed = {-0.15, -1/2, -0.15, 0.15, 1/2, 0.15},
    	},
    param2 = 0
    })
end 
    minetest.register_node("hruschev:corn_sprout_cob_5", {
	drawtype = "plantlike",
	tiles = {"corn_sprout_cob_5.png"},
	inventory_image = "corn_sprout_cob_5.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	material = minetest.digprop_constanttime(0.3),
	furnace_burntime = 2,
	drop = 'craft "hruschev:corn_cob" 1',
	wall_mounted = false,
    visual_scale = PLANTS_VISUAL_SCALE,
    param2 = 0,
        selection_box = {
    		type = "fixed",
    		fixed = {-0.15, -1/2, -0.15, 0.15, 1/2, 0.15},
    	},
})-- Nodes end


-- Craftitems
minetest.register_craftitem("hruschev:corn_seeds", {
    image = "corn_seeds.png",
    stack_max = 99,
    --cookresult_itemstring = itemstring (result of cooking),
    --furnace_cooktime = <cooking time>,
    furnace_burntime = -1,
    usable = true,
    liquids_pointable = false,
	cookresult_itemstring = 'craft "hruschev:popcorn" 5',
	furnace_cooktime = 10.0,
    on_place_on_ground = minetest.craftitem_place_item,
    on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "wheat:dirt_bed" then
				minetest.env:add_node(pointed_thing.above, {name="hruschev:corn_sprout_1"})
				return true
			end
		end
		return false
	end,
}) 

minetest.register_craftitem("hruschev:popcorn", {
	image = "corn_popcorn.png",
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = minetest.item_eat(1)
})

minetest.register_craftitem("hruschev:boiled_corn", {
	image = "boiled_corn.png",
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = minetest.item_eat(3)
})

minetest.register_craftitem("hruschev:corn_cob", {
    image = "corn_cob.png",
    stack_max = 99,
    --cookresult_itemstring = itemstring (result of cooking),
    --furnace_cooktime = <cooking time>,
    furnace_burntime = -1,
    usable = true,
    liquids_pointable = false,
    on_place_on_ground = minetest.craftitem_place_item,
}) 

minetest.register_craftitem("hruschev:corn_bowl", {
    image = "baking_baking_form_water.png^corn_cob.png",
    stack_max = 99,
    cookresult_itemstring = 'craft "hruschev:boiled_corn"',
    furnace_cooktime = 30,
    furnace_burntime = -1,
    usable = true,
    liquids_pointable = false,
    on_place_on_ground = minetest.craftitem_place_item,
}) 

minetest.register_craft({
    output = 'craft "hruschev:corn_seeds" 3',
    recipe = {
        {'craft "hruschev:corn_cob" 1'},
    },
}) 

minetest.register_craft({
    output = 'craft "hruschev:corn_bowl" 1',
    recipe = {
        {'craft "hruschev:corn_cob" 1'},
        {BOWL},

    },
}) 

--GEN
local corn_gen = function( minp, maxp )
			local pos = {
				x = math.random( minp.x, maxp.x ),
				y = math.random( minp.y, maxp.y ),
				z = math.random( minp.z, maxp.z ),
			}
						if math.random(1,2) > 1 then return true
						else
                                for i = 1,3 do
                                    for j = 0,3 do 
if (math.random(1,2) ~= 1) then return; end
                                        local p = {x=pos.x+i,y=pos.y,z=pos.z+j}
                                        local n = minetest.env:get_node(p)
if (n.name ~= "default:dirt_with_grass") then return; end

print("Corn generated above " .. p.x .. ' ' .. p.y .. ' ' .. pos.z)
								        minetest.env:add_node({x=p.x,y=p.y+1,z=p.z}, { name = "hruschev:corn_sprout_5" } )
								        minetest.env:add_node({x=p.x,y=p.y+2,z=p.z}, { name = "hruschev:corn_sprout_5" } )
								        minetest.env:add_node({x=p.x,y=p.y+3,z=p.z}, { name = "hruschev:corn_sprout_5" } )
								        minetest.env:add_node({x=p.x,y=p.y+4,z=p.z}, { name = "hruschev:corn_sprout_cob_5"} )
                                    end
                                end
						end
end


minetest.register_on_generated( corn_gen)


print("[hruschev] Loaded!")
