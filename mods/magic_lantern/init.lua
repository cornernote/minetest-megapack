local LANTERN_NODES = {}
local LIGHT_THRESHOLD_NIGHT = 4
local LIGHT_THRESHOLD_DAY = 10

for i = 0, LIGHT_MAX do
    table.insert(LANTERN_NODES, 'magic_lantern:magic_lantern_' .. i)
end

-- Functions
minetest.register_abm({
    nodenames = LANTERN_NODES,
    interval = 6,
    chance = 1,
    action = function(pos, node, _, __)
        local aname = node.name

        minetest.env:remove_node(pos)
        local l = minetest.env:get_node_light(pos, nil) - 1

        if l == nil then
            l = 0
        end

        if l < LIGHT_THRESHOLD_NIGHT then
            l = 0
        elseif l > LIGHT_THRESHOLD_DAY then
            l = LIGHT_MAX
        end

         local nname = 'magic_lantern:magic_lantern_' .. (LIGHT_MAX - l)

        minetest.env:add_node(pos, { name = nname })
    end
})

-- Nodes
for i, ml in ipairs(LANTERN_NODES) do
    minetest.register_node(ml, {
        tiles = { 'magic_lantern_' .. (i - 1) .. '.png' },
        inventory_image = 'magic_lantern_' .. (i - 1) .. '.png',
        drawtype = 'glasslike',
        paramtype = "light",
        walkable = true,
        sunlight_propagates = true,
        light_source = i - 1,
        material = minetest.digprop_glasslike(2.0),
        furnace_burntime = 4,
    })
end

-- Crafts
minetest.register_craft({
    output = 'NodeItem "magic_lantern:magic_lantern_0" 1',
    recipe = {
        {'node "default:glass" 1', 'node "default:glass" 1', 'node "default:glass" 1'},
        {'node "default:glass" 1', 'node "default:torch" 1', 'node "default:glass" 1'},
        {'node "default:glass" 1', 'node "default:glass" 1', 'node "default:glass" 1'},
    },
})
