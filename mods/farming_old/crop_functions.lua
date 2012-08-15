local registred_crops = {}

-------------------------------------------------------------------------------
-- name: get_node_type(nodename)
--
-- action: return type of node
--
-- param1: name of base node
-- retval: -
-------------------------------------------------------------------------------
local get_node_type = function(nodename) 

	for index,value in ipairs(registred_crops) do 
		local tocheck = value[7]..":"..value[1] .. "_node"
		if nodename == tocheck then
			return {value[1],value[7]}
		end
	end
	
	return nil
end


-------------------------------------------------------------------------------
-- name: contains_crop_name(string)
--
-- action: does name contain a crop string
--
-- param1: name of base node
-- retval: -
-------------------------------------------------------------------------------
function contains_crop_name(string)
	for index,value in ipairs(registred_crops) do 
		
		if string == value[7]..":"..value[1] .. "_node" then
			return true
		end
		
	end

	return false
end

-------------------------------------------------------------------------------
-- name: farming_on_dignode(p, node, digger)
--
-- action: dignode handler handling harvesting
--
-- param1: name of base node
-- retval: -
-------------------------------------------------------------------------------
function farming_on_dignode(p, node, digger)

	--print("FARMING: node digged")
	local croptype = get_node_type(node.name)

	if croptype ~= nil then
		local tool = digger:get_wielded_item()

		local durability = is_hoe(tool:get_name())
		--only give crop and seed if used hoe
		if durability then
			local dmg = 65635/durability
			--print("hoe for farming detected")
			damage_wielded_item(digger,dmg)

			digger:get_inventory():add_item("main", croptype[2]..':'..croptype[1].." 1")

			local randomval = math.random()

			if randomval < 0.10 then
				digger:get_inventory():add_item("main", croptype[2]..':'..croptype[1].." 1")
			end			

			randomval = math.random()

			--large chance of getting seed
			if randomval < 0.95 then

				digger:get_inventory():add_item("main", croptype[2]..':seed_'..croptype[1].." 1")
				end

			randomval = math.random()

			if randomval < 0.45 then
				digger:get_inventory():add_item("main", croptype[2]..':seed_'..croptype[1].." 1")
				end
				
			return
		end	
			
	end
	return
end

-------------------------------------------------------------------------------
-- name: farming_on_punchnode(p, node, digger)
--
-- action: get seeds if punching seedsource with hoe
--
-- param1: name of base node
-- retval: -
-------------------------------------------------------------------------------
function farming_on_punchnode(p, node,puncher)

	local tool = puncher:get_wielded_item()

	if tool then
		local durability = is_hoe(tool:get_name())
		if durability then
	
			local playername = puncher.get_player_name(puncher)

			if node then
				local dmg = 65635/durability
				--print("Player ",playername, "is punching ", node.name, " with a hoe")
		
				if is_plowable(node.name) then
					local toadd = { type="node", name="farming:plowed" }

					if node.name == "default:dirt_with_grass" then
						local randomval = math.random()

						for index,value in ipairs(registred_crops) do 
							--print("players chance is: ",randomval)
							if randomval < value[3] then
								puncher:get_inventory():add_item("main", value[7]..':seed_'..value[1].." 1")
								--randomize chance for next crop
								randomval = math.random()
								end
						end
					end

					minetest.env:remove_node(p)
					minetest.env:add_node(p,toadd)

					--decrease hoe durability
					--print("Damaging hoe by " .. dmg)
					damage_wielded_item(puncher,dmg)
					return false
				end

				if node.name == "default:junglegrass" then
					print("Junglegrass is possible seed source")
					local randomval = math.random()

					for index,value in ipairs(registred_crops) do 
						--print("players chance is: ",randomval)
						if randomval < value[4] then
							puncher:get_inventory():add_item("main", value[7]..':seed_'..value[1].." 1")
							--randomize chance for next crop
							randomval = math.random()
							end
					end

					minetest.env:remove_node(p)

					--decrease hoe durability
					damage_wielded_item(puncher,dmg)
				end

				if node.name == "farming:tallgrass" then
					--print("Tallgrass is possible seed source")
					local randomval = math.random()

					for index,value in ipairs(registred_crops) do 
						--print("players chance is: "..randomval.." crop chance is: ".. value[5])
						if randomval < value[5] then
							puncher:get_inventory():add_item("main", value[7]..':seed_'..value[1].." 1")
							--randomize chance for next crop
							randomval = math.random()
							end
					end

					minetest.env:remove_node(p)
		
					--decrease hoe durability
					damage_wielded_item(puncher,dmg)
				end

				
			end
			
		end

	end

	return true
	
end

-------------------------------------------------------------------------------
-- name:handle_onstep_event(self,now) 
--
-- action: register all entitys and nodes required for a crop to grow
--
-- param1: entity to grow
-- param2: current time
-- retval: -
-------------------------------------------------------------------------------
function handle_onstep_event(self,now)
	local pos = self.object:getpos()
	local light = minetest.env:get_node_light(pos,nil)

	if light >= 15 then
		if is_water_nearby(self.object:getpos(),self.farming_max_waterdistance) then
			self.timepassed = self.timepassed + (now - self.farming_last_update)
		else
			self.timewithoutwater = self.timewithoutwater + (now - self.farming_last_update)
		end
	end

	if self.timepassed > self.farming_grow_time then
		--print("Growing at light lvl",light)
		self.object:remove()
		if self.farming_lvl < 6 then
			minetest.env:add_entity(pos,self.farming_modname..":"..self.farming_basename.."_lvl"..(self.farming_lvl+1))
		else
			local toadd = { type="node", name=self.farming_modname..":"..self.farming_basename .. "_node" }
			minetest.env:add_node(pos,toadd)
			--make sure there is a dirt bed below
			check_node_below({x=pos.x,y=pos.y-1,z=pos.z})
		end
	end

	if self.timewithoutwater > self.farming_grow_time then
		self.object:remove()
	end

end


-------------------------------------------------------------------------------
-- name:farming_add_crop(value) 
--
-- action: register all entitys and nodes required for a crop to grow
--
-- param1: name of base node
-- retval: -
-------------------------------------------------------------------------------
function farming_add_crop(value) 
	--add growing level entitys
	for lvl = 1, 6, 1 do
		minetest.register_entity(":"..value[7]..":"..value[1].."_lvl"..lvl,
		 {
		     physical = true,
		     collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
--needs minetest patch
--		     visual = "plant",
		     visual = "sprite",
		     textures = {value[7].."_"..value[1].."_lvl"..lvl..".png"},
		      on_step = function(self, dtime)
				 	local now = farming_get_current_time()

					if self.farming_last_update < now then
						handle_onstep_event(self,now)
						self.farming_last_update = now 
					end


					end
					,
		      on_punch = function(self, hitter)
					local tool = hitter.get_wielded_item(hitter)
					if tool then
						local durability = is_hoe(tool.name)
						if durability then
							local dmg = 65635/durability
							hitter:damage_wielded_item(dmg)		
							self.object:remove()
							end			
						end
					end,

		     on_activate = function(self,staticdata)
					
						self.farming_last_update = farming_get_current_time()
						
						if staticdata ~= nil then
							self.timepassed = tonumber(staticdata)
						end
						
						local pos = self.object:getpos()
		
						if check_node_below({x=pos.x,y=pos.y-1,z=pos.z}) ~= true then
							--print("Crop not growing upon plowed land!")						
							self.object:remove()
						end
					
					end,
					
			 get_staticdata = function(self)
			 			return self.timepassed
			 		end,
			 		
		     timepassed = 0,
		     timewithoutwater = 0,
		     farming_name 		= value[7].."_"..value[1],
		     
		     farming_basename		= value[1],
		     farming_grow_time 		= value[2],
		     farming_max_waterdistance 	= value[6],
		     farming_modname            = value[7],
		     farming_lvl                = lvl,
		     farming_last_update 	= 0,

		     farming_workaround_entity_removed = false,
		 })
	end

	--add harvestable node
	minetest.register_node(value[7]..":"..value[1] .. "_node", {
		drawtype = "plantlike",
		tiles = {value[7].."_"..value[1].."_harvestable.png"},
		paramtype = "light",
		--is_ground_content = true,
		walkable = false,
       	material = minetest.digprop_constanttime(0.4),
		drop =  value[7]..":"..value[1].."_straw" ,
		visual_scale = PLANTS_VISUAL_SCALE,
	})

	--add result crop
	minetest.register_craftitem(value[7]..":"..value[1], {
		description = "Crop " .. value[1],
		image = value[7].."_"..value[1]..".png",
	})

	--add result straw
	minetest.register_node(value[7]..":"..value[1].."_straw", {
		description = "Straw (" .. value[1] .. ")",
		tiles = {value[7].."_"..value[1].."_straw.png",
				value[7].."_"..value[1].."_straw.png",
				value[7].."_"..value[1].."_straw.png",
				value[7].."_"..value[1].."_straw.png",
				value[7].."_"..value[1].."_straw.png",
				value[7].."_"..value[1].."_straw.png"},
		drawtype = "normal",
			inventory_image = minetest.inventorycube(value[7].."_"..value[1].."_straw.png",
			value[7].."_"..value[1].."_straw.png", value[7].."_"..value[1].."_straw.png"),
		furnace_burntime = 0.1,
		material = minetest.digprop_constanttime(0.1),
	})

	--add seed for crop
	minetest.register_craftitem(value[7]..":seed_"..value[1], {
		description = "Seed " .. value[1],
		image = value[7].."_seed_"..value[1]..".png",
		on_place = function(item,place,pointed_thing)
			if pointed_thing.type == "node" then
				local pos = pointed_thing.above
				local node = minetest.env:get_node(pos)

				if node.name == "air" then
					local pos_bottom = { x=pos.x,y=pos.y-1,z=pos.z }
		
					local bottom_node = minetest.env:get_node(pos_bottom)

					if bottom_node.name == "farming:plowed" then

						minetest.env:add_entity(pos,value[7]..":"..value[1].."_lvl1")
						item:take_item(1)
					end
				end
			end

			return item
		end
	})


	--increase crop count, reqired for randomizing seed gain

	table.insert(registred_crops,value)
end
