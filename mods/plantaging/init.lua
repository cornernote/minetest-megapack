function plant_height (plantx, planty, plantz, plantnodename)
	temp_height = 1
	p_next = {x = plantx, y = planty + 1, z = plantz}
	n_next  = minetest.env:get_node(p_next);
	while true do
		if n_next.name ~= plantnodename then
			break
		end
		temp_height = temp_height + 1
		p_next = {x = p_next.x, y = p_next.y + 1, z = p_next.z}
		n_next = minetest.env:get_node(p_next)
	end
	return temp_height
end

function plantaging (plantname, plantinterval, plantchance, plantsurfaces)
    minetest.register_abm(
    {
        nodenames = { plantname },
        interval = plantinterval,
        chance = plantchance,
        action = function(pos, node, active_object_count, active_object_count_wider)
            -- First check if there is a fertile surface under it and if the growing odds are good
			p_down = {x = pos.x, y = pos.y - 1, z = pos.z}
            n_down = minetest.env:get_node(p_down)
			if n_down.name ~= node.name then
				for _, s in ipairs(plantsurfaces) do
					if string.sub(n_down.name, 1, string.len(s.name)) == s.name and (math.random(1, 1000) > (1000 - s.odds)) then
						--check if the plant grows
						if s.max_height > 1 then
							--calculate the actual height
							cur_height = plant_height (pos.x, pos.y, pos.z, node.name)
							--get potential grow point
							grownodepos = {x = pos.x, y = pos.y + cur_height, z = pos.z}
							grownode = minetest.env:get_node(grownodepos)
							--get light level for the potential growth block
							local light = minetest.env:get_node_light(grownodepos, nil)
							-- replace nil by 0 if needed
							if light == nil then 
								light = 0 
							end
							-- check the light level, the height and the growth possibility
							if (cur_height < s.max_height) and (light >= s.minimal_light) and grownode.name == "air" then
								--place a new block on top
								minetest.env:add_node(grownodepos, {name = node.name})
							end
						end	
						if s.maturing == true then
							--calculate the height
							cur_height = plant_height (pos.x, pos.y, pos.z, node.name)
							if cur_height >= s.maturing_height then
								while cur_height > 0 do
									maturing_node= {x = pos.x, y = pos.y + cur_height - 1, z = pos.z}
									minetest.env:add_node(maturing_node,{type="node",name= s.matured_node})
									cur_height = cur_height - 1
								end
							end
						end
					end
				end
			end
		end
	})
	end


    