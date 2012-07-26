--Oneclick mod
--by kddekadenz

oc = 0

minetest.register_on_punchnode(function(pos, node, puncher)
	if minetest.setting_getbool("creative_mode") then
		minetest.env:remove_node(pos)
	end
		if oc == 1 then
		minetest.env:remove_node(pos)
		puncher:get_inventory():add_item('main', node)
		end	
end)


minetest.register_on_chat_message(function(name, message, playername, player)
    local cmd = "/oneclick"
    if message:sub(0, #cmd) == cmd then
	if oc == 0 then
	oc = 1
	minetest.chat_send_player(name, "Enabled oneclick mode")
	return true
	end
		if oc == 1 then
		oc = 0
		minetest.chat_send_player(name, "Disabled oneclick mode")
		return true
		end
    end
end)

