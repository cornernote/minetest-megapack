--[[ All code around the messaging system should be kept here. ]]--
lastspoke = {}

--[[ MSG command ]]---
if useMSG then
    minetest.register_chatcommand(msgcmd, {
        params = "<target> <text>",
        description = "Talk to someone!",
        privs = msgprivs,
        func = function(name, param)
            if string.match(param, "([^ ]+) (.+)") == nil then
                minetest.chat_send_player(name, "Missing parameters")
                return
            end

            -- Generating the variables out of the parameters
            local targetName, msg = string.match(param, "([^ ]+) (.+)")
            target = get_player_obj(targetName)

            -- Checking if the target exists
            if not target then
                minetest.chat_send_player(name, "The target was not found")
                return
            end

            -- Sending the message
            minetest.chat_send_player(target:get_player_name(), string.format("From %s: %s", name, msg))
            -- Register the chat in the target persons lastspoke tabler
            lastspoke[target:get_player_name()] = name
        end,
    })
end

--[[ REPLY command]] --
if useReply then
    minetest.register_chatcommand(replycmd, {
    params = "<text>",
    description = "Reply the last peron that messaged you.",
    privs = replyprivs,
    func = function(name, param)
        -- We need to get the target
        target = lastspoke[name]

        -- Make sure I don't crash the server.
        if not target then
            minetest.chat_send_player(name, "No one has spoke to you :(")
        elseif param == "" then
            minetest.chat_send_player(name, "You need to say something.")
        else
            -- We need to send the message and update the targets lastspoke[] status.
            minetest.chat_send_player(target, string.format("From %s: %s", name, param))
        end
    end,
    })
end