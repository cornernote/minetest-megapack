addore = function(mn,oreName, oreDescription, oreTexture, oreMaterial,
                  digTools, 
                  maxAmountForChunk, rarity, size,
                  minY, maxY,
                  dropName, dropDescription, dropTexture, dropAmount)

    local ore = mn .. ":" .. oreName
    local oreNode = {
        description = oreDescription,
        tiles = {oreTexture},
        is_ground_content = true,
        material = oreMaterial
    }
    if dropName ~= nil then
        local drop = ""
        if dropName ~= "" then
            drop = mn .. ":" .. dropName
            minetest.register_craftitem(drop, {
                description = dropDescription,
                image = dropTexture
            })
        end
        oreNode["drop"] = {
            max_items = 1,
            items = {
                {
                    items = {drop.." "..dropAmount},
                    tools = digTools
                }
            }
        }
    end
    minetest.register_node(ore, oreNode)
    local gen = function(minp,maxp)
        if minp.y < minY or maxp.y > maxY or math.random(1, rarity) ~= 1 then 
            return 
        end

        for a = 0, maxAmountForChunk do
            local pos = {
                x = math.random( minp.x, maxp.x ),
                y = math.random( minp.y, maxp.y ),
                z = math.random( minp.z, maxp.z ),
            }
            for i = -1, size.x - 1 do
                for j = -1, size.y - 1 do
                    for k = -1, size.z - 1 do
                        if math.random(1, 5) > 2 then
                        else
                            local p = {x = pos.x + i, y = pos.y + j, z = pos.z + k}
                            local n = minetest.env:get_node(p)
                            if n.name == "default:stone" then
                                minetest.env:add_node(p, {name = ore})
                            end
                        end
                    end
                end
            end
        end
    end
    minetest.register_on_generated(gen)
end


--[[ example
addore("check_ore","BAD ORE",
                "check_ore.png",minetest.digprop_stonelike(1.4),
                nil, -- any tool
                50,
                1,{
                    x = 1,
                    y = 1,
                    z = 1,
                },
                -31000,100)
]]--


-- quick iron add
local gen = function(minp,maxp)
    if minp.y < -31000 or maxp.y > -120 or math.random(1, 8) ~= 1 then 
        return 
    end

    for a = 0, 2 do
        local pos = {
            x = math.random( minp.x, maxp.x ),
            y = math.random( minp.y, maxp.y ),
            z = math.random( minp.z, maxp.z ),
        }
        for i = -1, 4 - 1 do
            for j = -1, 3 - 1 do
                for k = -1, 3 - 1 do
                    if math.random(1, 5) > 2 then
                    else
                        local p = {x = pos.x + i, y = pos.y + j, z = pos.z + k}
                        local n = minetest.env:get_node(p)
                        if n.name == "default:stone" then
                            minetest.env:add_node(p, {name = "default:stone_with_iron"})
                        end
                    end
                end
            end
        end
    end
end
minetest.register_on_generated(gen)
