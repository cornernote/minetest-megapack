local version = "0.0.3"

fish_blue_white_prototype = {   
		name="fish_blue_white",
		modname="animal_fish_blue_white",
	
		generic = {
					description="Blue white fish",
					base_health=5,
					kill_result="",
					armor_groups= {
						fleshy=3,
					}
				},				
		movement =  { 
					default_gen=movement_gen,
					min_accel=0.1,
					max_accel=0.3,
					max_speed=1.1,
					pattern="swim_pattern1"
					},		
		harvest        = nil,
		catching = {
					tool="animalmaterials:net",
					consumed=true,
					},				  	
		random_drop    = nil,		
		auto_transform = nil,					
		graphics = {
					sprite_scale={x=2,y=1},
					sprite_div = {x=1,y=1},
					visible_height = 1,
					visible_width = 1,
					},		
		combat         = nil,
		
		spawning = {		
					rate=0.02,
					density=150,
					algorithm="in_shallow_water",
					height=-1
					},
		}


--register with animals mod
print ("Adding animal "..fish_blue_white_prototype.name)
animals_add_animal(fish_blue_white_prototype)
print ("animal_fish_blue_white mod version " .. version .. " loaded")