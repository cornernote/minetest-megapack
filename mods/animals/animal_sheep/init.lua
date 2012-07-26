local version = "0.0.5"

sheep_prototype = {   
		name="sheep",
		modname="animal_sheep",
	
		generic = {
					description="Sheep",
					base_health=10,
					kill_result="animalmaterials:meat_raw 1",		
					armor_groups= {
						fleshy=3,
					},
					groups = {
						sheerable=1,
						wool=1,
					}
				},				
		movement =  {
					default_gen=movement_gen,
					min_accel=0.2,
					max_accel=0.4,
					max_speed=1.5,
					pattern="stop_and_go_meadow"
					},		
		harvest = {	
					tool="animalmaterials:scissors",
					max_tool_usage=10,
					tool_consumed=false,
					result="animalmaterials:wool_white 1", 
					transforms_to="animal_sheep:sheep_naked",
					min_delay=-1,
					},
		catching = {
					tool="animalmaterials:lasso",
					consumed=true,
					},				  	
		random_drop    = nil,		
		auto_transform = nil,					
		graphics = { 
					sprite_scale={x=4,y=4},
					sprite_div = {x=6,y=1},
					visible_height = 1.5,
					},		
		combat         = nil,
		
		spawning = {		
					rate=0.002,
					density=50,
					algorithm="willow",
					height=2
					},
					
		sound = {
					random = {
								name="Mudchute_sheep_1",
								min_delta = 30,
								chance = 0.5,
								gain = 0.8,
								max_hear_distance = 75,
								},
					harvest = {
								name="harvest",
								gain = 0.8,
								max_hear_distance = 5,
								},							
								
					},
		}
		
lamp_prototype = {   
		name="lamb",
		modname="animal_sheep", 
	
		generic = {
					description="Lamp",
					base_health=3,
					kill_result="animalmaterials:meat_raw 1",
					armor_groups= {
						fleshy=3,
					}
				},				
		movement =  { 
					min_accel=0.1,
					max_accel=0.2,
					max_speed=1,
					pattern="stop_and_go"
					},		
		harvest     = nil,
		catching = {
					tool="animalmaterials:lasso",
					consumed=true,
					},		  	
		random_drop = nil,		
		auto_transform = {
					result="animal_sheep:sheep",
					delay=1800
					},					
		graphics = { 
					sprite_scale={x=4,y=4},
					sprite_div = {x=6,y=1},
					visible_height = 1,
					},		
		combat      = nil,
		
		spawning = {		
					rate=0,
					density=0,
					algorithm="none",
					height=1
					},
		sound = {
					random = {
								name="Mudchute_lamb_1",
								min_delta = 30,
								chance = 0.5,
								gain = 0.8,
								max_hear_distance = 50,
								},								
								
					},
		}
	
sheep_naked_prototype = {   
		name="sheep_naked",
		modname="animal_sheep", 
	
		generic = {
					description="Naked sheep",
					base_health=10,
					kill_result="animalmaterials:meat_raw 1",
					armor_groups= {
						fleshy=3,
					},
				},				
		movement =  { 
					min_accel=0.2,
					max_accel=0.4,
					max_speed=1.5,
					pattern="stop_and_go"
					},		
		harvest     = nil,
		catching = {
					tool="animalmaterials:lasso",
					consumed=true,
					},		  	
		random_drop = nil,		
		auto_transform = {
					result="animal_sheep:sheep",
					delay=300
					},					
		graphics = { 
					sprite_scale={x=4,y=4},
					sprite_div = {x=6,y=1},
					visible_height = 1.5,
					},		
		combat      = nil,
		
		spawning = {		
					rate=0,
					density=0,
					algorithm="none",
					height=2
					},
		sound = {
					random = {
								name="Mudchute_sheep_1",
								min_delta = 30,
								chance = 0.5,
								gain = 0.8,
								max_hear_distance = 75,
								},								
								
					},
		}	


minetest.register_craft({
	output = "animalmaterials:scissors 5",
	recipe = {
		{'', "default:steel_ingot",''},
		{'', "default:steel_ingot",''},
		{"default:stick",'',"default:stick"},
	}
})

--register with animals mod
print ("Adding animal "..sheep_prototype.name)
animals_add_animal(sheep_prototype)
print ("Adding animal "..sheep_naked_prototype.name)
animals_add_animal(sheep_naked_prototype)
print ("Adding animal "..lamp_prototype.name)
animals_add_animal(lamp_prototype)
print ("animal_sheep mod version " .. version .. " loaded")
