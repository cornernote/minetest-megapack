local version = "0.0.3"
sliders_gravity = -6

local min_speed_jitter = 0.5


local pushable_block_modpath = minetest.get_modpath("pushable_block")

dofile (pushable_block_modpath .. "/generic_functions.lua")
dofile (pushable_block_modpath .. "/physics.lua")
dofile (pushable_block_modpath .. "/slider.lua")
dofile (pushable_block_modpath .. "/player_interaction.lua")
dofile (pushable_block_modpath .. "/generic_functions.lua")

function fix_speed_above_sliders(entity)

	local ownpos = entity.object:getpos()


	local slidertype =  detect_slider_type(ownpos)

	if slidertype == "inv" then
		entity.moving_up = false
		return
	end


	local current_speed = entity.object:getvelocity()
	

	--link to straight slider
	if slidertype == "x" then
		ownpos.z = math.floor(ownpos.z + 0.5)
		ownpos.y = math.floor(ownpos.y + 0.5)
		current_speed.z = 0	
	end

	if slidertype == "z" then
		ownpos.x = math.floor(ownpos.x + 0.5)
		ownpos.y = math.floor(ownpos.y + 0.5)
		current_speed.x = 0
	end

	--required for some normal calculations
	local zpos_rounded = math.floor(ownpos.z + 0.5)
	local xpos_rounded = math.floor(ownpos.x + 0.5)


	if 	slidertype == "x-u" or
		slidertype == "x+u" or 
		slidertype == "z-u" or
		slidertype == "z+u" or
		slidertype == "x-b" or
		slidertype == "x+b" or 
		slidertype == "z-b" or
		slidertype == "z+b" then
		
		entity.moving_up = true
		--print("Moving up: " .. slidertype)
	else
		---print("NOT Moving up: " .. slidertype)
		entity.moving_up = false
	end


	local toinc_y = 0

	--moving from x direction up/down
	if (slidertype == "x-u" and ownpos.x >= xpos_rounded) or
		(slidertype == "x+u" and ownpos.x <= xpos_rounded)	 then		

		toinc_y = 1 - math.abs((xpos_rounded - ownpos.x) *2)

	end

	if (slidertype == "x-b" and ownpos.x >= xpos_rounded) or
		(slidertype == "x+b" and ownpos.x <= xpos_rounded) then
		
		toinc_y = 1 - math.abs((ownpos.x - xpos_rounded) *2) + 0.1 * math.abs(current_speed.x)

	end

	--moving z direction up/down
	if (slidertype == "z-u" and ownpos.z >= zpos_rounded) or
		(slidertype == "z+u" and ownpos.z <= zpos_rounded)	 then
		
		toinc_y = 1 - math.abs((zpos_rounded - ownpos.z) *2)
	end

	if (slidertype == "z-b" and ownpos.z >= zpos_rounded) or
		(slidertype == "z+b" and ownpos.z <= zpos_rounded) then
		
		toinc_y = 1 - math.abs((ownpos.z - zpos_rounded) *2) + 0.1 * math.abs(current_speed.z)

	end


	--really increase y value
	if (toinc_y > 0) then
		if toinc_y > 1.2 then
			toinc_y = 1.2
		end

		local ground_level = get_ground_level(ownpos)
		
		ownpos.y = ground_level.y + toinc_y

	end




	if slidertype == "x+" then

		if ownpos.z  >= zpos_rounded and
			current_speed.z > 0 then
			
			print("dir change z+ -> x+")
		
			current_speed.x = math.abs(current_speed.z)
			current_speed.z = 0
		
			ownpos.z = math.floor(ownpos.z + 0.5)
		

		else
			if ownpos.x <= xpos_rounded and
			current_speed.x < 0 then
				print("dir change x- -> z-")

				current_speed.z = - math.abs(current_speed.x)
				current_speed.x = 0
				
	
				ownpos.x = math.floor(ownpos.x + 0.5)
			end
		end
	end

	if slidertype == "x-" then
		if ownpos.z >= zpos_rounded and
			current_speed.z > 0 then

			print("dir change z+ ->  x-")
		
			current_speed.x = - math.abs(current_speed.z)
			current_speed.z = 0
		
			ownpos.z = math.floor(ownpos.z + 0.5)
		else
			if ownpos.x >= xpos_rounded and
				current_speed.x > 0 then

				print("dir change x+ -> z-")
		
				current_speed.z = - math.abs(current_speed.x)
				current_speed.x = 0 
				
		
				ownpos.x = math.floor(ownpos.x + 0.5)
			end
		end
	end


	if slidertype == "z+" then
		if ownpos.x <= xpos_rounded and
			current_speed.x < 0 then

			print("dir change x- -> z+")
		
			current_speed.z = math.abs(current_speed.x)
			current_speed.x = 0
		
			ownpos.x = math.floor(ownpos.x + 0.5)
		else
			if ownpos.z <= zpos_rounded and
				current_speed.z < 0 then

				print("dir change z- -> x-")
		
				current_speed.x = math.abs(current_speed.z)
				current_speed.z = 0
				
		
				ownpos.x = math.floor(ownpos.x + 0.5)
			end
		end
	end


	if slidertype == "z-" then
		if ownpos.x >= xpos_rounded and
			current_speed.x > 0 then

			print("dir change x+ -> z+")
		
			current_speed.z = math.abs(current_speed.x)
			current_speed.x = 0
		
			ownpos.x = math.floor(ownpos.x + 0.5)
		else

			if ownpos.z <= zpos_rounded and
				current_speed.z < 0 then

				print("dir change z- -> x-")
		
				current_speed.x = - math.abs(current_speed.z)
				current_speed.z = 0 
				
		
				ownpos.z = math.floor(ownpos.z + 0.5)
			end
		end
	end

	entity.object:moveto(ownpos)
	entity.object:setvelocity(current_speed)

	return slidertype
end

minetest.register_entity(":pushable_block:moveblock_ent",
		 {
		     physical = true,
		     collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
--needs minetest patch
--		     visual = "plant",
		     visual = "cube",
		     textures = {"minecart_top.png","minecart_bottom.png","minecart_side.png","minecart_side.png","minecart_front.png","minecart_back.png"},
		      on_step = function(self, dtime)
					
					local slidertype = fix_speed_above_sliders(self)

					local current_velocity = self.object:getvelocity()
					local current_acceleration = self.object:getacceleration()
					local speed_fix = false

					local gravity 		= calc_gravity(slidertype)


					--don't do anything if block ain't moving
					if current_velocity.z == 0 and
						current_velocity.x == 0 and
						current_acceleration.x == 0 and
						current_acceleration.z == 0 and
						gravity.x == 0 and
						gravity.z == 0 then
						return
					end

					

					--make block stop on beeing to slow
					if math.abs(current_velocity.x) < min_speed_jitter
						then
						current_velocity.x = 0
						speed_fix = true
					end
		
					if math.abs(current_velocity.z) < min_speed_jitter then
						current_velocity.z = 0
						speed_fix = true
					end 

					if speed_fix then
						self.object:setvelocity(current_velocity)
						--print("Fixing speed below threshold")	
					end

					
			
					if current_velocity.z == 0 and
						current_velocity.x == 0 and
						gravity.x == 0 and
						gravity.z == 0 then

						self.object:setacceleration({x=0,y=current_velocity.y,z=0})	
	
						--print("Block to slow stopping")	
						return
					end
						

					--print("current velocity:" .. printpos(current_velocity))


					--calculate acceleration modifiers
					local resistance 	= calc_resistance(current_velocity)
					local current_friction 	= calc_friction(current_velocity,self.object:getpos())
					
					local boost 		= get_boost(current_velocity,self.object:getpos())


					local new_accel = {x=0,y=sliders_gravity,z=0}

					new_accel.x = resistance.x + current_friction.x + gravity.x + boost.x
					new_accel.z = resistance.z + current_friction.z + gravity.z + boost.z


					if self.moving_up then
						--print("moving up no y acceleration")
						new_accel.y = 0
					end

					--print("setting accel:" .. printpos(new_accel))
					--print("setting z-accel: " .. resistance.z .. ",".. current_friction.z .. "," ..gravity.z .. "," .. boost.z)
					--print("setting x-accel: " .. resistance.x .. ",".. current_friction.x .. "," ..gravity.x .. "," .. boost.x)

					self.object:setacceleration(new_accel)	

					if self.linkedplayer ~= nil then
						local pos = self.object:getpos()
						self.linkedplayer:setpos({x=pos.x,y=pos.y+0.1,z=pos.z})
						--self.linkedplayer:setpos(pos)
						self.linkedplayer:setvelocity(current_velocity)
						self.linkedplayer:setacceleration(new_accel)
					end			 	
					end,
		      on_punch = function(self, hitter)

					local own_pos = self.object:getpos()

					local current_velocity = self.object:getvelocity()

					local speed_change = calc_accel_on_sliders(own_pos,hitter:getpos(hitter))


					local cleant_pos = round_pos(own_pos)

					

					if speed_change.z == 0 then
						self.object:moveto(cleant_pos)
						current_velocity.z = 0
						current_velocity.x = current_velocity.x + speed_change.x						
					end

					if speed_change.x == 0 then
						self.object:moveto(cleant_pos)
						current_velocity.x = 0
						current_velocity.z = current_velocity.z + speed_change.z
					end


					print("setting speed by punch: x="..current_velocity.x .. " z="..current_velocity.z .. " dir=".. speed_change.dir)	
					
					if speed_change.dir == "inv" then
						 current_velocity = {x = current_velocity.x + speed_change.x, y= current_velocity.y, z = current_velocity.z + speed_change.z}
					end

					self.object:setvelocity(current_velocity)
					end,


			on_activate = function(self,staticdata)
				self.object:setacceleration({x=0,y=sliders_gravity,z=0})
				--self.object:remove()
			end,

			on_rightclick = function(self,clicker)
				if self.linkedplayer == nil then
					print("linking player")
					self.linkedplayer = clicker
				else
					print("unlinking player")
					self.linkedplayer = nil
					clicker:get_inventory():add_item('main', 'pushable_block:moveblock')
					self.object:remove()
				end
				--print("Info: "..detect_slider_type(self.object:getpos()).. " :",self.moving_up)
				--clicker:add_to_inventory('craft "pushable_block:moveblock"')
				--self.object:remove()

			end,

			moving_up = false,
			linkedplayer = nil,
		 })

minetest.register_node("pushable_block:moveblock", {
	tile_images = {"minecart_top.png","minecart_bottom.png","minecart_side.png","minecart_side.png","minecart_front.png","minecart_back.png"},
	inventory_image = minetest.inventorycube("minecart_top.png",
			"minecart_front.png", "minecart_side.png"),
	dug_item = '', -- Get nothing
	material = {
		groups = {bendy=2,snappy=1,dig_immediate=2},
	},
	description = "Minecart",
})
	minetest.register_on_placenode(function(p, node)
	if node.name == "pushable_block:moveblock" then
		minetest.env:remove_node(p)
		minetest.env:add_entity(p, "pushable_block:moveblock_ent")	
			end
		--minetest.env:add_entity(p, "nuke:iron_tnt2") <-in case you forget
		nodeupdate(p)
end)
		
	minetest.register_craft({
		output = 'craft "pushable_block:moveblock" 1',
		recipe = {
			{'default:steel_ingot','','default:steel_ingot'},
			{'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
		}
	})

	minetest.register_craft({
	output = 'node "pushable_block:slider" 20',
	recipe = {
		{'node "default:cobble"', 'node "default:sand"','node "default:cobble"'},
		{'node "default:sand"', 'node "default:cobble"', 'node "default:sand"'},
		{'node "default:cobble"', 'node "default:sand"','node "default:cobble"'},
	}
	})


	minetest.register_craft({
	output = 'node "pushable_block:booster" 10',
	recipe = {
		{'node "default:cobble"', 'node "default:sand"','node "default:cobble"'},
		{'node "default:sand"', 'node "default:glass" 0', 'node "default:sand"'},
		{'node "default:cobble"', 'node "default:sand"','node "default:cobble"'},
	}
	})

	minetest.register_node("pushable_block:slider", {
	drawtype = "raillike",
	tile_images = {"pushable_block_slider.png", "pushable_block_slider.png", "pushable_block_slider.png", "pushable_block_slider.png"},
	inventory_image = "pushable_block_slider.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	groups = {bendy=2,snappy=1,dig_immediate=2},
	})

	minetest.register_node("pushable_block:booster", {
	drawtype = "raillike",
	tile_images = {"pushable_block_booster.png", "pushable_block_booster.png", "pushable_block_booster.png", "pushable_block_booster.png"},
	inventory_image = "pushable_block_booster.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		--fixed = <default>
	},
	groups = {bendy=2,snappy=1,dig_immediate=2},
	})


print("pushable block " .. version .. " mod loaded")
