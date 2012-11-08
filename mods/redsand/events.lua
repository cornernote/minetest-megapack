--[[
    All code that is triggered when an event happens should reside
    here :D
]]--

-- !!! EVENTS !!! --

--[[ What happens when a player joins? ]]--
if useMOTD then
    minetest.register_on_joinplayer( function(player)
        minetest.after( 2.0, function(param)
            minetest.chat_send_player(player:get_player_name(), string.format(MOTD, player:get_player_name()))
        end )
    end )
end

--[[ What happens when a player die? ]]--
if useDeathMSG then
    minetest.register_on_dieplayer( function(player)
        minetest.chat_send_all(string.format(DEATH_MSG, player:get_player_name()))
    end )
end

--[[ What happens when a player respawn ]]--
if useReviveMSG then
    minetest.register_on_respawnplayer( function(player)
        minetest.chat_send_all(string.format(REVIVE_MSG, player:get_player_name()))
    end )
end
