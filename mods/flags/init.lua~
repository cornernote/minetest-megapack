-- Generic colored-objects template by Vanessa Ezekowitz  ~~  2012-07-13

-- License: WTFPL

-- Before using this code, consult the README, particularly the "Semi-
-- automatic generation of textures" section at the end, which descibes the
-- use of the gentextures.sh BASH script included in this package.  You"ll
-- need to either follow those instructions or create your textures the usual,
-- manual way.  Without textures, this code won"t be very useful. :-)

-- When configured properly, this code creates node names that follow the
-- naming convention established in Unified Dyes, such as "mymod:red" or
-- "mymod:dark_yellow_s50".


-- ===========================================================================
-- Edit the next several variables to define what mod this template will
-- generate and how it should behave in general.
-- ===========================================================================

-- First, the standard machine-readable name of your mod

colored_block_modname = "flags"

-- Human-readable description of the category of nodes you want to generate

colored_block_description = "flag"

-- The full node name of the neutral version of your main block as it
-- exists right after crafting or mining it, before any dyes have been
-- applied.  Typically, this should refer to the white version of your
-- mod's main block, but it can be anything as long as it makes sense.

neutral_block = colored_block_modname..":white"

-- This variable defines just how many of a given block a crafting operation
-- should give.  In most cases, the default (1) is correct.

colored_block_yield = "1"

-- If this object should let sunlight pass through it, set this to "true".
-- Otherwise, set it to "false" (the default).

colored_block_sunlight = "true"

-- If the node should be something you can stand on, set this to "true"
-- (the default).  Otherwise, set it to false.

colored_block_walkable = "false"

-- What groups should the generated nodes belong to?  Note that this must
-- be in the form of a table as in the default.

colored_block_groups = { snappy=3, flammable=2 }

-- What sound should be played when the node is digged?

colored_block_sound = "default.node_sound_leaves_defaults()"


-- ===========================================================================
-- From here down is the actual code to do the work.  You can either edit what
-- lies below to define which colors this mod should produce (be sure you sync
-- this with your textures), which is the preferred method, or leave the rest
-- as-is to generate nodes/crafts for the whole palette.
-- ===========================================================================


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
	"mediumgrey",
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

		colorname    = colored_block_modname..":"..shadename..huename
		pngname      = colored_block_modname.."_"..shadename..huename..".png"
		wieldpngname      = "wield_" .. colored_block_modname.."_"..shadename..huename..".png"
		nodedesc     = shadename2..huename2..colored_block_description
		
		minetest.register_node(colorname, {
			description = nodedesc,
			drawtype = "torchlike",
	        tiles = {
		        {name=pngname, animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}},
		        {name=pngname, animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}},
		        {name=pngname, animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}}
		        },
			inventory_image = wieldpngname, 
			wield_image = wieldpngname,
            paramtype = "light",
            paramtype2 = "wallmounted",
            sunlight_propagates = true,
            walkable = false,
            selection_box = {
	            type = "wallmounted",
	            wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
	            wall_bottom = {0, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
	            wall_side = {-0.5, -0.3, -0.1, 0.5, 0.3, 0.1},
            },
            groups = {dig_immediate=3},
            legacy_wallmounted = true,
            sounds = default.node_sound_defaults(),
		})

		s50colorname = colored_block_modname..":"..shadename..huename.."_s50"
		s50pngname   = colored_block_modname.."_"..shadename..huename.."_s50.png"
		s50wieldpngname      = "wield_" .. colored_block_modname..":"..shadename..huename.."_s50.png"
		s50nodedesc  = shadename2..huename2..colored_block_description.." (50% Saturation)"

		minetest.register_node(s50colorname, {
			description = nodedesc,
			drawtype = "torchlike",
	        tiles = {
		        {name=pngname, animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}},
		        {name=pngname, animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}},
		        {name=pngname, animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}}
		        },
			inventory_image = s50wieldpngname, 
			wield_image = s50wieldpngname,
            paramtype = "light",
            paramtype2 = "wallmounted",
            sunlight_propagates = true,
            walkable = false,
            selection_box = {
	            type = "wallmounted",
	            wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
	            wall_bottom = {0, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
	            wall_side = {-0.5, -0.3, -0.1, 0.5, 0.3, 0.1},
            },
            groups = {dig_immediate=3},
            legacy_wallmounted = true,
            sounds = default.node_sound_defaults(),
		})

		minetest.register_craft( {
			type = "shapeless",
			output = colorname.." "..colored_block_yield,
			recipe = {
				neutral_block,
				"unifieddyes:"..shadename..huename
			}
		})

		minetest.register_craft( {
			type = "shapeless",
			output = colorname.." "..colored_block_yield,
			recipe = {
				neutral_block,
				"unifieddyes:"..shadename..huename.."_s50"
			}
		})

	end
end

-- Generate the "light" shades separately, since they don't have a low-sat version.

for hue = 1, 12 do
	huename = hues[hue]
	huename2 = hues2[hue]
	colorname    = colored_block_modname..":light_"..huename
	pngname      = colored_block_modname.."_light_"..huename..".png"
	nodedesc     = "Light "..huename2..colored_block_description

	minetest.register_node(colorname, {
		description = nodedesc,
			drawtype = "torchlike",
	        tiles = {
		        {name=pngname, animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}},
		        {name=pngname, animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}},
		        {name=pngname, animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}}
		        },
			inventory_image = wieldpngname, 
			wield_image = wieldpngname,
            paramtype = "light",
            paramtype2 = "wallmounted",
            sunlight_propagates = true,
            walkable = false,
            selection_box = {
	            type = "wallmounted",
	            wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
	            wall_bottom = {0, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
	            wall_side = {-0.5, -0.3, -0.1, 0.5, 0.3, 0.1},
            },
            groups = {dig_immediate=3},
            legacy_wallmounted = true,
            sounds = default.node_sound_defaults(),
	})

	minetest.register_craft( {
		type = "shapeless",
		output = colorname.." "..colored_block_yield,
		recipe = {
			neutral_block,
			"unifieddyes:light_"..huename
		}
	})
end
	

-- ============================================================
-- The 5 levels of greyscale.
--
-- Oficially these are 0, 25, 50, 75, and 100% relative to white,
-- but in practice, they're actually 7.5%, 25%, 50%, 75%, and 95%.
-- (otherwise black and white would wash out).

for grey = 1,5 do

	greyname = greys[grey]
	greyname2 = greys2[grey]
	greyname3 = greys3[grey]

	greyshadename = colored_block_modname..":"..greyname
	pngname = colored_block_modname.."_"..greyname..".png"
	nodedesc = greyname2..colored_block_description
	wieldpngname      = "wield_" .. colored_block_modname.."_"..greyname..".png"

	minetest.register_node(greyshadename, {
		description = nodedesc,
			drawtype = "torchlike",
	        tiles = {
		        {name=pngname, animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}},
		        {name=pngname, animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}},
		        {name=pngname, animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.0}}
		        },
			inventory_image = wieldpngname, 
			wield_image = wieldpngname,
            paramtype = "light",
            paramtype2 = "wallmounted",
            sunlight_propagates = true,
            walkable = false,
            selection_box = {
	            type = "wallmounted",
	            wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
	            wall_bottom = {0, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
	            wall_side = {-0.5, -0.3, -0.1, 0.5, 0.3, 0.1},
            },
            groups = {dig_immediate=3},
            legacy_wallmounted = true,
            sounds = default.node_sound_defaults(),
	})

	minetest.register_craft( {
		type = "shapeless",
		output = greyshadename.." "..colored_block_yield,
		recipe = {
			neutral_block,
			"unifieddyes:"..greyname3
		}
	})

end


print("[" .. colored_block_modname .. "] Loaded!")


