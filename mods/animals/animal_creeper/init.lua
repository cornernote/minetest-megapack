local version = "0.0.4"

creeper_prototype = {   
		name="creeper",
		modname="animal_creeper", 
	
		generic = {
					description="Creeper",
					base_health=5,
					kill_result="",
					armor_groups= {
						cracky=3,
					}
				},				
		movement =  {
					default_gen=movement_gen,
					min_accel=0.4,
					max_accel=0.6,
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
					visible_height = 1.5,
					},		
		combat = {
					mgen=mgen_follow,
					angryness=0.95,
					starts_attack=true,
					sun_sensitive=true,					
					melee = {						
						maxdamage=0,
						range=2, 
						speed=1, 
						},						
					distance 		= nil,				
					self_destruct = {
						damage=15,
						range=5,
						node_damage_range = 1.5,
						delay=5,
						},
					},
		
		spawning = {		
					rate=0.02,
					density=500,
					algorithm="at_night",
					height=2
					},
		sound = {
					random = {
								name="random_1",
								min_delta = 10,
								chance = 0.5,
								gain = 1,
								max_hear_distance = 75,
								},					
					self_destruct = {
								name="bomb_explosion",
								gain = 2,
								max_hear_distance = 1000,
								},
					},	
		}


--register with animals mod
print ("Adding animal "..creeper_prototype.name)
animals_add_animal(creeper_prototype)
print ("animal_creeper mod version " .. version .. " loaded")