local version = "0.0.3"

rat_prototype = {   
		name="rat", 
		modname="animal_rat",
	
		generic = {
					description="Rat (Animals)",
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
					rate=0.02,
					density=250,
					algorithm="forrest",
					height=1
					},
		}



--register with animals mod
print ("Adding animal "..rat_prototype.name)
animals_add_animal(rat_prototype)
print ("animal_rat mod version " .. version .. " loaded")