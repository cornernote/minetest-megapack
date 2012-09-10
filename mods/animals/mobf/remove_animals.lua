-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
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
    { name="lamb" },
	{ name="deer" },
	{ name="cow" },
	{ name="big_red" },
	{ name="vampire" },
	{ name="chicken" },
	{ name="dm"  },
	{ name="creeper" },
	{ name="spawn_marker" },
}

local animal_mods_know = {
	{ 	name="big_red",
		modname="animal_big_red",},
	{   name="chicken",
		modname="animal_chicken", },
	{	name="clownfish",
		modname="animal_clownfish", },
	{	name="cow",
		modname="animal_cow", },
	{	name="creeper",
		modname="animal_creeper", },
	{	name="deer",
		modname = "animal_deer", },
	{	name="dm",
		modname="animal_dm", },
	{	name="fish_blue_white",
		modname="animal_fish_blue_white", },
	{	name="gull",
		modname="animal_gull", },
	{	name="rat", 
		modname="animal_rat", },
	{	name="sheep",
		modname="animal_sheep", },
	{	name="lamb",
		modname="animal_sheep", },
	{	name="sheep_naked",
		modname="animal_sheep", },
	{	name="vombie",
		modname="animal_vombie", },
	{	name="wolf",
		modname="animal_wolf", },
	{	name="tamed_wolf",
		modname="animal_wolf", },	
}

local animals_total = 0

for index,value in ipairs(animals_defined) do 
		animals_total = animals_total +1
		
		print ("removing animal "..animals_total.." -> animals:"..value.name)

		minetest.register_entity(":animals:"..value.name,
			 {
				on_activate = function(self,staticdata)
					self.object:remove()
				end
			})
		
end

for index,value in ipairs(animal_mods_know) do 
		animals_total = animals_total +1

		print ("removing animal "..animals_total.." -> "..value.mod .. ":" .. value.name)

		minetest.register_entity(":".. value.mod ..":".. value.name,
			 {
				on_activate = function(self,staticdata)
					self.object:remove()
				end
			})

end


print("ANIMALS WARNING: all animals becoming active will be removed at once!") 
