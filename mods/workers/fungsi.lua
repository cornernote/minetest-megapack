--[[
Workers Mod
By LocaL_ALchemisT (prof_awang@yahoo.com)
License: WTFPL
Version: 2.0
--]]

worker_images = function(name)
	return {name.."_body.png", name.."_body.png", name.."_left.png",name.."_right.png", name.."_back.png", name.."_front.png"}
end

dir = {
	[0] = function(p) return {x=p.x,y=p.y,z=p.z-1} end, --back
	[1] = function(p) return {x=p.x-1,y=p.y,z=p.z} end, --left
	[2] = function(p) return {x=p.x,y=p.y,z=p.z+1} end, --front
	[3] = function(p) return {x=p.x+1,y=p.y,z=p.z} end, --right
}

peek = function(p,name)
	if minetest.env:get_node(p).name == name then return true
	else return false end
end

faceTo = function(p,n,lim)
	if peek(dir[n](p),"air") then return {pos = dir[n](p),face = n} end
	n = n+1
	lim = lim+1
	if n > 3 then n = 0 end
	if lim < 4 then return faceTo(p,n,lim)
	else return nil end
end

anticlockwise = function(p,n)
	local n2 = n-1
	if n2 < 0 then n2 = 3 end
	if peek(dir[n2](p),"air") then return {pos = dir[n2](p),face = n2}
	else
		if peek(dir[n](p),"air") then return {pos = dir[n](p),face = n2}
		else return nil end
	end
end

clockwise = function(p,n)
	local n2 = n+1
	if n2 > 3 then n2 = 0 end
	if peek(dir[n2](p),"air") then return {pos = dir[n2](p),face = n2}
	else
		if peek(dir[n](p),"air") then return {pos = dir[n](p),face = n2}
		else return nil end
	end
end

shouldFall = function(p)
	local np = {x=p.x,y=p.y-1,z=p.z}
	if peek(np,"air") or peek(np,"default:water_source") or peek(np,"default:water_flowing") then return shouldFall(np)
	else return p end
end

shouldFall_miner = function(p)
	local np = {x=p.x,y=p.y-1,z=p.z}
	if peek(np,"air") then
		local np2 = {x=np.x-1,y=np.y,z=np.z}
		if peek(np2,"air") then minetest.env:add_node(np2,{name="default:ladder",param2=3}) end
		return shouldFall_miner(np)
	elseif peek(np,"default:water_source") or peek(np,"default:water_flowing") then return shouldFall(np)
	else return p end
end

shouldRise = function(p)
	local np = {x=p.x,y=p.y+1,z=p.z}
	if peek(np,"air") or peek(np,"default:water_source") or peek(np,"default:water_flowing") then return np
	else return shouldRise(np) end
end

get_ore = function(node)
	local drops = minetest.get_node_drops(node,"default:pick_mese")
	local _, dropped_item
	for _, dropped_item in ipairs(drops) do
		return dropped_item
	end
end

defend = function(player,master,worker)
	minetest.chat_send_player(player:get_player_name(), worker..": You are not "..master.."!")
	minetest.chat_send_player(master, worker..": Master, "..player:get_player_name().." punched me!")
	player:set_hp(player:get_hp()-6)
end

speak = function(player,text)
	minetest.chat_send_player(player,text)
	print(text)
end