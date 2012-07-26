function register_barrel(barrel_name, descr,brecipe, max)
	minetest.register_craft({
		output = 'barrels:' .. barrel_name,
		recipe = brecipe,
	})
	minetest.register_node('barrels:' .. barrel_name, {
			description = descr,
			stack_max = 1,
			metadata_name = 'generic',
			tiles = {'barrels_' .. barrel_name .. '_top.png', 'barrels_' .. barrel_name .. '_down.png', 'barrels_' .. barrel_name .. '_side.png',
				'barrels_' .. barrel_name .. '_side.png', 'barrels_' .. barrel_name .. '_side.png', 'barrels_' .. barrel_name .. '_side.png'},
			groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2, liquid_container=max},
			--sounds = default.node_sound_wood_defaults(),
		})
	minetest.register_on_placenode(function(pos, newnode, placer)
		if newnode.name == ('barrels:' .. barrel_name) then
			local meta = minetest.env:get_meta(pos)
			meta:set_string('liquid', '')
			meta:set_string('quantity', '0')
			meta:set_infotext(descr .. ' empty')
		end
	end)
end

register_barrel('woodbarrel', 
				'Wood barrel',
				{
					{'default:wood 3', '', 'default:wood 3'},
					{'default:wood 3', '', 'default:wood 3'},
					{'default:wood 3', '', 'default:wood 3'},
				},
				10
)
