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

on_righklick = function(self, clicker)
	local inv = clicker:get_inventory()
	if inv ~= nil then
		inv:add_item("main", ItemStack("wool:white "..math.random(1, 3)))
	end
	local sheep = minetest.env:add_entity(self.object:getpos(), "animals:sheep_no_wool")
	self.object:remove()
end

local textures = {"animals_sheep.png", "animals_sheep.png", "animals_sheep_front.png", "animals_sheep.png", "animals_sheep.png", "animals_sheep.png"}

animals:add_animal("animals:sheep", textures, box, 1, {-0.6, -0.75, -0.6, 0.6, 0.4, 0.6}, 5, on_righklick, nil, nil, true)

textures = {"animals_sheep_no_wool.png", "animals_sheep_no_wool.png", "animals_sheep_no_wool_front.png", "animals_sheep_no_wool.png", "animals_sheep_no_wool.png", "animals_sheep_no_wool.png"}

animals:add_animal("animals:sheep_no_wool", textures, box, 1, {-0.6, -0.75, -0.6, 0.6, 0.4, 0.6}, 5, nil, nil, nil, false)

textures = {"default_wood.png", "default_wood.png", "default_wood.png", "default_wood.png", "default_wood.png", "default_wood.png"}

animals:add_animal("animals:cow", textures, box, 1.5, {-0.6, -0.75, -0.6, 0.6, 0.4, 0.6}, 5, nil, nil, nil, true)
