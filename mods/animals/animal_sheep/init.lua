local version = "0.0.8"

local sheep_groups = {
						sheerable=1,
						wool=1,
						not_in_creative_inventory=1
					}

local selectionbox_sheep = {-0.65, -0.8, -0.65, 0.65, 0.45, 0.65}
local selectionbox_lamb = {-0.65*0.6, -0.8*0.6, -0.65*0.6, 0.65*0.6, 0.45*0.6, 0.65*0.65}		

local modpath = minetest.get_modpath("animal_sheep")

--include debug trace functions
dofile (modpath .. "/model.lua")

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
					groups = sheep_groups
				},				
		movement =  {
					default_gen=movement_gen,
					min_accel=0.2,
					max_accel=0.4,
					max_speed=1.5,
					min_speed=0.2,
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
					visual = "wielditem",
					textures = {"animal_sheep:box_wool"},
					collisionbox = selectionbox_sheep,
					visual_size= {x=1,y=1,z=1},
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
		
lamb_prototype = {   
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
					default_gen=movement_gen,
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
					visual = "wielditem",
					textures = {"animal_sheep:box_wool"},
					collisionbox = selectionbox_lamb,
					visual_size= {x=0.6,y=1,z=0.6},
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
					default_gen=movement_gen,
					min_accel=0.2,
					max_accel=0.4,
					max_speed=1.5,
					min_speed=0.2,
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
					visual = "wielditem",
					textures = {"animal_sheep:box_naked"},
					collisionbox = selectionbox_sheep,
					visual_size= {x=1,y=1,z=1},
					visible_height = 1,
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
print ("Adding animal "..lamb_prototype.name)
animals_add_animal(lamb_prototype)
print ("animal_sheep mod version " .. version .. " loaded")
