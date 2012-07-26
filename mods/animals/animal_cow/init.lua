local version = "0.0.4"

cow_prototype = {   
		name="cow",
		modname="animal_cow",
	
		generic = {
					description="Cow",
					base_health=40,
					kill_result="animalmaterials:meat_raw 5",
					armor_groups= {
						fleshy=2,
					}
				},				
		movement =  {
					default_gen=movement_gen,
					min_accel=0.1,
					max_accel=0.3,
					max_speed=1.2,
					pattern="stop_and_go_meadow"
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
								max_hear_distance = 750,
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