spawn = {x = 0, y = 0, z = 0}

minetest.register_on_chat_message(function(name, message, playername, player)
    local cmd = "/spawn"
    if message:sub(0, #cmd) == cmd then
        if message == '/spawn' then
        local player = minetest.env:get_player_by_name(name)
        minetest.chat_send_player(player:get_player_name(), "Teleporting to spawn...")
        player:setpos(spawn)
        return true --deds to sfan5
        end
    end
end)

--Deds to Kahrl
minetest.register_on_newplayer(function(player)
    player:setpos(spawn)
    return true
end)

--Deds to Kahrl
minetest.register_on_respawnplayer(function(player, pos)
    player:setpos(spawn)
    return true
end)
