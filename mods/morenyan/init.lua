--MoreNyan mod by InfinityProject. Code and textures WTFPL. 
--This mods add nyan themed tools, blocks, and other nodes.
--Enjoy

--
--Nodes
--

minetest.register_node ("morenyan:catblock", {
    drawtype = draw,
    description = "Cat Block",
    tiles = {"morenyan_catblock.png"},
    inventory_image = {"morenyan_catblock.png"},
    sunlight_propagates = true,
    paramtype = 'light',
    walkable = true,
    light_source = 10,
    material = minetest.digprop_constanttime(1.0),
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,}
   })

minetest.register_node("morenyan:ladder", {
    description = "Nyan Ladder",
    drawtype = "signlike",
    tiles = {"morenyan_ladder.png"},
    inventory_image = "morenyan_ladder.png",
    wield_image = "morenyan_ladder.png",
    paramtype = "light",
    paramtype2 = "wallmounted",
    is_ground_content = true,
    walkable = false,
    climbable = true,
    light_source = 10,
    selection_box = {
        type = "wallmounted",
        --wall_top = = <default>
        --wall_bottom = = <default>
        --wall_side = = <default>
    },
    material = minetest.digprop_glasslike(5.0),
    legacy_wallmounted = true,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,}
})

minetest.register_node("morenyan:fence", {
	description = "Nyan Fence",
	drawtype = "fencelike",
	tiles = {"morenyan_catblock.png"},
	inventory_image = "morenyan_fence_inventory.png",
	wield_image = "morenyan_catblock.png",
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,},
	sounds = default.node_sound_wood_defaults(),
})



--
--TAC NAYN!!!!!!!!!!
--

minetest.register_node("morenyan:tacnayn", {
	description = "Tacnayn",
	tiles = {"morenyan_tacnayn_side.png", "morenyan_tacnayn_side.png", "morenyan_tacnayn_side.png",
		"morenyan_tacnayn_side.png", "morenyan_tacnayn_back.png", "morenyan_tacnayn_front.png"},
	inventory_image = "morenyan_tacnayn_front.png",
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_defaults(),
})

minetest.register_node("morenyan:tacnayn_rainbow", {
	description = "Tacnayn Rainbow",
	tiles = {"morenyan_tacnayn_rainbow.png"},
	inventory_image = "morenyan_tacnayn_rainbow.png",
	groups = {cracky=2},
	sounds = default.node_sound_defaults(),
})