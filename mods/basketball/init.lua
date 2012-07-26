minetest.register_craftitem("basketball:ball", {
    image = "basketball_ball.png",
    on_place_on_ground = craftitem_place_item,
})

--
--Goal
--


minetest.register_node("basketball:goal1", {
        description = Goal1,
	tiles = {"basketball_goal.png", "basketball_goal.png", "basketball_goal.png",
		"basketball_goal.png", "basketball_goal.png", "basketball_goal1_front.png"},
	paramtype2 = "facedir",
        walkable = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
        drawtype= draw,
        walkable = true,
})

minetest.register_node("basketball:goal2", {
        description = Goal2,
	tiles = {"basketball_goal.png", "basketball_goal.png", "basketball_goal.png",
		"basketball_goal.png", "basketball_goal.png", "basketball_goal2.png"},
	paramtype2 = "facedir",
        walkable = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
        drawtype= draw,
        walkable = true,
})

minetest.register_node("basketball:goal3", {
        description = Goal3,
	tiles = {"basketball_goal.png", "basketball_goal.png", "basketball_goal.png",
		"basketball_goal.png", "basketball_goal.png", "basketball_goal3_front.png"},
	paramtype2 = "facedir",
        walkable = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
        drawtype= draw,
        walkable = true,
})

minetest.register_node("basketball:goal4", {
        description = Goal4,
	tiles = {"basketball_goal.png", "basketball_goal.png", "basketball_goal.png",
		"basketball_goal.png", "basketball_goal.png", "basketball_goal4_front.png"},
	paramtype2 = "facedir",
        walkable = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
        drawtype= draw,
        walkable = true,
})

minetest.register_node("basketball:goal5", {
        description = Goal5,
	tiles = {"basketball_goal.png", "basketball_goal.png", "basketball_goal.png",
		"basketball_goal.png", "basketball_goal.png", "basketball_goal5.png"},
	paramtype2 = "facedir",
        walkable = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
        drawtype= draw,
        walkable = true,
})

minetest.register_node("basketball:goal6", {
        description = Goal6,
	tiles = {"basketball_goal.png", "basketball_goal.png", "basketball_goal.png",
		"basketball_goal.png", "basketball_goal.png", "basketball_goal6_front.png"},
	paramtype2 = "facedir",
        walkable = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
        drawtype= draw,
        walkable = true,
})


minetest.register_node("basketball:net", {
        description = Net,
	tiles = {"basketball_net_top.png", "basketball_net_top.png", "basketball_net_side.png",
		"basketball_net_side.png", "basketball_net_side.png", "basketball_net_front.png"},
	paramtype2 = "facedir",
        walkable = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
        drawtype= draw,
        walkable = false,
})

minetest.register_node("basketball:pole", {
	description = "Pole",
	drawtype = "fencelike",
	tiles = {"basketball_pole.png"},
	inventory_image = "basketball_pole_inventory.png",
	wield_image = "basketball_pole_inventory.png",
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2},
	sounds = default.node_sound_wood_defaults(),
})


 