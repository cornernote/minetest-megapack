-------------------------------------------------------------------------------
-- Animals Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
-- (c) Sapier
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- name: animals_do_area_damage(pos,immune,damage,range) 
--
-- action: damage all objects within a certain range
--
-- param1: center of area
-- param2: object immune to damage
-- param3: damage to be done
-- param4: range around pos
-- retval: -
-------------------------------------------------------------------------------
function animals_do_area_damage(pos,immune,damage,range)
	--damage objects within inner blast radius
	objs = minetest.env:get_objects_inside_radius(pos, range)
	for k, obj in pairs(objs) do

		--don't do damage to issuer
		if obj ~= immune then
			obj:set_hp(obj:get_hp()-damage)
		end
	end
end


-------------------------------------------------------------------------------
-- name: animals_do_node_damage(pos,immune_list,range,chance)
--
-- action: damage all nodes within a certain range
--
-- param1: center of area
-- param2: nodes immune to damage
-- param3: range
-- param4: chance damage is done
-- retval: -
-------------------------------------------------------------------------------
function animals_do_node_damage(pos,immune_list,range,chance)
	--do node damage
	for i=pos.x-range, pos.x+range, 1 do
		for j=pos.y-range, pos.y+range, 1 do
			for k=pos.z-range,pos.z+range,1 do
				--TODO create a little bit more sophisticated blast resistance
				if math.random() < chance then
					local toremove = minetest.env:get_node({x=i,y=j,z=k})

					if toremove ~= nil then
						local immune = false
					
						if immune_list ~= nil then
							for i,v in ipairs(immune_list) do
								if (torremove.name == v) then
									immune = true
								end
							end
						end


						if immune ~= true then					
							minetest.env:remove_node({x=i,y=j,z=k})
						end
					end
				end
			end
		end
	end
end

-- A fireball entity
ANIMALS_FIREBALL_ENTITY={
	physical = false,
	textures = {"animals_fireball.png"},
	collisionbox = {0,0,0,0,0,0},

	damage_range = 4,
	velocity = 3,
	gravity = -0.01,

	damage = 15,

	owner = 0,
	lifetime = 30,
	created = -1,
}


ANIMALS_PLASMABALL_ENTITY={
	physical = false,
	textures = {"animals_plasmaball.png"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},

	damage_range = 2,
	velocity = 4,
	gravity = -0.001,

	damage = 8,

	owner = 0,
	lifetime = 30,
	created = -1,
}

ANIMALS_FIREBALL_ENTITY.on_activate = function(self,staticdata)
	self.created = animals_get_current_time()
end

-------------------------------------------------------------------------------
-- name: ANIMALS_FIREBALL_ENTITY.on_step = function(self, dtime)
--
-- action: onstep callback for fireball
--
-- param1: fireball itself
-- param2: dtime
-- retval: -
-------------------------------------------------------------------------------
ANIMALS_FIREBALL_ENTITY.on_step = function(self, dtime)
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)


	--detect hit
	local objs=minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)

	local hit = false

	for k, obj in pairs(objs) do
		if obj:get_entity_name() ~= "animals:fireball_entity" and
			obj ~= self.owner then
			hit=true
		end
	end


	if hit then
		--damage objects within inner blast radius
		animals_do_area_damage(pos,self.owner,self.damage_range/2,self.damage/2)

		--damage all objects within blast radius
		animals_do_area_damage(pos,self.owner,self.damage_range/2,self.damage/2)

		self.object:remove()
	end

	-- vanish when hitting a node
	if node.name ~= "air" then
		self.object:remove()
	end

	--remove after lifetime has passed
	if self.created > 0 and
		self.created + self.lifetime < animals_get_current_time() then
		self.object:remove()
	end
end

ANIMALS_PLASMABALL_ENTITY.on_activate = function(self,staticdata)
	self.created = animals_get_current_time()
end


-------------------------------------------------------------------------------
-- name: ANIMALS_PLASMABALL_ENTITY.on_step = function(self, dtime)
--
-- action: onstep callback for plasmaball
--
-- param1: plasmaball itself
-- param2: dtime
-- retval: -
-------------------------------------------------------------------------------
ANIMALS_PLASMABALL_ENTITY.on_step = function(self, dtime)
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)


	--detect hit
	local objs=minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)

	local hit = false

	for k, obj in pairs(objs) do
		if obj:get_entity_name() ~= "animals:plasmaball_entity" and
			obj ~= self.owner then
			hit=true
		end
	end

	--damage all objects not hit but at least passed
	animals_do_area_damage(pos,self.owner,2,1)	

	if hit then
		--damage objects within inner blast radius
		animals_do_area_damage(pos,self.owner,self.damage_range/2,self.damage/2)

		--damage all objects within blast radius
		animals_do_area_damage(pos,self.owner,self.damage_range/2,self.damage/2)
	end

	-- vanish when hitting a node
	if node.name ~= "air" or
		hit then

		--do node damage
		for i=pos.x-1, pos.x+1, 1 do
			for j=pos.y-1, pos.y+1, 1 do
				for k=pos.z-1,pos.z+1,1 do
					--TODO create a little bit more sophisticated blast resistance
					if math.random() < 0.5 then
						local toremove = minetest.env:get_node({x=i,y=j,z=k})

						if toremove ~= nil and
							toremove.name ~= "default:stone" and
							toremove.name ~= "default:cobble" then
						
							minetest.env:remove_node({x=i,y=j,z=k})
						end
					end
				end
			end
		end

		self.object:remove()
	end

	--remove after lifetime has passed
	if self.created > 0 and
		self.created + self.lifetime < animals_get_current_time() then
		self.object:remove()
	end
end


function animals_init_weapons()

	minetest.register_entity(":animals:fireball_entity", ANIMALS_FIREBALL_ENTITY)
	minetest.register_entity(":animals:plasmaball_entity", ANIMALS_PLASMABALL_ENTITY)

end
