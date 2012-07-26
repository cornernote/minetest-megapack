minetest.register_node("building_blocks:Adobe", {
	tiles = {"building_blocks_Adobe.png"},
	inventory_image = "building_blocks_Adobe.png",
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("building_blocks:Roofing", {
	tiles = {"building_blocks_Roofing.png"},
	inventory_image = "building_blocks_Roofing.png",
	is_ground_content = true,
	groups = {snappy=3},
})
minetest.register_craft({
	output = 'building_blocks:terrycloth_towel 2',
	recipe = {
		{"flowers:cotton", "flowers:cotton", "flowers:cotton"},
	}
})
minetest.register_craft({
	output = 'building_blocks:Tarmac_spread 4',
	recipe = {
		{"building_blocks:Tar", "building_blocks:Tar", "building_blocks:Tar"},
	}
})
minetest.register_craft({
	output = 'building_blocks:gravel_spread 4',
	recipe = {
		{"default:gravel", "default:gravel", "default:gravel"},
	}
})
minetest.register_craft({
	output = 'building_blocks:brobble_spread 4',
	recipe = {
		{"default:brick", "default:cobble", "default:brick"},
	}
})
minetest.register_craft({
	output = 'building_blocks:Fireplace 1',
	recipe = {
		{"default:steel_ingot", "building_blocks:faggot", "default:steel_ingot"},
	}
})
minetest.register_craft({
	output = 'building_blocks:Adobe 3',
	recipe = {
		{"default:sand"},
		{"default:clay"},
		{"default:stick"},
	}
})
minetest.register_craft({
	output = 'building_blocks:Roofing 10',
	recipe = {
		{"building_blocks:Adobe", "building_blocks:Adobe"},
		{"building_blocks:Adobe", "building_blocks:Adobe"},
	}
})
minetest.register_craft({
	output = 'building_blocks:grate 1',
	recipe = {
		{"default:steel_ingot"},
		{"default:glass"},
	}
})
minetest.register_craft({
	output = 'building_blocks:woodglass 1',
	recipe = {
		{"default:wood"},
		{"default:glass"},
	}
})
minetest.register_craft({
	output = 'building_blocks:hardwood 1',
	recipe = {
		{"default:wood", "default:wood"},
		{"default:wood", "default:wood"},
	}
})
minetest.register_craft({
	output = 'building_blocks:faggot 1',
	recipe = {
		{'craft "default:stick"', 'craft "default:stick"'},
		{'craft "default:stick"', 'craft "default:stick"'},
	}
})
minetest.register_craft({
	output = 'building_blocks:fakegrass 2',
	recipe = {
		{'default:leaves'},
		{"default:dirt"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "building_blocks:smoothglass",
	recipe = "default:glass"
})
minetest.register_node("building_blocks:smoothglass", {
	drawtype = "glasslike",
	tiles = {"building_blocks_sglass.png"},
	inventory_image = "building_blocks_sglass.png",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_node("building_blocks:grate", {
	drawtype = "glasslike",
	tiles = {"building_blocks_grate.png"},
	inventory_image = "building_blocks_grate.png",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=1},
})
minetest.register_node("building_blocks:Fireplace", {
	drawtype = "stonelike",
	tiles = {"building_blocks_cast_iron.png","building_blocks_cast_iron.png","building_blocks_cast_iron.png","building_blocks_cast_iron_fireplace.png"},
	inventory_image = "building_blocks_cast_iron.png","building_blocks_cast_iron.png","building_blocks_cast_iron.png","building_blocks_cast_iron_fireplace.png",
	paramtype = "facedir_simple",
	light_source = LIGHT_MAX,
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=2},
})
minetest.register_node("building_blocks:woodglass", {
	drawtype = "glasslike",
	tiles = {"building_blocks_wglass.png"},
	inventory_image = "building_blocks_wglass.png",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_node("building_blocks:terrycloth_towel", {
	drawtype = "raillike",
	tiles = {"building_blocks_towel.png"},
	inventory_image = "building_blocks_towel.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {crumbly=3},
})
minetest.register_node("building_blocks:Tarmac_spread", {
	drawtype = "raillike",
	tiles = {"tar.png"},
	inventory_image = "tar.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=3},
})
minetest.register_node("building_blocks:brobble_spread", {
	drawtype = "raillike",
	tiles = {"building_blocks_brobble.png"},
	inventory_image = "building_blocks_brobble.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=3},
})
minetest.register_node("building_blocks:gravel_spread", {
	drawtype = "raillike",
	tiles = {"default_gravel.png"},
	inventory_image = "default_gravel.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=2},
})
minetest.register_node("building_blocks:hardwood", {
	tiles = {"building_blocks_hardwood.png"},
	inventory_image = "building_blocks_hardwood.png",
	is_ground_content = true,
	groups = {choppy=1,flammable=1},
	sounds = default.node_sound_wood_defaults(),
})

stairs = {}

-- Node will be called stairs:stair_<subname>
function stairs.register_stair(subname, recipeitem, groups, images, description)
	minetest.register_node("building_blocks:stair_" .. subname, {
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
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
	})

	minetest.register_craft({
		output = 'building_blocks:stair_' .. subname .. ' 4',
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	-- Flipped recipe for the silly minecrafters
	minetest.register_craft({
		output = 'building_blocks:stair_' .. subname .. ' 4',
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

-- Node will be called stairs:slab_<subname>
function stairs.register_slab(subname, recipeitem, groups, images, description)
	minetest.register_node("building_blocks:slab_" .. subname, {
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
			if n0.name == "building_blocks:slab_" .. subname then
				slabpos = p0
				slabnode = n0
			elseif n1.name == "building_blocks:slab_" .. subname then
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
		output = 'building_blocks:slab_' .. subname .. ' 3',
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

-- Nodes will be called stairs:{stair,slab}_<subname>
function stairs.register_stair_and_slab(subname, recipeitem, groups, images, desc_stair, desc_slab)
	stairs.register_stair(subname, recipeitem, groups, images, desc_stair)
	stairs.register_slab(subname, recipeitem, groups, images, desc_slab)
end
stairs.register_stair_and_slab("marble","building_blocks:Marble",
	{cracky=3},
	{"marble.png"},
	"Marble stair",
	"Marble slab")
stairs.register_stair_and_slab("hardwood","building_blocks:hardwood",
		{snappy=1,choppy=1,flammable=1},
		{"building_blocks_hardwood.png"},
		"Hardwood stair",
		"Hardwood slab")
stairs.register_stair_and_slab("fakegrass","building_blocks:fakegrass",
		{crumbly=3},
		{"default_grass.png"},
		"Grass stair",
		"Grass slab")
stairs.register_stair_and_slab("tar","building_blocks:Tar",
		{crumbly=1},
		{"tar.png"},
		"Tar stair",
		"Tar slab")
minetest.register_craft({
	type = "fuel",
	recipe = "building_blocks:hardwood",
	burntime = 28,
})
minetest.register_node("building_blocks:fakegrass", {
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	inventory_image = "default_grass.png",
	is_ground_content = true,
	groups = {crumbly=3},
		sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})
minetest.register_craftitem("building_blocks:faggot", {
	image = "building_blocks_faggot.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

--Tar
minetest.register_craft({
	output = 'building_blocks:knife 1',
	recipe = {
		{"building_blocks:Tar"},
		{"Stick"},
	}
})
minetest.register_alias("tar", "building_blocks:Tar")
minetest.register_alias("fakegrass", "building_blocks:fakegrass")
minetest.register_alias("tar_knife", "building_blocks:knife")
minetest.register_alias("adobe", "building_blocks:Adobe")
minetest.register_alias("building_blocks_roofing", "building_blocks:Roofing")
minetest.register_alias("hardwood", "building_blocks:hardwood")
minetest.register_alias("faggot", "building_blocks:faggot")
minetest.register_alias("marble", "building_blocks:Marble")
minetest.register_node("building_blocks:Tar", {
	description = "Tar",
	tiles = {"tar.png"},
	inventory_image = "tar.png",
	is_ground_content = true,
	groups = {crumbly=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("building_blocks:Marble", {
	tiles = {"marble.png"},
	inventory_image = "marble.png",
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	type = "fuel",
	recipe = "building_blocks:faggot",
	burntime = 5,
})
minetest.register_craft({
	type = "fuel",
	recipe = "building_blocks:Tar",
	burntime = 40,
})
minetest.register_craft({
	type = "cooking",
	output = "building_blocks:Tar",
	recipe = "default:gravel",
})
minetest.register_tool("building_blocks:knife", {
	description = "Tar Knife",
	inventory_image = "knife.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			choppy={times={[2]=7.50, [3]=2.80}, maxwear=0.01, maxlevel=.1},
			fleshy={times={[2]=5.50, [3]=2.80}, maxwear=0.01, maxlevel=.1}
		}
	},
})
minetest.add_to_creative_inventory('building_blocks:Tar 0')
minetest.add_to_creative_inventory('building_blocks:hardwood 0')
minetest.register_craft({
	output = "building_blocks:Marble 9",
	recipe = {
		{"default:clay", "building_blocks:Tar", "default:clay"},
		{"building_blocks:Tar","default:clay", "building_blocks:Tar"},
		{"default:clay", "building_blocks:Tar","default:clay"},
	}
})

