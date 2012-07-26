dofile(minetest.get_modpath("beds").."/sleeping.lua")
minetest.register_node( 'beds:blue', {
	description         = 'Bed',
	drawtype	    = "chestlike",
	tiles         = {
				'beds_blue_top_above.png',
				'beds_blue_top_above.png',
				'beds_blue_top_top.png',
				'beds_blue_bottom_bottom.png',
				'beds_blue_top_side2.png',
				'beds_blue_top_side.png',
			      },
	groups		    = { choppy = 3, oddly_breakable_by_hand = 1.5}
})

minetest.register_craft( {
	output              = 'beds:blue',
	recipe = {
		{ 'default:wood', 'default:wood', 'default:wood' },
		{ 'default:stick','', 'default:stick' },
	},
})

minetest.register_craft({
	type = 'fuel',
	recipe = 'beds:blue',
	burntime = 45,
})

minetest.register_node( 'beds:blue_top', {
	Description         = '',
	tiles         = {
				'beds_blue_top_above.png',
				'beds_blue_top_above.png',
				'beds_blue_top_top.png',
				'beds_blue_bottom_bottom.png',
				'beds_blue_top_side2.png',
				'beds_blue_top_side.png',
			      },
	paramtype           = 'light',
	walkable            = true,
	groups		    = { choppy = 3, oddly_breakable_by_hand = 1.5},
	drop                = 'beds:blue',
})

minetest.register_node( 'beds:blue_bottom', {
	Description         = '',
	drawtype	    = "chestlike",
	tiles         = {
				'beds_blue_bottom_above.png',
				'beds_blue_bottom_above.png',
				'beds_blue_bottom_bottom.png',
				'beds_blue_bottom_bottom.png',
				'beds_blue_bottom_side2.png',
				'beds_blue_bottom_side.png',
			      },
	paramtype           = 'light',
	walkable            = true,
	groups		    = { choppy = 3, oddly_breakable_by_hand = 1.5},
	drop                = 'beds:blue',
})
--------------------------------------------------------------------------------

local on_door_placed = function( pos, node, placer )
	if node.name ~= 'beds:blue' then return end
	rpos = { x = pos.x - 1, y = pos.y , z = pos.z }
	lpos = { x = pos.x + 1, y = pos.y , z = pos.z }
	right = minetest.env:get_node( rpos )
	left = minetest.env:get_node( lpos )
	dir = placer:get_look_dir()
	if right.name == 'air' then
		minetest.env:add_node( pos,  { name = 'beds:blue_top'} )
		minetest.env:add_node( rpos, { name = 'beds:blue_bottom'} )
	elseif left.name == 'air' then
		minetest.env:add_node( pos,  { name = 'beds:blue_bottom'} )
		minetest.env:add_node( lpos, { name = 'beds:blue_top'} )
	else
		minetest.env:remove_node( pos )
		placer:get_inventory():add_item( "main", 'beds:blue' )
		minetest.chat_send_player( placer:get_player_name(), 'not enough space' )
	end
end

local on_door_digged = function( pos, node, digger )
	rpos = { x = pos.x - 1, y = pos.y , z = pos.z }
	lpos = { x = pos.x + 1, y = pos.y , z = pos.z }

	if ( node.name == 'beds:blue_top' ) then
		minetest.env:remove_node( rpos )
	elseif ( node.name == 'beds:blue_bottom' ) then
		minetest.env:remove_node( lpos )
	end
end

minetest.register_on_placenode( on_door_placed )
minetest.register_on_punchnode( on_door_punched )
minetest.register_on_dignode( on_door_digged )

