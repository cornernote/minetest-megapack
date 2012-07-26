minetest.register_tool("instant:instant_node_taker", {
	description = "Instant Node Taker",
	inventory_image = "instant_node_taker.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			cracky={times={[1]=0.0, [2]=0.0, [3]=0.0}, uses=50, maxlevel=3},
			crumbly={times={[1]=0.0, [2]=0.0, [3]=0.0}, uses=50, maxlevel=3},
			snappy={times={[1]=0.0, [2]=0.0, [3]=0.0}, uses=50, maxlevel=3},
		}
	},
})