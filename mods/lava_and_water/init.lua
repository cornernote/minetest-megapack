minetest.register_abm(
        {nodenames = {"default:lava_source"},
	neighbors = {"default:water_source", "default:water_flowing"},
        interval = 2,
        chance = 1,
        action = function(pos)
		minetest.env:add_node(pos, {name="default:stone"})
        end,
})


minetest.register_abm(
        {nodenames = {"default:lava_flowing"},
	neighbors = {"default:water_source", "default:water_flowing"},
        interval = 2,
        chance = 1,
        action = function(pos)
		minetest.env:add_node(pos, {name="default:cobble"})
        end,
})