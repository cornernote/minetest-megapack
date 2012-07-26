minetest.register_node("brick:kaktusbrick",{
		tiles = {"brick_kaktusbrick.png"},
		material = minetest.digprop_constanttime(1),
})
minetest.register_craft({
		output = '"brick:kaktusbrick" 5',
		recipe = {
				{'default:cactus', 'default:cactus', ''},
				{'default:cactus', 'default:cactus', ''},
				{'', '', ''},
		}
})
minetest.register_node("brick:treebrick",{
		tiles = {"brick_treebrick.png"},
		material = minetest.digprop_constanttime(1),
})
minetest.register_craft({
		output = '"brick:treebrick" 5',
		recipe = {
				{'default:tree', 'default:tree', ''},
				{'default:tree', 'default:tree', ''},
				{'', '', ''},
		}
})
minetest.register_node("brick:leavesbrick",{
		tiles = {"brick_leavesbrick.png"},
		material = minetest.digprop_constanttime(1),
})
minetest.register_craft({
		output = '"brick:leavesbrick" 5',
		recipe = {
				{'default:leaves', 'default:leaves', ''},
				{'default:leaves', 'default:leaves', ''},
				{'', '', ''},
		}
})
minetest.register_node("brick:cobblebrick",{
		tiles = {"brick_cobblebrick.png"},
		material = minetest.digprop_constanttime(1),
})
		minetest.register_craft({
		output = '"brick:cobblebrick" 5',
		recipe = {
				{'default:cobble', 'default:cobble', ''},
				{'default:cobble', 'default:cobble', ''},
				{'', '', ''},
		}
})
minetest.register_node("brick:sandbrick",{
		tiles = {"brick_sandbrick.png"},
		material = minetest.digprop_constanttime(1),
})
		minetest.register_craft({
		output = '"brick:sandbrick" 5',
		recipe = {
				{'default:sandstone', 'default:sandstone', ''},
				{'default:sandstone', 'default:sandstone', ''},
				{'', '', ''},
		}
})
minetest.register_node("brick:applebrick",{
		tiles = {"brick_applebrick.png"},
		material = minetest.digprop_constanttime(1),
})
		minetest.register_craft({
		output = '"brick:applebrick" 5',
		recipe = {
				{'default:apple', 'default:apple', ''},
				{'default:apple', 'default:apple', ''},
				{'', '', ''},
		}
})
minetest.register_node("brick:dirtbrick",{
		tiles = {"brick_dirtbrick.png"},
		material = minetest.digprop_constanttime(1),
})
		minetest.register_craft({
		output = '"brick:dirtbrick" 5',
		recipe = {
				{'default:dirt', 'default:dirt', ''},
				{'default:dirt', 'default:dirt', ''},
				{'', '', ''},
		}
})
minetest.register_node("brick:waterbrick",{
		tiles = {"brick_waterbrick.png"},
		material = minetest.digprop_constanttime(1),
})
		minetest.register_craft({
		output = '"brick:waterbrick" 5',
		recipe = {
				{'bucket:bucket_water', 'bucket:bucket_water', ''},
				{'bucket:bucket_water', 'bucket:bucket_water', ''},
				{'', '', ''},
		}
})
minetest.register_node("brick:coalbrick",{
		tiles = {"brick_coalbrick.png"},
		material = minetest.digprop_constanttime(1),
})
		minetest.register_craft({
		output = '"brick:coalbrick" 5',
		recipe = {
				{'default:coal_lump', 'default:coal_lump', ''},
				{'default:coal_lump', 'default:coal_lump', ''},
				{'', '', ''},
		}
})