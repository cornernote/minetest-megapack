local version = "0.0.2"

local modpath = minetest.get_modpath("animal_wolf")

--include debug trace functions
dofile (modpath .. "/model.lua")

local selectionbox_wolf = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}

wolf_prototype = {   
		name="wolf",
		modname="animal_wolf",
	
		generic = {
					description="Wolf",
					base_health=10,
					kill_result="animalmaterials:fur 1",
					armor_groups= {
						fleshy=3,
					},
					addoncatch = "animal_wolf:tamed_wolf",
					envid="on_ground_2"
				},
		movement =  {
					default_gen="follow_mov_gen",
					canfly=false,
					guardspawnpoint = true,
					teleportdelay = 60,
					min_accel=0.5,
					max_accel=0.9,
					max_speed=2,
					},		
		harvest = nil,
		catching = {
					tool="animalmaterials:net",
					consumed=true,
					},
		random_drop    = nil,
		auto_transform = nil,
		graphics_3d = { 
					visual = "wielditem",
					textures = {"animal_wolf:box_wolf"},
					collisionbox = selectionbox_wolf,
					visual_size = {x=1,y=1,z=1},
					},		
		combat = {
					mgen="follow_mov_gen",
					angryness=1,
					starts_attack=true,
					sun_sensitive=false,
					melee = {
						maxdamage=5,
						range=2, 
						speed=1,
						},
					distance 		= nil,
					self_destruct 	= nil,
					},
		
		spawning = {		
					rate=0.002,
					density=1500,
					algorithm="forrest",
					height=2
					},
					
		sound = {
					random = nil,
					},
		}
		
tamed_wolf_prototype = {
		name="tamed_wolf",
		modname="animal_wolf",
	
		generic = {
					description="Tamed Wolf",
					base_health=10,
					kill_result="animalmaterials:fur 1",
					armor_groups= {
						fleshy=3,
					},
					envid="on_ground_2",
					--this needs to be done by animal as first on_activate handler is called
					--before placer is known to entity
					custom_on_place_handler = function(entity, placer, pointed_thing)
						if placer:is_player(placer) then
							entity.dynamic_data.movement.target = placer
						end
					end,
					custom_on_activate_handler = function(entity)
						print("ANIMAL Wolf: custom on activate handler called")
						if (entity.dynamic_data.spawning.spawner ~= nil) then
							print("ANIMAL WOLF: setting target to: " .. entity.dynamic_data.spawning.spawner )
							entity.dynamic_data.movement.target = minetest.env:get_player_by_name(entity.dynamic_data.spawning.spawner)
						end
					end
				},
		movement =  {
					default_gen="follow_mov_gen",
					canfly=false,
					guardspawnpoint = false,
					teleportdelay = 20,
					min_accel=0.3,
					max_accel=0.9,
					max_speed=1.5,
					max_distance=2,
					},
		harvest = nil,
		catching = {
					tool="animalmaterials:net",
					consumed=true,
					},
		random_drop    = nil,
		auto_transform = nil,
		graphics_3d = { 
					visual = "wielditem",
					textures = {"animal_wolf:box_tamed_wolf"},
					collisionbox = selectionbox_wolf,
					visual_size = {x=1,y=1,z=1},
					},
		combat = nil,
		
		spawning = {
					rate=0.002,
					density=150,
					algorithm="none",
					height=2
					},
					
		sound = {
					random = nil,
					},
		}
		
print ("Adding animal "..wolf_prototype.name)
animals_add_animal(wolf_prototype)
print ("Adding animal "..tamed_wolf_prototype.name)
animals_add_animal(tamed_wolf_prototype)
print ("animal_wolf mod version " .. version .. " loaded")