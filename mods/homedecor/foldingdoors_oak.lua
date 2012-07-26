-- Oak "folding" doors - part of home decor mod by VanessaE
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

minetest.register_node('homedecor:folding_door_oak', {
	description = "Oak Folding Door (Left Opening)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_oak.png' },
	inventory_image = 'homedecor_folding_door_oak.png',
	wield_image = 'homedecor_folding_door_oak.png',
	paramtype2 = "wallmounted",
	selection_box = { type = "wallmounted" },
	groups = { choppy = 2, dig_immediate=2 },
})


local on_oak_folding_door_placed = function( pos, node, placer )
        if node.name ~= 'homedecor:folding_door_oak' then return end

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
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_oak_a_c', param2 = newparam } )
                minetest.env:add_node( upos, { name = 'homedecor:folding_door_oak_b_c', param2 = newparam } )
        elseif abv.name == 'air' then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_oak_b_c', param2 = newparam } )
                minetest.env:add_node( apos, { name = 'homedecor:folding_door_oak_a_c', param2 = newparam } )
        else
                minetest.env:remove_node( pos )
                placer:get_inventory():add_item( "main", 'homedecor:folding_door_oak' )
                minetest.chat_send_player( placer:get_player_name(), 'not enough space' )
        end
end

local on_oak_folding_door_punched = function( pos, node, puncher )
        if string.find( node.name, 'homedecor:folding_door_oak' ) == nil then return end

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

        if ( node.name == 'homedecor:folding_door_oak_a_c' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_oak_a_o', param2 = newparam } )
                minetest.env:add_node( upos, { name = 'homedecor:folding_door_oak_b_o', param2 = newparam } )

        elseif ( node.name == 'homedecor:folding_door_oak_b_c' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_oak_b_o', param2 = newparam } )
                minetest.env:add_node( apos, { name = 'homedecor:folding_door_oak_a_o', param2 = newparam } )

        elseif ( node.name == 'homedecor:folding_door_oak_a_o' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_oak_a_c', param2 = newparam } )
                minetest.env:add_node( upos, { name = 'homedecor:folding_door_oak_b_c', param2 = newparam } )

        elseif ( node.name == 'homedecor:folding_door_oak_b_o' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_oak_b_c', param2 = newparam } )
                minetest.env:add_node( apos, { name = 'homedecor:folding_door_oak_a_c', param2 = newparam } )

        end
end

local on_oak_folding_door_digged = function( pos, node, digger )
        upos = { x = pos.x, y = pos.y - 1, z = pos.z }
        apos = { x = pos.x, y = pos.y + 1, z = pos.z }

        if ( node.name == 'homedecor:folding_door_oak_a_c' ) or ( node.name == 'homedecor:folding_door_oak_a_o' ) then
                minetest.env:remove_node( upos )
        elseif ( node.name == 'homedecor:folding_door_oak_b_c' ) or ( node.name == 'homedecor:folding_door_oak_b_o' ) then
                minetest.env:remove_node( apos )
        end
end

minetest.register_on_placenode( on_oak_folding_door_placed )
minetest.register_on_punchnode( on_oak_folding_door_punched )
minetest.register_on_dignode( on_oak_folding_door_digged )


-- Nodes to build up oak folding doors

minetest.register_node('homedecor:folding_door_oak_a_c', {
	description = "Oak Folding Door (top, closed)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_oak_a.png' },
	inventory_image = 'homedecor_folding_door_oak_a.png',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = true,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted" },
	drop = 'homedecor:folding_door_oak',
})

minetest.register_node('homedecor:folding_door_oak_b_c', {
	description = "Oak Folding Door (bottom, closed)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_oak_b.png' },
	inventory_image = 'homedecor_folding_door_oak_b.png',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = true,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted" },
	drop = 'homedecor:folding_door_oak',
})

minetest.register_node('homedecor:folding_door_oak_a_o', {
	description = "Oak Folding Door (top, open)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_oak_a_r.png' },
	inventory_image = 'homedecor_folding_door_oak_a_r.png',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted", },
	drop = 'homedecor:folding_door_oak',
})

minetest.register_node('homedecor:folding_door_oak_b_o', {
	description = "Oak Folding Door (bottom, open)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_oak_b_r.png' },
	inventory_image = 'homedecor_folding_door_oak_b_r.png',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted", },
	drop = 'homedecor:folding_door_oak',
})


-- ========================================
-- Mirrored version for right-opening doors
-- ========================================

-- Actual nodes that you place

minetest.register_node('homedecor:folding_door_oak_right', {
	description = "Oak Folding Door (Right Opening)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_oak_right.png' },
	inventory_image = 'homedecor_folding_door_oak_right.png',
	wield_image = 'homedecor_folding_door_oak_right.png',
	paramtype2 = "wallmounted",
	selection_box = { type = "wallmounted" },
	groups = { choppy = 2, dig_immediate=2 },
})

local on_oak_folding_door_placed_right = function( pos, node, placer )
        if node.name ~= 'homedecor:folding_door_oak_right' then return end

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
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_oak_a_c_right', param2 = newparam } )
                minetest.env:add_node( upos, { name = 'homedecor:folding_door_oak_b_c_right', param2 = newparam } )
        elseif abv.name == 'air' then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_oak_b_c_right', param2 = newparam } )
                minetest.env:add_node( apos, { name = 'homedecor:folding_door_oak_a_c_right', param2 = newparam } )
        else
                minetest.env:remove_node( pos )
                placer:get_inventory():add_item( "main", 'homedecor:folding_door_oak_right' )
                minetest.chat_send_player( placer:get_player_name(), 'not enough space' )
        end
end

local on_oak_folding_door_punched_right = function( pos, node, puncher )

        if string.find( node.name, 'homedecor:folding_door_oak' ) == nil then return end

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

        if ( node.name == 'homedecor:folding_door_oak_a_c_right' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_oak_a_o_right', param2 = newparam } )
                minetest.env:add_node( upos, { name = 'homedecor:folding_door_oak_b_o_right', param2 = newparam } )

        elseif ( node.name == 'homedecor:folding_door_oak_b_c_right' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_oak_b_o_right', param2 = newparam } )
                minetest.env:add_node( apos, { name = 'homedecor:folding_door_oak_a_o_right', param2 = newparam } )

        elseif ( node.name == 'homedecor:folding_door_oak_a_o_right' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_oak_a_c_right', param2 = newparam } )
                minetest.env:add_node( upos, { name = 'homedecor:folding_door_oak_b_c_right', param2 = newparam } )

        elseif ( node.name == 'homedecor:folding_door_oak_b_o_right' ) then
                minetest.env:add_node( pos,  { name = 'homedecor:folding_door_oak_b_c_right', param2 = newparam } )
                minetest.env:add_node( apos, { name = 'homedecor:folding_door_oak_a_c_right', param2 = newparam } )

        end
end

local on_oak_folding_door_digged_right = function( pos, node, digger )
        upos = { x = pos.x, y = pos.y - 1, z = pos.z }
        apos = { x = pos.x, y = pos.y + 1, z = pos.z }

        if ( node.name == 'homedecor:folding_door_oak_a_c_right' ) or ( node.name == 'homedecor:folding_door_oak_a_o_right' ) then
                minetest.env:remove_node( upos )
        elseif ( node.name == 'homedecor:folding_door_oak_b_c_right' ) or ( node.name == 'homedecor:folding_door_oak_b_o_right' ) then
                minetest.env:remove_node( apos )
        end
end

minetest.register_on_placenode( on_oak_folding_door_placed_right )
minetest.register_on_punchnode( on_oak_folding_door_punched_right )
minetest.register_on_dignode( on_oak_folding_door_digged_right )


-- Nodes to build up oak folding doors

minetest.register_node('homedecor:folding_door_oak_a_c_right', {
	description = "Oak Folding Door (top, closed, right)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_oak_a_r.png' },
	inventory_image = 'homedecor_folding_door_oak_a_r.png',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = true,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted" },
	drop = 'homedecor:folding_door_oak_right',
})

minetest.register_node('homedecor:folding_door_oak_b_c_right', {
	description = "Oak Folding Door (bottom, closed, right)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_oak_b_r.png' },
	inventory_image = 'homedecor_folding_door_oak_b_r.png',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = true,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted" },
	drop = 'homedecor:folding_door_oak_right',
})

minetest.register_node('homedecor:folding_door_oak_a_o_right', {
	description = "Oak Folding Door (top, open, right)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_oak_a.png' },
	inventory_image = 'homedecor_folding_door_oak_a.png',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted", },
	drop = 'homedecor:folding_door_oak_right',
})

minetest.register_node('homedecor:folding_door_oak_b_o_right', {
	description = "Oak Folding Door (bottom, open, right)",
	drawtype = 'signlike',
	tiles = { 'homedecor_folding_door_oak_b.png' },
	inventory_image = 'homedecor_folding_door_oak_b.png',
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	groups = { choppy = 2, dig_immediate=2 },
	selection_box = { type = "wallmounted", },
	drop = 'homedecor:folding_door_oak_right',
})



-- =======================================
-- Crafting recipes for all types of doors
-- =======================================


minetest.register_craft( {
        output = 'homedecor:folding_door_oak',
        recipe = {
                { 'default:stick', 'default:stick', '' },
                { 'default:stick', 'default:stick', 'default:steel_ingot' },
                { 'default:stick', 'default:stick', '' },
        },
})

minetest.register_craft( {
	type = 'shapeless',
        output = 'homedecor:folding_door_oak_right',
        recipe = {
		'homedecor:folding_door_oak',
        },
})

minetest.register_craft( {
	type = 'shapeless',
        output = 'homedecor:folding_door_oak',
        recipe = {
		'homedecor:folding_door_oak_right',
        },
})

minetest.register_craft({
        type = 'fuel',
        recipe = 'homedecor:folding_door_oak',
        burntime = 30,
})

minetest.register_craft({
        type = 'fuel',
        recipe = 'homedecor:folding_door_oak_right',
        burntime = 30,
})
