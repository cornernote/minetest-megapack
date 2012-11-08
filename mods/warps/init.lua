print (" |   | /---| /---| /---| ")
print (" | | | |___| |___/ |___/ ")
print (" |---/ |   | |   | |     ")
print (" Mod Loading ")

local write_gofile = function() 
	local output = ''						--	WRITE CHANGES TO FILE
	for name, coords in pairs(GONETWORK) do 	output = output..name..':'..coords.x..','..coords.y..','..coords.z..';'	end
		local f = io.open(minetest.get_worldpath()..'/warps.go', "w")
    f:write(output)
    io.close(f)
end
GONETWORK = {}
local f = io.open(minetest.get_worldpath()..'/warps.go', "r")  
if gonfile then
	local contents = gonfile:read()
	io.close(gonfile)
	if contents ~= nil then 
		local entries = contents:split(";") 
		for i,entry in pairs(entries) do
			local goname, coords = unpack(entry:split(":"))
			local p = {}
			p.x, p.y, p.z = string.match(coords, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
			if p.x and p.y and p.z then
				GONETWORK[goname] = {x = tonumber(p.x),y= tonumber(p.y),z = tonumber(p.z)}
			end
		end
	end
end
minetest.register_chatcommand("setwarp", {
	params = "<name>",
	description = "Set Warp to destination!!",
	privs = {privs=true},
	func = function(name, param)
		local target = minetest.env:get_player_by_name(name)
		if target then
			GONETWORK[param] = target:getpos()
			write_gofile()
			minetest.chat_send_player(name, "/warp "..param.." set!!")
			return
		end
	end,
})
minetest.register_chatcommand("warp", {
	params = "<warpname>",
	description = "go to destination",
	func = function(name, param)
		if GONETWORK[param] == nil then minetest.chat_send_player(name, "no such warp") return end
		teleportee = minetest.env:get_player_by_name(name)
		teleportee:setpos(GONETWORK[param])
	end,
})

print (" |   | /---| /---| /---| ")
print (" | | | |___| |___/ |___/ ")
print (" |---/ |   | |   | |     ")
print (" Mod Loaded!! ")
print (" Created By MadChicken13 ")
print (" Code Fron mauvebic's BookMark Mod ")