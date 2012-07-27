DIG_END = -50

minetest.register_craftitem("ed:earth_driller", {
 description = "Earth Driller",
 tiles = "default_mese.png",
 inventory_image = "default_mese.png",
 stack_max = 1,
 is_ground_content = true,
 groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
})
minetest.register_abm({
 nodenames = "ed:earth_driller",
 interval = 1.0,
 chance = 1,
 action = function(pos, node)
 print("[ed] drilling")
 local DIG_END_ABS = DIG_END + pos.y
 local currpos = {}
 for y=(pos.y-1),DIG_END_ABS, -1 do
 currpos = {x=pos.x, y=y, z=pos.z}
 minetest.env:remove_node(currpos)
-- minetest.env:set_node(currpos, {name="vines:rope"})
 print('[ed] drilled narrow to '..y)
 end
 for y=(pos.y-5),DIG_END_ABS, -1 do
 currpos = {x=pos.x, y=y, z=pos.z}
 minetest.env:remove_node({x=pos.x-1, y=y, z=pos.z-1})
 minetest.env:remove_node({x=pos.x-1, y=y, z=pos.z})
 minetest.env:remove_node({x=pos.x-1, y=y, z=pos.z+1})
 minetest.env:remove_node({x=pos.x, y=y, z=pos.z-1})
 minetest.env:remove_node({x=pos.x, y=y, z=pos.z+1})
 minetest.env:remove_node({x=pos.x+1, y=y, z=pos.z-1})
 minetest.env:remove_node({x=pos.x+1, y=y, z=pos.z})
 minetest.env:remove_node({x=pos.x+1, y=y, z=pos.z+1})
 print('[ed] drilled wide to '..y)
 end
 minetest.env:remove_node(pos)
 --minetest.env:set_node(pos, {name="vines:rope_block"})
 end
})
-- Crafts
minetest.register_craft({
 output = 'ed:earth_driller',
 recipe = {
 {'', 'default:steel_ingot', 'default:steel_ingot'},
 {'ed:driller_bit', 'ed:driller_motor', 'default:steel_ingot'},
 {'', 'default:steel_ingot', 'default:steel_ingot'},
 }
})
minetest.register_craft({
 output = 'ed:driller_bit',
 recipe = {
 {'', '', ''},
 {'', 'default:steel_ingot', ''},
 {'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
 }
})
minetest.register_craft({
 output = 'ed:driller_motor',
 recipe = {
 {'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
 {'default:steel_ingot', 'default:mese', 'default:steel_ingot'},
 {'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
 }
})

-- Nodes
minetest.register_node("ed:earth_driller", {
 description = "Earth Driller",
 tiles = {"earth_driller.png"},
 inventory_image = ("inventory_drill.png"),
 stack_max = 1,
 groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
 
})
minetest.register_node("ed:driller_bit", {
 description = "Drill_Bit",
 drawtype = 'plantlike',
 tiles = {"driller_bit.png"},
 
})
minetest.register_node("ed:driller_motor", {
 description = "Drill_Motor",
 drawtype = 'plantlike',
 tiles = {"driller_motor.png"},
 
})
