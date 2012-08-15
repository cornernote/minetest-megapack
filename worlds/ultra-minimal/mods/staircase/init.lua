-- Minetest 0.4 mod: stairs
-- See README.txt for licensing and other information.

staircase = {}

-- Node will be called staircase:stair_<subname>
function staircase.register_railings(subname, groups, images, desc)
	minetest.register_node("staircase:railing_" .. subname, {
		description = desc..' Railing',--description,description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
--				{-0.5, -0.5, 0.4, 0.5, 0.1, 0.5},

				{-0.5, 0.2, 0.35, 0.5, 0.3, 0.5},
				{-0.5, -0.5, 0.4, -0.45, 0.2, 0.5},
				{0.5, -0.5, 0.4, 0.45, 0.2, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, 0.35, 0.5, 0.3, 0.5},

			},
		},
	})
	minetest.register_node("staircase:urailing_" .. subname, {
		description = desc..' Railing (Support Piece)',--description,description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.3, 0.4, 0.5, 0.5, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.3, 0.4, 0.5, 0.5, 0.5},
			},
		},		
	})
	minetest.register_node("staircase:crailing_" .. subname, {
		description = desc..' Railing (Corner Piece)',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.2, 0.35, 0.5, 0.3, 0.5},
				{-0.5, 0.2, -0.5, -0.35, 0.3, 0.35},
				{-0.5, -0.5, 0.4, -0.4, 0.2, 0.5},
				{0.5, -0.5, 0.4, 0.45, 0.2, 0.5},
				{-0.5, -0.5, -0.5, -0.4, 0.2, -0.45},												
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, 0.35, 0.5, 0.3, 0.5},
				{-0.5, -0.5, -0.5, -0.35, 0.3, 0.35},
			},
		},
	})
	minetest.register_node("staircase:ucrailing_" .. subname, {
		description = desc..' Railing (Corner Support Piece)',--description,description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.3, 0.4, 0.5, 0.5, 0.5},
				{-0.5, 0.3, -0.5, -0.4, 0.5, 0.4},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.3, 0.4, 0.5, 0.5, 0.5},
				{-0.5, 0.3, -0.5, -0.4, 0.5, 0.4},

			},
		},
	})
	minetest.register_node("staircase:hrailing_" .. subname, {
		description = desc..' Railing (Corner Piece)',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.2, 0.35, 0.5, 0.3, 0.5},
				{-0.5, 0.2, -0.5, -0.35, 0.3, 0.35},
				{0.5, 0.2, -0.5, 0.35, 0.3, 0.35},				

				{-0.5, -0.5, 0.4, -0.4, 0.2, 0.5},
				{0.5, -0.5, 0.4, 0.4, 0.2, 0.5},
				{-0.5, -0.5, -0.5, -0.4, 0.2, -0.45},
				{0.5, -0.5, -0.5, 0.4, 0.2, -0.45},																												
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.2, 0.35, 0.5, 0.3, 0.5},
				{-0.5, 0.2, -0.5, -0.35, 0.3, 0.35},
				{0.5, 0.2, -0.5, 0.35, 0.3, 0.35},				

				{-0.5, -0.5, 0.4, -0.4, 0.2, 0.5},
				{0.5, -0.5, 0.4, 0.4, 0.2, 0.5},
				{-0.5, -0.5, -0.5, -0.4, 0.2, -0.45},
				{0.5, -0.5, -0.5, 0.4, 0.2, -0.45},		
			},
		},
	})
	minetest.register_node("staircase:uhrailing_" .. subname, {
		description = desc..' Railing (Corner Support Piece)',--description,description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.3, 0.4, 0.5, 0.5, 0.5},
				{-0.5, 0.3, -0.5, -0.4, 0.5, 0.4},
				{0.5, 0.3, -0.5, 0.4, 0.5, 0.4},				
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.3, 0.4, 0.5, 0.5, 0.5},
				{-0.5, 0.3, -0.5, -0.4, 0.5, 0.4},
				{0.5, 0.3, -0.5, 0.4, 0.5, 0.4},		

			},
		},
	})	
end
function staircase.register_catwalk(subname, groups, images, description)
		minetest.register_node("staircase:supcatwalk_" .. subname, {
		description = description..' Catwalk',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.1, -0.5, 0.5, 0.1, -0.45, -0.1},
				{-0.1, -0.45, -0.1, 0.1, 0.5, 0.1},

--				{-0.5, 0.2, -0.5, -0.4, 0.3, 0.5},
--				{0.5, 0.2, -0.5, 0.4, 0.3, 0.5},				
--
--				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
--				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
--				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
--				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.1, -0.5, 0.5, 0.1, -0.45, -0.1},
				{-0.1, -0.45, -0.1, 0.1, 0.5, 0.1},
			},
		},
		sounds = default.node_sound_wood_defaults(),
	})

		minetest.register_node("staircase:catwalk_" .. subname, {
		description = description..' Catwalk',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, -0.4, 0.3, 0.5},
				{0.5, 0.2, -0.5, 0.4, 0.3, 0.5},				

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, -0.4, 0.3, 0.5},
				{0.5, 0.2, -0.5, 0.4, 0.3, 0.5},				

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		sounds = default.node_sound_wood_defaults(),
	})
		minetest.register_node("staircase:leftcatwalk_" .. subname, {
		description = description..' Catwalk (Left Turn)',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, 0.5, 0.3, -0.4},
				{-0.5, 0.2, 0.5, -0.4, 0.3, -0.5},
				{0.5, 0.2, 0.5, 0.4, 0.3, 0.4},

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, 0.5, 0.3, -0.4},
				{-0.5, 0.2, 0.5, -0.4, 0.3, -0.5},
				{0.5, 0.2, 0.5, 0.4, 0.3, 0.4},

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
																											
			},
		},
		sounds = default.node_sound_wood_defaults(),
	})	
		minetest.register_node("staircase:rightcatwalk_" .. subname, {
		description = description..' Catwalk (Right Turn)',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, 0.5, 0.3, -0.4},
				{0.5, 0.2, 0.5, 0.4, 0.3, -0.5},
				{-0.5, 0.2, 0.5, -0.4, 0.3, 0.4},

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, 0.5, 0.3, -0.4},
				{0.5, 0.2, 0.5, 0.4, 0.3, -0.5},
				{-0.5, 0.2, 0.5, -0.4, 0.3, 0.4},

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		sounds = default.node_sound_wood_defaults(),
	})	
		minetest.register_node("staircase:tjuncatwalk_" .. subname, {
		description = description..' Catwalk (T Junction)',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, 0.5, 0.3, -0.4},
				{-0.5, 0.2, 0.5, -0.4, 0.3, 0.4},
				{0.5, 0.2, 0.5, 0.4, 0.3, 0.4},

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, 0.5, 0.3, -0.4},
				{-0.5, 0.2, 0.5, -0.4, 0.3, 0.4},
				{0.5, 0.2, 0.5, 0.4, 0.3, 0.4},

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
																											
			},
		},
		sounds = default.node_sound_wood_defaults(),
	})	
		minetest.register_node("staircase:crosscatwalk_" .. subname, {
		description = description..' Catwalk (4-Way Junction)',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, -0.4, 0.3, -0.4},
				{-0.5, 0.2, 0.5, -0.4, 0.3, 0.4},
				{0.5, 0.2, -0.5, 0.4, 0.3, -0.4},				
				{0.5, 0.2, 0.5, 0.4, 0.3, 0.4},
								
				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, -0.4, 0.3, -0.4},
				{-0.5, 0.2, 0.5, -0.4, 0.3, 0.4},
				{0.5, 0.2, -0.5, 0.4, 0.3, -0.4},				
				{0.5, 0.2, 0.5, 0.4, 0.3, 0.4},
								
				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		sounds = default.node_sound_wood_defaults(),
	})
end
function staircase.register_stair(subname, recipeitem, groups, images, description)
	minetest.register_node("staircase:" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.1, -0.5, 0.5, 0, 0},
				{-0.1, -0.5, -0.5, 0.1, -0.1, 0.5},

				{-0.5, 0.4, 0, 0.5, 0.5, 0.5},
				{-0.1, -0.1, 0, 0.1, 0.4, 0.5},
			},
		},
		sounds = default.node_sound_wood_defaults(),
	})

	minetest.register_node("staircase:support_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {

				{0.1, 0.5, 0, -0.1, 0, -0.5},
--				{-0.1, -0.5, 0, 0.1, 0.5, -0.5},
			},
		},
	})

	minetest.register_craft({
		output = 'staircase:' .. subname .. ' 4',
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	-- Flipped recipe for the silly minecrafters
	minetest.register_craft({
		output = 'staircase:' .. subname .. ' 4',
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

-- Node will be called staircase:slab_<subname>
function staircase.register_slab(subname, recipeitem, groups, images, description)
	minetest.register_node("staircase:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = true,
		groups = groups,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
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
			if n0.name == "staircase:slab_" .. subname then
				slabpos = p0
				slabnode = n0
			elseif n1.name == "staircase:slab_" .. subname then
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
		output = 'staircase:slab_' .. subname .. ' 3',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

-- Nodes will be called staircase:{stair,slab}_<subname>
function staircase.register_stair_and_slab(subname, recipeitem, groups, images, desc_stair, desc_slab)
	staircase.register_stair(subname, recipeitem, groups, images, desc_stair)
	staircase.register_slab(subname, recipeitem, groups, images, desc_slab)
end


staircase.register_stair_and_slab("wood", "staircase:wood",
	{snappy=2,choppy=2,oddly_breakable_by_hand=2},
	{"riventest_wood.png"},
	"Wooden stair",
	"Wooden slab")

staircase.register_stair_and_slab("bluewood", "staircase:bluewood",
	{snappy=2,choppy=2,oddly_breakable_by_hand=2},
	{"riventest_woodblue.png"},
	"Wooden stair",
	"Wooden slab")
		
staircase.register_stair_and_slab("metal", "staircase:metal",
	{snappy=2,choppy=2,oddly_breakable_by_hand=2},
	{"riventest_metal.png"},
	"Wooden stair",
	"Wooden slab")
		
staircase.register_stair_and_slab("gold", "staircase:gold",
	{snappy=2,choppy=2,oddly_breakable_by_hand=2},
	{"riventest_stoneblue.png"},
	"Wooden stair",
	"Wooden slab")
		
staircase.register_stair_and_slab("rt4", "staircase:rt4",
	{snappy=2,choppy=2,oddly_breakable_by_hand=2},
	{"riventest_rt10.png"},
	"Wooden stair",
	"Wooden slab")		
		
staircase.register_railings("metal", {snappy=2,choppy=2,oddly_breakable_by_hand=2},	{"riventest_metal.png"},	"Metal")
staircase.register_catwalk("metal", {snappy=2,choppy=2,oddly_breakable_by_hand=2},	{"riventest_metal.png"},	"Metal")

