minetest.register_node("livehouse:kit", {
    description = "House kit",
    tiles = {
	"default_wood.png^livehouse_kit.png",
	"default_wood.png^livehouse_kit.png",
	"default_wood.png^livehouse_kit.png",
    },
    groups = { dig_immediate = 3 },
    sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
    output = "livehouse:kit",
    recipe = {
	{ "", "default:wood", "" },
	{ "default:stone", "default:glass", "default:stone" },
	{ "default:stone", "default:mese", "default:stone" },
    },
})
