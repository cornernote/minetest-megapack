---
---Mailbox Mod! By Aqua! Hope You Enjoy This Simple, Yet Fun Mod! 
---

---
---Mailbox
---

minetest.register_node("mailbox:mailbox", {
	description = "Mailbox",
	tiles = {"mailbox_mailbox_top.png", "mailbox_mailbox_bottom.png", "mailbox_mailbox_side_one.png",
		"mailbox_mailbox_side.png", "mailbox_mailbox_back.png", "mailbox_mailbox_front.png"},
	inventory_image = "mailbox_mailbox_front.png",
	paramtype2 = "facedir",
	light_source = 15,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Mailbox (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"size[8,9]"..
				"list[current_name;main;0,0;4,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Mailbox")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 4*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a mailbox belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return count
	end,
	
	 on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to mailbox at "..minetest.pos_to_string(pos))
	end,
	
     on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from mailbox at "..minetest.pos_to_string(pos))
	end,
})				

---
---Crafting
---

minetest.register_craft({
	output = 'mailbox:mailbox ',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:paper', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})