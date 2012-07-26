--flatland mod
--by kddekadenz


--VARIABLES

n_top = "default:dirt_with_grass"
n_dn = "default:dirt"
lvl = 2


--CUSTOMIZING

--TODO: add possibility to change level ingame (previous tries made the game crash)
--TODO: prevent game from crashing when typing false name

minetest.register_on_chat_message(function(name, message, playername, player)
    local cmd = "/nt"
    if message:sub(0, #cmd) == cmd then
	nodet = string.match(message, cmd.." (.*)")
	if nodet ~= nil then
	n_top = nodet
	minetest.chat_send_player(name, "Node at level setted to: " ..nodet)
	return true
	end
	minetest.chat_send_player(name, 'usage: '..cmd..'node at level')
	return true
    end
end)


minetest.register_on_chat_message(function(name, message, playername, player)
    local cmd = "/nd"
    if message:sub(0, #cmd) == cmd then
	noded = string.match(message, cmd.." (.*)")
	if noded ~= nil then
	n_dn = noded
	minetest.chat_send_player(name, "Node below level setted to: " ..noded)
	return true
	end
	minetest.chat_send_player(name, 'usage: '..cmd..'node below level')
	return true
    end
end)


minetest.register_on_chat_message(function(name, message, playername, player)
    local cmd = "/water"
    if message:sub(0, #cmd) == cmd then
	n_top = "water_source"
	n_dn = "water_source"
	minetest.chat_send_player(name, "Enabled ocean mode")
	return true
    end
end)


minetest.register_on_chat_message(function(name, message, playername, player)
    local cmd = "/cloud"
    if message:sub(0, #cmd) == cmd then
	n_top = "cloud"
	n_dn = "air"
	minetest.chat_send_player(name, "Enabled cloud mode")
	return true
    end
end)


minetest.register_on_chat_message(function(name, message, playername, player)
    local cmd = "/glass"
    if message:sub(0, #cmd) == cmd then
	n_top = "glass"
	n_dn = "air"
	minetest.chat_send_player(name, "Enabled glass mode")
	return true
    end
end)

minetest.register_on_chat_message(function(name, message, playername, player)
    local cmd = "/sand"
    if message:sub(0, #cmd) == cmd then
	n_top = "sand"
	n_dn = "sand"
	minetest.chat_send_player(name, "Enabled sand mode")
	return true
    end
end)

minetest.register_on_chat_message(function(name, message, playername, player)
    local cmd = "/grass"
    if message:sub(0, #cmd) == cmd then
	n_top = "dirt_with_grass"
	n_dn = "dirt"
	minetest.chat_send_player(name, "Enabled grass mode")
	return true
    end
end)



--GENERATING

minetest.register_on_generated(function(minp, maxp)
--	if minetest.setting_getbool("flatland") then
		for x = minp.x, maxp.x do
			for z = minp.z, maxp.z do
				for ly = minp.y, maxp.y do
				local y = maxp.y + minp.y - ly
				local p = {x = x, y = y, z = z}
						if y == lvl then
						minetest.env:add_node(p, {name=n_top})
						end
							if y < lvl then
							minetest.env:add_node(p, {name=n_dn})
							end
				end
			end
		end
--	end
end)

minetest.register_on_generated(function(minp, maxp)
--	if minetest.setting_getbool("flatland") then
		for x = minp.x, maxp.x do
			for z = minp.z, maxp.z do
				for ly = minp.y, maxp.y do
				local y = maxp.y + minp.y - ly
				local p = {x = x, y = y, z = z}
					if y > lvl then
					minetest.env:remove_node(p)
					end
				end
			end
		end
--	end
end)
