--Viscosity of thick lava
THICK_LAVA_VISC = 200
--Light emmited by lava
LIGHT = 14
--Rate that thick lava cools (for work with cooling lava mod)
THICK_LAVA_COOLING_RATE = 5

minetest.register_abm({
	nodenames = { "lava:thick_lava_source" },
	chance = 0.002,
	interval = 10,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local y1 = { x = pos.x, y = pos.y + 1, z = pos.z }	
		if minetest.env:get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air" then
		if minetest.env:get_node({x = pos.x, y = pos.y + 2, z = pos.z}).name == "air" then
		if minetest.env:get_node({x = pos.x, y = pos.y + 3, z = pos.z}).name == "air" then
		if minetest.env:get_node({x = pos.x, y = pos.y + 4, z = pos.z}).name == "air" then
		if minetest.env:get_node({x = pos.x + 1, y = pos.y, z = pos.z}).name == "lava:thick_lava_source" then
		if minetest.env:get_node({x = pos.x - 1, y = pos.y, z = pos.z}).name == "lava:thick_lava_source" then
		if minetest.env:get_node({x = pos.x, y = pos.y, z = pos.z + 1}).name == "lava:thick_lava_source" then
		if minetest.env:get_node({x = pos.x, y = pos.y, z = pos.z - 1}).name == "lava:thick_lava_source" then
		if minetest.env:get_node({x = pos.x - 1, y = pos.y, z = pos.z - 1}).name == "lava:thick_lava_source" then
		if minetest.env:get_node({x = pos.x + 1, y = pos.y, z = pos.z - 1}).name == "lava:thick_lava_source" then
		if minetest.env:get_node({x = pos.x - 1, y = pos.y, z = pos.z + 1}).name == "lava:thick_lava_source" then
		if minetest.env:get_node({x = pos.x + 1, y = pos.y, z = pos.z + 1}).name == "lava:thick_lava_source" then



		minetest.env:add_node(y1, { name = "lava:thick_lava_source",})
		end
end
end
end
end
end
end
end
end
end
end
end
end
})

minetest.register_abm({
	nodenames = "lava:thick_lava_flowing",
	chance = 0.00001,
	interval = 10,
	action = function(pos, node)
		if minetest.env:get_node({x = pos.x, y = pos.y, z = pos.z - 1}).name == "lava:thick_lava_source" then
    		minetest.env:add_node(pos , {name = "lava:thick_lava_source"})
end
end
})

minetest.register_abm({
	nodenames = "lava:thick_lava_flowing",
	chance = 0.00001,
	interval = 10,
	action = function(pos, node)
		if minetest.env:get_node({x = pos.x, y = pos.y, z = pos.z + 1}).name == "lava:thick_lava_source" then
    		minetest.env:add_node(pos , {name = "lava:thick_lava_source"})
end
end
})

minetest.register_abm({
	nodenames = "lava:thick_lava_flowing",
	chance = 0.00001,
	interval = 10,
	action = function(pos, node)
		if minetest.env:get_node({x = pos.x - 1, y = pos.y, z = pos.z}).name == "lava:thick_lava_source" then
    		minetest.env:add_node(pos , {name = "lava:thick_lava_source"})
end
end
})

minetest.register_abm({
	nodenames = "lava:thick_lava_flowing",
	chance = 0.00001,
	interval = 10,
	action = function(pos, node)
		if minetest.env:get_node({x = pos.x + 1, y = pos.y, z = pos.z}).name == "lava:thick_lava_source" then
    		minetest.env:add_node(pos , {name = "lava:thick_lava_source"})
end
end
})

--
--Types of lava
--

--Thick lava

minetest.register_node("lava:thick_lava_flowing", {
	description = "Thick Flowing Lava",
	inventory_image = minetest.inventorycube("default_lava.png"),
	drawtype = "flowingliquid",
	tiles = {"thick_lava.png"},
	special_tiles = {
		{
			image="thick_lava_flowing_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=4}
		},
		{
			image="thick_lava_flowing_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=4}
		},
	},
	paramtype = "light",
	light_source = LIGHT,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "lava:thick_lava_flowing",
	liquid_alternative_source = "lava:thick_lava_source",
	liquid_viscosity = THICK_LAVA_VISC,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=2, hot=3, igniter=1, not_in_creative_inventory=1},
})

minetest.register_node("lava:thick_lava_source", {
	description = "Thick Lava Source",
	inventory_image = minetest.inventorycube("thick_lava.png"),
	drawtype = "liquid",
	tiles = {"thick_lava.png"},
	paramtype = "light",
	light_source = LIGHT,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "lava:thick_lava_flowing",
	liquid_alternative_source = "lava:thick_lava_source",
	liquid_viscosity = THICK_LAVA_VISC,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=2, hot=3, igniter=1},
})

--ABM's for working with Cooling Lava mod

minetest.register_abm ({
	nodenames = {"lava:thick_lava_source", "lava:thick_lava_flowing"},
	neighbors = {"default:water_source", "default:water_flowing"},
	interval = 1.0,
	chance = 1,
	action = function (pos)
		minetest.env: add_node (pos, {name = "lavacooling:obsidian"})
	end,
})

minetest.register_abm ({
	nodenames = {"lava:thick_lava_source", "lava:thick_lava_flowing"},
	neighbors = {"air"},
	interval = 5.0,
	chance = THICK_LAVA_COOLING_RATE,
	action = function (pos)
		minetest.env: add_node (pos, {name = "lavacooling:moltenrock"})
	end,
})

--Bucket (so that you can collect/place lavas)

bucket.register_liquid(
	"lava:thick_lava_source",
	"lava:thick_lava_flowing",
	"lava:bucket_thick_lava",
	"bucket_thick_lava.png"
)