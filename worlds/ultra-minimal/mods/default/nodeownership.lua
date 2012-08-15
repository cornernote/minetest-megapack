
-- this goes in builtin/misc_register.lua
local function is_node_owner(meta, player)
	if meta:get_string("owner") == '' then
		meta:set_string("owner", player:get_player_name())
	elseif meta:get_string("owner") ~= player:get_player_name() then
		return false
	end
	return true
end
local can_dig = function(pos,player)
		meta = minetest.env:get_meta(pos)
		return is_node_owner(meta, player)
	endi

-- replace the default function for this one in builtin/misc_register.lua
function minetest.register_node(name, nodedef)
	nodedef.type = "node"
	if not nodedef.can_dig then nodedef.can_dig = can_dig end
	minetest.register_item(name, nodedef)
end

-- this can go in /default/init.lua or any mod folder
minetest.register_on_placenode(function(p, node, placer)
	local meta = minetest.env:get_meta(p)
	local player = placer:get_player_name()
	meta:set_string("owner",player)
end)
