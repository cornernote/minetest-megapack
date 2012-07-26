-- Burning a node. Can be used in other mods.
function burn(pos)
    local node = minetest.env:get_node(pos)
    
    if node.name == "morefire:bomb" then
        blow_up(pos, 1, 1)
        return true
    end

    -- Checking for water nearby
    for i = -1, 1 do
    for j = -1, 1 do
    for k = -1, 1 do
        local water_pos = {
            x = pos.x + i,
            y = pos.y + j,
            z = pos.z + k
        }
        local water_node = minetest.env:get_node(water_pos)
        if water_node.name == "default:water_source"
        or water_node.name == "default:water_flowing" then
            return false
        end
    end
    end
    end

    -- Checking for flammability
    --[[
    if minetest.registered_nodes[node.name].furnace_burntime == nil then
        return false
    end
    ]]
    if minetest.registered_nodes[node.name].material.cuttability == nil then
	return false
    end
    if minetest.registered_nodes[node.name].material.cuttability > 0 then
	minetest.env:add_entity({
            x = pos.x,
            y = pos.y,
            z = pos.z,
        }, "morefire:fire_ent")
        return true
    else
        return false
    end
end

-- Creating smoke
function create_smoke(pos)
    local smoke_pos = {
        x = pos.x,
        y = pos.y + 1,
        z = pos.z
    }
    if minetest.env:get_node(smoke_pos).name ~= "air" then
        return
    end
    local smoke = minetest.env:add_entity({
        x = smoke_pos.x,
        y = smoke_pos.y,
        z = smoke_pos.z,
    }, "morefire:smoke_ent")
    smoke:setvelocity({
        x = 0,
        y = 2,
        z = 0
    })
end

-- Creating explosion
function blow_up(pos, radius, rnd)
    local r = radius
    -- Searching for bombs nearby
    r = radius * search_for_bombs(pos, radius, 1)
    print("[fire] Blowing up in (" .. pos.x .. ',' .. pos.y .. ','
    .. pos.z .. ") in radius " .. r)
    for i = -(r + math.random(0, rnd)), (r + math.random(0, rnd)) do
    for j = -(r + math.random(0, rnd)), (r + math.random(0, rnd)) do
    for k = -(r + math.random(0, rnd)), (r + math.random(0, rnd)) do
        local temp_pos = {
            x = pos.x + i,
            y = pos.y + j,
            z = pos.z + k,
        }
        if minetest.env:get_node(temp_pos) ~= "air" then
            minetest.env:remove_node(temp_pos)
        end
        minetest.env:add_node(temp_pos, { name = "morefire:explosion" })
    end
    end
    end
    burn(pos)
end

-- Search for bombs in radius
function search_for_bombs(pos, radius, oldcount)
    local bomb_count = 0
    local new_radius = radius * oldcount
    for i = -new_radius, new_radius do
    for j = -new_radius, new_radius do
    for k = -new_radius, new_radius do
        local temp_pos = {
            x = pos.x + i,
            y = pos.y + j,
            z = pos.z + k,
        }
        if minetest.env:get_node(temp_pos).name == "morefire:bomb" then
            bomb_count = bomb_count + 1
        end
    end
    end
    end
    if bomb_count <= oldcount then
        return bomb_count
    else
        return search_for_bombs(pos, radius, bomb_count)
    end
end
