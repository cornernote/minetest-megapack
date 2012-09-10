local version = "0.0.8"

local vombie_groups = {
						not_in_creative_inventory=1
					}

local selectionbox_vombie = {-0.3, -1.2, -0.5, 0.3, 1, 0.5}

local modpath = minetest.get_modpath("animal_vombie")

dofile (modpath .. "/model.lua")
dofile (modpath .. "/flame.lua")



function vombie_drop()
	if math.random() < 0.05 then
		return "animalmaterials:bone 2"
	else
		return "animalmaterials:bone 1"
	end
end

function vombie_on_step_handler(entity,now,dtime)
	local pos = entity.getbasepos(entity)
	local current_light = minetest.env:get_node_light(pos)
	
	--print("vombie on step: current_light:" .. current_light .. " max light: " .. LIGHT_MAX .. " 3dmode:" .. dump(minetest.setting_getbool("disable_animals_3d_mode")))

	if current_light ~= nil and
		current_light > LIGHT_MAX and
		minetest.setting_getbool("mobf_disable_3d_mode") ~= true and
		minetest.setting_getbool("disable_vombie_3d_burn_animation") ~= true then
		
		
		local xdelta = (math.random()-0.5)
		local zdelta = (math.random()-0.5)
		--print("receiving sun damage: " .. xdelta .. " " .. zdelta)
		local newobject=minetest.env:add_entity( {	x=pos.x + xdelta,
													y=pos.y,
													z=pos.z + zdelta },
										"animal_vombie:vombie_flame")

		--add particles
	end
end

function vombie_on_activate_handler(entity)

        local pos = entity.object:getpos()
        
        local current_light = minetest.env:get_node_light(pos)
            
        if current_light == nil then
            minetest.log(LOGLEVEL_ERROR,"ANIMALS: Bug!!! didn't get a light value for ".. printpos(pos))
            return
        end
        --check if animal is in sunlight
        if ( current_light > LIGHT_MAX) then
            --don't spawn vombie in sunlight
            spawning.remove(entity)
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
						daemon=1,
					},
					envid="on_ground_1",
					custom_on_step_handler = vombie_on_step_handler,
                    custom_on_activate_handler = vombie_on_activate_handler,
				},
		movement =  {
					default_gen="probab_mov_gen",
					min_accel=0.3,
					max_accel=0.7,
					max_speed=2,
					pattern="stop_and_go",
					canfly=false,
					},
		harvest        = nil,
		catching       = nil,
		random_drop    = nil,
		auto_transform = nil,
		graphics_3d = {
					visual = "wielditem",
					textures = {"animal_vombie:box_vombie"},
					collisionbox = selectionbox_vombie,
					visual_size= {x=1.5,y=1.5,z=1.5},
					},
		graphics = {
					sprite_scale={x=4,y=4},
					sprite_div = {x=6,y=2},
					visible_height = 2.2,
					visible_width = 1,
					},
		combat = {
					mgen="follow_mov_gen",
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
					density=20,
					algorithm="at_night",
					height=2
					},
		sound = {
					random = {
								name="random_1",
								min_delta = 10,
								chance = 0.5,
								gain = 0.5,
								max_hear_distance = 5,
								},
					sun_damage = {
								name="sun_damage",
								gain = 0.25,
								max_hear_distance = 7,
								},
					},	
		}


--register with animals mod
print ("Adding animal "..vombie_prototype.name)
animals_add_animal(vombie_prototype)
print ("animal_vombie mod version " .. version .. " loaded")