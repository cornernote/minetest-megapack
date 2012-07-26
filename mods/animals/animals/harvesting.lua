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

harvesting = {}

-------------------------------------------------------------------------------
-- name: init_dynamic_data(entity,now)
--
-- action: initialize dynamic data required by harvesting
--
-- param1: entity being harvested
-- param2: current time
-- retval: -
-------------------------------------------------------------------------------
function harvesting.init_dynamic_data(entity,now)
 	local data =  {
		ts_last 				= now,
	}
	entity.dynamic_data.harvesting = data
end

-------------------------------------------------------------------------------
-- name: callback(entity,player)
--
-- action: handle harvest by player
--
-- param1: entity being harvested
-- param2: player harvesting
-- retval: true/false if handled by harvesting or not
-------------------------------------------------------------------------------
function harvesting.callback(entity,player) 

	dbg_animals.harvesting_lvl1("ANIMALS: harvest function called")

	local now = animals_get_current_time()

	--handle catching of animals
	if entity.data.catching ~= nil and
		entity.data.catching.tool ~= "" then

		-- what's wielded by player
		local tool = player:get_wielded_item()

		if tool:get_name() == entity.data.catching.tool then
			dbg_animals.harvesting_lvl1("ANIMALS: player wearing ".. entity.data.catching.tool)

			--play catch sound			
			if entity.data.sound ~= nil then		
				sound.play(entity.object:getpos(),entity.data.sound.catch);		
			end
			
			if entity.data.catching.consumed == true then			
					if player:get_inventory():contains_item("main",entity.data.catching.tool.." 1") then
						dbg_animals.harvesting_lvl2("ANIMALS: removing: " .. entity.data.catching.tool.." 1")
						player:get_inventory():remove_item("main",entity.data.catching.tool.." 1")
						player:get_inventory():add_item("main", entity.data.modname ..":"..entity.data.name.." 1")						
						spawning.remove(entity)	
						return true
					else
						minetest.log(LOGLEVEL_ERROR,"ANIMALS: BUG!!! player is wearing a item he doesn't have in inventory!!!")
						--handled but not ok so don't attack
						return true
					end
			else -- tool is not consumed on catch
				dbg_animals.harvesting_lvl2("ANIMALS: tool not consumed")
				player:get_inventory():add_item("main", entity.data.modname ..":"..entity.data.name.." 1")
				spawning.remove(entity)
				return true
			end
		end
	end


	--handle harvestable animals, check if player is wearing correct tool
	if entity.data.harvest ~= nil then	

		dbg_animals.harvesting_lvl1("ANIMALS: trying to harvest harvestable animal")		
		if (entity.data.harvest.tool ~= "") then
			local tool = player:get_wielded_item()
			if tool ~= nil then
				dbg_animals.harvesting_lvl1("ANIMALS: Player is wearing " .. tool:get_name() .. 
						" required is ".. entity.data.harvest.tool .. " wear: " .. tool:get_wear())
			
				if (tool:get_name() ~=  entity.data.harvest.tool) then	
					--player is wearing wrong tool do an attack
					return false
				else
					if entity.data.harvest.tool_consumed == true then
						if player:get_inventory():contains_item("main",entity.data.harvest.tool.." 1") == false then
							--handled but not ok so don't attack
							return true
						end						
					end
					--normal case handle tool changes
					
					local tool_wear = tool:get_wear()
					
					dbg_animals.harvesting_lvl1("ANIMALS: tool " .. tool:get_name() .. " wear: " ..  tool_wear)
					-- damage used tool
					if tool_wear ~= nil and
						entity.data.harvest.max_tool_usage ~= nil then	
						
						local todamage = (65535/entity.data.harvest.max_tool_usage)
						dbg_animals.harvesting_lvl1("ANIMALS: tool damage calculated: " .. todamage);		
						if tool:add_wear(todamage) ~= true then
							dbg_animals.harvesting_lvl3("ANIMALS: Tried to damage non tool item " .. tool:get_name() .. "!");
						end
						player:set_wielded_item(tool)
					end
				end
			else
				--player isn't wearing a tool so this has to be an attack
				return false
			end
		else
			--no havest tool defined so this has to be an attack
			return false
		end


		--transformation and harvest delay is exclusive
		
		--harvest delay mode
		if entity.data.harvest.min_delay < 0 or
			entity.dynamic_data.harvesting.ts_last + entity.data.harvest.min_delay < now then
		
			player:get_inventory():add_item("main", entity.data.harvest.result.." 1")

			--check if tool is consumed by action
			if entity.data.harvest.tool_consumed then
				dbg_animals.harvesting_lvl2("ANIMALS: removing "..entity.data.harvest.tool.." 1")
				player:get_inventory():remove_item("main",entity.data.harvest.tool.." 1")
			end
		end
		
		-- check if animal is transformed by harvest
		if entity.data.harvest.transforms_to ~= "" then
			local transformed = spawning.replace_entity(entity,entity.data.harvest.transforms_to)
		else
			entity.dynamic_data.harvesting.last = animals_get_current_time()		
		end
		
		
		--play harvest sound
		if entity.data.sound ~= nil then		
			sound.play(entity.object:getpos(),entity.data.sound.harvest);		
		end

		--harvest done
		return true
	end

	return false
end


-------------------------------------------------------------------------------
-- name: transform(entity)
--
-- action: self transform hook for entity
--
-- param1: entity calling it
-- retval: -
-------------------------------------------------------------------------------
function transform(entity,now)

	--check if it's a transformable animal
	if entity.data.auto_transform ~= nil then

		if now - entity.dynamic_data.spawning.original_spawntime > entity.data.auto_transform.delay then
			spawning.replace_entity(entity,entity.data.auto_transform.result)
		end

	end

end
