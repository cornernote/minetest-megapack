-- Flowers mod by VanessaE, rewritten from Ironzorg"s original

math.randomseed(os.time())

local DEBUG = 1

local MAX_RATIO = 200
local GROWING_DELAY = 1000

local FLOWERS = {
	{ "Rose",		"rose", 		GROWING_DELAY*2, "15", "4" },
	{ "Tulip",		"tulip",		GROWING_DELAY,   "10", "2" },
	{ "Yellow Dandelion",	"dandelion_yellow",	GROWING_DELAY,   "10", "2" },
	{ "White Dandelion",	"dandelion_white",	GROWING_DELAY*2, "15", "4" },
	{ "Viola",		"viola",		GROWING_DELAY*2, "15", "4" },
	{ "Cotton Plant",	"cotton",		GROWING_DELAY,   "10", "2" }
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

spawn_on_surfaces = function(spawndelay, spawnflower, spawnradius, spawnchance, spawnsurface)
	minetest.register_abm({
		nodenames = { spawnsurface },
		interval = spawndelay,
		chance = 30,

		action = function(pos, node, active_object_count, active_object_count_wider)
			local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }	
			local n_top = minetest.env:get_node(p_top)
			local rnd = math.random(1, MAX_RATIO)
			if (MAX_RATIO - spawnchance < rnd) and (n_top.name == "air") and is_node_loaded(p_top) then
				if (minetest.env:find_node_near(p_top, spawnradius, "group:flower") == nil ) and (minetest.env:get_node_light(p_top, nil) > 4) then
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
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		groups = { snappy = 3,flammable=2, flower=1 },
		sounds = default.node_sound_leaves_defaults()
	})

	minetest.register_node("flowers:flower_"..flower.."_pot", {
		description = flowerdesc.." in a pot",
		drawtype = "plantlike",
		tiles = { "flower_"..flower.."_pot.png" },
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		groups = { snappy = 3,flammable=2 },
		sounds = default.node_sound_leaves_defaults(),
	})

	minetest.register_craft( {
		type = "shapeless",
		output = "flowers:flower_"..flower.."_pot",
		recipe = {
			"flowers:flower_pot",
			"flowers:flower_"..flower
		}
	})

	spawn_on_surfaces(delay, "flowers:flower_"..flower, radius, chance, "default:dirt_with_grass")
	spawn_on_surfaces(delay, "flowers:flower_"..flower, radius, chance, "default:dirt")
end

-- These few have to be defined separately because of some special
-- condition.  Waterlilies only spawn on top of water for example.

minetest.register_node("flowers:flower_waterlily", {
	description = "Waterlily",
	drawtype = "raillike",
	tiles = { "flower_waterlily.png" },
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	groups = { snappy = 3,flammable=2,flower=1 },
	sounds = default.node_sound_leaves_defaults(),
})

spawn_on_surfaces(GROWING_DELAY/2, "flowers:flower_waterlily", 15, 1, "default:water_source")

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
