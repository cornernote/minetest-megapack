local function doorOpen(pos,node, hitter)
    --get the metadata since set_node removes it
    local meta = minetest.env:get_meta(pos)
    local name = meta:get_string("owner")
    local open = meta:get_int("open")
    local close = meta:get_int("close")
    if hitter:get_player_name() == name then
        if string.find(node.name,"Top") then
            local below = {x = pos.x, y = pos.y-1, z = pos.z}
            local belowNode = minetest.env:get_node(below)
            if node.name == "locked_door:lockedDoorTop" then
                minetest.env:set_node(pos,{name="locked_door:openDoorTop", param1=node.param1, param2 = open})
                if string.find(belowNode.name,"locked_door") then
                    minetest.env:set_node(below,{name="locked_door:openDoor", param1=belowNode.param1, param2 = open})
                end
            elseif node.name == "locked_door:openDoorTop" then
                minetest.env:set_node(pos,{name="locked_door:lockedDoorTop", param1=node.param1, param2 = close})
                if string.find(belowNode.name,"locked_door") then
                    minetest.env:set_node(below,{name="locked_door:lockedDoor", param1=belowNode.param1, param2 = close})
                end
            end
            meta:set_string("owner",name)
            meta:set_int("open",open)
            meta:set_int("close",close)
            if string.find(belowNode.name,"locked_door") then
                meta = minetest.env:get_meta(below)
                meta:set_string("owner",name)
                meta:set_int("open",open)
                meta:set_int("close",close)
            end
        else
            local above = {x = pos.x, y = pos.y+1, z = pos.z}
            local aboveNode = minetest.env:get_node(above)
            if node.name == "locked_door:lockedDoor" then
                minetest.env:set_node(pos,{name="locked_door:openDoor", param1=node.param1, param2 = open})
                if string.find(aboveNode.name,"locked_door") then
                    minetest.env:set_node(above,{name="locked_door:openDoorTop", param1=aboveNode.param1, param2 = open})
                end
            elseif node.name == "locked_door:openDoor" then
                minetest.env:set_node(pos,{name="locked_door:lockedDoor", param1=node.param1, param2 = close})
                if string.find(aboveNode.name,"locked_door") then
                    minetest.env:set_node(above,{name="locked_door:lockedDoorTop", param1=aboveNode.param1, param2 = close})
                end
            end
            meta:set_string("owner",name)
            meta:set_int("open",open)
            meta:set_int("close",close)
            if string.find(aboveNode.name,"locked_door") then
                meta = minetest.env:get_meta(above)
                meta:set_string("owner",name)
                meta:set_int("open",open)
                meta:set_int("close",close)
            end
        end
    end
end

local function doorInit(pos, placer)
    local meta = minetest.env:get_meta(pos)
    local above = {x=pos.x,y=pos.y+1,z=pos.z}
    local aboveNode = minetest.env:get_node(above) 
    if aboveNode.name ~= "air" then
        above.y = pos.y
        pos = {x=above.x,y=above.y-1,z=above.z}
        local node = minetest.env:get_node(pos)
        if  node.name ~= "air" then
            --needs to be fixed. just makes door disappear and doesn't
            --add back to inventory
            minetest.env:set_node(above,{name="locked_door:lockedDoor"})
            aboveNode = minetest.env:get_node(above)
            minetest.node_dig(above,aboveNode,placer)
            return
        end
    end
    local dir = placer:get_look_dir()
    local doorDir = minetest.dir_to_wallmounted({x=dir.x,y=0,z=dir.z})
    local doorOpenDir = minetest.dir_to_wallmounted({x=-dir.z,y=0,z=dir.x})
    minetest.env:set_node(pos,{name="locked_door:lockedDoor", nil, param2 = doorDir})
    meta:set_string("owner",placer:get_player_name())
    meta:set_int("open",doorOpenDir)
    meta:set_int("close",doorDir)
    meta = minetest.env:get_meta(above)
    minetest.env:set_node(above,{name="locked_door:lockedDoorTop", nil, param2 = doorDir})
    meta:set_string("owner",placer:get_player_name())
    meta:set_int("open",doorOpenDir)
    meta:set_int("close",doorDir)
end

local function doorDig (pos, node, digger)
    if node.name == "locked_door:openDoor" or 
       node.name == "locked_door:lockedDoor" then
        local above = {x=pos.x,y=pos.y+1,z=pos.z}
        aboveNode = minetest.env:get_node(above)
        minetest.node_dig(above,aboveNode,digger)
    else
        local below= {x=pos.x,y=pos.y-1,z=pos.z}
        belowNode = minetest.env:get_node(below)
        minetest.node_dig(below,belowNode,digger)
    end
    minetest.node_dig(pos,node,digger)
end

local lockedDoorProperties = {
    description = "locked door",
    tiles = {"locked_door_bottom.png"},
    inventory_image = "locked_door.png",
    sunlight_propagates = true, 
    paramtype="light",
    paramtype2 = "wallmounted",
    groups = {crumbly=3},
    walkable = true,
    diggable = true,
    climbable = false,
    drop = "locked_door:lockedDoor",
    drawtype = "signlike",
    on_punch = doorOpen,
    on_dig = doorDig,
    after_place_node = doorInit}

local unlockedDoorProperties = {}
local lockedDoorTopProperties = {}
local unlockedDoorTopProperties = {}
--creates a deep copy since they're all similar except
--for a couple of properties
for key, value in pairs(lockedDoorProperties) do
    unlockedDoorProperties[key] = value
    lockedDoorTopProperties[key] = value 
    unlockedDoorTopProperties[key] = value 
end
unlockedDoorProperties.walkable = false
unlockedDoorTopProperties.walkable = false
lockedDoorTopProperties.tiles = {"locked_door_top.png"}
lockedDoorTopProperties.drop = ""
unlockedDoorTopProperties.tiles = {"locked_door_top.png"}
unlockedDoorTopProperties.drop = ""


minetest.register_node("locked_door:lockedDoor", lockedDoorProperties)
minetest.register_node("locked_door:lockedDoorTop", lockedDoorTopProperties)
minetest.register_node("locked_door:openDoor", unlockedDoorProperties)
minetest.register_node("locked_door:openDoorTop", unlockedDoorTopProperties)

minetest.register_craft({
    output = "locked_door:lockedDoor",
    recipe = {
        {'default:wood', 'default:wood'},
        {'default:wood', 'default:steel_ingot'},
        {'default:wood', 'default:wood'}
    },
})
