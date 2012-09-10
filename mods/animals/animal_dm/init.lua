local version = "0.0.7"

dm_prototype = {   
		name="dm",
		modname="animal_dm",
	
		generic = {
					description="Dungeonmaster (Animals)",
					base_health=50,
					kill_result="",
					armor_groups= {
						fleshy=1,
						deamon=1,
					},
					envid="simple_air"
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
		catching       = nil,
		random_drop    = nil,
		auto_transform = nil,
		graphics = {
					sprite_scale={x=4,y=4},
					sprite_div = {x=6,y=1},
					visible_height = 2,
					},		
		combat = {
					mgen="follow_mov_gen",
					angryness=0.99,
					starts_attack=true,
					sun_sensitive=true,
					melee = {
						maxdamage=8,
						range=5, 
						speed=1,
						},
					distance = {
						attack="animals:fireball_entity",
						range =15,
						speed = 1,
						},				
					self_destruct = nil,
					},
		
		spawning = {		
					rate=0.02,
					density=750,
					algorithm="shadows",
					height=3
					},
		sound = {
					random = {
								name="random_1",
								min_delta = 30,
								chance = 0.5,
								gain = 1,
								max_hear_distance = 15,
								},
					distance = {
								name="fireball",
								gain = 1,
								max_hear_distance = 10,
								},
					die = {
								name="die",
								gain = 1,
								max_hear_distance = 15,
								},
					melee = {
								name="hit",
								gain = 1,
								max_hear_distance = 5,
								},
					},		
		}
		
dm_debug = function (msg)
    --minetest.log("action", "mobs: "..msg)
    --minetest.chat_send_all("mobs: "..msg)
end

local modpath = minetest.get_modpath("animal_dm")
dofile (modpath .. "/vault.lua")

--register with animals mod
print ("Adding animal "..dm_prototype.name)
animals_add_animal(dm_prototype)
print ("animal_dm mod version " .. version .. " loaded")