
minetest.register_tool("gold:pick_gold", {
	description = "Gold Pickaxe",
	inventory_image = "gold_tool_goldpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			cracky={times={[1]=1.7, [2]=0.6, [3]=0.3}, uses=6, maxlevel=3},
			snappy={times={[1]=1.7, [2]=0.6, [3]=0.3}, uses=6, maxlevel=3},
			fastness={times={[1]=19.0, [2]=13.0, [3]=7.5}, uses=6, maxlevel=3}
		}
	},
})
minetest.register_tool("gold:shovel_gold", {
	description = "Gold Shovel",
	inventory_image = "gold_tool_goldshovel.png",
	tool_capabilities = {
		max_drop_level=3,
		groupcaps={
			crumbly={times={[1]=1.10, [2]=0.50, [3]=0.40}, uses=8, maxlevel=3}
		}
	},
})
minetest.register_tool("gold:axe_gold", {
	description = "Gold Axe",
	inventory_image = "gold_tool_goldaxe.png",
	tool_capabilities = {
		max_drop_level=3,
		groupcaps={
			choppy={times={[1]=1.60, [2]=0.90, [3]=0.30}, uses=6, maxlevel=3},
			fleshy={times={[2]=0.90, [3]=0.30}, uses=24, maxlevel=3}
		}
	},
})
minetest.register_tool("gold:sword_gold", {
	description = "Gold Sword",
	inventory_image = "gold_tool_goldsword.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=3,
		groupcaps={
			fleshy={times={[1]=1.00, [2]=0.40, [3]=0.40}, uses=6, maxlevel=3},
			snappy={times={[1]=0.90,[2]=0.30, [3]=0.10}, uses=24, maxlevel=3},
			choppy={times={[1]=0.80,[2]=0.50,[3]=0.20}, uses=24, maxlevel=3}
		}
	}
})

minetest.register_node("gold:gold_ore", {
	description = "Gold ore",
	tiles = {"default_stone.png^gold_ore.png"},
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.2),
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = "gold:gold_nugget",
	stack_max = 128,
})
minetest.register_craftitem("gold:gold_nugget", {
	description = "Gold nugget",
	image = "dye_blue.png",
	stack_max = 128,
})
minetest.register_craftitem("gold:gold_ingot", {
	description = "Gold Ingot",
	image = "gold_ingot.png",
	stack_max = 128,
})
minetest.register_node("gold:gold_block", {
	description = "Gold Block",
	tiles = {"gold_block.png"},
	is_ground_content = true,
	material = minetest.digprop_stonelike(0.8),
	stack_max = 128,
})
minetest.register_craft({
	output = 'gold:gold_block',
	recipe = {
		{ 'gold:gold_ingot','gold:gold_ingot','gold:gold_ingot'},
		{ 'gold:gold_ingot','gold:gold_ingot','gold:gold_ingot'},
		{ 'gold:gold_ingot','gold:gold_ingot','gold:gold_ingot'},
	}
})
minetest.register_craft({
	type = "shapeless",
	type = "cooking",
	output = "gold:gold_ingot",
	recipe = "gold:gold_nugget",
	cooktime = 7,
})
minetest.register_craft({
	output = 'gold:gold_ingot 9',
	recipe = {
		{ 'gold:gold_block'},
	}
})

minetest.register_craft({
	output = 'gold:shovel_gold',
	recipe = {
		{'gold:gold_ingot'},
		{'default:stick'},
		{'default:stick'},
	}
})
minetest.register_craft({
	output = 'gold:pick_gold',
	recipe = {
		{'gold:gold_ingot', 'gold:gold_ingot', 'gold:gold_ingot'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})
minetest.register_craft({
	output = 'gold:axe_gold',
	recipe = {
		{'gold:gold_ingot', 'gold:gold_ingot'},
		{'gold:gold_ingot', 'default:stick'},
		{'', 'default:stick'},
	}
})
minetest.register_craft({
	output = 'gold:sword_gold',
	recipe = {
		{'gold:gold_ingot'},
		{'gold:gold_ingot'},
		{'default:stick'},
	}
})
