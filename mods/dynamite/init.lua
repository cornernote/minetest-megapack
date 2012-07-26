--[[

Author: Nemo08
mod:dynamite v 0.0.5
	
	thx to Jeija for bow code sample

]]--

--[ ***********************   coal dust  ***************** ]--

	minetest.register_craft({
		output = 'craft "dynamite:coal_dust" 1',
		recipe = {
			{'craft "default:coal_lump"'},
			{'craft "default:coal_lump"'},
			}
	})

	minetest.register_craftitem("dynamite:coal_dust", {
		image = "coal_dust.png",
		stack_max = 10,
		dropcount = 1,
		liquids_pointable = false,
		on_place_on_ground = minetest.craftitem_place_item,
	})

	DYNAMITE_TABLE = {}

--[ ******************************** DYNAMITE *************************** ]]--
	findeq = function (text,pattern)
		if text == pattern then
			return true
		else
			if (string.find(text, pattern) ~= nil)and(string.find(pattern, ":") ~= nil) then
				return true			
			else
				return false
			end
		end
	end

	explode_area = function (posd, half_size, change_node_list) 
		--[[
			change list format:             список имен нод, которые изменяются взрывом
				{node_name1 = node_name1x, node_name2 = node_name2x, .. }

			callback node list format:	список имен нод, при попадании на которые вызывается коллбек
				{{{node_name1, node_name2, .. }, callback_function(finded_node_pos) }, ..}
		]]--

		minetest.env:remove_node(posd)
				
		local rnd = 35

		for x = -half_size, half_size do
		for y = -half_size, half_size do
		for z = -half_size, half_size do

			dynpos = {x = posd.x+x,y = posd.y+y,z = posd.z+z}
			target_node = minetest.env:get_node(dynpos)
		
			local explode_this = true

				--check explosible а не динамит ли тут?
			for i, i_state in pairs(DYNAMITE_TABLE) do
				if (target_node.name == i)or(target_node.name == (i .. "_fired")) then
					minetest.env:add_node(dynpos, {name= (i .. "_fired")})
					explode_this = false    -- we not explose
					break
				end
			end

				--check change
			if change_node_list ~= nil then
				for i, i_state in pairs(change_node_list) do
					if i_state == '*' then
						i_state = i
					end
					
					if findeq(target_node.name,i) then
						if (string.match(i_state,"craft",1,true) ~= nil) then
							minetest.env:add_item(dynpos, i_state)
							explode_this = false    -- we not explose
						else
							minetest.env:add_node(dynpos, {name= (i_state)})
							nodeupdate_single(dynpos)
							explode_this = false    -- we not explose
							break
						end
					end
					
					if (i == "*") or (i_state == "") then
						explode_this = true;	
					end

				end
			end
				
			if (target_node.name == "default:tree")or (target_node.name == "default:jungletree") then
				local rnd_base = 0.04 + half_size * 0.01
				for i = 1, 4 do
					wood_pos = {	x=(dynpos.x + (rnd_base/2)-(math.random(1,100)*rnd_base)), 
									y=(dynpos.y + (rnd_base/2) - (math.random(1,100)*rnd_base)), 
									z=(dynpos.z + (rnd_base/2) -(math.random(1,100)*rnd_base))}
					target_wood_node = minetest.env:get_node(wood_pos)
					if target_wood_node.name == "air" then 
						if (math.random(1,100) < 40) then
							minetest.env:add_item(wood_pos, 'craft "default:stick" 1')
						else
							minetest.env:add_item(wood_pos, 'craft "moarcraft:ash" 1')
						end
					end
				end
				explode_this = true
			end

			if (explode_this) then
					minetest.env:remove_node(dynpos)

					if math.random(1,100) < 35 then 
						--minetest.env:add_node(dynpos, {name="nparticle:fire_cloud1"})
						--minetest.env:add_entity(dynpos,"nparticle:fire1_entity")
						add_nfire_single(dynpos,3)
					end				
				end

		end
		end
		end
	end

	--[[ ***************************************** register timed dinamite ********************************* ]]--
	register_time_dynamite = function (dyn_node_name, dyn_image, dyn_image_fired, explode_cube_half_size, dyn_interval, dyn_chance, dyn_lightness, dyn_craft_recipe,
					change_node_list,callback_node_list)
		
		DYNAMITE_TABLE["dynamite:dyn_" .. dyn_node_name] = tostring(explode_cube_half_size)
	
		minetest.register_abm({
			nodenames 	= {"dynamite:dyn_" .. dyn_node_name .. "_fired"},
			interval 	= dyn_interval,
			chanse		= dyn_chance,
			action 		= function(pos, node, _, __)							
						explode_area(pos, explode_cube_half_size,change_node_list,callback_node_list)
					end
		})
	

		minetest.register_node("dynamite:dyn_" .. dyn_node_name , {
			drawtype = "plantlike",
				tiles = {dyn_image},
			inventory_image = dyn_image,
			paramtype = "light",
			is_ground_content = true,
			walkable = false,
			sunlight_propagates = true,
			material = minetest.digprop_constanttime(0.4),
				drop = 'craft "dynamite:dyn_' .. dyn_node_name .. '_craft" 1',
		})

		minetest.register_node("dynamite:dyn_" .. dyn_node_name .. "_fired", {
			drawtype = "plantlike",
				tiles = {dyn_image_fired},
			inventory_image = dyn_image,
			paramtype = "light",
			is_ground_content = true,
			walkable = false,
			sunlight_propagates = true,
			light_source = dyn_lightness,
			material = minetest.digprop_constanttime(0.4),
				drop = 'craft "dynamite:dyn_' .. dyn_node_name .. '_craft" 1',
		})  


		minetest.register_craft({
			output = 'craft "dynamite:dyn_' .. dyn_node_name .. '_craft" 1',
			recipe = dyn_craft_recipe,
		})
	
		minetest.register_craftitem("dynamite:dyn_" .. dyn_node_name .. "_craft", {
			image = dyn_image,
			stack_max = 10,
			usable = true,
			dropcount = 1,
			liquids_pointable = false,
	
			on_place_on_ground = function (item, placer, pos)
			minetest.env:add_node(pos, {name="dynamite:dyn_" .. dyn_node_name})
				return true	
			end,

			on_use = function(item, player, pointed_thing)
			if pointed_thing.type == "node" then		
				minetest.env:add_node(pointed_thing.above, {name="dynamite:dyn_" .. dyn_node_name .. "_fired"})
				return true	
			end
	
				return false
			end,

		})
		return true
	end

	--[[ ***************************************** register throw dinamite ********************************* ]]--
	local throw_dyn_table = {}

	register_throw_dynamite = function (dyn_node_name, dyn_image, dyn_image_fired, explode_cube_half_size, 
						dyn_self_damage, dyn_gravity, dyn_velocity, dyn_lightness, 
						dyn_craft_recipe, change_node_list,callback_node_list)
		-------------dyn_interval, dyn_chance, 
		
		DYNAMITE_TABLE["dynamite:dyn_" .. dyn_node_name] = tostring(explode_cube_half_size)
	
		minetest.register_node("dynamite:dyn_" .. dyn_node_name , {
			drawtype = "plantlike",
			tiles = {dyn_image},
			inventory_image = dyn_image,
			paramtype = "light",
			is_ground_content = true,
			walkable = false,
			sunlight_propagates = true,
			material = minetest.digprop_constanttime(0.4),
			drop = 'craft "dynamite:dyn_' .. dyn_node_name .. '_craft" 1',
		})

		minetest.register_node("dynamite:dyn_" .. dyn_node_name .. "_fired", {
			drawtype = "plantlike",
			tiles = {dyn_image_fired},
			inventory_image = dyn_image,
			paramtype = "light",
			is_ground_content = true,
			walkable = false,
			sunlight_propagates = true,
			light_source = dyn_lightness,
			material = minetest.digprop_constanttime(0.4),
			drop = 'craft "dynamite:dyn_' .. dyn_node_name .. '_craft" 1',
		})  

		throw_dyn_table["dynamite:dyn_" .. dyn_node_name .. "_fired"] = {
			physical = false,
			timer=0,
			textures = {dyn_image_fired},
			lastpos={},
			collisionbox = {0,0,0,0,0,0},
		}
		
		throw_dyn_table["dynamite:dyn_" .. dyn_node_name .. "_fired"].on_step = function(self, dtime)
			self.timer=self.timer+dtime
			local pos = self.object:getpos()
			local node = minetest.env:get_node(pos)

			if self.timer>0.2 then
				local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, explode_cube_half_size)
				for k, obj in pairs(objs) do
					-- damage from a distance--
					local objname = obj:get_entity_name()
					local find_particle = nil
					if objname ~= nil then
						find_particle = string.find(objname,"nparticle:")
					end

					if (find_particle == nil) then
						local objpos = obj:getpos()
						local dist = math.sqrt((pos.x-objpos.x)^2 + (pos.y-objpos.y)^2 + (pos.z-objpos.z)^2)	
						-- /damage from a distance--
						obj:set_hp(obj:get_hp()- dyn_self_damage * (explode_cube_half_size / dist))
						if obj:get_entity_name() ~= "dynamite:" .. dyn_node_name .. "_entity" then
							if obj:get_hp()<=0 then 
								obj:remove()
							end
							self.object:remove()
							explode_area(pos, explode_cube_half_size,change_node_list,callback_node_list) 
						end
					end
				end
			end

			-- Become item when hitting a node
			if self.lastpos.x~=nil then 
				if node.name ~= "air" then
					self.object:remove()
					explode_area(pos, explode_cube_half_size,change_node_list,callback_node_list)
				end
			end
			self.lastpos={x=pos.x, y=pos.y, z=pos.z} 
		end

		minetest.register_entity("dynamite:" .. dyn_node_name .. "_entity", throw_dyn_table["dynamite:dyn_" .. dyn_node_name .. "_fired"])

		dyn_throw= function (item, player, pointed_thing)
				local playerpos=player:getpos()
				local obj=minetest.env:add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, "dynamite:" .. dyn_node_name .. "_entity")
				local dir=player:get_look_dir()
				obj:setvelocity({x=dir.x*dyn_velocity, y=dir.y*dyn_velocity, z=dir.z*dyn_velocity})
				obj:setacceleration({x=dir.x*-3, y=-dyn_gravity, z=dir.z*-3})
			return true
		end

		minetest.register_craft({
			output = 'craft "dynamite:dyn_' .. dyn_node_name .. '_craft" 1',
			recipe = dyn_craft_recipe,
		})

		minetest.register_craftitem("dynamite:dyn_" .. dyn_node_name .. "_craft", {
			image = dyn_image,
			stack_max = 10,
			usable = true,
			dropcount = 1,
			liquids_pointable = false,
	
			on_place_on_ground = function (item, placer, pos)
			minetest.env:add_node(pos, {name="dynamite:dyn_" .. dyn_node_name})
				return true	
			end,

			on_use = dyn_throw,

		})
		return true
	end
--[[	register_throw_dynamite = function (dyn_node_name, dyn_image, dyn_image_fired, explode_cube_half_size, 
						dyn_self_damage, dyn_gravity, dyn_velocity, dyn_lightness, 
						dyn_craft_recipe, change_node_list,callback_node_list)


	register_time_dynamite = function (dyn_node_name, dyn_image, dyn_image_fired, explode_cube_half_size, dyn_interval, dyn_chance, dyn_lightness, 
					dyn_craft_recipe,
						change_node_list,callback_node_list)
]]--
	
	local nnn = register_throw_dynamite("small","dynamite_small.png","dynamite_small_fired.png", 1,
					1, 9, 14, 4,
					{{'node "default:papyrus"','craft "dynamite:coal_dust"','node "default:papyrus"'}},
					{["default:stone"] = "default:gravel",["default:sand"] = "*", ["moreores:mineral_*"] = "*"})

	nnn = register_throw_dynamite("normal","dynamite.png","dynamite_fired.png", 2, 
					2, 9, 14, 6,
					{{'node "default:papyrus"','craft "dynamite:coal_dust"','node "default:papyrus"'},
					{'node "default:papyrus"','craft "dynamite:coal_dust"','node "default:papyrus"'}},
					{["default:stone"] = "default:gravel",["default:sand"] = "*", ["moreores:mineral_*"] = "*"})
	
	nnn = register_time_dynamite("big","dynamite_big.png","dynamite_big_fired.png", 5, 3, 0.9, 12,
					{{'craft "dynamite:dyn_normal_craft"','craft "dynamite:dyn_normal_craft"','craft "dynamite:dyn_normal_craft"'}},
					{["*"] = ""})

	nnn = register_time_dynamite("tsmall","tdynamite_small.png","tdynamite_small_fired.png", 3, 3, 0.9, 8,
					{{'craft "dynamite:dyn_small_craft"','craft "dynamite:dyn_small_craft"'}},
					{["default:stone"] = "default:gravel",["default:sand"] = "*", ["moreores:mineral_*"] = "*"})

	nnn = register_time_dynamite("tnormal","tdynamite.png","tdynamite_fired.png", 4, 3, 0.9, 10,
					{{'craft "dynamite:dyn_normal_craft"','craft "dynamite:dyn_normal_craft"'}},
					{["default:stone"] = "default:gravel",["default:sand"] = "*", ["moreores:mineral_*"] = "*"})

	-------------------------------------------------------------------------------------------

	minetest.register_craft({
		output = 'craft "dynamite:woods" 1',
		recipe = {{'craft "default:stick"','craft "default:stick"','craft "default:stick"'}},
	})

	minetest.register_craftitem("dynamite:woods", {
		image = "woods.png",
		stack_max = 10,
		dropcount = 1,
		liquids_pointable = false,
		on_place_on_ground = function (item, placer, pos)
		minetest.env:add_node(pos, {name="dynamite:fire1"})
		local meta = minetest.env:get_meta(pos)
		meta:set_string("state","1")
		meta:set_infotext("")

		target_node = minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z})

		if (target_node.name == "default:dirt_with_grass") then
			minetest.env:add_node({x=pos.x,y=pos.y-1,z=pos.z}, {name="default:dirt"})
		end
			return true	
		end,
	})

	for i = 1,3 do
		minetest.register_node("dynamite:fire" .. i, {
			drawtype = "plantlike",
			tiles = {"fire" .. i .. ".png"},
			paramtype = "light",
			is_ground_content = true,
			walkable = false,
			sunlight_propagates = false,
			light_source = dyn_lightness,
			damage_per_second = 1*2,
			alpha = 150,
			light_source = 13 + i*2,
			post_effect_color = {a=192, r=255, g=64, b=0},
			material = minetest.digprop_constanttime(0.4),
			drop = 'craft "dynamite:woods" 1',
			metadata_name = "generic",
		})
	
		
	end
	minetest.register_abm({
			nodenames 	= {"dynamite:fire1","dynamite:fire2","dynamite:fire3"},
			interval 	= 0.2,
			chanse		= 1,
			action 		= function(pos, node, _, __)

						local meta = minetest.env:get_meta(pos)						
						local oldstate = meta:get_string("state")
						local newstate = 1

						if oldstate == "" then
							newstate = 1
							meta:set_string("state", "1")
						else
							newstate = tonumber(oldstate) + 1					
							if newstate >= 4 then newstate = 1 end
							meta:set_string("state", newstate)
						end
						
						minetest.env:add_node(pos, {name= ("dynamite:fire".. newstate)})
						local meta = minetest.env:get_meta(pos)	
						meta:set_string("state", newstate)
						meta:set_infotext("")

						local rnd = math.random(1,100)
						--if rnd < 80 then 
							local dynpos = {x=pos.x,y=pos.y+2,z=pos.z}
							minetest.env:add_entity(dynpos,"nparticle:smoke_cloud3_entity")
						--end
					end
		})

print("[Dynamite] Loaded!")


