
nbu = {}

-- ***********************************************************************************
--														**************************************************
--				RAILINGS				**************************************************
--														**************************************************
-- ***********************************************************************************
function nbu.register_railings(subname, images, desc)
	minetest.register_node("nbu:railing_" .. subname, {
		description = desc..' Railing',--description,description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.2, 0.35, 0.5, 0.3, 0.5},
				{-0.5, -0.5, 0.4, -0.45, 0.2, 0.5},
				{0.5, -0.5, 0.4, 0.45, 0.2, 0.5},
			},		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.2, 0.35, 0.5, 0.3, 0.5},
				{-0.5, -0.5, 0.4, -0.45, 0.2, 0.5},
				{0.5, -0.5, 0.4, 0.45, 0.2, 0.5},
			},		},
	})
	minetest.register_node("nbu:urailing_" .. subname, {
		description = desc..' Railing (Support Piece)',--description,description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.3, 0.4, 0.5, 0.5, 0.5},
			},		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.3, 0.4, 0.5, 0.5, 0.5},
			},		},		
	})
	minetest.register_node("nbu:crailing_" .. subname, {
		description = desc..' Railing (Corner Piece)',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.2, 0.35, 0.5, 0.3, 0.5},
				{-0.5, 0.2, -0.5, -0.35, 0.3, 0.35},
				{-0.5, -0.5, 0.4, -0.4, 0.2, 0.5},
				{0.5, -0.5, 0.4, 0.45, 0.2, 0.5},
				{-0.5, -0.5, -0.5, -0.4, 0.2, -0.45},												
			},		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, 0.35, 0.5, 0.3, 0.5},
				{-0.5, -0.5, -0.5, -0.35, 0.3, 0.35},
			},		},
	})
	minetest.register_node("nbu:ucrailing_" .. subname, {
		description = desc..' Railing (Corner Support Piece)',--description,description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.3, 0.4, 0.5, 0.5, 0.5},
				{-0.5, 0.3, -0.5, -0.4, 0.5, 0.4},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.3, 0.4, 0.5, 0.5, 0.5},
				{-0.5, 0.3, -0.5, -0.4, 0.5, 0.4},

			},
		},
	})
	minetest.register_node("nbu:hrailing_" .. subname, {
		description = desc..' Railing (Cul-de-Sac Piece)',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.2, 0.35, 0.5, 0.3, 0.5},
				{-0.5, 0.2, -0.5, -0.35, 0.3, 0.35},
				{0.5, 0.2, -0.5, 0.35, 0.3, 0.35},				

				{-0.5, -0.5, 0.4, -0.4, 0.2, 0.5},
				{0.5, -0.5, 0.4, 0.4, 0.2, 0.5},
				{-0.5, -0.5, -0.5, -0.4, 0.2, -0.45},
				{0.5, -0.5, -0.5, 0.4, 0.2, -0.45},																												
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.2, 0.35, 0.5, 0.3, 0.5},
				{-0.5, 0.2, -0.5, -0.35, 0.3, 0.35},
				{0.5, 0.2, -0.5, 0.35, 0.3, 0.35},				

				{-0.5, -0.5, 0.4, -0.4, 0.2, 0.5},
				{0.5, -0.5, 0.4, 0.4, 0.2, 0.5},
				{-0.5, -0.5, -0.5, -0.4, 0.2, -0.45},
				{0.5, -0.5, -0.5, 0.4, 0.2, -0.45},		
			},
		},
	})
--[[
	minetest.register_node("nbu:uhrailing_" .. subname, {
		description = desc..' Railing (Corner Support Piece)',--description,description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.3, 0.4, 0.5, 0.5, 0.5},
				{-0.5, 0.3, -0.5, -0.4, 0.5, 0.4},
				{0.5, 0.3, -0.5, 0.4, 0.5, 0.4},				
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.3, 0.4, 0.5, 0.5, 0.5},
				{-0.5, 0.3, -0.5, -0.4, 0.5, 0.4},
				{0.5, 0.3, -0.5, 0.4, 0.5, 0.4},		

			},
		},
	})	]]--
end

-- ***********************************************************************************
--														**************************************************
--				CATWALKS				**************************************************
--														**************************************************
-- ***********************************************************************************
function nbu.register_catwalk(subname, images, description)
		minetest.register_node("nbu:supcatwalk_" .. subname, {
		description = description..' Catwalk',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {
				{-0.1, -0.5, 0.5, 0.1, -0.45, -0.1},
				{-0.1, -0.45, -0.1, 0.1, 0.5, 0.1},
																										
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.1, -0.5, 0.5, 0.1, -0.45, -0.1},
				{-0.1, -0.45, -0.1, 0.1, 0.5, 0.1},
			},
		},
		sounds = default.node_sound_wood_defaults(),
	})

		minetest.register_node("nbu:catwalk_" .. subname, {
		description = description..' Catwalk',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, -0.4, 0.3, 0.5},
				{0.5, 0.2, -0.5, 0.4, 0.3, 0.5},				

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, -0.4, 0.3, 0.5},
				{0.5, 0.2, -0.5, 0.4, 0.3, 0.5},				

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		sounds = default.node_sound_wood_defaults(),
	})
		minetest.register_node("nbu:leftcatwalk_" .. subname, {
		description = description..' Catwalk (Left Turn)',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, 0.5, 0.3, -0.4},
				{-0.5, 0.2, 0.5, -0.4, 0.3, -0.5},
				{0.5, 0.2, 0.5, 0.4, 0.3, 0.4},

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, 0.5, 0.3, -0.4},
				{-0.5, 0.2, 0.5, -0.4, 0.3, -0.5},
				{0.5, 0.2, 0.5, 0.4, 0.3, 0.4},

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
																											
			},
		},
		sounds = default.node_sound_wood_defaults(),
	})	
		minetest.register_node("nbu:rightcatwalk_" .. subname, {
		description = description..' Catwalk (Right Turn)',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, 0.5, 0.3, -0.4},
				{0.5, 0.2, 0.5, 0.4, 0.3, -0.5},
				{-0.5, 0.2, 0.5, -0.4, 0.3, 0.4},

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, 0.5, 0.3, -0.4},
				{0.5, 0.2, 0.5, 0.4, 0.3, -0.5},
				{-0.5, 0.2, 0.5, -0.4, 0.3, 0.4},

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		sounds = default.node_sound_wood_defaults(),
	})	
		minetest.register_node("nbu:tjuncatwalk_" .. subname, {
		description = description..' Catwalk (T Junction)',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, 0.5, 0.3, -0.4},
				{-0.5, 0.2, 0.5, -0.4, 0.3, 0.4},
				{0.5, 0.2, 0.5, 0.4, 0.3, 0.4},

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, 0.5, 0.3, -0.4},
				{-0.5, 0.2, 0.5, -0.4, 0.3, 0.4},
				{0.5, 0.2, 0.5, 0.4, 0.3, 0.4},

				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
																											
			},
		},
		sounds = default.node_sound_wood_defaults(),
	})	
		minetest.register_node("nbu:crosscatwalk_" .. subname, {
		description = description..' Catwalk (4-Way Junction)',--description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, -0.4, 0.3, -0.4},
				{-0.5, 0.2, 0.5, -0.4, 0.3, 0.4},
				{0.5, 0.2, -0.5, 0.4, 0.3, -0.4},				
				{0.5, 0.2, 0.5, 0.4, 0.3, 0.4},
								
				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.45, 0.5},

				{-0.5, 0.2, -0.5, -0.4, 0.3, -0.4},
				{-0.5, 0.2, 0.5, -0.4, 0.3, 0.4},
				{0.5, 0.2, -0.5, 0.4, 0.3, -0.4},				
				{0.5, 0.2, 0.5, 0.4, 0.3, 0.4},
								
				{-0.5, -0.45, 0.45, -0.45, 0.2, 0.5},
				{0.5, -0.45, 0.45, 0.45, 0.2, 0.5},
				{-0.5, -0.45, -0.5, -0.45, 0.2, -0.45},
				{0.5, -0.45, -0.5, 0.45, 0.2, -0.45},																												
			},
		},
		sounds = default.node_sound_wood_defaults(),
	})
end

-- ***********************************************************************************
--														**************************************************
--				STAIRS AND SLABS				**************************************************
--														**************************************************
-- ***********************************************************************************

function nbu.register_stair(subname, images, description)
	minetest.register_node("nbu:stair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.1, -0.5, 0.5, 0, 0},
				{-0.1, -0.5, -0.5, 0.1, -0.1, 0.5},

				{-0.5, 0.4, 0, 0.5, 0.5, 0.5},
				{-0.1, -0.1, 0, 0.1, 0.4, 0.5},
			},
		},
		sounds = default.node_sound_wood_defaults(),
	})

	minetest.register_node("nbu:ustair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {

				{0.1, 0.5, 0, -0.1, 0, -0.5},
--				{-0.1, -0.5, 0, 0.1, 0.5, -0.5},
			},
		},
	})

end

-- Node will be called nbu:slab_<subname>
function nbu.register_slab(subname, images, description)
	minetest.register_node("nbu:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},	
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			-- If it's being placed on an another similar one, replace it with
			-- a full block
			local slabpos = nil
			local slabnode = nil
			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local n0 = minetest.env:get_node(p0)
			local n1 = minetest.env:get_node(p1)
			if n0.name == "nbu:slab_" .. subname then
				slabpos = p0
				slabnode = n0
			elseif n1.name == "nbu:slab_" .. subname then
				slabpos = p1
				slabnode = n1
			end
			if slabpos then
				-- Remove the slab at slabpos
				minetest.env:remove_node(slabpos)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(recipeitem)
				pointed_thing.above = slabpos
				fakestack = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if not fakestack or fakestack:is_empty() then
					itemstack:take_item(1)
				-- Else put old node back
				else
					minetest.env:set_node(slabpos, slabnode)
				end
				return itemstack
			end
			
			-- Otherwise place regularly
			return minetest.item_place(itemstack, placer, pointed_thing)
		end,
	})
end

-- Nodes will be called nbu:{stair,slab}_<subname>
function nbu.register_stair_and_slab(subname, images, desc_stair, desc_slab)
	nbu.register_stair(subname, images, desc_stair)
	nbu.register_slab(subname, images, desc_slab)
end

-- ***********************************************************************************
--														**************************************************
--				MULTILOCK DOORS					**************************************************
--														**************************************************
-- ***********************************************************************************

function nbu.register_door(settings)
	local on_nbdoor_placed = function( pos, node, placer )
		if node.name ~= 'nbu:door_'..settings.name then return end

		upos = { x = pos.x, y = pos.y - 1, z = pos.z }
		apos = { x = pos.x, y = pos.y + 1, z = pos.z }
		und = minetest.env:get_node( upos )
		abv = minetest.env:get_node( apos )

		if und.name == 'air' then
			minetest.env:add_node( pos,  { name = 'nbu:door_'..settings.name..'_a',param2=node.param2} )
			local meta = minetest.env:get_meta(pos)
			meta:set_string("owner", placer:get_player_name() or "")

			minetest.env:add_node( upos, { name = 'nbu:door_'..settings.name..'_b',param2=node.param2} )
			local meta = minetest.env:get_meta(upos)
			meta:set_string("owner", placer:get_player_name() or "")

		elseif abv.name == 'air' then
			minetest.env:add_node( pos,  { name = 'nbu:door_'..settings.name..'_b',param2=node.param2} )
			local meta = minetest.env:get_meta(pos)
			meta:set_string("owner", placer:get_player_name() or "")

			minetest.env:add_node( apos, { name = 'nbu:door_'..settings.name..'_a',param2=node.param2} )
			local meta = minetest.env:get_meta(apos)
			meta:set_string("owner", placer:get_player_name() or "")

		else
			minetest.env:remove_node( pos )
			placer:get_inventory():add_item( "main", 'nbu:door_'..settings.name )
			minetest.chat_send_player( placer:get_player_name(), 'not enough space' )
		end
	end
	local on_nbdoor_punched = function( pos, node, puncher, skip )
		if string.find( node.name, 'nbu:door_'..settings.name ) == nil then return end

		local meta = minetest.env:get_meta(pos)
		local owner = meta:get_string("owner")
		local keycode = meta:get_string('keycode')

		if not skip then
			if owner == '' then
				meta:set_string("owner", puncher:get_player_name())
			elseif owner ~= puncher:get_player_name() then
				minetest.chat_send_player( puncher:get_player_name(), 'door is locked' )
				return false
			end
		end

		upos = { x = pos.x, y = pos.y - 1, z = pos.z }
		apos = { x = pos.x, y = pos.y + 1, z = pos.z }

		if node.param2 == 0 then newparam =1
		elseif node.param2 == 1 then newparam =0
		elseif node.param2 == 2 then newparam =3
		elseif node.param2 == 3 then newparam =2 end

		if ( node.name == 'nbu:door_'..settings.name..'_a' ) then
			minetest.env:add_node( pos,  { name = 'nbu:door_'..settings.name..'_a', param2 = newparam } )
			local meta = minetest.env:get_meta(pos)
			meta:set_string("owner", owner)
			if keycode then meta:set_string("keycode",  keycode) end

			minetest.env:add_node( upos, { name = 'nbu:door_'..settings.name..'_b', param2 = newparam } )
			local meta = minetest.env:get_meta(upos)
			meta:set_string("owner", owner)
			if keycode then meta:set_string("keycode",  keycode) end

		elseif ( node.name == 'nbu:door_'..settings.name..'_b' ) then

			minetest.env:add_node( pos,  { name = 'nbu:door_'..settings.name..'_b', param2 = newparam } )
			local meta = minetest.env:get_meta(pos)
			meta:set_string("owner", owner)
			if keycode then meta:set_string("keycode",  keycode) end

			minetest.env:add_node( apos, { name = 'nbu:door_'..settings.name..'_a', param2 = newparam } )
			local meta = minetest.env:get_meta(apos)
			meta:set_string("owner", owner)
			if keycode then meta:set_string("keycode",  keycode) end
		end
		minetest.sound_play({name='metalgate'}, {pos=pos, loop=false})
	end

	local on_nbdoor_digged = function( pos, node, digger )
		upos = { x = pos.x, y = pos.y - 1, z = pos.z }
		apos = { x = pos.x, y = pos.y + 1, z = pos.z }

		if ( node.name == 'nbu:door_'..settings.name..'_a' ) then
			minetest.env:remove_node( upos )
		elseif ( node.name == 'nbu:door_'..settings.name..'_b' ) then
			minetest.env:remove_node( apos )
		end
	end

	local buildkey, keycode = nil
	if settings.keycode then 
		buildkey = function(pos)
			local meta = minetest.env:get_meta(pos)
			meta:set_string("formspec", "size[6,2;]"..
				"field[0.256,0.5;6,1;keycode;Key code:;]"..
				"button_exit[2.3,1.5;2,1;button;Proceed]")
			meta:set_string("owner", "")
			meta:set_string("form", "yes")
		end	
		keylock = function(pos, formname, fields, sender)
			local node = minetest.env:get_node(pos)
			local meta = minetest.env:get_meta(pos)
			local owner = meta:get_string("owner")
			local keycode = meta:get_string('keycode')
			local sender_name = sender:get_player_name()
			local upos = { x = pos.x, y = pos.y - 1, z = pos.z }
			local apos = { x = pos.x, y = pos.y + 1, z = pos.z }

			if sender_name == owner then 
				if ( node.name == 'nbu:door_'..settings.name..'_a' ) then
					local meta = minetest.env:get_meta(pos)
					meta:set_string("keycode",  fields.keycode)
					local meta = minetest.env:get_meta(upos)
					meta:set_string("keycode",  fields.keycode)
				elseif ( node.name == 'nbu:door_'..settings.name..'_b' ) then
					local meta = minetest.env:get_meta(pos)
					meta:set_string("keycode",  fields.keycode)
					local meta = minetest.env:get_meta(apos)
					meta:set_string("keycode",  fields.keycode)
				end
				minetest.chat_send_player( sender_name, 'keycode \''..fields.keycode..'\' set' )

			elseif fields.keycode == keycode then
				on_nbdoor_punched(pos,node,sender_name,true)
			else
				minetest.chat_send_player( sender_name, 'door is locked' )
			end
		end
	end

	if not settings.texbot then settings.texbot = settings.textop end
	if not settings.doortex then settings.doortex = settings.textop end

	minetest.register_node( 'nbu:door_'..settings.name, {
		description         = settings.name..' Door',
		drawtype            = 'nodebox',
		tiles        		= { settings.doortex },
		paramtype2          = 'facedir',
		groups              = { choppy=2, dig_immediate=2 },
		node_box = {
			type = "fixed",
			fixed = {{-0.25, -0.5, 0.5, 0.25, 0.5, 0.45},	},
		},
	})
	minetest.register_node( 'nbu:door_'..settings.name..'_a', {
		Description         = 'Top Closed Door',
		tiles		        = { settings.textop },
		groups              = { choppy=2, dig_immediate=2 },
		drop                = 'nbu:door_'..settings.name,
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",	
		node_box = {
			type = "fixed",
			fixed = {{-0.5, -0.5, 0.5, 0.5, 0.5, 0.4},	},
		},
		selection_box = {
			type = "fixed",
			fixed = {{-0.5, -0.5, 0.5, 0.5, 0.5, 0.4},	},
		},
		on_construct = buildkey,
		on_receive_fields = keylock,
		can_dig = function(pos,player)
			local meta = minetest.env:get_meta(pos)
			if meta:get_string("owner") ~= '' and meta:get_string("owner") ~= player:get_player_name() then
				return false
			else return true end
		end,	
	})
	minetest.register_node( 'nbu:door_'..settings.name..'_b', {
		Description         = 'Bottom Closed Door',
		tiles         		= { settings.texbot },
		inventory_image     = 'rivendoor_b.png',
		groups              = { choppy=2, dig_immediate=2 },
		drop                = 'nbu:door_'..settings.name,
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",	
		node_box = {
			type = "fixed",
			fixed = {{-0.5, -0.5, 0.5, 0.5, 0.5, 0.4},	},
		},
		selection_box = {
			type = "fixed",
			fixed = {{-0.5, -0.5, 0.5, 0.5, 0.5, 0.4},	},
		},
		on_construct = buildkey,
		on_receive_fields = keylock,
		can_dig = function(pos,player)
			local meta = minetest.env:get_meta(pos)
			if meta:get_string("owner") ~= '' and meta:get_string("owner") ~= player:get_player_name() then
				return false
			else return true end
		end,	
	})

	minetest.register_on_placenode( on_nbdoor_placed )
	minetest.register_on_punchnode( on_nbdoor_punched )
	minetest.register_on_dignode( on_nbdoor_digged )
end

minetest.register_chatcommand("nbu", {
	params = "<name>",
	description = "give full inventory set of all pieces",
	privs = {server=true},
	func = function(name, param)
		local player = minetest.env:get_player_by_name(name)
		player:get_inventory():add_item( "main", 'nbu:door_'..param..' 99' )
		player:get_inventory():add_item( "main", 'nbu:stair_'..param..' 99' )
		player:get_inventory():add_item( "main", 'nbu:ustair_'..param..' 99' )
		player:get_inventory():add_item( "main", 'nbu:slab_'..param..' 99' )
		player:get_inventory():add_item( "main", 'nbu:railing_'..param..' 99' )
		player:get_inventory():add_item( "main", 'nbu:urailing_'..param..' 99' )
		player:get_inventory():add_item( "main", 'nbu:crailing_'..param..' 99' )
		player:get_inventory():add_item( "main", 'nbu:ucrailing_'..param..' 99' )
		player:get_inventory():add_item( "main", 'nbu:hrailing_'..param..' 99' )
		player:get_inventory():add_item( "main", 'nbu:catwalk_'..param..' 99' )
		player:get_inventory():add_item( "main", 'nbu:leftcatwalk_'..param..' 99' )
		player:get_inventory():add_item( "main", 'nbu:rightcatwalk_'..param..' 99' )
		player:get_inventory():add_item( "main", 'nbu:tjuncatwalk_'..param..' 99' )
		player:get_inventory():add_item( "main", 'nbu:crosscatwalk_'..param..' 99' )
		player:get_inventory():add_item( "main", 'nbu:supcatwalk_'..param..' 99' )
	end,
})
nbu.makeset = function(setname, settexture)
	nbu.register_door({name=setname,textop=settexture,keycode=true})
	nbu.register_stair_and_slab(setname, {settexture},	setname.." stair",	setname.." slab")
	nbu.register_railings(setname, {settexture}, setname)
	nbu.register_catwalk(setname, {settexture},	setname)
end

nbu.makeset('mossycobble','default_mossycobble.png')
nbu.makeset('tree','default_tree.png')


