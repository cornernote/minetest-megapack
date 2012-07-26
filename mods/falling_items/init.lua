FALLERS = {
    "default:torch",
    "mesecons_torch:mesecon_torch_off",
    "mesecons_torch:mesecon_torch_on",
}

local dx = {0, 0, 0, 0, 1, -1}
local dy = {0, 0, 1, -1, 0, 0}
local dz = {1, -1, 0, 0, 0, 0}

minetest.register_on_dignode(function (pos, node, player)
    
    
    for i = 1, 6 do
    local p = {x = pos.x + dx[i], y = pos.y + dy[i] , z = pos.z + dz[i]}
           local n = minetest.env:get_node(p)

            if n.name ~= "air" then
                for ii, faller in ipairs(FALLERS) do
                    if faller == n.name then
                        local tag = n.param2 .. dx[i] .. dy[i] .. dz[i]
                        if tag=="5001" or tag=="400-1" or tag == "1010" or tag=="00-10" or tag=="3100" or tag=="2-100"then
                            minetest.env:remove_node(p)
                            minetest.env:add_item(p, faller)
                        end
                    
                    end
                end
            end
        end
end)


