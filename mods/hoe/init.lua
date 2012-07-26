--[[

Textures Author: Nemo08
A lot of code author: sapier

]]--

local tool_types = { 
    {"default", "wood",   70},
    {"default", "cobble", 250},
    {"default", "steel",  320},
    {"default", "mese",   1200}
}



function farming_add_hoe_type(value)
	--print("Adding "..value[2].." hoe with durability "..value[3])

    minetest.register_craft({
        output = 'tool "hoe:'..value[2]..'_hoe"',
        recipe = {
            {'node "'..value[1]..":"..value[2]..'"', 'node "'..value[1]..":"..value[2]..'"'},
            {'', 'craft "default:stick"'},
            {'', 'craft "default:stick"'},
        }
    })

    minetest.register_tool("hoe:"..value[2].."_hoe", {
        image = "hoe_"..value[2].."hoe.png",
        basetime = 300.0,
        dt_weight = 0.2,
        dt_crackiness = 0.2,
        dt_crumbliness = 0.2,
        dt_cuttability = 0.2,
        basedurability = value[3],
        dd_weight = 0,
        dd_crackiness = 0.1,
        dd_crumbliness = 0.1,
    dd_cuttability = 0.1,
    })
end

for index,value in ipairs(tool_types) do 
    farming_add_hoe_type(value)
end


function is_hoe(toolname)

    for index,value in ipairs(tool_types) do 
	
        if toolname == "hoe:"..value[2].."_hoe" then
            return value[3]
        end
	end

    return false
end

function hoe_on_punchnode(p, node,puncher)
    local tool = puncher.get_wielded_item(puncher)
    if tool then
        local durability = is_hoe(tool.name)
        if durability then
            if (node.name == "default:dirt_with_grass") or (node.name == "default:dirt") then
                minetest.env:remove_node(p)
                minetest.env:add_node(p,{name = "wheat:dirt_bed"})
            end
            local dmg = 65535/durability -- расчет урона
            puncher:damage_wielded_item(dmg)
        end
    end
end

minetest.register_on_punchnode(hoe_on_punchnode)

print("[Hoe] Loaded!")
