
-------------------------------------------------------------------------------
-- name: get_ground_level(pos)
--
-- action: detect ground level containing sliders
--
-- param1: position detect ground
-- retval: position of ground level slider
-------------------------------------------------------------------------------
function get_ground_level(pos)

    local current_pos =round_pos(pos)

    local tested_node = minetest.env:get_node(current_pos)

    

    while tested_node ~= nil and tested_node.name == "air" do
        current_pos = {x=current_pos.x,y=current_pos.y -1,z=current_pos.z}

        tested_node = minetest.env:get_node(current_pos)
    end

    return current_pos
end

function get_ground_level_x(pos)

	
	
	local dirs = {
	   {x=0,z=0.5},
	   {x=0,z=-0.5},
	   {x=0.5,z=0},
	   {x=-0.5,z=0}
	}

    local current_ground_level = round_pos(pos)
    
    
    for i=1, #dirs do
    
        local current_pos = round_pos({x=pos.x+dirs[i].x,y=pos.y+2,z=pos.z+dirs[i].z})
        
        local tested_node = minetest.env:get_node(current_pos)

        while tested_node ~= nil and tested_node.name == "air" do
            current_pos = {x=current_pos.x,y=current_pos.y -1,z=current_pos.z}
            tested_node = minetest.env:get_node(current_pos)
            
            if current_pos.y > current_ground_level.y then
                current_ground_level = current_pos
            end
        end
    end
    
	return {x=pos.x,y=current_ground_level.y,z=pos.z}
end


-------------------------------------------------------------------------------
-- name: is_slider(name)
--
-- action: detect if node is a slider
--
-- param1: name of node
-- retval: true/false
-------------------------------------------------------------------------------
function is_slider(name)

	if 	name == "pushable_block:slider" or
	   name == "pushable_block:break" or
		name == "pushable_block:booster" then
		return true
	end

	return false
end

-------------------------------------------------------------------------------
-- name: get_boost(speed,pos)
--
-- action: calculate boost
--
-- param1: name of node
-- retval: true/false
-------------------------------------------------------------------------------
function get_boost(speed,pos)

	local node_at_pos = minetest.env:get_node(pos)
		
	local x_accel = 0
	local z_accel = 0
	
	

	if  node_at_pos ~= nil and
		node_at_pos.name == "pushable_block:booster" then

		--print("Found booster: " .. printpos(pos))

		if speed.x > 0 then
			x_accel = 5
		end

		if speed.x < 0 then
			x_accel = -5
		end

		if speed.z < 0 then
			z_accel = -5
		end
		
		if speed.z > 0 then
			z_accel = 5
		end
	end
	
	if  node_at_pos ~= nil and
        node_at_pos.name == "pushable_block:break" then

        --print("Found booster: " .. printpos(pos))

        if speed.x > 0 then
            x_accel = -5
        end

        if speed.x < 0 then
            x_accel = 5
        end

        if speed.z < 0 then
            z_accel = 5
        end
        
        if speed.z > 0 then
            z_accel = -5
        end
    end

	return {x=x_accel,z=z_accel}
end

-------------------------------------------------------------------------------
-- name: detect_slider_type(pos)
--
-- action: find out what type of slider we are driving at
--
-- param1: position to detect
-- retval: slidertype
-------------------------------------------------------------------------------
function detect_slider_type(pos)

	local current_node =  minetest.env:get_node(pos)

	if current_node == nil then
		return "inv"
	end

	if is_slider(current_node.name) ~= true and
		current_node.name ~= "air" then
		--print("not on slider:"..current_node.name)
		return "inv"
	end 

	local node_x_prev = minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z})
	local node_x_next = minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z})
	local node_z_prev = minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z-1})
	local node_z_next = minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z+1})


	local node_x_prev_above = minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z})
	local node_x_next_above = minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z})
	local node_z_prev_above = minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z-1})
	local node_z_next_above = minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z+1})

	local node_below        = minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z})

	if node_x_prev ~= nil and
		node_below ~= nil and
		is_slider(node_x_prev.name) and
		is_slider(node_below.name) then
		return "x-b"
	end

	if node_x_next ~= nil and
		node_below ~= nil and
		is_slider(node_x_next.name) and
		is_slider(node_below.name) then
		return "x+b"
	end

	if node_z_prev ~= nil and
		node_below ~= nil and
		is_slider(node_z_prev.name) and
		is_slider(node_below.name) then
		return "z-b"
	end

	if node_z_next ~= nil and
		node_below ~= nil and
		is_slider(node_z_next.name) and
		is_slider(node_below.name) then
		return "z+b"
	end

	if current_node.name == "air" then
		return "in_air"
	end

	
	if node_x_prev_above ~= nil and
		is_slider(node_x_prev_above.name) then
		return "x-u"
	end

	if node_x_next_above ~= nil and
		is_slider(node_x_next_above.name) then
		return "x+u"
	end

	if node_z_prev_above ~= nil and
		is_slider(node_z_prev_above.name) then
		return "z-u"
	end

	if node_z_next_above ~= nil and
		is_slider(node_z_next_above.name) then

		return "z+u"
	end
		

    --easy moving without up or down
	if node_z_prev ~= nil and
		node_x_next ~= nil and
		is_slider(node_z_prev.name) and
		is_slider(node_x_next.name) then

		return "x+"
	end

	if node_z_prev ~= nil and
		node_x_prev ~= nil and
		is_slider(node_z_prev.name) and
		is_slider(node_x_prev.name) then

		return "x-"
	end

	if node_z_next ~= nil and
		node_x_next ~= nil and
		is_slider(node_z_next.name) and
		is_slider(node_x_next.name) then

		return "z+"
	end

	if node_z_next ~= nil and
		node_x_prev ~= nil and
		is_slider(node_z_next.name) and
		is_slider(node_x_prev.name) then

		return "z-"
	end


	--only basic directions by now
	if node_x_prev ~= nil and
		node_x_next ~= nil and
		(is_slider(node_x_prev.name) or
		is_slider(node_x_next.name)) then

		return "x"
	end

	if node_z_prev ~= nil and
		node_z_next ~= nil and
		(is_slider(node_z_prev.name) or
		is_slider(node_z_next.name)) then

		return "z"
	end

	return "inv"
end
