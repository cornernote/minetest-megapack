-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file swim_pattern1.lua
--! @brief movementpattern for slow swimming mobs 
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-10
--
--! @addtogroup mpatterns
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @struct swim_pattern1_prototype
--! @brief movement pattern for mobs swimming slow
local swim_pattern1_prototype = 	{
		name                            ="swim_pattern1",
		start_movement					=1,
		stop_movement					=0,
		start_stop_delta_time_factor	=0,      
		jump_up							=0,
	
		random_jump_chance              =0.2,
		random_jump_initial_speed       =0,
		random_jump_delay               =10,
		random_acceleration_change      =0.3,

--
--      --run towards player or run away?  1 <-> -1
--		player_attraction				=0,
--		--maximum distance a player has an effect
--		player_attraction_range         =-1,
	}
	
--!@}
	
table.insert(mov_patterns_defined,swim_pattern1_prototype)