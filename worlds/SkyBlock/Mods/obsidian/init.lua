minetest.register_node("obsidian:obsidian_block", {
    tile_images = {"obsidian_block.png"},
    inventory_image = minetest.inventorycube("obsidian_block.png"),
    is_ground_content = true,
    material = minetest.digprop_glasslike(5.0), -- obsidian is hard, but brittle
    drop = {
        max_items = 1,
        items = {
            {
                -- player will get shard with 1/20 chance
                items = {'obsidian:obsidian_shard'},
                rarity = 2,
            },
            {
                items = {'obsidian:obsidian_block'},
            }
        }
    },
})

minetest.register_craftitem("obsidian:obsidian_shard", {
    image = "obsidian_shard.png",
    on_place_on_ground = craftitem_place_item,
})

minetest.register_craft({
    output = 'obsidian:obsidian_knife',
    recipe = {
        {'obsidian:obsidian_shard'},
        {'default:stick'},
    }
})

minetest.register_tool("obsidian:obsidian_knife", {
    image = "obsidian_knife.png",
    basetime = 1.0,
    dt_weight = 0.5,
    dt_crackiness = 2,
    dt_crumbliness = 4,
    dt_cuttability = -0.5,
    basedurability = 80,
    dd_weight = 0,
    dd_crackiness = 0,
    dd_crumbliness = 0,
    dd_cuttability = 0,
})

minetest.register_abm({nodenames = {"default:lava_source"},
    interval = 1.0,
    chance = 1,
    action = function(pos, node, active_obsidianject_count, active_obsidianject_count_wider)
            for i=-1,1 do
            for j=-1,1 do
            for k=-1,1 do
        p = {x=pos.x+i, y=pos.y+j, z=pos.z+k}
        n = minetest.env:get_node(p)
        if (n.name=="default:water_flowing") or (n.name == "default:water_source") then
            minetest.env:add_node(pos, {name="obsidian:obsidian_block"})
                end
            end
        end
    end
end
})

minetest.register_abm({nodenames = {"default:lava_flowing"},
    interval = 1.0,
    chance = 1,
    action = function(pos, node, active_obsidianject_count, active_obsidianject_count_wider)
            for i=-1,1 do
            for j=-1,1 do
            for k=-1,1 do
                p = {x=pos.x+i, y=pos.y+j, z=pos.z+k}
                n = minetest.env:get_node(p)
                if (n.name=="default:water_flowing") or (n.name == "default:water_source") then
                    if (j==-1) then
            minetest.env:add_node({x=pos.x, y=pos.y-1, z=pos.z}, {name="cobble"})
                    else
            minetest.env:add_node(pos, {name="cobble"})
                    end
                end
            end
        end
    end
end
})


-- Crafting

minetest.register_craft({
    output = 'obsidian:obsidian_sword',
    recipe = {
        {'obsidian:obsidian_blade'},
        {'obsidian:obsidian_blade'},
        {'default:stick'},
    }
})
minetest.register_craft({
    output = 'obsidian:obsidian_axe',
    recipe = {
        {'obsidian:obsidian_block', 'obsidian:obsidian_block'},
        {'obsidian:obsidian_block', 'default:stick'},
        {'', 'default:stick'},
    }
})
minetest.register_craft({
    output = 'obsidian:obsidian_shovel',
    recipe = {
        {'obsidian:obsidian_block'},
        {'default:stick'},
        {'default:stick'},
    }
})
minetest.register_craft({
    output = 'obsidian:obsidian_pick',
    recipe = {
        {'obsidian:obsidian_block', 'obsidian:obsidian_block', 'obsidian:obsidian_block'},
        {'', 'default:stick', ''},
        {'', 'default:stick', ''},
    }
})




-- tools
minetest.register_tool("obsidian:obsidian_sword", {
    image = "os.png",
    basetime = 0,
    dt_weight = 3,
    dt_crackiness = 0,
    dt_crumbliness = 1,
    dt_cuttability = -10,
    basedurability = 1000,
    dd_weight = 0,
    dd_crackiness = 0,
    dd_crumbliness = 0,
    dd_cuttability = 0,
})
minetest.register_tool("obsidian:obsidian_shovel", {
    image = "osh.png",
    basetime = 0,
    dt_weight = 0.5,
    dt_crackiness = 2,
    dt_crumbliness = -1.5,
    dt_cuttability = 0.0,
    basedurability = 330,
    dd_weight = 0,
    dd_crackiness = 0,
    dd_crumbliness = 0,
    dd_cuttability = 0,
})
minetest.register_tool("obsidian:obsidian_pick", {
    image = "op.png",
    basetime = 0,
    dt_weight = 0,
    dt_crackiness = -0.5,
    dt_crumbliness = 2,
    dt_cuttability = 0,
    basedurability = 333,
    dd_weight = 0,
    dd_crackiness = 0,
    dd_crumbliness = 0,
    dd_cuttability = 0,
})
minetest.register_tool("obsidian:obsidian_axe", {
    image = "ob.png",
    basetime = 0,
    dt_weight = 3,
    dt_crackiness = 0,
    dt_crumbliness = 1,
    dt_cuttability = -10,
    basedurability = 1000,
    dd_weight = 0,
    dd_crackiness = 0,
    dd_crumbliness = 0,
    dd_cuttability = 0,
})

minetest.register_node("obsidian:fence_obsidian", {
    description = "Obsidian Fence",
    drawtype = "fencelike",
    tile_images = {"obsidian_block.png"},
    inventory_image = "obsidian_fence.png",
    wield_image = "obsidian_fence.png",
    paramtype = "light",
    is_ground_content = true,
    selection_box = {
        type = "fixed",
        fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
    },
    material = minetest.digprop_glasslike(5.0),
})
minetest.register_craft({
    output = 'tool "obsidian:fence_obsidian"',
    recipe = {
            {'node "obsidian:obsidian_block"', 'node "obsidian:obsidian_block"', 'node "obsidian:obsidian_block"'},
            {'node "obsidian:obsidian_block"', 'node "obsidian:obsidian_block"', 'node "obsidian:obsidian_block"'},
    }
})
minetest.register_node("obsidian:obsidian_ladder", {
    description = "Obsidian Ladder",
    drawtype = "signlike",
    tile_images = {"obsidian_ladder.png"},
    inventory_image = "obsidian_ladder.png",
    wield_image = "obsidian_ladder.png",
    paramtype = "light",
    paramtype2 = "wallmounted",
    is_ground_content = true,
    walkable = false,
    climbable = true,
    selection_box = {
        type = "wallmounted",
        --wall_top = = <default>
        --wall_bottom = = <default>
        --wall_side = = <default>
    },
    material = minetest.digprop_glasslike(5.0),
    legacy_wallmounted = true,
})
minetest.register_craft({
    output = 'obsidian:obsidian_ladder',
    recipe = {
        {'obsidian:obsidian_block', '', 'obsidian:obsidian_block'},
        {'obsidian:obsidian_block', 'obsidian:obsidian_block', 'obsidian:obsidian_block'},
        {'obsidian:obsidian_block', '', 'obsidian:obsidian_block'},
    }
})
minetest.register_craftitem("obsidian:obsidian_blade", {
    image = "obsidian_blade.png",
    on_place_on_ground = craftitem_place_item,
})
minetest.register_craft({
    output = 'obsidian:obsidian_blade',
    recipe = {
        {'', 'obsidian:obsidian_shard', ''},
        {'', 'obsidian:obsidian_shard', ''},
    }
})

--        end
--        return false
--    end,
--