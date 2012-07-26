-- Junglegrass mod by VanessaE (using ironzorg's flowers mod as a basis)

math.randomseed(os.time())

local DEBUG = 1

local MAX_RATIO = 500
local GROWING_DELAY = 50
local RADIUS = 10

local GRASSES = {
        "junglegrass:shortest",
        "junglegrass:short",
        "junglegrass:medium",
        "default:junglegrass",
	"default:dry_shrub",
	"default:cactus",
}

local dbg = function(s)
	if DEBUG == 1 then
		print('[JUNGLEGRASS] ' .. s)
	end
end

local is_node_loaded = function(nodenames, node_pos)
	n = minetest.env:get_node_or_nil(node_pos)
	if (n == nil) or (n.name == 'ignore') then
		return false
	end
	return true
end

spawn_on_surfaces = function(growdelay, grownames, surfaces)
	for _, surface in ipairs(surfaces) do
		minetest.register_abm({
			nodenames = { surface.name },
			interval = growdelay,
			chance = 30,
			action = function(pos, node, active_object_count, active_object_count_wider)
				local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }	
				local n_top = minetest.env:get_node(p_top)
				local rnd = math.random(1, MAX_RATIO)

				if (MAX_RATIO - surface.chance < rnd) and (n_top.name == "air") and (is_node_loaded(grownames, p_top) == true) then
					if ((minetest.env:find_node_near(p_top, RADIUS, GRASSES) == nil ) or (surface.name == "default:cactus")) then
						local nnode = grownames[math.random(1, #grownames)]
						dbg('Spawning '
						  .. nnode .. ' at ('
						  .. p_top.x .. ', '
						  .. p_top.y .. ', '
						  .. p_top.z .. ') on '
						  .. surface.name)
						minetest.env:add_node(p_top, { name = nnode })
					end
				end
			end
		})
	end
end

grow_on_surfaces = function(growdelay, grownames, surfaces)
	for _, surface in ipairs(surfaces) do
		minetest.register_abm({
			nodenames = { surface.name },
			interval = growdelay,
			chance = 30,
			action = function(pos, node, active_object_count, active_object_count_wider)
				local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }	
				local n_top = minetest.env:get_node(p_top)
				local rnd = math.random(1, MAX_RATIO)
				local nnode = grownames[math.random(1, #grownames)]

				if (MAX_RATIO - surface.chance < rnd) and (is_node_loaded(grownames, p_top) == true) then
					if (n_top.name == "junglegrass:shortest") then
						dbg('Growing shortest into short at ('
						  .. p_top.x .. ', '
						  .. p_top.y .. ', '
						  .. p_top.z .. ') on '
						  .. surface.name)
						minetest.env:add_node(p_top, { name = "junglegrass:short" })
					end
	
					if (surface.name == "default:desert_sand") then
						if (n_top.name == "junglegrass:short") or (n_top.name == "junglegrass:medium") or (n_top.name == "default:junglegrass") then
							dbg(nnode .. ' in desert turns to dry shrub at ('
							  .. p_top.x .. ', '
							  .. p_top.y .. ', '
							  .. p_top.z .. ') on '
							  .. surface.name)
							minetest.env:add_node(p_top, { name = "default:dry_shrub" })
						end
					else
						if (n_top.name == "junglegrass:short") then
							dbg('Growing short into medium at ('
							  .. p_top.x .. ', '
							  .. p_top.y .. ', '
							  .. p_top.z .. ') on '
							  .. surface.name)
							minetest.env:add_node(p_top, { name = "junglegrass:medium" })
						end

						if (n_top.name == "junglegrass:medium") then
							dbg('Growing medium into full size at ('
							  .. p_top.x .. ', '
							  .. p_top.y .. ', '
							  .. p_top.z .. ') on '
							  .. surface.name)
							minetest.env:add_node(p_top, { name = "default:junglegrass" })
						end

						if (n_top.name == "default:junglegrass") then
							dbg(nnode .. ' dies at ('
							  .. p_top.x .. ', '
							  .. p_top.y .. ', '
							  .. p_top.z .. ') on '
							  .. surface.name)
							minetest.env:remove_node(p_top)
						end
					end
				end
			end
		})
	end
end

-- On regular fertile ground, any size can spawn

spawn_on_surfaces(GROWING_DELAY, {
	"junglegrass:shortest",
	"junglegrass:short",
	"junglegrass:medium",
	"default:junglegrass",
	}, {
	{name = "default:dirt_with_grass", chance = 4},
	{name = "default:dirt", chance = 5},
	{name = "default:sand", chance = 4},
})

-- On cactus, papyrus, and desert sand, only the two smallest sizes can spawn

spawn_on_surfaces(GROWING_DELAY, {
	"junglegrass:shortest",
	"junglegrass:short",
	}, {
	{name = "default:papyrus", chance = 250},
	{name = "default:cactus", chance = 150},
	{name = "default:desert_sand", chance = 2},
})

-- make the grasses grow and die

grow_on_surfaces(GROWING_DELAY, {
	"junglegrass:shortest",
	"junglegrass:short",
	"junglegrass:medium",
	"default:junglegrass",
	}, {
	{name = "default:dirt_with_grass", chance = 499},
	{name = "default:dirt", chance = 499},
	{name = "default:sand", chance = 499},
	{name = "default:desert_sand", chance = 400}
})

-- The actual node definitions

minetest.register_node('junglegrass:medium', {
	description = "Jungle Grass (medium height)",
	drawtype = 'plantlike',
	tiles = { 'junglegrass_medium.png' },
	inventory_image = 'junglegrass_medium.png',
	wield_image = 'junglegrass_medium.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	groups = { snappy = 3,flammable=2 },
	sounds = default.node_sound_leaves_defaults(),
	drop = 'default:junglegrass',

	selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
	},
})

minetest.register_node('junglegrass:short', {
	description = "Jungle Grass (short)",
	drawtype = 'plantlike',
	tiles = { 'junglegrass_short.png' },
	inventory_image = 'junglegrass_short.png',
	wield_image = 'junglegrass_short.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	groups = { snappy = 3,flammable=2 },
	sounds = default.node_sound_leaves_defaults(),
	drop = 'default:junglegrass',
	selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4, 0.3, 0.4},
	},
})

minetest.register_node('junglegrass:shortest', {
	description = "Jungle Grass (very short)",
	drawtype = 'plantlike',
	tiles = { 'junglegrass_shortest.png' },
	inventory_image = 'junglegrass_shortest.png',
	wield_image = 'junglegrass_shortest.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	groups = { snappy = 3,flammable=2 },
	sounds = default.node_sound_leaves_defaults(),
	drop = 'default:junglegrass',
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3},
	},
})


print("[Junglegrass] Loaded!")
