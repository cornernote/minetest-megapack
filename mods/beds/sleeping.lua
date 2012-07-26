sleeping_players = {}

function AllPlayersInBed()
    local ret = false
    for k, v in pairs(minetest.object_refs) do
        if v:get_player_name() ~= nil then
            if sleeping_players[v:get_player_name()] == nil then
                return false
            end
            ret = true
        end
    end
    
    return ret
end

local timer = 0
minetest.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer >= 10 then
        timer = timer - 10
    else
        return
    end
    
    if AllPlayersInBed() then
        minetest.chat_send_all("[beds] Everyone in bed.  Setting time to dawn.")
        -- set time to dawn
        minetest.env:set_timeofday(0.24)
        
        -- remove everyone from bed so this doesn't run constantly
        sleeping_players = {}
    end
end)

minetest.register_abm({
nodenames = { "beds:blue_top" },
interval = 10,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)
    for name, in_bed in pairs(sleeping_players) do
        if in_bed ~= nil then
            if in_bed.x == pos.x and in_bed.y == pos.y and in_bed.z == pos.z then
                sleeping_players[name] = nil
            end
        end
    end
    objs = minetest.env:get_objects_inside_radius(pos, 1)
    for _, o in pairs(objs) do
        name = o:get_player_name()
        if name ~= nil then
            minetest.chat_send_all("[beds] " .. name .. " added to bed at " .. minetest.pos_to_string(pos))
            sleeping_players[name] = pos
        end
    end
end
})

minetest.register_abm({
nodenames = { "beds:blue_bottom" },
interval = 10,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)
    for name, in_bed in pairs(sleeping_players) do
        if in_bed ~= nil then
            if in_bed.x == pos.x and in_bed.y == pos.y and in_bed.z == pos.z then
                sleeping_players[name] = nil
            end
        end
    end
    objs = minetest.env:get_objects_inside_radius(pos, 1)
    for _, o in pairs(objs) do
        name = o:get_player_name()
        if name ~= nil then
            minetest.chat_send_all("[beds] " .. name .. " added to bed at " .. minetest.pos_to_string(pos))
            sleeping_players[name] = pos
        end
    end
end
})
