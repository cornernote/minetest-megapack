-- add to /buitin/builtin.lua, just below misc_register:
-- dofile(minetest.get_modpath("__builtin").."/universal_node_ownership.lua")

local function is_node_owner(meta, player)
    if meta:get_string("owner") ~= player:get_player_name() and meta:get_string("owner") ~= '' then
        return false
    end
    return true
end
local can_dig = function(pos,player)
    meta = minetest.env:get_meta(pos)
    return is_node_owner(meta, player)
end

-- copy minetest.register_node to another function so we can still call it
minetest_register_node = minetest.register_node;

-- overwrite minetest.register_node
function minetest.register_node(name, nodedef)
    if not nodedef.can_dig then nodedef.can_dig = can_dig end
    minetest_register_node(name, nodedef) -- call the real minetest.register_node
end

minetest.register_on_placenode(function(p, node, placer)
    local meta = minetest.env:get_meta(p)
    local player = placer:get_player_name()
    meta:set_string("owner",player)
end)