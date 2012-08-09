local box = {
				-- legs
				{-0.25, -0.25-0.25, -0.2, -0.15, 0.125-0.25, -0.1},
				{0.15, 0.125-0.25, -0.1, 0.25, -0.25-0.25, -0.2},
				{-0.15, 0.125-0.25, 0.1, -0.25, -0.25-0.25, 0.2},
				{0.25, -0.25-0.25, 0.2, 0.15, 0.125-0.25, 0.1},
				
				-- body
				{-0.25, 0.125-0.25, -0.2, 0.25, 0.35-0.25, 0.2},
				
				-- head
				{0.25, 0.275-0.25, -0.1, 0.5, 0.5-0.25, 0.1},
			}

local on_rightklick = function(self, clicker)
	local inv = clicker:get_inventory()
	if inv ~= nil then
		inv:add_item("main", ItemStack("wool:white "..math.random(1, 3)))
	end
	local sheep = minetest.env:add_entity(self.object:getpos(), "animals:sheep_no_wool")
	self.object:remove()
end

local textures = {"animals_sheep.png", "animals_sheep.png", "animals_sheep_front.png", "animals_sheep.png", "animals_sheep.png", "animals_sheep.png"}

animals:add_animal("animals:sheep", textures, box, 1, {-0.6, -0.75, -0.6, 0.6, 0.4, 0.6}, 5, on_rightklick, nil, nil, true)

textures = {"animals_sheep_no_wool.png", "animals_sheep_no_wool.png", "animals_sheep_no_wool_front.png", "animals_sheep_no_wool.png", "animals_sheep_no_wool.png", "animals_sheep_no_wool.png"}

animals:add_animal("animals:sheep_no_wool", textures, box, 1, {-0.6, -0.75, -0.6, 0.6, 0.4, 0.6}, 5, nil, nil, nil, false)

textures = {"animals_cow.png", "animals_cow.png", "animals_cow_front.png", "animals_cow.png", "animals_cow.png", "animals_cow.png"}

minetest.register_craftitem("animals:bucket_milk", {
	inventory_image = "animals_bucket_milk.png",
	stack_max = 1,
	on_use = minetest.item_eat(2),
})

local on_rightklick = function(self, clicker)
	local stack = clicker:get_wielded_item()
	if stack:get_name() == "bucket:bucket_empty" then
		local inv = clicker:get_inventory()
		inv:set_stack("main", clicker:get_wield_index(), ItemStack("animals:bucket_milk"))
	end
end

animals:add_animal("animals:cow", textures, box, 1.5, {-0.6*1.5, -0.75*1.5, -0.6*1.5, 0.6*1.5, 0.4*1.5, 0.6*1.5}, 8, on_rightklick, nil, nil, true)
