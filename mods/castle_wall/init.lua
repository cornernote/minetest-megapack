-- Minetest 0.4 mod: castle_wall
-- See README.txt for licensing and other information.

castle_wall = {}

-- Node will be called castle_wall:castle_wall_<subname>
function castle_wall.register_castle_wall(subname, recipeitem, groups, images, description)
	minetest.register_node("castle_wall:castle_wall_" .. subname, {
		description = description .. "Castle Wall",
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -.5, 0, 0.5, 0, 0.5},
				{-0.25, 0, 0, 0.25, 0.5, 0.5},
				},
		},
	})

	minetest.register_node("castle_wall:castle_wall_corner_" .. subname, {
		description = description .. "Castle Wall Corner",
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
                {-0.5, -.5, 0, 0.5, 0, 0.5},
                {-0.5, 0, 0, 0.25, 0.5, 0.5},
		{-0.5,-0.5, -0.25, 0, 0.5, 0},
                {-0.5,-0.5,-0.5, 0,0,0}
				},
		},
	})

	minetest.register_node("castle_wall:castle_window_bottom_" .. subname, {
		description = description .. "Castle Window Bottom",
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
            {0.2,-0.4,-0.3, 0.3,0.5,0.3},
            {-0.3,-0.4,-0.3, -0.2,0.5,0.3},
            {0.3,-0.4,-0.4, 0.4,0.5,0.4},
            {-0.4,-0.4,-0.4, -0.3,0.5,0.4},
            {0.4,-0.4,-0.5, 0.5,0.5,0.5},
            {-0.5,-0.4,-0.5, -0.4,0.5,0.5},
            {-0.5,-0.5,-0.5, 0.5,-0.4,0.5}
				},
		},
	})
	minetest.register_node("castle_wall:castle_window_middle_" .. subname, {
		description = description .. "Castle Window Middle",
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
            {0.2,-0.5,-0.3, 0.3,0.5,0.3},
            {-0.3,-0.5,-0.3, -0.2,0.5,0.3},
            {0.3,-0.5,-0.4, 0.4,0.5,0.4},
            {-0.4,-0.5,-0.4, -0.3,0.5,0.4},
            {0.4,-0.5,-0.5, 0.5,0.5,0.5},
            {-0.5,-0.5,-0.5, -0.4,0.5,0.5},
				},
		},
	})
	minetest.register_node("castle_wall:castle_window_top_" .. subname, {
		description = description .. "Castle Window Top",
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
		{-0.4,0.4,-0.5, 0.4,0.5,-0.4},
            {-0.4,0.4,0.4, 0.4,0.5,0.5},
            {-0.3,0.3,-0.4, 0.3,0.5,-0.3},
            {-0.3,0.3,0.3, 0.3,0.5,0.4},
            {-0.2,0.2,-0.3, 0.2,0.5,0.3},
            {0.2,-0.5,-0.3, 0.3,0.5,0.3},
            {-0.3,-0.5,-0.3, -0.2,0.5,0.3},
            {0.3,-0.5,-0.4, 0.4,0.5,0.4},
            {-0.4,-0.5,-0.4, -0.3,0.5,0.4},
            {0.4,-0.5,-0.5, 0.5,0.5,0.5},
            {-0.5,-0.5,-0.5, -0.4,0.5,0.5},
				},
		},
	})
	minetest.register_craft({
		output = 'castle_wall:castle_wall_' .. subname .. ' 4',
		recipe = {
			{"", recipeitem, ""},
			{recipeitem, "", ""},
			{recipeitem, "", ""},
		},
	})
	minetest.register_craft({
		output = 'castle_wall:castle_wall_corner_' .. subname .. ' 4',
		recipe = {
			{"", recipeitem, ""},
			{recipeitem, "", recipeitem},
			{recipeitem, "", ""},
		},
	})
	minetest.register_craft({
		output = 'castle_wall:castle_window_bottom_' .. subname .. ' 4',
		recipe = {
			{recipeitem, "", recipeitem},
			{recipeitem, "", recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
	minetest.register_craft({
		output = 'castle_wall:castle_window_middle_' .. subname .. ' 4',
		recipe = {
			{recipeitem, "", recipeitem},
			{recipeitem, "", recipeitem},
			{recipeitem, "", recipeitem},
		},
	})
	minetest.register_craft({
		output = 'castle_wall:castle_window_top_' .. subname .. ' 4',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{recipeitem, "", recipeitem},
			{recipeitem, "", recipeitem},
		},
	})

end

-- Node will be called castle_wall:slab_<subname>
function castle_wall.register_slab(subname, recipeitem, groups, images, description)
	minetest.register_node("castle_wall:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			-- If it's being placed on an another similar one, replace it with
			-- a full block
			local slabpos = nil
			local slabnode = nil
			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local n0 = minetest.env:get_node(p0)
			local n1 = minetest.env:get_node(p1)
			if n0.name == "castle_wall:slab_" .. subname then
				slabpos = p0
				slabnode = n0
			elseif n1.name == "castle_wall:slab_" .. subname then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.env:remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(recipeitem)
				pointed_thing.above = slabpos
				fakestack = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if not fakestack or fakestack:is_empty() then
					itemstack:take_item(1)
				-- Else put old node back
				else
					minetest.env:set_node(slabpos, slabnode)
				end
				return itemstack
			end

			-- Otherwise place regularly
			return minetest.item_place(itemstack, placer, pointed_thing)
		end,
	})

	minetest.register_craft({
		output = 'castle_wall:slab_' .. subname .. ' 3',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

-- Nodes will be called castle_wall:{castle_wall,slab}_<subname>
function castle_wall.register_castle_wall_and_slab(subname, recipeitem, groups, images, desc_castle_wall, desc_slab)
	castle_wall.register_castle_wall(subname, recipeitem, groups, images, desc_castle_wall)
	castle_wall.register_slab(subname, recipeitem, groups, images, desc_slab)
end

castle_wall.register_castle_wall_and_slab("wood", "default:wood",
		{snappy=2,choppy=2,oddly_breakable_by_hand=2},
		{"default_wood.png"},
		"Wooden ",
		"Wooden slab")

castle_wall.register_castle_wall_and_slab("stone", "default:stone",
		{cracky=3},
		{"default_stone.png"},
		"Stone ",
		"Stone slab")

castle_wall.register_castle_wall_and_slab("cobble", "default:cobble",
		{cracky=3},
		{"default_cobble.png"},
		"Cobble ",
		"Cobble slab")

castle_wall.register_castle_wall_and_slab("brick", "default:brick",
		{cracky=3},
		{"default_brick.png"},
		"Brick ",
		"Brick slab")

castle_wall.register_castle_wall_and_slab("sandstone", "default:sandstone",
		{crumbly=2,cracky=2},
		{"default_sandstone.png"},
		"Sandstone ",
		"Sandstone slab")




