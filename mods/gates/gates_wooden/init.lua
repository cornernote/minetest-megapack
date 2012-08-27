
minetest.register_alias("gates:gate",'gates_wooden:classic')
minetest.register_alias("gates:gate_open",'gates_wooden:classic_open')

-- 
-- Nodes
--
gates.register_node('gates_wooden:long', {
	description = "Long Gate",
    groups = {choppy=2,dig_immediate=2},
    paramtype2 = "facedir",
    drop = "gates_wooden:long",
    selection_box = {
		type = "fixed",
		fixed = {
			{-0.9, -0.25, -0.1, 0.9, 0.25, 0.1},
		},
	},
	tile_images = {'default_wood.png'},
	sunlight_propagates = true,
    paramtype = "light",
},
{
    drawtype = 'nodebox',
    node_box = {
		type = "fixed",
		fixed = {
			{-1, -0.25, -0.1, -0.9, 0.25, 1},
			{ 0.9, 0.25, 1,1, -0.25, -0.1},
		},
	},
},
{
	drawtype = 'nodebox',
    node_box = {
		type = "fixed",
		fixed = {
			{-1, -0.25, -0.1, 1, 0.25, 0.1},
		},
	},
	walkable = true,
})

gates.register_node('gates_wooden:short', {
	description = "Short Gate",
    groups = {choppy=2,dig_immediate=2},
    paramtype2 = "facedir",
    drop = "gates_wooden:short",
    selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.06, 0.5, 0.5, 0.06},
		},
	},
	tile_images = {'default_wood.png'},
	--sunlight_propagates = true,
    paramtype = "light",
},
{
    drawtype = 'nodebox',
    node_box = {
		type = "fixed",
		fixed = {
			--Left
			{-0.5, -0.15, -0.06, -0.4, 0.4,  0.19},     --|
			{-0.5,  0,     0.34, -0.4, 0.25, 0.50},     --  |
			{-0.5,  0.25,  0.19, -0.4, 0.4,  0.50},     -- -
			{-0.5, -0.15,  0.19, -0.4, 0,    0.50},     -- _
			
			--Right
			{0.4, -0.15, -0.06, 0.5, 0.4,  0.19},     --|
			{0.4,  0,     0.34, 0.5, 0.25, 0.50},     --  |
			{0.4,  0.25,  0.19, 0.5, 0.4,  0.50},     -- -
			{0.4, -0.15,  0.19, 0.5, 0,    0.50},     -- _
		},
	},
	walkable = false,
},
{
	drawtype = 'nodebox',
    node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.15, -0.06, -0.25, 0.4, 0.06},   --|
			{0.25, -0.15, -0.06, 0.5, 0.4, 0.06},     --  |
			{-0.125, 0, -0.06, 0.125, 0.25, 0.06},    -- |
			{-0.25, 0.25, -0.06, 0.25, 0.4, 0.06},    -- -
			{0.25, 0, -0.06, -0.25, -0.15, 0.06},     -- _
		},
	},
	walkable = true,
})

gates.register_node('gates_wooden:classic', {
	description = "Gate",
    groups = {choppy=2,dig_immediate=2},
    drop = "gates:gate",
},
{
    drawtype = 'plantlike',
    sunlight_propagates = true,
    paramtype = "light",
    visual_scale = 1.5,
	tile_images = {'gate_wooden_open.png'},
	walkable = false,
},
{
	tile_images = {'gate_wooden_top.png','gate_wooden_top.png','gate_wooden.png'},
	walkable = true,
})


--
-- Crafts
--
minetest.register_craft({
    output = '"gates_wooden:classic" 2',
    recipe = {
        {"default:stick", "default:wood", "default:stick"},
        {"default:stick", "default:wood", "default:stick"},
    },
})

minetest.register_craft({
    output = '"gates_wooden:long" 1',
    recipe = {
        {"default:stick", "default:wood", "default:stick"},
    },
})

minetest.register_craft({
    output = '"gates_wooden:short" 1',
    recipe = {
        {"default:stick", "default:stick"},
    },
})

