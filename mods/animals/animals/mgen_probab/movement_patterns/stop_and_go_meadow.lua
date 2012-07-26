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
local stop_and_go_meadow_prototype = 	{
		name                            ="stop_and_go_meadow",
		start_movement					=0.1,
		stop_movement					=0.008,
		start_stop_delta_time_factor	=0.5,      
		jump_up							=0.2,
	
		random_jump_chance              =0,
		random_jump_initial_speed       =0,
		random_jump_delay               =0,
		random_acceleration_change      =0.05,

		movement_canfly				    =false,

		environment = {
			media = {
						"air",
						"default:junglegrass"
					},
			surfaces = {
						good = {
							"default:dirt_with_grass"
							},
						possible = {
							"default:dirt",
							"default:sand"
							},
						},
		}
--
--      --run towards player or run away?  1 <-> -1
--		player_attraction				=0,
--		--maximum distance a player has an effect
--		player_attraction_range         =-1,
	}
	
table.insert(mov_patterns_defined,stop_and_go_meadow_prototype)