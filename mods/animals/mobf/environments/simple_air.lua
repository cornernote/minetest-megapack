-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file simple_air.lua
--! @brief a very basic environment definition
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-10
--
--! @addtogroup environments
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @struct env_simple_air
--! @brief simple environment only checking for air
env_simple_air = {
			media = {
						"air"
					}
		}
		
--!@}
		
environment.register("simple_air", env_simple_air)