-- Unified Dyes Mod by Vanessa Ezekowitz  ~~  2012-07-08
--
-- License: GPL
--
-- This mod depends on ironzorg's flowers mod
--

--=================================================================
-- Smelting/crafting recipes needed to generate various base colors
-- (the register_craftitem functions are in the generate-the-rest
-- loop below the base colors).

-----------------
-- Primary colors

-- Red (rose)

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:red 2",
        recipe = "flowers:flower_rose",
})

-- Green (cactus)

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:green 2",
        recipe = "default:cactus",
})

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:green 2",
        recipe = "flowers:flower_waterlily",
})

minetest.register_craft( {
       type = "shapeless",
       output = "unifieddyes:green 2",
       recipe = {
               "unifieddyes:blue",
               "unifieddyes:yellow",
		},
})

-- Blue (Viola)

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:blue 2",
        recipe = "flowers:flower_viola",
})


-------------------
-- Secondary colors

-- Cyan

minetest.register_craft( {
       type = "shapeless",
       output = "unifieddyes:cyan 2",
       recipe = {
               "unifieddyes:blue",
               "unifieddyes:green",
		},
})

-- Magenta

minetest.register_craft( {
       type = "shapeless",
       output = "unifieddyes:magenta 2",
       recipe = {
               "unifieddyes:blue",
               "unifieddyes:red",
		},
})

-- Yellow (yellow dandelion)

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:yellow 2",
        recipe = "flowers:flower_dandelion_yellow",
})


------------------
-- Tertiary colors

-- Orange (tulip)

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:orange 2",
        recipe = "flowers:flower_tulip",
})

minetest.register_craft( {
       type = "shapeless",
       output = "unifieddyes:orange 2",
       recipe = {
               "unifieddyes:yellow",
               "unifieddyes:red",
		},
})


-- Lime

minetest.register_craft( {
       type = "shapeless",
       output = "unifieddyes:lime 2",
       recipe = {
               "unifieddyes:yellow",
               "unifieddyes:green",
		},
})

-- Aqua

minetest.register_craft( {
       type = "shapeless",
       output = "unifieddyes:aqua 2",
       recipe = {
               "unifieddyes:cyan",
               "unifieddyes:green",
		},
})

-- Sky blue

minetest.register_craft( {
       type = "shapeless",
       output = "unifieddyes:skyblue 2",
       recipe = {
               "unifieddyes:cyan",
               "unifieddyes:blue",
		},
})

-- Violet

minetest.register_craft( {
       type = "shapeless",
       output = "unifieddyes:violet 2",
       recipe = {
               "unifieddyes:blue",
               "unifieddyes:magenta",
		},
})

minetest.register_craft( {
       type = "shapeless",
       output = "unifieddyes:violet 3",
       recipe = {
               "unifieddyes:blue",
               "unifieddyes:blue",
               "unifieddyes:red",
		},
})


-- Red-violet

minetest.register_craft( {
       type = "shapeless",
       output = "unifieddyes:redviolet 2",
       recipe = {
               "unifieddyes:red",
               "unifieddyes:magenta",
		},
})

----------------------------
-- The 5 levels of greyscale

-- White paint

minetest.register_craftitem("unifieddyes:titanium_dioxide", {
        description = "Titanium Dioxide Powder",
        inventory_image = "unifieddyes_titanium_dioxide.png",
	groups = {dye=1},
})

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:titanium_dioxide 10",
        recipe = "default:stone",
})

minetest.register_craft( {
        type = "shapeless",
        output = "unifieddyes:white_paint",
        recipe = {
                "unifieddyes:titanium_dioxide",
                "bucket:bucket_water",
                "default:junglegrass",
        },
})

minetest.register_craftitem("unifieddyes:white_paint", {
        description = "White Paint",
        inventory_image = "unifieddyes_white_paint.png",
	groups = {dye=1},
})


-- Light grey paint

minetest.register_craft( {
       type = "shapeless",
       output = "unifieddyes:lightgrey_paint 3",
       recipe = {
               "unifieddyes:white_paint",
               "unifieddyes:white_paint",
               "unifieddyes:black",
		},
})

minetest.register_craftitem("unifieddyes:lightgrey_paint", {
        description = "Light grey paint",
        inventory_image = "unifieddyes_lightgrey_paint.png",
	groups = {dye=1},
})


-- Medium grey paint

minetest.register_craft( {
       type = "shapeless",
       output = "unifieddyes:grey_paint 2",
       recipe = {
               "unifieddyes:white_paint",
               "unifieddyes:black",
		},
})

minetest.register_craftitem("unifieddyes:grey_paint", {
        description = "Medium grey paint",
        inventory_image = "unifieddyes_grey_paint.png",
	groups = {dye=1},
})


-- Dark grey paint

minetest.register_craft( {
       type = "shapeless",
       output = "unifieddyes:darkgrey_paint 3",
       recipe = {
               "unifieddyes:white_paint",
               "unifieddyes:black",
               "unifieddyes:black",
		},
})

minetest.register_craftitem("unifieddyes:darkgrey_paint", {
        description = "Dark grey paint",
        inventory_image = "unifieddyes_darkgrey_paint.png",
	groups = {dye=1},
})


-- Black dye (coal)

minetest.register_craft({
        type = "cooking",
        output = "unifieddyes:black 2",
        recipe = "default:coal_lump",
})

minetest.register_craftitem("unifieddyes:black", {
	description = "Black Dye",
	inventory_image = "unifieddyes_black.png",
	groups = {dye=1},
})



-- =================================================================

-- Finally, generate all of additional variants of hue, saturation, and
-- brightness from the above 12 base colors.

-- "s50" in a file/item name means "saturation: 50%".
-- Brightness levels in the textures are 33% ("dark"), 66% ("medium"),
-- 100% ("full" but not so-named), and 150% ("light").

HUES = {
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

for i = 1, 12 do

	hue = HUES[i]

	minetest.register_craft( {
        type = "shapeless",
        output = "unifieddyes:dark_" .. hue .. "_s50 2",
        recipe = {
                "unifieddyes:" .. hue,
                "unifieddyes:darkgrey_paint",
	        },
	})

	minetest.register_craft( {
        type = "shapeless",
        output = "unifieddyes:dark_" .. hue .. "_s50 4",
        recipe = {
                "unifieddyes:" .. hue,
                "unifieddyes:black",
                "unifieddyes:black",
		"unifieddyes:white_paint"
	        },
	})

	minetest.register_craft( {
        type = "shapeless",
        output = "unifieddyes:dark_" .. hue .. " 3",
        recipe = {
                "unifieddyes:" .. hue,
                "unifieddyes:black",
                "unifieddyes:black",
	        },
	})

	minetest.register_craft( {
        type = "shapeless",
        output = "unifieddyes:medium_" .. hue .. "_s50 2",
        recipe = {
                "unifieddyes:" .. hue,
                "unifieddyes:grey_paint",
	        },
	})

	minetest.register_craft( {
        type = "shapeless",
        output = "unifieddyes:medium_" .. hue .. "_s50 3",
        recipe = {
                "unifieddyes:" .. hue,
		"unifieddyes:black",
                "unifieddyes:white_paint",
	        },
	})

	minetest.register_craft( {
        type = "shapeless",
        output = "unifieddyes:medium_" .. hue .. " 2",
        recipe = {
                "unifieddyes:" .. hue,
                "unifieddyes:black",
	        },
	})

	minetest.register_craft( {
        type = "shapeless",
        output = "unifieddyes:" .. hue .. "_s50 2",
        recipe = {
                "unifieddyes:" .. hue,
                "unifieddyes:lightgrey_paint",
	        },
	})

	minetest.register_craft( {
        type = "shapeless",
        output = "unifieddyes:" .. hue .. "_s50 4",
        recipe = {
                "unifieddyes:" .. hue,
                "unifieddyes:white_paint",
                "unifieddyes:white_paint",
                "unifieddyes:black",
	        },
	})

	minetest.register_craft( {
        type = "shapeless",
        output = "unifieddyes:light_" .. hue .. " 2",
        recipe = {
                "unifieddyes:" .. hue,
                "unifieddyes:white_paint",
	        },
	})

	minetest.register_craftitem("unifieddyes:dark_" .. hue .. "_s50", {
		description = "Dark " .. hue .. " (low saturation)",
		inventory_image = "unifieddyes_dark_" .. hue .. "_s50.png",
		groups = {dye=1},
	})

	minetest.register_craftitem("unifieddyes:dark_" .. hue, {
		description = "Dark " .. hue,
		inventory_image = "unifieddyes_dark_" .. hue .. ".png",
		groups = {dye=1},
	})

	minetest.register_craftitem("unifieddyes:medium_" .. hue .. "_s50", {
		description = "Medium " .. hue .. " (low saturation)",
		inventory_image = "unifieddyes_medium_" .. hue .. "_s50.png",
		groups = {dye=1},
	})

	minetest.register_craftitem("unifieddyes:medium_" .. hue, {
		description = "Medium " .. hue,
		inventory_image = "unifieddyes_medium_" .. hue .. ".png",
		groups = {dye=1},
	})

	minetest.register_craftitem("unifieddyes:" .. hue .. "_s50", {
		description = "Full " .. hue .. " (low saturation)",
		inventory_image = "unifieddyes_" .. hue .. "_s50.png",
		groups = {dye=1},
	})

	minetest.register_craftitem("unifieddyes:" .. hue, {
		description = "Full " .. hue,
		inventory_image = "unifieddyes_" .. hue .. ".png",
		groups = {dye=1},
	})

	minetest.register_craftitem("unifieddyes:light_" .. hue, {
		description = "Light " .. hue,
		inventory_image = "unifieddyes_light_" .. hue .. ".png",
		groups = {dye=1},
	})

end


print("[UnifiedDyes] Loaded!")

