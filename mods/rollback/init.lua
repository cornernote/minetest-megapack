minetest.register_on_placenode(function (pos, node, player)
	local file = io.open(minetest.get_modpath("rollback").."/logs/"..player:get_player_name()..".log", "a")
	file:write("p".."&"..os.time().."&"..pos.x.."&"..pos.y.."&"..pos.z.."&"..node.name.."\n")
	file:close()
end)

minetest.register_on_dignode(function (pos, node, player)
	local file = io.open(minetest.get_modpath("rollback").."/logs/"..player:get_player_name()..".log", "a")
	file:write("d".."&"..os.time().."&"..pos.x.."&"..pos.y.."&"..pos.z.."&"..node.name.."\n")
	file:close()
end)



local function rollback(cmd, player, playername, time)
	if not minetest.get_player_privs(player)["privs"] then
		minetest.chat_send_player(player, "error: you don't have permission to rollback")
		return
	end
	
	local file = io.open(minetest.get_modpath("rollback").."/logs/"..playername..".log", "r")
	if file==nil then
		minetest.chat_send_player(player, "error: We have no records on this player")
		return
	end

	local line
	local pos={}
	local action, logtime, nodename
	
	line=file:read()
	while (line~=nil) do
		action, logtime, pos.x, pos.y, pos.z, nodename=string.match(line, "([%a%d%d%d%d%a_-]+)&(.*)&(.*)&(.*)&(.*)&(.*)")
		print (action)
		--print (time)
		--print (pos.x)
		--print (pos.y)
		--print (pos.z)
		--print (pos.z)
		--print (nodename)
		--print (line)
		--print ("logtime:"..logtime)
		--print ("mintime:"..os.time()-tonumber(time))
		if time==nil or tonumber(logtime)>os.time()-tonumber(time) then
			if action=="p" then
				minetest.env:remove_node(pos)
			end
			if action=="d" then
				minetest.env:add_node(pos,  {name=nodename})
			end
		end
		line=file:read()
	end
	file:close()
	local file = io.open(minetest.get_modpath("rollback").."/logs/"..playername..".log", "w+")
	file:close()
end





minetest.register_on_chat_message(function(player, message)
	local cmd = "/rollbacktime"
	if message:sub(0, #cmd) == cmd then
		local playername, time = string.match(message, cmd.." ([%a%d_-]+) (.*)")
		if playername == nil or time==nil then
			minetest.chat_send_player(player, 'usage: '..cmd..' playername time')
			return true -- Handled chat message
		end
		rollback(cmd, player, playername, time)
		return true
	end	
	local cmd = "/rollback"
	if message:sub(0, #cmd) == cmd then
		local playername = string.match(message, cmd.." (.*)")
		if playername == nil then
			minetest.chat_send_player(player, 'usage: '..cmd..' playername')
			return true -- Handled chat message
		end
		rollback(cmd, player, playername, nil)
		return true
	end
end)
