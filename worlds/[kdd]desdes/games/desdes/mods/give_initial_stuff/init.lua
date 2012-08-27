minetest.register_on_newplayer(function(player)
	print("[minimal] giving initial stuff to player")
	player:get_inventory():add_item('main', 'default:pick_wood')
	player:get_inventory():add_item('main', 'default:axe_wood')
	player:get_inventory():add_item('main', 'default:torch 99')
	player:get_inventory():add_item('main', 'default:cobble 99')
	player:get_inventory():add_item('main', 'default:wood 99')
end)

