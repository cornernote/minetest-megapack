scribing_table = {}

minetest.register_craft({
	output = 'scribing_table:self',
	recipe = {
		{'','default:stick',''},
		{'default:wood','default:glass','default:wood'},
		{'default:wood','default:wood','default:wood'},
	}
})

minetest.register_node("scribing_table:self", {
	description = "Scribing table",
	tiles = {"scribing_table_top.png", "default_wood.png", "default_wood.png^scribing_table_side.png"},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.3,0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,0.3,0.5},
		},
	},
	groups = {oddly_breakable_by_hand=3, dig_immediate=2},
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "invsize[8,10;]"..
				--"image[0,2;1,1;scribing_table_scribing.png]"..
				"list[current_name;paper;1,1;1,1;]"..
				"list[current_name;dye_axe;4,1;1,1;]"..
				"list[current_name;dye_pick;4,2;1,1;]"..
				"list[current_name;dye_shovel;4,3;1,1;]"..
				"list[current_name;dye_sword;4,4;1,1;]"..
				"list[current_name;dye_hammer;4,5;1,1;]"..
				"list[current_name;dye_spear;2,3;1,1;]"..
				"list[current_name;res;6,1;1,1;]"..
				"label[1,0;Paper:]"..
				"label[4,0;Dye:]"..
				"label[6,0;Output:]"..
				"label[3,1;Axe:]"..
				"label[3,2;Pick:]"..
				"label[3,3;Shovel:]"..
				"label[3,4;Sword:]"..
				"label[3,5;Hammer:]"..
				"label[1,3;Spear:]"..
				"list[current_player;main;0,6;8,4;]")
		meta:set_string("infotext", "Scribing table")
		local inv = meta:get_inventory()
		inv:set_size("paper", 1)
		inv:set_size("dye_pick", 1)
		inv:set_size("dye_axe", 1)
		inv:set_size("dye_shovel", 1)
		inv:set_size("dye_sword", 1)
		inv:set_size("dye_hammer", 1)
		inv:set_size("dye_spear", 1)
		inv:set_size("res", 1)
	end,
})

minetest.register_abm({
	nodenames = {"scribing_table:self"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()

		local paperstack = inv:get_stack("paper", 1)
		local dyeaxestack = inv:get_stack("dye_axe", 1)
		local dyepickstack = inv:get_stack("dye_pick", 1)
		local dyeshovelstack = inv:get_stack("dye_shovel", 1)
		local dyeswordstack = inv:get_stack("dye_sword", 1)
		local dyehammerstack = inv:get_stack("dye_hammer", 1)
		local dyespearstack = inv:get_stack("dye_spear", 1)
		
		if paperstack:get_name()=="default:paper" then
			if dyeaxestack:get_name()=="default:leaves" and inv:room_for_item("res","metals:recipe_axe") then
				paperstack:take_item()
				dyeaxestack:take_item()
				inv:set_stack("paper", 1, paperstack)
				inv:set_stack("dye_axe", 1, dyeaxestack)
				inv:add_item("res", "metals:recipe_axe")
				return
			end
			if dyepickstack:get_name()=="default:leaves" and inv:room_for_item("res","metals:recipe_pick") then
				paperstack:take_item()
				dyepickstack:take_item()
				inv:set_stack("paper", 1, paperstack)
				inv:set_stack("dye_pick", 1, dyepickstack)
				inv:add_item("res", "metals:recipe_pick")
				return
			end
			if dyeshovelstack:get_name()=="default:leaves" and inv:room_for_item("res","metals:recipe_shovel") then
				paperstack:take_item()
				dyeshovelstack:take_item()
				inv:set_stack("paper", 1, paperstack)
				inv:set_stack("dye_shovel", 1, dyeshovelstack)
				inv:add_item("res", "metals:recipe_shovel")
				return
			end
			if dyeswordstack:get_name()=="default:leaves" and inv:room_for_item("res","metals:recipe_sword") then
				paperstack:take_item()
				dyeswordstack:take_item()
				inv:set_stack("paper", 1, paperstack)
				inv:set_stack("dye_sword", 1, dyeswordstack)
				inv:add_item("res", "metals:recipe_sword")
				return
			end
			if dyehammerstack:get_name()=="default:leaves" and inv:room_for_item("res","metals:recipe_hammer") then
				paperstack:take_item()
				dyehammerstack:take_item()
				inv:set_stack("paper", 1, paperstack)
				inv:set_stack("dye_hammer", 1, dyehammerstack)
				inv:add_item("res", "metals:recipe_hammer")
				return
			end
			if dyespearstack:get_name()=="default:leaves" and inv:room_for_item("res","metals:recipe_spear") then
				paperstack:take_item()
				dyespearstack:take_item()
				inv:set_stack("paper", 1, paperstack)
				inv:set_stack("dye_spear", 1, dyespearstack)
				inv:add_item("res", "metals:recipe_spear")
				return
			end
		end
	end,
})