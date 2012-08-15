-------------------------------------------------------------------------------
-- Farming Mod
-- Author: Sapier
-- Purpose: provide farming functionality in minetest
--
-- External interface:
--  farming_add_hoe_type({ modname,typename,durability })
--  farming_add_crop({ 	cropname,
--			growtime,
--			chance of getting on plowing grass, 
--			chance of getting on collecting jungle grass,
--			chance of getting on collecting tall grass,		
--			max distance to water (on < 0 distance is ignored)
--			})
-------------------------------------------------------------------------------

local version = "0.1.8"


tool_types = { 
	{"default", "wood",   100},
	{"default", "cobble", 200},
	{"default", "steel",  500},
	{"default", "mese",   1000}
	}


-- {cropname,growtime,chance for seed on plow, maxwaterdistance(-1 ignore)
local crops = {
		{"wheat",    30,  0.0025,    0,      0.25,   5,"farming"},
		{"rhy",      45,  0.00125,   0,      0.125,  5,"farming"},
		{"potatoe",  60,  0,         0.10,   0,      5,"farming"},
		{"corn",     60,  0.01,      0.15,   0,      3,"farming"},
		}

local farming_modpath = minetest.get_modpath("farming")

dofile (farming_modpath .. "/generic_functions.lua")
dofile (farming_modpath .. "/tool_functions.lua")
dofile (farming_modpath .. "/crop_functions.lua")
dofile (farming_modpath .. "/plowed_functions.lua")


function init_module()

	--hoe declaration
	for index,value in ipairs(tool_types) do 
		farming_add_hoe_type(value)
	end

	--register crops
	for index,value in ipairs(crops) do 
		farming_add_crop(value,"farming")
	end

	--register seed source in flowers mod
	--flowers_add_sprite_flower("farming","tallgrass",1200,
	--			{
	--			{name = "dirt_with_grass", chance = 4, spacing = 15}})

	--initialize plowing
	init_plowing()

	--register global hooks
	minetest.register_on_punchnode(farming_on_punchnode)
	minetest.register_on_dignode(farming_on_dignode)


	print("Farming mod ", version, " loaded")
end




init_module()

