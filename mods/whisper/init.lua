minetest.register_chatcommand("msg", {
	params = "<toname> <message>",
	description = "send private message",
	privs = {shout=true},
	func = function(name, param)
		local toname = string.match(param, "^([^ ]+) +(.+)$")
		if not toname then
			toname = string.match(param, "^([^ ]+) *$")
		end
		if not toname then
			minetest.chat_send_player(name, "Name field required")
			return
		end
		minetest.chat_send_player(name, "Message sent to "..toname)
		if toname ~= name then
			minetest.chat_send_player(toname, name.." whispers to "..param)
			print("ACTION[ServerThread]:"..name.." Pm's "..param)
		end
	end,
})
print("[Pm] Loaded!")
