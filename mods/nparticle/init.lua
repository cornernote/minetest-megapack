--
--
-- 		Author: Nemo08
--		nParticle mod
--
	local version = "0.0.4"
--
--

---------------------------
--[[
-- Profiler stuff
dofile(minetest.get_modpath('nparticle') .. '/profiler.lua')
local profiler = newProfiler()
profiler:start()
local function stopProfiler()
	profiler:stop()
	local outfile = io.open("profile.txt", "w+")
	profiler:report(outfile)
	outfile:close()
end
minetest.register_on_chat_message(function(name, message)
	if message == "/stop" then
		stopProfiler()
		minetest.chat_send_player(name, "Profiler stopped!")
	end
end)
----------------
]]--
	math.randomseed(os.time())

	add_entity_chk = function (pos, name)
		local objs = minetest.env:get_objects_inside_radius(pos,0)
		local find_ent = false
		local n = 0

		if (# objs)~=0 then
			for k, obj in pairs(objs) do
				if (obj:get_entity_name() ~= nil) then
					find_ent = true
					n = n +1
				end
			end
		end
		if find_ent == false then
			minetest.env:add_entity(pos,name)
		end
		return not (find_ent)
	end


--[ ************************************* FIRE2 ***************************************]--

	minetest.register_node("nparticle:lpoint", {
		tiles = {"nparticle_lpoint.png"},
		paramtype = "light",
		walkable = false,
		pointable = false,
		diggable = false,
		drawtype="plantlike",
		buildable_to = false,
		sunlight_propagates = true,
		light_source = 15,
		damage_per_second = 2*2,
		post_effect_color = {a=192, r=255, g=64, b=0},
	})

	minetest.register_abm({
		nodenames 	= {"nparticle:lpoint"},
		interval 	= 6 ,
		chanse		= 1  ,
		action 		= function(pos, node, _, __)
			minetest.env:remove_node(pos)
		end
	})

	FIRE_ENT_MOVE_CUBE = 1    --пределы распространения
	FIRE_ENT_MOVE_CHANSE = 5  --шанс переместиться [1..100]

	local fire_ent_table = {}


	for i=1,3 do

		fire_ent_table['fire' .. i ..'_entity'] = {
			physical = false,
			textures = {"nparticle_fire" .. i .. ".png"},
			lastpos={},
			visual_size = {x=0.8+0.2*i, y=0.8+0.2*i},
			timer = 0,										
			full_timer = 0,									-- counter of full fire life cycle
			my_num = i,										-- state of fire
			burn_time = 2,									-- furn time
			node_burn = false,								-- flag, fire on burnable node
		}

		fire_ent_table['fire' .. i ..'_entity'].on_activate = function(self, data)
			local pos = self.object:getpos()
			local target_node = nil
			local water_close = false        -- water near flag
			local targetnode = minetest.env:get_node(pos)

			if (minetest.registered_nodes[minetest.env:get_node(pos).name].furnace_burntime ~= nil ) then
				self.node_burn = true
				self.burn_time = minetest.registered_nodes[minetest.env:get_node(pos).name].furnace_burntime * 1.2
			end
			
			-- fire in not burnable node??? noway!!
			if (minetest.env:get_node(pos).name ~="air")and(self.node_burn ~= true) then
				self.object:remove()
				nodeupdate(pos)
				return false
			end
			
			-- search for water near
			for x = -1, 1 do
			for y = -1, 1 do
			for z = -1, 1 do
				target_node = minetest.env:get_node({x=pos.x+x,y=pos.y+y,z=pos.z+z})
				if (target_node.name == "default:water_flowing")or(target_node.name == "default:water_source") then
					water_close = true
				end
			end
			end
			end

			-- check the proximity to water
			if not (water_close) then
				-- if node at this pos burnable
				self.burn_time = math.random(3,7)
				minetest.env:remove_node(pos)
				minetest.env:add_node(pos,{name='nparticle:lpoint'})
			else
				minetest.env:remove_node(pos)
				self.object:remove()
				nodeupdate(pos)
			end
		end
			

		fire_ent_table['fire' .. i ..'_entity'].on_step = function(self, dtime)
			self.timer = self.timer + dtime
			self.full_timer = self.full_timer + dtime

			if (self.timer >= self.burn_time) then
				self.timer = 0
				local pos = self.object:getpos()
				if (self.node_burn == false) then
					-- target not burnable node
					for x = -FIRE_ENT_MOVE_CUBE, FIRE_ENT_MOVE_CUBE do
					for y = -FIRE_ENT_MOVE_CUBE, FIRE_ENT_MOVE_CUBE do
					for z = -FIRE_ENT_MOVE_CUBE, FIRE_ENT_MOVE_CUBE do
						local dynpos 	= {x = pos.x+x,y = pos.y+y,z = pos.z+z}
						local targetnode = minetest.env:get_node(dynpos)

						if ((targetnode.name == "air") and (math.random(1,100) < FIRE_ENT_MOVE_CHANSE))	then 
							if self.my_num>2 then
								--minetest.env:add_entity(dynpos,'nparticle:fire' .. (self.my_num+1) ..'_entity')
								add_nfire_single(dynpos,self.my_num-1)
								
							end

							self.object:remove()
							minetest.env:remove_node(pos)	
							nodeupdate(pos)

							if (math.random(1,100) < 15) then
								--minetest.env:add_entity(dynpos,'nparticle:dust_cloud3_entity')
								add_ndust_single(dynpos,3)
							end
						end
					
						if (minetest.registered_nodes[targetnode.name].furnace_burntime ~=nil ) then
							--minetest.env:add_entity(dynpos,'nparticle:fire1_entity')
							add_nfire_single(dynpos,3)
						end
					end
					end
					end
					
				else
					-- target is burnable node
					local dynpos 	= {x = pos.x,y = pos.y+1,z = pos.z}
					local targetnode = minetest.env:get_node(dynpos)
					
					if (targetnode.name == "air") then
						--minetest.env:add_entity(dynpos,'nparticle:smoke_cloud' .. 3.. '_entity')
						add_nsmoke_single(dynpos,2)
					end
					
					for x = -1, 1 do
					for y = -1, 1 do
					for z = -1, 1 do
						local dynpos 	= {x = pos.x+x,y = pos.y+y,z = pos.z+z}
						local targetnode = minetest.env:get_node(dynpos)
						if (minetest.registered_nodes[targetnode.name].furnace_burntime ~=nil ) then
							if (minetest.registered_nodes[targetnode.name].furnace_burntime ~= -1) then
								if (math.random(1,100) < 80) then
									--minetest.env:add_entity(dynpos,'nparticle:fire1_entity')
									add_nfire_single(dynpos,3)
								end
							end
						end
					end
					end
					end
				end
				
				-- selfremove after full life cycle
				if self.full_timer >=(self.burn_time*1.5) then
					minetest.env:remove_node(self.object:getpos())
					self.object:remove()
					nodeupdate(self.object:getpos())
				end
			end			
		end

		minetest.register_entity("nparticle:fire" .. i .. "_entity", fire_ent_table['fire' .. i ..'_entity'])
	end 

--[ ************************************* SMOKE2 ************************************]--

	SMOKE_ENT_MOVE_CUBE = 1    --пределы распространения
	SMOKE_ENT_BREAK_CHANSE = 25  -- [1..100]  шанс частицы "разлететься"
	SMOKE_ENT_MOVE_NODE_CHANSE = 60  -- [1..100]  шанс разлетевшейся частицы попасть в конкретную ячейку

	local smoke_ent_table = {}

	for i=0,4 do
		smoke_ent_table['smoke_cloud' .. i ..'_entity'] = {
			physical = false,
			textures = {"nparticle_smoke" .. i .. ".png"},
			timer = 0,
			full_timer = 0,
			visual_size = {x=0.25+0.5*i, y=0.25+0.5*i},
			my_num =i,
		}
		smoke_ent_table['smoke_cloud' .. i ..'_entity'].on_step = function(self, dtime)
			self.timer = self.timer + dtime
			self.full_timer = self.full_timer + dtime

			if self.timer >= 1.5 then
				self.timer = 0
				local pos = self.object:getpos()
				local this_node = minetest.env:get_node(pos)
				local rand_break = math.random(1,100)
					
					if rand_break <= SMOKE_ENT_BREAK_CHANSE then
						for x = -SMOKE_ENT_MOVE_CUBE,SMOKE_ENT_MOVE_CUBE do
						for y = 0,SMOKE_ENT_MOVE_CUBE do
						for z = -SMOKE_ENT_MOVE_CUBE,SMOKE_ENT_MOVE_CUBE do
							local rand_move = math.random(1,100-y*15)
							if rand_move <= SMOKE_ENT_MOVE_NODE_CHANSE then
								local dynpos 	= {x = pos.x+x,y = pos.y+y,z = pos.z+z}
								local targetnode = minetest.env:get_node(dynpos)
								local rand = math.random(1,100)							
								if (targetnode.name == "air")and (rand<20)and(self.my_num>2) then
										--minetest.env:add_entity(dynpos,'nparticle:smoke_cloud' .. (i-1) ..'_entity')
										add_nsmoke_single(dynpos,self.my_num-1)
								else
									self.object:remove()
								end
								local rand = math.random(1,100)
								if rand<15 then
									self.object:remove()
								end
							end							
						end
						end
						end

					end
			
						local rand = math.random(1,100)  
						local dynpos 	= {x = pos.x,y = pos.y+1,z = pos.z}
						local targetnode = minetest.env:get_node(dynpos)
						if (targetnode.name ~= "air") then
							dynpos 	= {x = (pos.x+math.random(-1,1)),y = pos.y,z = (pos.z+math.random(-1,1))}
							local targetnode = minetest.env:get_node(dynpos)
							if (targetnode.name ~= "air") then
								local dynpos = pos	
							end
						else
							if self.my_num>1 then
								local rand = math.random(1,100)  
								if rand<20 then
									--minetest.env:add_entity(dynpos,'nparticle:smoke_cloud' .. (self.my_num-1) ..'_entity')
									add_nsmoke_single(dynpos,self.my_num-1)
									self.object:remove()
								end
							else
								self.object:remove()							
							end
						end	
			end	
			if self.full_timer>10 then
				self.object:remove()
			end
		end
		
		smoke_ent_table['smoke_cloud' .. i ..'_entity'].on_activate = function(self, staticdata)
			self.object:setvelocity({x=0,y=math.random(1,3),z=0})
		end

		minetest.register_entity("nparticle:smoke_cloud" .. i .. "_entity", smoke_ent_table['smoke_cloud' .. i ..'_entity'])
	end


--[ ************************************* DUST2 ************************************]--
	DUST_ENT_MOVE_CUBE = 2    --пределы распространения
	DUST_ENT_BREAK_CHANSE = 10 -- [1..100]  шанс частицы "разлететься"
	DUST_ENT_MOVE_NODE_CHANSE = 5  -- [1..100]  шанс разлетевшейся частицы попасть в конкретную ячейку

	local dust_ent_table = {}

	for i=0,4 do

		dust_ent_table['dust_cloud' .. i ..'_entity'] = {
			physical = false,
			textures = {"nparticle_dust" .. i .. ".png"},
			lastpos={},
			collisionbox = {0,0,0,0,0,0},
			timer = 0,
			full_timer = 0,
			my_num = i,
		}

		dust_ent_table['dust_cloud' .. i ..'_entity'].on_step = function(self, dtime)
			self.timer = self.timer + dtime
			self.full_timer = self.full_timer + dtime

			if self.timer >= math.random(2,6) then
				self.timer = 0
				local pos = self.object:getpos()
				local rand_move = math.random(1,100)
				local this_node = minetest.env:get_node(pos)
					
				if rand_move <= DUST_ENT_BREAK_CHANSE then
					
					for x = -DUST_ENT_MOVE_CUBE,DUST_ENT_MOVE_CUBE do
					for y = -DUST_ENT_MOVE_CUBE,DUST_ENT_MOVE_CUBE do
					for z = -DUST_ENT_MOVE_CUBE,DUST_ENT_MOVE_CUBE do
					
						if (math.random(1,100)+y*20) <= DUST_ENT_MOVE_NODE_CHANSE then --пыль оседает
							local dynpos 	= {x = pos.x+x,y = pos.y+y,z = pos.z+z}
							local targetnode = minetest.env:get_node(dynpos)			
	
							if (targetnode.name == "air") and (self.my_num > 1) then
								--minetest.env:add_entity(dynpos,'nparticle:dust_cloud' .. (self.my_num-1) ..'_entity')
								add_ndust_single(dynpos,self.my_num-1)
							end
						end
					end
					end
					end
				
					self.object:remove()					
				end			
			end
			if self.full_timer>math.random(8,15) then
				self.object:remove()
			end
		end

		minetest.register_entity("nparticle:dust_cloud" .. i .. "_entity", dust_ent_table['dust_cloud' .. i ..'_entity'])
	end

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end
	
	------------------------------------------------------- API -------------------------------------------
	-- pos - {x,y,z}							--required
	-- power - [ 1 .. 3 ]						--required  -- 3 - strongest

	function add_nfire_single(pos,power)
		--minetest.env:add_entity(pos,'nparticle:fire'.. power.. '_entity')
		add_entity_chk(pos,'nparticle:fire'.. power.. '_entity')
	end

	function add_nfire_cube(pos,power,halfsize,fire_rnd)
		if halfsize>5 then halfsize = 5 end
		for x=-halfsize,halfsize do
			for y=-halfsize,halfsize do
				for z=-halfsize,halfsize do
					if (math.random(1,100)<fire_rnd) then
						minetest.env:add_entity({x=pos.x+x,y=pos.y+y,z=pos.z+z},'nparticle:fire'.. power.. '_entity')
					end
				end
			end
		end
	end

	function add_nfire_sphere(pos,power,radius,fire_rnd)
		if radius>5 then radius = 5 end
		for x=-radius,radius do
			for y=-radius,radius do
				for z=-radius,radius do
					if (math.random(1,100)<fire_rnd) then
						if (math.sqrt((pos.x-(pos.x+x))^2 + (pos.y-(pos.y+y))^2 + (pos.z-(pos.z+z))^2) <= radius) then
							add_nfire_single({x=pos.x+x,y=pos.y+y,z=pos.z+z},power)
						end
					end
				end
			end
		end
	end
	
	-- pos - {x,y,z}							--required
	-- power - [ 1 .. 4 ]						--required  -- 4 - strongest
	function add_ndust_single(pos,power)
		--minetest.env:add_entity(pos,'nparticle:dust_cloud' .. power .. '_entity')
		add_entity_chk(pos,'nparticle:dust_cloud' .. power .. '_entity')
	end	
	-- pos - {x,y,z}							--required
	-- power - [ 1 .. 4 ]						--required  -- 4 - strongest
	
	function add_ndust_cube(pos,power,halfsize,fire_rnd)
		if halfsize>5 then halfsize = 5 end
		for x=-halfsize,halfsize do
			for y=-halfsize,halfsize do
				for z=-halfsize,halfsize do
					if (math.random(1,100)<fire_rnd) then
						minetest.env:add_entity({x=pos.x+x,y=pos.y+y,z=pos.z+z},'nparticle:dust_cloud'.. power.. '_entity')
					end
				end
			end
		end
	end

	function add_ndust_sphere(pos,power,radius,fire_rnd)
		if radius>5 then radius = 5 end
		for x=-radius,radius do
			for y=-radius,radius do
				for z=-radius,radius do
					if (math.random(1,100)<fire_rnd) then
						if (math.sqrt((pos.x-(pos.x+x))^2 + (pos.y-(pos.y+y))^2 + (pos.z-(pos.z+z))^2) <= radius) then
							add_ndust_single({x=pos.x+x,y=pos.y+y,z=pos.z+z},power)
						end
					end
				end
			end
		end
	end
	
	
	function add_nsmoke_single(pos,power)
		--minetest.env:add_entity(pos,'nparticle:smoke_cloud' .. power ..'_entity')
		add_entity_chk(pos,'nparticle:smoke_cloud' .. power ..'_entity')
	end	

	function add_nsmoke_cube(pos,power,halfsize,fire_rnd)
		if halfsize>5 then halfsize = 5 end
		for x=-halfsize,halfsize do
			for y=-halfsize,halfsize do
				for z=-halfsize,halfsize do
					if (math.random(1,100)<fire_rnd) then
						minetest.env:add_entity({x=pos.x+x,y=pos.y+y,z=pos.z+z},'nparticle:smoke_cloud'.. power.. '_entity')
					end
				end
			end
		end
	end

	function add_nsmoke_sphere(pos,power,radius,fire_rnd)
		if radius>5 then radius = 5 end
		for x=-radius,radius do
			for y=-radius,radius do
				for z=-radius,radius do
					if (math.random(1,100)<fire_rnd) then
						if (math.sqrt((pos.x-(pos.x+x))^2 + (pos.y-(pos.y+y))^2 + (pos.z-(pos.z+z))^2) <= radius) then
							add_nsmoke_single({x=pos.x+x,y=pos.y+y,z=pos.z+z},power)
						end
					end
				end
			end
		end
	end
	
	
print("[nParticles " .. version .. "] Loaded!")	
