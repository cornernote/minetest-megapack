minetest.register_node("trash:block", {
description = "Trash block",
tile_images = {"default_nc_front.png",},
is_ground_content = true,
groups = {snappy=1,bendy=2,cracky=1,melty=2,flammable=3},
sounds = default_stone_sounds
})

minetest.register_craft({
	output = 'trash:block',
	recipe = {
		{'default:wood', 'default:wood', 'default:wood'},
		{'default:wood', 'default:cobble', 'default:wood'},
		{'default:wood', 'default:wood', 'default:wood'},
	}
})

minetest.register_on_punchnode(function(pos, node, puncher)	if node.name == "trash:block" then
hit_with = puncher:get_wielded_item()
hit_with_name = hit_with:get_name()
hit_with_count = hit_with:get_count()

puncher:get_inventory():remove_item("main", hit_with)
minetest.chat_send_player(puncher:get_player_name(), 'Clunk!')
end end)
