-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file fighting.lua
--! @brief component for fighting related features
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup fighting Combat subcomponent
--! @brief Component handling all fighting
--! @ingroup framework_int
--! @{
-- Contact: sapier a t gmx net
-------------------------------------------------------------------------------

--! @class fighting
--! @brief melee and distance attack features
fighting = {}

--!@}

--! @brief factor added to mob melee combat range to get its maximum agression radius
MOBF_AGRESSION_FACTOR = 5

-------------------------------------------------------------------------------
-- name: hit(entity,player)
--
--! @brief handler for mob beeing hit
--! @memberof fighting
--
--! @param entity mob being hit
--! @param player player/object hitting the mob
-------------------------------------------------------------------------------
function fighting.hit(entity,player)

	if entity.data.generic.on_hit_callback ~= nil and
			entity.data.generic.on_kill_callback(entity,player) == true
		then
		dbg_mobf.fighting_lvl2("MOBF: ".. entity.data.name .. " custom on hit handler superseeds generic handling")
		return
	end
	
	--TODO calculate damage by players weapon
	--local damage = 1

	--dbg_mobf.fighting_lvl2("MOBF: ".. entity.data.name .. " about to take ".. damage .. " damage")
	--entity.dynamic_data.generic.health = entity.dynamic_data.generic.health	 - damage

	--entity.object:set_hp(entity.object:get_hp() - damage )
	

	--get some base information
	local mob_basepos = entity.getbasepos(entity)
	local mob_pos = entity.object:getpos()
	local playerpos = player:getpos()
	local dir = mobf_get_direction(playerpos,mob_basepos)
	
	
	if entity.data.sound ~= nil then		
		sound.play(mob_pos,entity.data.sound.hit);		
	end
	
	--push back mob	
	local new_pos = {x=(mob_basepos.x + (dir.x *0.5)),
							y=mob_basepos.y,
							z=(mob_basepos.z + (dir.z *0.5))}
	local pos_state = environment.pos_is_ok(new_pos,entity)
	new_pos.y = mob_pos.y
	dbg_mobf.fighting_lvl2("trying to move mob from " .. printpos(mob_pos) .. " to ".. printpos(new_pos) .. " state="..pos_state)
	if pos_state == "ok" or
		pos_state == "drop" then
		dbg_mobf.fighting_lvl2("moving")
		entity.object:moveto(new_pos)
	else
		dbg_mobf.fighting_lvl2("not moving mob due to position state: " .. pos_state)
	end
	


	-- make it die
	if entity.object:get_hp() < 1 then
	--if entity.dynamic_data.generic.health < 1 then
		local result = entity.data.generic.kill_result
		if type(entity.data.generic.kill_result) == "function" then
			result = entity.data.generic.kill_result()
		end
		
		
		--call on kill callback and superseed normal on kill handling
		if entity.data.generic.on_kill_callback == nil or
			entity.data.generic.on_kill_callback(entity,player) == false
			then
			
			if entity.data.sound ~= nil then		
				sound.play(mob_pos,entity.data.sound.die);		
			end
		
			player:get_inventory():add_item("main", result)
			spawning.remove(entity)
		else
			dbg_mobf.fighting_lvl2("MOBF: ".. entity.data.name .. " custom on kill handler superseeds generic handling")
		end
		
		return
	end

	--dbg_mobf.fighting_lvl2("MOBF: attack chance is ".. entity.data.combat.angryness)
	-- fight back
	if entity.data.combat ~= nil and
		entity.data.combat.angryness > 0 then
		dbg_mobf.fighting_lvl2("MOBF: mob with chance of fighting back attacked")
		--either the mob hasn't been attacked by now or a new player joined fight
		
		local playername = player.get_player_name(player)
		
		if entity.dynamic_data.combat.target ~= playername then
			dbg_mobf.fighting_lvl2("MOBF: new player started fight")
			--calculate chance of mob fighting back
			if math.random() < entity.data.combat.angryness then
					dbg_mobf.fighting_lvl2("MOBF: fighting back player "..playername)
					entity.dynamic_data.combat.target = playername
					
					fighting.enable_combat_movement(entity,mobf_get_current_time(),player)
								
			end	
		end

	end

end

-------------------------------------------------------------------------------
-- name: restore_default_movement(entity,now) 
--
--! @brief restore default movement generator of mob
--! @memberof fighting
--! @private
--
--! @param entity mob to restore movement generator
--! @param now current time in seconds
-------------------------------------------------------------------------------
function fighting.restore_default_movement(entity,now)

	if entity.data.combat.mgen ~= nil then
		--switch movement generator to default
		entity.dynamic_data.current_movement_gen = getMovementGen(entity.data.movement.default_gen)
		
		--restore old dynamic data
		
		if entity.dynamic_data.backup ~= nil then
			entity.dynamic_data.movement = entity.dynamic_data.backup
		else
			minetest.log(LOGLEVEL_WARNING,"MOBF: unable to restore old dynamic_data.movement, reinitilizing")
			entity.dynamic_data.current_movement_gen.init_dynamic_data(entity,now)
		end		
	end		

end


-------------------------------------------------------------------------------
-- name: enable_combat_movement(entity,now) 
--
--! @brief switch to combat movement gen (if specified)
--! @memberof fighting
--! @private
--
--! @param entity mob to change movement gen
--! @param now current time
--! @param target target to attack
-------------------------------------------------------------------------------
function fighting.enable_combat_movement(entity,now,target)

	if target == nil then
		dbg_mobf.fighting_lvl2("MOBF: no target for movement gen specified")
		return
	end

	if entity.data.combat.mgen ~= nil then
		dbg_mobf.fighting_lvl2("MOBF: switching to combat movement generator")
		--switch movement generator to combat specified movement generator
		entity.dynamic_data.current_movement_gen = getMovementGen(entity.data.combat.mgen)
		entity.dynamic_data.current_movement_gen.init_dynamic_data(entity,now)
		
		local new_dynamic_data = {}
		
		--backup dynamic data
		new_dynamic_data.backup = entity.dynamic_data.movement
		
		--switch to new dynamic_data
		entity.dynamic_data.movement = new_dynamic_data
		
		--set target
		entity.dynamic_data.movement.target = target
		
		--make sure a fighting mob ain't teleporting to target
		entity.dynamic_data.movement.teleportsupport = false
		--make sure we do follow our target
		entity.dynamic_data.movement.guardspawnpoint = false
	else
		dbg_mobf.fighting_lvl2("MOBF: no combat movement generator specified not changing movement")
	end			

end
-------------------------------------------------------------------------------
-- name: combat(entity,now) 
--
--! @brief periodic callback called to do mobs own combat related actions
--! @memberof fighting
--
--! @param entity mob to do action
--! @param now current time
-------------------------------------------------------------------------------
function fighting.combat(entity,now)
	
	--handle self destruct mobs
	if fighting.self_destruct_handler(entity,now) then
		return
	end	

	if entity.dynamic_data.combat.target ~= "" then		

		dbg_mobf.fighting_lvl1("MOBF: attacking player: "..entity.dynamic_data.combat.target)

		local player = minetest.env:get_player_by_name(entity.dynamic_data.combat.target)


		--check if target is still valid
		if player == nil then
			dbg_mobf.fighting_lvl3("MOBF: not a valid player")
			--there is no player by that name, stop attack
			entity.dynamic_data.combat.target = ""
			-- switch back to default movement gen
			fighting.restore_default_movement(entity,now)
			return
		end
		
		--calculate some basic data
		local mob_pos = entity.object:getpos()
		local playerpos = player:getpos()
		local distance = mobf_calc_distance(mob_pos,playerpos)
		
		fighting.self_destruct_trigger(entity,distance,now)

		--find out if player is next to mob
		if distance > entity.data.combat.melee.range * MOBF_AGRESSION_FACTOR then
			dbg_mobf.fighting_lvl2("MOBF: " .. entity.data.name .. " player >" .. entity.dynamic_data.combat.target .. "< to far away " 
			.. distance .. " > " .. (entity.data.combat.melee.range * MOBF_AGRESSION_FACTOR ) .. " stopping attack")
			--there is no player by that name, stop attack
			entity.dynamic_data.combat.target = ""
			
			--switch back to default movement gen
			fighting.restore_default_movement(entity,now)
			return
		end

		--is mob near enough for any attack attack?
		if  (entity.data.combat.melee == nil or
			distance > entity.data.combat.melee.range) and
			(entity.data.combat.distance == nil or 
			distance > entity.data.combat.distance.range) then
			
			if entity.data.combat.melee ~= nil or
				entity.data.combat.distance ~= nil then
				dbg_mobf.fighting_lvl2("MOBF: distance="..distance)
				
				
				if entity.data.combat.melee ~= nil then
					dbg_mobf.fighting_lvl2("MOBF: melee="..entity.data.combat.melee.range)
				end
				if  entity.data.combat.distance ~= nil then
					dbg_mobf.fighting_lvl2("MOBF: distance="..entity.data.combat.distance.range)
				end
			end
			return
		end

		if fighting.melee_attack_handler(entity,player,now,distance) == false then
			
			if fighting.distance_attack_handler(entity,playerpos,mob_pos,now,distance) then
	
				-- mob did an attack so give chance to stop attack

				local rand_value = math.random()								

				if  rand_value > entity.data.combat.angryness then
					dbg_mobf.fighting_lvl2("MOBF: rand=".. rand_value .. " angryness=" .. entity.data.combat.angryness)
					dbg_mobf.fighting_lvl2("MOBF: " .. entity.data.name .. " " .. now .. " random aborting attack at player "..entity.dynamic_data.combat.target)
					entity.dynamic_data.combat.target = ""
				end
			end		
		end
	end
		
	--fight against generic enemy "sun"
	fighting.sun_damage_handler(entity,now)
	

end

-------------------------------------------------------------------------------
-- name: get_target(entity)
--
--! @brief find and possible target next to mob
--! @memberof fighting
--! @private
--
--! @param entity mob to look around
--! @return target
-------------------------------------------------------------------------------
function fighting.get_target(entity)

	local possible_targets = {}

	if entity.data.combat.melee.range > 0 then
		local objectlist = minetest.env:get_objects_inside_radius(entity.object:getpos(),entity.data.combat.melee.range*MOBF_AGRESSION_FACTOR)

		local count = 0

		for i,v in ipairs(objectlist) do
		
			local playername = v.get_player_name(v)			
	
			if playername ~= nil and
				playername ~= "" then
				count = count + 1
				table.insert(possible_targets,v)
				dbg_mobf.fighting_lvl3(playername .. " is next to a mob of type " .. entity.data.name);
			end

		end
		dbg_mobf.fighting_lvl3("Found ".. count .. " objects within attack range of " .. entity.data.name)
	end


	local targets_within_sight = {}

	for i,v in ipairs(possible_targets) do

		local entity_pos = entity.object:getpos()
		local target_pos = v:getpos()

		--is there a line of sight between mob and possible target
		--line of sight is calculated 1block above ground
		if mobf_line_of_sight({x=entity_pos.x,y=entity_pos.y+1,z=entity_pos.z},
					 {x=target_pos.x,y=target_pos.y+1,z=target_pos.z}) then

			table.insert(targets_within_sight,v)
		end

	end

	local nearest_target = nil
	local min_distance = -1

	for i,v in ipairs(targets_within_sight) do

		local distance = mobf_calc_distance(entity.object:getpos(),v:getpos())

		if min_distance < 0 or
			distance < min_distance then

			nearest_target = v
			min_distance = distance
		end
		
	end

	return nearest_target

end


-------------------------------------------------------------------------------
-- name: aggression(entity) 
--
--! @brief start attack in case of agressive mob
--! @memberof fighting
--
--! @param entity mob to do action
--! @param now current time
-------------------------------------------------------------------------------
function fighting.aggression(entity,now)

	--if no combat data is specified don't do anything
	if entity.data.combat == nil then
		return
	end

	--mob is specified as self attacking
	if entity.data.combat.starts_attack then
		dbg_mobf.fighting_lvl3("MOBF: ".. entity.data.name .. " " .. now .. " aggressive mob, is it time to attack?")
		if entity.dynamic_data.combat.ts_last_attack + 5 < now then
			dbg_mobf.fighting_lvl3("MOBF: ".. entity.data.name .. " " .. now .. " lazzy time over try to find an enemy")
			entity.dynamic_data.combat.ts_last_attack = now

			if math.random() < entity.data.combat.angryness then

				dbg_mobf.fighting_lvl3("MOBF: ".. entity.data.name .. " " .. now .. " really is angry")
				local target = fighting.get_target(entity)
				
				if target ~= nil then
					local targetname = target.get_player_name(target)

					if targetname ~= entity.dynamic_data.combat.target then

						entity.dynamic_data.combat.target = targetname		
						
						fighting.enable_combat_movement(entity,now,target)			
						
						dbg_mobf.fighting_lvl2("MOBF: ".. entity.data.name .. " " .. now .. " starting attack at player: " ..targetname)
						minetest.log(LOGLEVEL_INFO,"MOBF: starting attack at player "..targetname)
					end
				end
			end
		end
	end
end

-------------------------------------------------------------------------------
-- name: fighting.init_dynamic_data(entity) 
--
--! @brief initialize all dynamic data on activate
--! @memberof fighting
--
--! @param entity mob to do action
--! @param now current time
-------------------------------------------------------------------------------
function fighting.init_dynamic_data(entity,now)
	local targetstring = ""
	local data = {
		ts_last_sun_damage			= now,
		ts_last_attack     			= now,
		ts_last_aggression_chance 	= now,
		ts_self_destruct_triggered  = -1,
		
		target             = targetstring,		
	}	
	
	entity.dynamic_data.combat = data
end

-------------------------------------------------------------------------------
-- name: self_destruct_trigger(entity,distance) 
--
--! @brief handle self destruct features
--! @memberof fighting
--! @private
--
--! @param entity mob to do action
--! @param distance current distance to target
--! @param now current time
--! @return true/false if handled or not
-------------------------------------------------------------------------------
function fighting.self_destruct_trigger(entity,distance,now)
		if entity.data.combat ~= nil and
		   entity.data.combat.self_destruct ~= nil then

			dbg_mobf.fighting_lvl1("MOBF: checking for self destruct trigger " ..  
									distance .. 
									" " .. entity.dynamic_data.combat.ts_self_destruct_triggered .. 
									" " ..now)

			--trigger self destruct			
			if distance <= entity.data.combat.self_destruct.range and
				entity.dynamic_data.combat.ts_self_destruct_triggered == -1 then
				dbg_mobf.fighting_lvl2("MOBF: self destruct triggered")
				entity.dynamic_data.combat.ts_self_destruct_triggered = now
			end
		end
end
-------------------------------------------------------------------------------
-- name: self_destruct_handler(entity) 
--
--! @brief handle self destruct features
--! @memberof fighting
--! @private
--
--! @param entity mob to do action
--! @param now current time
--! @return true/false if handled or not
-------------------------------------------------------------------------------
function fighting.self_destruct_handler(entity,now)
		--self destructing mob?
		if entity.data.combat ~= nil and
		   entity.data.combat.self_destruct ~= nil then
		   
		   local pos = entity.object:getpos()

			dbg_mobf.fighting_lvl1("MOBF: checking for self destruct imminent")
			--do self destruct
			if 	entity.dynamic_data.combat.ts_self_destruct_triggered > 0 and
				entity.dynamic_data.combat.ts_self_destruct_triggered + 
				entity.data.combat.self_destruct.delay
				<= now then
				
				dbg_mobf.fighting_lvl2("MOBF: executing self destruct")
				
				if entity.data.sound ~= nil then		
					sound.play(pos,entity.data.sound.self_destruct);		
				end
				
				mobf_do_area_damage(pos,nil,
										entity.data.combat.self_destruct.damage,
										entity.data.combat.self_destruct.range)

				--TODO determine block removal by damage and remove blocks
				mobf_do_node_damage(pos,{},
								entity.data.combat.self_destruct.node_damage_range,
								1 - 1/entity.data.combat.self_destruct.node_damage_range)
								
				--Add fire
				for i=pos.x-entity.data.combat.self_destruct.range/2, pos.x+entity.data.combat.self_destruct.range/2, 1 do
				for j=pos.y-entity.data.combat.self_destruct.range/2, pos.y+entity.data.combat.self_destruct.range/2, 1 do
				for k=pos.z-entity.data.combat.self_destruct.range/2, pos.z+entity.data.combat.self_destruct.range/2, 1 do
				
					local current = minetest.env:get_node({x=i,y=j,z=k})					
					
					if (current.name == "air") then
						minetest.env:set_node({x=i,y=j,z=k}, {name="fire:basic_flame"})
					end
							
				end
				end
				end	

				spawning.remove(entity)
				return true
			end
		end
		return false
end

-------------------------------------------------------------------------------
-- name: melee_attack_handler(entity,now) 
--
--! @brief handle melee attack
--! @memberof fighting
--! @private
--
--! @param entity mob to do action
--! @param player player to attack
--! @param now current time
--! @param distance distance to player
--! @return true/false if handled or not
-------------------------------------------------------------------------------
function fighting.melee_attack_handler(entity,player,now,distance)

		if entity.data.combat.melee == nil then
			dbg_mobf.fighting_lvl2("MOBF: no meele attack specified")
			return false
		end

		local time_of_next_attack_chance = entity.dynamic_data.combat.ts_last_attack 
												+ entity.data.combat.melee.speed
		--check if mob is ready to attack
		if now <  time_of_next_attack_chance then
			dbg_mobf.fighting_lvl1("MOBF: to early for meele attack " .. 
									now .. " >= " .. time_of_next_attack_chance)
			return false
		end
		
		if distance <= entity.data.combat.melee.range
			then

			--save time of attack
			entity.dynamic_data.combat.ts_last_attack = now
			
			if entity.data.sound ~= nil then		
				sound.play(entity.object:getpos(),entity.data.sound.melee);		
			end

			--calculate damage to be done
			local damage_done = math.floor(math.random(0,entity.data.combat.melee.maxdamage)) + 1

			local player_health = player:get_hp()

			--do damage
			player:set_hp(player_health -damage_done)

			dbg_mobf.fighting_lvl2("MOBF: ".. entity.data.name .. 
									" doing melee attack damage=" .. damage_done)
			return true
		end
		dbg_mobf.fighting_lvl1("MOBF: not within meele range " .. 
									distance .. " > " .. entity.data.combat.melee.range) 
		return false
end


-------------------------------------------------------------------------------
-- name: distance_attack_handler(entity,now) 
--
--! @brief handle distance attack
--! @memberof fighting
--! @private
--
--! @param entity mob to do action
--! @param playerpos position of target
--! @param mob_pos position of mob
--! @param now current time
--! @param distance distance between target and player
--! @return true/false if handled or not
-------------------------------------------------------------------------------
function fighting.distance_attack_handler(entity,playerpos,mob_pos,now,distance)
		if 	entity.data.combat.distance == nil then
			dbg_mobf.fighting_lvl2("MOBF: no distance attack specified")
			return false
		end
		
		local time_of_next_attack_chance = entity.dynamic_data.combat.ts_last_attack 
											+ entity.data.combat.distance.speed

		--check if mob is ready to attack
		if 	now < time_of_next_attack_chance then
			dbg_mobf.fighting_lvl1("MOBF: to early for distance attack " .. 
									now .. " >= " .. time_of_next_attack_chance)	
			return false
		end
		
		if	distance <= entity.data.combat.distance.range
			then
			
			dbg_mobf.fighting_lvl2("MOBF: ".. entity.data.name .. " doing distance attack")
			
			--save time of attack
			entity.dynamic_data.combat.ts_last_attack = now
			
			local dir = mobf_get_direction({	x=mob_pos.x,
												y=mob_pos.y+1,
												z=mob_pos.z
												},
												playerpos)
												
			if entity.data.sound ~= nil then		
				sound.play(mob_pos,entity.data.sound.distance);		
			end
				
			local newobject=minetest.env:add_entity({	x=mob_pos.x+dir.x,
														y=mob_pos.y+dir.y+1,
														z=mob_pos.z+dir.z
														},
														entity.data.combat.distance.attack
														)

			local thrown_entity = mobf_find_entity(newobject)

			--TODO add random disturbance based on accuracy

			local vel_trown = {
								x=dir.x*thrown_entity.velocity,
								y=dir.y*thrown_entity.velocity + math.random(0,0.25),
								z=dir.z*thrown_entity.velocity
								}

			dbg_mobf.fighting_lvl2("MOBF: throwing with velocity: " .. printpos(vel_trown))

			newobject:setvelocity(vel_trown)

			newobject:setacceleration({x=0, y=-thrown_entity.gravity, z=0})
			thrown_entity.owner = entity.object

			dbg_mobf.fighting_lvl2("MOBF: distance attack issued")
			return true
		end
		dbg_mobf.fighting_lvl1("MOBF: not within distance range " .. 
								distance .. " > " .. entity.data.combat.distance.range) 
		return false
end


-------------------------------------------------------------------------------
-- name: sun_damage_handler(entity,now) 
--
--! @brief handle damage done by sun
--! @memberof fighting
--! @private
--
--! @param entity mob to do action
--! @param now current time
-------------------------------------------------------------------------------
function fighting.sun_damage_handler(entity,now)
	if entity.data.combat ~= nil and
		entity.data.combat.sun_sensitive then

		local pos = entity.object:getpos()

		local current_light = minetest.env:get_node_light(pos)
			
		if current_light == nil then
			minetest.log(LOGLEVEL_ERROR,"MOBF: Bug!!! didn't get a light value for ".. printpos(pos))
			return
		end
		--check if mob is in sunlight
		if ( current_light > LIGHT_MAX) then
			dbg_mobf.fighting_lvl1("MOBF: " .. entity.data.name .. 
										" health at start:" .. entity.object:get_hp())
			
			graphics.set_draw_mode(entity,"burning")							
				
			if entity.dynamic_data.combat.ts_last_sun_damage < now then
				local damage = (1 + math.floor(entity.data.generic.base_health/15))				
				dbg_mobf.fighting_lvl1("Mob ".. entity.data.name .. " takes " ..damage .." damage because of sun")
				
				entity.object:set_hp(entity.object:get_hp() - damage)
				
				if entity.data.sound ~= nil then		
					sound.play(mob_pos,entity.data.sound.sun_damage);		
				end

				if entity.object:get_hp() <= 0 then
				--if entity.dynamic_data.generic.health <= 0 then
					dbg_mobf.fighting_lvl2("Mob ".. entity.data.name .. " died of sun")
					spawning.remove(entity)
					return
				end
				entity.dynamic_data.combat.ts_last_sun_damage = now
			end
		else
			graphics.set_draw_mode(entity,"init")
		end
	end
	
end