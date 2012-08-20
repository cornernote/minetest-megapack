--[[
-- Mod        fire flowers
-- Author	    Bas080
-- Copyright  GNU GPL
-- Version    1.2
-- Feature    Adds fireflowers at night which gives light.
--]]

minetest.register_node("fire_flowers:fireflower", {
	tile_images = {"plants_fireflower.png"},
	inventory_image = "plants_fireflower.png",
	drawtype = 'plantlike',
	visual_scale = 0.7,
	sunlight_propagates = true,
	paramtype = 'light',
	selection_box = {
		type = "fixed",
	},
	walkable = false,
	light_source = 8,
	groups = {dig_immediate=3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_abm(
	{nodenames = {"default:dirt_with_grass"},
	interval = 5,
	chance = 1000,
	action = function(pos)
		if (minetest.env:get_timeofday() < 0.5) then
		pos.y=pos.y+1
		minetest.env:add_node(pos, {name="fire_flowers:fireflower"})
		end
	end,
})

minetest.register_abm(
	{nodenames = {"plants:fireflower"},
	interval = 1,
	chance = 1,
	action = function(pos)
		minetest.env:add_node(pos, {name="fire_flowers:fireflower"})
	end,
})

minetest.register_abm(
	{nodenames = {"fire_flowers:fireflower"},
	interval = 5,
	chance = 10,
	action = function(pos)
		if (minetest.env:get_timeofday() > 0.1) then
		minetest.env:remove_node(pos)
		end
	end,
})


