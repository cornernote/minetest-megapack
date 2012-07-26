---
--Bones 1.01
--Copyright (C) 2012 Bad_Command
--
--This library is free software; you can redistribute it and/or
--modify it under the terms of the GNU Lesser General Public
--License as published by the Free Software Foundation; either
--version 2.1 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU Lesser General Public
--License along with this library; if not, write to the Free Software
--Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
----

bones = {}
bones.version = 1.01

-- config.lua contains configuration parameters
dofile(minetest.get_modpath("bones").."/config.lua")
-- bones.lua contains the code
dofile(minetest.get_modpath("bones").."/bones.lua")

minetest.register_node("bones:bones", {
	description = "Old Bones",
	tiles ={"bones_top.png", "bones_bottom.png", "bones_side.png",
		"bones_side.png", "bones_rear.png", "bones_front.png"},
	paramtype2 = "facedir",
	groups = {crumbly=2},
	paramtype = "light",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.45},
	}),
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", "")
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv == nil or inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
	end,
	on_metadata_inventory_offer = function(pos, listname, index, stack, player)
		return stack
	end,
   	on_metadata_inventory_take = bones.inventory_take,
})

minetest.register_abm(
	{nodenames = {"bones:bones"},
	interval = 10.0,
	chance = 1,
	action = bones.action
})

minetest.register_on_dieplayer(bones.on_dieplayer)

