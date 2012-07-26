local version = "0.0.4"

deer_prototype = {   
		name="deer",
		modname = "animal_deer", 

		generic = {
					description="Deer",
					base_health=25,
					kill_result="animalmaterials:meat_raw 2",
					armor_groups= {
						fleshy=3,
					}
				},				
		movement =  { 
					default_gen=movement_gen,
					min_accel=0.2,
					max_accel=0.4,
					max_speed=2,
					pattern="stop_and_go_meadow"
					},		
		harvest        = nil,
		catching = {
					tool="animalmaterials:lasso",
					consumed=true,
					},				  	
		random_drop    = nil,		
		auto_transform = nil,					
		graphics = {
					sprite_scale={x=4,y=4},
					sprite_div = {x=6,y=1},
					visible_height = 2,
					visible_width = 1,
					},		
		combat         = nil,
		
		spawning = {		
					rate=0.002,
					density=200,
					algorithm="forrest",
					height=2
					},
		}


--register with animals mod
print ("Adding animal "..deer_prototype.name)
animals_add_animal(deer_prototype)
print ("animal_deer mod version " .. version .. " loaded")