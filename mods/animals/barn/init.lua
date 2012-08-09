local version = "0.0.3"

local modpath = minetest.get_modpath("barn")

--include debug trace functions
dofile (modpath .. "/model.lua")

minetest.register_craftitem("barn:barn_empty", {
			description = "Barn to breed animals",
			image = minetest.inventorycube("barn_3d_empty_top.png","barn_3d_empty_side.png","barn_3d_empty_side.png"),
			on_place = function(item, placer, pointed_thing)
				if pointed_thing.type == "node" then
					local pos = pointed_thing.above
			
					local newobject = minetest.env:add_entity(pos,"barn:barn_empty_ent")
					
					item:take_item()

					return item
				end
			end
		})
		
minetest.register_craft({
	output = "barn:barn_empty 1",
	recipe = {
		{'default:stick', 'default:stick','default:stick'},
		{'default:wood','default:wood','default:wood'},
	}
})

function is_food(name) 

	if name == "default:leaves" then
		return true
	end
	
	if name == "default:junglegrass" then
		return true
	end

	return false
end

--Entity
minetest.register_entity(":barn:barn_ent",
	{
		physical 		= true,
		collisionbox 	= {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
		visual 			= "wielditem",
		textures 		= { "barn:box_filled"},
		visual_size     = { x=0.666,y=0.666,z=0.666},

		on_step = function(self,dtime)

			local now = os.time(os.date('*t'))
			
			if now ~= self.last_check_time then
			
				local pos = self.object:getpos()
			
				local objectlist = minetest.env:get_objects_inside_radius(pos,2)
				
				local le_animal1 = nil
				local le_animal2 = nil
				
				for index,value in pairs(objectlist) do
				
					local luaentity = value:get_luaentity()
					
					if luaentity ~= nil and
						luaentity.name == "animal_sheep:sheep" and 
						le_animal1 ~= nil and
						le_animal2 == nil then						
						
						le_animal2 = luaentity
					end
					
					if luaentity ~= nil and
						luaentity.name == "animal_sheep:sheep" and 
						le_animal1 == nil then						
						
						le_animal1 = luaentity
					end
					
					if le_animal1 ~= nil and
						le_animal2 ~= nil then
						break
					end				
				end
				
				if math.random() < (0.0001 * (now - (self.last_breed_time + 30))) and
					self.last_breed_time > 0 and
					le_animal1 ~= nil and
					le_animal2 ~= nil then
					local pos1 = le_animal1.object:getpos()
					local pos2 = le_animal2.object:getpos()
					local pos = self.object:getpos()
					local pos_to_breed = {
											x = pos1.x + (pos2.x - pos1.x) /2,
											y = pos1.y,
											z = pos1.z + (pos2.z - pos1.z) /2,					
										}
										
					--TODO check position by now this is done by spawn algorithm only
					
					local lamb = minetest.env:add_entity(pos_to_breed,"animal_sheep:lamb")					
					
					local lamb_lua = lamb:get_luaentity()
					lamb_lua.dynamic_data.spawning.player_spawned = true
					
					--remove barn and add empty one
					self.object:remove()
									
					local barn_empty = minetest.env:add_entity(pos,"barn:barn_empty_ent")
					
					local barn_empty_lua = barn_empty:get_luaentity()
					
					barn_empty_lua.last_breed_time = now
				end			
			
				self.last_check_time = now
			end
		end,
		
		on_activate = function(self,staticdata)
			if staticdata == nil then
				self.last_breed_time = os.time(os.date('*t'))
			else
				self.last_breed_time = tonumber(staticdata)
			end
			self.last_check_time = os.time(os.date('*t'))
		end,
		
		get_staticdata = function(self)
			return self.last_breed_time
		end,
		
		on_punch = function(self,player)
			player:get_inventory():add_item("main", "barn:barn_empty 1")	
			self.object:remove()	
		end,

		last_breed_time = -1,
		last_check_time = -1,
	})
	
minetest.register_entity(":barn:barn_empty_ent",
	{
		physical 		= true,
		collisionbox 	= {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
		visual 			= "wielditem",
		textures 		= { "barn:box_empty"},
		visual_size     = { x=0.666,y=0.666,z=0.666},
		
		
		on_punch = function(self,player)
		
			--if player is wearing food replace by full barn
			local tool = player:get_wielded_item()

			if is_food(tool:get_name()) then
				local time_of_last_breed = self.last_breed_time
				local pos = self.object:getpos()
				
				self.object:remove()
			
				local barn = minetest.env:add_entity(pos,"barn:barn_ent")
					
				local barn_lua = barn:get_luaentity()
					
				barn_lua.last_breed_time = time_of_last_breed
			--else add to players inventory
			else
				player:get_inventory():add_item("main", "barn:barn_empty 1")	
				self.object:remove()
			end	
		end,
		
		on_activate = function(self, staticdata)
			self.last_breed_time = os.time(os.date('*t'))
			self.last_check_time = self.last_breed_time		
		end,
		
		})

--animals_register_animal_item("vombie","animal_vombie","Trapped Vombie")
	
print("barn mod version " .. version .. " loaded")