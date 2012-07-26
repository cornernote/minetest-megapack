-- Mahogany "folding" doors - part of home decor mod by VanessaE
-- 2012-06-10
--
-- Copied and modified from Minetest's default doors mod.  
--
-- License: GPL
--

local DEBUG = 1

local WALLMX = 3
local WALLMZ = 5
local WALLPX = 2
local WALLPZ = 4

local WALLMXr = 2
local WALLMZr = 4
local WALLPXr = 3
local WALLPZr = 5

local dbg = function(s)
	if DEBUG == 1 then
		print('[FOLDINGDOORS] ' .. s)
	end
end

local round = function( n )
        if n >= 0 then
                return math.floor( n + 0.5 )
        else
                return math.ceil( n - 0.5 )
        end
end

-- ==========================
-- Regular left-opening doors

-- Actual nodes that you place

minetest.register_node('homedecor:folding_door_mahogany', {
	description = "Mahogany Folding Door (Left Opening)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_mahogany.png' },
	inventory_image = 'homedecor_folding_door_mahogany.png',
	wield_image = 'homedecor_folding_door_mahogany.png',
	paramtype2 = "wallmounted",
	selection_box = { type = "wallmounted" },
	groups = { choppy = 2, dig_immediate=2 },
})

-- Mahogany door functions

local on_mahogany_folding_door_placed = function( pos, node, placer )
        if node.name ~= 'homedecor:folding_door_mahogany' then return end

        upos = { x = pos.x, y = pos.y - 1, z = pos.z }
        apos = { x = pos.x, y = pos.y + 1, z = pos.z }
        und = minetest.env:get_node( upos )
        abv = minetest.env:get_node( apos )

        dir = placer:get_look_dir()

        if     round( dir.x ) == 1  then
                newparam = WALLMX
        elseif round( dir.x ) == -1 then
                newparam = WALLPX
        elseif round( dir.z ) == 1  then
                newparam = WALLMZ
        elseif round( dir.z ) == -1 then
                newparam = WALLPZ
        end

        if und.name == 'air' then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_mahogany_a_c', param2 = newparam } )
                minetest.env:add_node( upos, { name = 'homedecor:folding_door_mahogany_b_c', param2 = newparam } )
        elseif abv.name == 'air' then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_mahogany_b_c', param2 = newparam } )
                minetest.env:add_node( apos, { name = 'homedecor:folding_door_mahogany_a_c', param2 = newparam } )
        else
                minetest.env:remove_node( pos )
                placer:get_inventory():add_item( "main", 'homedecor:folding_door_mahogany' )
                minetest.chat_send_player( placer:get_player_name(), 'not enough space' )
        end
end

local on_mahogany_folding_door_punched = function( pos, node, puncher )
        if string.find( node.name, 'homedecor:folding_door_mahogany' ) == nil then return end

        upos = { x = pos.x, y = pos.y - 1, z = pos.z }
        apos = { x = pos.x, y = pos.y + 1, z = pos.z }

        if string.find( node.name, '_c', -2 ) ~= nil then
                if     node.param2 == WALLPX then
                        newparam = WALLMZ
                elseif node.param2 == WALLMZ then
                        newparam = WALLMX
                elseif node.param2 == WALLMX then
                        newparam = WALLPZ
                elseif node.param2 == WALLPZ then
                        newparam = WALLPX
                end
        elseif string.find( node.name, '_o', -2 ) ~= nil then
                if     node.param2 == WALLMZ then
                        newparam = WALLPX
                elseif node.param2 == WALLMX then
                        newparam = WALLMZ
                elseif node.param2 == WALLPZ then
                        newparam = WALLMX
                elseif node.param2 == WALLPX then
                        newparam = WALLPZ
                end
        end

        if ( node.name == 'homedecor:folding_door_mahogany_a_c' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_mahogany_a_o', param2 = newparam } )
                minetest.env:add_node( upos, { name = 'homedecor:folding_door_mahogany_b_o', param2 = newparam } )

        elseif ( node.name == 'homedecor:folding_door_mahogany_b_c' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_mahogany_b_o', param2 = newparam } )
                minetest.env:add_node( apos, { name = 'homedecor:folding_door_mahogany_a_o', param2 = newparam } )

        elseif ( node.name == 'homedecor:folding_door_mahogany_a_o' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_mahogany_a_c', param2 = newparam } )
                minetest.env:add_node( upos, { name = 'homedecor:folding_door_mahogany_b_c', param2 = newparam } )

        elseif ( node.name == 'homedecor:folding_door_mahogany_b_o' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_mahogany_b_c', param2 = newparam } )
                minetest.env:add_node( apos, { name = 'homedecor:folding_door_mahogany_a_c', param2 = newparam } )

        end
end

local on_mahogany_folding_door_digged = function( pos, node, digger )
        upos = { x = pos.x, y = pos.y - 1, z = pos.z }
        apos = { x = pos.x, y = pos.y + 1, z = pos.z }

        if ( node.name == 'homedecor:folding_door_mahogany_a_c' ) or ( node.name == 'homedecor:folding_door_mahogany_a_o' ) then
                minetest.env:remove_node( upos )
        elseif ( node.name == 'homedecor:folding_door_mahogany_b_c' ) or ( node.name == 'homedecor:folding_door_mahogany_b_o' ) then
                minetest.env:remove_node( apos )
        end
end

minetest.register_on_placenode( on_mahogany_folding_door_placed )
minetest.register_on_punchnode( on_mahogany_folding_door_punched )
minetest.register_on_dignode( on_mahogany_folding_door_digged )


-- Nodes used to build up mahogany doors

minetest.register_node('homedecor:folding_door_mahogany_a_c', {
	description = "Mahogany Folding Door (top, closed)",
	tiles = { 'homedecor_folding_door_mahogany_a.png' },
	inventory_image = 'homedecor_folding_door_mahogany_a.png',
	drawtype = 'signlike',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = true,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted" },
	drop = 'homedecor:folding_door_mahogany',
})

minetest.register_node('homedecor:folding_door_mahogany_b_c', {
	description = "Mahogany Folding Door (bottom, closed)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_mahogany_b.png' },
	inventory_image = 'homedecor_folding_door_mahogany_b.png',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = true,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted" },
	drop = 'homedecor:folding_door_mahogany',
})

minetest.register_node('homedecor:folding_door_mahogany_a_o', {
	description = "Mahogany Folding Door (top, open)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_mahogany_a_r.png' },
	inventory_image = 'homedecor_folding_door_mahogany_a_r.png',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted", },
	drop = 'homedecor:folding_door_mahogany',
})

minetest.register_node('homedecor:folding_door_mahogany_b_o', {
	description = "Mahogany Folding Door (bottom, open)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_mahogany_b_r.png' },
	inventory_image = 'homedecor_folding_door_mahogany_b_r.png',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = 'wallmounted',
	walkable = false,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted", },
	drop = 'homedecor:folding_door_mahogany',
})


-- ========================================
-- Mirrored version for right-opening doors
-- ========================================

-- Actual nodes that you place

minetest.register_node('homedecor:folding_door_mahogany_right', {
	description = "Mahogany Folding Door (Right Opening)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_mahogany_right.png' },
	inventory_image = 'homedecor_folding_door_mahogany_right.png',
	wield_image = 'homedecor_folding_door_mahogany_right.png',
	paramtype2 = "wallmounted",
	selection_box = { type = "wallmounted" },
	groups = { choppy = 2, dig_immediate=2 },
})


-- Mahogany door functions

local on_mahogany_folding_door_placed_right = function( pos, node, placer )
        if node.name ~= 'homedecor:folding_door_mahogany_right' then return end

        upos = { x = pos.x, y = pos.y - 1, z = pos.z }
        apos = { x = pos.x, y = pos.y + 1, z = pos.z }
        und = minetest.env:get_node( upos )
        abv = minetest.env:get_node( apos )

        dir = placer:get_look_dir()

        if     round( dir.x ) == 1  then
                newparam = WALLMX
        elseif round( dir.x ) == -1 then
                newparam = WALLPX
        elseif round( dir.z ) == 1  then
                newparam = WALLMZ
        elseif round( dir.z ) == -1 then
                newparam = WALLPZ
        end

        if und.name == 'air' then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_mahogany_a_c_right', param2 = newparam } )
                minetest.env:add_node( upos, { name = 'homedecor:folding_door_mahogany_b_c_right', param2 = newparam } )
        elseif abv.name == 'air' then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_mahogany_b_c_right', param2 = newparam } )
                minetest.env:add_node( apos, { name = 'homedecor:folding_door_mahogany_a_c_right', param2 = newparam } )
        else
                minetest.env:remove_node( pos )
                placer:get_inventory():add_item( "main", 'homedecor:folding_door_mahogany_right' )
                minetest.chat_send_player( placer:get_player_name(), 'not enough space' )
        end
end

local on_mahogany_folding_door_punched_right = function( pos, node, puncher )

        if string.find( node.name, 'homedecor:folding_door_mahogany' ) == nil then return end

        upos = { x = pos.x, y = pos.y - 1, z = pos.z }
        apos = { x = pos.x, y = pos.y + 1, z = pos.z }

        if string.find( node.name, '_c_right', -8 ) ~= nil then
                if     node.param2 == WALLPX then
                        newparam = WALLMZr
                elseif node.param2 == WALLMZ then
                        newparam = WALLMXr
                elseif node.param2 == WALLMX then
                        newparam = WALLPZr
                elseif node.param2 == WALLPZ then
                        newparam = WALLPXr
                end
        elseif string.find( node.name, '_o_right', -8 ) ~= nil then
                if     node.param2 == WALLMZ then
                        newparam = WALLPXr
                elseif node.param2 == WALLMX then
                        newparam = WALLMZr
                elseif node.param2 == WALLPZ then
                        newparam = WALLMXr
                elseif node.param2 == WALLPX then
                        newparam = WALLPZr
                end
        end

        if ( node.name == 'homedecor:folding_door_mahogany_a_c_right' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_mahogany_a_o_right', param2 = newparam } )
                minetest.env:add_node( upos, { name = 'homedecor:folding_door_mahogany_b_o_right', param2 = newparam } )

        elseif ( node.name == 'homedecor:folding_door_mahogany_b_c_right' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_mahogany_b_o_right', param2 = newparam } )
                minetest.env:add_node( apos, { name = 'homedecor:folding_door_mahogany_a_o_right', param2 = newparam } )

        elseif ( node.name == 'homedecor:folding_door_mahogany_a_o_right' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_mahogany_a_c_right', param2 = newparam } )
                minetest.env:add_node( upos, { name = 'homedecor:folding_door_mahogany_b_c_right', param2 = newparam } )

        elseif ( node.name == 'homedecor:folding_door_mahogany_b_o_right' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_mahogany_b_c_right', param2 = newparam } )
                minetest.env:add_node( apos, { name = 'homedecor:folding_door_mahogany_a_c_right', param2 = newparam } )

        end
end

local on_mahogany_folding_door_digged_right = function( pos, node, digger )
        upos = { x = pos.x, y = pos.y - 1, z = pos.z }
        apos = { x = pos.x, y = pos.y + 1, z = pos.z }

        if ( node.name == 'homedecor:folding_door_mahogany_a_c_right' ) or ( node.name == 'homedecor:folding_door_mahogany_a_o_right' ) then
                minetest.env:remove_node( upos )
        elseif ( node.name == 'homedecor:folding_door_mahogany_b_c_right' ) or ( node.name == 'homedecor:folding_door_mahogany_b_o_right' ) then
                minetest.env:remove_node( apos )
        end
end

minetest.register_on_placenode( on_mahogany_folding_door_placed_right )
minetest.register_on_punchnode( on_mahogany_folding_door_punched_right )
minetest.register_on_dignode( on_mahogany_folding_door_digged_right )


-- Nodes used to build up mahogany doors

minetest.register_node('homedecor:folding_door_mahogany_a_c_right', {
	description = "Mahogany Folding Door (top, closed, right)",
	tiles = { 'homedecor_folding_door_mahogany_a_r.png' },
	inventory_image = 'homedecor_folding_door_mahogany_a_r.png',
	drawtype = 'signlike',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = true,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted" },
	drop = 'homedecor:folding_door_mahogany_right',
})

minetest.register_node('homedecor:folding_door_mahogany_b_c_right', {
	description = "Mahogany Folding Door (bottom, closed, right)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_mahogany_b_r.png' },
	inventory_image = 'homedecor_folding_door_mahogany_b_r.png',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = true,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted" },
	drop = 'homedecor:folding_door_mahogany_right',
})

minetest.register_node('homedecor:folding_door_mahogany_a_o_right', {
	description = "Mahogany Folding Door (top, open, right)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_mahogany_a.png' },
	inventory_image = 'homedecor_folding_door_mahogany_a.png',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted", },
	drop = 'homedecor:folding_door_mahogany_right',
})

minetest.register_node('homedecor:folding_door_mahogany_b_o_right', {
	description = "Mahogany Folding Door (bottom, open, right)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_mahogany_b.png' },
	inventory_image = 'homedecor_folding_door_mahogany_b.png',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = 'wallmounted',
	walkable = false,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted", },
	drop = 'homedecor:folding_door_mahogany_right',
})


-- =======================================
-- Crafting recipes for all types of doors
-- =======================================

minetest.register_craft( {
	type = 'shapeless',
        output = 'homedecor:folding_door_mahogany_right',
        recipe = {
		'homedecor:folding_door_mahogany',
        },
})

minetest.register_craft({
	type = 'shapeless',
	output = 'homedecor:folding_door_mahogany',
	recipe = {
		'homedecor:folding_door_mahogany_right',
	},
})

minetest.register_craft({
	type = 'fuel',
	recipe = 'homedecor:folding_door_mahogany',
	burntime = 30,
})

minetest.register_craft({
	type = 'fuel',
	recipe = 'homedecor:folding_door_mahogany_right',
        burntime = 30,
})


-- You only need flowers to get the red dye necessary to actually
-- craft a mahogany door (either one), but not to /give or use one.

if ( minetest.get_modpath("flowers") ) ~= nil then

        minetest.register_craft( {
                type = 'shapeless',
                output = 'homedecor:folding_door_mahogany',
                recipe = {
                        'homedecor:folding_door_oak',
                        'unifieddyes:black',
                        'unifieddyes:red',
                },
        })

        minetest.register_craft( {
                type = 'shapeless',
                output = 'homedecor:folding_door_mahogany_right',
                recipe = {
                        'homedecor:folding_door_oak_right',
                        'unifieddyes:black',
                        'unifieddyes:red',
                },
        })

end
