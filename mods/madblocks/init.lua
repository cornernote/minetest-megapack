local madblocks_modpath = minetest.get_modpath("madblocks")
math.randomseed(os.time())

--		*****************************
--		INCLUDES
--		*****************************
dofile (madblocks_modpath .. "/nodes.lua")
dofile (madblocks_modpath .. "/functions.lua")
dofile (madblocks_modpath .. "/crafts.lua")
--dofile (madblocks_modpath .. "/new.lua")					-- experimental/testing
--dofile (madblocks_modpath .. "/strongholds.lua")			-- experimental/testing
dofile (madblocks_modpath .. "/lights.lua")					-- fork

print('mAdBlOcKs 12.7.17 loaded')
