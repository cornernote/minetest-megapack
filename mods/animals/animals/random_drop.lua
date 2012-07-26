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

random_drop = {}

-------------------------------------------------------------------------------
-- name: callback(entity)
--
-- action: does entity do a random drop?
--
-- param1: entity calling it
-- retval: -
-------------------------------------------------------------------------------
function random_drop.callback(entity,now)
	if entity.data.random_drop ~= nil and
		entity.data.random_drop.result ~= "" then

		--print("ANIMALS: random drop for ".. entity.animals_name .." set")

		if entity.dynamic_data.random_drop.ts_last_drop + entity.data.random_drop.min_delay < now then

			--print("ANIMALS: enough time passed give drop a chance")
			if math.random() < entity.data.random_drop.chance then
			
				entity.dynamic_data.random_drop.ts_last_drop = now

				--find pos around
				local toput = movement_generic.get_suitable_pos_same_level(entity.getbasepos(entity),1,entity)

				if toput ~= nil then
					minetest.env:add_entity(toput,entity.data.random_drop.result.."_ent")
					--print("ANIMALS: adding random drop for "..entity.animals_name .. ": "..entity.animals_random_drop.."_ent" .. " at " .. printpos(toput))
					if entity.data.sound ~= nil then		
						sound.play(animal_pos,entity.data.sound.random_drop);		
					end
				else
					print("ANIMALS: didn't find a place to put random drop for ".. entity.data.name)
				end
			end
		
		end
	end
end

-------------------------------------------------------------------------------
-- name: register_random_drop(animal)
--
-- action: register random drop item and entity
--
-- param1: static data
-- retval: -
-------------------------------------------------------------------------------
function random_drop.register(animal)

		--get basename from random drop item name		
		local start_pos = 1
		local end_pos = string.find(animal.random_drop.result,":")

		if end_pos == nil then
			return
		end
		
		local drop_basename = string.sub(animal.random_drop.result,start_pos,end_pos-1)
		local drop_itemname = string.sub(animal.random_drop.result,end_pos+1)
		
		
		if drop_itemname == nil or
			drop_basename == nil then
			return
		end
		
		print("\tregistering random drop entity: "..":"..animal.random_drop.result.."_ent"..
				" item="..drop_itemname .. " basename=" .. drop_basename)
		
		--Entity
		minetest.register_entity(":"..animal.random_drop.result.."_ent",
			{
				physical 		= true,
				collisionbox 	= {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
				visual 			= "sprite",
				textures 		= {drop_basename .. "_"..drop_itemname..".png"},

				on_activate = function(self,staticdata)

					local now = animals_get_current_time()
					
					if staticdata == "" then
						self.dropped 	= now
					else
					
						self.dropped = tonumber(staticdata)
					end

					if self.dropped + self.random_drop_max_life < now then
						--print("ANIMALS: entity timed out")
						self.object:remove()
					end
				end,

				on_punch = function(self, hitter)
					hitter:get_inventory():add_item("main", animal.random_drop.result.." 1")
					self.object:remove()
				end,

				on_step = function(self,dtime)
					if self.dropped + self.random_drop_max_life < animals_get_current_time() then
						--print("ANIMALS: entity timed out")
						self.object:remove()
					end
		
				end,


				get_staticdata = function(self)
					return self.animals_dropped
				end,

				random_drop_max_life 	= animal.random_drop.min_delay/4,
				dropped 		= 0,

			})
end

-------------------------------------------------------------------------------
-- name: init_dynamic_data(entity,now)
--
-- action: initialize dynamic data required by random drop
--
-- param1: entity to add data
-- retval: -
-------------------------------------------------------------------------------
function random_drop.init_dynamic_data(entity,now)
	if entity.data.random_drop ~= nil and
		entity.data.random_drop.min_delay > 5 then
		entity.dynamic_data.random_drop = {
			ts_last_drop = now + math.random(5,entity.data.random_drop.min_delay)
			}
	else
		entity.dynamic_data.random_drop = {
			ts_last_drop = now
			}
	end
end
