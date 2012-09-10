local version = "0.0.6"

local chicken_groups = {
						not_in_creative_inventory=1
					}

local selectionbox_chicken = {-0.2, -0.25, -0.4, 0.2, 0.25, 0.4}

local modpath = minetest.get_modpath("animal_chicken")

dofile (modpath .. "/model.lua")

chicken_prototype = {   
		name="chicken",
		modname="animal_chicken",
	
		generic = {
					description="Chicken",
					base_health=5,
					kill_result="animalmaterials:feather 1",
					armor_groups= {
						fleshy=3,
					},
					envid = "meadow"
				},
		movement =  {
					default_gen="probab_mov_gen",
					min_accel=0.2,
					max_accel=0.45,
					max_speed=2,
					pattern="stop_and_go",
					canfly = false,
					},		
		harvest        = nil,
		catching = {
					tool="animalmaterials:lasso",
					consumed=true,
					},
		random_drop = {
 					result="animalmaterials:egg",
 					min_delay=60,
 					chance=0.2
 					},		
		auto_transform = nil,
		graphics = {
					sprite_scale={x=1,y=1},
					sprite_div = {x=6,y=1},
					visible_height = 1,
					visible_width = 1,
					},
		graphics_3d = {
			visual = "wielditem",
			textures = {"animal_chicken:box_chicken"},
			collisionbox = selectionbox_chicken,
			visual_size= {x=0.6,y=0.6,z=0.6},
			},
		combat         = nil,
		spawning = {
					rate=0.001,
					density=50,
					algorithm="willow",
					height=1
					},
		}


--register with animals mod
print ("Adding animal "..chicken_prototype.name)
animals_add_animal(chicken_prototype)
print ("animal_chicken mod version " .. version .. " loaded")