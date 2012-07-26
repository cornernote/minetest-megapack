BULLET1_DAMAGE1=30
BULLET1_GRAVITY1=0
BULLET1_VELOCITY1=80

gunmod_shoot_bullet1=function (item, player, pointed_thing)
	if player:get_inventory():contains_item("main", "50cal:bullet1") then
		player:get_inventory():remove_item("main", "50cal:bullet1")

			local playerpos=player:getpos()
			local obj=minetest.env:add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, "50cal:bullet11_entity")
			local dir=player:get_look_dir()
			obj:setvelocity({x=dir.x*BULLET1_VELOCITY1, y=dir.y*BULLET1_VELOCITY1, z=dir.z*BULLET1_VELOCITY1})
			obj:setacceleration({x=dir.x*-3, y=-BULLET1_GRAVITY1, z=dir.z*-3})
	end
	return
end

GUNMOD_BULLET1_ENTITY={
	physical = false,
	timer=0,
	textures = {"MESE_builder_kit_bullet11_back.png"},
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
			obj:set_hp(obj:get_hp()-BULLET1_DAMAGE1)
			if obj:get_entity_name() ~= "50cal:bullet11_entity" then
				if obj:get_hp()<=0 then 
					obj:remove()
				end
				self.object:remove() 
			end
		end
	end

	if self.lastpos.x~=nil then 
		if node.name ~= "air" then
			minetest.env:add_item(self.lastpos, '50cal:usedbullet1 1')
			self.object:remove()
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z} 
end

minetest.register_entity("50cal:bullet11_entity", GUNMOD_BULLET1_ENTITY)







minetest.register_craft({
	output = '50cal:irongun 1',
	recipe = {
		{'50cal:barrel','default:steel_ingot','default:wood'},
		{'','default:steel_ingot','default:wood'},
		{'','','default:wood'},
	}
})

minetest.register_craft({
	output = '50cal:bullet1 3',
	recipe = {
		{'default:steel_ingot'},
		{'default:steel_ingot'},
		{'default:steel_ingot'},
	}
})
minetest.register_craft({
	output = '50cal:rawbullet1 1',
	recipe = {
		{'50cal:usedbullet1'},
	}
})
minetest.register_craft({
	output = '50cal:barrel 1',
	recipe = {
		{'default:steel_ingot','default:steel_ingot'},
		{'',''},
		{'default:steel_ingot','default:steel_ingot'},
	}
})


minetest.register_craftitem("50cal:barrel", {
	image = "MESE_builder_kit_barrel.png",
	on_place_on_ground = minetest.craftitem_place_item,
	description = "Barret 50 cal barrel"
})

minetest.register_craftitem("50cal:irongun", {
	image = "MESE_builder_kit_mesegun1.png",
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = gunmod_shoot_bullet1,
	description = "Barret 50 cal"
})

minetest.register_craftitem("50cal:bullet1", {
	image = "MESE_builder_kit_bullet11.png",
	on_place_on_ground = minetest.craftitem_place_item,
	description = "Barret 50 cal gun Bullets"
})
minetest.register_craftitem("50cal:usedbullet1", {
	image = "MESE_builder_kit_usedbullet11.png",
	on_place_on_ground = minetest.craftitem_place_item,
	description = "Barret 50 cal Useless Bullet"
})
minetest.register_craftitem("50cal:rawbullet1", {
	image = "MESE_builder_kit_rawbullet11.png",
	on_place_on_ground = minetest.craftitem_place_item,
	description = "Barret 50 cal Raw Bullet"
})
minetest.register_craft({
	type = "cooking",
	output = "50cal:bullet1",
	recipe = "50cal:rawbullet1",
})


print("[ 50cal ] Loaded")
