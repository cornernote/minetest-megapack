
minetest.register_node("mesegun:default_wood", {
	description = "Mese wood",
	drawtype = "glasslike",
	tiles = {"MESE_builder_kit_default_wood.png"},
	inventory_image = minetest.inventorycube("MESE_builder_kit_default_wood.png"),
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	material = minetest.digprop_glasslike(3.0),
})

minetest.register_craft({
	output = 'node "mesegun:default_wood" 1',
	recipe = {
		{'default:mese'},
		{'default:wood'},
	}
})

minetest.register_craftitem("mesegun:mese_stick", {
	description = "Mese stick",
	inventory_image = "MESE_builder_kit_default_stick.png",
})
minetest.register_craft({
	output = 'node "mesegun:mese_stick" 4',
	recipe = {
		{'mesegun:mese_ignot'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "mesegun:mese_ignot",
	recipe = "default:mese",
})

BULLET1_DAMAGE=30
BULLET1_GRAVITY=3 --3
BULLET1_VELOCITY=40 --40

gunmod_shoot_bullet1=function (item, player, pointed_thing)
	if player:get_inventory():contains_item("main", "mesegun:bullet1") then
		player:get_inventory():remove_item("main", "mesegun:bullet1")

			local playerpos=player:getpos()
			local obj=minetest.env:add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, "mesegun:bullet1_entity")
			local dir=player:get_look_dir()
			obj:setvelocity({x=dir.x*BULLET1_VELOCITY, y=dir.y*BULLET1_VELOCITY, z=dir.z*BULLET1_VELOCITY})
			obj:setacceleration({x=dir.x*-3, y=-BULLET1_GRAVITY, z=dir.z*-3})
	end
	return
end

minetest.register_craftitem("mesegun:irongun", {
	image = "MESE_builder_kit_mesegun.png",
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = gunmod_shoot_bullet1,
	description = "Mese gun"
})

minetest.register_craftitem("mesegun:bullet1", {
	image = "MESE_builder_kit_bullet1.png",
	on_place_on_ground = minetest.craftitem_place_item,
	description = "Mese gun Bullets"
})
minetest.register_craftitem("mesegun:usedbullet1", {
	image = "MESE_builder_kit_usedbullet1.png",
	on_place_on_ground = minetest.craftitem_place_item,
	description = "Useless Bullet"
})
minetest.register_craftitem("mesegun:rawbullet1", {
	image = "MESE_builder_kit_rawbullet1.png",
	on_place_on_ground = minetest.craftitem_place_item,
	description = "Raw Bullet"
})
minetest.register_craft({
	type = "cooking",
	output = "mesegun:bullet1",
	recipe = "mesegun:rawbullet1",
})

GUNMOD_BULLET1_ENTITY={
	physical = false,
	timer=0,
	textures = {"MESE_builder_kit_bullet1_back.png"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
}


GUNMOD_BULLET1_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)

	if self.timer>0.2 then
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
		for k, obj in pairs(objs) do
			obj:set_hp(obj:get_hp()-BULLET1_DAMAGE)
			if obj:get_entity_name() ~= "mesegun:bullet1_entity" then
				if obj:get_hp()<=0 then 
					obj:remove()
				end
				self.object:remove() 
			end
		end
	end

	if self.lastpos.x~=nil then 
		if node.name ~= "air" then
			minetest.env:add_item(self.lastpos, 'mesegun:usedbullet1 1')
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z} 
end

minetest.register_entity("mesegun:bullet1_entity", GUNMOD_BULLET1_ENTITY)







minetest.register_craft({
	output = 'mesegun:irongun 1',
	recipe = {
		{'mesegun:mese_ignot', 'mesegun:default_wood', 'mesegun:default_wood'},
		{'mesegun:mese_ignot', 'mesegun:mese_ignot', 'mesegun:mese_stick'},
		{'', '', 'mesegun:mese_stick'},
	}
})

minetest.register_craft({
	output = 'mesegun:bullet1 3',
	recipe = {
		{'mesegun:mese_ignot', 'mesegun:mese_ignot', 'mesegun:mese_ignot'},
	}
})
minetest.register_craft({
	output = 'mesegun:rawbullet1 1',
	recipe = {
		{'mesegun:usedbullet1', 'mesegun:usedbullet1'},
	}
})


print("[mesegun ] Loaded")
