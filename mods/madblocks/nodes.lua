BRICKLIKE = function(nodeid, nodename)
	minetest.register_node("madblocks:"..nodeid, {
		description = nodename,
		tiles = {"madblocks_"..nodeid..'.png'},
		inventory_image = minetest.inventorycube("madblocks_"..nodeid..'.png'),
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end
WOODLIKE = function(nodeid, nodename,fence)
	minetest.register_node("madblocks:"..nodeid, {
		description = nodename,
		tiles = {"madblocks_"..nodeid..".png"},
		inventory_image = minetest.inventorycube("madblocks_"..nodeid..".png"),
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
	})
	if fence == true then
		minetest.register_node("madblocks:"..nodeid.."_fence", {
			description = nodename.." Fence",
			drawtype = "fencelike",
			tiles = {"madblocks_"..nodeid..".png"},
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
		tiles = {"madblocks_signs_"..nodeid..".png"},
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

	local params ={ description = nodename, drawtype = "plantlike", tiles = {"madblocks_"..nodeid..'.png'}, 
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
		tiles = {"madblocks_"..nodeid..".png"},
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
		tiles = {"madblocks_"..nodeid..".png"},
		inventory_image = minetest.inventorycube("madblocks_"..nodeid..".png"),
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_wood_defaults(),
	})
	if fence == true then
		minetest.register_node("madblocks:"..nodeid.."_fence", {
			description = nodename.." Fence",
			drawtype = "fencelike",
			tiles = {"madblocks_"..nodeid..".png"},
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
			tiles = {"madblocks_"..nodeid..'.png'}, 
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
			tiles = {"madblocks_"..nodeid..'.png'}, 
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


BRICKLIKE('greenbrick','Green Brick')
BRICKLIKE('blackbrick','Black Brick')
BRICKLIKE('bluebrick','Blue Brick')
BRICKLIKE('yellowbrick','Yellow Brick')
BRICKLIKE('brownbrick','Brown Brick')
BRICKLIKE('oddbrick','Oddly Coloured Brick')
BRICKLIKE('mossystonebrick','Mossy Stone Brick')
BRICKLIKE('culturedstone','Cultured Stone')
BRICKLIKE('marblestonebrick','Marble Stone Brick')
BRICKLIKE('shinystonebrick','Sand-Blasted Stone Brick')
BRICKLIKE('cinderblock','Cinderblock')
BRICKLIKE('blackstonebrick','Black Stonebrick')
BRICKLIKE('roundstonebrick','Round Stonebrick')
BRICKLIKE('slimstonebrick','Slim Stonebrick')
BRICKLIKE('greystonebrick','Grey Stonebrick')
BRICKLIKE('medistonebrick','Mediterranean Stonebrick')
BRICKLIKE('whitestonebrick','White Stonebrick')
BRICKLIKE('cement','Cement')
BRICKLIKE('countrystonebrick','Country Stonebrick')
BRICKLIKE('asphalte','Asphalte')
WOODLIKE('woodshingles','Wood Shingles')
WOODLIKE('bluewood','Blue Stained Wood',true)
WOODLIKE('blackwood','Black Stained Wood',true)
WOODLIKE('yellowwood','Yellow Stained Wood',true)
WOODLIKE('greenwood','Green Stained Wood',true)
WOODLIKE('redwood','Red Stained Wood',true)
WOODLIKE('dye_black','Black Dye')
WOODLIKE('dye_blue','Blue Dye')
WOODLIKE('dye_red','Red Dye')
WOODLIKE('dye_yellow','Yellow Dye')
WOODLIKE('dye_green','Green Dye')
SIGNLIKE('cafe',7)
SIGNLIKE('drpepper')
SIGNLIKE('dangermines')
SIGNLIKE('hucksfoodfuel')
SIGNLIKE('enjoycoke')
PLANTLIKE('flowers1','Flower Arrangement #1','veg')
PLANTLIKE('flowers2','Flower Arrangement #2','veg')
PLANTLIKE('hangingflowers','Hanging Flower Basket','cri')
PLANTLIKE('stool','Bar Stool','cri',true)
PLANTLIKE('gnome','Garden Gnome','cri')
PLANTLIKE('statue','Statuette','cri')
PLANTLIKE('gargoyle','Gargoyle','cri')
SOUNDNODE('siren','Loud Siren')
SOUNDNODE('churchbells','Church Bells')

-- ***********************************************************************************
--		ASSORTED DEFS						**************************************************
-- ***********************************************************************************

minetest.register_node("madblocks:pylon", {
	description = "Pylon",
	drawtype = "glasslike",
	tiles = {"madblocks_power_pylon.png"},
	inventory_image = minetest.inventorycube("madblocks_power_pylon.png"),
	paramtype = "light",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("madblocks:safetyladder", {
	description = "Ladder",
	drawtype = "signlike",
	tiles = {"madblocks_power_polepegs.png"},
	inventory_image = "madblocks_power_polepegs.png",
	wield_image = "madblocks_power_polepegs.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	is_ground_content = true,
	walkable = false,
	climbable = true,
	selection_box = {	type = "wallmounted" },
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_node(":madblocks:lampling", {
	description = "Lampling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"madblocks_lampling.png"},
	inventory_image = "madblocks_lampling.png",
	wield_image = "madblocks_lampling.png",
	paramtype = "light",
	walkable = false,
	groups = {snappy=2,dig_immediate=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("madblocks:sheetmetal", {
	description = "Sheet Metal",
	tiles = {"madblocks_sheetmetal_top.png","madblocks_sheetmetal_top.png","madblocks_sheetmetal.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("madblocks:bigben", {
	description = "Big Ben",
	tiles = {"madblocks_bigben_top.png","madblocks_bigben_top.png","madblocks_bigben.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=3,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_node("madblocks:fancybracket", {
	description = "Fancy Support Bracket",
	drawtype = "torchlike",
	tiles = {"madblocks_fancybracket.png", "madblocks_fancybracket.png", "madblocks_fancybracket.png"},
	inventory_image = "madblocks_fancybracket.png",
	wield_image = "madblocks_fancybracket.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {choppy=2,dig_immediate=3,flammable=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})
minetest.register_node("madblocks:cinderblock_planter", {
	description = "Cinderblock Planter",
	tiles = {"madblocks_cinderblock_planter.png","madblocks_cinderblock.png"},
	inventory_image = minetest.inventorycube("madblocks_cinderblock_planter.png","madblocks_cinderblock.png","madblocks_cinderblock.png"),
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("madblocks:awning", {
	drawtype = "raillike",
	visual_scale = 1.0,
	paramtype = "light",
	description = "Awning",
	tiles = {"madblocks_awning.png","madblocks_awning2.png"},
	inventory_image  = "madblocks_awning.png",
	light_propagates = true,
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=3},
})

-- ***********************************************************************************
--		NEW METALLIC ITEMS				**************************************************
-- ***********************************************************************************

METALLIKE('brushedmetal','Brushed Metal',true)
minetest.register_craft({	output = 'node "madblocks:brushedmetal" 4',	recipe = {
		{'','',''},
		{'default:steel_ingot','default:steel_ingot',''},
		{'default:steel_ingot','default:steel_ingot',''},
	}})
minetest.register_craft({	output = 'node "madblocks:brushedmetal_fence" 6',	recipe = {
		{'','',''},
		{'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
		{'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
	}})
METALLIKE('yellow_rustedmetal','Yellow Painted Rusted Metal',true)
minetest.register_craft({	output = 'node "madblocks:yellow_rustedmetal" 1',	recipe = {
		{'','madblocks:dye_yellow',''},
		{'','default:steel_ingot',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'node "madblocks:yellow_rustedmetal_fence" 6',	recipe = {
		{'','madblocks:dye_yellow',''},
		{'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
		{'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
	}})

METALLIKE('texturedmetal','Textured Metal')
minetest.register_craft({	output = 'node "madblocks:texturedmetal" 2',	recipe = {
		{'default:steel_ingot','',''},
		{'','',''},
		{'','','default:steel_ingot'},
	}})
METALLIKE('metalbulkhead','Metal Bulkhead')
minetest.register_craft({	output = 'node "madblocks:metalbulkhead" 5',	recipe = {
		{'default:steel_ingot','','default:steel_ingot'},
		{'','default:steel_ingot',''},
		{'default:steel_ingot','','default:steel_ingot'},
	}})
METALLIKE('stripedmetal','Caution Striped Metal')
minetest.register_craft({	output = 'node "madblocks:stripedmetal" 2',	recipe = {
		{'','default:steel_ingot',''},
		{'','madblocks:dye_yellow',''},
		{'','default:steel_ingot',''},
	}})

BRICKLIKE('brownmedistonebrick','Mediterranean Stonebrick (Brown Tones)')
minetest.register_craft({	output = 'node "madblocks:brownmedistonebrick" 3',	recipe = {
		{'','',''},
		{'madblocks:dye_red','','madblocks:dye_black'},
		{'default:cobble','madblocks:cement','default:cobble'},
	}})
