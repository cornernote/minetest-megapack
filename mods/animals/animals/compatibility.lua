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

--temporary cleanup code for old animals

minetest.register_entity(":animals:sheep",
	{	
		on_step = function(self,dtime)
			self.object:remove()
			end,
		on_activate = function(self,staticdata)
			self.object:remove()
			end
	})
	
minetest.register_entity(":animals:sheep_naked",
	{
		on_step = function(self,dtime)
			self.object:remove()
			end,
		on_activate = function(self,staticdata)
			self.object:remove()
			end
	})
	
minetest.register_entity(":animals:cow",
	{
		on_step = function(self,dtime)
			self.object:remove()
			end,
		on_activate = function(self,staticdata)
			self.object:remove()
			end
	})
	
minetest.register_entity(":animals:deer",
	{
		on_step = function(self,dtime)
			self.object:remove()
			end,
		on_activate = function(self,staticdata)
			self.object:remove()
			end
	})
	
minetest.register_entity(":animals:dm",
	{
		on_step = function(self,dtime)
			self.object:remove()
			end,
		on_activate = function(self,staticdata)
			self.object:remove()
			end
	})
	
minetest.register_entity(":animals:big_red",
	{
		on_step = function(self,dtime)
			self.object:remove()
			end,
		on_activate = function(self,staticdata)
			self.object:remove()
			end
	})
	
minetest.register_entity(":animals:creeper",
	{
		on_step = function(self,dtime)
			self.object:remove()
			end,
		on_activate = function(self,staticdata)
			self.object:remove()
			end
	})
	
minetest.register_entity(":animals:chicken",
	{
		on_step = function(self,dtime)
			self.object:remove()
			end,
		on_activate = function(self,staticdata)
			self.object:remove()
			end
	})
	
minetest.register_entity(":animals:fish_blue_white",
	{
		on_step = function(self,dtime)
			self.object:remove()
			end,
		on_activate = function(self,staticdata)
			self.object:remove()
			end
	})
	
minetest.register_entity(":animals:rat",
	{
		on_step = function(self,dtime)
			self.object:remove()
			end,
		on_activate = function(self,staticdata)
			self.object:remove()
			end
	})
	
minetest.register_entity(":animals:vampire",
	{
		on_step = function(self,dtime)
			self.object:remove()
			end,
		on_activate = function(self,staticdata)
			self.object:remove()
			end
	})

minetest.register_abm({
		nodenames = { "animals:sheep_wool" },
		interval = 1,
		chance = 1,

		action = function(pos, node, active_object_count, active_object_count_wider)
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos,{name="animalmaterials:wool_white"})
		end
	
	})