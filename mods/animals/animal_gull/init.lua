local version = "0.0.7"

local gull_groups = {
						not_in_creative_inventory=1
					}

local selectionbox_gull = {-1, -0.3, -1, 1, 0.3, 1}

local modpath = minetest.get_modpath("animal_gull")

dofile (modpath .. "/model.lua")

gull_prototype = {   
		name="gull",
		modname="animal_gull",
	
		generic = {
					description="Gull",
					base_health=5,
					kill_result="",
					armor_groups= {
						fleshy=3,
					},
					envid="flight_1",
				},				
		movement =  {
					default_gen="probab_mov_gen",
					min_accel=0.5,
					max_accel=1,
					max_speed=4,
					pattern="flight_pattern1",
					canfly=true,
					},		
		harvest        = nil,
		catching 	   = nil,				  	
		random_drop    = nil,		
		auto_transform = nil,
		graphics_3d = {
			visual = "wielditem",
			textures = {"animal_gull:box_gull"},
			collisionbox = selectionbox_gull,
			visual_size= {x=2,y=2,z=2},
			},			
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