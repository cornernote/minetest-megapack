local madblocks_modpath = minetest.get_modpath("madblocks")
math.randomseed(os.time())

BRICKLIKE = function(nodeid, nodename)
	minetest.register_node("madblocks:"..nodeid, {
		description = nodename,
		tile_images = {"madblocks_"..nodeid..'.png'},
		inventory_image = minetest.inventorycube("madblocks_"..nodeid..'.png'),
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end
--		*****************************
--		NODES
--		*****************************

--[[
WOODLIKE = function(nodeid, nodename,fence)
	minetest.register_node("madblocks:"..nodeid, {
		description = nodename,
		tile_images = {"madblocks_"..nodeid..".png"},
		inventory_image = minetest.inventorycube("madblocks_"..nodeid..".png"),
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
	})
	if fence == true then
		minetest.register_node("madblocks:"..nodeid.."_fence", {
			description = nodename.." Fence",
			drawtype = "fencelike",
			tile_images = {"madblocks_"..nodeid..".png"},
			inventory_image = "madblocks_"..nodeid.."_fence.png",
			wield_image = "madblocks_"..nodeid.."_fence.png",
			paramtype = "light",
			is_ground_content = true,
			selection_box = {
				type = "fixed",
				fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
			},
			groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
			sounds = default.node_sound_wood_defaults(),
		})
	end
end
SIGNLIKE = function(nodeid, light)
	light = light or 0
	minetest.register_node("madblocks:signs_"..nodeid, {
		description = "Sign",
		drawtype = "signlike",
		tile_images = {"madblocks_signs_"..nodeid..".png"},
		inventory_image = "madblocks_signs_"..nodeid..".png",
		wield_image = "madblocks_signs_"..nodeid..".png",
		paramtype = "light",
		paramtype2 = "wallmounted",
		is_ground_content = true,
		walkable = false,
		climbable = false,
		selection_box = {
			type = "wallmounted",
		},
		light_source = light	,
		light_propagates = true,
		sunlight_propagates = true,

		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=2},
		legacy_wallmounted = true,
		sounds = default.node_sound_stone_defaults(),
	})
end
PLANTLIKE = function(nodeid, nodename,type,option)
	if option == nil then option = false end

	local params ={ description = nodename, drawtype = "plantlike", tile_images = {"madblocks_"..nodeid..'.png'}, 
	inventory_image = "madblocks_"..nodeid..'.png',	wield_image = "madblocks_"..nodeid..'.png', paramtype = "light",	}
		
	if type == 'veg' then
		params.groups = {snappy=2,dig_immediate=3,flammable=2}
		params.sounds = default.node_sound_leaves_defaults()
		if option == false then params.walkable = false end
	elseif type == 'met' then			-- metallic
		params.groups = {cracky=3}
		params.sounds = default.node_sound_stone_defaults()
	elseif type == 'cri' then			-- craft items
		params.groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3}
		params.sounds = default.node_sound_wood_defaults()
		if option == false then params.walkable = false end
	elseif type == 'eat' then			-- edible
		params.groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3}
		params.sounds = default.node_sound_wood_defaults()
		params.walkable = false
		params.on_use = minetest.item_eat(option)
	end
	minetest.register_node("madblocks:"..nodeid, params)
end
GLOWLIKE = function(nodeid,nodename,drawtype)
	if drawtype == nil then 
		drawtype = 'glasslike'
		inv_image = minetest.inventorycube("madblocks_"..nodeid..".png")
	else 
		inv_image = "madblocks_"..nodeid..".png" 
	end
	minetest.register_node("madblocks:"..nodeid, {
		description = nodename,
		drawtype = drawtype,
		tile_images = {"madblocks_"..nodeid..".png"},
		inventory_image = inv_image,
		light_propagates = true,
		paramtype = "light",
		sunlight_propagates = true,
		light_source = 15	,
		is_ground_content = true,
		groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
		sounds = default.node_sound_glass_defaults(),
	})
end
METALLIKE = function(nodeid, nodename,fence)
	minetest.register_node("madblocks:"..nodeid, {
		description = nodename,
		tile_images = {"madblocks_"..nodeid..".png"},
		inventory_image = minetest.inventorycube("madblocks_"..nodeid..".png"),
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_wood_defaults(),
	})
	if fence == true then
		minetest.register_node("madblocks:"..nodeid.."_fence", {
			description = nodename.." Fence",
			drawtype = "fencelike",
			tile_images = {"madblocks_"..nodeid..".png"},
			inventory_image = "madblocks_"..nodeid.."_fence.png",
			wield_image = "madblocks_"..nodeid.."_fence.png",
			paramtype = "light",
			is_ground_content = true,
			selection_box = {
				type = "fixed",
				fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
			},
			groups = {cracky=3},
			sounds = default.node_sound_wood_defaults(),
		})
	end
end
SOUNDS = {}
SOUNDNODE = function(nodeid, nodename,drawtype)
	SOUNDS[nodeid] = {}
	SOUNDS[nodeid].sounds = {}
	local on_punch = function(pos,node)
		local sound = SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)]
		if sound == nil then 
			local wanted_sound = {name=nodeid, gain=1.5}
			SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)] = {	handle = minetest.sound_play(wanted_sound, {pos=pos, loop=true}),	name = wanted_sound.name, }

		else 
			minetest.sound_stop(sound.handle)
			SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)] = nil
		end

	end
	after_dig_node = function(pos,node)
		local sound = SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)]
		if sound ~= nil then
			minetest.sound_stop(sound.handle)
			SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)] = nil
			nodeupdate(pos)
		end
	end
	if drawtype == 'signlike' then
		minetest.register_node("madblocks:"..nodeid, {
			description = nodename,
			drawtype = "signlike",
			tile_images = {"madblocks_"..nodeid..'.png'}, 
			inventory_image = "madblocks_"..nodeid..'.png',
			wield_image = "madblocks_"..nodeid..'.png', 
			paramtype = "light",
			paramtype2 = "wallmounted",
			sunlight_propagates = true,
			walkable = false,
			metadata_name = "sign",
			selection_box = {
				type = "wallmounted",
				--wall_top = <default>
				--wall_bottom = <default>
				--wall_side = <default>
			},
			groups = {choppy=2,dig_immediate=2},
			legacy_wallmounted = true,
			sounds = default.node_sound_defaults(),
			on_punch = on_punch,
			after_dig_node = after_dig_node,		
		})
	else 
		minetest.register_node("madblocks:"..nodeid, { 
			description = nodename, 
			drawtype = 'plantlike', 
			tile_images = {"madblocks_"..nodeid..'.png'}, 
			inventory_image = "madblocks_"..nodeid..'.png',
			wield_image = "madblocks_"..nodeid..'.png', 
			paramtype = "light",
			groups = {cracky=3},
			sounds = default.node_sound_stone_defaults(),
			on_punch = on_punch,	
			after_dig_node = after_dig_node,
		})
	end
end
]]--

BRICKLIKE('mossystonebrick','Mossy Stone Brick')
BRICKLIKE('culturedstone','Cultured Stone')
BRICKLIKE('marblestonebrick','Marble Stone Brick')
BRICKLIKE('shinystonebrick','Sand-Blasted Stone Brick')
BRICKLIKE('blackstonebrick','Black Stonebrick')
BRICKLIKE('roundstonebrick','Round Stonebrick')
BRICKLIKE('slimstonebrick','Slim Stonebrick')
BRICKLIKE('greystonebrick','Grey Stonebrick')
BRICKLIKE('medistonebrick','Mediterranean Stonebrick')
BRICKLIKE('whitestonebrick','White Stonebrick')
BRICKLIKE('countrystonebrick','Country Stonebrick')
BRICKLIKE('brownmedistonebrick','Mediterranean Stonebrick (Brown Tones)')

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
		wanted_sound = {name="fire_large", gain=0.2}
	elseif #flames_p > 0 then
		wanted_sound = {name="fire_small", gain=0.2}
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
		interval = 60,
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
	tile_images = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
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
	tile_images = {"fire_basic_flame.png"},
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
	tile_images = {"default_cobble.png","default_cobble.png","default_cobble.png","default_cobble.png","default_cobble.png","madblocks_fireplace.png"},
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


print('mAdBlOcKs 12.7.17 loaded')
