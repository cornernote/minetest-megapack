local version = "0.0.1"

pet_rat_prototype = {   
		name="petrat", 
		modname="animal_pet_rat",
	
		generic = {
					description="Pet Rat (Animals)",
					base_health=2,
					kill_result="",
					armor_groups= {
						fleshy=3,
					}
				},				
		movement =  {
					default_gen=movement_gen,
					min_accel=0.4,
					max_accel=0.6,
					max_speed=2,
					pattern="run_and_jump_low"
					},		
		harvest        = nil,
		catching = {
					tool="animalmaterials:net",
					consumed=true,
					},				  	
		random_drop    = nil,		
		auto_transform = nil,					
		graphics = {
					sprite_scale={x=1,y=1},
					sprite_div = {x=6,y=1},
					visible_height = 1,
					visible_width = 1,
					},		
		combat         = nil,		
		spawning = {		
					rate=0.25,
					density=250,
					algorithm="forrest",
					height=0.5
					},
		}



--register with animals mod
print ("Adding animal "..pet_rat_prototype.name)
animals_add_animal(pet_rat_prototype)
print ("animal_pet_rat mod version " .. version .. " loaded")