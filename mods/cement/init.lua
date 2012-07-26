local CEMENT = {
	"normal",
--    "rose",
--	"dandelion_yellow",
--	"dandelion_white",
--	"tulip",
--	"viola",
}

minetest.register_alias("home_mod:normal_stone", "cement:cement")
--minetest.register_alias("home_mod:rose_stone", "home_mod:red_stone")
--minetest.register_alias("home_mod:dandelion_yellow_stone", "home_mod:yellow_stone")
--minetest.register_alias("home_mod:dandelion_white_stone", "home_mod:white_stone")
--minetest.register_alias("home_mod:tulip_stone", "home_mod:orange_stone")
--minetest.register_alias("home_mod:viola_stone", "home_mod:violet_stone")


minetest.register_craft({
	output = 'cement:aggregate_cement_normal',
	recipe = {
		{'node "default:sand"', 'node "default:sand"', 'node "default:sand"'},
		{'node "default:gravel"', 'node "default:gravel"', 'node "default:gravel"'},
		{'node "default:clay_lump"', 'node "default:clay_lump"', 'node "default:clay_lump"'},
	}
})

	minetest.register_node('cement:aggregate_cement_normal', {
		description = "Cement",
	    tiles = {'cement_normal_aggregate.png'},
	    inventory_image = minetest.inventorycube( 'cement_normal_aggregate.png'),
	    is_ground_content = true,
	    groups = {cracky=3},
	    material = minetest.digprop_gravellike(1.5),
	})

-- registering falling nodes
for _, color in ipairs(CEMENT) do
    local cname = 'cement_' .. color
    default.register_falling_node("cement:aggregate_" .. cname, "cement_" .. cname .. "aggregate.png")
end -- registering falling nodes end


    minetest.register_craft({
	    output = 'cement:bucket_cement_normal',
	    recipe = {
		    {'cement:aggregate_cement_normal'},
		    {'cement:aggregate_cement_normal'},
		    {'bucket:bucket_water'},
	    }
    })

minetest.register_craft({
	output = 'node "cement:cement" 1',
	recipe = {
		{'node "default:stone"', 'node "default:stone"'},
		{'node "default:stone"', 'node "default:stone"'},
		{'node "default:stone"', 'node "default:mese"'},
	}
})

minetest.register_node("cement:cement", {
	description = "cement",
	tiles = {"cement_cement.png"},
	inventory_image = minetest.inventorycube("cement_cement.png"),
	is_ground_content = true,
	groups = {cracky=3},
	material = minetest.digprop_stonelike(1.0),
})

-- registering cement buckets crafts nodes
for _, color in ipairs(CEMENT) do
    local cname = 'cement_' .. color

    
    minetest.register_craft({
	    output = 'cement:bucket_' .. cname,
	    recipe = {
            {'home_mod:' .. color .. '_petal'},
		    {'cement:bucket_cement_normal'},
	    }
    })
    minetest.register_craft({
	    output = 'cement:bucket_' .. cname ,
	    recipe = {
		    {'cement:bucket_cement_normal'},
            {'home_mod:' .. color .. '_petal'},	    
        }
    })
end -- registering cement buckets crafts end

-- registering cement buckets 
for _, color in ipairs(CEMENT) do
    local cname = 'cement_' .. color

    minetest.register_craftitem("cement:bucket_".. cname, {
		description = color .. " cement bucket",
	    image = cname .. "_bucket.png",
	    stack_max = 1,
	    on_place = minetest.item_place,
	    on_use = function(item, player, pointed_thing)
		    if pointed_thing.type == "node" then
			    minetest.env:add_node(pointed_thing.above, {name="cement:" .. cname .. "source"})
				local leftover = player:get_inventory():add_item("main", ItemStack('bucket:bucket_empty'))
				if leftover:is_empty() then
					item:take_item()
				else
					minetest.chat_send_player(player:get_player_name(), 'Not enough space in inventory!')
				end
		    end
		    return item
	    end,
    })
end -- registering cement buckets end


CEMENT_VISC = 20

-- registering cement sources
for _, color in ipairs(CEMENT) do
    local cname = 'cement_' .. color
    minetest.register_node("cement:" .. cname .. "source", {
		description = color .. " cement source",
	    drawtype = "liquid",
	    tiles = {"cement_" .. color .. "_block.png"},
	    inventory_image = minetest.inventorycube("cement_" .. color .. "_block.png"),
	    walkable = false,
	    pointable = false,
	    diggable = false,
	    buildable_to = true,
	    liquidtype = "source",
	    liquid_alternative_flowing = "cement:" .. cname .. "flowing",
	    liquid_alternative_source = "cement:" .. cname .. "source",
	    liquid_viscosity = CEMENT_VISC,
	    special_materials = {
		    -- New-style cement source material (WTF does this even mean?)
		    {image= cname .. "_block.png", backface_culling=false},
	    },
    })
end -- registering cement sources end

-- registering cement flowing
for _, color in ipairs(CEMENT) do
    local cname = 'cement_' .. color
    minetest.register_node("cement:" .. cname .. "flowing", {
	    drawtype = "flowingliquid",
	    tiles = {"cement_" .. color .. "_block.png"},
	    inventory_image = minetest.inventorycube("cement_" .. color .. "_block.png"),
	    walkable = false,
	    pointable = false,
	    diggable = false,
	    buildable_to = true,
	    liquidtype = "flowing",
	    liquid_alternative_flowing = "cement:".. cname .. "flowing",
	    liquid_alternative_source = "cement:" .. cname .. "source",
	    liquid_viscosity = CEMENT_VISC,
	    damage_per_second = CEMENT_DAMAGE,
	    special_materials = {
		    -- I do not understand this and I won't even try.
		    {image= cname .. "_block.png", backface_culling=false},
		    {image= cname .. "_block.png", backface_culling=true},
	    },
    })
end -- registering cement flowing end

-- registering cement abms flowing
for _, color in ipairs(CEMENT) do
    local cname = 'cement_' .. color

    minetest.register_abm(
    {nodenames = {"cement:" .. cname .. "flowing"},
    interval = 15.0,  -- fast-setting cement should hinder griefing
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
	    if (node.param1 > 1) then
		    minetest.env:add_node(pos, {name="home_mod:" .. color .. "_stone"})
	    end
    end
    })
end -- registering cement abms flowing end

-- registering cement abms source
for _, color in ipairs(CEMENT) do
    local cname = 'cement_' .. color

    minetest.register_abm(
    {nodenames = {"cement:" .. cname .."source"},
    interval = 15,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
    	minetest.env:add_node(pos, {name="home_mod:" .. color .. "_stone"})
    end
    })
end -- registering cement abms flowing end
--[[
-- registering cement concrete
for _, color in ipairs(CEMENT) do
    local cname = 'cement_' .. color

    minetest.register_node("cement:concrete_" .. color .."_block", {
	    tiles = { cname .. "_concrete.png"},
	    inventory_image = minetest.inventorycube( cname .. "_concrete.png"),
	    is_ground_content = true,
	    material = minetest.digprop_stonelike(3.0),
	    drop = 'node "cobble" 2',
    })
end -- registering cement concrete end ]]
print("[Cement] Loaded!")
