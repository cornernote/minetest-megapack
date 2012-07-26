-- Fences portion of Colored Wood mod by Vanessa Ezekowitz  ~~  2012-07-17
-- based on my unified dyes modding template.
--
-- License: WTFPL

colored_block_modname = "coloredwood"
colored_block_description = "Wooden Fence"
neutral_block = "default:fence_wood"
colored_block_sunlight = "false"
colored_block_walkable = "true"
colored_block_groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2}
colored_block_sound = "default.node_sound_wood_defaults()"

-- ------------------------------------------------------------------
-- Generate all of the base color node definitions and all variations
-- except for the greyscale stuff.

-- Hues are on a 30 degree spacing starting at red = 0 degrees.
-- "s50" in a file/item name means "saturation: 50%".
-- Texture brightness levels for the colors are 100%, 66% ("medium"),
-- and 33% ("dark").

shades = {
	"dark_",
	"medium_",
	""		-- represents "no special shade name", e.g. bright.
}

shades2 = {
	"Dark ",
	"Medium ",
	""		-- represents "no special shade name", e.g. bright.
}

hues = {
	"red",
	"orange",
	"yellow",
	"lime",
	"green",
	"aqua",
	"cyan",
	"skyblue",
	"blue",
	"violet",
	"magenta",
	"redviolet"
}

hues2 = {
	"Red ",
	"Orange ",
	"Yellow ",
	"Lime ",
	"Green ",
	"Aqua ",
	"Cyan ",
	"Sky Blue ",
	"Blue ",
	"Violet ",
	"Magenta ",
	"Red-violet "
}

greys = {
	"black",
	"darkgrey",
	"grey",
	"lightgrey",
	"white"
}

greys2 = {
	"Black ",
	"Dark Grey ",
	"Medium Grey ",
	"Light Grey ",
	"White "
}

greys3 = {
	"black",
	"darkgrey_paint",
	"mediumgrey_paint",
	"lightgrey_paint",
	"white_paint"
}

for shade = 1, 3 do

	shadename = shades[shade]
	shadename2 = shades2[shade]

	for hue = 1, 12 do

		huename = hues[hue]
		huename2 = hues2[hue]

		colorname     = colored_block_modname..":fence_"..shadename..huename
		pngnameinv    = colored_block_modname.."_fence_"..shadename..huename..".png"
		pngname       = colored_block_modname.."_wood_"..shadename..huename..".png"
		nodedesc      = shadename2..huename2..colored_block_description
		stickname     = colored_block_modname..":stick_"..shadename..huename

		s50colorname  = colored_block_modname..":fence_"..shadename..huename.."_s50"
		s50pngname    = colored_block_modname.."_wood_"..shadename..huename.."_s50.png"
		s50pngnameinv = colored_block_modname.."_fence_"..shadename..huename.."_s50.png"
		s50nodedesc   = shadename2..huename2..colored_block_description.." (50% Saturation)"
		s50stickname  = colored_block_modname..":stick_"..shadename..huename.."_s50"

		minetest.register_node(colorname, {
			drawtype = "fencelike",
			description = nodedesc,
			tiles = { pngname },
			inventory_image = pngnameinv, 
			wield_image = pngnameinv,
			sunlight_propagates = colored_block_sunlight,
			paramtype = "light",
			walkable = colored_block_walkable,
			groups = colored_block_groups,
			sounds = colored_block_sound
		})

		minetest.register_node(s50colorname, {
			drawtype = "fencelike",
			description = s50nodedesc,
			tiles = { s50pngname },
			inventory_image = s50pngnameinv, 
			wield_image = s50pngnameinv,
			sunlight_propagates = colored_block_sunlight,
			paramtype = "light",
			walkable = colored_block_walkable,
			groups = colored_block_groups,
			sounds = colored_block_sound
		})

		minetest.register_craft({
		        type = "fuel",
		        recipe = colorname,
		        burntime = 7,
		})

		minetest.register_craft({
		        type = "fuel",
		        recipe = s50colorname,
		        burntime = 7,
		})

		minetest.register_craft({
		        output = colorname.." 2" ,
		        recipe = {
		                {stickname, stickname, stickname },
		                {stickname, stickname, stickname }
		        }
		})

		minetest.register_craft({
		        output = s50colorname.." 2",
		        recipe = {
		                {s50stickname, s50stickname, s50stickname },
		                {s50stickname, s50stickname, s50stickname }
		        }
		})

		minetest.register_craft({
		        output = colorname.." 2",
			recipe = {
				{ "unifieddyes:"..shadename..huename, "", "" },
		                {"default:stick", "default:stick", "default:stick"},
		                {"default:stick", "default:stick", "default:stick"},
		        }
		})

		minetest.register_craft({
		        output = s50colorname.." 2",
			recipe = {
				{ "unifieddyes:"..shadename..huename.."_s50", "", "" },
		                {"default:stick", "default:stick", "default:stick"},
		                {"default:stick", "default:stick", "default:stick"},
		        }
		})

		minetest.register_craft( {
			type = "shapeless",
			output = colorname.." 2",
			recipe = {
				neutral_block,
				neutral_block,
				"unifieddyes:"..shadename..huename
			}
		})

		minetest.register_craft( {
			type = "shapeless",
			output = colorname.." 2",
			recipe = {
				neutral_block,
				neutral_block,
				"unifieddyes:"..shadename..huename.."_s50"
			}
		})

	end
end

-- Generate the "light" shades separately, since they don"t have a low-sat version.

for hue = 1, 12 do
	huename = hues[hue]
	huename2 = hues2[hue]
	colorname    = colored_block_modname..":fence_light_"..huename
	pngname      = colored_block_modname.."_wood_light_"..huename..".png"
	pngnameinv   = colored_block_modname.."_fence_light_"..huename..".png"
	nodedesc     = "Light "..huename2..colored_block_description
	stickname    = colored_block_modname..":stick_light_"..shadename..huename

	minetest.register_node(colorname, {
		drawtype = "fencelike",
		description = nodedesc,
		tiles = { pngname },
		inventory_image = pngnameinv, 
		wield_image = pngnameinv,
		sunlight_propagates = colored_block_sunlight,
		paramtype = "light",
		walkable = colored_block_walkable,
		groups = colored_block_groups,
		sounds = colored_block_sound
	})

	minetest.register_craft({
	        type = "fuel",
	        recipe = colorname,
	        burntime = 7,
	})

	minetest.register_craft({
	        output = colorname.." 2",
	        recipe = {
	                {stickname, stickname, stickname },
	                {stickname, stickname, stickname }
	        }
	})

	minetest.register_craft({
	        output = colorname.." 2",
		recipe = {
			{ "unifieddyes:light_"..huename, "", "" },
	                {"default:stick", "default:stick", "default:stick"},
	                {"default:stick", "default:stick", "default:stick"},
	        }
	})

	minetest.register_craft( {
		type = "shapeless",
		output = colorname.." 2",
		recipe = {
			neutral_block,
			neutral_block,
			"unifieddyes:light_"..huename
		}
	})
end
	

-- ============================================================
-- The 5 levels of greyscale.
--
-- Oficially these are 0, 25, 50, 75, and 100% relative to white,
-- but in practice, they"re actually 7.5%, 25%, 50%, 75%, and 95%.
-- (otherwise black and white would wash out).

for grey = 1,5 do

	greyname = greys[grey]
	greyname2 = greys2[grey]
	greyname3 = greys3[grey]

	greyshadename = colored_block_modname..":fence_"..greyname
	pngname       = colored_block_modname.."_wood_"..greyname..".png"
	pngnameinv    = colored_block_modname.."_fence_"..greyname..".png"
	nodedesc      = greyname2..colored_block_description
	stickname     = colored_block_modname..":stick_"..greyname

	minetest.register_node(greyshadename, {
		drawtype = "fencelike",
		description = nodedesc,
		tiles = { pngname },
		inventory_image = pngnameinv, 
		wield_image = pngnameinv,
		sunlight_propagates = colored_block_sunlight,
		paramtype = "light",
		walkable = colored_block_walkable,
		groups = colored_block_groups,
		sounds = colored_block_sound
	})

	minetest.register_craft({
	        type = "fuel",
	        recipe = greyshadename,
	        burntime = 7,
	})

	minetest.register_craft({
	        output = greyshadename.." 2",
	        recipe = {
	                {stickname, stickname, stickname },
	                {stickname, stickname, stickname }
	        }
	})

	minetest.register_craft({
	        output = greyshadename.." 2",
		recipe = {
			{ "unifieddyes:"..greyname, "", "" },
	                {"default:stick", "default:stick", "default:stick"},
	                {"default:stick", "default:stick", "default:stick"},
	        }
	})

	minetest.register_craft( {
		type = "shapeless",
		output = greyshadename.." 2",
		recipe = {
			neutral_block,
			neutral_block,
			"unifieddyes:"..greyname3
		}
	})

end
