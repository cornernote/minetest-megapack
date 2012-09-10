local version = "0.0.6"

local chicken_deer = {
						not_in_creative_inventory=1
					}

local selectionbox_deer = {-1, -1.5, -1, 1, 1.5, 1}

local modpath = minetest.get_modpath("animal_deer")

dofile (modpath .. "/model.lua")

deer_prototype = {   
		name="deer",
		modname = "animal_deer", 

		generic = {
					description="Deer",
					base_health=25,
					kill_result="animalmaterials:meat_raw 2",
					armor_groups= {
						fleshy=3,
					},
					envid="meadow",
				},				
		movement =  { 
					default_gen="probab_mov_gen",
					min_accel=0.2,
					max_accel=0.4,
					max_speed=2,
					pattern="stop_and_go",
					canfly=false,
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
		graphics_3d = {
			visual = "wielditem",
			textures = {"animal_deer:box_deer"},
			collisionbox = selectionbox_deer,
			visual_size= {x=2,y=2,z=2},
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