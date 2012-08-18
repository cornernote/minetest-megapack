--[[
***********
Blox
by Sanchez
***********
--]]
local version = "0.4"
local DYES = {
	"pink",
	"yellow",
	"white",
	"orange",
	"violet",
	"blue",
	"red",
	"green",
	"black",
}
local colour, name


for _, colour in ipairs(DYES) do

	-- checker
	name = colour .. 'checker'
	minetest.register_node('blox:' .. name, {
		description = colour .. " checker",
		tiles = { 'blox_' .. name .. '.png' },
		inventory_image = 'blox_' .. name .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})

	-- square
	name = colour .. 'square'
	minetest.register_node('blox:' .. name, {
		description = colour .. " stone square",
		tiles = { 'blox_' .. name .. '.png' },
		inventory_image = 'blox_' .. name .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})

	-- stone
	name = colour .. 'stone'
	minetest.register_node('blox:' .. name, {
		description = colour .. " stone",
		tiles = { 'blox_' .. name .. '.png' },
		inventory_image = 'blox_' .. name .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})

	-- cross
	name = colour .. 'cross'
	minetest.register_node('blox:' .. name, {
		description = colour .. " cross",
		tiles = { 'blox_' .. name .. '.png' },
		inventory_image = 'blox_' .. name .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})

	-- wood
	name = colour .. 'wood'
	minetest.register_node('blox:' .. name, {
		description = colour .. " wood",
		tiles = { 'blox_' .. name .. '.png' },
		inventory_image = 'blox_' .. name .. '.png',
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
	})

	-- loop
	name = colour .. 'loop'
	minetest.register_node('blox:' .. name, {
		description = colour .. " decorative block",
		tiles = { 'blox_' .. name .. '.png' },
		inventory_image = 'blox_' .. name .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})

	-- quarter
	name = colour .. 'quarter'
	minetest.register_node('blox:' .. name, {
		description = colour .. " large checker",
		tiles = { 'blox_' .. name .. '.png' },
		inventory_image = 'blox_' .. name .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})

	-- quarter_wood
	name = colour .. 'quarter_wood'
	minetest.register_node('blox:' .. name, {
		description = colour .. " large wooden checker",
		tiles = { 'blox_' .. name .. '.png' },
		inventory_image = 'blox_' .. name .. '.png',
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
	})

	-- checker_wood
	name = colour .. 'checker_wood'
	minetest.register_node('blox:' .. name, {
		description = colour .. " wooden checker",
		tiles = { 'blox_' .. name .. '.png' },
		inventory_image = 'blox_' .. name .. '.png',
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
	})

	-- corner
	name = colour .. 'corner'
	minetest.register_node('blox:' .. name, {
		description = colour .. " corners",
		tiles = { 'blox_' .. name .. '.png' },
		inventory_image = 'blox_' .. name .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})

	-- cobble
	name = colour .. 'cobble'
	minetest.register_node('blox:' .. name, {
		description = colour .. " cobble",
		tiles = { 'blox_' .. name .. '.png' },
		inventory_image = 'blox_' .. name .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
	
end


--
-- Crafting
--

for _, colour in ipairs(DYES) do

	-- quarter
	minetest.register_craft({
		output = 'blox:' .. colour ..'quarter 4',
		recipe = {
			{'default:stone', 'dye:' .. colour},
			{'dye:' .. colour, 'default:stone'},
		}
	})
	minetest.register_craft({
		output = 'blox:' .. colour ..'quarter 4',
		recipe = {
			{'dye:' .. colour, 'default:stone'},
			{'default:stone', 'dye:' .. colour},
		}
	})

	-- square
	minetest.register_craft({
		output = 'blox:' .. colour ..'square 4',
		recipe = {
			{'', 'moreblocks:stonesquare', ''},
			{'moreblocks:stonesquare', 'dye:' .. colour, 'moreblocks:stonesquare'},
			{'', 'moreblocks:stonesquare', ''},
		}
	})

	-- stone
	minetest.register_craft({
		output = 'blox:' .. colour ..'stone 4',
		recipe = {
			{'', 'default:stone', ''},
			{'default:stone', 'dye:' .. colour, 'default:stone'},
			{'', 'default:stone', ''},
		}
	})

	-- cross
	minetest.register_craft({
		output = 'blox:' .. colour ..'cross 4',
		recipe = {
			{'default:stone', '', 'default:stone'},
			{'', 'dye:' .. colour, ''},
			{'default:stone', '', 'default:stone'},
		}
	})
	
	-- wood
	minetest.register_craft({
		output = 'blox:' .. colour ..'wood 4',
		recipe = {
			{'', 'default:wood', ''},
			{'default:wood', 'dye:' .. colour, 'default:wood'},
			{'', 'default:wood', ''},
		}
	})
	
	-- quarter_wood
	minetest.register_craft({
		output = 'blox:' .. colour ..'quarter_wood 4',
		recipe = {
			{'default:wood', 'dye:' .. colour},
			{'dye:' .. colour, 'default:wood'},
		}
	})
	minetest.register_craft({
		output = 'blox:' .. colour ..'quarter_wood 4',
		recipe = {
			{'dye:' .. colour, 'default:wood'},
			{'default:wood', 'dye:' .. colour},
		}
	})
	
	-- checker_wood
	minetest.register_craft({
		output = 'blox:' .. colour ..'checker_wood 6',
		recipe = {
			{'default:wood', 'dye:' .. colour,'default:wood'},
			{'dye:' .. colour, 'default:wood', 'dye:' .. colour},
			{'default:wood', 'dye:' .. colour,'default:wood'},
		}
	})
	minetest.register_craft({
		output = 'blox:' .. colour ..'checker_wood 8',
		recipe = {
			{'dye:' .. colour, 'default:wood', 'dye:' .. colour},
			{'default:wood', 'dye:' .. colour,'default:wood'},
			{'dye:' .. colour, 'default:wood', 'dye:' .. colour},
		}
	})
	
	-- checker
	minetest.register_craft({
		output = 'blox:' .. colour ..'checker 6',
		recipe = {
			{'default:stone', 'dye:' .. colour,'default:stone'},
			{'dye:' .. colour, 'default:stone', 'dye:' .. colour},
			{'default:stone', 'dye:' .. colour,'default:stone'},
		}
	})
	minetest.register_craft({
		output = 'blox:' .. colour ..'checker 8',
		recipe = {
			{'dye:' .. colour, 'default:stone', 'dye:' .. colour},
			{'default:stone', 'dye:' .. colour,'default:stone'},
			{'dye:' .. colour, 'default:stone', 'dye:' .. colour},
		}
	})

	-- loop
	minetest.register_craft({
		output = 'blox:' .. colour ..'loop 6',
		recipe = {
			{'default:stone', 'default:stone', 'default:stone'},
			{'default:stone', 'dye:' .. colour, 'default:stone'},
			{'default:stone', 'default:stone', 'default:stone'},
		}
	})
	
	-- cobble
	minetest.register_craft({
		output = 'blox:' .. colour ..'cobble 4',
		recipe = {
			{'', 'default:cobble', ''},
			{'default:cobble', 'dye:' .. colour, 'default:cobble'},
			{'', 'default:cobble', ''},
		}
	})
	
	-- corner
	minetest.register_craft({
		output = 'blox:' .. colour ..'corner 4',
		recipe = {
			{'dye:' .. colour, '', 'dye:' .. colour},
			{'', 'default:stone', ''},
			{'dye:' .. colour, '', 'dye:' .. colour},
		}
	})
	
end

print("Blox Mod [" ..version.. "] Loaded!")
