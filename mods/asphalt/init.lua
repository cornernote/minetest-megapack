--ASPHALT mod for lazy builders
--by Severak
--License: WTFPL

asphalt={
	is_not_batch = true,
	cracking=(minetest.setting_getbool("asphalt_cracking") or true),
	disappear=(minetest.setting_getbool("asphalt_disappear") or false)
}

minetest.register_node("asphalt:asphalt", {
	description = "Asphalt",
	drawtype = "raillike",
	tile_images = {"asphalt_asphalt.png"},
	inventory_image = "asphalt_asphalt.png",
	wield_image = "asphalt_asphalt.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	material = minetest.digprop_dirtlike(0.75),
})

minetest.register_node("asphalt:line", {
	description = "Asphalt with line",
	drawtype = "raillike",
	tile_images = {"asphalt_line.png"},
	inventory_image = "asphalt_line.png",
	wield_image = "asphalt_line.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	material = minetest.digprop_dirtlike(0.75),
})

minetest.register_node("asphalt:fullline", {
	description = "Asphalt with full line",
	drawtype = "raillike",
	tile_images = {"asphalt_fullline.png"},
	inventory_image = "asphalt_fullline.png",
	wield_image = "asphalt_fullline.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	material = minetest.digprop_dirtlike(0.75),
})

minetest.register_node("asphalt:zebra", {
	description = "Asphalt with zebra",
	drawtype = "raillike",
	tile_images = {"asphalt_zebra.png"},
	inventory_image = "asphalt_zebra.png",
	wield_image = "asphalt_zebra.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	material = minetest.digprop_dirtlike(0.75),
})

minetest.register_node("asphalt:cover", {
	description = "Asphalt with sewer hatch",
	drawtype = "raillike",
	tile_images = {"asphalt_cover.png"},
	inventory_image = "asphalt_cover.png",
	wield_image = "asphalt_cover.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	--material = minetest.digprop_dirtlike(0.75),
})

minetest.register_node("asphalt:cracked", {
	description = "Cracked asphalt",
	drawtype = "raillike",
	tile_images = {"asphalt_cracked.png"},
	inventory_image = "asphalt_cracked.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	drop = {}
})

minetest.register_craftitem("asphalt:synthetic",{
	description = "Synthetic asphalt",
	inventory_image = "asphalt_synthetic.png"
})

minetest.register_craft({
	type = "cooking",
	output = "asphalt:synthetic 3",
	recipe = "default:scorched_stuff"
})

minetest.register_craft({
	output = "asphalt:asphalt 50",
	recipe ={
		{"asphalt:synthetic"},
		{"default:gravel"}
	}
})

minetest.register_craft({
	output = "asphalt:line",
	recipe={
		{"","",""},
		{"","default:paper",""},
		{"","asphalt:asphalt",""}
	}
})

minetest.register_craft({
	output = "asphalt:fullline",
	recipe={
		{"","default:paper",""},
		{"","default:paper",""},
		{"","asphalt:asphalt",""}
	}
})

minetest.register_craft({
	output = "asphalt:zebra",
	recipe={
		{"","",""},
		{"default:paper","","default:paper"},
		{"","asphalt:asphalt",""}
	}
})

minetest.register_craft({
	output = "asphalt:cover",
	recipe={
		{"","",""},
		{"","bucket:bucket_empty",""},
		{"","asphalt:asphalt",""}
	}
})

--asphalt cracking
minetest.register_abm({
	nodenames = {"asphalt:asphalt","asphalt:line","asphalt:fullline","asphalt:zebra"},
	chance = 30000,
	interval = 1,
	action = function(pos)
		print(string.format("asphalt cracking at %4d,%4d,%4d",pos.x,pos.y,pos.z))
		if asphalt.cracking and asphalt.is_not_batch then
			minetest.env:add_node(pos, { name = "asphalt:cracked" })
		end
	end
})
--cracked disappear
minetest.register_abm({
	nodenames = {"asphalt:cracked"},
	chance = 90000,
	interval = 1,
	action = function(pos)
		print(string.format("asphalt disappeared at %4d,%4d,%4d",pos.x,pos.y,pos.z))
		if asphalt.disappear and asphalt.is_not_batch then
			minetest.env:add_node(pos, { name = "air" })
		end
	end
})
