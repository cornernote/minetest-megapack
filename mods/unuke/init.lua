--items to be crafted


minetest.register_node("unuke:nuke", {
	description = "Nuke",
	groups = {cracky=3, igniter=3, hot=3},
	drawtype = "glasslike",
	tiles = {"unuke_nukei.png"},
	inventory_image = minetest.inventorycube("unuke_nukei.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	material = minetest.digprop_glasslike(1.0),
	light_source = 9,
})


minetest.register_abm(
	{nodenames = {"unuke:nuke"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local objs = minetest.env:get_objects_inside_radius(pos, 50)
		for k, obj in pairs(objs) do
			obj:set_hp(obj:get_hp()-2)
		end
	end,
})




local uraniumore = {
	"unuke:uranium"
}

local uranium_gen = function( minp, maxp )
	for c, uraniummineral in ipairs(uraniumore) do
		local amount = math.random( 0, 0.1 )
		for a = 0, amount do
			local pos = {
				x = math.random( minp.x, maxp.x ),
				y = math.random( minp.y, maxp.y ),
				z = math.random( minp.z, maxp.z ),
			}
			for i = -1, 1 do
				for j = -1, 1 do
					for k = -1, 1 do
						if math.random() > 0.2 then
						else
							local p = { x=pos.x+i, y=pos.y+j, z=pos.z+k }
							local n = minetest.env:get_node( p )
							if n.name == "default:stone" then
								minetest.env:add_node( p, { name = uraniummineral } )
							end
						end
					end
				end
			end
		end
	end
end

minetest.register_on_generated( uranium_gen )





minetest.register_node( "unuke:uranium", {
	description = "Uranium",
	tiles = { "default_stone.png^unuke_uranium.png" },
	inventory_inventory_image = minetest.inventorycube( "default_stone.png^unuke_uranium.png" ),
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'craft "unuke:uranium_lump" 1',
	light_source = 9,
})


minetest.register_craftitem( "unuke:uranium_lump", {
	description = "Lump of uranium",
	inventory_image = "unuke_uraniumlump.png",
	on_place_on_ground = minetest.craftitem_place_item,
	light_source = 9,
})




minetest.register_craftitem( "unuke:tube", {
	description = "Nuke tube",
	inventory_image = "unuke_tube.png",
	on_place_on_ground = minetest.craftitem_place_item,
})



minetest.register_craftitem( "unuke:cfour", {
	description = "C4",
	inventory_image = "unuke_cfour.png",
	on_place_on_ground = minetest.craftitem_place_item,
})


minetest.register_craft({
	output = 'node "c4:c4" 4',
	recipe = {
		{'default:steel_ingot'},
		{'default:junglegrass'},
	}
})


minetest.register_craft({
	output = 'node "unuke:tube" 1',
	recipe = {
		{'default:stone','unuke:uranium_lump','default:stone'},
		{'default:stone','default:stone','default:stone'},
		{'default:stone','unuke:uranium_lump','default:stone'},
	}
})


minetest.register_craft({
	output = 'node "unuke:nuke" 1',
	recipe = {
		{'default:stone','c4:c4','default:stone'},
		{'default:stone','unuke:tube','default:stone'},
		{'default:stone','c4:c4','default:stone'},
	}
})

