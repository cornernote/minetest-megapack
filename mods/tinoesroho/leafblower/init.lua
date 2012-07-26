-- LeafBlower by tinoesroho
-- Based on nuke
function activate_if_tnt(nname, np, tnt_np, tntr)
    if nname == "experimental:tnt" or nname == "nuke:iron_tnt" or nname == "nuke:mese_tnt" or nname == "nuke:hardcore_iron_tnt" or nname == "nuke:hardcore_mese_tnt" then
        local e = minetest.env:add_entity(np, nname)
        e:setvelocity({x=(np.x - tnt_np.x)*3+(tntr / 4), y=(np.y - tnt_np.y)*3+(tntr / 3), z=(np.z - tnt_np.z)*3+(tntr / 4)})
    end
end

function do_tnt_physics(tnt_np,tntr)
    local objs = minetest.env:get_objects_inside_radius(tnt_np, tntr)
    for k, obj in pairs(objs) do
        local oname = obj:get_entity_name()
        local v = obj:getvelocity()
        local p = obj:getpos()
        if oname == "experimental:tnt" or oname == "nuke:iron_tnt" or oname == "nuke:mese_tnt" or oname == "nuke:hardcore_iron_tnt" or oname == "nuke:hardcore_mese_tnt" then
            obj:setvelocity({x=(p.x - tnt_np.x) + (tntr / 2) + v.x, y=(p.y - tnt_np.y) + tntr + v.y, z=(p.z - tnt_np.z) + (tntr / 2) + v.z})
        else
            if v ~= nil then
                obj:setvelocity({x=(p.x - tnt_np.x) + (tntr / 4) + v.x, y=(p.y - tnt_np.y) + (tntr / 2) + v.y, z=(p.z - tnt_np.z) + (tntr / 4) + v.z})
            else
                if obj:get_player_name() ~= nil then
                    obj:set_hp(obj:get_hp() - 1)
                end
            end
        end
    end
end

minetest.register_craft({
	output = 'node "leafblower:bomb" ',
	recipe = {
		{'','node "default:leaves" 1',''},
		{'craft "default:steel_ingot" 1','craft "default:coal_lump" 1','craft "default:steel_ingot" 1'},
		{'','node "default:leaves" 1',''}
	}
})
minetest.register_node("leafblower:bomb", {
	tile_images = {"nuke_iron_tnt_top.png", "nuke_iron_tnt_bottom.png",
			"nuke_iron_tnt_side.png", "nuke_iron_tnt_side.png",
			"nuke_iron_tnt_side.png", "nuke_iron_tnt_side.png"},
	inventory_image = minetest.inventorycube("nuke_iron_tnt_top.png",
			"nuke_iron_tnt_side.png", "nuke_iron_tnt_side.png"),
	dug_item = '', -- Get nothing
	material = {
		diggability = "not",
	},
})

minetest.register_on_punchnode(function(p, node)
	if node.name == "leafblower:bomb" then
		minetest.env:remove_node(p)
		minetest.env:add_entity(p, "leafblower:bomb")
		nodeupdate(p)
	end
end)

local IRON_TNT_RANGE = 100
local IRON_TNT = {
	-- Static definition
	physical = true, -- Collides with things
	-- weight = 5,
	collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
	visual = "cube",
	textures = {"nuke_iron_tnt_top.png", "nuke_iron_tnt_bottom.png",
			"nuke_iron_tnt_side.png", "nuke_iron_tnt_side.png",
			"nuke_iron_tnt_side.png", "nuke_iron_tnt_side.png"},
	-- Initial value for our timer
	timer = 0,
	-- Number of punches required to defuse
	health = 1,
	blinktimer = 0,
	blinkstatus = true,
}

function IRON_TNT:on_activate(staticdata)
	self.object:setvelocity({x=0, y=4, z=0})
	self.object:setacceleration({x=0, y=-10, z=0})
	self.object:settexturemod("^[brighten")
end

function IRON_TNT:on_step(dtime)
	self.timer = self.timer + dtime
	self.blinktimer = self.blinktimer + dtime
    if self.timer>5 then
        self.blinktimer = self.blinktimer + dtime
        if self.timer>8 then
            self.blinktimer = self.blinktimer + dtime
            self.blinktimer = self.blinktimer + dtime
        end
    end
	if self.blinktimer > 0.5 then
		self.blinktimer = self.blinktimer - 0.5
		if self.blinkstatus then
			self.object:settexturemod("")
		else
			self.object:settexturemod("^[brighten")
		end
		self.blinkstatus = not self.blinkstatus
	end
	if self.timer > 10 then
		local pos = self.object:getpos()
        pos.x = math.floor(pos.x+0.5)
        pos.y = math.floor(pos.y+0.5)
        pos.z = math.floor(pos.z+0.5)
        do_tnt_physics(pos, IRON_TNT_RANGE)
        if minetest.env:get_node(pos).name == "default:water_source" or minetest.env:get_node(pos).name == "default:water_flowing" then
            -- Cancel the Explosion
            self.object:remove()
            return
        end
        for x=-IRON_TNT_RANGE,IRON_TNT_RANGE do
        for y=-IRON_TNT_RANGE,IRON_TNT_RANGE do
        for z=-IRON_TNT_RANGE,IRON_TNT_RANGE do
            if x*x+y*y+z*z <= IRON_TNT_RANGE * IRON_TNT_RANGE + IRON_TNT_RANGE then
                local np={x=pos.x+x,y=pos.y+y,z=pos.z+z}
                local n = minetest.env:get_node(np)
                if n.name == "leaves" or n.name == "blossom" or n.name == "nature:blossom" or n.name == "default:jungletree" or n.name == "default:junglegrass" or n.name == "default:leaves"  or n.name == "default:apple" or n.name == "default:cactus" then
                   minetest.env:remove_node(np)
                end
                activate_if_tnt(n.name, np, pos, IRON_TNT_RANGE)
            end
        end
        end
        end
		self.object:remove()
	end
end

function IRON_TNT:on_punch(hitter)
	self.health = self.health - 1
	if self.health <= 0 then
		self.object:remove()
		hitter:add_to_inventory("node leafblower:bomb 1")
	end
end

minetest.register_entity("leafblower:bomb", IRON_TNT)
