minetest.register_abm(
	{nodenames = {"default:tree"},
	interval = 10 ,
	chance = 2,
	action = function(pos)
		minetest.env:add_node(pos, {name="default:tree"})
	end,
})
