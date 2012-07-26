-- Minetest 0.4.1 mod: technic

minetest.register_alias("rebar", "technic:rebar")
minetest.register_alias("concrete", "technic:concrete")
minetest.register_alias("iron_chest", "technic:iron_chest")
minetest.register_alias("iron_locked_chest", "technic:iron_locked_chest")
minetest.register_alias("copper_chest", "technic:copper_chest")
minetest.register_alias("copper_locked_chest", "technic:copper_locked_chest")
minetest.register_alias("silver_chest", "technic:silver_chest")
minetest.register_alias("silver_locked_chest", "technic:silver_locked_chest")
minetest.register_alias("gold_chest", "technic:gold_chest")
minetest.register_alias("gold_locked_chest", "technic:gold_locked_chest")
minetest.register_alias("mithril_chest", "technic:mithril_chest")
minetest.register_alias("mithril_locked_chest", "technic:mithril_locked_chest")


minetest.register_craft({
	output = 'technic:rebar 6',
	recipe = {
		{'','', 'default:steel_ingot'},
		{'','default:steel_ingot',''},
		{'default:steel_ingot', '', ''},
	}
})

minetest.register_craft({
	output = 'technic:concrete 5',
	recipe = {
		{'default:stone','technic:rebar','default:stone'},
		{'technic:rebar','default:stone','technic:rebar'},
		{'default:stone','technic:rebar','default:stone'},
	}
})
minetest.register_craft({
	output = 'technic:iron_chest 1',
	recipe = {
		{'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
		{'default:steel_ingot','default:chest','default:steel_ingot'},
		{'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
	}
})
minetest.register_craft({
	output = 'technic:iron_locked_chest 1',
	recipe = {
		{'default:steel_ingot'},
		{'technic:iron_chest'},
	}
})

minetest.register_craft({
	output = 'technic:copper_chest 1',
	recipe = {
		{'moreores:copper_ingot','moreores:copper_ingot','moreores:copper_ingot'},
		{'moreores:copper_ingot','technic:iron_chest','moreores:copper_ingot'},
		{'moreores:copper_ingot','moreores:copper_ingot','moreores:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:copper_locked_chest 1',
	recipe = {
		{'moreores:copper_ingot','moreores:copper_ingot','moreores:copper_ingot'},
		{'moreores:copper_ingot','technic:iron_locked_chest','moreores:copper_ingot'},
		{'moreores:copper_ingot','moreores:copper_ingot','moreores:copper_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:copper_locked_chest 1',
	recipe = {
		{'default:steel_ingot'},
		{'technic:copper_chest'},
	}
})

minetest.register_craft({
	output = 'technic:silver_chest 1',
	recipe = {
		{'moreores:silver_ingot','moreores:silver_ingot','moreores:silver_ingot'},
		{'moreores:silver_ingot','technic:copper_chest','moreores:silver_ingot'},
		{'moreores:silver_ingot','moreores:silver_ingot','moreores:silver_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:silver_locked_chest 1',
	recipe = {
		{'moreores:silver_ingot','moreores:silver_ingot','moreores:silver_ingot'},
		{'moreores:silver_ingot','technic:copper_locked_chest','moreores:silver_ingot'},
		{'moreores:silver_ingot','moreores:silver_ingot','moreores:silver_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:silver_locked_chest 1',
	recipe = {
		{'default:steel_ingot'},
		{'technic:silver_chest'},
	}
})

minetest.register_craft({
	output = 'technic:gold_chest 1',
	recipe = {
		{'moreores:gold_ingot','moreores:gold_ingot','moreores:gold_ingot'},
		{'moreores:gold_ingot','technic:silver_chest','moreores:gold_ingot'},
		{'moreores:gold_ingot','moreores:gold_ingot','moreores:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:gold_locked_chest 1',
	recipe = {
		{'moreores:gold_ingot','moreores:gold_ingot','moreores:gold_ingot'},
		{'moreores:gold_ingot','technic:silver_locked_chest','moreores:gold_ingot'},
		{'moreores:gold_ingot','moreores:gold_ingot','moreores:gold_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:gold_locked_chest 1',
	recipe = {
		{'default:steel_ingot'},
		{'technic:gold_chest'},
	}
})

minetest.register_craft({
	output = 'technic:mithril_chest 1',
	recipe = {
		{'moreores:mithril_ingot','moreores:mithril_ingot','moreores:mithril_ingot'},
		{'moreores:mithril_ingot','technic:gold_chest','moreores:mithril_ingot'},
		{'moreores:mithril_ingot','moreores:mithril_ingot','moreores:mithril_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:gold_locked_chest 1',
	recipe = {
		{'moreores:mithril_ingot','moreores:mithril_ingot','moreores:mithril_ingot'},
		{'moreores:mithril_ingot','technic:gold_locked_chest','moreores:mithril_ingot'},
		{'moreores:mithril_ingot','moreores:mithril_ingot','moreores:mithril_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:mithril_locked_chest 1',
	recipe = {
		{'default:steel_ingot'},
		{'technic:mithril_chest'},
	}
})

minetest.register_craftitem("technic:rebar", {
	description = "Rebar",
	inventory_image = "technic_rebar.png",
	stack_max = 99,
})

minetest.register_craftitem("technic:concrete", {
	description = "Concrete Block",
	inventory_image = "technic_concrete_block.png",
	stack_max = 99,
})

minetest.register_craftitem("technic:iron_chest", {
	description = "Iron Chest",
	stack_max = 99,
})
minetest.register_craftitem("technic:iron_locked_chest", {
	description = "Iron Locked Chest",
	stack_max = 99,
})

minetest.register_node("technic:concrete", {
	description = "Concrete Block",
	tile_images = {"technic_concrete_block.png"},
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("technic:copper_chest", {
	description = "Copper Chest",
	tiles = {"technic_copper_chest_top.png", "technic_copper_chest_top.png", "technic_copper_chest_side.png",
		"technic_copper_chest_side.png", "technic_copper_chest_side.png", "technic_copper_chest_front.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[10,9;]"..
				"list[current_name;main;0,0;10,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Copper Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 10*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_take_allow_all(
				pos, listname, index, count, player)
	end,
})

local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_node("technic:copper_locked_chest", {
	description = "Copper Locked Chest",
	tiles = {"technic_copper_chest_top.png", "technic_copper_chest_top.png", "technic_copper_chest_side.png",
		"technic_copper_chest_side.png", "technic_copper_chest_side.png", "technic_copper_chest_locked.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Locked Copper Chest (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[10,9;]"..
				"list[current_name;main;0,0;10,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Locked Copper Chest")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 10*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return
		end
		minetest.log("action", player:get_player_name()..
				" moves stuff in locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return stack
		end
		minetest.log("action", player:get_player_name()..
				" moves stuff to locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return
		end
		minetest.log("action", player:get_player_name()..
				" takes stuff from locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_take_allow_all(
				pos, listname, index, count, player)
	end,
})

minetest.register_node("technic:iron_chest", {
	description = "Iron Chest",
	tiles = {"technic_iron_chest_top.png", "technic_iron_chest_top.png", "technic_iron_chest_side.png",
		"technic_iron_chest_side.png", "technic_iron_chest_side.png", "technic_iron_chest_front.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[9,9;]"..
				"list[current_name;main;0,0;9,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Iron Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 9*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_take_allow_all(
				pos, listname, index, count, player)
	end,
})

local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_node("technic:iron_locked_chest", {
	description = "Iron Locked Chest",
	tiles = {"technic_iron_chest_top.png", "technic_iron_chest_top.png", "technic_iron_chest_side.png",
		"technic_iron_chest_side.png", "technic_iron_chest_side.png", "technic_iron_chest_locked.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Locked Iron Chest (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[9,9;]"..
				"list[current_name;main;0,0;9,4;]"..
				"list[current_player;main;0,5;9,4;]")
		meta:set_string("infotext", "Iron Locked Chest")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 9*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return
		end
		minetest.log("action", player:get_player_name()..
				" moves stuff in locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return stack
		end
		minetest.log("action", player:get_player_name()..
				" moves stuff to locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return
		end
		minetest.log("action", player:get_player_name()..
				" takes stuff from locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_take_allow_all(
				pos, listname, index, count, player)
	end,
})


minetest.register_node("technic:silver_chest", {
	description = "Silver Chest",
	tiles = {"technic_silver_chest_top.png", "technic_silver_chest_top.png", "technic_silver_chest_side.png",
		"technic_silver_chest_side.png", "technic_silver_chest_side.png", "technic_silver_chest_front.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[11,9;]"..
				"list[current_name;main;0,0;11,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Silver Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 11*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_take_allow_all(
				pos, listname, index, count, player)
	end,
})

local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_node("technic:silver_locked_chest", {
	description = "Silver Locked Chest",
	tiles = {"technic_silver_chest_top.png", "technic_silver_chest_top.png", "technic_silver_chest_side.png",
		"technic_silver_chest_side.png", "technic_silver_chest_side.png", "technic_silver_chest_locked.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Locked Silver Chest (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[11,9;]"..
				"list[current_name;main;0,0;11,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Locked Silver Chest")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 11*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return
		end
		minetest.log("action", player:get_player_name()..
				" moves stuff in locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return stack
		end
		minetest.log("action", player:get_player_name()..
				" moves stuff to locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return
		end
		minetest.log("action", player:get_player_name()..
				" takes stuff from locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_take_allow_all(
				pos, listname, index, count, player)
	end,
})

minetest.register_node("technic:gold_chest", {
	description = "Gold Chest",
	tiles = {"technic_gold_chest_top.png", "technic_gold_chest_top.png", "technic_gold_chest_side.png",
		"technic_gold_chest_side.png", "technic_gold_chest_side.png", "technic_gold_chest_front.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[12,9;]"..
				"list[current_name;main;0,0;12,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Gold Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 12*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_take_allow_all(
				pos, listname, index, count, player)
	end,
})

local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_node("technic:gold_locked_chest", {
	description = "Gold Locked Chest",
	tiles = {"technic_gold_chest_top.png", "technic_gold_chest_top.png", "technic_gold_chest_side.png",
		"technic_gold_chest_side.png", "technic_gold_chest_side.png", "technic_gold_chest_locked.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Locked Gold Chest (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[12,9;]"..
				"list[current_name;main;0,0;12,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Locked Silver Chest")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 12*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return
		end
		minetest.log("action", player:get_player_name()..
				" moves stuff in locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return stack
		end
		minetest.log("action", player:get_player_name()..
				" moves stuff to locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return
		end
		minetest.log("action", player:get_player_name()..
				" takes stuff from locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_take_allow_all(
				pos, listname, index, count, player)
	end,
})

minetest.register_node("technic:mithril_chest", {
	description = "Mithril Chest",
	tiles = {"technic_mithril_chest_top.png", "technic_mithril_chest_top.png", "technic_mithril_chest_side.png",
		"technic_mithril_chest_side.png", "technic_mithril_chest_side.png", "technic_mithril_chest_front.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[13,9;]"..
				"list[current_name;main;0,0;13,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Mithril Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 13*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_take_allow_all(
				pos, listname, index, count, player)
	end,
})

local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_node("technic:mithril_locked_chest", {
	description = "Mithril Locked Chest",
	tiles = {"technic_mithril_chest_top.png", "technic_mithril_chest_top.png", "technic_mithril_chest_side.png",
		"technic_mithril_chest_side.png", "technic_mithril_chest_side.png", "technic_mithril_chest_locked.png"},
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Locked Mithril Chest (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec",
				"invsize[13,9;]"..
				"list[current_name;main;0,0;13,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Locked Mithril Chest")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 13*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return
		end
		minetest.log("action", player:get_player_name()..
				" moves stuff in locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_move_allow_all(
				pos, from_list, from_index, to_list, to_index, count, player)
	end,
    on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return stack
		end
		minetest.log("action", player:get_player_name()..
				" moves stuff to locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_offer_allow_all(
				pos, listname, index, stack, player)
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return
		end
		minetest.log("action", player:get_player_name()..
				" takes stuff from locked chest at "..minetest.pos_to_string(pos))
		return minetest.node_metadata_inventory_take_allow_all(
				pos, listname, index, count, player)
	end,
})