print (" Colored Stairs, Glass, & Sign Mod Loading ")

-- Nodes! --

minetest.register_node("color_gss:redstair", {
	description = "Red Stairs",
	drawtype = "nodebox",
	tiles = {"red.png"},
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
	sounds = default.node_sound_stone_defaults(),
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
})

minetest.register_node("color_gss:bluestair", {
	description = "Blue Stairs",
	drawtype = "nodebox",
	tiles = {"blue.png"},
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
	sounds = default.node_sound_stone_defaults(),
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
})

minetest.register_node("color_gss:greenstair", {
	description = "Green Stairs",
	drawtype = "nodebox",
	tiles = {"green.png"},
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
	sounds = default.node_sound_stone_defaults(),
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
})

minetest.register_node("color_gss:glassred", {
	description = "Red Glass",
	drawtype = "glasslike",
	tiles = {"redg.png"},
	inventory_image = minetest.inventorycube("redg.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("color_gss:glassblue", {
	description = "Blue Glass",
	drawtype = "glasslike",
	tiles = {"blueg.png"},
	inventory_image = minetest.inventorycube("blueg.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("color_gss:glassgreen", {
	description = "Green Glass",
	drawtype = "glasslike",
	tiles = {"greeng.png"},
	inventory_image = minetest.inventorycube("greeng.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("color_gss:signred", {
	description = "Red Sign",
	drawtype = "signlike",
	tiles = {"redsign.png"},
	inventory_image = "redsign.png",
	wield_image = "redsign.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	metadata_name = "sign",
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups = {choppy=2,dig_immediate=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		--local n = minetest.env:get_node(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "hack:sign_text_input")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		--print("Sign at "..minetest.pos_to_string(pos).." got "..dump(fields))
		local meta = minetest.env:get_meta(pos)
		fields.text = fields.text or ""
		print((sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to sign at "..minetest.pos_to_string(pos))
		meta:set_string("text", fields.text)
		meta:set_string("infotext", '"'..fields.text..'"')
	end,
})

minetest.register_node("color_gss:signblue", {
	description = "Blue Sign",
	drawtype = "signlike",
	tiles = {"bluesign.png"},
	inventory_image = "bluesign.png",
	wield_image = "bluesign.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	metadata_name = "sign",
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups = {choppy=2,dig_immediate=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		--local n = minetest.env:get_node(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "hack:sign_text_input")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		--print("Sign at "..minetest.pos_to_string(pos).." got "..dump(fields))
		local meta = minetest.env:get_meta(pos)
		fields.text = fields.text or ""
		print((sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to sign at "..minetest.pos_to_string(pos))
		meta:set_string("text", fields.text)
		meta:set_string("infotext", '"'..fields.text..'"')
	end,
})

minetest.register_node("color_gss:signgreen", {
	description = "Green Sign",
	drawtype = "signlike",
	tiles = {"greensign.png"},
	inventory_image = "greensign.png",
	wield_image = "greensign.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	metadata_name = "sign",
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups = {choppy=2,dig_immediate=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		--local n = minetest.env:get_node(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "hack:sign_text_input")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		--print("Sign at "..minetest.pos_to_string(pos).." got "..dump(fields))
		local meta = minetest.env:get_meta(pos)
		fields.text = fields.text or ""
		print((sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to sign at "..minetest.pos_to_string(pos))
		meta:set_string("text", fields.text)
		meta:set_string("infotext", '"'..fields.text..'"')
	end,
})


-- Crafting! --

minetest.register_craft({
	output = 'color_gss:bluestair 16',
	recipe = {
		{"default:wood", "", ""},
		{"bucket:bucket_water", "default:wood", ""},
		{"default:wood", "bucket:bucket_water", "default:wood"},
	},
})

minetest.register_craft({
	output = 'color_gss:redstair 16',
	recipe = {
		{"default:wood", "", ""},
		{"default:apple", "default:wood", ""},
		{"default:wood", "default:apple", "default:wood"},
	},
})

minetest.register_craft({
	output = 'color_gss:greenstair 16',
	recipe = {
		{"default:wood", "", ""},
		{"default:cactus", "default:wood", ""},
		{"default:wood", "default:cactus", "default:wood"},
	},
})

minetest.register_craft({
	output = 'color_gss:glassred',
	recipe = {
		{'default:glass'},
		{'default:apple'},
	}
})

minetest.register_craft({
	output = 'color_gss:glassblue',
	recipe = {
		{'default:glass'},
		{'bucket:bucket_water'},
	}
})

minetest.register_craft({
	output = 'color_gss:glassgreen',
	recipe = {
		{'default:glass'},
		{'default:cactus'},
	}
})

minetest.register_craft({
	output = 'color_gss:signgreen 2',
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:cactus", "default:wood"},
		{"", "default:stick", ""},
	},
})

minetest.register_craft({
	output = 'color_gss:signblue 2',
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "bucket:bucket_water", "default:wood"},
		{"", "default:stick", ""},
	},
})

minetest.register_craft({
	output = 'color_gss:signred 2',
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:apple", "default:wood"},
		{"", "default:stick", ""},
	},
})

-- Alias!! --

minetest.register_alias("redstair", "color_gss:redstair")
minetest.register_alias("bluestair", "color_gss:bluestair")
minetest.register_alias("greenstair", "color_gss:greenstair")
minetest.register_alias("redglass", "color_gss:glassred")
minetest.register_alias("blueglass", "color_gss:glassblue")
minetest.register_alias("greenglass", "color_gss:glassgreen")
minetest.register_alias("redsign", "color_gss:signred")
minetest.register_alias("bluesign", "color_gss:signblue")
minetest.register_alias("greensign", "color_gss:signgreen")
	
print (" Colored Stairs, Glass, & Sign Mod Loaded!! ")