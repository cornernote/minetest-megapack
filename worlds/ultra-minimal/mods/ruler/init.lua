
ruler_xp = function(pos)
	local upos = {x=pos.x+1,y=pos.y,z=pos.z}
	local unode = minetest.env:get_node(upos)

	if unode.name == 'air' then
		minetest.env:add_node( upos, { name = 'ruler:helpers'} )	
		ruler_xp(upos)
	end
end
ruler_xm = function(pos)
	local upos = {x=pos.x-1,y=pos.y,z=pos.z}
	local unode = minetest.env:get_node(upos)

	if unode.name == 'air' then
		minetest.env:add_node( upos, { name = 'ruler:helpers'} )	
		ruler_xm(upos)
	end
end

ruler_yp = function(pos)
	local upos = {x=pos.x,y=pos.y+1,z=pos.z}
	local unode = minetest.env:get_node(upos)

	if unode.name == 'air' then
		minetest.env:add_node( upos, { name = 'ruler:helpers'} )	
		ruler_yp(upos)
	end
end
ruler_ym = function(pos)
	local upos = {x=pos.x,y=pos.y-1,z=pos.z}
	local unode = minetest.env:get_node(upos)

	if unode.name == 'air' then
		minetest.env:add_node( upos, { name = 'ruler:helpers'} )	
		ruler_ym(upos)
	end
end
ruler_zp = function(pos)
	local upos = {x=pos.x,y=pos.y,z=pos.z+1}
	local unode = minetest.env:get_node(upos)

	if unode.name == 'air' then
		minetest.env:add_node( upos, { name = 'ruler:helpers'} )	
		ruler_zp(upos)
	end
end
ruler_zm = function(pos)
	local upos = {x=pos.x,y=pos.y,z=pos.z-1}
	local unode = minetest.env:get_node(upos)

	if unode.name == 'air' then
		minetest.env:add_node( upos, { name = 'ruler:helpers'} )	
		ruler_zm(upos)
	end
end
minetest.register_node("ruler:helpers", {
	description = "Ruler",
	tile_images = {"default_cloud.png"},
	paramtype = "light",
	buildable_to = true,
	light_source = LIGHT_MAX-1,	
})
minetest.register_node("ruler:tool", {
	description = "Ruler",
	tile_images = {"default_mese.png"},
	paramtype = "light",
	groups = {choppy=2,dig_immediate=2},
	sounds = default.node_sound_defaults(),
	on_punch = function(pos,node,puncher)
		ruler_xp(pos)
		ruler_xm(pos)
		ruler_yp(pos)
		ruler_ym(pos)
		ruler_zp(pos)
		ruler_zm(pos)
	end,
})
CLEAR_HELPERS = false
minetest.register_chatcommand("clearhelpers", {
	params = "<none>",
	description = "clear",
	privs = {server=true},
	func = function(name, param)
		CLEAR_HELPERS = true
	end,
})
minetest.register_chatcommand("keephelpers", {
	params = "<none>",
	description = "clear",
	privs = {server=true},
	func = function(name, param)
		CLEAR_HELPERS = false
	end,
})
minetest.register_abm({
	nodenames = {"ruler:helpers"},
	interval = 60,
	chance = 1,
	action = function(pos, node, _, _)
		if CLEAR_HELPERS == true then
			minetest.env:remove_node(pos)
		end
	end,
})
