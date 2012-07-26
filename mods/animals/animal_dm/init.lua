local version = "0.0.3"

dm_prototype = {   
		name="dm",
		modname="animal_dm",
	
		generic = {
					description="Dungeonmaster (Animals)",
					base_health=50,
					kill_result="",
					armor_groups= {
						fleshy=1,
					}
				},				
		movement =  {
					default_gen=movement_gen,
					min_accel=0.2,
					max_accel=0.4,
					max_speed=2,
					pattern="stop_and_go"
					},		
		harvest        = nil,
		catching       = nil,				  	
		random_drop    = nil,		
		auto_transform = nil,					
		graphics = {
					sprite_scale={x=4,y=4},
					sprite_div = {x=6,y=1},
					visible_height = 2,
					},		
		combat = {
					mgen=mgen_follow,
					angryness=0.99,					
					starts_attack=true,
					sun_sensitive=true,					
					melee = {
						maxdamage=8,
						range=5, 
						speed=1,
						},						
					distance = {					
						attack="animals:fireball_entity", 
						range =15,
						speed = 1,
						},				
					self_destruct = nil,
					},
		
		spawning = {		
					rate=0.02,
					density=750,
					algorithm="shadows",
					height=3
					},
		sound = {
					random = {
								name="random_1",
								min_delta = 30,
								chance = 0.5,
								gain = 1,
								max_hear_distance = 500,
								},
					distance = {
								name="fireball",
								gain = 1,
								max_hear_distance = 100,
								},
					die = {
								name="die",
								gain = 1,
								max_hear_distance = 100,
								},
					melee = {
								name="hit",
								gain = 1,
								max_hear_distance = 100,
								},
					},		
		}


--register with animals mod
print ("Adding animal "..dm_prototype.name)
animals_add_animal(dm_prototype)
print ("animal_dm mod version " .. version .. " loaded")