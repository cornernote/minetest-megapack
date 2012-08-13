--[[
	Mod by kotolegokot
	Version 2012.8.13.0
]]
function table.contains(table, value)
	for i = 1, #table do
		if table[i] == value then
			return true
		end
	end
	return false
end
--Local functions
local function set_list(list_name, list)
	output = io.open(minetest.get_worldpath() .. "/" .. list_name .. ".txt", "w") 
	if not output then
		minetest.log("error", "lists: can't open " .. minetest.get_worldpath() .. "/list_" .. list_name .. ".txt to write")
		return nil
	end
	output:write(minetest.serialize(list))
	io.close(output)
end
local function get_list(list_name)
	input = io.open(minetest.get_worldpath() .. "/" .. list_name .. ".txt", "r")
	if not input then
		return nil
	end
	list = minetest.deserialize(input:read("*l"))
	io.close(input)
	return list
end
local function add_to_list(list_name, player_name)
	local list = get_list(list_name)
	if not list then list = {} end
	if not table.contains(list, player_name) then
		table.insert(list, player_name)
		set_list(list_name, list)
		return true
	end
	return false
end
local function remove_from_list(list_name, player_name)
	local list = get_list(list_name)
	if list then
		for i = 1, #list do
			if list[i] == player_name then
				table.remove(list, i)
				set_list(list_name, list)
				return true
			end
		end
	end
	return false
end
--Privileges
minetest.register_privilege("list", {
	description = "Can use /list command",
	give_to_singleplayer = false,
})
minetest.register_privilege("tell", {
	description = "Can use /tell command",
	give_to_singleplayer = false,
})
--Commands
minetest.register_chatcommand("list", {
	privs = {list=true},
	params = "[add/remove/rm <list> <item> | info/removelist/rmlist <list> | list | execute/exe <list> <command>]",
	description = "Operations with lists",
	func = function(name, param)
		if param == "" then
			minetest.chat_send_player(name, "Lists: " .. table.concat(get_list("lists"), ","))
			return true
		end
		local param1 = string.match(param, "^([^ ]+)")
		if param1 == "add" then
			local _, list_name, item = string.match(param, "^([^ ]+) ([^ ]+) ([^ ]+)")
			if list_name and item then
				if add_to_list("list_" .. list_name, item) then
					add_to_list("lists", list_name)
					minetest.chat_send_player(name, "Item \"" .. item .. "\" added in the list.")
				else
					minetest.chat_send_player(name, "Item \"" .. item .. "\" already is in the list.")
				end
				return true
			end
		elseif param1 == "remove" or param1 == "rm" then
			local _, list_name, item = string.match(param, "^([^ ]+) ([^ ]+) ([^ ]+)")
			if list_name and item then
				if remove_from_list("list_" .. list_name, item) then
					local tmp = get_list("list_" .. list_name)
					if not tmp or #tmp == 0 then
						remove_from_list("lists", list_name)
						os.remove(minetest.get_worldpath() .. "/list_" .. list_name .. ".txt")
					end
					minetest.chat_send_player(name, "Item \"" .. item .. "\" removed from the list.")
				else
					minetest.chat_send_player(name, "Item \"" .. item .. "\" is not in the list or the list does not exist.")
				end
				return true
			end
		elseif param1 == "rmlist" or param1 == "removelist" then
			local _, list_name = string.match(param, "^([^ ]+) ([^ ]+)")
			if list_name then
				if get_list("list_" .. list_name) then
					remove_from_list("lists", list_name)
					os.remove(minetest.get_worldpath() .. "/list_" .. list_name .. ".txt")
					minetest.chat_send_player(name, "The list removed.")
				else
					minetest.chat_send_player(name, "The list does not exist.")
				end
			end
			return true
		elseif param1 == "info" then
			_, list_name = string.match(param, "^([^ ]+) ([^ ]+)")
			if list_name then
				if get_list("list_" .. list_name) then
					minetest.chat_send_player(name, list_name .. ": " .. table.concat(get_list("list_" .. list_name), ","))
				else
					minetest.chat_send_player(name, "List named \"" .. list_name .. "\" does not exist.")
				end
				return true
			end
		elseif param1 == "list" then
			minetest.chat_send_player(name, "Lists: " .. table.concat(get_list("lists"), ","))
			return true
		elseif param1 == "execute" or param1 == "exe" then
			_, command = string.match(param, "^([^ ]+) *(.*)")
			if command then
				local s = {}
				for i = 1, #command do
					if command:sub(i, i) == "`" then
						table.insert(s, i)
					end
				end
				if #s % 2 == 1 then
					minetest.chat_send_player(name, "Invalid parameter \"command\"")
					return
				end
				local ss = {}
				for i = 1, #s / 2 do
					ss[i] = command:sub(s[(i-1)*2+1] + 1, s[(i-1)*2+2] - 1) 
				end
				local lists = {}
				local pos1 = {}
				local pos2 = {}
				for i = 1, #ss do
					local ps = string.split(ss[i], " ")
					if #ps % 2 == 1 then
						minetest.chat_send_player(name, "Invalid parameter \"command\"")
						return
					end
					lists[i] = {}
					pos1[i] = s[(i-1)*2+1] - 1
					pos2[i] = s[(i-1)*2+2] + 1
					for j = 1, #ps / 2 do
						if ps[(j-1)*2+1] == "list" then
							local tmp = get_list("list_" .. ps[(j-1)*2+2])
							if not tmp then
								minetest.chat_send_player(name, "List named \"" .. ps[(j-1)*2+2] .. "\" does not exist.")
								return
							end
							for k = 1, #tmp do
								table.insert(lists[i], tmp[k])
							end
						elseif ps[(j-1)*2+1] == "item" then
							table.insert(lists[i], ps[(j-1)*2+2])
						end
					end
				end
				local mult_lists = 1
				local list_n = {}
				for i = 1, #lists do
					mult_lists = mult_lists * #lists[i]
					list_n[i] = 1
				end
				for i = 1, mult_lists do
					local tmp = {}
					for j = 1, #lists do
						if j == 1 then
							table.insert(tmp, command:sub(1, pos1[j]))
						else
							table.insert(tmp, command:sub(pos2[j-1], pos1[j]))
						end
						table.insert(tmp, lists[j][list_n[j]])
					end
					table.insert(tmp, command:sub(pos2[#lists]))
					local str = table.concat(tmp)
					if str:sub(1, 1) ~= "/" then
						minetest.chat_send_all("<" .. name .. "> " .. str)
					end
					for j = 1, #minetest.registered_on_chat_messages do
						minetest.registered_on_chat_messages[j](name, str)
					end
					list_n[#list_n] = list_n[#list_n] + 1
					for j = #lists, 1, -1 do
						if list_n[j] == #lists[j] + 1 then
							list_n[j] = 1
							if j > 1 then list_n[j-1] = list_n[j-1] + 1 end
						end
					end
				end
			end
			return true
		end
		minetest.chat_send_player(name, "Invalid parameters (see /help list)")
	end,
})
minetest.register_chatcommand("tell", {
	privs = {tell=true, shout=true},
	params = "<name> <message>",
	description = "Tell the message to given player",
	func = function(name, param)
		local player_name, message = string.match(param, "^([^ ]+) *(.*)")
		if not message then
			minetest.chat_send_player(name, "Invalid parameters (see /help tell)")
			return
		end
		if minetest.env:get_player_by_name(player_name) then
			minetest.chat_send_player(player_name, "(from " .. name .. "): " .. message)
		else
			minetest.chat_send_player(name, "Player named \"" .. player_name .. "\" does not exist.")
		end
	end,
})
