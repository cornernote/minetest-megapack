local version = "0.0.8"


local cow_groups = {
						not_in_creative_inventory=1
					}

local selectionbox_cow = {-1.5, -1.5, -0.75, 1.5, 0.6, 0.75}

local modpath = minetest.get_modpath("animal_cow")

--include debug trace functions
dofile (modpath .. "/model.lua")

cow_prototype = {   
		name="cow",
		modname="animal_cow",
	
		generic = {
					description="Cow",
					base_health=40,
					kill_result="animalmaterials:meat_raw 5",
					armor_groups= {
						fleshy=2,
					},
					groups = cow_groups,
					envid = "meadow"
				},				
		movement =  {
					default_gen="probab_mov_gen",
					min_accel=0.1,
					max_accel=0.3,
					max_speed=1.2,
					min_speed=0.2,
					pattern="stop_and_go",
					canfly=false,
					},		
		harvest = {	
					tool="animalmaterials:glass",
					tool_consumed=true,
					result="animalmaterials:milk", 
					transforms_to="",
					min_delay=60,
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
					visible_height = 2,
					},
		graphics_3d = {
					visual = "wielditem",
					textures = {"animal_cow:box_cow"},
					collisionbox = selectionbox_cow,
					visual_size= {x=2,y=2,z=2},
					},
		combat         = nil,
	
		spawning = {
					rate=0.001,
					density=200,
					algorithm="willow",
					height=2
					},
		sound = {
					random = {
								name="Mudchute_cow_1",
								min_delta = 30,
								chance = 0.5,
								gain = 1,
								max_hear_distance = 10,
								},
					},	
		}

minetest.register_craft({
	output = "animalmaterials:glass 5",
	recipe = {
		{'', "default:glass",''},
		{'', "default:glass",''}
	}
})

--register with animals mod
print ("Adding animal "..cow_prototype.name)
animals_add_animal(cow_prototype)
print ("animal_cow mod version " .. version .. " loaded")