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
local run_and_jump_low_prototype = 	{
		name                            ="run_and_jump_low",
		start_movement					=0.7,
		stop_movement					=0.05,
		start_stop_delta_time_factor	=0.5,      
		jump_up							=0.2,
	
		random_jump_chance              =0.3,
		random_jump_initial_speed       =3.5,
		random_jump_delay               =2,
		random_acceleration_change      =0.6,

		movement_canfly				    =false,
		
		environment = {
			media = {
						"air",
						"default:junglegrass"
					}
		}
--
--      --run towards player or run away?  1 <-> -1
--		player_attraction				=0,
--		--maximum distance a player has an effect
--		player_attraction_range         =-1,
	}
table.insert(mov_patterns_defined,run_and_jump_low_prototype)