--------------------------------------------------------------------------------
--
-- CONIFERS MOD 0.3
-- For Minetest-c55
-- Created by Cisoun (cysoun[at]gmail.com).
--
-- This mod adds some conifers randomly at a certain altitude.
-- There are two types of conifers: regular and narrow.
-- You can define the altitude at which they spawn and their structure and
-- choose if you want to keep normal trees above this altitude.
--
--------------------------------------------------------------------------------

-- Structure definitions.

local TRUNK_MINHEIGHT = 7
local TRUNK_MAXHEIGHT = 25

local LEAVES_MINHEIGHT = 2
local LEAVES_MAXHEIGHT = 6
local LEAVES_MAXRADIUS = 5
local LEAVES_NARROWRADIUS = 3 -- For narrow typed conifers.

local CONIFERS_DISTANCE = 4
local CONIFERS_ALTITUDE = 30

local REMOVE_TREES = false -- Remove trees above CONIFERS_ALTITUDE?

local SAPLING_CHANCE = 100 -- 1/x chances to grow a sapling.

local INTERVAL = 3600

-- End of structure definitions.



conifers = {}



--------------------------------------------------------------------------------
--
-- Definitions
--
--------------------------------------------------------------------------------

--
-- Node definitions
--
minetest.register_node("conifers:trunk", {
	description = "Conifer trunk",
	tiles = { 
		"conifers_trunktop.png", 
		"conifers_trunktop.png", 
		"conifers_trunk.png", 
		"conifers_trunk.png", 
		"conifers_trunk.png", 
		"conifers_trunk.png" 
	},
	--inventory_image = minetest.inventorycube(
		--"conifers_trunktop.png", 
		--"conifers_trunk.png", 
		--"conifers_trunk.png"
	--),
	paramtype = "facedir_simple",
	material = minetest.digprop_woodlike(1.0),
	is_ground_content = true,
	groups = {
		tree = 1,
		snappy = 2,
		choppy = 2,
		oddly_breakable_by_hand = 1,
		flammable = 2
	},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("conifers:trunk_reversed", {
	description = "Conifer reversed trunk",
	tiles = { 
		"conifers_trunk_reversed.png", 
		"conifers_trunk_reversed.png",
		"conifers_trunktop.png", 
		"conifers_trunktop.png", 
		"conifers_trunk_reversed.png", 
		"conifers_trunk_reversed.png" 
	},
	--inventory_image = minetest.inventorycube(
		--"conifers_trunk.png",
		--"conifers_trunktop.png",
		--"conifers_trunk.png"
	--),
	paramtype = "facedir_simple",
	material = minetest.digprop_woodlike(1.0),
	legacy_facedir_simple = true,
	is_ground_content = true,
	groups = {
		tree = 1,
		snappy = 2,
		choppy = 2,
		oddly_breakable_by_hand = 1,
		flammable = 2
	},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("conifers:leaves", {
	description = "Conifer leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = { "conifers_leaves.png" },
	--inventory_image = "conifers_leaves.png",
	paramtype = "light",
	groups = {
		snappy = 3,
		leafdecay = 3,
		flammable = 2
	},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'conifers:sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'conifers:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("conifers:leaves_special", {
	description = "Bright conifer leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = { "conifers_leaves_special.png" },
	--inventory_image = "conifers_leaves_special.png",
	paramtype = "light",
	groups = {
		snappy = 3,
		leafdecay = 3,
		flammable = 2
	},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'conifers:sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'conifers:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_node("conifers:sapling", {
	description = "Conifer sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"conifers_sapling.png"},
	inventory_image = "conifers_sapling.png",
	wield_image = "conifers_sapling.png",
	paramtype = "light",
	walkable = false,
	groups = {
		snappy = 2,
		dig_immediate = 3,
		flammable = 2
	},
	sounds = default.node_sound_defaults(),
})



--
-- Craft definitions
--
minetest.register_craft({
	output = 'node "conifers:trunk_reversed" 2',
	recipe = {
		{'node "conifers:trunk"', 'node "conifers:trunk"'},
	}
})

minetest.register_craft({
	output = 'node "conifers:trunk" 2',
	recipe = {
		{'node "conifers:trunk_reversed"'},
		{'node "conifers:trunk_reversed"'}
	}
})

minetest.register_craft({
	output = 'default:wood 4',
	recipe = {
		{'conifers:trunk'}
	}
})

minetest.register_craft({
	output = 'default:wood 4',
	recipe = {
		{'conifers:trunk_reversed'}
	}
})


--
-- ABM definitions
--
-- Spawn random conifers.
minetest.register_abm({
	nodenames = "default:dirt_with_grass",
	interval = INTERVAL,
	chance = 1,
	
	action = function(pos, node, _, _)
   		if minetest.env:get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air"
   			and pos.y >= CONIFERS_ALTITUDE
   			and conifers:is_node_in_cube({"conifers:trunk"}, pos, CONIFERS_DISTANCE) == false
   		then
   			if math.random(0,1000) == 5 then
   				conifers:make_conifer({x = pos.x, y = pos.y + 1, z = pos.z}, math.random(0, 1))
   			end
		end
    end
})

-- Saplings.
minetest.register_abm({
	nodenames = "conifers:sapling",
	interval = INTERVAL,
	chance = SAPLING_CHANCE,
	
	action = function(pos, node, _, _)
   		if minetest.env:get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air" then
   			conifers:make_conifer({x = pos.x, y = pos.y, z = pos.z}, math.random(0, 1))
   		end
    end
})

-- Should we remove all the trees above the conifers altitude?
if REMOVE_TREES == true then
	minetest.register_abm({
		nodenames = {
			"default:tree", 
			"default:leaves"
		},
		interval = INTERVAL/100,
		chance = 1,
		
		action = function(pos, node, _, _)
			if minetest.env:get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air"
				and pos.y >= CONIFERS_ALTITUDE
			then
				minetest.env:add_node(pos , {name = "air"})
			end
		end
	})
end



--------------------------------------------------------------------------------
--
-- Functions
--
--------------------------------------------------------------------------------

--
-- table_contains(t, v)
--
-- Taken from the Flowers mod by erlehmann.
--
function conifers:table_contains(t, v)
    for _, i in ipairs(t) do
		if (i == v) then
			return true
		end
    end
    return false
end

--
-- is_node_in_cube(nodenames, node_pos, radius)
--
-- Taken from the Flowers mod by erlehmann.
--
function conifers:is_node_in_cube(nodenames, node_pos, radius)
    for x = node_pos.x - radius, node_pos.x + radius do
		for y = node_pos.y - math.floor(radius / 2), node_pos.y + math.floor(radius / 2) do
			for z = node_pos.z - radius, node_pos.z + radius do
				n = minetest.env:get_node_or_nil({x = x, y = y, z = z})
				if (n == nil)
					or (n.name == 'ignore')
					or (conifers:table_contains(nodenames, n.name) == true) then
					return true
				end
			end
		end
    end
    return false
end

--
-- are_leaves_surrounded(position)
--
-- Return a boolean value set to 'true' if a leaves block is surrounded
-- by something else than
--  - air
--  - leaves
--  - special leaves
--
-- If a leaves block is surrounded by the blocks above, 
-- it can be placed.
-- Otherwise, it will replace blocks we want to keep.
--
function conifers:are_leaves_surrounded(pos)
	--
	-- Check if a leaves block does not interfer with something else than the air or another leaves block.
	--
	local node1 = minetest.env:get_node({x = pos.x + 1, y = pos.y, z = pos.z}).name
	local node2 = minetest.env:get_node({x = pos.x - 1, y = pos.y, z = pos.z}).name
	local node3 = minetest.env:get_node({x = pos.x, y = pos.y, z = pos.z + 1}).name
	local node4 = minetest.env:get_node({x = pos.x, y = pos.y, z = pos.z - 1}).name
	local replacable_nodes = {
		"air", 
		"conifers:leaves", 
		"conifers:leaves_special"
	}

	-- Let's check if the neighboring node is a replacable node.
	if (conifers:table_contains(replacable_nodes, node1) == true)
		and (conifers:table_contains(replacable_nodes, node2) == true)
		and (conifers:table_contains(replacable_nodes, node3) == true)
		and (conifers:table_contains(replacable_nodes, node4) == true)
	then
		return false
	else
		return true
	end
end

--
-- add_leaves_block(position, type of leaves, near trunk?)
--
-- Put a simple leaves block.
-- Leaves must be positioned near a trunk or surrounded by air.
-- Types of leaves are:
-- 	0: dark leaves
--	1: bright leaves (special)
--
function conifers:add_leaves_block(pos, special, near_trunk)
	if conifers:are_leaves_surrounded(pos) == false or near_trunk == true then
		if special == 0 then
			minetest.env:add_node(pos , { name = "conifers:leaves" })
		else
			minetest.env:add_node(pos , { name = "conifers:leaves_special" })
		end
	end
end

--
-- make_leaves(middle point, min radius, max radius, type of leaves)
--
-- Make a circle of leaves with a center given by 'middle point'.
-- Types of leaves are:
-- 	0: dark leaves
--	1: bright leaves (special)
--
function conifers:make_leaves(c, radius_min, radius_max, special)
	--
	-- Using the midpoint circle algorithm from Bresenham we can trace a circle of leaves.
	--
	for r = radius_min, radius_max do
		local m_x = 0
		local m_z = r
		local m_m = 5 - 4 * r		
		while m_x <= m_z do
			if radius_max > 1 then
				if r == 1 then
					-- Add a square of leaves (fixing holes near the trunk).
					-- [ ]   [ ]
					--    [#]
					-- [ ]   [ ]
					conifers:add_leaves_block({x = -1 + c.x, 	y = c.y, z = 1 + c.z}, special)
					conifers:add_leaves_block({x = 1 + c.x, 	y = c.y, z = 1 + c.z}, special)
					conifers:add_leaves_block({x = -1 + c.x, 	y = c.y, z = -1 + c.z}, special)
					conifers:add_leaves_block({x = 1 + c.x, 	y = c.y, z = -1 + c.z}, special)
	 				--    [ ]
					-- [ ][#][ ]
					--    [ ]
					conifers:add_leaves_block({x = c.x, 		y = c.y, z = -1 + c.z}, special, true)
					conifers:add_leaves_block({x = c.x, 		y = c.y, z = 1 + c.z}, special, true)
					conifers:add_leaves_block({x = -1 + c.x, 	y = c.y, z = c.z}, special, true)
					conifers:add_leaves_block({x = 1 + c.x, 	y = c.y, z = c.z}, special, true)
				else
					conifers:add_leaves_block({x = m_x + c.x, 	y = c.y, z = m_z + c.z}, special)
					conifers:add_leaves_block({x = m_z + c.x, 	y = c.y, z = m_x + c.z}, special)
					conifers:add_leaves_block({x = -m_x + c.x, 	y = c.y, z = m_z + c.z}, special)
					conifers:add_leaves_block({x = -m_z + c.x, 	y = c.y, z = m_x + c.z}, special)
					conifers:add_leaves_block({x = m_x + c.x, 	y = c.y, z = -m_z + c.z}, special)
					conifers:add_leaves_block({x = m_z + c.x, 	y = c.y, z = -m_x + c.z}, special)
					conifers:add_leaves_block({x = -m_x + c.x, 	y = c.y, z = -m_z + c.z}, special)
					conifers:add_leaves_block({x = -m_z + c.x, 	y = c.y, z = -m_x + c.z}, special)	
				end
			else
				-- Put a small circle of leaves around the trunk.
 				--    [ ]
				-- [ ][#][ ]
				--    [ ]
				conifers:add_leaves_block({x = c.x, 		y = c.y, z = -1 + c.z}, special, true)
				conifers:add_leaves_block({x = c.x, 		y = c.y, z = 1 + c.z}, special, true)
				conifers:add_leaves_block({x = -1 + c.x, 	y = c.y, z = c.z}, special, true)
				conifers:add_leaves_block({x = 1 + c.x, 	y = c.y, z = c.z}, special, true)
			end
			-- Stuff...
			if m_m > 0 then
				m_z = m_z - 1
				m_m = m_m - 8 * m_z
			end
			m_x = m_x + 1
			m_m = m_m + 8 * m_x + 4
		end
	end
end

--
-- make_conifer(position, type)
--
-- Make a conifer at a given position.
-- Types are:
-- 	0: regular pine
--	1: narrow pine
--
function conifers:make_conifer(pos, conifer_type)
	-- Check if we can gros a conifer at this place.
	if minetest.env:get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name ~= "default:dirt_with_grass"
		and (minetest.env:get_node({x = pos.x, y = pos.y, z = pos.z}).name ~= "air"
			or minetest.env:get_node({x = pos.x, y = pos.y, z = pos.z}).name ~= "conifers:sapling"
		)
	then
		return false
	--else
		--if minetest.env:get_node({x = pos.x, y = pos.y, z = pos.z}).name == "conifers:sapling" then
			--minetest.env:add_node(pos , {name = "air"})
		--end
	end
	
	local height = math.random(TRUNK_MINHEIGHT, TRUNK_MAXHEIGHT) -- Random height of the conifer.
	local leaves_height = math.random(LEAVES_MINHEIGHT, LEAVES_MAXHEIGHT) -- Level from where the leaves grow.
	local current_block = {} -- Duh...
	local leaves_radius = 1
	local leaves_max_radius = 2
	local special = math.random(0, 1)

	-- Let's check if we can grow a tree here.
	-- That means, we must have a column of 'height' high which contains
	-- only air.
	for j = 1, height - 1 do -- Start from 1 so we can grow a sapling.
		if minetest.env:get_node({x = pos.x, y = pos.y + j, z = pos.z}).name ~= "air" then
			-- Abort
			return false
		end
	end

	-- Create the trunk and add the leaves.
	for i = 0, height - 1 do
		current_block = {
			x = pos.x,
			y = pos.y + i,
			z = pos.z
		}
		-- Put a trunk block.
		minetest.env:add_node(current_block , {name = "conifers:trunk"})
		-- Put some leaves.
		if i >= leaves_height then
			-- Put some leaves.
			conifers:make_leaves({x = pos.x,	y = pos.y + leaves_height + (height - 1) - i, z = pos.z}, 1, leaves_radius, special)
			--
			-- TYPE OF CONIFER
			--
			if conifer_type == 1 then -- Regular type
				-- Prepare the next circle of leaves.
				leaves_radius = leaves_radius + 1
				-- Check if the current radius is the maximum radius at this level.
				if leaves_radius > leaves_max_radius then
					leaves_radius = 1
					leaves_max_radius = leaves_max_radius + 1
					-- Does it exceeds the maximum radius?
					if leaves_max_radius > LEAVES_MAXRADIUS then
						leaves_max_radius = LEAVES_MAXRADIUS
					end
				end
			else -- Narrow type
				if i % 2 == 0 then
					leaves_radius = LEAVES_NARROWRADIUS - math.random(0, 1)
				else
					leaves_radius = math.floor(LEAVES_NARROWRADIUS / 2)
				end
			end
		end
	end

	-- Put a top leaves block.
	current_block.y = current_block.y + 1
	conifers:add_leaves_block(current_block, special)

	-- Blahblahblah
	print ('[conifers] A conifer has grown at (' .. pos.x .. ',' .. pos.y .. ',' .. pos.z .. ') with a height of ' .. (height))
	
	return true
end
