--
--Fireworks by InfinityProject
--License code and textures WTFPL 
--Thanks to Mauvebic, Cornernote, and Neuromancer

--Sound will be added soon

minetest.register_abm({
		nodenames = {"fireworks:red", "fireworks:blue", "fireworks:green", "fireworks:purple", "fireworks:orange", "fireworks:yellow", "fireworks:rainbow"},
		interval = 8,
		chance = 1,	
		
		action = function(pos, node, active_object_count, active_object_count_wider)
		if node.name == "fireworks:red" then
				  minetest.env:remove_node(pos,{name="fireworks:red"})
		elseif node.name == "fireworks:blue" then
		          minetest.env:remove_node(pos,{name="fireworks:blue"})
		elseif node.name == "fireworks:green" then
				  minetest.env:remove_node(pos,{name="fireworks:green"})
		elseif node.name == "fireworks:purple" then
		          minetest.env:remove_node(pos,{name="fireworks:purple"})
		elseif node.name == "fireworks:orange" then
				  minetest.env:remove_node(pos,{name="fireworks:orange"})
		elseif node.name == "fireworks:yellow" then
		          minetest.env:remove_node(pos,{name="fireworks:yellow"})
		elseif node.name == "fireworks:rainbow" then
		          minetest.env:remove_node(pos,{name="fireworks:rainbow"})
				  
			end
		end
})


minetest.register_node("fireworks:firework_red", {
	description = "Red Fireworks",
	tiles = {"fireworks_firework_red.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("fireworks:red", {
	drawtype = "plantlike",
	description = "Red",
	tiles = {"fireworks_red.png"},
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	pointable = false,
	groups = {cracky=3,not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("fireworks:firework_blue", {
	description = "Blue Fireworks",
	tiles = {"fireworks_firework_blue.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("fireworks:blue", {
	drawtype = "plantlike",
	description = "Blue",
	tiles = {"fireworks_blue.png"},
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	pointable = false,
	groups = {cracky=3,not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("fireworks:firework_green", {
	description = "Green Fireworks",
	tiles = {"fireworks_firework_green.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("fireworks:green", {
	drawtype = "plantlike",
	description = "Green",
	tiles = {"fireworks_green.png"},
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	pointable = false,
	groups = {cracky=3,not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("fireworks:firework_purple", {
	description = "Purple Fireworks",
	tiles = {"fireworks_firework_purple.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("fireworks:purple", {
	drawtype = "plantlike",
	description = "Purple",
	tiles = {"fireworks_purple.png"},
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	pointable = false,
	groups = {not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("fireworks:firework_orange", {
	description = "Orange Fireworks",
	tiles = {"fireworks_firework_orange.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("fireworks:orange", {
	drawtype = "plantlike",
	description = "Orange",
	tiles = {"fireworks_orange.png"},
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	pointable = false,
	groups = {cracky=3,not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("fireworks:firework_yellow", {
	description = "Yellow Fireworks",
	tiles = {"fireworks_firework_yellow.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("fireworks:yellow", {
	drawtype = "plantlike",
	description = "Yellow",
	tiles = {"fireworks_yellow.png"},
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	pointable = false,
	groups = {cracky=3,not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("fireworks:firework_rainbow", {
	description = "Rainbow Fireworks",
	tiles = {"fireworks_firework_rainbow.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("fireworks:rainbow", {
	drawtype = "plantlike",
	description = "Rainbow",
	tiles = {"fireworks_rainbow.png"},
	light_source = 14,
	walkable = false,
	is_ground_content = true,
	pointable = false,
	groups = {not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "fireworks:firework_red 2",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:torch", "default:wood"},
		{"default:wood", "default:wood", "default:wood"}
	}
})

minetest.register_craft({
	output = "fireworks:firework_blue 2",
	recipe = {
		{"fireworks:firework_red"}
	}
})

minetest.register_craft({
	output = "fireworks:firework_yellow 2",
	recipe = {
		{"fireworks:firework_blue"}
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "fireworks:firework_green 2",
	recipe = {"fireworks:firework_blue", "fireworks:firework_yellow"},
})

minetest.register_craft({
	type = "shapeless",
	output = "fireworks:firework_purple 2",
	recipe = {"fireworks:firework_red", "fireworks:firework_blue"},
	
})

minetest.register_craft({
	type = "shapeless",
	output = "fireworks:firework_orange 2",
	recipe = {"fireworks:firework_red", "fireworks:firework_yellow"},
	
})

minetest.register_craft({
	type = "shapeless",
	output = "fireworks:firework_rainbow 5",
	recipe = 
		{"fireworks:firework_red", "fireworks:firework_blue", "fireworks:firework_yellow", "fireworks:firework_orange", "fireworks:firework_green", "fireworks:firework_purple"}
	
})

--[[
local fireworks = {
	handler = {},
	{name="FireworkCombo44q5", length=14, gain=1}
}
local play_sound = function(list, number)
		local gain = 1.0
		local handler = minetest.sound_play(list[number].name, {gain=gain})
end]]


function fireworks_activate (pos, node)
--play_sound(fireworks, 1)

zrand = math.random(-10, 10)
xrand = math.random(-10,10)
yrand = math.random(10, 30)
if 
  node.name == "fireworks:firework_red" 
then
local radius = 4 
for x=-radius,radius do
for y=-radius,radius do
for z=-radius,radius do
   if x*x+y*y+z*z <= radius*radius then
      minetest.env:add_node({x=pos.x+x+xrand,y=pos.y+y+yrand,z=pos.z+z+zrand},{name='fireworks:red'}) 
end
end
end
end
minetest.env:remove_node(pos,{name="fireworks:firework_red"})
elseif
  node.name == "fireworks:firework_blue" 
then
local radius = 4 
for x=-radius,radius do
for y=-radius,radius do
for z=-radius,radius do
   if x*x+y*y+z*z <= radius*radius then
      minetest.env:add_node({x=pos.x+x+xrand,y=pos.y+y+yrand,z=pos.z+z+zrand},{name='fireworks:blue'}) 
end
end
end
end
minetest.env:remove_node(pos,{name="fireworks:firework_blue"})
elseif
  node.name == "fireworks:firework_green" 
then
local radius = 4 
for x=-radius,radius do
for y=-radius,radius do
for z=-radius,radius do
   if x*x+y*y+z*z <= radius*radius then
      minetest.env:add_node({x=pos.x+x+xrand,y=pos.y+y+yrand,z=pos.z+z+zrand},{name='fireworks:green'})
end
end
end
end
minetest.env:remove_node(pos,{name="fireworks:firework_green"})
elseif
  node.name == "fireworks:firework_purple" 
then
local radius = 4 
for x=-radius,radius do
for y=-radius,radius do
for z=-radius,radius do
   if x*x+y*y+z*z <= radius*radius then
      minetest.env:add_node({x=pos.x+x+xrand,y=pos.y+y+yrand,z=pos.z+z+zrand},{name='fireworks:purple'})
end
end
end
end
minetest.env:remove_node(pos,{name="fireworks:firework_purple"})
elseif
  node.name == "fireworks:firework_orange" 
then
local radius = 4 
for x=-radius,radius do
for y=-radius,radius do
for z=-radius,radius do
   if x*x+y*y+z*z <= radius*radius then
      minetest.env:add_node({x=pos.x+x+xrand,y=pos.y+y+yrand,z=pos.z+z+zrand},{name='fireworks:orange'})
end
end
end
end
minetest.env:remove_node(pos,{name="fireworks:firework_orange"})
elseif
  node.name == "fireworks:firework_yellow" 
then
local radius = 4 
for x=-radius,radius do
for y=-radius,radius do
for z=-radius,radius do
   if x*x+y*y+z*z <= radius*radius then
      minetest.env:add_node({x=pos.x+x+xrand,y=pos.y+y+yrand,z=pos.z+z+zrand},{name='fireworks:yellow'})
end
end
end
end
minetest.env:remove_node(pos,{name="fireworks:firework_yellow"})
elseif
  node.name == "fireworks:firework_rainbow" 
then
local radius = 4 
for x=-radius,radius do
for y=-radius,radius do
for z=-radius,radius do
   if x*x+y*y+z*z <= radius*radius then
      minetest.env:add_node({x=pos.x+x+xrand,y=pos.y+y+yrand,z=pos.z+z+zrand},{name='fireworks:rainbow'})
end
end
end
end
minetest.env:remove_node(pos,{name="fireworks:firework_rainbow"})
end
end
minetest.register_on_punchnode(fireworks_activate)

print("Fireworks Mod Loaded!")