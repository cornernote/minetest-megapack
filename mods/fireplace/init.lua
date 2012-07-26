-- minetest/fire/init.lua

minetest.register_node("fireplace:basic_flame", {
	description = "Fire",
	drawtype = "glasslike",
	tiles = {"fire_basic_flame.png"},
	light_source = 14,
	groups = {dig_immediate=3},
	drop = '',
	walkable = false,
})

local fireplace = {}
fireplace.D = 1
-- key: position hash of low corner of area
-- value: {handle=sound handle, name=sound name}
fireplace.sounds = {}

function fireplace.get_area_p0p1(pos)
	local p0 = {
		x=math.floor(pos.x/fireplace.D)*fireplace.D,
		y=math.floor(pos.y/fireplace.D)*fireplace.D,
		z=math.floor(pos.z/fireplace.D)*fireplace.D,
	}
	local p1 = {
		x=p0.x+fireplace.D-1,
		y=p0.y+fireplace.D-1,
		z=p0.z+fireplace.D-1
	}
	return p0, p1
end

function fireplace.update_sounds_around(pos)
	local p0, p1 = fireplace.get_area_p0p1(pos)
	local cp = {x=(p0.x+p1.x)/2, y=(p0.y+p1.y)/2, z=(p0.z+p1.z)/2}
	local flames_p = minetest.env:find_nodes_in_area(p0, p1, {"fireplace:basic_flame"})
	--print("number of flames at "..minetest.pos_to_string(p0).."/"
	--		..minetest.pos_to_string(p1)..": "..#flames_p)
	local should_have_sound = (#flames_p > 0)
	local wanted_sound = nil
	if #flames_p >= 9 then
		wanted_sound = {name="fire_large", gain=1.5}
	elseif #flames_p > 0 then
		wanted_sound = {name="fire_small", gain=1.5}
	end
	local p0_hash = minetest.hash_node_position(p0)
	local sound = fireplace.sounds[p0_hash]
	if not sound then
		if should_have_sound then
			fireplace.sounds[p0_hash] = {
				handle = minetest.sound_play(wanted_sound, {pos=cp, loop=true}),
				name = wanted_sound.name,
			}
		end
	else
		if not wanted_sound then
			minetest.sound_stop(sound.handle)
			fireplace.sounds[p0_hash] = nil
		elseif sound.name ~= wanted_sound.name then
			minetest.sound_stop(sound.handle)
			fireplace.sounds[p0_hash] = {
				handle = minetest.sound_play(wanted_sound, {pos=cp, loop=true}),
				name = wanted_sound.name,
			}
		end
	end
end

function fireplace.on_flame_add_at(pos)
	--print("flame added at "..minetest.pos_to_string(pos))
	fireplace.update_sounds_around(pos)
end

function fireplace.on_flame_remove_at(pos)
	--print("flame removed at "..minetest.pos_to_string(pos))
	fireplace.update_sounds_around(pos)
end

minetest.register_on_placenode(function(pos, newnode, placer)
	if newnode.name == "fireplace:basic_flame" then
		fireplace.on_flame_add_at(pos)
	end
end)

minetest.register_on_dignode(function(pos, oldnode, digger)
	if oldnode.name == "fireplace:basic_flame" then
		fireplace.on_flame_remove_at(pos)
	end
end)


minetest.register_node("fireplace:fireplace", {

	description = "Fireplace",

	tiles = {"default_cobble.png","default_cobble.png","default_cobble.png","default_cobble.png","default_cobble.png","fireplace_fireplace.png"},
	inventory_image = minetest.inventorycube("default_cobble.png","fireplace_fireplace.png","default_cobble.png"),
	light_propagates = true,
	paramtype = "light",
		paramtype2 = "facedir",
	sunlight_propagates = true,
	light_source = 10,
	material = minetest.digprop_glasslike(1.0),
	groups = {cracky=3},
})

minetest.register_craft({
	output = 'fireplace:fireplace 1',
	recipe = {
		{'default:cobble','default:cobble','default:cobble'},
		{'default:cobble','default:torch','default:cobble'},
		{'default:cobble','default:tree','default:cobble'},

	}
})
minetest.register_abm({
		nodenames = { "fireplace:fireplace" },
		interval = 5,
		chance = 1,

		action = function(pos, node, active_object_count, active_object_count_wider)
			local xm = {x=pos.x-1,y=pos.y,z=pos.z}
			local xp = {x=pos.x+1,y=pos.y,z=pos.z}
			local zm = {x=pos.x,y=pos.y,z=pos.z-1}
			local zp = {x=pos.x,y=pos.y,z=pos.z+1}
			local xmnode = minetest.env:get_node(xm)
			local xpnode = minetest.env:get_node(xp)
			local zmnode = minetest.env:get_node(zm)
			local zpnode = minetest.env:get_node(zp)
			
			if xpnode.name == 'default:cobble' or
			xmnode.name == 'default:cobble' then -- build along Z axis
				minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z},{type="node",name="fireplace:log"})
				minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z},{type="node",name="fireplace:basic_flame"})
				minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z-1},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z-1},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x,y=pos.y+2,z=pos.z-1},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x,y=pos.y+2,z=pos.z},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x,y=pos.y+2,z=pos.z+1},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z+1},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z+1},{type="node",name="default:cobble"})
			elseif zpnode.name == 'default:cobble' or
			zmnode.name == 'default:cobble' then -- build along x axis
				minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z},{type="node",name="fireplace:log"})
				minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z},{type="node",name="fireplace:basic_flame"})
				minetest.env:add_node({x=pos.x-1,y=pos.y,z=pos.z},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x-1,y=pos.y+1,z=pos.z},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x-1,y=pos.y+2,z=pos.z},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x,y=pos.y+2,z=pos.z},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x+1,y=pos.y+2,z=pos.z},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x+1,y=pos.y+1,z=pos.z},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x+1,y=pos.y,z=pos.z},{type="node",name="default:cobble"})
			end
			fireplace.update_sounds_around({x=pos.x,y=pos.y+1,z=pos.z})
		end
})
minetest.register_node("fireplace:log", {
	description = "Fire Log",
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	is_ground_content = true,
	groups = {tree=1,snappy=2,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_on_punchnode(function(p, node)
	if node.name == "fireplace:log" then
		fire_above = {x = p.x, y= p.y+1, z = p.z}
		isflame = minetest.env:get_node(fire_above)
		if isflame.name == 'air' then
			minetest.env:add_node(fire_above,{type="node",name="fireplace:basic_flame"})
		elseif isflame.name == "fireplace:basic_flame" then
			minetest.env:remove_node(fire_above)
		end
		fireplace.update_sounds_around({x=p.x,y=p.y+1,z=p.z})
	end
end)
