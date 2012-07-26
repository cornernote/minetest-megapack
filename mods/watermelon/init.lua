math.randomseed(os.time())
--[[

Author: Victor Hackeridze hackeridze@gmail.com
VERSION: 0.7
LICENSE: GPLv3
TODO:

]]
local WATERMELON_SPROUT_STATES = {
    '1',
    '2', 
    '3',
    '4',
    '5',
    '6',
    'final',
}

local LIGHT = 5 -- amount of light neded to watermelon grow

local replace_node = function(coords, aname) 
	minetest.env:remove_node(coords)
	minetest.env:add_node(coords, { name = aname })
end

local function register_falling_watermelon(nodename)
	default.falling_node_names[nodename] = true,
	-- Override naming conventions for stuff like :default:falling_default:sand
	minetest.register_entity(":default:falling_"..nodename, {
		-- Static definition
		physical = true,
		collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
		visual = "cube",
		textures = {"watermelon_watermelon_top.png","watermelon_watermelon_top.png", "watermelon_watermelon.png", "watermelon_watermelon.png", "watermelon_watermelon.png", "watermelon_watermelon.png"},
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
				minetest.env:add_item({x=(bcp.x + (math.random(1,100)*.01)), y=(bcp.y + 0.5 + (math.random(1,100)*.01)), z=(bcp.z + (math.random(1,100)*.01))}, 'craft "watermelon:watermelon_slice" 1')
print("add")
minetest.env:add_item({x=(bcp.x + (math.random(1,100)*.01)), y=(bcp.y + 0.5 + (math.random(1,100)*.01)), z=(bcp.z + (math.random(1,100)*.01))}, 'craft "watermelon:watermelon_slice" 1')
print("add")
minetest.env:add_item({x=(bcp.x + (math.random(1,100)*.01)), y=(bcp.y + 0.5 + (math.random(1,100)*.01)), z=(bcp.z + (math.random(1,100)*.01))}, 'craft "watermelon:watermelon_slice" 1')
print("add")
minetest.env:add_item({x=(bcp.x + (math.random(1,100)*.01)), y=(bcp.y + 0.5 + (math.random(1,100)*.01)), z=(bcp.z + (math.random(1,100)*.01))}, 'craft "watermelon:watermelon_seeds" 1')
print("add")
minetest.env:add_item({x=(bcp.x + (math.random(1,100)*.01)), y=(bcp.y + 0.5 + (math.random(1,100)*.01)), z=(bcp.z + (math.random(1,100)*.01))}, 'craft "watermelon:watermelon_seeds" 1')
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
    nodenames = {"watermelon:watermelon_sprout_1","watermelon:watermelon_sprout_2",
											"watermelon:watermelon_sprout_3","watermelon:watermelon_sprout_4",
                                        	"watermelon:watermelon_sprout_5","watermelon:watermelon_sprout_6"},
    interval = PLANTS_GROW_INTERVAL,
    chance = PLANTS_GROW_CHANCE,
        action = function(pos, node, _, __)
        if (math.random(1,3) > 1) then return 0; end
            local l = minetest.env:get_node_light(pos, nil)
            local p = pos
            p.y = p.y - 1 -- it will change pos too, that cause using p.y = p.y + 1
            local under_node = minetest.env:get_node(p)
            --p.y = p.y + 1

            if (l >= LIGHT) and (under_node.name == "wheat:dirt_bed")  then
                
                --minetest.env:remove_node(p)
                if node.name == "watermelon:watermelon_sprout_1" then 
                    --if math.random(1, 3) == 1 then
                        nname = 'watermelon:watermelon_sprout_2'
                        p.y = p.y + 1
                        replace_node(pos, nname)
                    --end
                elseif node.name == "watermelon:watermelon_sprout_2" then
                    --if math.random(1, 3) == 1 then
                        nname = 'watermelon:watermelon_sprout_3'
                        p.y = p.y + 1
                        replace_node(pos, nname)
                    --end
                elseif  node.name == 'watermelon:watermelon_sprout_3' then
                    --if math.random(1, 3) == 1 then
                        nname = 'watermelon:watermelon_sprout_4'
                        p.y = p.y + 1
                        replace_node(pos, nname)
                    --end
                elseif  node.name == 'watermelon:watermelon_sprout_4' then
                    --if math.random(1, 3) == 1 then
                        nname = 'watermelon:watermelon_sprout_5'
                        p.y = p.y + 1
                        replace_node(p, nname)
                    --end
                elseif  node.name == 'watermelon:watermelon_sprout_5' then
                    --if math.random(1, 3) == 1 then
                        nname = 'watermelon:watermelon_sprout_6'
                        p.y = p.y + 1
                        replace_node(p, nname)
                    --end
                else nname = 'watermelon:watermelon_sprout_final'
                        p.y = p.y + 1
                    replace_node(p, nname) 
                end
                --minetest.env:add_node(p, { name = nname })
            elseif (under_node.name == "air") then
                minetest.env:remove_node(p)
            end
        end
})

minetest.register_abm({ --WARNING!!! DO NOT TRY UNDERSTAND HOW IT WORKS!!!
    nodenames = {"watermelon:watermelon_sprout_final"},
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
			

            if (l >= LIGHT) and (under_node.name == "wheat:dirt_bed") and (node.name == "watermelon:watermelon_sprout_final")  then
				local x1, x2, z1, z2 = pos, pos, pos, pos
                local nname = 'watermelon:watermelon'
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
				--minetest.env:add_node(p, { name = 'watermelon:watermelon' })
            end
        end
}) -- ABMs end

-- Nodes
for i, state in ipairs(WATERMELON_SPROUT_STATES) do
    minetest.register_node("watermelon:watermelon_sprout_" .. state, {
	drawtype = "plantlike",
	tiles = {"watermelon_watermelon_sprout_" .. state .. ".png"},
	inventory_image = "watermelon_watermelon_sprout_" .. state .. ".png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	material = minetest.digprop_constanttime(0.3),
	furnace_burntime = 2,
	drop = "",
	extra_drop = 'craft "watermelon:watermelon_seeds"',
	extra_drop_rarity = 10,
	wall_mounted = false,
    visual_scale = PLANTS_VISUAL_SCALE,
    })
end

minetest.register_node("watermelon:watermelon", {
	tiles = {"watermelon_watermelon_top.png","watermelon_watermelon_top.png", "watermelon_watermelon.png"},
	inventory_image = minetest.inventorycube("watermelon_watermelon_top.png","watermelon_watermelon.png","watermelon_watermelon.png"),
	paramtype = "light",
	is_ground_content = true,
	walkable = true,
	--material = minetest.digprop_constanttime(0.6),
	groups = {crumbly=3, falling_node=1},
})

--register_falling_watermelon("watermelon:watermelon", "watermelon_watermelon.png")
-- Nodes end

-- Craftitems
minetest.register_craftitem("watermelon:watermelon_seeds", {
    image = "watermelon_watermelon_seeds.png",
    stack_max = 99,
    --cookresult_itemstring = itemstring (result of cooking),
    --furnace_cooktime = <cooking time>,
    furnace_burntime = 1,
    usable = true,
    dropcount = 10,
    liquids_pointable = false,
    on_place_on_ground = minetest.craftitem_place_item,
    on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "wheat:dirt_bed" then
				minetest.env:add_node(pointed_thing.above, {name="watermelon:watermelon_sprout_1"})
				return true
			end
		end
		return false
	end,
}) 

minetest.register_craftitem("watermelon:watermelon_slice", {
	image = "watermelon_watermelon_slice.png",
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = minetest.item_eat(3)
}) -- Craftitems end

-- Crafts
minetest.register_craft({
    output = 'craft "watermelon:watermelon_slice" 5',
    recipe = {
        {'node "watermelon:watermelon" 1'},
    },
}) 

minetest.register_craft({
    output = 'craft "watermelon:watermelon_seeds" 1',
    recipe = {
        {'craft "watermelon:watermelon_slice" 1'},
    },
}) -- Crafts end


 


local watermelons_gen = function( minp, maxp )
			local pos = {
				x = math.random( minp.x, maxp.x ),
				y = math.random( minp.y, maxp.y ),
				z = math.random( minp.z, maxp.z ),
			}
						if math.random(1,5) > 1 then return true
						else
							local n = minetest.env:get_node( pos )
							if n.name == "default:dirt_with_grass" then
print("Watermelon generated above " .. pos.x .. ' ' .. pos.y .. ' ' .. pos.z)
								minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z}, { name = "watermelon:watermelon" } )
							end
						end
end


minetest.register_on_generated( watermelons_gen)


print("[Watermelons] Loaded!")
