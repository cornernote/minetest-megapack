minetest.register_tool("laser_mod:laser_sword", {
	description = "Laser Sword",
	inventory_image = "laser_sword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			cracky={times={[1]=1.0, [2]=0.5, [3]=0.5}, uses=30, maxlevel=3},
			crumbly={times={[1]=1.0, [2]=0.5, [3]=0.5}, uses=30, maxlevel=3},
			snappy={times={[1]=1.0, [2]=0.5, [3]=0.5}, uses=30, maxlevel=3}
		}
	},
})

minetest.register_craft({
	output = 'laser_mod:laser_sword',
	recipe = {
		{'default:glass'},
		{'default:mese'},
		{'default:stick'},
	}
})
