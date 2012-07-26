-- Seasons mod by xyz

-- Some constant values
-- Feel free to modify them

-- Time amount, after what ABM '' table for winter will be built
-- This is required because Minetest doesn't have function that run after all nodes were registered
local time_to_load = 5

-- How many seconds one season lasts?
local season_duration = 600
---------------------------

math.randomseed(os.time())

local season_time = 0.0
local time_file = minetest.get_modpath('seasons')..'/'..'time'
-- init seasons
local f = io.open(time_file, "r")
season_time = f:read("*n")
io.close(f)

local function pp(x, y, z)
    return "("..x.." "..y.." "..z..")"
end

local function get_season_time()
    return season_time
end

local function set_season_time(t)
    season_time = t
    -- write to file
    local f = io.open(time_file, "w")
    f:write(season_time)
    io.close(f)
end

-- spring, summer, autumn, winter
function get_season()
    if season_time < 1 then
        return "spring"
    elseif season_time < 2 then
        return "summer"
    elseif season_time < 3 then
        return "autumn"
    else
        return "winter"
    end
end

minetest.register_node("seasons:treehead", {
    tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
    inventory_image = minetest.inventorycube("default_tree_top.png", "default_tree.png", "default_tree.png"),
    is_ground_content = true,
    material = minetest.digprop_woodlike(1.0),
    drop = 'node "tree" 1', 
})

minetest.register_node("seasons:ice", {
    tiles = {"seasons_ice.png"},
    inventory_image = minetest.inventorycube("seasons_ice.png"),
    is_ground_content = true,
    material = minetest.digprop_woodlike(1.0),
    drop = '', 
})

minetest.register_node("seasons:autumn_leaves", {
    drawtype = "allfaces_optional",
    visual_scale = 1.3,
    tiles = {"seasons_autumn_leaves.png"},
    inventory_image = minetest.inventorycube("seasons_autumn_leaves.png"),
    paramtype = "light",
    material = minetest.digprop_leaveslike(0.5),
    drop = ''
})

minetest.register_node("seasons:snow", {
    drawtype = "signlike",
    tiles = {"seasons_snow.png"},
    inventory_image = "seasons_snow.png",
    paramtype = "light",
    is_ground_content = true,
    wall_mounted = true,
    walkable = false,
    selection_box = {
        type = "wallmounted",
    },
    material = minetest.digprop_dirtlike(0.4),
    drop = ''
})

minetest.register_on_generated(function(minp, maxp)
    -- replace top tree block with TREEHEAD
    -- TODO: it should definetly be done in sources
    for x = minp.x, maxp.x do
        for z = minp.z, maxp.z do
            for ly = minp.y, maxp.y do
                -- TODO: fix that
                local y = maxp.y + minp.y - ly
                if minetest.env:get_node({x = x, y = y, z = z}).name == "default:tree" then
                    --print("New treenode at "..pp(x, y, z))
                    minetest.env:add_node({x = x, y = y, z = z}, {name = "seasons:treehead"})
                    local ny = y - 1
                    local t_node = minetest.env:get_node({x = x, y = ny, z = z})
                    while t_node.name == "default:tree" or t_node.name == "seasons:treehead" do
                        -- if there is already treehead below me, it should be removed
                        if t_node.name == "seasons:treehead" then
                            minetest.env:add_node({x = x, y = ny, z = z}, {name = "tree"})
                            --print("Old treehead removed at "..pp(x, y, z))
                        end
                        ny = ny - 1
                        t_node = minetest.env:get_node({x = x, y = ny, z = z})
                    end
                    break
                else
                end
            end
        end
    end
end)

local delta = 0.0
minetest.register_globalstep(function(dtime)
    delta = delta + dtime
    if delta > 5 then
        set_season_time(get_season_time() + delta / season_duration)
        if get_season_time() >= 4 then
            set_season_time(get_season_time() - 4)
        end
        --print(get_season().." "..get_season_time())
        delta = 0
    end
end)

-- leaves become orange in autumn
minetest.register_abm({
    nodenames = {"default:leaves"},
    neighbors = {"air", "seasons:autumn_leaves"},
    interval = 5.0,
    chance = 10,
    action = function(pos, node)
        -- FIXME: remove math.random, chance should hold it
        if get_season() == "autumn" and math.random(10) == 1 then
            minetest.env:remove_node(pos)
            minetest.env:add_node(pos, {name = "seasons:autumn_leaves"})
        end
    end
})

-- leaves fall in autumn
minetest.register_abm({
    nodenames = {"seasons:autumn_leaves"},
    neighbors = {"air"},
    interval = 5.0,
    chance = 10,
    action = function(pos, node)
        if get_season() == "autumn" then
            -- TODO: leaves should faaaall, like falling nodes
            -- FIXME: chance shoudl hold math.random
            if get_season_time() > 2.7 and math.random(10) == 1 then
                minetest.env:remove_node(pos)
            end
        end
    end
})

local function sign(x)
    if x > 0 then
        return 1
    elseif x < 0 then 
        return -1
    else 
        return 0
    end
end

-- leaves grow in spring
-- TODO: refactor this afwul cycle
-- (maybe) shuffle something?
minetest.register_abm({
    nodenames = {"seasons:treehead"},
    interval = 5.0,
    chance = 10,
    action = function(pos, node)
        if get_season() == "spring" then
            --print("Spring time!")
            local modcnt = 0
            for x = -2,2 do
            for y = -1,2 do
            for z = -2,2 do
                local n_pos = {x = pos.x + x, y = pos.y + y, z = pos.z + z}
                if minetest.env:get_node(n_pos).name == "air" then
                    for dx = -1,1 do
                    for dy = -1,1 do
                    for dz = -1,1 do
                        if (math.abs(sign(dx)) + math.abs(sign(dy)) + math.abs(sign(dz)) == 1) then
                        else
                            local d_pos = {x = n_pos.x + dx, y = n_pos.y + dy, z = n_pos.z + dz}
                            local d_node = minetest.env:get_node(d_pos)
                            if d_node.name == "default:leaves" or d_node.name == "seasons:treehead" then
                                if math.random(30) == 1 then
                                    modcnt = modcnt + 1
                                    minetest.env:add_node(n_pos, {name = "default:leaves"})
                                    if modcnt == 5 then
                                        return
                                    end
                                end
                            end
                        end
                    end
                    end
                    end
                end
            end
            end
            end
        end
    end
})

minetest.register_abm({
    nodenames = {"default:leaves", 'default:stone', 'default:dirt', 'default:dirt_with_grass', 'default:sand', 'default:gravel', 'default:sandstone',
                 'default:clay', 'default:brick', 'default:tree', 'seasons:treehead', 'default:jungletree', 'default:cactus', 'default:glass',
                 'default:wood', 'default:cobble', 'default:mossycobble'},
    neighbors = {"air"},
    interval = 5.0,
    chance = 1,
    action = function(pos, node)
        if get_season() ~= "winter" then
            return
        end
        local t_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
        if minetest.env:get_node(t_pos).name == "air" and minetest.env:get_node_light(t_pos, 0.5) == 15 then
            -- Grow snow!
            if math.random(17 - math.pow(get_season_time(), 2)) == 1 then
                --print("Growing snow")
                minetest.env:add_node(t_pos, {name = 'seasons:snow', param2 = 8})
            end
        end
    end
})

minetest.register_abm({
    -- FIXME: need better way (like getting block temperature?)
    nodenames = {'default:water_source', 'seasons:ice'},
    neighbors = {"air"},
    interval = 5.0,
    chance = 1,
    action = function(pos, node)
        if get_season() ~= "winter" then
            return
        end
        local t_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
        if minetest.env:get_node(t_pos).name == "air" and minetest.env:get_node_light(t_pos, 0.5) == 15 then
            -- Grow ice on water!
            if math.random(5) == 1 then
                if node.name == "seasons:ice" then
                    return
                end
                minetest.env:add_node(pos, {name = 'seasons:ice'})
            end
        end
    end
})

-- Remove snow which has air below it
minetest.register_abm({
    nodenames = {"seasons:snow"},
    interval = 1.0,
    chance = 1,
    action = function(pos, node)
        local b_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
        if minetest.env:get_node(b_pos).name == "air" or get_season() ~= "winter" then
            --print('Killing snow')
            minetest.env:remove_node(pos)
        end
    end
})

minetest.register_abm({
    nodenames = {"seasons:ice"},
    interval = 1.0,
    chance = 1,
    action = function(pos, node)
        if get_season() == "winter" then
            return
        end
        if get_season_time() <= 0.2 then
            -- slooowly remove ice
            if math.random(4) == 1 then
                minetest.env:add_node(pos, {name = 'default:water_source'})
            end
        else
            minetest.env:add_node(pos, {name = 'default:water_source'})
        end
    end
})

minetest.register_on_dignode(function(pos, oldnode, digger)
    if oldnode.name == "seasons:ice" then
        minetest.env:add_node(pos, {name = "default:water_source"})
    end
end)

minetest.register_abm({
    nodenames = {"default:leaves"},
    interval = 3.0,
    chance = 1,
    action = function(pos, node)
        if get_season() == "winter" then
            minetest.env:remove_node(pos)
        end
    end
})

minetest.register_abm({
    nodenames = {"seasons:autumn_leaves"},
    interval = 3.0,
    chance = 1,
    action = function(pos, node)
        if get_season() ~= "autumn" then
            minetest.env:remove_node(pos)
        end
    end
})
