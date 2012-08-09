-- minetest/domob/init.lua
-- See README.txt for licensing and other information.

local v3 = {}
function v3.new(x, y, z)
	if x == nil then
		return {
			x = 0,
			y = 0,
			z = 0
		}
	end
	if type(x) == "table" then
		return {
			x = x.x,
			y = x.y,
			z = x.z,
		}
	end
	return {
		x = x,
		y = y,
		z = z,
	}
end
function v3.floor(v)
	return {
		x = math.floor(v.x),
		y = math.floor(v.y),
		z = math.floor(v.z),
	}
end
function v3.cmp(v, w)
	return (
		v.x == w.x and
		v.y == w.y and
		v.z == w.z
	)
end
function v3.add(v, w)
	return {
		x = v.x + w.x,
		y = v.y + w.y,
		z = v.z + w.z,
	}
end
function v3.sub(v, w)
	return {
		x = v.x - w.x,
		y = v.y - w.y,
		z = v.z - w.z,
	}
end
function v3.mul(v, a)
	return {
		x = v.x * a,
		y = v.y * a,
		z = v.z * a,
	}
end
function v3.len(v)
	return math.sqrt(
		math.pow(v.x, 2) +
		math.pow(v.y, 2) +
		math.pow(v.z, 2)
	)
end
function v3.norm(v)
	return v3.mul(v, 1.0 / v3.len(v))
end
function v3.distance(v, w)
	return math.sqrt(
		math.pow(v.x - w.x, 2) +
		math.pow(v.y - w.y, 2) +
		math.pow(v.z - w.z, 2)
	)
end

local domob = {}

function domob.debug(msg)
	minetest.log("action", "domob: "..msg)
	minetest.chat_send_all("domob: "..msg)
end

function domob.node_is_solid(n)
	return (n and n.name and minetest.registered_nodes[n.name] and
			minetest.registered_nodes[n.name].walkable)
end
--[[
minetest.register_entity("domob:dm_fireball", {
	initial_properties = {
		hp_max = 1,
		physical = true,
		collisionbox = {-0.2,-0.2,-0.2, 0.2,0.2,0.2},
		visual = "sprite",
		visual_size = {x=1, y=1},
		textures = {"domob_fireball.png^[makealpha:128,128,0"},
		spritediv = {x=1, y=3},
		initial_sprite_basepos = {x=0, y=0},
		makes_footstep_sound = true,
	},

	on_activate = function(self, staticdata)
		-- Umm... water damage? whatever...
		self.object:set_armor_groups({water=1})

		--self.object:setacceleration({x=0,y=0,z=0})
		
		self.object:setsprite({x=0, y=0}, 3, 0.2, true)

		--minetest.sound_play({name="fire_small"},
		--		{object=self.object, loop=true})
	end,

	get_staticdata = function(self)
	end,

	on_step = function(self, dtime)
		if v3.len(self.object:getvelocity()) < 0.1 then
			--self.object:remove()
		end
	end,

	on_punch = function(self, hitter)
		self.object:remove()
	end,
})]]--

minetest.register_entity("domob:domob", {
	initial_properties = {
		hp_max = 20,
		physical = true,
		--collisionbox = {-0.4,-1.38,-0.4, 0.4,1.1,0.4},
		--visual_size = {x=2, y=3},
		collisionbox = {-0.4,-1.1,-0.4, 0.4,0,0.4},
		visual_size = {x=1, y=2},
		visual = "sprite",
		textures = {"domob_domob.png"},
		spritediv = {x=2, y=1},
		initial_sprite_basepos = {x=0, y=0},
		makes_footstep_sound = true,
	},

	on_activate = function(self, staticdata)
		--domob.debug("DM: on_activate()")

		self.object:setsprite({x=0, y=0}, 1, 0.5, true)
		self.object:setyaw(0)
		self.object:set_armor_groups({fleshy=3})
		self.object:setacceleration({x=0,y=-10,z=0})
		
		self.nextp = nil
		self.nextp_travelled_time = 0
		self.nextp_nil_counter = 0

		--self.nextp = v3.add(self.lastp, v3.new(0, 1, 0))
	end,

	to_feet_pos = function(selfp)
		return v3.add(selfp, v3.new(0, -0.9, 0))
	end,
	from_feet_pos = function(feetp)
		return v3.add(feetp, v3.new(0, 0.95, 0))
	end,
	get_under_feet_pos = function(selfp)
		return v3.add(selfp, v3.new(0, -1.20, 0))
	end,
    
	get_staticdata = function(self)
	end,

	has_traction = function(self)
		for dx=-1,1 do
		for dz=-1,1 do
			local fp0 = self.get_under_feet_pos(self.object:getpos())
			local fp = v3.add(fp0, v3.new(dx*0.5, 0, dz*0.5))
			local n = minetest.env:get_node(fp)
			if domob.node_is_solid(n) then
				return true
			end
		end
		end
		return false
	end,

	get_next_routepoint = function(self)
		--domob.debug("DM: get_next_routepoint()")

		-- If standing in ground, walk up from there
		local cur_fp = self.to_feet_pos(self.object:getpos())
		if domob.node_is_solid(minetest.env:get_node(cur_fp)) then
			--domob.debug("DM:get_next_routepoint(): raising up from ground")
			return self.from_feet_pos(
					v3.add(cur_fp, v3.new(0, 1, 0)))
		end
		
		-- Walk somewhere
		local possible_dsts = {}
		local dirs = {
			{x=-1, y=0, z=0},
			{x=1, y=0, z=0},
			{x=0, y=0, z=-1},
			{x=0, y=0, z=1},

			{x=-1, y=1, z=0},
			{x=1, y=1, z=0},
			{x=0, y=1, z=-1},
			{x=0, y=1, z=1},

			{x=-1, y=-1, z=0},
			{x=1, y=-1, z=0},
			{x=0, y=-1, z=-1},
			{x=0, y=-1, z=1},




		}
		for _,dp in ipairs(dirs) do
			local fp0 = self.to_feet_pos(self.object:getpos())
			local fp = v3.add(fp0, dp)
			local n = minetest.env:get_node(fp)
			if not domob.node_is_solid(n) and
					domob.node_is_solid(minetest.env:get_node(v3.add(fp, v3.new(0,-1,0)))) then
				table.insert(possible_dsts, fp)
			end
		end
		if #possible_dsts > 0 then
			local i = math.random(1, #possible_dsts)
			--domob.debug("DM: Selecting random destination")
			return self.from_feet_pos(possible_dsts[i])
		end
		--[[
		local new_fp = v3.add(cur_fp, v3.new(1, 0, 0))
		if not domob.node_is_solid(minetest.env:get_node(new_fp)) then
			return self.from_feet_pos(new_fp)
		end]]
		--domob.debug("DM: No destination found")
	end,

	on_step = function(self, dtime)
		local speed = 0.2

		-- If travelled long, discard next position
		self.nextp_travelled_time  = self.nextp_travelled_time + dtime
		if self.nextp_travelled_time > 4.0 then
			--domob.debug("DM: Travelled for too long; discarding target")
			self.nextp = nil
		end
		
		-- Try to figure out next position
		if not self.nextp then
			self.nextp_nil_counter = self.nextp_nil_counter + dtime
			if self.nextp_nil_counter < 2.0 then
				self.object:setvelocity(v3.new(0,0,0))
				return
			end
			--domob.debug("DM: Figuring out next position")
			self.nextp = self:get_next_routepoint()
			self.nextp_travelled_time = 0
			self.nextp_nil_counter = 0
		end

		if not self.nextp or not self:has_traction() then
			--domob.debug("DM: No next position or no traction")
			self.nextp = nil
			--self.set_properties({})
			self.object:setacceleration({x=0,y=-10,z=0})
			self.object:setsprite({x=0, y=0}, 1, 0.5, true)
		else
			----domob.debug("DM: Next position known and has traction")
			local d_at_speed = dtime * speed
			local fp = self.object:getpos()
			local d_total = v3.distance(fp, self.nextp)
			-- Move only if the overall movement is not unusually long
			if d_total >= 2.0 then
				--domob.debug("DM: Cancelling move, too long distance")
				self.nextp = nil
			else
				self.object:setacceleration(v3.new(0,0,0))
				if d_at_speed >= d_total then
					--domob.debug("DM: Finishing travel to nextp")
					fp = self.nextp
					self.object:setpos(fp)
					if math.random(1,2) == 1 then minetest.sound_play({name='domob', gain=1.5}, {pos=fp, loop=false}) end
					self.nextp = nil
					self.object:setsprite({x=0, y=0}, 1, 0.5, true)
				else
					----domob.debug("DM: Travelling")

					local nextpdiff = v3.sub(self.nextp, fp)
					local add = v3.mul(v3.norm(nextpdiff), d_at_speed)
					fp = v3.add(fp, add)
					self.object:setpos(fp)
					self.object:setvelocity(v3.add(v3.mul(v3.norm(nextpdiff), speed),
							v3.new(0,0,0)))

					self.object:setsprite({x=0, y=1}, 2, 0.5, true)
					if nextpdiff.x > 0 then
						self.object:setyaw(0)
					elseif nextpdiff.z < 0 then
						self.object:setyaw(math.pi*3/2)
					elseif nextpdiff.x < 0 then
						self.object:setyaw(math.pi)
					else
						self.object:setyaw(math.pi*1/2)
					end
				end
			end
		end
	end,

	on_punch = function(self, hitter)
	end,
})


minetest.register_chatcommand("domob", {
	params = "<none>",
	description = "spawn a domob",
	privs = {server=true},
	func = function(name, param)
		local pos = minetest.env:get_player_by_name(name):getpos()
		minetest.env:add_entity(pos,"domob:domob")

	end,		})

