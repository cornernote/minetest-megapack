-- init.lua
-- roof minetest mod, by darkrose
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

minetest.register_node("roof:thatch", {
	description = "Thatch",
	tiles = {"roof_thatch.png"},
	paramtype = "light",
	drawtype = "raillike",
	is_ground_content = true,
	inventory_image = "roof_thatch.png",
	wield_image = "roof_thatch.png",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
	},
})

minetest.register_node("roof:bluecanvas", {
	description = "Blue Striped Canvas",
	tiles = {"roof_bluecanvas.png"},
	paramtype = "light",
	drawtype = "raillike",
	is_ground_content = true,
	inventory_image = "roof_thatch.png",
	wield_image = "roof_thatch.png",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
	},
})

minetest.register_node("roof:redcanvas", {
	description = "Red Striped Canvas",
	tiles = {"roof_redcanvas.png"},
	paramtype = "light",
	drawtype = "raillike",
	is_ground_content = true,
	inventory_image = "roof_thatch.png",
	wield_image = "roof_thatch.png",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
	},
})

minetest.register_node("roof:slatetile", {
	description = "Slate Tile",
	tiles = {"roof_slatetile.png"},
	paramtype = "light",
	drawtype = "raillike",
	is_ground_content = true,
	inventory_image = "roof_slatetile.png",
	wield_image = "roof_slatetile.png",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = "",
	}),
	selection_box = {
		type = "fixed",
	},
})

minetest.register_node("roof:claytile", {
	description = "Clay Tile",
	tiles = {"roof_claytile.png"},
	paramtype = "light",
	drawtype = "raillike",
	is_ground_content = true,
	inventory_image = "roof_claytile.png",
	wield_image = "roof_claytile.png",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = "",
	}),
	selection_box = {
		type = "fixed",
	},
})

minetest.register_craft({
	output = '"roof:thatch" 4',
	recipe = {
		{'"default:junglegrass"'},
		{'"default:junglegrass"'},
	}
})

minetest.register_craft({
	output = '"roof:bluecanvas" 4',
	recipe = {
		{'"roof:thatch"'},
		{'"flowers:flower_viola"'},
	}
})

minetest.register_craft({
	output = '"roof:redcanvas" 4',
	recipe = {
		{'"roof:thatch"'},
		{'"flowers:flower_rose"'},
	}
})

minetest.register_craft({
	output = '"roof:claytile" 4',
	recipe = {
		{'"default:clay"'},
		{'"default:clay"'},
	}
})

minetest.register_craft({
	output = '"roof:slatetile" 4',
	recipe = {
		{'"default:stone"'},
		{'"default:stone"'},
	}
})
