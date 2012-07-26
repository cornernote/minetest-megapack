function minetest.item_place_node(itemstack, placer, pointed_thing)
	local item = itemstack:peek_item()
	local def = itemstack:get_definition()
	if def.type == "node" and pointed_thing.type == "node" then
		local pos = pointed_thing.above

		----------------
		--snow stuff--
		local thing = pointed_thing.under
		if minetest.env:get_node(thing).name == "snow:snow" then

			--Gets rid of client-side placement block
			minetest.env:add_node(pos,{name="air"})

			minetest.env:remove_node(thing)
			pos=thing
		end
		----------------

		local oldnode = minetest.env:get_node(pos)
		local olddef = ItemStack({name=oldnode.name}):get_definition()

		if not olddef.buildable_to then
			minetest.log("info", placer:get_player_name() .. " tried to place"
				.. " node in invalid position " .. minetest.pos_to_string(pos)
				.. ", replacing " .. oldnode.name)
			return
		end

		minetest.log("action", placer:get_player_name() .. " places node "
			.. def.name .. " at " .. minetest.pos_to_string(pos))

		local newnode = {name = def.name, param1 = 0, param2 = 0}

		-- Calculate direction for wall mounted stuff like torches and signs
		if def.paramtype2 == 'wallmounted' then
			local under = pointed_thing.under
			local above = pointed_thing.above
			local dir = {x = under.x - above.x, y = under.y - above.y, z = under.z - above.z}
			newnode.param2 = minetest.dir_to_wallmounted(dir)
		-- Calculate the direction for furnaces and chests and stuff
		elseif def.paramtype2 == 'facedir' then
			local playerpos = placer:getpos() or {x=0,y=0,z=0}
			local dir = {x = pos.x - playerpos.x, y = pos.y - playerpos.y, z = pos.z - playerpos.z}
			newnode.param2 = minetest.dir_to_facedir(dir)
			minetest.log("action", "facedir: " .. newnode.param2)
		end

		-- Add node and update
		minetest.env:add_node(pos, newnode)

		-- Run callback
		if def.after_place_node then
			def.after_place_node(pos, placer)
		end

		-- Run script hook (deprecated)
		local _, callback
		for _, callback in ipairs(minetest.registered_on_placenodes) do
			callback(pos, newnode, placer)
		end

		itemstack:take_item()
	end
	return itemstack
end

minetest.register_node(":default:leaves", {
	description = "Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_leaves.png"},
	paramtype = "light",
	groups = {snappy=3, leafdecay=3, flammable=2},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'default:sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:leaves'},
			}
		}
	},
	--Remove snow on top of leaves after decay
	after_destruct = function(pos, node, digger)
		pos.y = pos.y + 1
		local nodename = minetest.env:get_node(pos).name
		if nodename == "snow:snow" then
			minetest.env:remove_node(pos)
		end
	end,
	sounds = default.node_sound_leaves_defaults(),
})

snowball_DAMAGE=1
snowball_GRAVITY=9
snowball_VELOCITY=19

snow_shoot_snowball=function (item, player, pointed_thing)
	-- Shoot snowball
	local i=1
	local playerpos=player:getpos()
	local obj=minetest.env:add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, "snow:snowball_entity")
	local dir=player:get_look_dir()
	obj:setvelocity({x=dir.x*snowball_VELOCITY, y=dir.y*snowball_VELOCITY, z=dir.z*snowball_VELOCITY})
	obj:setacceleration({x=dir.x*-3, y=-snowball_GRAVITY, z=dir.z*-3})
	item:take_item()
	return item
end

-- The snowball Entity

snow_snowball_ENTITY={
	physical = false,
	timer=0,
	textures = {"snow_snowball.png"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
}


-- snowball_entity.on_step()--> called when snowball is moving
snow_snowball_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)

	-- Become item when hitting a node
	if self.lastpos.x~=nil then --If there is no lastpos for some reason
		if node.name ~= "air" and node.name ~= "snow:snow" then
			minetest.env:place_node(self.lastpos,{name="snow:snow"})
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z} -- Set lastpos-->Node will be added at last pos outside the node
end

minetest.register_entity("snow:snowball_entity", snow_snowball_ENTITY)

--Snow.
minetest.register_node("snow:snow", {
	tiles = {"snow_snow.png"},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = "light",
	groups = {crumbly=3,melts=3},
	buildable_to = true,
	drop = 'snow:snowball',
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.35, 0.5}
		},
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.45},
	}),
	after_destruct = function(pos, node, digger)
		pos.y = pos.y - 1
		local nodename = minetest.env:get_node(pos).name
		if nodename == "snow:dirt_with_snow" then
			minetest.env:add_node(pos,{name="default:dirt_with_grass"})
		end
	end,
	on_construct = function(pos, newnode)
		pos.y = pos.y - 1
		local nodename = minetest.env:get_node(pos).name
		if nodename == "default:dirt_with_grass" then
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos,{name="snow:dirt_with_snow"})
		elseif nodename == "air" then
			pos.y = pos.y + 1
			minetest.env:remove_node(pos)
		end
	end,
})

--Snow with dirt.
minetest.register_node("snow:dirt_with_snow", {
	description = "Dirt with Snow",
	tiles = {"snow_snow.png", "default_dirt.png", "default_dirt.png^snow_snow_side.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
	after_place_node = function(pos, newnode)
		pos.y = pos.y + 1
		local nodename = minetest.env:get_node(pos).name
		if nodename == "air" then
			minetest.env:add_node(pos,{name="snow:snow"})
		end
	end,
})

--Snowball.
minetest.register_craftitem("snow:snowball", {
	Description = "Snowball",
	inventory_image = "snow_snowball.png",
	on_use = snow_shoot_snowball,
})

local unsnowify = function(pos, node, digger)
	pos.y = pos.y + 1
	local nodename = minetest.env:get_node(pos).name
	if nodename == "snow:snow" then
		minetest.env:remove_node(pos)
	end
end

minetest.register_on_dignode(unsnowify)

minetest.register_on_generated(function(minp, maxp, seed)
if maxp.y >= -10 then
		local pr = PseudoRandom(seed+57)
		local biome = pr:next(1, 10)
		local icebergs = biome == 2
		local icesheet = biome == 3
		local cool = biome > 9   --only spawns ice on edge of water
		local icecave = biome == 5
		local icehole = biome == 6 --icesheet with holes

		local icy = pr:next(1, 2) == 2   --If enabled spawns ice in sand instead of snow blocks

		-- Assume X and Z lengths are equal
		local divlen = 16
		local divs = (maxp.x-minp.x);
		local divx=0
		local divz=0
		local x0 = minp.x
		local z0 = minp.z
		local x1 = maxp.x
		local z1 = maxp.z

		local env = minetest.env

		--Debug
		--~ local biomeToString = function(num)
			--~ if num == 1 then return "normal"
			--~ elseif num == 2 then return "icebergs"
			--~ elseif num == 3 then return "icesheet"
			--~ elseif num == 5 then return "icecave"
			--~ elseif num == 4 then return "cool"
			--~ elseif num == 6 then return "icehole"
			--~ else return "unknown" end
		--~ end

		local perlin1 = env:get_perlin(112,3, 0.5, 150)
		pr = PseudoRandom(seed+68)
		if not (perlin1:get2d({x=x0, y=z0}) > 0.53) and not (perlin1:get2d({x=x1, y=z1}) > 0.53)
		and not (perlin1:get2d({x=x0, y=z1}) > 0.53) and not (perlin1:get2d({x=x1, y=z0}) > 0.53)
		and not (perlin1:get2d({x=(x1-x0)/2, y=(z1-z0)/2}) > 0.53) then
			print("abort")
			return
		end

		for j=0,divs do
		for i=0,divs do

			local x = x0+i
			local z = z0+j


			local test = perlin1:get2d({x=x, y=z})
			if test > 0.53 then

				-- Find ground level (0...15)
				local ground_y = nil
				for y=maxp.y,0,-1 do
					if env:get_node({x=x,y=y,z=z}).name ~= "air" then
						ground_y = y
						break
					end
				end

				-- Snowy stuff
				if ground_y and env:get_node({x=x,y=ground_y,z=z}).name == "default:dirt_with_grass" then
						env:add_node({x=x,y=ground_y,z=z}, {name="snow:dirt_with_snow"})
						env:add_node({x=x,y=ground_y+1,z=z}, {name="snow:snow"})
				elseif ground_y and env:get_node({x=x,y=ground_y,z=z}).name == "default:sand" then
					if not icy then
						env:add_node({x=x,y=ground_y+1,z=z}, {name="snow:snow"})
						env:add_node({x=x,y=ground_y,z=z}, {name="snow:snow_block"})
					else
						env:add_node({x=x,y=ground_y,z=z}, {name="snow:ice"})
					end
				elseif ground_y and env:get_node({x=x,y=ground_y,z=z}).name == "default:leaves" then
					env:add_node({x=x,y=ground_y+1,z=z}, {name="snow:snow"})
				elseif ground_y and env:get_node({x=x,y=ground_y,z=z}).name == "default:water_source" then
					if not icesheet and not icecave and not icehole then
						local x1 = env:get_node({x=x+1,y=ground_y,z=z}).name
						local z1 = env:get_node({x=x,y=ground_y,z=z+1}).name
						local xz1 = env:get_node({x=x+1,y=ground_y,z=z+1}).name
						local xz2 = env:get_node({x=x-1,y=ground_y,z=z-1}).name
						local x2 = env:get_node({x=x-1,y=ground_y,z=z}).name
						local z2 = env:get_node({x=x,y=ground_y,z=z-1}).name
						local y = env:get_node({x=x,y=ground_y-1,z=z}).name
						local rand = pr:next(1,4) == 1
						if
						((x1  and x1 ~= "default:water_source"  and x1 ~= "snow:ice"  and x1 ~= "air" and x1 ~= "ignore") or ((cool or icebergs) and x1 == "snow:ice"  and rand)) or
						((z1  and z1 ~= "default:water_source"  and z1 ~= "snow:ice"  and z1 ~= "air" and z1 ~= "ignore") or ((cool or icebergs) and z1 == "snow:ice"  and rand)) or
						((xz1 and xz1 ~= "default:water_source" and xz1 ~= "snow:ice" and xz1 ~= "air"and xz1 ~= "ignore") or ((cool or icebergs) and xz1 == "snow:ice" and rand)) or
						((xz2 and xz2 ~= "default:water_source" and xz2 ~= "snow:ice" and xz2 ~= "air"and xz2 ~= "ignore") or ((cool or icebergs) and xz2 == "snow:ice" and rand)) or
						((x2  and x2 ~= "default:water_source"  and x2 ~= "snow:ice"  and x2 ~= "air" and x2 ~= "ignore") or ((cool or icebergs) and x2 == "snow:ice"  and rand)) or
						((z2  and z2 ~= "default:water_source"  and z2 ~= "snow:ice"  and z2 ~= "air" and z2 ~= "ignore") or ((cool or icebergs) and z2 == "snow:ice"  and rand)) or
						(y ~= "default:water_source" and y ~= "snow:ice" and y ~= "air") or (pr:next(1,6) == 1 and icebergs) then
								env:add_node({x=x,y=ground_y,z=z}, {name="snow:ice"})
						end
					else
						if (icehole and pr:next(1,10) > 1) or icecave or icesheet then
							env:add_node({x=x,y=ground_y,z=z}, {name="snow:ice"})
						end
						if icecave then
							for y=ground_y-1,-60,-1 do
								if env:get_node({x=x,y=y,z=z}) and env:get_node({x=x,y=y,z=z}).name ~= "default:water_source" then
									break
								else
									env:remove_node({x=x,y=y,z=z})
								end
							end
						end
					end
				elseif ground_y and env:get_node({x=x,y=ground_y,z=z}).name == "default:desert_sand" then
					--Debug
					--print(biomeToString(biome)..": ABORTED! ("..((large and "large") or "small")..")")
					return
				end
			end
			end
		--Debug
		--print(biomeToString(biome)..": Snow Biome Genarated ("..((large and "large") or "small")..")")
	end
end
end
)

minetest.register_node("snow:snow_block", {
	description = "Snow",
	tiles = {"snow_snow.png"},
	is_ground_content = true,
	groups = {crumbly=3,melts=2,falling_node=1},
	drop = 'snow:snow_block',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})
minetest.register_node("snow:ice", {
	description = "Ice",
	tiles = {"snow_ice.png"},
	is_ground_content = true,
	groups = {snappy=2,cracky=3,melts=1},
	drop = 'snow:ice',
	paramtype = "light",
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults({
		footstep = {name="default_stone_footstep", gain=0.4},
	}),
})
minetest.register_craft({
    output = 'snow:snow_block',
    recipe = {
        {'snow:snowball', 'snow:snowball'},
        {'snow:snowball', 'snow:snowball'},
    },
})

--Melting
minetest.register_abm({
    nodenames = {"group:melts"},
    neighbors = {"default:desert_sand", "group:igniter","default:torch","default:furnace_active","group:hot"},
    interval = 2,
    chance = 2,
    action = function(pos, node, active_object_count, active_object_count_wider)
		local intensity = minetest.get_item_group(node.name,"melts")
		if intensity == 1 then
			minetest.env:add_node(pos,{name="default:water_source"})
		elseif intensity == 2 then
			local check_place = function(pos,node)
				if minetest.env:get_node(pos).name == "air" then
					minetest.env:place_node(pos,node)
				end
			end
			minetest.env:add_node(pos,{name="default:water_flowing"})
			check_place({x=pos.x+1,y=pos.y,z=pos.z},{name="default:water_flowing"})
			check_place({x=pos.x-1,y=pos.y,z=pos.z},{name="default:water_flowing"})
			check_place({x=pos.x,y=pos.y+1,z=pos.z},{name="default:water_flowing"})
			check_place({x=pos.x,y=pos.y-1,z=pos.z},{name="default:water_flowing"})
		elseif intensity == 3 then
			minetest.env:add_node(pos,{name="default:water_flowing"})
		end
		nodeupdate(pos)
    end,
})

--~ --Snowing (WIP)
--~ minetest.register_abm({
	--~ nodenames = {"default:dirt_with_grass","default:dirt"},
	--~ interval = 20,
    --~ chance = 5,
	--~ action = function()
		--~ local perlin1 = env:get_perlin(112,3, 0.5, 150)
	--~ end
--~ })

--Freezing
minetest.register_abm({
    nodenames = {"default:water_source"},
    neighbors = {"snow:snow", "snow:snow_block"},
    interval = 20,
    chance = 4,
    action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.env:add_node(pos,{name="snow:ice"})
    end,
})
