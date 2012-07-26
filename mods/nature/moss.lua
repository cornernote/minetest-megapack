-- Turning cobblestone into mossy stone

local MOSS_CHANCE = 30

minetest.register_abm({
    nodenames = { "default:cobble" },
    interval = 7200,
    chance = MOSS_CHANCE,

    action = function(pos, node, _, _)

	local water = false
	local light = false
	for i = -1, 1 do
	for j = -1, 1 do
	for k = -1, 1 do
	    local near_pos = {
		x = pos.x + i,
		y = pos.y + j,
		z = pos.z + k,
	    }
	    
	    local light_level = minetest.env:get_node_light(near_pos, nil)
	    if light_level ~= nil then
		if light_level > 0 then
		    light = true
		end
	    end

	    if minetest.env:get_node(near_pos).name == "default:water_source" then
		water = true
		break
	    end
	end
	end
	end
	
	if water or (not light) then
	    minetest.env:remove_node(pos)
	    minetest.env:add_node(pos, { name = "default:mossycobble" })
	    print("[nature] Turning cobble into mossycobble at ("
	    .. pos.x .. ", " .. pos.y .. ", " .. pos.z .. ")")
	end
    end
})
