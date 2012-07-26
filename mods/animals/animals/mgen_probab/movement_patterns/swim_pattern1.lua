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

		movement_canfly				    =true,
		
		environment = {
			media = {
						"default:water_source",
						"default:water_flowing"
					},
			surfaces = nil,
			--ground is first node above/below not beeing of media type
			max_height_above_ground		= -1,
			min_height_above_ground     = -10		
		}
--
--      --run towards player or run away?  1 <-> -1
--		player_attraction				=0,
--		--maximum distance a player has an effect
--		player_attraction_range         =-1,
	}
	
table.insert(mov_patterns_defined,swim_pattern1_prototype)