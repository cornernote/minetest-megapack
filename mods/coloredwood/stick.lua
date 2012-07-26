-- Sticks portion of Colored Wood mod by Vanessa Ezekowitz  ~~  2012-07-17
-- based on my unified dyes modding template.
--
-- License: WTFPL

colored_block_modname = "coloredwood"
colored_block_description = "Stick"
neutral_block = "default:stick"

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

		colorname    = colored_block_modname..":stick_"..shadename..huename
		pngname      = colored_block_modname.."_stick_"..shadename..huename..".png"
		itemdesc     = shadename2..huename2..colored_block_description
		woodname     = colored_block_modname..":wood_"..shadename..huename
		s50colorname = colored_block_modname..":stick_"..shadename..huename.."_s50"
		s50pngname   = colored_block_modname.."_stick_"..shadename..huename.."_s50.png"
		s50itemdesc  = shadename2..huename2..colored_block_description.." (50% Saturation)"
		s50woodkname = colored_block_modname..":wood_"..shadename..huename.."_s50"

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

		minetest.register_craftitem(colorname, {
		        description = itemdesc,
		        inventory_image = pngname,
			groups = { coloredsticks=1 }
		})

		minetest.register_craftitem(s50colorname, {
		        description = s50itemdesc,
		        inventory_image = s50pngname,
			groups = { coloredsticks=1 }
		})

		minetest.register_craft( {
			type = "shapeless",
			output = colorname.." 4",
			recipe = {
				woodname
			}
		})

		minetest.register_craft( {
			type = "shapeless",
			output = s50colorname.." 4",
			recipe = {
				s50woodname
			}
		})

	end
end

-- Generate the "light" shades separately, since they don"t have a low-sat version.

for hue = 1, 12 do
	huename = hues[hue]
	huename2 = hues2[hue]
	colorname    = colored_block_modname..":stick_light_"..huename
	pngname      = colored_block_modname.."_stick_light_"..huename..".png"
	itemdesc     = "Light "..huename2..colored_block_description
	woodname     = colored_block_modname..":wood_light_"..huename

	minetest.register_craftitem(colorname, {
	        description = itemdesc,
	        inventory_image = pngname,
		groups = { coloredsticks=1 }
	})

	minetest.register_craft({
	        type = "fuel",
	        recipe = colorname,
	        burntime = 7,
	})

	minetest.register_craft( {
		type = "shapeless",
		output = colorname.." 4",
		recipe = {
			woodname
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

	greyshadename = colored_block_modname..":stick_"..greyname
	pngname       = colored_block_modname.."_stick_"..greyname..".png"
	itemdesc      = greyname2..colored_block_description
	greywoodname  = colored_block_modname..":wood_"..greyname

	minetest.register_craftitem(greyshadename, {
	        description = itemdesc,
	        inventory_image = pngname,
		groups = { coloredsticks=1 }
	})

	minetest.register_craft({
	        type = "fuel",
	        recipe = greyshadename,
	        burntime = 7,
	})

	minetest.register_craft( {
		type = "shapeless",
		output = greyshadename.." 4",
		recipe = {
			greywoodname
		}
	})

end

-- ====================================================================
-- This recipe causes all colored sticks to be usable to craft ladders.

minetest.register_craft({
        output = "default:ladder 2" ,
        recipe = {
                {"group:coloredsticks", ""                   , "group:coloredsticks" },
                {"group:coloredsticks", "group:coloredsticks", "group:coloredsticks" },
                {"group:coloredsticks", ""                   , "group:coloredsticks" }
        }
})
