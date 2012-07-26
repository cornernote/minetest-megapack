-- stone bricks

SB_NAMES_COLORS = {
	["white"] = "White stone brick",
	["light_gray"] = "Light-gray stone brick",
	["gray"] = "Gray stone brick",
	["black"] = "Black stone brick",
	["red"] = "Red stone brick",
	["orange"] = "Orange stone brick",
	["yellow"] = "Yellow stone brick",
	["lime"] = "Lime stone brick",
	["green"] = "Green stone brick",
	["light_blue"] = "Light-blue stone brick",
	["cyan"] = "Cyan stone brick",
	["blue"] = "Blue stone brick",
	["purple"] = "Purple stone brick",
	["magenta"] = "Magenta stone brick",
	["pink"] = "Pink stone brick",
	["brown"] = "Brown stone brick",
}


-- Stone brick
minetest.register_craft({
	output = 'node "stone_brick:stone_brick" 4',
	recipe = {
		{'node "default:stone"','node "default:stone"'},
		{'node "default:stone"','node "default:stone"'},
	}
})
minetest.register_node("stone_brick:stone_brick", {
	tiles = {"default_stone.png^stone_brick_stone_brick.png"},
	paramtype = "mineral",
	is_ground_content = true,
	groups = {cracky=2, level=2},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 128,
})

-- Desert stone brick
minetest.register_craft({
	output = "stone_brick:desert_stone_brick 4",
	recipe = {
		{"default:desert_stone","default:desert_stone"},
		{"default:desert_stone","default:desert_stone"},
	}
})
minetest.register_node("stone_brick:desert_stone_brick", {
	tiles = {"stone_brick_desert_stone.png"},
	paramtype = "mineral",
	is_ground_content = true,
	groups = {cracky=2, level=2},
	sounds = default.node_sound_stone_defaults(),
	stack_max = 128,
})

-- Colored bricks:
for color, name in pairs(SB_NAMES_COLORS) do
	local texture = "stone_brick_" .. color .. ".png"
	minetest.register_node("stone_brick:" .. color .. "_stone_brick", {
		description = name,
		paramtype = "mineral",
		tiles = {texture},
		is_ground_content = true,
		groups = {cracky=2, level=2},
		sounds = default.node_sound_cotton_defaults(),
		stack_max = 128,
	})
	dye.add_dye_recipe("stone_brick:" .. color .. "_stone_brick","stone_brick:stone_brick",color)
	dye.add_dye_recipe("stone_brick:white","stone_brick:" .. color .. "_stone_brick","white")
end
