function init_plowing()
	minetest.register_node("farming:plowed", {
		tile_images = {"farming_plowed.png", "default_dirt.png",
				"default_dirt.png", "default_dirt.png",
				"default_dirt.png", "default_dirt.png"},
		inventory_image = minetest.inventorycube("farming_plowed.png",
				"default_dirt.png", "default_dirt.png"),
		drop = "default:dirt",
		material = {
			diggability = "normal",
			weight = 0,
			crackiness = 0,
			crumbliness = 0,
			cuttability = 0,
			flammability = 0,
		},
	})

	minetest.register_abm({
		nodenames = { "farming:plowed" },
		interval = 60,
		chance = 10,

		action = function(pos, node, active_object_count, active_object_count_wider)

			--print("revert farmland abm called")

			pos_above = {x=pos.x,y=pos.y+1,z=pos.z}				


			local found_farming_around = false

			--check for farming entities
			local objects_around = minetest.env:get_objects_inside_radius(pos_above,0.5)
			for i,v in ipairs(objects_around) do

				local entity = farming_find_entity(v)

				if entity ~= nil and
					 entity.farming_name ~= nil then
					--print("found farming entity")
					found_farming_around = true
				end
			end

			--check for harvestable crop
			local node_above = minetest.env:get_node(pos_above)
			if node_above ~= nil and
				contains_crop_name(node_above.name) then
				found_farming_around =	true		
			end

			if found_farming_around == false then
				minetest.env:remove_node(pos)
				minetest.env:add_node(pos,{name="default:dirt"})
			end

		end
	})
end
