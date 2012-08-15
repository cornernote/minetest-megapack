-- ***********************************************************************************
--		FUNCTIONS							**************************************************
-- ***********************************************************************************
searchlight = function(pos)
			for i = 1, 30, 1 do
				local xm = {x=pos.x-i,y=pos.y-i,z=pos.z}
				local xp = {x=pos.x+i,y=pos.y-i,z=pos.z}
				local zm = {x=pos.x,y=pos.y-i,z=pos.z-i}
				local zp = {x=pos.x,y=pos.y-i,z=pos.z+i}
				local xmn  = minetest.env:get_node_or_nil(xm)
				local xpn  = minetest.env:get_node_or_nil(xp)
				local zmn  = minetest.env:get_node_or_nil(zm)
				local zpn  = minetest.env:get_node_or_nil(zp)

				if xmn ~= nil and xmn.name == "air"	then		
					minetest.env:add_node(xm,{type="node",name='madblocks:light'})
				end
				if xpn ~= nil and xpn.name == "air"	then		
					minetest.env:add_node(xp,{type="node",name='madblocks:light'})
				end
				if zmn ~= nil and zmn.name == "air"	then		
					minetest.env:add_node(zm,{type="node",name='madblocks:light'})
				end
				if zpn ~= nil and zpn.name == "air"	then		
					minetest.env:add_node(zp,{type="node",name='madblocks:light'})
				end
			end
end
searchlight_off = function(pos)
			for i = 1, 30, 1 do
				local xm = {x=pos.x-i,y=pos.y-i,z=pos.z}
				local xp = {x=pos.x+i,y=pos.y-i,z=pos.z}
				local zm = {x=pos.x,y=pos.y-i,z=pos.z-i}
				local zp = {x=pos.x,y=pos.y-i,z=pos.z+i}
				local xmn  = minetest.env:get_node_or_nil(xm)
				local xpn  = minetest.env:get_node_or_nil(xp)
				local zmn  = minetest.env:get_node_or_nil(zm)
				local zpn  = minetest.env:get_node_or_nil(zp)

				if xmn ~= nil and xmn.name == 'madblocks:light' then
					minetest.env:remove_node(xm)
				end
				if xpn ~= nil and xpn.name == 'madblocks:light' then
					minetest.env:remove_node(xp)
				end
				if zmn ~= nil and zmn.name == 'madblocks:light' then
					minetest.env:remove_node(zm)
				end
				if zpn ~= nil and zpn.name == 'madblocks:light' then
					minetest.env:remove_node(zp)
				end
			end
end
spotlight = function(pos,node)

			for i = 1, 19, 1 do
				local ontop = {x=pos.x,y=pos.y+i,z=pos.z}
				local is_air  = minetest.env:get_node_or_nil(ontop)

				if is_air ~= nil and is_air.name == "air"	then		
					minetest.env:add_node(ontop,{type="node",name='madblocks:light'})
				end
			end
end

spotlight_off = function(pos,node)
			for i = 1, 19, 1 do
				local ontop = {x=pos.x,y=pos.y+i,z=pos.z}
				local is_air  = minetest.env:get_node_or_nil(ontop)
				if is_air ~= nil and is_air.name == 'madblocks:light' then
					minetest.env:remove_node(ontop)
				end
			end
end

-- ***********************************************************************************
--		DEFS									**************************************************
-- ***********************************************************************************
GLOWLIKE('glowyellow','Yellow Glow Glass')
GLOWLIKE('glowgreen','Green Glow Glass')
GLOWLIKE('glowblue','Blue Glow Glass')
GLOWLIKE('glowred','Red Glow Glass')
GLOWLIKE('glowtron','Tron Glow Glass')
GLOWLIKE('fancylamp','Fancy Lamp','plantlike')

minetest.register_node("madblocks:light", {
	drawtype = "glasslike",
	tile_images = {"madblocks_spotlights_inv.png"},
	inventory_image = minetest.inventorycube("madblocks_spotlights_inv.png"),
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	light_propagates = true,
	sunlight_propagates = true,
	light_source = 15	,
	selection_box = {
        type = "fixed",
        fixed = {0, 0, 0, 0, 0, 0},
    },
})
minetest.register_node("madblocks:searchlight", { 
	description = 'Searchlight', 
	drawtype = "plantlike", 
	tile_images = {'madblocks_searchlight.png'}, 
	inventory_image = 'madblocks_searchlight.png',	
	wield_image = 'madblocks_searchlight.png', 
	paramtype = "light",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'madblocks:searchlight_off',
	on_punch = function(pos,node)
		searchlight_off(pos)
		minetest.env:add_node(pos, {name='madblocks:searchlight_off'})
	end,
	on_dig = function(pos,node)
		searchlight_off(pos)
	end,
})
minetest.register_node("madblocks:searchlight_off", { 
	description = 'Searchlight', 
	drawtype = "plantlike", 
	tile_images = {'madblocks_searchlight.png'}, 
	inventory_image = 'madblocks_searchlight.png',	
	wield_image = 'madblocks_searchlight.png', 
	paramtype = "light",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_punch =  function(pos,node)
		searchlight(pos)
		minetest.env:add_node(pos, {name='madblocks:searchlight'})
	end,
})			
minetest.register_node("madblocks:spotlight", {
	description = "Spotlight",
	tile_images = { "madblocks_spotlights_top.png", "madblocks_spotlights_side.png", "madblocks_spotlights_side.png"},
	inventory_image = minetest.inventorycube("madblocks_spotlights_top.png","madblocks_spotlights_side.png","madblocks_spotlights_side.png"),
	paramtype2 = "facedir",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3},
	drop = 'madblocks:spotlight_off',
	on_punch = function(pos,node)
		spotlight_off(pos)
		minetest.env:add_node(pos, {name='madblocks:spotlight_off'})
	end,
	on_dig = function(pos,node)
		spotlight_off(pos)
	end,
})
minetest.register_node("madblocks:spotlight_off", {
	description = "Spotlight",
	tile_images = { "madblocks_spotlights_top.png", "madblocks_spotlights_side.png", "madblocks_spotlights_side.png"},
	inventory_image = minetest.inventorycube("madblocks_spotlights_top.png","madblocks_spotlights_side.png","madblocks_spotlights_side.png"),
	paramtype2 = "facedir",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3},
	on_punch =  function(pos,node)
		spotlight(pos)
		minetest.env:add_node(pos, {name='madblocks:spotlight'})
	end,	
})

