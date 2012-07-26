-- Poison Ivy mod by VanessaE (using ironzorg's flowers mod as a basis)

math.randomseed(os.time())

local DEBUG = 1

local MAX_RATIO = 2000
local GROWING_DELAY = 1200
-- use values of around 50 and 30 for rapid growth

local VERTICALS = {
	"default:dirt",
	"default:dirt_with_grass",
	"default:stone",
	"default:cobble",
	"default:mossycobble",
	"default:brick",
	"default:tree",
	"default:jungletree",
	"default:coal",
	"default:iron",
}

-- Local Functions
local dbg = function(s)
	if DEBUG == 1 then
		print('[POISONIVY] ' .. s)
	end
end

local is_node_loaded = function(nodenames, node_pos)
	n = minetest.env:get_node_or_nil(node_pos)
	if (n == nil) or (n.name == 'ignore') then
		return false
	end
	return true
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

				if (rnd > (MAX_RATIO / 10) ) then
					if (n_top.name == "poisonivy:seedling") and (is_node_loaded(grownames, p_top) == true) then
						dbg('Growing seedling at ('
						  .. p_top.x .. ', '
						  .. p_top.y .. ', '
						  .. p_top.z .. ') into sproutling' )
						minetest.env:add_node(p_top, { name = "poisonivy:sproutling" })
					end
				end

				if (MAX_RATIO - surface.chance < rnd) then
					if (n_top.name == "air") and (is_node_loaded(grownames, p_top) == true) then

						local nnode = grownames[math.random(1, #grownames)]
						dbg('Adding node '
						  .. nnode .. ' ('
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

grow_on_walls = function(growdelay, grownames, walls)
	for _, wall in ipairs(walls) do
		minetest.register_abm({
			nodenames = { wall.name },
			interval = growdelay,
			chance = 30,
			action = function(pos, node, active_object_count, active_object_count_wider)

				local p_top = {x = pos.x, y = pos.y + 1, z = pos.z}
				local n_top = minetest.env:get_node(p_top)

				local n_left  = minetest.env:get_node({ x = pos.x - 1, y = pos.y + 1, z = pos.z     })
				local n_right = minetest.env:get_node({ x = pos.x + 1, y = pos.y + 1, z = pos.z     })
				local n_front = minetest.env:get_node({ x = pos.x,     y = pos.y + 1, z = pos.z + 1 })
				local n_back  = minetest.env:get_node({ x = pos.x,     y = pos.y + 1, z = pos.z - 1 })

				local rnd = math.random(1, MAX_RATIO)

				if (MAX_RATIO - wall.chance < rnd) then
					if (n_top.name == "air") and (is_node_loaded(grownames, p_top) == true) then
						for _, nodeside in ipairs(VERTICALS) do
							walldir = 0
							if n_left.name == nodeside then
								walldir = 3
							end

							if n_right.name == nodeside then
								walldir = 2
							end

							if n_front.name == nodeside then
								walldir = 4
							end

							if n_back.name == nodeside then
								walldir = 5
							end

							if walldir ~= 0 then
								local nnode = grownames[math.random(1, #grownames)]
								dbg('Adding node ' .. nnode .. ' ('
								  .. p_top.x .. ', '
								  .. p_top.y .. ', '
								  .. p_top.z .. ') on '
								  .. wall.name .. ' side '
								  .. walldir)
								minetest.env:add_node(p_top, {name = nnode, param2 = walldir})
							end
						end
					end
				end
			end
		})
	end
end

-- Nodes
minetest.register_node('poisonivy:seedling', {
	description = "Poison ivy (seedling)",
	drawtype = 'plantlike',
	tile_images = { 'poisonivy_seedling.png' },
	inventory_image = 'poisonivy_seedling.png',
	wield_image = 'poisonivy_seedling.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('poisonivy:sproutling', {
	description = "Poison ivy (sproutling)",
	drawtype = 'plantlike',
	tile_images = { 'poisonivy_sproutling.png' },
	inventory_image = 'poisonivy_sproutling.png',
	wield_image = 'poisonivy_sproutling.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node('poisonivy:climbing', {
	description = "Poison ivy (climbing plant)",
	drawtype = 'signlike',
	tile_images = { 'poisonivy_climbing.png' },
	inventory_image = 'poisonivy_climbing.png',
	wield_image = 'poisonivy_climbing.png',
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = 'wallmounted',
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "wallmounted",
		--wall_side = = <default>
	},
})

-- spawn seedlings, make them grow into sproutlings
grow_on_surfaces(GROWING_DELAY, {
	"poisonivy:seedling",
	}, {
	{name = "default:dirt_with_grass", chance = 4},
	{name = "default:dirt", chance = 4}

})

-- add climbing variety to random vertical surfaces, but rooted only in dirt or grass
grow_on_walls(GROWING_DELAY, {
	"poisonivy:climbing"
	}, {
	{name = "default:dirt_with_grass", chance = 4},
	{name = "default:dirt", chance = 4},
})

-- make the ivy actually climb up to the top of the wall (over time)

grow_on_walls(GROWING_DELAY, {
	"poisonivy:climbing"
	}, {
	{name = "poisonivy:climbing", chance = 49}
})


print("[PoisonIvy] Loaded!")

