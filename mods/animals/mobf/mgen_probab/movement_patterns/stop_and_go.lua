-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file stop_and_go.lua
--! @brief movementpattern creating a random stop and go movement e.g. sheep/cow
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-10
--
--! @addtogroup mpatterns
--! @{
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @struct stop_and_go_prototype
--! @brief movement pattern for mobs wandering around randomly
local stop_and_go_prototype = 	{
		name                            ="stop_and_go",
		start_movement					=0.5,
		stop_movement					=0.08,
		start_stop_delta_time_factor	=0.5,      
		jump_up							=0.2,
	
		random_jump_chance              =0,
		random_jump_initial_speed       =0,
		random_jump_delay               =0,
		random_acceleration_change      =0.1,

--
--      --run towards player or run away?  1 <-> -1
--		player_attraction				=0,
--		--maximum distance a player has an effect
--		player_attraction_range         =-1,
	}
	
--!@}
	
table.insert(mov_patterns_defined,stop_and_go_prototype)