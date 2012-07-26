local version = "0.0.5"

function vombie_drop()
	if math.random() < 0.05 then
		return "animalmaterials:bone 2"
	else
		return "animalmaterials:bone 1"
	end
end

vombie_prototype = {   
		name="vombie",
		modname="animal_vombie",
	
		generic = {
					description="Vombie",
					base_health=40,
					kill_result=vombie_drop,
					armor_groups= {
						fleshy=3,
					}
				},				
		movement =  {
					default_gen=movement_gen,
					min_accel=0.3,
					max_accel=0.7,
					max_speed=2,
					pattern="stop_and_go"
					},		
		harvest        = nil,
		catching       = nil,		  	
		random_drop    = nil,		
		auto_transform = nil,					
		graphics = {
					sprite_scale={x=4,y=4},
					sprite_div = {x=6,y=2},
					visible_height = 2.2,
					visible_width = 1,
					},		
		combat = {
					mgen=mgen_follow,
					angryness=1,
					starts_attack=true,
					sun_sensitive=true,					
					melee = {
						maxdamage=4,
						range=2, 
						speed=1,
						},						
					distance 		= nil,		
					self_destruct 	= nil,
					},
		
		spawning = {		
					rate=0.05,
					density=30,
					algorithm="at_night",
					height=2
					},
		sound = {
					random = {
								name="random_1",
								min_delta = 10,
								chance = 0.5,
								gain = 0.5,
								max_hear_distance = 75,
								},					
					sun_damage = {
								name="sun_damage",
								gain = 0.25,
								max_hear_distance = 100,
								},
					},	
		}


--register with animals mod
print ("Adding animal "..vombie_prototype.name)
animals_add_animal(vombie_prototype)
print ("animal_vombie mod version " .. version .. " loaded")