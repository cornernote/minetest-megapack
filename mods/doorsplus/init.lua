--[[
****
Doors+
by Calinou
Version 12.06.18
****
--]]

--------------------------------------------------------------------------------

local WALLMX = 3
local WALLMZ = 5
local WALLPX = 2
local WALLPZ = 4

--------------------------------------------------------------------------------

minetest.register_alias('door', 'doorsplus:door_wood_right')
minetest.register_alias('door_wood', 'doorsplus:door_wood_right')
minetest.register_alias('door_right', 'doorsplus:door_wood_right')
minetest.register_alias('door_left', 'doorsplus:door_wood_left')
minetest.register_alias('door_wood_right', 'doorsplus:door_wood_right')
minetest.register_alias('door_wood_left', 'doorsplus:door_wood_left')

minetest.register_node( 'doorsplus:door_wood_right', {
	description         = 'Right-handed Wooden Door',
	drawtype            = 'signlike',
	tiles         = { 'door_wood.png' },
	inventory_image     = 'door_wood.png',
	wield_image         = 'door_wood.png',
	paramtype2          = 'wallmounted',
	selection_box       = { type = 'wallmounted' },
	groups              = { choppy=2, dig_immediate=2 },
})

minetest.register_node( 'doorsplus:door_wood', {
	description         = 'Right-handed Wooden Door',
	drawtype            = 'signlike',
	tiles         = { 'door_wood.png' },
	inventory_image     = 'door_wood.png',
	wield_image         = 'door_wood.png',
	paramtype2          = 'wallmounted',
	selection_box       = { type = 'wallmounted' },
	groups              = { choppy=2, dig_immediate=2 },
})

minetest.register_node( 'doorsplus:door_wood_left', {
	description         = 'Left-handed Wooden Woor',
	drawtype            = 'signlike',
	tiles         = { 'door_wood.png' },
	inventory_image     = 'door_wood.png',
	wield_image         = 'door_wood.png',
	paramtype2          = 'wallmounted',
	selection_box       = { type = 'wallmounted' },
	groups              = { choppy=2, dig_immediate=2 },
})

minetest.register_craft( {
	output              = 'doorsplus:door_wood_right',
	recipe = {
		{ 'default:wood', 'default:wood', '' },
		{ 'default:wood', 'default:wood', '' },
		{ 'default:wood', 'default:wood', '' },
	},
})

minetest.register_craft( {
	output              = 'doorsplus:door_wood_left',
	recipe = {
		{ 'doorsplus:door_wood_right' },
	},
})

minetest.register_craft( {
	output              = 'doorsplus:door_wood_right',
	recipe = {
		{ 'doorsplus:door_wood_left' },
	},
})

minetest.register_craft({
	type = 'fuel',
	recipe = 'doorsplus:door_wood_right',
	burntime = 30,
})

minetest.register_craft({
	type = 'fuel',
	recipe = 'doorsplus:door_wood',
	burntime = 30,
})

minetest.register_craft({
	type = 'fuel',
	recipe = 'doorsplus:door_wood_left',
	burntime = 30,
})

minetest.register_node( 'doorsplus:door_wood_right_a_c', {
	Description         = 'Right-handed Top Closed Door',
	drawtype            = 'signlike',
	tiles         = { 'door_wood_a.png' },
	inventory_image     = 'door_wood_a.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = true,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	drop                = 'doorsplus:door_wood_right',
})

minetest.register_node( 'doorsplus:door_wood_right_b_c', {
	Description         = 'Right-handed Bottom Closed Door',
	drawtype            = 'signlike',
	tiles         = { 'door_wood_b.png' },
	inventory_image     = 'door_wood_b.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = true,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	drop                = 'doorsplus:door_wood_right',
})

minetest.register_node( 'doorsplus:door_wood_right_a_o', {
	Description         = 'Right-handed Top Open Door',
	drawtype            = 'signlike',
	tiles         = { 'door_wood_a_r.png' },
	inventory_image     = 'door_wood_a_r.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = false,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	drop                = 'doorsplus:door_wood_right',
})

minetest.register_node( 'doorsplus:door_wood_right_b_o', {
	Description         = 'Right-handed Bottom Open Door',
	drawtype            = 'signlike',
	tiles         = { 'door_wood_b_r.png' },
	inventory_image     = 'door_wood_b_r.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = false,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	drop                = 'doorsplus:door_wood_right',
})

minetest.register_node( 'doorsplus:door_wood_left_a_c', {
	Description         = 'Left-handed Top Closed Door',
	drawtype            = 'signlike',
	tiles         = { 'door_wood_a_r.png' },
	inventory_image     = 'door_wood_a_r.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = true,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	drop                = 'doorsplus:door_wood_left',
})

minetest.register_node( 'doorsplus:door_wood_left_b_c', {
	Description         = 'Left-handed Bottom Closed Door',
	drawtype            = 'signlike',
	tiles         = { 'door_wood_b_r.png' },
	inventory_image     = 'door_wood_b_r.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = true,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	drop                = 'doorsplus:door_wood_left',
})

minetest.register_node( 'doorsplus:door_wood_left_a_o', {
	Description         = 'Left-handed Top Open Door',
	drawtype            = 'signlike',
	tiles         = { 'door_wood_a.png' },
	inventory_image     = 'door_wood_a.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = false,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	drop                = 'doorsplus:door_wood_left',
})

minetest.register_node( 'doorsplus:door_wood_left_b_o', {
	Description         = 'Left-handed Bottom Open Door',
	drawtype            = 'signlike',
	tiles         = { 'door_wood_b.png' },
	inventory_image     = 'door_wood_b.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = false,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	drop                = 'doorsplus:door_wood_left',
})

minetest.register_node( 'doorsplus:door_wood_a_c', {
	Description         = 'Right-handed Top Closed Door',
	drawtype            = 'signlike',
	tiles         = { 'door_wood_a.png' },
	inventory_image     = 'door_wood_a.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = true,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	drop                = 'doorsplus:door_wood_right',
})

minetest.register_node( 'doorsplus:door_wood_b_c', {
	Description         = 'Right-handed Bottom Closed Door',
	drawtype            = 'signlike',
	tiles         = { 'door_wood_b.png' },
	inventory_image     = 'door_wood_b.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = true,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	drop                = 'doorsplus:door_wood_right',
})

minetest.register_node( 'doorsplus:door_wood_a_o', {
	Description         = 'Right-handed Top Open Door',
	drawtype            = 'signlike',
	tiles         = { 'door_wood_a_r.png' },
	inventory_image     = 'door_wood_a_r.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = false,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	drop                = 'doorsplus:door_wood_right',
})

minetest.register_node( 'doorsplus:door_wood_b_o', {
	Description         = 'Right-handed Bottom Open Door',
	drawtype            = 'signlike',
	tiles         = { 'door_wood_b_r.png' },
	inventory_image     = 'door_wood_b_r.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = false,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	drop                = 'doorsplus:door_wood_right',
})

--------------------------------------------------------------------------------

local round = function( n )
	if n >= 0 then
		return math.floor( n + 0.5 )
	else
		return math.ceil( n - 0.5 )
	end
end

local on_door_right_placed = function( pos, node, placer )
	if node.name ~= 'doorsplus:door_wood_right' then return end

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
		minetest.env:add_node( pos,  { name = 'doorsplus:door_wood_right_a_c', param2 = newparam } )
		minetest.env:add_node( upos, { name = 'doorsplus:door_wood_right_b_c', param2 = newparam } )
	elseif abv.name == 'air' then
		minetest.env:add_node( pos,  { name = 'doorsplus:door_wood_right_b_c', param2 = newparam } )
		minetest.env:add_node( apos, { name = 'doorsplus:door_wood_right_a_c', param2 = newparam } )
	else
		minetest.env:remove_node( pos )
		placer:get_inventory():add_item( "main", 'doorsplus:door_wood_right' )
		minetest.chat_send_player( placer:get_player_name(), 'Not enough space to place the door.' )
	end
end

local on_door_left_placed = function( pos, node, placer )
	if node.name ~= 'doorsplus:door_wood_left' then return end

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
		minetest.env:add_node( pos,  { name = 'doorsplus:door_wood_left_a_c', param2 = newparam } )
		minetest.env:add_node( upos, { name = 'doorsplus:door_wood_left_b_c', param2 = newparam } )
	elseif abv.name == 'air' then
		minetest.env:add_node( pos,  { name = 'doorsplus:door_wood_left_b_c', param2 = newparam } )
		minetest.env:add_node( apos, { name = 'doorsplus:door_wood_left_a_c', param2 = newparam } )
	else
		minetest.env:remove_node( pos )
		placer:get_inventory():add_item( "main", 'doorsplus:door_wood_left' )
		minetest.chat_send_player( placer:get_player_name(), 'Not enough space to place the door.' )
	end
end

local on_door_right_punched = function( pos, node, puncher )
	if string.find( node.name, 'doorsplus:door_wood_right' ) == nil then return end

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

	if ( node.name == 'doorsplus:door_wood_right_a_c' ) then
		minetest.env:add_node( pos,  { name = 'doorsplus:door_wood_right_a_o', param2 = newparam } )
		minetest.env:add_node( upos, { name = 'doorsplus:door_wood_right_b_o', param2 = newparam } )

	elseif ( node.name == 'doorsplus:door_wood_right_b_c' ) then
		minetest.env:add_node( pos,  { name = 'doorsplus:door_wood_right_b_o', param2 = newparam } )
		minetest.env:add_node( apos, { name = 'doorsplus:door_wood_right_a_o', param2 = newparam } )

	elseif ( node.name == 'doorsplus:door_wood_right_a_o' ) then
		minetest.env:add_node( pos,  { name = 'doorsplus:door_wood_right_a_c', param2 = newparam } )
		minetest.env:add_node( upos, { name = 'doorsplus:door_wood_right_b_c', param2 = newparam } )

	elseif ( node.name == 'doorsplus:door_wood_right_b_o' ) then
		minetest.env:add_node( pos,  { name = 'doorsplus:door_wood_right_b_c', param2 = newparam } )
		minetest.env:add_node( apos, { name = 'doorsplus:door_wood_right_a_c', param2 = newparam } )

	end
end

local on_door_left_punched = function( pos, node, puncher )
	if string.find( node.name, 'doorsplus:door_wood_left' ) == nil then return end

	upos = { x = pos.x, y = pos.y - 1, z = pos.z }
	apos = { x = pos.x, y = pos.y + 1, z = pos.z }

	if string.find( node.name, '_c', -2 ) ~= nil then
		if     node.param2 == WALLPX then
			newparam = WALLPZ
		elseif node.param2 == WALLMZ then
			newparam = WALLPX
		elseif node.param2 == WALLMX then
			newparam = WALLMZ
		elseif node.param2 == WALLPZ then
			newparam = WALLMX
		end
	elseif string.find( node.name, '_o', -2 ) ~= nil then
		if     node.param2 == WALLMZ then
			newparam = WALLMX
		elseif node.param2 == WALLMX then
			newparam = WALLPZ
		elseif node.param2 == WALLPZ then
			newparam = WALLPX
		elseif node.param2 == WALLPX then
			newparam = WALLMZ
		end
	end

	if ( node.name == 'doorsplus:door_wood_left_a_c' ) then
		minetest.env:add_node( pos,  { name = 'doorsplus:door_wood_left_a_o', param2 = newparam } )
		minetest.env:add_node( upos, { name = 'doorsplus:door_wood_left_b_o', param2 = newparam } )

	elseif ( node.name == 'doorsplus:door_wood_left_b_c' ) then
		minetest.env:add_node( pos,  { name = 'doorsplus:door_wood_left_b_o', param2 = newparam } )
		minetest.env:add_node( apos, { name = 'doorsplus:door_wood_left_a_o', param2 = newparam } )

	elseif ( node.name == 'doorsplus:door_wood_left_a_o' ) then
		minetest.env:add_node( pos,  { name = 'doorsplus:door_wood_left_a_c', param2 = newparam } )
		minetest.env:add_node( upos, { name = 'doorsplus:door_wood_left_b_c', param2 = newparam } )

	elseif ( node.name == 'doorsplus:door_wood_left_b_o' ) then
		minetest.env:add_node( pos,  { name = 'doorsplus:door_wood_left_b_c', param2 = newparam } )
		minetest.env:add_node( apos, { name = 'doorsplus:door_wood_left_a_c', param2 = newparam } )

	end
end

local on_door_right_digged = function( pos, node, digger )
	upos = { x = pos.x, y = pos.y - 1, z = pos.z }
	apos = { x = pos.x, y = pos.y + 1, z = pos.z }

	if ( node.name == 'doorsplus:door_wood_right_a_c' ) or ( node.name == 'doorsplus:door_wood_right_a_o' ) then
		minetest.env:remove_node( upos )
	elseif ( node.name == 'doorsplus:door_wood_right_b_c' ) or ( node.name == 'doorsplus:door_wood_right_b_o' ) then
		minetest.env:remove_node( apos )
	end
end

local on_door_left_digged = function( pos, node, digger )
	upos = { x = pos.x, y = pos.y - 1, z = pos.z }
	apos = { x = pos.x, y = pos.y + 1, z = pos.z }

	if ( node.name == 'doorsplus:door_wood_left_a_c' ) or ( node.name == 'doorsplus:door_wood_left_a_o' ) then
		minetest.env:remove_node( upos )
	elseif ( node.name == 'doorsplus:door_wood_left_b_c' ) or ( node.name == 'doorsplus:door_wood_left_b_o' ) then
		minetest.env:remove_node( apos )
	end
end

--------------------------------------------------------------------------------

minetest.register_on_placenode( on_door_right_placed )
minetest.register_on_punchnode( on_door_right_punched )
minetest.register_on_dignode( on_door_right_digged )

minetest.register_on_placenode( on_door_left_placed )
minetest.register_on_punchnode( on_door_left_punched )
minetest.register_on_dignode( on_door_left_digged )

--------------------------------------------------------------------------------

