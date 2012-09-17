--Registers Blocks
	-- Asphalt block
	minetest.register_node("streets:asphalt", {
	description = "Asphalt",
	tile_images = {"streets_asphalt.png"},
	drawtype = "normal",
	groups = {cracky=1},
	})
	-- Asphalt with side line
	minetest.register_node("streets:asphalt_side", {
	description = "Asphalt with side line",
	tile_images = {"streets_asphalt_side.png", "streets_asphalt.png"},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1},
	})
	-- Asphalt with middle dashed line
	minetest.register_node("streets:asphalt_middle_dashed", {
	description = "Asphalt with middle dashed line",
	tile_images = {"streets_asphalt_middle_dashed.png", "streets_asphalt.png"},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1},
	})
	-- Asphalt with middle solid line
	minetest.register_node("streets:asphalt_middle", {
	description = "Asphalt with middle solid line",
	tile_images = {"streets_asphalt_middle_solid.png", "streets_asphalt.png"},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1},
	})
	-- Asphalt with solid line for outer edge
	minetest.register_node("streets:asphalt_outer_edge", {
	description = "Asphalt with solid line for outer edge",
	tile_images = {"streets_asphalt_outer_edge.png", "streets_asphalt.png"},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=1},
	})
	-- Asphalt with manhole
	minetest.register_node("streets:manhole", {
	description = "Asphalt block with manhole",
	tile_images = {"streets_manhole.png", "streets_asphalt.png"},
	drawtype = "normal",
	paramtype = "light",
	groups = {cracky=1},
	})
	-- Concrete
	minetest.register_node("streets:concrete", {
	description = "Concrete Block",
	tile_images = {"streets_concrete.png"},
	drawtype = "normal",
	paramtype = "light",
	groups = {cracky=2},
	})
	-- Concrete seperating wall
	minetest.register_node("streets:seperating_wall", {
	description = "Seperating wall",
	tile_images = {"streets_concrete.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky=2},
	node_box = {
    type = "fixed",
        fixed = {  {-0.4, -0.5, -0.5, 0.4, -0.4, 0.5}, {-0.1, -0.4, -0.5, 0.1, 0.5, 0.5}}
	}
	})
	-- Steel frame
	minetest.register_node("streets:steel_support", {
	description = "Steel frame",
	tile_images = {"streets_support.png"},
	drawtype = "glasslike",
	paramtype = "light",
	groups = {cracky=3},
	})
	
--Registers Aliases
	-- Asphalt block
	minetest.register_alias("asphalt", "streets:asphalt")
	-- Asphalt block with side line
	minetest.register_alias("asphalt_side", "streets:asphalt_side")
	-- Asphalt block middle dashed line
	minetest.register_alias("asphalt_middle_dashed", "streets:asphalt_middle_dashed")
	-- Asphalt block middle solid line
	minetest.register_alias("asphalt_middle", "streets:asphalt_middle")
	-- Asphalt block with solid line for outer edge
	minetest.register_alias("asphalt_outer_edge", "streets:asphalt_outer_edge")
	-- Asphalt block with manhole
	minetest.register_alias("asphalt_manhole", "streets:manhole")
	-- Concrete Block
	minetest.register_alias("concrete", "streets:concrete")
	-- Stell support block
	minetest.register_alias("steel_frame", "streets:steel_support")
	-- Stell support block
	minetest.register_alias("seperating_wall", "streets:seperating_wall")
	
--Registers Crafting recipes
	--Asphalt block
	minetest.register_craft({
		output = '"streets:asphalt" 10',
		recipe = {
			{'default:cobble', 'default:stone', 'default:cobble'},
			{'default:stone', 'default:cobble', 'default:stone'},
			{'default:cobble', 'default:stone', 'default:cobble'},
		}
	})
	--Asphalt block with side line
	minetest.register_craft({
		output = '"streets:asphalt_side" 10',
		recipe = {
			{'default:sand', 'streets:asphalt', 'streets:asphalt'},
			{'default:sand', 'streets:asphalt', 'streets:asphalt'},
			{'default:sand', 'streets:asphalt', 'streets:asphalt'},
		}
	})
	--Asphalt block with middle dashed line
	minetest.register_craft({
		output = '"streets:asphalt_middle_dashed" 10',
		recipe = {
			{'streets:asphalt', 'default:sand', 'streets:asphalt'},
			{'streets:asphalt', 'streets:asphalt', 'streets:asphalt'},
			{'streets:asphalt', 'default:sand', 'streets:asphalt'},
		}
	})
	--Asphalt block with middle solid line
	minetest.register_craft({
		output = '"streets:asphalt_middle" 10',
		recipe = {
			{'streets:asphalt', 'default:sand', 'streets:asphalt'},
			{'streets:asphalt', 'default:sand', 'streets:asphalt'},
			{'streets:asphalt', 'default:sand', 'streets:asphalt'},
		}
	})
	--Asphalt block with side line
	minetest.register_craft({
		output = '"streets:asphalt_outer_edge" 6',
		recipe = {
			{'default:sand', 'default:sand', 'default:sand'},
			{'default:sand', 'streets:asphalt', 'streets:asphalt'},
			{'default:sand', 'streets:asphalt', 'streets:asphalt'},
		}
	})
	--Asphalt block with manhole
	minetest.register_craft({
		output = '"streets:manhole" 4',
		recipe = {
			{'streets:asphalt', 'streets:asphalt', 'streets:asphalt'},
			{'streets:asphalt', 'default:steel_ingot', 'streets:asphalt'},
			{'streets:asphalt', 'streets:asphalt', 'streets:asphalt'},
		}
	})
	--Concrete block
	minetest.register_craft({
		output = '"streets:concrete" 2',
		recipe = {
			{'', '', ''},
			{'', '', ''},
			{'default:stone', '', ''},
		}
	})
	--Steel frame
	minetest.register_craft({
		output = '"streets:steel_support" 6',
		recipe = {
			{'default:steel_ingot', '', 'default:steel_ingot'},
			{'', 'default:steel_ingot', ''},
			{'default:steel_ingot', '', 'default:steel_ingot'},
		}
	})
	--Concrete seperating wall
	minetest.register_craft({
		output = '"streets:seperating_wall" 5',
		recipe = {
			{'', 'streets:concrete', ''},
			{'', 'streets:concrete', ''},
			{'streets:concrete', 'streets:concrete', 'streets:concrete'},
		}
	})
	
--Prints finishing messages
print ("")
print ("StreetS loaded")
print ("-->Time to create MODERN cities")
print ("")