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

--animal definition
local animals_defined = {
	{ name="sheep" },
	{ name="sheep_naked" },
	{ name="deer" },
	{ name="cow" },
	{ name="big_red" },
	{ name="vampire" },
	{ name="chicken" },
	{ name="dm"  },
	{ name="creeper" },
	{ name="spawn_marker" },
}



for index,value in ipairs(animals_defined) do 

		print ("removing animal "..index.." -> "..value.name)

		minetest.register_entity(":animals:"..animal.name,
			 {
				on_activate = function(self,staticdata)
					self.object:remove()
				end
			})
end


print("ANIMALS WARNING: all animals becoming active will be removed at once!") 
