-- Gun mod by Luizbr507 and with thmr's textures!
-- Based on Jeijas throwing mod, check it out here: http://c55.me/minetest/forum/viewtopic.php?id=687

BULLET1_DAMAGE=3
BULLET1_GRAVITY=9
BULLET1_VELOCITY=20

gunmod_shoot_bullet1=function (item, player, pointed_thing)
	-- Check if arrows in Inventory and remove one of them
	if player:get_inventory():contains_item("main", "gunmod:bullet1") then
		player:get_inventory():remove_item("main", "gunmod:bullet1")

			-- Shoot Arrow
			local playerpos=player:getpos()
			local obj=minetest.env:add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, "gunmod:bullet1_entity")
			local dir=player:get_look_dir()
			obj:setvelocity({x=dir.x*BULLET1_VELOCITY, y=dir.y*BULLET1_VELOCITY, z=dir.z*BULLET1_VELOCITY})
			obj:setacceleration({x=dir.x*-3, y=-BULLET1_GRAVITY, z=dir.z*-3})
			 -- Arrow shot, leave loop that checks for arrows in inventory
	end
	return
end
minetest.register_craftitem("gunmod:woodgun", {
	image = "gunmod_woodgun.png",
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = gunmod_shoot_bullet1,
	description = "Wooden gun"
})
minetest.register_craftitem("gunmod:irongun", {
	image = "gunmod_irongun.png",
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = gunmod_shoot_bullet1,
	description = "Iron gun"
})

minetest.register_craftitem("gunmod:bullet1", {
	image = "gunmod_bullet1.png",
	on_place_on_ground = minetest.craftitem_place_item,
	description = "Gun Bullets"
})
minetest.register_craftitem("gunmod:ironstick", {
	image = "gunmod_ironstick.png",
	on_place_on_ground = minetest.craftitem_place_item,
	description = "Iron Stick"
})
minetest.register_craftitem("gunmod:usedbullet1", {
	image = "gunmod_usedbullet1.png",
	on_place_on_ground = minetest.craftitem_place_item,
	description = "Useless Bullet"
})
minetest.register_craftitem("gunmod:rawbullet1", {
	image = "gunmod_rawbullet1.png",
	on_place_on_ground = minetest.craftitem_place_item,
	description = "Raw Bullet"
})
minetest.register_craft({
	type = "cooking",
	output = "gunmod:bullet1",
	recipe = "gunmod:rawbullet1",
})
--cookresult_itemstring = 'gunmod:bullet1 1',
-- The Arrow Entity

GUNMOD_BULLET1_ENTITY={
	physical = false,
	timer=0,
	textures = {"gunmod_bullet1_back.png"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
}


-- Arrow_entity.on_step()--> called when arrow is moving
GUNMOD_BULLET1_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)

	-- When arrow is away from player (after 0.2 seconds): Cause damage to mobs and players
	if self.timer>0.2 then
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
		for k, obj in pairs(objs) do
			obj:set_hp(obj:get_hp()-BULLET1_DAMAGE)
			if obj:get_entity_name() ~= "gunmod:bullet1_entity" then
				if obj:get_hp()<=0 then 
					obj:remove()
				end
				self.object:remove() 
			end
		end
	end

	-- Become item when hitting a node
	if self.lastpos.x~=nil then --If there is no lastpos for some reason
		if node.name ~= "air" then
			minetest.env:add_item(self.lastpos, 'gunmod:usedbullet1 1')
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z} -- Set lastpos-->Item will be added at last pos outside the node
end

minetest.register_entity("gunmod:bullet1_entity", GUNMOD_BULLET1_ENTITY)





--CRAFTS


minetest.register_craft({
	output = 'gunmod:woodgun 1',
	recipe = {
		{'default:steel_ingot', 'default:wood', 'default:wood'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:stick'},
		{'', '', 'default:stick'},
	}
})
minetest.register_craft({
	output = 'gunmod:irongun 1',
	recipe = {
		{'default:steel_ingot', 'default:wood', 'default:wood'},
		{'default:steel_ingot', 'default:steel_ingot', 'gunmod:ironstick'},
		{'', '', 'gunmod:ironstick'},
	}
})

minetest.register_craft({
	output = 'gunmod:bullet1 3',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})
minetest.register_craft({
	output = 'gunmod:ironstick 2',
	recipe = {
		{'default:steel_ingot'},
	}
})
minetest.register_craft({
	output = 'gunmod:rawbullet1 1',
	recipe = {
		{'gunmod:usedbullet1', 'gunmod:usedbullet1'},
	}
})
print ("[Gunmod_mod] Loaded!")
