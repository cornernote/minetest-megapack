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
	"purple",
	"blue",
	"red",
	"green",
	"black",
}

-- Nodes


	for _, colour in ipairs(DYES) do
	local cname = colour .. 'checker'

	minetest.register_node('blox:' .. cname, {
		description = colour .. " checker",
		tiles = { 'blox_' .. cname .. '.png' },
		inventory_image = 'blox_' .. cname .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

for _, colour2 in ipairs(DYES) do
	local sname = colour2 .. 'square'

	minetest.register_node('blox:' .. sname, {
		description = colour2 .. " stone square",
		tiles = { 'blox_' .. sname .. '.png' },
		inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

for _, colour7 in ipairs(DYES) do
	local sname = colour7 .. 'stone'

	minetest.register_node('blox:' .. sname, {
		description = colour7 .. " stone",
		tiles = { 'blox_' .. sname .. '.png' },
		inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

for _, colour8 in ipairs(DYES) do
	local sname = colour8 .. 'cross'

	minetest.register_node('blox:' .. sname, {
		description = colour8 .. " cross",
		tiles = { 'blox_' .. sname .. '.png' },
		inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

for _, colour10 in ipairs(DYES) do
	local sname = colour10 .. 'wood'

	minetest.register_node('blox:' .. sname, {
		description = colour10 .. " wood",
		tiles = { 'blox_' .. sname .. '.png' },
		inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
	})
end

for _, colour11 in ipairs(DYES) do
	local sname = colour11 .. 'loop'

	minetest.register_node('blox:' .. sname, {
		description = colour11 .. " decorative block",
		tiles = { 'blox_' .. sname .. '.png' },
		inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

for _, colour12 in ipairs(DYES) do
	local sname = colour12 .. 'quarter'

	minetest.register_node('blox:' .. sname, {
		description = colour12 .. " large checker",
		tiles = { 'blox_' .. sname .. '.png' },
		inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

for _, colour13 in ipairs(DYES) do
	local sname = colour13 .. 'quarter_wood'

	minetest.register_node('blox:' .. sname, {
		description = colour13 .. " large wooden checker",
		tiles = { 'blox_' .. sname .. '.png' },
		inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
	})
end

for _, colour14 in ipairs(DYES) do
	local sname = colour14 .. 'checker_wood'

	minetest.register_node('blox:' .. sname, {
		description = colour14 .. " wooden checker",
		tiles = { 'blox_' .. sname .. '.png' },
		inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
	})
end

for _, colour15 in ipairs(DYES) do
	local sname = colour15 .. 'corner'

	minetest.register_node('blox:' .. sname, {
		description = colour15 .. " corners",
		tiles = { 'blox_' .. sname .. '.png' },
		inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

minetest.register_node("blox:glowstone", {
	description = "Glowstone",
	tiles = {"blox_glowstone.png"},
	inventory_image = "blox_glowstone.png",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 30	,
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

for _, colour22 in ipairs(DYES) do
	local sname = colour22 .. 'cobble'

	minetest.register_node('blox:' .. sname, {
		description = colour22 .. " cobble",
		tiles = { 'blox_' .. sname .. '.png' },
		inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_stone_defaults(),
	})
end

-- Dyes

for _, colour3 in ipairs(DYES) do
local dname = colour3  .. "dye"
minetest.register_craftitem("blox:" .. dname, {
	description = colour3 .. " dye",
	inventory_image = "blox_" .. dname .. ".png",
})
end



-- Crafting

minetest.register_craft({
	output = 'blox:blackdye 4',
	recipe = {
		{'default:coal'},
	}
})

minetest.register_craft({
	output = 'blox:reddye 4',
	recipe = {
		{'default:apple'},
	}
})

minetest.register_craft({
	output = 'blox:pinkdye 4',
	recipe = {
		{'flowers:flower_rose'},
	}
})

minetest.register_craft({
	output = 'blox:greendye 4',
	recipe = {
		{'default:cactus'},
	}
})

minetest.register_craft({
	output = 'blox:yellowdye 4',
	recipe = {
		{'flowers:flower_dandelion_yellow'},
	}
})

minetest.register_craft({
	output = 'blox:whitedye 4',
	recipe = {
		{'flowers:flower_dandelion_white'},
	}
})

minetest.register_craft({
	output = 'blox:bluedye 4',
	recipe = {
		{'flowers:flower_waterlily'},
	}
})

minetest.register_craft({
	output = 'blox:orangedye 4',
	recipe = {
		{'flowers:flower_tulip'},
	}
})

minetest.register_craft({
	output = 'blox:purpledye 4',
	recipe = {
		{'flowers:flower_viola'},
	}
})

minetest.register_craft({
	output = 'blox:orangedye',
	recipe = {
		{'blox:reddye'},
		{'blox:yellowdye'},
	}
})

minetest.register_craft({
	output = 'blox:orangedye',
	recipe = {
		{'blox:yellowdye'},
		{'blox:reddye'},
	}
})

minetest.register_craft({
	output = 'blox:purpledye',
	recipe = {
		{'blox:reddye'},
		{'blox:bluedye'},
	}
})

minetest.register_craft({
	output = 'blox:purpledye',
	recipe = {
		{'blox:bluedye'},
		{'blox:reddye'},
	}
})

minetest.register_craft({
	output = 'blox:greendye',
	recipe = {
		{'blox:bluedye'},
		{'blox:yellowdye'},
	}
})

minetest.register_craft({
	output = 'blox:greendye',
	recipe = {
		{'blox:yellowdye'},
		{'blox:bluedye'},
	}
})


for _, colour4 in ipairs(DYES) do
minetest.register_craft({
	output = 'blox:' .. colour4 ..'quarter 4',
	recipe = {
		{'default:stone', 'blox:' .. colour4 .. 'dye'},
		{'blox:' .. colour4 .. 'dye', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'blox:' .. colour4 ..'quarter 4',
	recipe = {
		{'blox:' .. colour4 .. 'dye', 'default:stone'},
		{'default:stone', 'blox:' .. colour4 .. 'dye'},
	}
})
end

for _, colour5 in ipairs(DYES) do
minetest.register_craft({
	output = 'blox:' .. colour5 ..'square 4',
	recipe = {
		{'', 'moreblocks:stonesquare', ''},
		{'moreblocks:stonesquare', 'blox:' .. colour5 .. 'dye', 'moreblocks:stonesquare'},
		{'', 'moreblocks:stonesquare', ''},
	}
})
end

for _, colour6 in ipairs(DYES) do
minetest.register_craft({
	output = 'blox:' .. colour6 ..'stone 4',
	recipe = {
		{'', 'default:stone', ''},
		{'default:stone', 'blox:' .. colour6 .. 'dye', 'default:stone'},
		{'', 'default:stone', ''},
	}
})
end

for _, colour9 in ipairs(DYES) do
minetest.register_craft({
	output = 'blox:' .. colour9 ..'cross 4',
	recipe = {
		{'default:stone', '', 'default:stone'},
		{'', 'blox:' .. colour9 .. 'dye', ''},
		{'default:stone', '', 'default:stone'},
	}
})
end

minetest.register_craft({
	output = 'blox:glowstone',
	recipe = {
		{'', 'default:torch', ''},
		{'default:torch', 'moreblocks:stonesquare', 'default:torch'},
		{'', 'default:torch', ''},
	}
})

for _, colour16 in ipairs(DYES) do
minetest.register_craft({
	output = 'blox:' .. colour16 ..'wood 4',
	recipe = {
		{'', 'default:wood', ''},
		{'default:wood', 'blox:' .. colour16 .. 'dye', 'default:wood'},
		{'', 'default:wood', ''},
	}
})
end

for _, colour17 in ipairs(DYES) do
minetest.register_craft({
	output = 'blox:' .. colour17 ..'quarter_wood 4',
	recipe = {
		{'default:wood', 'blox:' .. colour17 .. 'dye'},
		{'blox:' .. colour17 .. 'dye', 'default:wood'},
	}
})

minetest.register_craft({
	output = 'blox:' .. colour17 ..'quarter_wood 4',
	recipe = {
		{'blox:' .. colour17 .. 'dye', 'default:wood'},
		{'default:wood', 'blox:' .. colour17 .. 'dye'},
	}
})
end

for _, colour18 in ipairs(DYES) do
minetest.register_craft({
	output = 'blox:' .. colour18 ..'checker_wood 6',
	recipe = {
		{'default:wood', 'blox:' .. colour18 .. 'dye','default:wood'},
		{'blox:' .. colour18 .. 'dye', 'default:wood', 'blox:' .. colour18 .. 'dye'},
		{'default:wood', 'blox:' .. colour18 .. 'dye','default:wood'},
	}
})

minetest.register_craft({
	output = 'blox:' .. colour18 ..'checker_wood 8',
	recipe = {
		{'blox:' .. colour18 .. 'dye', 'default:wood', 'blox:' .. colour18 .. 'dye'},
		{'default:wood', 'blox:' .. colour18 .. 'dye','default:wood'},
		{'blox:' .. colour18 .. 'dye', 'default:wood', 'blox:' .. colour18 .. 'dye'},
	}
})
end

for _, colour19 in ipairs(DYES) do
minetest.register_craft({
	output = 'blox:' .. colour19 ..'checker 6',
	recipe = {
		{'default:stone', 'blox:' .. colour19 .. 'dye','default:stone'},
		{'blox:' .. colour19 .. 'dye', 'default:stone', 'blox:' .. colour19 .. 'dye'},
		{'default:stone', 'blox:' .. colour19 .. 'dye','default:stone'},
	}
})

minetest.register_craft({
	output = 'blox:' .. colour19 ..'checker 8',
	recipe = {
		{'blox:' .. colour19 .. 'dye', 'default:stone', 'blox:' .. colour19 .. 'dye'},
		{'default:stone', 'blox:' .. colour19 .. 'dye','default:stone'},
		{'blox:' .. colour19 .. 'dye', 'default:stone', 'blox:' .. colour19 .. 'dye'},
	}
})
end

for _, colour20 in ipairs(DYES) do
minetest.register_craft({
	output = 'blox:' .. colour20 ..'loop 6',
	recipe = {
		{'default:stone', 'default:stone', 'default:stone'},
		{'default:stone', 'blox:' .. colour20 .. 'dye', 'default:stone'},
		{'default:stone', 'default:stone', 'default:stone'},
	}
})
end

for _, colour21 in ipairs(DYES) do
minetest.register_craft({
	output = 'blox:' .. colour21 ..'cobble 4',
	recipe = {
		{'', 'default:cobble', ''},
		{'default:cobble', 'blox:' .. colour21 .. 'dye', 'default:cobble'},
		{'', 'default:cobble', ''},
	}
})
end

for _, colour23 in ipairs(DYES) do
minetest.register_craft({
	output = 'blox:' .. colour23 ..'corner 4',
	recipe = {
		{'blox:' .. colour23 .. 'dye', '', 'blox:' .. colour23 .. 'dye'},
		{'', 'default:stone', ''},
		{'blox:' .. colour23 .. 'dye', '', 'blox:' .. colour23 .. 'dye'},
	}
})
end

print("Blox Mod [" ..version.. "] Loaded!")
