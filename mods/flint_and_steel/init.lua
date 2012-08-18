minetest.register_craftitem("flint_and_steel:flint_and_steel", {
	inventory_image = "flint_and_steel.png",
	stack_max = 1,
	liquids_pointable = false,
	on_use = function(itemstack, user, pointed_thing)
		n = minetest.env:get_node(pointed_thing)
		if pointed_thing.type == "node" then
			minetest.env:add_node(pointed_thing.above, {name="fire:basic_flame"})
		end
	end,
})

minetest.register_craftitem("flint_and_steel:flint", {
	inventory_image = "flint.png",
	stack_max = 99,
	liquids_pointable = false,
})