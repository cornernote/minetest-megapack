-- ***********************************************************************************
--		BIGBEN								**************************************************
-- ***********************************************************************************
local bigben = {}
bigben.sounds = {}
bigben_sound = function(p)
		local wanted_sound = {name="bigbenshort", gain=1.5}
			bigben.sounds[minetest.hash_node_position(p)] = {
				handle = minetest.sound_play(wanted_sound, {pos=p, loop=false}),
				name = wanted_sound.name,
			}

end

minetest.register_abm({
		nodenames = {'madblocks:bigben'},
		interval = 60,
		chance = 1,
		action = function(pos, node, active_object_count, active_object_count_wider)
			bigben_sound(pos)
		end
})

-- ***********************************************************************************
--		FIREPLACE							**************************************************
-- ***********************************************************************************
local fireplace = {}
fireplace.D = 1
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
	local flames_p = minetest.env:find_nodes_in_area(p0, p1, {"madblocks:basic_flame"})
	local should_have_sound = (#flames_p > 0)
	local wanted_sound = nil
	if #flames_p >= 9 then
		wanted_sound = {name="fire_large", gain=0.5}
	elseif #flames_p > 0 then
		wanted_sound = {name="fire_small", gain=0.5}
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
	fireplace.update_sounds_around(pos)
end

function fireplace.on_flame_remove_at(pos)
	fireplace.update_sounds_around(pos)
end
minetest.register_abm({
		nodenames = { "madblocks:fireplace" },
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
				minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z},{type="node",name="madblocks:log"})
				minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z},{type="node",name="madblocks:basic_flame"})
				minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z-1},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z-1},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x,y=pos.y+2,z=pos.z-1},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x,y=pos.y+2,z=pos.z},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x,y=pos.y+2,z=pos.z+1},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z+1},{type="node",name="default:cobble"})
				minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z+1},{type="node",name="default:cobble"})
			elseif zpnode.name == 'default:cobble' or
			zmnode.name == 'default:cobble' then -- build along x axis
				minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z},{type="node",name="madblocks:log"})
				minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z},{type="node",name="madblocks:basic_flame"})
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
minetest.register_node(":madblocks:log", {
	description = "Fire Log",
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	is_ground_content = true,
	groups = {tree=1,snappy=2,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	on_punch = function(p,node)
		fire_above = {x = p.x, y= p.y+1, z = p.z}
		isflame = minetest.env:get_node(fire_above)
		if isflame.name == 'air' then
			minetest.env:add_node(fire_above,{type="node",name="madblocks:basic_flame"})
		elseif isflame.name == "madblocks:basic_flame" then
			minetest.env:remove_node(fire_above)
		end
		fireplace.update_sounds_around({x=p.x,y=p.y+1,z=p.z})
	end,
	after_dig_node = function(p,node)
		fire_above = {x = p.x, y= p.y+1, z = p.z}
		isflame = minetest.env:get_node(fire_above)
		if isflame.name == "madblocks:basic_flame" then
			minetest.env:remove_node(fire_above)
		end
		fireplace.update_sounds_around({x=p.x,y=p.y+1,z=p.z})
	end,
})
minetest.register_node(":madblocks:basic_flame", {
	description = "Fire",
	drawtype = "glasslike",
	tiles = {"fire_basic_flame.png"},
	light_source = 14,
	groups = {dig_immediate=3},
	drop = '',
	walkable = false,
	after_place_node = function(pos, node)
		fireplace.on_flame_add_at(pos)
	end,
	on_dig = function(pos,node)
		fireplace.on_flame_remove_at(pos)	
	end,
})
minetest.register_node(":madblocks:fireplace", {
	description = "Fireplace",
	tiles = {"default_cobble.png","default_cobble.png","default_cobble.png","default_cobble.png","default_cobble.png","madblocks_fireplace.png"},
	inventory_image = minetest.inventorycube("default_cobble.png","madblocks_fireplace.png","default_cobble.png"),
	light_propagates = true,
	paramtype = "light",
		paramtype2 = "facedir",
	sunlight_propagates = true,
	light_source = 10,
	material = minetest.digprop_glasslike(1.0),
	groups = {cracky=3},
})
minetest.register_craft({
	output = 'madblocks:fireplace 1',
	recipe = {
		{'default:cobble','default:cobble','default:cobble'},
		{'default:cobble','default:torch','default:cobble'},
		{'default:cobble','default:tree','default:cobble'},
	}
})
-- ***********************************************************************************
--		LAMPLING								**************************************************
-- ***********************************************************************************
minetest.register_abm({
		nodenames = { "madblocks:lampling" },
		interval = 60,
		chance = 1,
		
		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z},{type="node",name="madblocks:blackwood_fence"})
			minetest.env:add_node({x=pos.x,y=pos.y+1,z=pos.z},{type="node",name="madblocks:blackwood_fence"})
			minetest.env:add_node({x=pos.x,y=pos.y+2,z=pos.z},{type="node",name="madblocks:blackwood_fence"})
			minetest.env:add_node({x=pos.x,y=pos.y+3,z=pos.z},{type="node",name="madblocks:blackwood_fence"})			
			minetest.env:add_node({x=pos.x,y=pos.y+4,z=pos.z},{type="node",name="madblocks:glowyellow"})			
			
		end
})

-- ***********************************************************************************
--		STREETS								**************************************************
-- ***********************************************************************************
minetest.register_node(":madblocks:street", {
	description = "Street Builder",
	tiles = {"madblocks_street.png"},
	inventory_image = minetest.inventorycube("madblocks_street.png"),
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 10,
	material = minetest.digprop_glasslike(1.0),
	groups = {cracky=3},
	on_punch = function(pos,node)
		local xm = {x=pos.x-1,y=pos.y,z=pos.z}
		local xp = {x=pos.x+1,y=pos.y,z=pos.z}
		local zm = {x=pos.x,y=pos.y,z=pos.z-1}
		local zp = {x=pos.x,y=pos.y,z=pos.z+1}
		local xmnode = minetest.env:get_node(xm)
		local xpnode = minetest.env:get_node(xp)
		local zmnode = minetest.env:get_node(zm)
		local zpnode = minetest.env:get_node(zp)

		if xpnode.name ~= "air" and xmnode.name == "air" and zpnode.name == "air" and zmnode.name == "air" and
		xpnode.name ~= "madblocks:replicator" and xpnode.name ~= "madblocks:mk2" and xpnode.name ~= "madblocks:street" then
			for i = 0, 9, 1 do
				local xmin = pos.x-(i+1)
				local corner1 = {x=pos.x+2,y=pos.y,z=pos.z+2}
				local corner2 = {x=pos.x+2,y=pos.y,z=pos.z-2}
				c1node = minetest.env:get_node(corner1)
				c2node = minetest.env:get_node(corner2)
				if i == 0 then
					minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z-1},{type="node",name=xpnode.name})
					minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z+1},{type="node",name=xpnode.name})
				end
				minetest.env:add_node({x=xmin,y=pos.y,z=pos.z},{type="node",name=xpnode.name})
				minetest.env:add_node({x=xmin,y=pos.y,z=pos.z-1},{type="node",name=xpnode.name})
				minetest.env:add_node({x=xmin,y=pos.y,z=pos.z+1},{type="node",name=xpnode.name})
				if i == 9 then
					minetest.env:add_node({x=xmin,y=pos.y,z=pos.z+2},{type="node",name=xpnode.name})
					minetest.env:add_node({x=xmin,y=pos.y+1,z=pos.z+2},{type="node", name="madblocks:lampling"})
				end
			end
		elseif xmnode.name ~= "air" and xpnode.name == "air" and zpnode.name == "air" and zmnode.name == "air" and
		xmnode.name ~= "madblocks:replicator" and xmnode.name ~= "madblocks:mk2" and  xmnode.name ~= "madblocks:street" then
			for i = 0, 9, 1 do
				local xplu = pos.x+(i+1)
				local corner1 = {x=pos.x-2,y=pos.y,z=pos.z+2}
				local corner2 = {x=pos.x-2,y=pos.y,z=pos.z-2}
				c1node = minetest.env:get_node(corner1)
				c2node = minetest.env:get_node(corner2)
				if i == 0 then
					minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z-1},{type="node",name=xmnode.name})
					minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z+1},{type="node",name=xmnode.name})
				end
				minetest.env:add_node({x=xplu,y=pos.y,z=pos.z},{type="node",name=xmnode.name})
				minetest.env:add_node({x=xplu,y=pos.y,z=pos.z-1},{type="node",name=xmnode.name})
				minetest.env:add_node({x=xplu,y=pos.y,z=pos.z+1},{type="node",name=xmnode.name})
				if i == 9 then
					minetest.env:add_node({x=xplu,y=pos.y,z=pos.z+2},{type="node",name=xmnode.name})
					minetest.env:add_node({x=xplu,y=pos.y+1,z=pos.z+2},{type="node",name="madblocks:lampling"})
				end
			end
		elseif zpnode.name ~= "air" and zmnode.name == "air" and xpnode.name == "air" and xmnode.name == "air" and
		zpnode.name ~= "madblocks:replicator" and zpnode.name ~= "madblocks:mk2" and zpnode.name ~= "madblocks:street" then
			for i = 0, 9, 1 do
				local zmin = pos.z-(i+1)
				local corner1 = {x=pos.x+2,y=pos.y,z=pos.z+2}
				local corner2 = {x=pos.x-2,y=pos.y,z=pos.z+2}
				c1node = minetest.env:get_node(corner1)
				c2node = minetest.env:get_node(corner2)
				if i == 0 then
					minetest.env:add_node({x=pos.x-1,y=pos.y,z=pos.z},{type="node",name=zpnode.name})
					minetest.env:add_node({x=pos.x+1,y=pos.y,z=pos.z},{type="node",name=zpnode.name})
				end
				minetest.env:add_node({x=pos.x,y=pos.y,z=zmin},{type="node",name=zpnode.name})
				minetest.env:add_node({x=pos.x-1,y=pos.y,z=zmin},{type="node",name=zpnode.name})
				minetest.env:add_node({x=pos.x+1,y=pos.y,z=zmin},{type="node",name=zpnode.name})
				if i == 9 then
					minetest.env:add_node({x=pos.x+2,y=pos.y,z=zmin},{type="node",name=zpnode.name})
					minetest.env:add_node({x=pos.x+2,y=pos.y+1,z=zmin},{type="node",name="madblocks:lampling"})
				end
			end
		elseif zmnode.name ~= "air" and zpnode.name == "air" and xpnode.name == "air" and xmnode.name == "air" and
		zmnode.name ~= "madblocks:replicator" and zmnode.name ~= "madblocks:mk2" and zmnode.name ~= "madblocks:street" then
			for i = 0, 9, 1 do
				local zplu = pos.z+(i+1)
				local corner1 = {x=pos.x+2,y=pos.y,z=pos.z-2}
				local corner2 = {x=pos.x-2,y=pos.y,z=pos.z-2}
				c1node = minetest.env:get_node(corner1)
				c2node = minetest.env:get_node(corner2)
				if i == 0 then
					minetest.env:add_node({x=pos.x-1,y=pos.y,z=pos.z},{type="node",name=zmnode.name})
					minetest.env:add_node({x=pos.x+1,y=pos.y,z=pos.z},{type="node",name=zmnode.name})
				end
				minetest.env:add_node({x=pos.x,y=pos.y,z=zplu},{type="node",name=zmnode.name})
				minetest.env:add_node({x=pos.x-1,y=pos.y,z=zplu},{type="node",name=zmnode.name})
				minetest.env:add_node({x=pos.x+1,y=pos.y,z=zplu},{type="node",name=zmnode.name})
				if i == 9 then
					minetest.env:add_node({x=pos.x+2,y=pos.y,z=zplu},{type="node",name=zmnode.name})
					minetest.env:add_node({x=pos.x+2,y=pos.y+1,z=zplu},{type="node",name="madblocks:lampling"})
				end
			end
		nodeupdate(pos)
		end
	end,
})

