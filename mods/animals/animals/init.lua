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

--registry for movement patterns
animals_movement_patterns = {}
animals_defined = {}
animals_spawn_algorithms = {}

animals_modpath = minetest.get_modpath("animals")

--include debug trace functions
dofile (animals_modpath .. "/debug_trace.lua")

--include engine
dofile (animals_modpath .. "/generic_functions.lua")
dofile (animals_modpath .. "/environment.lua")
dofile (animals_modpath .. "/movement_generic.lua")
dofile (animals_modpath .. "/movement_gen_registry.lua")
dofile (animals_modpath .. "/mgen_probab/main_probab.lua")
dofile (animals_modpath .. "/mgen_follow/main_follow.lua")
dofile (animals_modpath .. "/harvesting.lua")
dofile (animals_modpath .. "/weapons.lua")
dofile (animals_modpath .. "/fighting.lua")
dofile (animals_modpath .. "/random_drop.lua")
dofile (animals_modpath .. "/sound.lua")
dofile (animals_modpath .. "/permanent_data.lua")
dofile (animals_modpath .. "/management_functions.lua")
dofile (animals_modpath .. "/debug.lua")

--include spawning support
dofile (animals_modpath .. "/spawning.lua")

local version = "1.2.90"

LOGLEVEL_INFO     = "verbose"
LOGLEVEL_NOTICE   = "info"
LOGLEVEL_WARNING  = "action"
LOGLEVEL_ERROR    = "error"
LOGLEVEL_CRITICAL = "error"


--define tools used for more than one animal
minetest.register_craft({
	output = "animalmaterials:lasso 5",
	recipe = {
		{'', "animalmaterials:wool_white",''},
		{"animalmaterials:wool_white",'', "animalmaterials:wool_white"},
		{'',"animalmaterials:wool_white",''},
	}
})

minetest.register_craft({
	output = "animalmaterials:net 1",
	recipe = {
		{"animalmaterials:wool_white",'',"animalmaterials:wool_white"},
		{'', "animalmaterials:wool_white",''},
		{"animalmaterials:wool_white",'',"animalmaterials:wool_white"},
	}
})


function animals_init_module()
	print("Initializing animals mod")
	
	print("Initializing probabilistic movement generator")
	movement_gen.initialize()

	print("Initializing weaponry..")
	animals_init_weapons()

	print("Initializing debug hooks..")
	animals_init_debug()
	
--	luatrace = require("luatrace")

	print("animals mod "..version.." loaded")
end

animals_init_module()

dofile (animals_modpath .. "/compatibility.lua")
