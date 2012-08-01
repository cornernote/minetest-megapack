local version = "0.0.3"

butterfly_prototype = {   
		name="butterfly", 
		modname="animal_butterfly",
	
		generic = {
					description="Butterfly (Animals)",
					base_health=2,
					kill_result="",
					armor_groups= {
						fleshy=3,
					}
				},				
		movement =  { 
					min_accel=3.8,
					max_accel=3.9,
					max_speed=5,
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
					rate=0.002,
					density=50,
					algorithm="forrest",
					height=1
					},
		}



--register with animals mod
print ("Adding animal "..butterfly_prototype.name)
animals_add_animal(butterfly_prototype)
print ("animal_butterfly mod version " .. version .. " loaded")