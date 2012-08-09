animals = {}

spawning_animals = {}

function animals:add_animal(name, textures, nodebox, zoom, selectionbox, hp, on_rightclick, on_punch, on_step, spawn)
	
	minetest.register_node(name.."_box", {
		tiles = textures,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = nodebox,
		},
		groups = {oddly_breakable_by_hand=3, not_in_creative_inventory=1},
	})
	
	local animal = {
		physical = true,
		visual = "wielditem",
		textures = {name.."_box"},
		collisionbox = selectionbox,
		visual_size = {x=zoom, y=zoom},
		hp_max = hp,
		
		animal = true,
		state = "walk",
		timer = 0,
	}
	
	animal.on_rightclick = on_rightclick
	animal.on_punch = on_punch
	animal.on_step = on_step
	
	function animal:set_acceleration(a)
		local obj = self.object
		local z = math.sin(obj:getyaw())/a
		local x = math.cos(obj:getyaw())/a
		obj:setacceleration({x=x, y=-10, z=z})
	end
	
	function animal:get_speed(vel)
		local v = self.object:getvelocity()
		if vel ~= nil then
			v = vel
		end
		if v.x == 0 and v.z == 0 then
			return 0
		end
		return (v.x^2 + v.z^2)^(0.5)
	end
	
	function animal:turn_v()
		local v = self:get_speed()
		if v == 0 then
			return
		end
		if v > 1 then
			v = 1
		end
		local obj = self.object
		local z = math.sin(obj:getyaw())/v
		local x = math.cos(obj:getyaw())/v
		if self:get_speed({x=x, y=obj:getvelocity().y, z=z}) > 1 then
			return
		end
		obj:setvelocity({x=x, y=obj:getvelocity().y, z=z})
	end
	
	function animal:on_activate()
		local state = math.random(1,2)
		if state == 1 then
			self.state = "stand"
		else
			self.state = "walk"
		end
		self.object:setyaw(math.random(0,360)/180 * math.pi)
		self.timer = math.random(0, 3000)/1000
	end
	
	minetest.register_entity(name, animal)
	
	if spawn then
		table.insert(spawning_animals, name)
	end
end

local number_of_animals = 0
minetest.register_globalstep(function(dtime)
	local number = 0
	for i,animal in pairs(minetest.luaentities) do
		if animal ~= nil and animal.animal then
			number = number+1
			animal:turn_v()
			if animal:get_speed() > 1 then
				animal.object:setacceleration({x=0, y=-10, z=0})
			elseif animal.state == "walk" then
				animal:set_acceleration(1)
			end
			
			if animal.timer < 3 then
				animal.timer = animal.timer+dtime
			else
				animal.timer = 0
				
				if animal.state == "stand" then
					if math.random(1, 100) > 60 then
						animal:set_acceleration(1)
						animal.state = "walk"
					end
				elseif animal.state == "walk" then
					if math.random(1, 100) > 80 then
						animal.object:setacceleration({x=0, y=-10, z=0})
						animal.object:setvelocity({x=0, y=0, z=0})
						animal.state = "stand"
					elseif math.random(1, 100) > 30 then
						local yaw = animal.object:getyaw()
						yaw = yaw+((math.random(0, 180)-90)/180) * math.pi
						animal.object:setyaw(yaw)
					elseif math.random(1, 100) > 80 then
						local v = animal.object:getvelocity()
						if v.y == 0 then
							v.y = 5
							animal.object:setvelocity(v)
						end
					end
					if animal:get_speed() < 0.8 and math.random(1, 100) > 5 then
						local v = animal.object:getvelocity()
						if v.y == 0 then
							v.y = 5
							animal.object:setvelocity(v)
						end
					end
					if animal:get_speed() < 0.8 and math.random(1, 100) > 1 then
						local yaw = animal.object:getyaw()
						yaw = yaw+((math.random(0, 180)-90)/180) * math.pi
						animal.object:setyaw(yaw)
					end
				end
			end
		end
	end
	number_of_animals = number
end)

local MAX_ANIMALS = 10
minetest.register_abm({
	nodenames = {"default:dirt_with_grass"},
	neighbors = {"default:dirt_with_grass"},
	interval = 10,
	chance = 3000,
	action = function(pos, node)
		if number_of_animals >= MAX_ANIMALS then
			return
		end
		number_of_animals = number_of_animals+1
		pos.y = pos.y+2
		if minetest.env:get_node(pos).name == "air" then
			minetest.env:add_entity(pos, spawning_animals[math.random(1, #spawning_animals)])
		end
	end
})

dofile(minetest.get_modpath("animals").."/basic_animals.lua")