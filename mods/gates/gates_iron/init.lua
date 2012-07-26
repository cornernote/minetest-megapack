-- gates_iron
-- By Splizard
-- Forum post: http://c55.me/minetest/forum/viewtopic.php?id=896
--
-- This program is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.
--      
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--      
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
-- MA 02110-1301, USA.
--      

minetest.register_alias("gates_iron:gate",'gates_iron:classic')
minetest.register_alias("gates_iron:gate_open",'gates_iron:classic_open')

-- Nodes
--
gates.register_node('gates_iron:classic', {
	description = "Iron Gate",
    groups = {snappy=1,bendy=2},
    drop = "gates_iron:gate",
},
{
    drawtype = 'plantlike',
    sunlight_propagates = true,
    paramtype = 'light',
    visual_scale = 1.5,
	tiles = {'gate_iron_open.png'},
	walkable = false,
},
{
	tiles = {'gate_iron_top.png','gate_iron_top.png','gate_iron.png'},
	walkable = true,
}, "on_mesecon")

gates.register_node('gates_iron:long', {
	description = "Long Iron Gate",
    groups = {snappy=1,bendy=2},
    paramtype2 = "facedir",
    drop = "gates_iron:long",
    selection_box = {
		type = "fixed",
		fixed = {
			{-0.9, -0.25, -0.1, 0.9, 0.25, 0.1},
		},
	},
	tiles = {'gate_iron_long.png'},
	sunlight_propagates = true,
    paramtype = "light",
},
{
    drawtype = 'nodebox',
    node_box = {
		type = "fixed",
		fixed = {
			{-1, -0.25, -0.1, -0.9, 0.25, 1},
			{ 0.9, 0.25, 1,1, -0.25, -0.1},
		},
	},
},
{
	drawtype = 'nodebox',
    node_box = {
		type = "fixed",
		fixed = {
			{-1, -0.25, -0.1, 1, 0.25, 0.1},
		},
	},
	walkable = true,
}, "on_mesecon")

-- 
-- Nodes
--
gates.register_node('gates_iron:short', {
	description = "Short Iron Gate",
    groups = {choppy=2,dig_immediate=2},
    paramtype2 = "facedir",
    drop = "gates_iron:short",
    selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.06, 0.5, 0.5, 0.06},
		},
	},
	tiles = {'default_stone.png'},
	--sunlight_propagates = true,
    paramtype = "light",
},
{
    drawtype = 'nodebox',
    node_box = {
		type = "fixed",
		fixed = {
			--Left
			{-0.5, -0.15, -0.06, -0.4, 0.4,  0.19},     --|
			{-0.5,  0,     0.34, -0.4, 0.25, 0.50},     --  |
			{-0.5,  0.25,  0.19, -0.4, 0.4,  0.50},     -- -
			{-0.5, -0.15,  0.19, -0.4, 0,    0.50},     -- _
			
			--Right
			{0.4, -0.15, -0.06, 0.5, 0.4,  0.19},     --|
			{0.4,  0,     0.34, 0.5, 0.25, 0.50},     --  |
			{0.4,  0.25,  0.19, 0.5, 0.4,  0.50},     -- -
			{0.4, -0.15,  0.19, 0.5, 0,    0.50},     -- _
		},
	},
	walkable = false,
},
{
	drawtype = 'nodebox',
    node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.15, -0.06, -0.25, 0.4, 0.06},   --|
			{0.25, -0.15, -0.06, 0.5, 0.4, 0.06},     --  |
			{-0.125, 0, -0.06, 0.125, 0.25, 0.06},    -- |
			{-0.25, 0.25, -0.06, 0.25, 0.4, 0.06},    -- -
			{0.25, 0, -0.06, -0.25, -0.15, 0.06},     -- _
		},
	},
	walkable = true,
})

local gate_on_mesecon = function(pos,node)
	if gates.registered_nodes["on_mesecon"][node.name] ~= nil then
		minetest.env:add_node(pos, {
			name = gates.registered_nodes["on_mesecon"][node.name],
			param2 = node.param2
		})
	end
end

--
-- Crafts
--
minetest.register_craft({
    output = '"gates_iron:gate" 2',
    recipe = {
        {"default:iron_lump", "default:steel_ingot", "default:iron_lump"},
        {"default:iron_lump", "default:steel_ingot", "default:iron_lump"},
    },
})

minetest.register_craft({
    output = '"gates_iron:short" 1',
    recipe = {
        {"default:iron_lump", "default:iron_lump"},
    },
})
minetest.register_craft({
    output = '"gates_iron:long" 1',
    recipe = {
        {"default:iron_lump", "default:steel_ingot", "default:iron_lump"},
    },
})

-- Mesecon Stuff:
mesecon:register_on_signal_on(gate_on_mesecon)
mesecon:register_on_signal_off(gate_on_mesecon)
