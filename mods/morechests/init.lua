-- MoreChests - Minetest mod
-- Written in 2011 by Maxim Litvinov <maxim.litvinow@gmail.com>

-- To the extent possible under law, the author(s) have dedicated all
-- copyright and related and neighboring rights to this software to the
-- public domain worldwide. This software is distributed without any
-- warranty.

-- You should have received a copy of the CC0 Public Domain Dedication
-- along with this software.
-- If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

function create_chest(chest_info)
    local name = "morechests:"..chest_info.name
    local sides = chest_info.textures.sides
    local front = chest_info.textures.front

    minetest.register_node(name, {
        tiles = {sides, sides, sides, sides, sides, front},
        inventory_image = minetest.inventorycube(sides, front, sides),
        paramtype = "facedir_simple",
        metadata_name = "generic",
        material = chest_info.material.digprop
    })


    local height = chest_info.inventory_size.height + 5
    local width = chest_info.inventory_size.width
    local slots_count = chest_info.inventory_size.height * chest_info.inventory_size.width
    local slots = {}
    for i=1,slots_count do
        slots[i] = ""
    end

    local c_x = 0
    local c_y = 0

    local p_x = 0
    local p_y = chest_info.inventory_size.height+1

    if 8 > width then
        c_x = math.ceil((8-width)/2)
        width = 8
    elseif 8 < width then
        p_x = math.ceil((width-8)/2)
    end

    minetest.register_on_placenode(function(pos, newnode, placer)
        if newnode.name == name then
            local meta = minetest.env:get_meta(pos)
            meta:inventory_set_list("store", slots)
            meta:set_inventory_draw_spec(
                "invsize["..width..","..height..";]"
                .."list[current_name;store;"..c_x..","..c_y..";"
                            ..chest_info.inventory_size.width..","..chest_info.inventory_size.height..";]"
                .."list[current_player;main;"..p_x..","..p_y..";8,4;]"
            )
            meta:set_infotext(chest_info.info)
        end
    end)

    minetest.register_craft({
        output = 'node "'..name..'" 1',
        recipe = {
            {chest_info.material.stack, chest_info.material.stack, chest_info.material.stack},
            {chest_info.material.stack, 'node "default:chest"', chest_info.material.stack},
            {chest_info.material.stack, chest_info.material.stack, chest_info.material.stack},
        }
    })
end


stone_chest = {
    name = "stonechest",
    info = "Cobble stone chest",
    textures = {
        front = "morechests_stone_chest_front.png",
        sides = "morechests_stone_side.png",
    },
    inventory_size = {
        height = 4,
        width = 8,
    },
    material = {
        stack = 'node "default:cobble"',
        digprop = minetest.digprop_stonelike(0.9),
    },
}

iron_chest = {
    name = "ironchest",
    info = "Iron chest",
    textures = {
        front = "morechests_iron_chest_front.png",
        sides = "morechests_iron_side.png",
    },
    inventory_size = {
        height = 6,
        width = 10,
    },
    material = {
        stack = 'craft "default:steel_ingot"',
        digprop = minetest.digprop_stonelike(5.0),
    },
}

mese_chest = {
    name = "mesechest",
    info = "Mese chest",
    textures = {
        front = "morechests_mese_chest_front.png",
        sides = "morechests_mese_side.png",
    },
    inventory_size = {
        height = 8,
        width = 12,
    },
    material = {
        stack = 'node "default:mese"',
        digprop = minetest.digprop_stonelike(0.5),
    },
}

create_chest(stone_chest)
create_chest(iron_chest)
create_chest(mese_chest)

