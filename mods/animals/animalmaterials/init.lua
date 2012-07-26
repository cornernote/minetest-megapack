local version = "0.0.7"
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Node definitions
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- wool 
-- 
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_node("animalmaterials:wool_white", {
	description = "Wool (white)",
	tile_images = {"animalmaterials_wool_white.png"},
	groups = { snappy=3,wool=1 }
})
minetest.register_node("animalmaterials:wool_grey", {
	description = "Wool (grey)",
	tile_images = {"animalmaterials_wool_grey.png"},
	groups = { snappy=3, wool=1 }
})
minetest.register_node("animalmaterials:wool_brown", {
	description = "Wool (grey)",
	tile_images = {"animalmaterials_wool_grey.png"},
	groups = { snappy=3, wool=1 }
})
minetest.register_node("animalmaterials:wool_black", {
	description = "Wool (grey)",
	tile_images = {"animalmaterials_wool_black.png"},
	groups = { snappy=3, wool=1 }
})

minetest.register_craft({
    type = "fuel",
    recipe = "animalmaterials:wool_black",
    burntime = 2,
})

minetest.register_craft({
    type = "fuel",
    recipe = "animalmaterials:wool_white",
    burntime = 2,
})

minetest.register_craft({
    type = "fuel",
    recipe = "animalmaterials:wool_grey",
    burntime = 2,
})

minetest.register_craft({
    type = "fuel",
    recipe = "animalmaterials:wool_brown",
    burntime = 2,
})

--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- Item definitions
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- scissors
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_tool("animalmaterials:scissors", {
	description = "Scissors",
	inventory_image = "animalmaterials_scissors.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			wool  = {uses=20,maxlevel=1}
		}
	},
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- lasso
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:lasso", {
	description = "Lasso",
	image = "animalmaterials_lasso.png",
	stack_max=10,
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- net
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:net", {
	description = "Net",
	image = "animalmaterials_net.png",
	stack_max=10,
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- raw meat
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:meat_raw", {
	description = "Raw meat",
	image = "animalmaterials_meat_raw.png",
	on_use = minetest.item_eat(1),
	groups = { meat=1, eatable=1 },
	stack_max=25
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- feather
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:feather", {
	description = "Feather",
	image = "animalmaterials_feather.png",
	stack_max=25
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- milk
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:milk", {
	description = "Milk",
	image = "animalmaterials_milk.png",
	on_use = minetest.item_eat(1),
	groups = { eatable=1 },
	stack_max=10
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- glass
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:glass", {
	description = "Empty glass",
	image = "animalmaterials_glass.png",
	stack_max=25
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- egg
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:egg", {
	description = "Egg",
	image = "animalmaterials_egg.png",
	stack_max=10
})

minetest.register_craftitem("animalmaterials:egg_big", {
	description = "Egg (big)",
	image = "animalmaterials_egg_big.png",
	stack_max=5
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- bone
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:bone", {
	description = "Bone",
	image = "animalmaterials_bone.png",
	stack_max=25
})
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- scale
--
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
minetest.register_craftitem("animalmaterials:scale_golden", {
	description = "Scale (golden)",
	image = "animalmaterials_scale_golden.png",
	stack_max=25
})
minetest.register_craftitem("animalmaterials:scale_white", {
	description = "Scale (white)",
	image = "animalmaterials_scale_white.png",
	stack_max=25
})
minetest.register_craftitem("animalmaterials:scale_grey", {
	description = "Scale (grey)",
	image = "animalmaterials_scale_grey.png",
	stack_max=25
})
minetest.register_craftitem("animalmaterials:scale_blue", {
	description = "Scale (blue)",
	image = "animalmaterials_scale_blue.png",
	stack_max=25
})

print("animalmaterials mod version " .. version .. " loaded")
