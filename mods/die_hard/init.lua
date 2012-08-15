-- Minetest Die Hard Mod
-- Players lose most of their items.

math.randomseed(os.time())

-- You need to roll ONE out of ITEM_LOSE_DICE
local ITEM_LOSE_DICE = 4

minetest.register_on_dieplayer(function(player)
        local inventorylist=player:inventory_get_list("main")
        local i=1
        while inventorylist[i]~=nil do
                if math.random(1, ITEM_LOSE_DICE) ~= 1 and (inventorylist[i]~="") then
                        print(inventorylist[i])
                        local bnumbeg, bnumend=string.find(inventorylist[i], '" ')
                        local oldvalue=tonumber(string.sub(inventorylist[i], bnumend))
                        oldvalue=math.random(0,(oldvalue/3))
                        local newstring=string.sub(inventorylist[i], 1, bnumend)
                        newstring=(newstring..tostring(oldvalue))
                        if oldvalue == 0 then
                        inventorylist[i]=""
                        else
                        inventorylist[i]=newstring
                        end
                end
                i=i+1
        end
        player:inventory_set_list("main", inventorylist)
        return
end)

print("[die_hard] Loaded!")
