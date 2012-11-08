--[[ Single functions or non set commands should go in here ]]--

-- !!! COMMANDS !!! --
--[[ List function. ]]--
if useList then
    minetest.register_chatcommand(listcmd, {
        params = "", -- short parameter description
        description = "List connected players", -- full description
        privs = listprivs, -- require the "privs" privilege to run
        func = function(name, param)
            local namelist, count = "", 0
            for _,player in ipairs(minetest.get_connected_players()) do
                local name = player:get_player_name()
                namelist = namelist .. string.format("%s, ", name)
                count = count + 1
            end
            minetest.chat_send_player(name, string.format("\nCurrent players online: %d\nNames: \[%s\]", count, namelist))
        end,
    })
end

--[[ Kill command ]]---
if useKill then
    minetest.register_chatcommand(killcmd, {
        params = "",
        description = "Kills you :(",
        privs = killprivs,
        func = function(name, param)
            local player = get_player_obj(name)
            player:set_hp(0.0)
        end,
    })
end