--[[
-- beer mod by ray8888
--]]

math.randomseed(os.time())

local DEBUG = 0

local color = {
    "hops",
    "dandelion_yellow",
    "bush",
    "grape",
	"grape_white",
}

local beer = {
    "hops",
    "dandelion_yellow",
    "bush",
    "grape",
	"grape_white",
}
local dropitem = {
    "beer:beer_hops",
    "beer:beer_dandelion_yellow",
    "beer:bush_berries 5",
    "beer:grape_berries 10",
	"beer:grape_white_berries 10",
}

local beer_DESCRIPTION = {
    "hops",
    "Dandelion yellow",
    "bush",
    "grape",
    "grape white",
    
}

local MAX_RATIO = 800
local GROWING_DELAY = 100

-- Local Functions
local dbg = function(s)
    if DEBUG == 1 then
	print('[BEER] ' .. s)
    end
end

local table_contains = function(t, v)
    for _, i in ipairs(t) do
	if (i == v) then
	    return true
	end
    end

    return false
end

local is_node_in_cube = function(nodenames, node_pos, radius)
    for x = node_pos.x - radius, node_pos.x + radius do
	for y = node_pos.y - radius, node_pos.y + radius do
	    for z = node_pos.z - radius, node_pos.z + radius do
		n = minetest.env:get_node_or_nil({x = x, y = y, z = z})
		if (n == nil)
		    or (n.name == 'ignore')
		    or (table_contains(nodenames, n.name) == true) then
		    return true
		end
	    end
	end
    end

    return false
end

grow_blocks_on_surfaces = function(growdelay, grownames, surfaces)
    for _, surface in ipairs(surfaces) do
	minetest.register_abm({
	    nodenames = { surface.name },
	    interval = growdelay,
	    chance = 30,
	    action = function(pos, node, active_object_count, active_object_count_wider)
		local p_top = {
		    x = pos.x,
		    y = pos.y + 1,
		    z = pos.z
		}
		local n_top = minetest.env:get_node(p_top)
		local rnd = math.random(1, MAX_RATIO)

		if (MAX_RATIO - surface.chance < rnd) then
		    local flower_in_range = is_node_in_cube(grownames, p_top, surface.spacing)
		    if (n_top.name == "air") and (flower_in_range == false) then
			local nnode = grownames[math.random(1, #grownames)]
			dbg('Adding node ' .. nnode .. ' ('
			.. pos.x .. ', '
			.. pos.y .. ', '
			.. pos.z .. ')')
			minetest.env:add_node(p_top, { name = nnode })
		    end
		end
	    end
	})
    end
end


function beer_add_sprite_beer(modname,name,growdelay,surfaces)

	minetest.register_node(modname..':'..name, {
		drawtype = 'plantlike',
		visual_scale = 1.0,
		tile_images = { modname.."_"..name .. '.png' },
		inventory_image = modname.."_"..name .. '.png',
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = false,
		groups = {choppy=2,dig_immediate=2},
		furnace_burntime = 1,
		drop = dropitem[i],
	})

	grow_blocks_on_surfaces(growdelay,{modname..':'..name,},surfaces)
end


-- Nodes
for i, color in ipairs(beer) do
	local fname = 'beer_' .. color

	minetest.register_node('beer:' .. fname, {
	    description = beer_DESCRIPTION[i],
	    drawtype = 'plantlike',
	    visual_scale = 1.0,
	    tile_images = { fname .. '.png' },
	    inventory_image = fname .. '.png',
	    sunlight_propagates = true,
	    paramtype = 'light',
	    walkable = false,
	    groups = {choppy=2,dig_immediate=2},
	    furnace_burntime = 1,
	    drop = dropitem[i],
	})
end
-- Make it grow !
grow_blocks_on_surfaces(GROWING_DELAY * 30, {
	"beer:beer_dandelion_yellow",
	}, {
	{name = "default:dirt_with_grass", chance = 30, spacing = 15},
})
grow_blocks_on_surfaces(GROWING_DELAY * 10, {
	"beer:beer_hops",
	"beer:beer_grape",
	"beer:beer_grape_white",
	"beer:beer_bush",
	}, {
	{name = "default:dirt_with_grass", chance = 10, spacing = 10},
})

minetest.register_craftitem("beer:bucket_empty", {
	description = "Empty Beer Bucket",
	image = "beer_bucket_empty.png",
	stack_max = 1,
	liquids_pointable = true,
	on_place = minetest.item_place,
	on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "default:water_source" then
				minetest.env:add_node(pointed_thing.under, {name="air"})
				local leftover = player:get_inventory():add_item("main", ItemStack('beer:bucket_water 1'))
				if leftover:is_empty() then
					item:take_item()
				else
					minetest.chat_send_player(player:get_player_name(), 'Not enough space in inventory!')
				end
			end
		end
		return item
	end,
})

minetest.register_craftitem("beer:bucket_water", {
	description = "beer bucket",
	image = "beer_bucket_full.png",
	stack_max = 1,
	liquids_pointable = true,
	on_place = minetest.item_place,
	on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "default:water_source" then
				-- unchanged
			elseif n.name == "default:lava_source" or n.name == "default:lava_flowing" then
				minetest.env:add_node(pointed_thing.under, {name="default:cobble"})
			else
				minetest.env:add_node(pointed_thing.above, {name="default:water_flowing"})
			end
			local leftover = player:get_inventory():add_item("main", ItemStack('beer:bucket_empty 1'))
			if leftover:is_empty() then
				item:take_item()
			else
				minetest.chat_send_player(player:get_player_name(), 'Not enough space in inventory!')
			end
		end
		return item
	end,
})


minetest.register_craftitem("beer:bush_berries", {
	description = "berries",
	inventory_image = "berry.png",
	on_use = minetest.item_eat(-10),
})
minetest.register_craftitem("beer:grape_berries", {
	description = "grapes",
	inventory_image = "grape.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craftitem("beer:grape_white_berries", {
	description = "white grapes",
	inventory_image = "grape_white.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craftitem("beer:beer", {
	description = "Beer",
	inventory_image = "beer.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craftitem("beer:dandelion_wine", {
	description = "Wine",
	inventory_image = "wine.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craftitem("beer:grape_ferme", {
	description = "fermented grapes",
	inventory_image = "beer_bucket_ferm.png",
})
minetest.register_craftitem("beer:moonshine", {
	description = "Moonshine",
	inventory_image = "moonshine.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craftitem("beer:red_wine", {
	description = "Red Wine",
	inventory_image = "red_wine.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craftitem("beer:white_wine", {
	description = "White Wine",
	inventory_image = "white_wine.png",
	on_use = minetest.item_eat(5),
})
minetest.register_craft({
	output = 'beer:beer 24',
	recipe = {
		{'beer:beer_hops'},
		{'beer:bucket_water'},
	}
})
minetest.register_craft({
	output = 'beer:moonshine 10',
	type = 'cooking',
	recipe = 'beer:grape_ferme',
})
minetest.register_craft({
	output = 'beer:dandelion_wine 4',
	recipe = {
		{'beer:beer_dandelion_yellow'},
		{'beer:beer_dandelion_yellow'},
		{'beer:bucket_water'},
	}
})
minetest.register_craft({
	output = 'beer:grape_ferme',
	recipe = {
		{'beer:grape_berries'},
		{'beer:grape_white_berries'},
		{'beer:bucket_water'},
	}
})
minetest.register_craft({
	output = 'beer:bucket_empty 1',
	recipe = {
		{'default:wood', '', 'default:wood'},
		{'', 'default:wood', ''},
	}
})
minetest.register_craft({
	output = 'beer:red_wine 4',
	recipe = {
		{'beer:grape_berries'},
		{'beer:grape_berries'},
		{'beer:bucket_water'},
	}
})
minetest.register_craft({
	output = 'beer:white_wine 4',
	recipe = {
		{'beer:grape_white_berries'},
		{'beer:grape_white_berries'},
		{'beer:bucket_water'},
	}
})

