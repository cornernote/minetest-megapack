
local WALLMX = 3
local WALLMZ = 5
local WALLPX = 2
local WALLPZ = 4

local round = function( n )
	if n >= 0 then
		return math.floor( n + 0.5 )
	else
		return math.ceil( n - 0.5 )
	end
end

minetest.register_alias('stickdoor', 'riventest:door1')
minetest.register_alias('uldoor', 'riventest:door2')
minetest.register_alias('kldoor', 'riventest:door3')

-- ***********************************************************************************
--														**************************************************
--				PLAIN 'STICK' DOOR				**************************************************
--														**************************************************
-- ***********************************************************************************

minetest.register_node( 'riventest:door1', {
	description         = 'Plain Stick Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor.png' },
	inventory_image     = 'rivendoor.png',
	wield_image         = 'rivendoor.png',
	paramtype2          = 'wallmounted',
	selection_box       = { type = 'wallmounted' },
	groups              = { choppy=2, dig_immediate=2 },
})
minetest.register_node( 'riventest:door1_a_c', {
	Description         = 'Top Closed Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor_a.png' },
	inventory_image     = 'rivendoor_a.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = true,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	legacy_wallmounted  = true,
	drop                = 'riventest:door1',
})

minetest.register_node( 'riventest:door1_b_c', {
	Description         = 'Bottom Closed Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor_b.png' },
	inventory_image     = 'rivendoor_b.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = true,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	legacy_wallmounted  = true,
	drop                = 'riventest:door1',
})

minetest.register_node( 'riventest:door1_a_o', {
	Description         = 'Top Open Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor_a_r.png' },
	inventory_image     = 'rivendoor_a_r.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = false,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	legacy_wallmounted  = true,
	drop                = 'riventest:door1',
})

minetest.register_node( 'riventest:door1_b_o', {
	Description         = 'Bottom Open Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor_b_r.png' },
	inventory_image     = 'rivendoor_b_r.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = false,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	legacy_wallmounted  = true,
	drop                = 'riventest:door1',
})

local on_door1_placed = function( pos, node, placer )
	if node.name ~= 'riventest:door1' then return end

	upos = { x = pos.x, y = pos.y - 1, z = pos.z }
	apos = { x = pos.x, y = pos.y + 1, z = pos.z }
	und = minetest.env:get_node( upos )
	abv = minetest.env:get_node( apos )

	dir = placer:get_look_dir()

	if round( dir.x ) == 1  then
		newparam = WALLMX
	elseif round( dir.x ) == -1 then
		newparam = WALLPX
	elseif round( dir.z ) == 1  then
		newparam = WALLMZ
	elseif round( dir.z ) == -1 then
		newparam = WALLPZ
	end

	if und.name == 'air' then
		minetest.env:add_node( pos,  { name = 'riventest:door1_a_c', param2 = newparam } )
		minetest.env:add_node( upos, { name = 'riventest:door1_b_c', param2 = newparam } )
	elseif abv.name == 'air' then
		minetest.env:add_node( pos,  { name = 'riventest:door1_b_c', param2 = newparam } )
		minetest.env:add_node( apos, { name = 'riventest:door1_a_c', param2 = newparam } )
	else
		minetest.env:remove_node( pos )
		placer:get_inventory():add_item( "main", 'riventest:door1' )
		minetest.chat_send_player( placer:get_player_name(), 'not enough space' )
	end
end
local on_door1_punched = function( pos, node, puncher )
	if string.find( node.name, 'riventest:door1' ) == nil then return end

	upos = { x = pos.x, y = pos.y - 1, z = pos.z }
	apos = { x = pos.x, y = pos.y + 1, z = pos.z }

	if string.find( node.name, '_c', -2 ) ~= nil then
		if node.param2 == WALLPX then
			newparam = WALLMZ
		elseif node.param2 == WALLMZ then
			newparam = WALLMX
		elseif node.param2 == WALLMX then
			newparam = WALLPZ
		elseif node.param2 == WALLPZ then
			newparam = WALLPX
		end
	elseif string.find( node.name, '_o', -2 ) ~= nil then
		if node.param2 == WALLMZ then
			newparam = WALLPX
		elseif node.param2 == WALLMX then
			newparam = WALLMZ
		elseif node.param2 == WALLPZ then
			newparam = WALLMX
		elseif node.param2 == WALLPX then
			newparam = WALLPZ
		end
	end

	if ( node.name == 'riventest:door1_a_c' ) then
		minetest.env:add_node( pos,  { name = 'riventest:door1_a_o', param2 = newparam } )
		minetest.env:add_node( upos, { name = 'riventest:door1_b_o', param2 = newparam } )

	elseif ( node.name == 'riventest:door1_b_c' ) then
		minetest.env:add_node( pos,  { name = 'riventest:door1_b_o', param2 = newparam } )
		minetest.env:add_node( apos, { name = 'riventest:door1_a_o', param2 = newparam } )

	elseif ( node.name == 'riventest:door1_a_o' ) then
		minetest.env:add_node( pos,  { name = 'riventest:door1_a_c', param2 = newparam } )
		minetest.env:add_node( upos, { name = 'riventest:door1_b_c', param2 = newparam } )

	elseif ( node.name == 'riventest:door1_b_o' ) then
		minetest.env:add_node( pos,  { name = 'riventest:door1_b_c', param2 = newparam } )
		minetest.env:add_node( apos, { name = 'riventest:door1_a_c', param2 = newparam } )

	end
	minetest.sound_play({name='woodengate', gain=1.5}, {pos=pos, loop=false})
end

local on_door1_digged = function( pos, node, digger )
	upos = { x = pos.x, y = pos.y - 1, z = pos.z }
	apos = { x = pos.x, y = pos.y + 1, z = pos.z }

	if ( node.name == 'riventest:door1_a_c' ) or ( node.name == 'riventest:door1_a_o' ) then
		minetest.env:remove_node( upos )
	elseif ( node.name == 'riventest:door1_b_c' ) or ( node.name == 'riventest:door1_b_o' ) then
		minetest.env:remove_node( apos )
	end
end

minetest.register_on_placenode( on_door1_placed )
minetest.register_on_punchnode( on_door1_punched )
minetest.register_on_dignode( on_door1_digged )


-- ***********************************************************************************
--														**************************************************
--				USER-LOCK DOOR						**************************************************
--														**************************************************
-- ***********************************************************************************
local function has_door2_privilege(meta, player)
	if meta:get_string("owner") == '' then
		meta:set_string("owner", player:get_player_name())
	elseif meta:get_string("owner") ~= player:get_player_name() then
		return false
	end
	return true
end

minetest.register_node( 'riventest:door2', {
	description         = 'User-Lock Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor2.png' },
	inventory_image     = 'rivendoor2.png',
	wield_image         = 'rivendoor2.png',
	paramtype2          = 'wallmounted',
	selection_box       = { type = 'wallmounted' },
	groups              = { choppy=2, dig_immediate=2 },
})

minetest.register_node( 'riventest:door2_a_c', {
	Description         = 'Top Closed Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor2_a.png' },
	inventory_image     = 'rivendoor2_a.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = true,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	legacy_wallmounted  = true,
	drop                = 'riventest:door2',
	can_dig = function(pos,player)
		meta = minetest.env:get_meta(pos)
		return has_door2_privilege(meta, player)
	end,	
})

minetest.register_node( 'riventest:door2_b_c', {
	Description         = 'Bottom Closed Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor2_b.png' },
	inventory_image     = 'rivendoor2_b.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = true,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	legacy_wallmounted  = true,
	drop                = 'riventest:door2',
	can_dig = function(pos,player)
		meta = minetest.env:get_meta(pos)
		return has_door2_privilege(meta, player)
	end,	
})

minetest.register_node( 'riventest:door2_a_o', {
	Description         = 'Top Open Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor2_a_r.png' },
	inventory_image     = 'rivendoor2_a_r.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = false,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	legacy_wallmounted  = true,
	drop                = 'riventest:door2',
	can_dig = function(pos,player)
		meta = minetest.env:get_meta(pos)
		return has_door2_privilege(meta, player)
	end,	
})

minetest.register_node( 'riventest:door2_b_o', {
	Description         = 'Bottom Open Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor2_b_r.png' },
	inventory_image     = 'rivendoor2_b_r.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = false,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	legacy_wallmounted  = true,
	drop                = 'riventest:door2',
	can_dig = function(pos,player)
		meta = minetest.env:get_meta(pos)
		return has_door2_privilege(meta, player)
	end,	
})

local on_door2_placed = function( pos, node, placer )
	if node.name ~= 'riventest:door2' then return end

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
		minetest.env:add_node( pos,  { name = 'riventest:door2_a_c', param2 = newparam } )
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		minetest.env:add_node( upos, { name = 'riventest:door2_b_c', param2 = newparam } )
		local meta = minetest.env:get_meta(upos)
		meta:set_string("owner",  placer:get_player_name() or "")

	elseif abv.name == 'air' then
		minetest.env:add_node( pos,  { name = 'riventest:door2_b_c', param2 = newparam } )
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner",  placer:get_player_name() or "")
		minetest.env:add_node( apos, { name = 'riventest:door2_a_c', param2 = newparam } )
		local meta = minetest.env:get_meta(apos)
		meta:set_string("owner",  placer:get_player_name() or "")

	else
		minetest.env:remove_node( pos )
		placer:get_inventory():add_item( "main", 'riventest:door2' )
		minetest.chat_send_player( placer:get_player_name(), 'not enough space' )
	end
end
local on_door2_punched = function( pos, node, puncher )
	if string.find( node.name, 'riventest:door2' ) == nil then 	return end

	local meta = minetest.env:get_meta(pos)
	if not has_door2_privilege(meta, puncher) then minetest.chat_send_player(puncher:get_player_name(), "door is locked") return end

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

	if ( node.name == 'riventest:door2_a_c' ) then
		minetest.env:add_node( pos,  { name = 'riventest:door2_a_o', param2 = newparam } )
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner",  puncher:get_player_name() or "")

		minetest.env:add_node( upos, { name = 'riventest:door2_b_o', param2 = newparam } )
		local meta = minetest.env:get_meta(upos)
		meta:set_string("owner",  puncher:get_player_name() or "")

	elseif ( node.name == 'riventest:door2_b_c' ) then
		minetest.env:add_node( pos,  { name = 'riventest:door2_b_o', param2 = newparam } )
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner",  puncher:get_player_name() or "")

		minetest.env:add_node( apos, { name = 'riventest:door2_a_o', param2 = newparam } )
		local meta = minetest.env:get_meta(apos)
		meta:set_string("owner",  puncher:get_player_name() or "")

	elseif ( node.name == 'riventest:door2_a_o' ) then
		minetest.env:add_node( pos,  { name = 'riventest:door2_a_c', param2 = newparam } )
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner",  puncher:get_player_name() or "")

		minetest.env:add_node( upos, { name = 'riventest:door2_b_c', param2 = newparam } )
		local meta = minetest.env:get_meta(upos)
		meta:set_string("owner",  puncher:get_player_name() or "")

	elseif ( node.name == 'riventest:door2_b_o' ) then
		minetest.env:add_node( pos,  { name = 'riventest:door2_b_c', param2 = newparam } )
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner",  puncher:get_player_name() or "")

		minetest.env:add_node( apos, { name = 'riventest:door2_a_c', param2 = newparam } )
		local meta = minetest.env:get_meta(apos)
		meta:set_string("owner",  puncher:get_player_name() or "")

	end
	minetest.sound_play({name='metalgate', gain=1.5}, {pos=pos, loop=false})
end

local on_door2_digged = function( pos, node, digger )
	upos = { x = pos.x, y = pos.y - 1, z = pos.z }
	apos = { x = pos.x, y = pos.y + 1, z = pos.z }

	if ( node.name == 'riventest:door2_a_c' ) or ( node.name == 'riventest:door2_a_o' ) then
		minetest.env:remove_node( upos )
	elseif ( node.name == 'riventest:door2_b_c' ) or ( node.name == 'riventest:door2_b_o' ) then
		minetest.env:remove_node( apos )
	end
end

minetest.register_on_placenode( on_door2_placed )
minetest.register_on_punchnode( on_door2_punched )
minetest.register_on_dignode( on_door2_digged )


-- ***********************************************************************************
--														**************************************************
--				PASSWORD-LOCK DOOR				**************************************************
--														**************************************************
-- ***********************************************************************************

local function has_door3_privilege(meta, player)
	if meta:get_string("owner") == '' then
		meta:set_string("owner", player:get_player_name())
	elseif meta:get_string("owner") ~= player:get_player_name() then
		return false
	end
	return true
end

minetest.register_node( 'riventest:door3', {
	description         = 'Keycode-Lock Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor3.png' },
	inventory_image     = 'rivendoor3.png',
	wield_image         = 'rivendoor3.png',
	paramtype2          = 'wallmounted',
	selection_box       = { type = 'wallmounted' },
	groups              = { choppy=2, dig_immediate=2 },

})
minetest.register_node( 'riventest:door3_a_c', {
	Description         = 'Top Closed Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor3_a.png' },
	inventory_image     = 'rivendoor3_a.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = true,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	legacy_wallmounted  = true,
	drop                = 'riventest:door3',
	can_dig = function(pos,player)
		meta = minetest.env:get_meta(pos)
		return has_door3_privilege(meta, player)
	end,	
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "size[6,2;]"..
			"field[0.256,0.5;6,1;keycode;Key code:;]"..
			"button_exit[2.3,1.5;2,1;button;Proceed]")
		meta:set_string("owner", "")
		meta:set_string("form", "yes")
	end,	
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.env:get_meta(pos)
		local sender_name = sender:get_player_name()

		if not has_door3_privilege(meta, sender) then
			if fields.keycode == meta:get_string("keycode") then minetest.chat_send_player(sender_name, "pass")
				on_door3_punched( pos, minetest.env:get_node(pos), sender, true )
			else minetest.chat_send_player(sender_name, "you shall not pass") end
		return end
		meta:set_string("keycode", fields.keycode)
		local bometa = minetest.env:get_meta({x=pos.x,y=pos.y-1,z=pos.z})
		bometa:set_string("keycode", fields.keycode)
	end,	
})

minetest.register_node( 'riventest:door3_b_c', {
	Description         = 'Bottom Closed Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor3_b.png' },
	inventory_image     = 'rivendoor3_b.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = true,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	legacy_wallmounted  = true,
	drop                = 'riventest:door3',
	can_dig = function(pos,player)
		meta = minetest.env:get_meta(pos)
		return has_door3_privilege(meta, player)
	end,	
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "size[6,2;]"..
			"field[0.256,0.5;6,1;keycode;Key code:;]"..
			"button_exit[2.3,1.5;2,1;button;Proceed]")
		meta:set_string("owner", "")
		meta:set_string("form", "yes")
	end,	
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.env:get_meta(pos)
		local sender_name = sender:get_player_name()

		if not has_door3_privilege(meta, sender) then
			if fields.keycode == meta:get_string("keycode") then minetest.chat_send_player(sender_name, "pass")
				on_door3_punched( pos, minetest.env:get_node(pos), sender, true )
			else minetest.chat_send_player(sender_name, "you shall not pass") end
		return end
		meta:set_string("keycode", fields.keycode)
		local bometa = minetest.env:get_meta({x=pos.x,y=pos.y+1,z=pos.z})
		bometa:set_string("keycode", fields.keycode)

	end,	
})

minetest.register_node( 'riventest:door3_a_o', {
	Description         = 'Top Open Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor3_a_r.png' },
	inventory_image     = 'rivendoor3_a_r.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = false,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	legacy_wallmounted  = true,
	drop                = 'riventest:door3',
	can_dig = function(pos,player)
		meta = minetest.env:get_meta(pos)
		return has_door3_privilege(meta, player)
	end,	
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "size[6,2;]"..
			"field[0.256,0.5;6,1;keycode;Key code:;]"..
			"button_exit[2.3,1.5;2,1;button;Proceed]")
		meta:set_string("owner", "")
		meta:set_string("form", "yes")
	end,	
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.env:get_meta(pos)
		local sender_name = sender:get_player_name()

		if not has_door3_privilege(meta, sender) then
			if fields.keycode == meta:get_string("keycode") then minetest.chat_send_player(sender_name, "pass")
				on_door3_punched( pos, minetest.env:get_node(pos), sender, true )
			else minetest.chat_send_player(sender_name, "you shall not pass") end
		return end
		meta:set_string("keycode", fields.keycode)
		local bometa = minetest.env:get_meta({x=pos.x,y=pos.y-1,z=pos.z})
		bometa:set_string("keycode", fields.keycode)
		
	end,	
})

minetest.register_node( 'riventest:door3_b_o', {
	Description         = 'Bottom Open Door',
	drawtype            = 'signlike',
	tiles         = { 'rivendoor3_b_r.png' },
	inventory_image     = 'rivendoor3_b_r.png',
	paramtype           = 'light',
	paramtype2          = 'wallmounted',
	walkable            = false,
	selection_box       = { type = "wallmounted", },
	groups              = { choppy=2, dig_immediate=2 },
	legacy_wallmounted  = true,
	drop                = 'riventest:door3',
	can_dig = function(pos,player)
		meta = minetest.env:get_meta(pos)
		return has_door3_privilege(meta, player)
	end,	
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "size[6,2;]"..
			"field[0.256,0.5;6,1;keycode;Key code:;]"..
			"button_exit[2.3,1.5;2,1;button;Proceed]")
		meta:set_string("owner", "")
		meta:set_string("form", "yes")
	end,	
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.env:get_meta(pos)
		local sender_name = sender:get_player_name()

		if not has_door3_privilege(meta, sender) then
			if fields.keycode == meta:get_string("keycode") then minetest.chat_send_player(sender_name, "pass")
				on_door3_punched( pos, minetest.env:get_node(pos), sender, true )
			else minetest.chat_send_player(sender_name, "you shall not pass") end
		return end
		meta:set_string("keycode", fields.keycode)
		local bometa = minetest.env:get_meta({x=pos.x,y=pos.y+1,z=pos.z})
		bometa:set_string("keycode", fields.keycode)

	end,		
})

local on_door3_placed = function( pos, node, placer )
	if node.name ~= 'riventest:door3' then return end

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
		minetest.env:add_node( pos,  { name = 'riventest:door3_a_c', param2 = newparam } )
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		minetest.env:add_node( upos, { name = 'riventest:door3_b_c', param2 = newparam } )
		local meta = minetest.env:get_meta(upos)
		meta:set_string("owner",  placer:get_player_name() or "")

	elseif abv.name == 'air' then
		minetest.env:add_node( pos,  { name = 'riventest:door3_b_c', param2 = newparam } )
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner",  placer:get_player_name() or "")
		minetest.env:add_node( apos, { name = 'riventest:door3_a_c', param2 = newparam } )
		local meta = minetest.env:get_meta(apos)
		meta:set_string("owner",  placer:get_player_name() or "")

	else
		minetest.env:remove_node( pos )
		placer:get_inventory():add_item( "main", 'riventest:door3' )
		minetest.chat_send_player( placer:get_player_name(), 'not enough space' )
	end
end
on_door3_punched = function( pos, node, puncher,skip )
	if string.find( node.name, 'riventest:door3' ) == nil then 	return end

	local meta = minetest.env:get_meta(pos)
	local keycode = meta:get_string('keycode')
	local owner = meta:get_string('owner')

	if skip ~= true then 
		if not has_door3_privilege(meta, puncher) then 
			minetest.chat_send_player(puncher:get_player_name(), "door is locked") return end 	
	end

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

	if ( node.name == 'riventest:door3_a_c' ) then
		minetest.env:add_node( pos,  { name = 'riventest:door3_a_o', param2 = newparam } )
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner",  owner)
		meta:set_string("keycode",  keycode)

		minetest.env:add_node( upos, { name = 'riventest:door3_b_o', param2 = newparam } )
		local meta = minetest.env:get_meta(upos)
		meta:set_string("owner",  owner)
		meta:set_string("keycode",  keycode)

	elseif ( node.name == 'riventest:door3_b_c' ) then
		minetest.env:add_node( pos,  { name = 'riventest:door3_b_o', param2 = newparam } )
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner",  owner)
		meta:set_string("keycode",  keycode)

		minetest.env:add_node( apos, { name = 'riventest:door3_a_o', param2 = newparam } )
		local meta = minetest.env:get_meta(apos)
		meta:set_string("owner",  owner)
		meta:set_string("keycode",  keycode)

	elseif ( node.name == 'riventest:door3_a_o' ) then
		minetest.env:add_node( pos,  { name = 'riventest:door3_a_c', param2 = newparam } )
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner",  owner)
		meta:set_string("keycode",  keycode)

		minetest.env:add_node( upos, { name = 'riventest:door3_b_c', param2 = newparam } )
		local meta = minetest.env:get_meta(upos)
		meta:set_string("owner",  owner)
		meta:set_string("keycode",  keycode)

	elseif ( node.name == 'riventest:door3_b_o' ) then
		minetest.env:add_node( pos,  { name = 'riventest:door3_b_c', param2 = newparam } )
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner",  owner)
		meta:set_string("keycode",  keycode)

		minetest.env:add_node( apos, { name = 'riventest:door3_a_c', param2 = newparam } )
		local meta = minetest.env:get_meta(apos)
		meta:set_string("owner",  owner)
		meta:set_string("keycode",  keycode)
	end
	minetest.sound_play({name='metalgate', gain=1.5}, {pos=pos, loop=false})
end

local on_door3_digged = function( pos, node, digger )
	upos = { x = pos.x, y = pos.y - 1, z = pos.z }
	apos = { x = pos.x, y = pos.y + 1, z = pos.z }

	if ( node.name == 'riventest:door3_a_c' ) or ( node.name == 'riventest:door3_a_o' ) then
		minetest.env:remove_node( upos )
	elseif ( node.name == 'riventest:door3_b_c' ) or ( node.name == 'riventest:door3_b_o' ) then
		minetest.env:remove_node( apos )
	end
end

minetest.register_on_placenode( on_door3_placed )
minetest.register_on_punchnode( on_door3_punched )
minetest.register_on_dignode( on_door3_digged )

-- ***********************************************************************************
--														**************************************************
--				LINKING BOOKS						**************************************************
--														**************************************************
-- ***********************************************************************************
local linkingbook = {}
linkingbook.sounds = {}
linkingbook_sound = function(p)
	local wanted_sound = {name="linkingbook", gain=1.5}
		linkingbook.sounds[minetest.hash_node_position(p)] = {
			handle = minetest.sound_play(wanted_sound, {pos=p, loop=false}),
			name = wanted_sound.name,
		}

end
local function has_linkingbook_privilege(meta, player)
	if meta:get_string("owner") == '' then
		meta:set_string("owner", player:get_player_name())
	elseif meta:get_string("owner") ~= player:get_player_name() then
		return false
	end
	return true
end


minetest.register_node("riventest:linkingbook", {
	description = "Linking Book",
	drawtype = "nodebox",
	tiles = {"riventest_linkingbook.png",'bookunder.png',"bookside.png"},
	inventory_image = "riventest_linkingbook.png",
	paramtype = "light",
	paramtype2 = "facedir",	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.45, -0.5, -0.3, 0.45, -0.4, 0.3},
--				{-0.1, -0.5, -0.5, 0.1, -0.1, 0.5},

--				{-0.5, 0.4, 0, 0.5, 0.5, 0.5},
--				{-0.1, -0.1, 0, 0.1, 0.4, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.45, -0.5, -0.3, 0.45, -0.4, 0.3},
--				{-0.1, -0.5, -0.5, 0.1, -0.1, 0.5},

--				{-0.5, 0.4, 0, 0.5, 0.5, 0.5},
--				{-0.1, -0.1, 0, 0.1, 0.4, 0.5},
		},
	},	
	groups = {choppy=2,dig_immediate=2},
	sounds = default.node_sound_defaults(),
	on_punch = function(pos,node,puncher)
		local player = puncher:get_player_name()-- or ""
		local meta = minetest.env:get_meta(pos)
		local stringpos = meta:get_string("location")
		local p = {}
		p.x, p.y, p.z = string.match(stringpos, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
		if p.x and p.y and p.z then

			teleporiventeste = minetest.env:get_player_by_name(player)
			linkingbook_sound(pos)
			teleporiventeste:setpos(p)
			linkingbook_sound(p)
		end
	end,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "size[8,3;]"..
			"field[0.256,0.5;8,1;bookname;Book name:;]"..
			"field[0.256,1.5;8,1;location;Coordinates X,Y,Z:;]"..
			"button_exit[3.3,2.5;2,1;button;Write]")
		meta:set_string("infotext", "Linking Book")
		meta:set_string("owner", "")
		meta:set_string("form", "yes")
	end,	
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.env:get_meta(pos)
		local sender_name = sender:get_player_name()

		if not has_linkingbook_privilege(meta, sender) then
			minetest.chat_send_player(sender_name, "You cannot edit other people's books")
		return end

		meta:set_string("infotext", fields.bookname)
		meta:set_string("location", fields.location)
	end,	
	
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
	end,
	
	can_dig = function(pos,player)
		meta = minetest.env:get_meta(pos)
		return has_linkingbook_privilege(meta, player)
	end,
	
})
minetest.register_node("riventest:plinkingbook", {
	description = "Private Linking Book",
	drawtype = 'nodebox',
	tiles = {"riventest_plinkingbook.png",'bookunder.png',"bookside.png"},
	inventory_image = "riventest_plinkingbook.png",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.45, -0.5, -0.3, 0.45, -0.4, 0.3},
--				{-0.1, -0.5, -0.5, 0.1, -0.1, 0.5},

--				{-0.5, 0.4, 0, 0.5, 0.5, 0.5},
--				{-0.1, -0.1, 0, 0.1, 0.4, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.45, -0.5, -0.3, 0.45, -0.4, 0.3},
--				{-0.1, -0.5, -0.5, 0.1, -0.1, 0.5},

--				{-0.5, 0.4, 0, 0.5, 0.5, 0.5},
--				{-0.1, -0.1, 0, 0.1, 0.4, 0.5},
		},
	},	
	groups = {choppy=2,dig_immediate=2},
	sounds = default.node_sound_defaults(),
	on_punch = function(pos,node,puncher)
		local meta = minetest.env:get_meta(pos)
		if not has_linkingbook_privilege(meta, puncher) then return end
		local player = puncher:get_player_name()-- or ""
		local stringpos = meta:get_string("location")
		local p = {}
		p.x, p.y, p.z = string.match(stringpos, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
		if p.x and p.y and p.z then

			teleporiventeste = minetest.env:get_player_by_name(player)
			linkingbook_sound(pos)
			teleporiventeste:setpos(p)
			linkingbook_sound(p)
		end
	end,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "size[8,3;]"..
			"field[0.256,0.5;8,1;bookname;Book name:;]"..
			"field[0.256,1.5;8,1;location;Coordinates X,Y,Z:;]"..
			"button_exit[3.3,2.5;2,1;button;Write]")
		meta:set_string("infotext", "Personal Linking Book")
		meta:set_string("owner", "")
		meta:set_string("form", "yes")
	end,	
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.env:get_meta(pos)
		local sender_name = sender:get_player_name()

		if not has_linkingbook_privilege(meta, sender) then
			minetest.chat_send_player(sender_name, "You cannot edit other people's books")
		return end

		meta:set_string("infotext", fields.bookname)
		meta:set_string("location", fields.location)
	end,	
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
	end,
	
	can_dig = function(pos,player)
		meta = minetest.env:get_meta(pos)
		return has_linkingbook_privilege(meta, player)
	end,
	
})

-- ***********************************************************************************
--														**************************************************
--				DECORATIVE							**************************************************
--														**************************************************
-- ***********************************************************************************


GLOWLIKE = function(nodeid,nodename,drawtype)
	if drawtype == nil then 
		drawtype = 'glasslike'
		inv_image = minetest.inventorycube("riventest_"..nodeid..".png")
	else 
		inv_image = "riventest_"..nodeid..".png" 
	end
	minetest.register_node("riventest:"..nodeid, {
		description = nodename,
		drawtype = drawtype,
		tiles = {"riventest_"..nodeid..".png"},
		inventory_image = inv_image,
		light_propagates = true,
		paramtype = "light",
		sunlight_propagates = true,
		light_source = 15	,
		is_ground_content = true,
		groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
		sounds = default.node_sound_glass_defaults(),
	})
end
METALLIKE = function(nodeid, nodename,fence)
	minetest.register_node("riventest:"..nodeid, {
		description = nodename,
		tiles = {"riventest_"..nodeid..".png"},
		inventory_image = minetest.inventorycube("riventest_"..nodeid..".png"),
		is_ground_content = true,
		groups = {cracky=3},
		sounds = default.node_sound_wood_defaults(),
	})
	if fence == true then
		minetest.register_node("riventest:"..nodeid.."_fence", {
			description = nodename.." Fence",
			drawtype = "fencelike",
			tiles = {"riventest_"..nodeid..".png"},
			inventory_image = "riventest_"..nodeid.."_fence.png",
			wield_image = "riventest_"..nodeid.."_fence.png",
			paramtype = "light",
			is_ground_content = true,
			selection_box = {
				type = "fixed",
				fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
			},
			groups = {cracky=3},
			sounds = default.node_sound_wood_defaults(),
		})
	end
end
local SOUNDS = {}
SOUNDNODE = function(nodeid, nodename,drawtype)
	SOUNDS[nodeid] = {}
	SOUNDS[nodeid].sounds = {}
	local on_punch = function(pos,node)
		local sound = SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)]
		if sound == nil then 
			local wanted_sound = {name=nodeid, gain=1.5}
			SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)] = {	handle = minetest.sound_play(wanted_sound, {pos=pos, loop=true}),	name = wanted_sound.name, }

		else 
			minetest.sound_stop(sound.handle)
			SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)] = nil
		end

	end
	after_dig_node = function(pos,node)
		local sound = SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)]
		if sound ~= nil then
			minetest.sound_stop(sound.handle)
			SOUNDS[nodeid].sounds[minetest.hash_node_position(pos)] = nil
			nodeupdate(pos)
		end
	end
	if drawtype == 'signlike' then
		minetest.register_node("riventest:"..nodeid, {
			description = nodename,
			drawtype = "signlike",
			tiles = {"riventest_"..nodeid..'.png'}, 
			inventory_image = "riventest_"..nodeid..'.png',
			wield_image = "riventest_"..nodeid..'.png', 
			paramtype = "light",
			paramtype2 = "wallmounted",
			sunlight_propagates = true,
			walkable = false,
			metadata_name = "sign",
			selection_box = {
				type = "wallmounted",
				--wall_top = <default>
				--wall_bottom = <default>
				--wall_side = <default>
			},
			groups = {choppy=2,dig_immediate=2},
			legacy_wallmounted = true,
			sounds = default.node_sound_defaults(),
			on_punch = on_punch,
			after_dig_node = after_dig_node,		
		})
	else 
		minetest.register_node("riventest:"..nodeid, { 
			description = nodename, 
			drawtype = 'plantlike', 
			tiles = {"riventest_"..nodeid..'.png'}, 
			inventory_image = "riventest_"..nodeid..'.png',
			wield_image = "riventest_"..nodeid..'.png', 
			paramtype = "light",
			groups = {cracky=3},
			sounds = default.node_sound_stone_defaults(),
			on_punch = on_punch,	
			after_dig_node = after_dig_node,
		})
	end
end
PLANTLIKE = function(nodeid, nodename,type,option)
	if option == nil then option = false end

	local params ={ description = nodename, drawtype = "plantlike", tiles = {"riventest_"..nodeid..'.png'}, 
	inventory_image = "riventest_"..nodeid..'.png',	wield_image = "riventest_"..nodeid..'.png', paramtype = "light",	}
		
	if type == 'veg' then
		params.groups = {snappy=2,dig_immediate=3,flammable=2}
		params.sounds = default.node_sound_leaves_defaults()
		if option == false then params.walkable = false end
	elseif type == 'met' then			-- metallic
		params.groups = {cracky=3}
		params.sounds = default.node_sound_stone_defaults()
	elseif type == 'cri' then			-- craft items
		params.groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3}
		params.sounds = default.node_sound_wood_defaults()
		if option == false then params.walkable = false end
	elseif type == 'eat' then			-- edible
		params.groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3}
		params.sounds = default.node_sound_wood_defaults()
		params.walkable = false
		params.on_use = minetest.item_eat(option)
	end
	minetest.register_node("riventest:"..nodeid, params)
end

METALLIKE('rt1','Riven Testnode 1')
METALLIKE('rt2','Riven Testnode 2')
METALLIKE('rt3','Riven Testnode 3')
METALLIKE('rt4','Riven Testnode 4')
METALLIKE('rt5','Riven Testnode 5')
PLANTLIKE('rt6_mushroom','Riven testnode 6 Mushroom','veg')
METALLIKE('rt7','Riven Testnode 7')
METALLIKE('rt8','Riven Testnode 8')
GLOWLIKE('rt9_lamppost','Riven testnode 9 Lamppost','plantlike')
GLOWLIKE('rt17_lamppost','Riven testnode 17 Lamppost','plantlike')
GLOWLIKE('rt18_lamppost','Riven testnode 18 Lamppost','plantlike')
GLOWLIKE('rt19_lamppost','Riven testnode 19 Lamppost','plantlike')
METALLIKE('rt10','Riven Testnode 10')
METALLIKE('rt11','Riven Testnode 11')
METALLIKE('rt12','Riven Testnode 12')


SOUNDNODE('1','Riven Art (1)','signlike')
SOUNDNODE('2','Riven Art (2)','signlike')
SOUNDNODE('3','Riven Art (3)','signlike')
METALLIKE('wood','Riven Wood')
METALLIKE('woodblue','Riven Wood (Blue)')
METALLIKE('stone1','Riven Stone (1)')
METALLIKE('stone2','Riven Stone (2)')
METALLIKE('stoneblue','Riven Stone (Blue)')
METALLIKE('metal','Riven Rusted Metal')
METALLIKE('bulkhead','Riven Metal Bulkhead')
METALLIKE('goldstone1','Riven Gold Stone (1)')
METALLIKE('goldstone2','Riven Gold Stone (2)')

minetest.register_node("riventest:rt15", {
	description = "Stained Glass",
	drawtype = "nodebox",
	tiles = {"riventest_rt15.png"},
--	inventory_image = minetest.inventorycube("riventest_rt15.png"),
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = LIGHT_MAX-1,	
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.1, 0.5,0.5, 0.1},
--				{-0.1, -0.5, -0.5, 0.1, -0.1, 0.5},

--				{-0.5, 0.4, 0, 0.5, 0.5, 0.5},
--				{-0.1, -0.1, 0, 0.1, 0.4, 0.5},
			},
		},
selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.1, 0.5,0.5, 0.1},
--				{-0.1, -0.5, -0.5, 0.1, -0.1, 0.5},

--				{-0.5, 0.4, 0, 0.5, 0.5, 0.5},
--				{-0.1, -0.1, 0, 0.1, 0.4, 0.5},
			},
		},		
})
minetest.register_node("riventest:glass", {
	description = "Riven Glass",
	drawtype = "glasslike",
	tiles = {"riventest_glass.png"},
	inventory_image = minetest.inventorycube("riventest_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_node("riventest:rt16", {
	description = "Puzzle Book",
	drawtype = "signlike",
	tiles = {"riventest_rt16.png"},
	inventory_image = "riventest_rt16.png",
	wield_image = "riventest_rt16.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_propagates = true,
	sunlight_propagates = true,
	light_source = 10,
	walkable = false,

	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups = {choppy=2,dig_immediate=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})
extend_chain = function(pos)
	
	local upos = {x=pos.x,y=pos.y-1,z=pos.z}
	local apos = {x=pos.x,y=pos.y+1,z=pos.z}
	
	local unode = minetest.env:get_node(upos)
	local anode = minetest.env:get_node(apos)
	if unode.name == 'air' then
		minetest.env:add_node( upos, { name = 'riventest:chain'} )	
		extend_chain(upos)
	end
	if anode.name == 'air' then
		minetest.env:add_node( apos, { name = 'riventest:chain'} )	
		extend_chain(apos)
	end	

end
minetest.register_node("riventest:chain", {
	description = "Chain",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"riventest_chain.png"},
	inventory_image = "riventest_chain.png",
	wield_image = "riventest_chain.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	buildable_to = true,
	groups = {snappy=2,dig_immediate=3},
	sounds = default.node_sound_wood_defaults(),
	after_place_node = extend_chain,
})
minetest.register_node("riventest:water_flowing", {
	description = "Flowing Water",
	inventory_image = minetest.inventorycube("riventest_altwater.png"),
	drawtype = "flowingliquid",
	tiles = {"riventest_altwater.png"},
	alpha = WATER_ALPHA,
	paramtype = "light",
--	light_source = 8,	
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "riventest:water_flowing",
	liquid_alternative_source = "riventest:water_source",
	liquid_viscosity = WATER_VISC,
	post_effect_color = {a=64, r=100, g=100, b=200},
	special_materials = {
		{image="riventest_altwater.png", backface_culling=false},
		{image="riventest_altwater.png", backface_culling=true},
	},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("riventest:water_source", {
	description = "Water Source",
	inventory_image = minetest.inventorycube("riventest_altwater.png"),
	drawtype = "liquid",
	tiles = {"riventest_altwater.png"},
	alpha = WATER_ALPHA,
	paramtype = "light",
	light_source = 8,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "riventest:water_flowing",
	liquid_alternative_source = "riventest:water_source",
	liquid_viscosity = WATER_VISC,
	post_effect_color = {a=64, r=100, g=100, b=200},
	special_materials = {
		-- New-style water source material (mostly unused)
		{image="riventest_altwater.png", backface_culling=false},
	},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("riventest:beetle", {
	description = "Sign",
	drawtype = "signlike",
	tiles = {"riventest_beetle.png"},
	inventory_image = "riventest_beetle.png",
	wield_image = "riventest_beetle.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_propagates = true,
	sunlight_propagates = true,
	light_source = 10,
	walkable = false,

	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups = {choppy=2,dig_immediate=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})
minetest.register_node("riventest:dagger", {
	description = "Sign",
	drawtype = "signlike",
	tiles = {"riventest_dagger.png"},
	inventory_image = "riventest_dagger.png",
	wield_image = "riventest_dagger.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	metadata_name = "sign",
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups = {choppy=2,dig_immediate=2},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		--local n = minetest.env:get_node(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "hack:sign_text_input")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		--print("Sign at "..minetest.pos_to_string(pos).." got "..dump(fields))
		local meta = minetest.env:get_meta(pos)
		fields.text = fields.text or ""
		print((sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to sign at "..minetest.pos_to_string(pos))
		meta:set_string("text", fields.text)
		meta:set_string("infotext", '"'..fields.text..'"')
	end,
})
minetest.register_tool("riventest:tool", {
	description = "Riven Dagger (tool)",
	inventory_image = "riventest_tool.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level=3,
		groupcaps={
			fleshy={times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=10, maxlevel=3},
			cracky={times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=5000, maxlevel=3},
			crumbly={times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=5000, maxlevel=3},
			snappy={times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=5000, maxlevel=3}
		}
	},
})

minetest.register_node("riventest:holocobble", {
	description = "Holographic Cobblestone",
	tiles = {"default_cobble.png"},
	is_ground_content = true,
	walkable = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("riventest:holostone", {
	description = "Holographic Stone",
	tiles = {"default_stone.png"},
	is_ground_content = true,
	walkable = false,
	groups = {cracky=3},
	--drop = 'default:cobble',
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_alias('rtt1', 'riventest:1')
minetest.register_alias('rtt2', 'riventest:2')
minetest.register_alias('rtt3', 'riventest:3')
minetest.register_alias('rtbluewood', 'riventest:woodblue')
minetest.register_alias('rtstone1', 'riventest:stone1')
minetest.register_alias('rtstone2', 'riventest:stone2')
minetest.register_alias('rtbluestone', 'riventest:stoneblue')
minetest.register_alias('rtmetal', 'riventest:metal')
minetest.register_alias('rtbulkhead', 'riventest:bulkhead')
minetest.register_alias('rtgold1', 'riventest:goldstone1')
minetest.register_alias('rtgold2', 'riventest:goldstone2')
minetest.register_alias('rtglass', 'riventest:glass')
minetest.register_alias('rtwood', 'riventest:wood')
minetest.register_alias('rtchain', 'riventest:chain')
minetest.register_alias('rtbeetle', 'riventest:beetle')
minetest.register_alias('rtdagger', 'riventest:dagger')
minetest.register_alias('rttool', 'riventest:tool')
minetest.register_alias('rtwater', 'riventest:water_source')
minetest.register_alias('bluebook', 'riventest:linkingbook')
minetest.register_alias('redbook', 'riventest:plinkingbook')

