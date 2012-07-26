--Dripping Water Mod
--by kddekadenz

-- License of code, textures & sounds: CC0

--Random
math.randomseed(3)


--Drop entity
minetest.register_entity("drippingwater:drop", {
	hp_max = 2000,
	physical = true,
	collisionbox = {0,0,0,0,0,0},
	visual = "sprite",
	visual_size = {x=0.05, y=0.1},
	textures = {"dripping_water_drop.png"},
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},

	on_activate = function(self, staticdata)
		self.object:setsprite({x=0,y=0}, 1, 0, true)
	end,

	on_step = function(self, dtime)
	local k = math.random(1,222)
	local ownpos = self.object:getpos()

	if k==1 then
	self.object:setacceleration({x=0, y=-5, z=0})
	end

	if minetest.env:get_node({x=ownpos.x, y=ownpos.y +0.5, z=ownpos.z}).name == "air" then
	self.object:setacceleration({x=0, y=-5, z=0})
	end

		
		if minetest.env:get_node({x=ownpos.x, y=ownpos.y -0.5, z=ownpos.z}).name ~= "air" then
		self.object:remove()
		minetest.sound_play({name="drippingwater_drip"}, {pos = ownpos, gain = 0.5, max_hear_distance = 8})
		end
	end,
})


--Create drop
minetest.register_abm(
        {nodenames = {"group:crumbly"},
	neighbors = {"group:water"},
        interval = 2,
        chance = 22,
        action = function(pos)
		if minetest.env:get_node({x=pos.x, y=pos.y -1, z=pos.z}).name == "air" and 
		minetest.env:get_node({x=pos.x, y=pos.y -2, z=pos.z}).name == "air" then
		local i = math.random(-5,5) / 10
		minetest.env:add_entity({x=pos.x + i, y=pos.y - 0.5, z=pos.z + i}, "drippingwater:drop")
		end
        end,
})


--Cloudstone

minetest.register_abm(
        {nodenames = {"default:cloud"},
        interval = 0,
        chance = 1,
        action = function(pos)
		if minetest.env:get_node({x=pos.x, y=pos.y -1, z=pos.z}).name == "air" and 
		minetest.env:get_node({x=pos.x, y=pos.y -2, z=pos.z}).name == "air" then
		local i = math.random(-5,5) / 10
		minetest.env:add_entity({x=pos.x + i, y=pos.y - 0.5, z=pos.z + i}, "drippingwater:drop")
		end
        end,
})
