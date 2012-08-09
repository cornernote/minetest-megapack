-- Flowers mod by VanessaE, 2012-08-01
-- Rewritten from Ironzorg's last update, 
-- as included in Nature Pack Controlled
--
-- License:  WTFPL (applies to all parts and textures)
--

math.randomseed(os.time())

local DEBUG = 1

local GROWING_DELAY = 500 -- larger numbers = ABM runs less often
local GROWCHANCE = 50 -- larger = less chance to grow

local FLOWERS = {
	{ "Rose",		"rose", 		GROWING_DELAY*2,	15,	GROWCHANCE*2	},
	{ "Tulip",		"tulip",		GROWING_DELAY,		10,	GROWCHANCE	},
	{ "Yellow Dandelion",	"dandelion_yellow",	GROWING_DELAY,		10,	GROWCHANCE	},
	{ "White Dandelion",	"dandelion_white",	GROWING_DELAY*2,	15,	GROWCHANCE*2	},
	{ "Blue Geranium",	"geranium",		GROWING_DELAY,		10,	GROWCHANCE*2	},
	{ "Viola",		"viola",		GROWING_DELAY*2,	15,	GROWCHANCE*2	},
	{ "Cotton Plant",	"cotton",		GROWING_DELAY,		10,	GROWCHANCE	},
}

local dbg = function(s)
	if DEBUG == 1 then
		print("[FLOWERS] " .. s)
	end
end

local is_node_loaded = function(node_pos)
	n = minetest.env:get_node_or_nil(node_pos)
	if (n == nil) or (n.name == "ignore") then
		return false
	end
	return true
end

spawn_on_surfaces = function(spawndelay, spawnflower, spawnradius, spawnchance, spawnsurface, spawnavoid)
	minetest.register_abm({
		nodenames = { spawnsurface },
		interval = spawndelay,
		chance = spawnchance,

		action = function(pos, node, active_object_count, active_object_count_wider)
			local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }	
			local n_top = minetest.env:get_node(p_top)
			if (n_top.name == "air") and is_node_loaded(p_top) then
				if (minetest.env:find_node_near(p_top, spawnradius, spawnavoid) == nil )
				   and (minetest.env:get_node_light(p_top, nil) > 4) then
					dbg("Spawning "..spawnflower.." at ("..p_top.x..", "..p_top.y..", "..p_top.z..") on "..spawnsurface)
					minetest.env:add_node(p_top, { name = spawnflower })
				end
			end
		end
	})
end

-- On regular fertile ground, any flower except waterlilies can spawn

for i in ipairs(FLOWERS) do
	local flowerdesc = FLOWERS[i][1]
	local flower     = FLOWERS[i][2]
	local delay      = FLOWERS[i][3]
	local radius     = FLOWERS[i][4]
	local chance     = FLOWERS[i][5]

	minetest.register_node("flowers:flower_"..flower, {
		description = flowerdesc,
		drawtype = "plantlike",
		tiles = { "flower_"..flower..".png" },
		inventory_image = "flower_"..flower..".png",
		wield_image = "flower_"..flower..".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		groups = { snappy = 3,flammable=2, flower=1 },
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
		},	
	})

	minetest.register_node("flowers:flower_"..flower.."_pot", {
		description = flowerdesc.." in a pot",
		drawtype = "plantlike",
		tiles = { "flower_"..flower.."_pot.png" },
		inventory_image = "flower_"..flower.."_pot.png",
		wield_image = "flower_"..flower.."_pot.png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		groups = { snappy = 3,flammable=2 },
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = { -0.25, -0.5, -0.25, 0.25, 0.5, 0.25 },
		},	
	})

	minetest.register_craft( {
		type = "shapeless",
		output = "flowers:flower_"..flower.."_pot",
		recipe = {
			"flowers:flower_pot",
			"flowers:flower_"..flower
		}
	})

	spawn_on_surfaces(delay, "flowers:flower_"..flower, radius, chance, "default:dirt_with_grass", "group:flower")
	spawn_on_surfaces(delay, "flowers:flower_"..flower, radius, chance, "default:dirt", "group:flower")
end

-- These few have to be defined separately because of some special
-- condition.  Waterlilies only spawn on top of water for example.

minetest.register_node("flowers:flower_waterlily", {
	description = "Waterlily",
	drawtype = "raillike",
	tiles = { "flower_waterlily.png" },
	inventory_image = "flower_waterlily.png",
	wield_image  = "flower_waterlily.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	groups = { snappy = 3,flammable=2,flower=1 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.4, -0.5, -0.4, 0.4, -0.45, 0.4 },
	},	
})

spawn_on_surfaces(GROWING_DELAY/2, "flowers:flower_waterlily", 15, GROWCHANCE*3, "default:water_source", "group:flower")

-- Seaweed requires specific circumstances under which it will spawn

minetest.register_node("flowers:flower_seaweed", {
	description = "Seaweed",
	drawtype = "signlike",
	tiles = { "flower_seaweed.png" },
	inventory_image = "flower_seaweed.png",
	wield_image  = "flower_seaweed.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	groups = { snappy = 3,flammable=2,flower=1 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -0.4, 0.5 },
	},	
})

minetest.register_abm({
	nodenames = { "default:water_source" },
	interval = GROWING_DELAY*2,
	chance = GROWCHANCE*2,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }	
		local n_top = minetest.env:get_node(p_top)
		local n_light = minetest.env:get_node_light(p_top, nil) 
		if (n_top.name == "air")
			and is_node_loaded(p_top)
			and (n_light < 10) and (n_light > 4)
			and (minetest.env:find_node_near(p_top, 1, {"default:dirt", "default:dirt_with_grass", "default:stone"}) ~= nil ) then
				dbg("Spawning flowers:flower_seaweed at ("..p_top.x..", "..p_top.y..", "..p_top.z..") on default:water_source")
				minetest.env:add_node(p_top, { name = "flowers:flower_seaweed", param2 = 1 })
		end
	end
})

minetest.register_abm({
	nodenames = { "default:dirt", "default:dirt_with_grass", "default:stone" },
	interval = GROWING_DELAY*2,
	chance = GROWCHANCE*2,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }	
		local n_top = minetest.env:get_node(p_top)
		local n_light = minetest.env:get_node_light(p_top, nil) 
		if (n_top.name == "air")
			and is_node_loaded(p_top)
			and (n_light < 10) and (n_light > 4)
			and (minetest.env:find_node_near(p_top, 2, "default:water_source" ) ~= nil ) then
				dbg("Spawning flowers:flower_seaweed at ("..p_top.x..", "..p_top.y..", "..p_top.z..") on default:water_source")
				minetest.env:add_node(p_top, { name = "flowers:flower_seaweed", param2 = 1 })
		end
	end
})

-- Additional crafts, etc.

minetest.register_craftitem("flowers:flower_pot", {
        description = "Flower Pot",
        inventory_image = "flower_pot.png",
})

minetest.register_craft( {
        output = "flowers:flower_pot",
        recipe = {
                { "default:clay_brick", "", "default:clay_brick" },
                { "", "default:clay_brick", "" }
        },
})

minetest.register_craftitem("flowers:cotton", {
    description = "Cotton",
    image = "cotton.png",
})

minetest.register_craft({
    output = "flowers:cotton 3",
    recipe ={
        {"flowers:flower_cotton"},
    }
})

print("[Flowers] Loaded!")
