local version = "0.0.5"

gull_prototype = {   
		name="gull",
		modname="animal_gull",
	
		generic = {
					description="Gull",
					base_health=5,
					kill_result="",
					armor_groups= {
						fleshy=3,
					}
				},				
		movement =  {
					default_gen=movement_gen,
					min_accel=0.5,
					max_accel=1,
					max_speed=4,
					pattern="flight_pattern1"
					},		
		harvest        = nil,
		catching 	   = nil,				  	
		random_drop    = nil,		
		auto_transform = nil,					
		graphics = {
					sprite_scale={x=2,y=2},
					sprite_div = {x=6,y=1},
					visible_height = 1,
					visible_width = 1,
					},		
		combat         = nil,
		
		spawning = {		
					rate=0.02,
					density=500,
					algorithm="in_air1",
					height=-1
					},
		}


--register with animals mod
print ("Adding animal "..gull_prototype.name)
animals_add_animal(gull_prototype)
print ("animal_gull mod version " .. version .. " loaded")