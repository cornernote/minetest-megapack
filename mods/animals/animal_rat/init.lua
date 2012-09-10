local version = "0.0.5"

local selectionbox_rat = {-0.35, -0.0625, -0.0625, 0.35, 0.125, 0.0625}

local modpath = minetest.get_modpath("animal_rat")

--include debug trace functions
dofile (modpath .. "/model.lua")

rat_prototype = {   
		name="rat", 
		modname="animal_rat",
	
		generic = {
					description="Rat (Animals)",
					base_health=2,
					kill_result="",
					armor_groups= {
						fleshy=3,
					},
					envid="on_ground_1",
				},
		movement =  {
					default_gen="probab_mov_gen",
					min_accel=0.4,
					max_accel=0.6,
					max_speed=2,
					pattern="run_and_jump_low",
					canfly=false,
					},
		harvest        = nil,
		catching = {
					tool="animalmaterials:net",
					consumed=true,
					},
		random_drop    = nil,
		auto_transform = nil,
		graphics_3d = {
					visual = "wielditem",
					textures = {"animal_rat:box_rat"},
					collisionbox = selectionbox_rat,
					visual_size= {x=0.666,y=0.666,z=0.666},
					},
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