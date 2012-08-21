--Harvest
--A simple farming mod
--A extended plant spawning mod

--register alias to avoid unknown plants from previous harvest version

--Variable and function definitions
local mod_name = "plants"

local wild_crops = {}
local wild_crop_count = 0

local function arrayContains(array, value)
    for _,v in pairs(array) do
      if v == value then
        return true
      end
    end
    
    return false
end

local function generate(node, surfaces, minp, maxp, height_min, height_max, spread, habitat_size, habitat_nodes)
    if maxp.y < height_min or minp.y > height_max then
		return
	end
	
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	
	local width   = maxp.x-minp.x
	local length  = maxp.z-minp.z
	local height  = height_max-height_min
    
    local y_current
	local x_current
	local z_current
	
	local x_deviation
	local z_deviation
	
	--apperently nested while loops don't work!
	for x_current = spread/2, width, spread do
	    for z_current = spread/2, length, spread do

	        x_deviation = math.floor(math.random(spread))-spread/2
	        z_deviation = math.floor(math.random(spread))-spread/2

	        for y_current = height_max, height_min, -1 do
	            local p = {x=minp.x+x_current+x_deviation, y=y_current, z=minp.z+z_current+z_deviation}
	            local n = minetest.env:get_node(p)
	            
	            local p_top = {x=p.x, y=p.y+1, z=p.z}
	            local n_top = minetest.env:get_node(p_top)
	            if n_top.name == "air" then
	            
                    if arrayContains(surfaces, n.name) then 
                        if minetest.env:find_node_near(p_top, habitat_size, habitat_nodes) ~= nil then
                            minetest.env:add_node(p_top, {name=node})
                        end
                    end

	            end
	        end
	        --randomize positioning a little and then check if the surface(grow on) node is beneath it. If so check if habitat node is within the habitat_size. If so create the node.
	        z_current = z_current + spread
        end
    end
end

local add_plant = function(name_plant) -- register a wild plant
    
    local name = mod_name..":"..name_plant
    local img = mod_name.."_"..name_plant
    
    minetest.register_node(name.."_wild", {--register wild plant
        tile_images = {img.."_wild.png"},
        inventory_image = img.."_wild.png",
        description = name_plant,
        drawtype = "plantlike",
        sunlight_propagates = true,
        paramtype = "light",
        walkable = false,
        groups = { snappy = 3,flammable=2 },
        sounds = default.node_sound_leaves_defaults(),
    })
    
end

--plant registration
--Just wild plant
--node registration
minetest.register_alias("harvest:lavender_wild", "plants:lavender_wild")
minetest.register_alias("harvest:redshroom_wild", "plants:redshroom_wild")
minetest.register_alias("harvest:corn_wild", "plants:corn_wild")
minetest.register_alias("harvest:cotton_wild", "plants:cotton_wild")
minetest.register_alias("harvest:brownshroom_wild", "plants:brownshroom_wild")
minetest.register_alias("harvest:chamomile_wild", "plants:chamomile_wild")
minetest.register_alias("harvest:colchicum_wild", "plants:colchicum_wild")
minetest.register_alias("harvest:poppy_wild", "plants:poppy_wild")
minetest.register_alias("harvest:grasstall_wild", "plants:grasstall_wild")
minetest.register_alias("harvest:grass_wild", "plants:grass_wild")
--Make node in which dirt changes after hoe preperation

--create plant nodes. Not all plants spawn in the wild for this you have to define it on the generate on function
add_plant("cotton")
add_plant("corn")
add_plant("lavender")
add_plant("potato")
add_plant("redshroom")
add_plant("cacao")
add_plant("brownshroom")
add_plant("chamomile")
add_plant("colchicum")
add_plant("poppy")
add_plant("grasstall")
add_plant("grass")

--generate(node, surface, minp, maxp, height_min, height_max, spread, habitat_size, habitat_nodes)
--For the plants that do spawn on the lang we have the generate function. This makes sure that plants are placed when new peaces of the level are loaded.
minetest.register_on_generated(function(minp, maxp, seed)
	generate("plants:lavender_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 60, 4, 4, {"default:sand",})
	generate("plants:redshroom_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 60, 20, 8, {"default:leaves",})
	generate("plants:corn_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 60, 8, 10, {"default:water_source",})
	generate("plants:cotton_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 60, 8, 10, {"default:desert_sand",})
	generate("plants:brownshroom_wild", {"default:stone"}, minp, maxp, -40, 10, 2, 10, {"default:water_source",})
	generate("plants:chamomile_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 40, 8, 4, {"default:stone_with_coal",})
	generate("plants:colchicum_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 40, 4, 10, {"default:stone_with_iron",})
	generate("plants:poppy_wild", {"defaultw:desert_sand"}, minp, maxp, -10, 20, 4, 10, {"default:water_source",})
	generate("plants:grasstall_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 20, 3, 3, {"default:water_source",})
	generate("plants:grass_wild", {"default:dirt_with_grass"}, minp, maxp, -10, 20, 3, 3, {"default:water_source",})
end)

print("[Harvest] Loaded!")
