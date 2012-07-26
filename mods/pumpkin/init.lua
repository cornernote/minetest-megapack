math.randomseed(os.time())
--[[

Author: Victor Hackeridze hackeridze@gmail.com
VERSION: 0.4
LICENSE: GPLv3
TODO:

]]
local PUMPKIN_SPROUT_STATES = {
    '1',
    '2', 
    '3',
    '4',
    '5',
    '6',
    'final',
}

local LIGHT = 5 -- amount of light neded to pumpkin grow

local function register_falling_pumpkin(nodename)
	default.falling_node_names[nodename] = true
	-- Override naming conventions for stuff like :default:falling_default:sand
	minetest.register_entity(":default:falling_"..nodename, {
		-- Static definition
		physical = true,
		collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
		visual = "cube",
		textures = {"pumpkin_pumpkin_top.png","pumpkin_pumpkin_top.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png"},
		-- State
		-- Methods
		on_step = function(self, dtime)
print("1")
			-- Set gravity
			self.object:setacceleration({x=0, y=-10, z=0})
			-- Turn to actual sand when collides to ground or just move
			local pos = self.object:getpos()
			local bcp = {x=pos.x, y=pos.y-0.7, z=pos.z} -- Position of bottom center point
			local bcn = minetest.env:get_node(bcp)
print("1")
			if bcn.name ~= "air" then
				-- Turn to a sand node
				minetest.env:add_item({x=(bcp.x + (math.random(1,100)*.01)), y=(bcp.y + 0.5 + (math.random(1,100)*.01)), z=(bcp.z + (math.random(1,100)*.01))}, 'craft "pumpkin:pumpkin_seeds" 1')
print("add")
minetest.env:add_item({x=(bcp.x + (math.random(1,100)*.01)), y=(bcp.y + 0.5 + (math.random(1,100)*.01)), z=(bcp.z + (math.random(1,100)*.01))}, 'craft "pumpkin:pumpkin_seeds" 1')
print("add")
minetest.env:add_item({x=(bcp.x + (math.random(1,100)*.01)), y=(bcp.y + 0.5 + (math.random(1,100)*.01)), z=(bcp.z + (math.random(1,100)*.01))}, 'craft "pumpkin:pumpkin_seeds" 1')
print("add")
				self.object:remove()
			else
				-- Do nothing
			end
		end
	})
end

-- ABMs
minetest.register_abm({
    nodenames = {"pumpkin:pumpkin_sprout_1","pumpkin:pumpkin_sprout_2",
											"pumpkin:pumpkin_sprout_3","pumpkin:pumpkin_sprout_4",
                                        	"pumpkin:pumpkin_sprout_5","pumpkin:pumpkin_sprout_6"},
    interval = PLANTS_GROW_INTERVAL,
    chance = PLANTS_GROW_CHANCE,
        action = function(pos, node, _, __)
if (math.random(1,3) > 1) then return 0; end
            local l = minetest.env:get_node_light(pos, nil)
            local p = pos
            p.y = p.y - 1 -- it will change pos too, that cause using p.y = p.y + 1
            local under_node = minetest.env:get_node(p)
            if (l >= LIGHT) and (under_node.name == "wheat:dirt_bed")  then
                local nname  --= 'wheat:wheat_final' 
                if node.name == "pumpkin:pumpkin_sprout_1" then 
                    --if math.random(1, 3) == 1 then
                        nname = 'pumpkin:pumpkin_sprout_2'
                    --end
                elseif node.name == "pumpkin:pumpkin_sprout_2" then
                    --if math.random(1, 3) == 1 then
                        nname = 'pumpkin:pumpkin_sprout_3'
                    --end
                elseif  node.name == 'pumpkin:pumpkin_sprout_3' then
                    --if math.random(1, 3) == 1 then
                        nname = 'pumpkin:pumpkin_sprout_4'
                    --end
                elseif  node.name == 'pumpkin:pumpkin_sprout_4' then
                    --if math.random(1, 3) == 1 then
                        nname = 'pumpkin:pumpkin_sprout_5'
                    --end
                elseif  node.name == 'pumpkin:pumpkin_sprout_5' then
                    --if math.random(1, 3) == 1 then
                        nname = 'pumpkin:pumpkin_sprout_6'
                    --end
                else nname = 'pumpkin:pumpkin_sprout_final' end
                p.y = p.y + 1
                minetest.env:remove_node(pos)
                minetest.env:add_node(pos, { name = nname })
            elseif (under_node.name == "air") then
                p.y = p.y + 1
                minetest.env:remove_node(pos)
            end
        end
})

minetest.register_abm({ --WARNING!!! DO NOT TRY UNDERSTAND HOW IT WORKS!!!
    nodenames = {"pumpkin:pumpkin_sprout_final"},
    interval = (PLANTS_GROW_INTERVAL*3)/2,
    chance = PLANTS_GROW_CHANCE,
        action = function(pos, node, _, __)
if (math.random(1,4) > 1) then return 0; end
if (node.param2 > 3) then return; end
            local l = minetest.env:get_node_light(pos, nil)
            local p = pos
            p.y = p.y - 1 -- it will change pos too, that cause using p.y = p.y + 1
            local under_node = minetest.env:get_node(p)
			p.y = p.y + 1
			

            if (l >= LIGHT) and (under_node.name == "wheat:dirt_bed") and (node.name == "pumpkin:pumpkin_sprout_final")  then
				local x1, x2, z1, z2 = pos, pos, pos, pos
                local nname = 'pumpkin:pumpkin'
				---
				x1.x = pos.x + 1
				x1.z = pos.z + 1
                nx1 = minetest.env:get_node(x1)
                if (nx1.name == "air")  then
                    minetest.env:add_node(x1, { name = nname})
                    nodeupdate_single(x1)
                    node.param2 = node.param2 + 1
                    return
                end
				---
				x1.x = pos.x - 2
				x1.z = pos.z - 2
                nx2 = minetest.env:get_node(x1)
                if (nx2.name == "air") then 	
                    minetest.env:add_node(x1, { name = nname})
                    nodeupdate_single(x1)
                    node.param2 = node.param2 + 1
                    return
                end
				---
				x1.x = pos.x + 2
                nz1 = minetest.env:get_node(x1)
                if (nz1.name == "air") then
                 	minetest.env:add_node(x1, { name = nname})
                    nodeupdate_single(x1) 
                    node.param2 = node.param2 + 1
                    return
                end
				---
				x1.x = pos.x - 2
				x1.z = pos.z + 2
                nz2 = minetest.env:get_node(x1)
                if (nz2.name == "air") then
                    minetest.env:add_node(x1, { name = nname})
                    nodeupdate_single(x1)
                    node.param2 = node.param2 + 1
                    return
				end
				---
				--minetest.env:add_node(p, { name = 'pumpkin:pumpkin' })
            end

        end
}) -- ABMs end

-- Nodes
for i, state in ipairs(PUMPKIN_SPROUT_STATES) do
    minetest.register_node("pumpkin:pumpkin_sprout_" .. state, {
	drawtype = "plantlike",
	tiles = {"watermelon_watermelon_sprout_" .. state .. ".png"},
	inventory_image = "watermelon_watermelon_sprout_" .. state .. ".png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	material = minetest.digprop_constanttime(0.3),
	furnace_burntime = 2,
	drop = "",
    visual_scale = 1.19,
	extra_drop = 'craft "pumpkin:pumpkin_seeds"',
	extra_drop_rarity = 10,
	wall_mounted = false,
    visual_scale = PLANTS_VISUAL_SCALE,
    param2 = 0,
    })
end

minetest.register_node("pumpkin:pumpkin", {
	tiles = {"pumpkin_pumpkin_top.png","pumpkin_pumpkin_top.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png"},
	inventory_image = minetest.inventorycube("pumpkin_pumpkin_top.png","pumpkin_pumpkin.png", "pumpkin_pumpkin.png"),
	paramtype = "light",
	is_ground_content = true,
	walkable = true,
	material = minetest.digprop_constanttime(0.6),
}) 

--=======================
--register_falling_pumpkin("pumpkin:pumpkin")
--=======================

minetest.register_node("pumpkin:pumpkin_light", {
	tiles = {"pumpkin_pumpkin_top.png","pumpkin_pumpkin_top.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin.png", "pumpkin_pumpkin_light_front.png"},
	inventory_image = minetest.inventorycube("pumpkin_pumpkin_top.png","pumpkin_pumpkin_light_front.png", "pumpkin_pumpkin.png"),
	--drawtype = 'glasslike',
	paramtype = "facedir_simple",
	walkable = true,
	sunlight_propagates = true,
	wall_mounted = false,
	light_source = 17,
	--material = minetest.digprop_constanttime(0.6),
	groups = {crumbly=3, falling_node=1},
})-- Nodes end

-- Craftitems
minetest.register_craftitem("pumpkin:pumpkin_seeds", {
    image = "pumpkin_pumpkin_seeds.png",
    stack_max = 99,
    --cookresult_itemstring = itemstring (result of cooking),
    --furnace_cooktime = <cooking time>,
    furnace_burntime = 1,
    usable = true,
    liquids_pointable = false,
    on_place_on_ground = minetest.craftitem_place_item,
    on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "wheat:dirt_bed" then
				minetest.env:add_node(pointed_thing.above, {name="pumpkin:pumpkin_sprout_1"})
				return true
			end
		end
		return false
	end,
}) -- Craftitems end

-- Crafts
minetest.register_craft({
    output = 'NodeItem "pumpkin:pumpkin_light" 1',
    recipe = {
        {'node "pumpkin:pumpkin" 1'},
        {'node "default:torch" 1'},
    },
}) 

minetest.register_craft({
    output = 'craft "pumpkin:pumpkin_seeds" 3',
    recipe = {
        {'node "pumpkin:pumpkin" 1'},
    },
}) -- Crafts end

 


local pumpkins_gen = function( minp, maxp )
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
								minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z}, { name = "pumpkin:pumpkin" } )
							end
						end
end


minetest.register_on_generated( pumpkins_gen)


print("[Pumpkin] Loaded!")
