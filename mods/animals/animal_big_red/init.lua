local version = "0.0.6"

big_red_prototype = {   
		name="big_red",
		modname="animal_big_red",
	
		generic = {
					description="Big Red",
					base_health=30,
					kill_result="",
					armor_groups= {
						fleshy=1,
						cracky=1,
						deamon=1,
					},
					envid="on_ground_1",
				},
		movement =  {
					default_gen="probab_mov_gen",
					min_accel=0.2,
					max_accel=0.4,
					max_speed=2,
					pattern="stop_and_go",
					canfly=false,
					},
		harvest = {	
					tool="",
					tool_consumed=false,
					result="", 
					transforms_to="",
					min_delay=-1,
				  	},
		catching       = nil,
		random_drop    = nil,
		auto_transform = nil,
		graphics = {
					sprite_scale={x=6,y=6},
					sprite_div = {x=1,y=1},
					visible_height = 3.2,
					visible_width = 1,
					},		
		combat = {
					mgen="follow_mov_gen",
					angryness=0.95,
					starts_attack=true,
					sun_sensitive=true,
					melee = {
						maxdamage=4,
						range=2,
						speed=2,
						},
					distance = {
						attack="animals:plasmaball_entity", 
						range=10,
						speed=2,
						},				
					self_destruct = nil,
					},
		
		spawning = {		
					rate=0.01,
					density=1000,
					algorithm="shadows",
					height=4
					},
		}


--register with animals mod
print ("Adding animal "..big_red_prototype.name)
animals_add_animal(big_red_prototype)
print ("animal_big_red mod version " .. version .. " loaded")