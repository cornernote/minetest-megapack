--Mod Name: KBlocks
--Author: Kapelutek (konrado95)
--Last Edit: 02.06.2012
--About Mod: Add blocks to MineTest
--MineTest Version: MineTest-C55 0.4.dev-20120408 

---------------------------------------------------------------------------------------------------------

--01.Overgrown Cobble

minetest.register_node("kblocks:overgrown_cobble", {
tiles = {"kblocks_overgrown_cobble.png"},
description = "Overgrown Cobble",
is_ground_content = true,
groups = {cracky=3},
})

minetest.register_craft({
output = '"kblocks:overgrown_cobble" 4',
recipe = {
{'', '', ''},
{'default:cobble', 'default:leaves', ''},
{'', '', ''},
}
})

---------------------------------------------------------------------------------------------------------

--02.Desert Ore

minetest.register_craftitem("kblocks:desert_ingot", {
	description = "Desert Ore Ingot",
	image = "desert_ore_ingot.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

--

minetest.register_craft({
    type = "cooking",
    output = "kblocks:desert_ingot","default:desert_sand",
    recipe = "default:desert_stone",
})

---------------------------------------------------------------------------------------------------------

--03.Knife

minetest.register_craftitem("kblocks:small_knife", {
	description = "Small Knife",
	image = "small_knife.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craft({
output = '"kblocks:small_knife" 10',
recipe = {
{'', '', ''},
{'', 'default:cobble', ''},
{'default:stick', '', ''},
}
})

---------------------------------------------------------------------------------------------------------

--04.Pumpkin

minetest.register_node("kblocks:pumpkin", {
tiles = {"pumpkin_top.png", "pumpkin_down.png", "pumpkin_front.png",
		"pumpkin_front.png", "pumpkin_front.png", "pumpkin_front.png"},
description = "Pumpkin",
is_ground_content = true,
groups = {oddly_breakable_by_hand=2},
})

minetest.register_craft({
output = '"kblocks:pumpkin" 8',
recipe = {
{'', 'kblocks:desert_ingot', ''},
{'kblocks:desert_ingot', 'default:leaves', 'kblocks:desert_ingot'},
{'', 'kblocks:desert_ingot', ''},
}
})

---------------------------------------------------------------------------------------------------------

--05.Hallowen Pumpkin

minetest.register_node("kblocks:hallowen_pumpkin", {
tiles = {"pumpkin_top.png", "pumpkin_down.png", "hallowen_pumpkin_front.png",
		"hallowen_pumpkin_front.png", "hallowen_pumpkin_front.png", "hallowen_pumpkin_front.png"},
description = "Hallowen Pumpkin",
is_ground_content = true,
groups = {oddly_breakable_by_hand=2},
})

minetest.register_craft({
output = '"kblocks:hallowen_pumpkin" 1',
recipe = {
{'', '', ''},
{'kblocks:small_knife', 'kblocks:pumpkin', ''},
{'', '', ''},
}
})

---------------------------------------------------------------------------------------------------------

--06.Lighting Hallowen Pumpkin

minetest.register_node("kblocks:lighting_hallowen_pumpkin", {
tiles = {"pumpkin_top.png", "pumpkin_down.png", "lighting_hallowen_pumpkin_front.png",
		"lighting_hallowen_pumpkin_front.png", "lighting_hallowen_pumpkin_front.png", "lighting_hallowen_pumpkin_front.png"},
description = "Lighting Hallowen Pumpkin",
is_ground_content = true,
light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 20,
groups = {oddly_breakable_by_hand=2},
})

minetest.register_craft({
output = '"kblocks:lighting_hallowen_pumpkin" 1',
recipe = {
{'default:torch', 'default:torch', 'default:torch'},
{'default:torch', 'kblocks:hallowen_pumpkin', 'default:torch'},
{'default:torch', 'default:torch', 'default:torch'},
}
})

---------------------------------------------------------------------------------------------------------

--07.Empty Glass

minetest.register_craftitem("kblocks:empty_glass", {
	description = "Empty Glass",
	image = "empty_glass.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craft({
output = '"kblocks:empty_glass" 8',
recipe = {
{'', '', ''},
{'default:glass', '', 'default:glass'},
{'default:glass', 'default:glass', 'default:glass'},
}
})

---------------------------------------------------------------------------------------------------------

--08.Iblon

minetest.register_craftitem("kblocks:iblon", {
	description = "Iblon",
	image = "iblon.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craft({
output = '"kblocks:iblon" 10',
recipe = {
{'', 'default:cobble', ''},
{'default:cobble', '', 'default:cobble'},
{'default:stick', 'default:cobble', ''},
}
})

---------------------------------------------------------------------------------------------------------

--09.Pumpkin Seeds

minetest.register_craftitem("kblocks:pumpkin_seeds", {
	description = "Pumpkin Seeds",
	image = "pumpkin_seeds.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craft({
output = '"kblocks:pumpkin_seeds" 80',
recipe = {
{'', '', ''},
{'kblocks:iblon', 'kblocks:pumpkin', ''},
{'', '', ''},
}
})

---------------------------------------------------------------------------------------------------------

--10.Pumpkin Juice

minetest.register_craftitem("kblocks:pumpkin_juice", {
	description = "Pumpkin Juice",
	image = "pumpkin_juice.png",
	groups = {fleshy=3,dig_immediate=3,flammable=2},
	on_use = minetest.item_eat(1),
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craft({
output = '"kblocks:pumpkin_juice" 1',
recipe = {
{'kblocks:pumpkin_seeds', 'kblocks:pumpkin_seeds', 'kblocks:pumpkin_seeds'},
{'kblocks:pumpkin_seeds', 'kblocks:empty_glass', 'kblocks:pumpkin_seeds'},
{'kblocks:pumpkin_seeds', 'kblocks:pumpkin_seeds', 'kblocks:pumpkin_seeds'},
}
})

---------------------------------------------------------------------------------------------------------

--11.Colorous Woods

--a)Clear Wood

minetest.register_node("kblocks:clear_wood", {
tiles = {"clear_wood.png",},
description = "Clear Wood",
is_ground_content = true,
groups = {oddly_breakable_by_hand=2},
})

minetest.register_craft({
output = '"kblocks:clear_wood" 1',
recipe = {
{'', '', ''},
{'kblocks:clear_pigment', 'default:wood', ''},
{'', '', ''},
}
})

--b)Dark Wood

minetest.register_node("kblocks:dark_wood", {
tiles = {"dark_wood.png",},
description = "Dark Wood",
is_ground_content = true,
groups = {oddly_breakable_by_hand=2},
})

minetest.register_craft({
output = '"kblocks:dark_wood" 1',
recipe = {
{'', '', ''},
{'kblocks:dark_pigment', 'default:wood', ''},
{'', '', ''},
}
})

--c)Red Wood

minetest.register_node("kblocks:red_wood", {
tiles = {"red_wood.png",},
description = "Red Wood",
is_ground_content = true,
groups = {oddly_breakable_by_hand=2},
})

minetest.register_craft({
output = '"kblocks:red_wood" 1',
recipe = {
{'', '', ''},
{'kblocks:red_pigment', 'default:wood', ''},
{'', '', ''},
}
})

---------------------------------------------------------------------------------------------------------

--12.Magic Powder

minetest.register_craftitem("kblocks:magic_powder", {
	description = "Magic Powder",
	image = "magic_powder.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craft({
output = '"kblocks:magic_powder" 20',
recipe = {
{'', '', ''},
{'', 'kblocks:desert_ingot', ''},
{'', '', ''},
}
})

---------------------------------------------------------------------------------------------------------

--13.Pigments

--a)Clear Pigment

minetest.register_craftitem("kblocks:clear_pigment", {
	description = "Clear Pigment",
	image = "clear_pigment.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craft({
output = '"kblocks:clear_pigment" 4',
recipe = {
{'', 'kblocks:magic_powder', ''},
{'', 'default:sand', ''},
{'', 'kblocks:empty_glass', ''},
}
})

--b)Dark Pigment

minetest.register_craftitem("kblocks:dark_pigment", {
	description = "Dark Pigment",
	image = "dark_pigment.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craft({
output = '"kblocks:dark_pigment" 4',
recipe = {
{'', 'kblocks:magic_powder', ''},
{'', 'default:coal_lump', ''},
{'', 'kblocks:empty_glass', ''},
}
})

--c)Red Pigment

minetest.register_craftitem("kblocks:red_pigment", {
	description = "Red Pigment",
	image = "red_pigment.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craft({
output = '"kblocks:red_pigment" 4',
recipe = {
{'', 'kblocks:magic_powder', ''},
{'', 'kblocks:magic_powder', ''},
{'', 'kblocks:empty_glass', ''},
}
})
