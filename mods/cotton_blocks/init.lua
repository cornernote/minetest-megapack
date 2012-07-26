
local CB_NAMES_COLORS = {
	["white"] = "White cotton block",
	["light_gray"] = "Light-gray cotton block",
	["gray"] = "Gray cotton block",
	["black"] = "Black cotton block",
	["red"] = "Red cotton block",
	["orange"] = "Orange cotton block",
	["yellow"] = "Yellow cotton block",
	["lime"] = "Lime cotton block",
	["green"] = "Green cotton block",
	["light_blue"] = "Light-blue cotton block",
	["cyan"] = "Cyan cotton block",
	["blue"] = "Blue cotton block",
	["purple"] = "Purple cotton block",
	["magenta"] = "Magenta cotton block",
	["pink"] = "Pink cotton block",
	["brown"] = "Brown cotton block",
}

function default.node_sound_cotton_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="cotton_blocks_cotton_step", gain=0.25}
	table.dig = table.dig or
			{name="cotton_blocks_cotton_step", gain=0.6}
	table.dug = table.dug or
			{name="", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

minetest.register_craft({
	output = 'cotton_blocks:white',
	recipe = {
		{'flowers:cotton','flowers:cotton'},
		{'flowers:cotton','flowers:cotton'},
	}
})
 
for color, name in pairs(CB_NAMES_COLORS) do
	minetest.register_node("cotton_blocks:" .. color, {
		description = name,
		tiles = "cb_" .. color .. ".png",
		inventory_image = "cb_" .. color .. ".png",
		is_ground_content = true,
		groups = {snappy=3, cotton=1},
		sounds = default.node_sound_cotton_defaults(),
		stack_max = 128,
	})
	dye.add_dye_recipe("cotton_blocks:" .. color,"cotton_blocks:white",color)
	dye.add_dye_recipe("cotton_blocks:white","cotton_blocks:" .. color,"white")
end
