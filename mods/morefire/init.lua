-- fire
-- Mod for Minetest 0.4
-- Licensed under the GNU GPLv3

-- Replace a burnable node by fire node
-- Spread the fire nodes on all the birnable nodes in radius by ABM
-- Destroy the fire nodes by ABM

-- TODO:
-- lighter
-- bomb

local FIRE_SPREAD_DELAY = 7
local FIRE_DISAPPEAR_DELAY = 8
local SMOKE_DISAPPEAR_DELAY = 8
local SMOKE_COLLISION_BOX = 1

local SMOKELESS = false

math.randomseed(os.time())

-- ENTITIES

-- Smoke entity
minetest.register_entity( "morefire:smoke_ent", {
    physical = false,
    textures = { "fire_smoke.png" },
    timer = 0,
    death_timer = 0,

    on_activate = function(self, staticdata)
        self.death_timer = math.random(3, 10)
    end,

    on_step = function(self, dtime)
        self.timer = self.timer + dtime
        if(self.timer >= self.death_timer)
        or minetest.env:get_node(self.object:getpos()).name ~= "air" then
            self.object:remove()
        end
    end
})

-- Fire entity
minetest.register_entity( "morefire:fire_ent", {
    physical = false,
    --visual = "cube",
    textures = {
        "fire_fire.png",
        "fire_fire.png",
        "fire_fire.png",
        "fire_fire.png",
        "fire_fire.png",
        "fire_fire.png",
    },
    timer = 0,
    smoke_timer = 0,
    burntime = 0,
    spread = true,

    on_activate = function(self, staticdata)
        local old_node = minetest.env:get_node(self.object:getpos())
        self.burntime = minetest.registered_nodes[old_node.name].material.cuttability
        minetest.env:remove_node(self.object:getpos())
        minetest.env:add_node(self.object:getpos(), {name = "morefire:fire_transp"})
    end,

    on_step = function(self, dtime)
        self.timer = self.timer + dtime
        self.smoke_timer = self.smoke_timer + dtime
        if (self.timer > self.burntime) then
            minetest.env:remove_node(self.object:getpos())
            self.object:remove()
        elseif (self.timer >= self.burntime / 2) and self.spread then
            for i = -1, 1 do
            for j = -1, 1 do
            for k = -1, 1 do
                if (math.abs(i) + math.abs(j) + math.abs(k) == 1) then
                    local new_pos = {
                        x = self.object:getpos().x + i,
                        y = self.object:getpos().y + j,
                        z = self.object:getpos().z + k
                    }
                    burn(new_pos)
                end
            end
            end
            end
            self.spread = false
        end
	if SMOKELESS == false then
	    if(self.smoke_timer > 2) then
		create_smoke(self.object:getpos())
		self.smoke_timer = 0
	    end
	end
    end
})

-- NODES

-- Fire (transparent)
minetest.register_node("morefire:fire_transp", {
    drawtype = "plantlike",
    paramtype = "light",
    visual_scale = 0,
    buildable_to = false,
    tiles = { "fire_fire_transp.png" },
    is_ground_content = true,
    walkable = false,
    pointable = false,
    sunlight_propagates = true,
    damage_per_second = 6,
    light_source = 13,
    post_effect_color = {a = 180, r = 255, g = 0, b = 0}
})

-- CRAFTITEMS

-- Match
minetest.register_craftitem("morefire:match", {
    description = "Match",
    inventory_image = "fire_match.png",
    stack_max = 99,

    on_use = function(itemstack, player, pointed_thing)
        if pointed_thing.type == "node" then
            print("[fire] Match used on (" .. pointed_thing.under.x .. ',' .. pointed_thing.under.y .. ',' .. pointed_thing.under.z .. ')')
            if(math.random(1, 6) ~= 1) then
                if burn(pointed_thing.under) then
		    itemstack:take_item()
		end
            else
		itemstack:take_item()
            end
        end
        return itemstack
    end
})

-- Match box
minetest.register_craftitem("morefire:match_box", {
    description = "Match box",
    inventory_image = "fire_match_box.png",
    stack_max = 99
})

-- CRAFTS

-- Crafting match
minetest.register_craft({
    output = 'morefire:match 10',
    recipe = {
        {'default:coal_lump' },
        {'default:stick' },
        {'default:stick' },
    }
})

-- Crafting match box
minetest.register_craft({
    output = 'morefire:match_box 1',
    recipe = {
        { 'morefire:match', 'morefire:match', 'morefire:match' },
        { 'morefire:match', 'morefire:match', 'morefire:match' },
        { 'morefire:match', 'morefire:match', 'morefire:match' },
    }
})
minetest.register_craft({
    output = 'morefire:match 9',
    recipe = {
        { 'morefire:match_box' }
    }
})


-- Additional modules
dofile(minetest.get_modpath("morefire") .. "/api.lua")
dofile(minetest.get_modpath("morefire") .. "/bomb.lua")
dofile(minetest.get_modpath("morefire") .. "/deprecated_remove.lua")
