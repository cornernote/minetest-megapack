SLIME_SIZE = 0.5
SLIME_BOX = math.sqrt(2*math.pow(SLIME_SIZE, 2))/2
GRAVITY = 9.8

minetest.register_entity("slimes:small",{
	initial_properties = {
		hp_max = 4,
		visual_size = {x = SLIME_SIZE, y = SLIME_SIZE, z = SLIME_SIZE},
		visual = "cube",
		textures = {
			"slime_top.png",
			"slime_bottom.png",
			"slime_front.png",
			"slime_sides.png",
			"slime_sides.png",
			"slime_sides.png",
		},
		collisionbox = {-SLIME_BOX, -SLIME_SIZE/2, -SLIME_BOX, SLIME_BOX, SLIME_SIZE/2, SLIME_BOX},
		physical = true,
	},

	timer = 6,
	timer2 = 1,
	timer3 = 0, --regularly check if slime touches ground and possibly set x/z velocity/acceleration to 0
	yaw = 0,
	direction = {},
	status = 2, --1 = jump, 2 = rotate
	attracts_slime = true,
	found_friend = false,

	on_activate = function(self)
		self.object:setacceleration({x = 0, y = -GRAVITY, z = 0})
	end,

	on_punch = function(self)
		if self.object:get_hp() <= 0 then
			minetest.env:add_item(self.object:getpos(), "mesecons_materials:glue 4")
			self.object:remove()
		end
	end,

	on_step = function(self, dtime)
		self.timer2 = self.timer2 + dtime
		if self.status == 2 and (self.timer2 >= 0.5) then
			self.timer2 = 1.2
			self.status = 1

			local pos = self.object:getpos()
			if slime_lonely(pos) and not minetest.env:find_node_near(pos, 16, "default:mese") then
				self.object:remove()
			end
			self.yaw = slime_getyaw(pos)
			if self.yaw == false then
				self.yaw = math.random() * 360
				self.found_friend = false
			else
				self.found_friend = true
			end
			self.object:setyaw(self.yaw)
			self.object:set_properties({automatic_rotate = 0})
			self.direction = {x = math.cos(self.yaw)*2, y = 6, z = math.sin(self.yaw)*2}
		end


		self.timer = self.timer + dtime
		self.timer3 = self.timer3 + dtime

		if self.timer2 > 1.3 and self.object:getvelocity().y == 0 then
			self.object:setvelocity(self.direction)
			self.object:setacceleration({x = self.direction.x/5, y = -GRAVITY, z = self.direction.z/5})
			self.timer2 = 0
		end

		if (self.timer >= 6 or (self.timer >= 1 and self.found_friend == true)) and self.object:getvelocity().y == 0 then
			self.timer = 0
			self.timer2 = 0

			self.status = 2
			if not self.found_friend then
				self.object:set_properties({automatic_rotate = math.pi * 8})
			end
		end

		if self.timer3 > 0.07 then
			vel = self.object:getvelocity()
			if vel.y == 0 and (vel.x ~= 0 or vel.z ~= 0) then
				self.object:setvelocity({x = 0, y = 0, z = 0})
				self.object:setacceleration({x = 0, y = -GRAVITY, z = 0})
			end
			self.timer3 = 0
		end
	end,
})

function slime_lonely (pos)
	objs = minetest.env:get_objects_inside_radius(pos, 32)
	for i, obj in pairs(objs) do
		if obj:is_player() then return false end
	end
	return true
end

function approx(val1, val2, deviation)
	if val1 + deviation > val2
	and val1 - deviation < val2 then
		return true
	end
	return false
end

function slime_getyaw (pos) -- get yaw, only if objects to follow nearby
	objs = minetest.env:get_objects_inside_radius(pos, 7)
	for i, obj in ipairs(objs) do
		if obj:is_player() or obj:get_luaentity().name == "slimes:small" then
			local ppos = {x = obj:getpos().x - pos.x,
				      z = obj:getpos().z - pos.z}
			if ppos.x ~= 0 and ppos.z ~= 0 then --found itself as an object
				local yaw = math.abs(math.atan(ppos.x/ppos.z) - math.pi / 2)
				if ppos.z < 0 then yaw = yaw + math.pi end
				return yaw
			end
		end
	end
	return false
end

minetest.register_abm({
	nodenames = {"default:leaves"},
	interval = 10.0,
	chance = 100000,
	action = function(pos, node)
		minetest.env:add_entity({x=pos.x, y=pos.y + 1, z=pos.z}, "slimes:small")
	end,
})
