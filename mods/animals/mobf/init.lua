-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file init.lua
--! @brief main module file responsible for including all parts of mob framework mod
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
--! @defgroup framework_int Internal framework subcomponent API
--! @brief this functions are used to provide additional features to mob framework
--! e.g. add additional spawn algorithms, movement generators, environments ...
--
--
--! @defgroup framework_mob Mob Framework API 
--! @brief this functions are used to add a mob to mob framework
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--!registry for movement patterns
mobf_movement_patterns = {}
--!registry of mobs
mobf_registred_mob = {}

--!path of mod
mobf_modpath = minetest.get_modpath("mobf")

--include debug trace functions
dofile (mobf_modpath .. "/debug_trace.lua")

--include engine
dofile (mobf_modpath .. "/generic_functions.lua")
dofile (mobf_modpath .. "/environment.lua")
dofile (mobf_modpath .. "/movement_generic.lua")
dofile (mobf_modpath .. "/graphics.lua")
dofile (mobf_modpath .. "/movement_gen_registry.lua")
dofile (mobf_modpath .. "/harvesting.lua")
dofile (mobf_modpath .. "/weapons.lua")
dofile (mobf_modpath .. "/fighting.lua")
dofile (mobf_modpath .. "/random_drop.lua")
dofile (mobf_modpath .. "/sound.lua")
dofile (mobf_modpath .. "/permanent_data.lua")
dofile (mobf_modpath .. "/management_functions.lua")
dofile (mobf_modpath .. "/debug.lua")

--include spawning support
dofile (mobf_modpath .. "/spawning.lua")

--include movement generators
dofile (mobf_modpath .. "/mgen_probab/main_probab.lua")
dofile (mobf_modpath .. "/mgen_follow/main_follow.lua")
dofile (mobf_modpath .. "/mgen_rasterized/mgen_raster.lua")
dofile (mobf_modpath .. "/mov_gen_none.lua")

local version = "1.3.5"

LOGLEVEL_INFO     = "verbose"
LOGLEVEL_NOTICE   = "info"
LOGLEVEL_WARNING  = "action"
LOGLEVEL_ERROR    = "error"
LOGLEVEL_CRITICAL = "error"

--! @brief define tools used for more than one mob
function mobf_init_basic_tools()	
	minetest.register_craft({
		output = "animalmaterials:lasso 5",
		recipe = {
			{'', "wool:white",''},
			{"wool:white",'', "wool:white"},
			{'',"wool:white",''},
		}
	})
	
	minetest.register_craft({
		output = "animalmaterials:net 1",
		recipe = {
			{"wool:white",'',"wool:white"},
			{'', "wool:white",''},
			{"wool:white",'',"wool:white"},
		}
	})
	

	
	minetest.register_craft({
	output = 'animalmaterials:sword_deamondeath',
	recipe = {
		{'animalmaterials:bone'},
		{'animalmaterials:bone'},
		{'default:stick'},
	}
	})

end


--! @brief main initialization function
function mobf_init_module()
	print("Initializing mob framework")
	mobf_init_basic_tools()
	
	print("Initializing probabilistic movement generator")
	movement_gen.initialize()

	print("Initializing weaponry..")
	mobf_init_weapons()

	print("Initializing debug hooks..")
	mobf_init_debug()
	
	--luatrace = require("luatrace")

	print("mob framework mod "..version.." loaded starttime is:" .. mobf_get_time_ms())
end

mobf_init_module()

dofile (mobf_modpath .. "/compatibility.lua")
