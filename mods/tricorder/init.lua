-- init.lua
-- tricorder minetest mod, by darkrose
-- Copyright (C) Lisa Milne 2012 <lisa@ltmnet.com>
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 2 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-- See the GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>

local searches = {
	{name="coal",node="default:stone_with_coal"},
	{name="iron",node="default:stone_with_iron"},
	{name="mese",node="default:mese"},
	{name="lava",node="default:lava_source"},
	{name="gold",node="moreores:mineral_gold"},
	{name="silver",node="moreores:mineral_silver"},
	{name="copper",node="moreores:mineral_copper"},
	{name="tin",node="moreores:mineral_tin"},
	{name="mithril",node="moreores:mineral_mithril"}
}


minetest.register_node("tricorder:tricorder", {
	description = "Tricorder",
	drawtype = "nodebox",
	tiles = {"tricorder_tricorder.png","tricorder_tricorder.png","tricorder_tricorder_front.png","tricorder_tricorder.png"},
	paramtype = "light",
	liquids_pointable = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2},
	node_box = {
		type = "fixed",
		fixed = {
			-- x,y,z,x,y,z
			{0, -0.2, -0.2, 0.1, 0.5, 0.2},
			{0.1, -0.4, -0.2, 0.2, -0.1, 0.2},
			{0.1, 0.2, -0.2, 0.2, 0.5, 0.2},
		},
	},
	on_use = function(itemstack, user, pointed_thing)
		local name = user:get_player_name()
		local node
		local pos
		local ppos
		local found = false

		if pointed_thing.type == 'node' then
			node = minetest.env:get_node(pointed_thing.above)
			if node.name == "air" then
				node = minetest.env:get_node(pointed_thing.under)
				pos = pointed_thing.under
			else
				pos = pointed_thing.above
			end
			ppos = pos
			minetest.chat_send_player(name, 'Tricorder: pointing at '..node.name..' '..minetest.pos_to_string(pos))
		elseif pointed_thing.type == 'object' then
			pos = pointed_thing.ref:getpos()
			ppos = pos
			minetest.chat_send_player(name, 'Tricorder: pointing at Object '..minetest.pos_to_string(pos))
		else
			pos = user:getpos()
			ppos = {x = math.floor(pos.x),y = math.floor(pos.y),z = math.floor(pos.z)}
			minetest.chat_send_player(name, 'Tricorder: pointing at Air from '..minetest.pos_to_string(ppos))
		end
		for i,n in ipairs(searches) do
			pos = minetest.env:find_node_near(ppos,16,n.node)
			if pos then
				minetest.chat_send_player(name, 'Tricorder: '..n.name..' at '..minetest.pos_to_string(pos))
				found = true
			end
		end
		if not found then
			minetest.chat_send_player(name, 'Tricorder: no resources found')
		end
		return nil
	end
})

minetest.register_craft({
	output = "tricorder:tricorder",
	recipe = {
		{"default:mese"},
		{"default:steel_ingot"},
	}
})
