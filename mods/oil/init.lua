-- Oil Mod 1.1
-- By sfan5
OIL_VISC = 16
OIL_ALPHA = 210

minetest.register_node("oil:oil_flowing", {
	description = "Oil (flowing)",
	inventory_image = minetest.inventorycube("oil_oil.png"),
	drawtype = "flowingliquid",
	tiles = {"oil_oil.png"},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "oil:oil_flowing",
	liquid_alternative_source = "oil:oil_source",
	liquid_viscosity = OIL_VISC,
	post_effect_color = {a=OIL_ALPHA, r=0, g=0, b=0},
	special_materials = {
		{image="oil_oil.png", backface_culling=false},
		{image="oil_oil.png", backface_culling=true},
	},
})

minetest.register_node("oil:oil_source", {
	description = "Oil",
	inventory_image = minetest.inventorycube("oil_oil.png"),
	drawtype = "liquid",
	tiles = {"oil_oil.png"},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "oil:oil_flowing",
	liquid_alternative_source = "oil:oil_source",
	liquid_viscosity = OIL_VISC,
	post_effect_color = {a=OIL_ALPHA, r=0, g=0, b=0},
	special_materials = {
		{image="oil_oil.png", backface_culling=false},
	},
})

bucket.register_liquid(
	"oil:oil_source",
	"oil:oil_flowing",
	"oil:bucket_oil",
	"oil_oil_bucket.png"
)

minetest.register_on_generated(function(minp, maxp)
    if math.random() > 0.95 then
        -- Generate Oil only under Water
        if minetest.env:get_node(minp).name == "default:water_source" then
            made_oil_fountain = false
            -- Generate much Oil
            for x = math.random(-6,-4),math.random(4,6),1 do
                for y = math.random(-6,-4),math.random(4,6),1 do
                    for z = math.random(-6,-4),math.random(4,6),1 do
                        np = {x=minp.x+x,y=minp.y+y,z=minp.z+z}
                        while minetest.env:get_node(np).name == "default:water_source" or minetest.env:get_node(np).name == "air" do
                            np.y = np.y - 1
                        end
                        np.y = np.y + 1
                        if np.y < -5 then
                            minetest.env:add_node(np, {name="oil:oil_source"})
                            if made_oil_fountain == false then
                                if math.random() > 0.50 then
                                    for y_ = np.y,5,1 do
                                        local np_ = np
                                        np_.y = y_
                                        minetest.env:add_node(np_, {name="oil:oil_source"})
                                    end
                                    made_oil_fountain = true
                                    local np__ = np
                                    np__.y = 5
                                    print("[Oil] Generated Oil Fountain at "..dump(np__))
                                    np__ = nil
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)


minetest.register_node("oil:pump_empty", {
	description = "Pump",
	tiles = {"oil_pump_side.png", "oil_pump_side.png", "oil_pump_empty.png"},
	is_ground_content = true,
	groups = {cracky=3},
})
minetest.register_node("oil:pump_oil", {
	description = "Pump",
	tiles = {"oil_pump_side.png", "oil_pump_side.png", "oil_pump_oil.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'oil:pump_empty 1',
})

minetest.register_craft({
	output = 'oil:pump_empty',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', 'bucket:bucket_empty', 'default:steel_ingot'},
		{'', 'default:stick', ''},
	}
})

minetest.register_node("oil:pipe_empty", {
    paramtype2 = "facedir",
	description = "Pipe",
	tiles = {"default_cobble.png","default_cobble.png","oil_pipe_empty.png","oil_pipe_empty.png","oil_pipe_empty_side.png","oil_pipe_empty_side.png"},
	groups = {cracky=2},
	inventory_image = "oil_pipe_inventory.png",
	wield_image = "oil_pipe_inventory.png",
})

minetest.register_node("oil:pipe_oil", {
    paramtype2 = "facedir",
	tiles = {"default_cobble.png","default_cobble.png","oil_pipe_oil.png","oil_pipe_oil.png","oil_pipe_oil_side.png","oil_pipe_oil_side.png"},
	groups = {cracky=2},
	drop = "oil:pipe_empty 1",
})

minetest.register_node("oil:pipe_fuel", {
    paramtype2 = "facedir",
	tiles = {"default_cobble.png","default_cobble.png","oil_pipe_fuel.png","oil_pipe_fuel.png","oil_pipe_fuel_side.png","oil_pipe_fuel_side.png"},
	groups = {cracky=2},
	drop = "oil:pipe_empty 1",
})

minetest.register_node("oil:pipe_wood", {
    description = "Wood Pipe",
    paramtype2 = "facedir",
	tiles = {"default_cobble.png","default_cobble.png","oil_pipe_wood.png","oil_pipe_wood.png","oil_pipe_wood_side.png","oil_pipe_wood_side.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=4},
	drop = "oil:pipe_wood 1",
	inventory_image = "oil_pipe_wood_inventory.png",
	wield_image = "oil_pipe_wood_inventory.png",
})

minetest.register_node("oil:pipe_wood_fuel", {
    paramtype2 = "facedir",
	tiles = {"default_cobble.png","default_cobble.png","oil_pipe_wood_fuel.png","oil_pipe_wood_fuel.png","oil_pipe_wood_fuel_side.png","oil_pipe_wood_fuel_side.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=4},
	drop = "oil:pipe_wood 1",
})

minetest.register_craft({
	output = 'oil:pipe_empty 4',
	recipe = {
		{'default:cobble', 'default:cobble', 'default:cobble'},
		{'', '', ''},
		{'default:cobble', 'default:cobble', 'default:cobble'},
	}
})

minetest.register_craft({
	output = 'oil:pipe_wood 4',
	recipe = {
		{'default:cobble', 'default:cobble', 'default:cobble'},
		{'default:stick', '', 'default:stick'},
		{'default:cobble', 'default:cobble', 'default:cobble'},
	}
})

minetest.register_node("oil:refinery_empty", {
    description = "Refinery",
	tiles = {"oil_refinery_top.png","oil_refinery_top.png","oil_refinery_empty.png"},
	groups = {cracky=3},
})

minetest.register_node("oil:refinery_working", {
	tiles = {"oil_refinery_top.png","oil_refinery_top.png","oil_refinery_working.png"},
	groups = {cracky=3},
	drop = "oil:refinery_empty 1",
})

minetest.register_craft({
	output = 'oil:refinery_empty',
	recipe = {
		{'default:steel_ingot', 'default:stick', 'default:steel_ingot'},
		{'bucket:bucket_empty', 'default:mese', 'bucket:bucket_empty'},
		{'default:steel_ingot', 'default:stick', 'default:steel_ingot'},
	}
})

minetest.register_node("oil:siphon_empty", {
	description = "Siphon",
	tiles = {"oil_siphon_top.png", "oil_siphon_top.png", "oil_siphon_side_empty.png"},
	is_ground_content = true,
	groups = {cracky=3},
})
minetest.register_node("oil:siphon_fuel", {
	tiles = {"oil_siphon_top.png", "oil_siphon_top.png", "oil_siphon_side_fuel.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'oil:siphon_empty 1',
})

minetest.register_craft({
	output = 'oil:siphon_empty',
	recipe = {
		{'', 'oil:pipe_empty', ''},
		{'default:steel_ingot', 'bucket:bucket_empty', 'default:steel_ingot'},
		{'', 'default:steel_ingot', ''},
	}
})

minetest.register_node("oil:gfcable_empty", {
    paramtype2 = "facedir",
	description = "Glass Fibre Cable",
	tiles = {"oil_gfcable_empty.png","oil_gfcable_empty.png","oil_gfcable_empty.png","oil_gfcable_empty.png","oil_gfcable_empty_side.png","oil_gfcable_empty_side.png"},
	groups = {snappy=1,bendy=1},
	inventory_image = "oil_gfcable_inventory.png",
	wield_image = "oil_gfcable_inventory.png",
})

minetest.register_node("oil:gfcable_energy", {
    paramtype2 = "facedir",
	tiles = {"oil_gfcable_energy.png","oil_gfcable_energy.png","oil_gfcable_energy.png","oil_gfcable_energy.png","oil_gfcable_energy_side.png","oil_gfcable_energy_side.png"},
	groups = {snappy=1,bendy=1},
	drop = "oil:gfcable_empty 1",
})

minetest.register_craft({
	output = 'oil:gfcable_empty 2',
	recipe = {
		{'default:glass', 'default:glass', 'default:glass'},
		{'oil:pipe_empty', 'default:mese', 'oil:pipe_empty'},
		{'default:glass', 'default:glass', 'default:glass'},
	}
})


minetest.register_node("oil:ec", {
	description = "Fuel-Energy Converter",
	tiles = {"oil_ec_top.png", "oil_ec_top.png", "oil_ec_side.png"},
	is_ground_content = true,
	groups = {snappy=1,bendy=1},
})

minetest.register_craft({
	output = 'oil:ec',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'oil:pipe_empty', 'default:mese', 'oil:gfcable_empty'},
		{'', 'default:steel_ingot', ''},
	}
})

minetest.register_abm({
	nodenames = {"oil:pump_empty"},
	interval = 0.5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
	    if node.param2 == nil then
	        node.param2 = 1 -- Init
	    end
	    local p = {x=pos.x,y=pos.y,z=pos.z}
	    p.y = p.y - node.param2
	    if minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z}).name ~= "default:torch" then
	        did_work = false
	        for x = p.x-10,p.x+10,1 do
	            if did_work == true then break end
	            for z = p.z-10,p.z+10,1 do
	                local np = {x=x,y=p.y,z=z}
	                if minetest.env:get_node(np).name == "oil:oil_source" then
	                    minetest.env:add_node(pos, {name="oil:pump_oil",param2=node.param2})
	                    if np.y < 0 then
	                        minetest.env:add_node(np, {name="default:water_source"})
	                    else
	                        minetest.env:add_node(np, {name="air"})
	                    end
	                    did_work = true
	                    break
	                end
	            end
	        end
	        if did_work == false then
	            node.param2 = node.param2 + 1
	            minetest.env:add_node(pos, {name=node.name,param2=node.param2})
	        end
	    end
	        --[[
	        if minetest.env:get_node(p).name == "oil:oil_source" then
	            minetest.env:add_node(pos, {name="oil:pump_oil",param2=node.param2})
	            minetest.env:add_node(p, {name="oil:oil_flowing"})
	        else
	            node.param2 = node.param2 + 1
	            minetest.env:add_node(pos, {name=node.name,param2=node.param2})
	        end
	     --]]
	end})
minetest.register_abm({
	nodenames = {"oil:pump_oil"},
	interval = 0.5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local p = {x=pos.x+1,y=pos.y,z=pos.z}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_empty" then
	        minetest.env:add_node(p, {name="oil:pipe_oil", param2=n.param2,param1=5})
	        minetest.env:add_node(pos, {name="oil:pump_empty",param2=node.param2})
	    end
	    
	    local p = {x=pos.x-1,y=pos.y,z=pos.z}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_empty" then
	        minetest.env:add_node(p, {name="oil:pipe_oil", param2=n.param2,param1=5})
	        minetest.env:add_node(pos, {name="oil:pump_empty",param2=node.param2})
	    end
	    
	    local p = {x=pos.x,y=pos.y,z=pos.z+1}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_empty" then
	        minetest.env:add_node(p, {name="oil:pipe_oil", param2=n.param2,param1=5})
	        minetest.env:add_node(pos, {name="oil:pump_empty",param2=node.param2})
	    end
	    
	    local p = {x=pos.x,y=pos.y,z=pos.z-1}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_empty" then
	        minetest.env:add_node(p, {name="oil:pipe_oil", param2=n.param2,param1=5})
	        minetest.env:add_node(pos, {name="oil:pump_empty",param2=node.param2})
	    end
	end})


minetest.register_on_placenode(function(pos, newnode, placer)
    pos.y = pos.y - 1 -- Fix a weird Bug
    
    if newnode.name == "oil:pipe_empty" then
        if minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).name == "oil:pipe_empty" then
            newnode.param2 = 0
        end
        if minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).name == "oil:pipe_empty" then
            newnode.param2 = 0
        end
        if minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).name == "oil:pipe_empty" then
            newnode.param2 = 1
        end
        if minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).name == "oil:pipe_empty" then
            newnode.param2 = 1
        end
        minetest.env:add_node(pos,newnode)
    end
    if newnode.name == "oil:pipe_wood" then
        if minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).name == "oil:pipe_wood" then
            newnode.param2 = 0
        end
        if minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).name == "oil:pipe_wood" then
            newnode.param2 = 0
        end
        if minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).name == "oil:pipe_wood" then
            newnode.param2 = 1
        end
        if minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).name == "oil:pipe_wood" then
            newnode.param2 = 1
        end
        minetest.env:add_node(pos,newnode)
    end
    if newnode.name == "oil:gfcable_empty" then
        if minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).name == "oil:gfcable_empty" then
            newnode.param2 = 0
        end
        if minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).name == "oil:gfcable_empty" then
            newnode.param2 = 0
        end
        if minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).name == "oil:gfcable_empty" then
            newnode.param2 = 1
        end
        if minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).name == "oil:gfcable_empty" then
            newnode.param2 = 1
        end
        minetest.env:add_node(pos,newnode)
    end
end)


-- Exclude Check Table
-- 0 = x+
-- 1 = x-
-- 2 = z+
-- 3 = z-

minetest.register_abm({
	nodenames = {"oil:pipe_oil"},
	interval = 0.5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
	    if node.param1 == nil then node.param1 = 5 end -- No Flow-Direction
	    if node.param1 ~= 0 then
	        local p = {x=pos.x+1,y=pos.y,z=pos.z}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:pipe_empty" then
	            minetest.env:add_node(p, {name="oil:pipe_oil", param2=n.param2, param1=1})
	            minetest.env:add_node(pos, {name="oil:pipe_empty",param2=node.param2})
	        end
	    end
	    
	    if node.param1 ~= 1 then
	        local p = {x=pos.x-1,y=pos.y,z=pos.z}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:pipe_empty" then
	            minetest.env:add_node(p, {name="oil:pipe_oil", param2=n.param2, param1=0})
	            minetest.env:add_node(pos, {name="oil:pipe_empty",param2=node.param2})
	        end
	    end
	    
	    if node.param1 ~= 2 then
	        local p = {x=pos.x,y=pos.y,z=pos.z+1}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:pipe_empty" then
	            minetest.env:add_node(p, {name="oil:pipe_oil", param2=n.param2, param1=3})
	            minetest.env:add_node(pos, {name="oil:pipe_empty",param2=node.param2})
	        end
	    end
	    
	    if node.param1 ~= 3 then
	        local p = {x=pos.x,y=pos.y,z=pos.z-1}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:pipe_empty" then
	            minetest.env:add_node(p, {name="oil:pipe_oil", param2=n.param2, param1=2})
	            minetest.env:add_node(pos, {name="oil:pipe_empty",param2=node.param2})
	        end
	    end
	end})

minetest.register_abm({
	nodenames = {"oil:gfcable_energy"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
	    if node.param1 == nil then node.param1 = 5 end -- No Flow-Direction
	    if node.param1 ~= 0 then
	        local p = {x=pos.x+1,y=pos.y,z=pos.z}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:gfcable_empty" then
	            minetest.env:add_node(p, {name="oil:gfcable_energy", param2=n.param2, param1=1})
	            minetest.env:add_node(pos, {name="oil:gfcable_empty",param2=node.param2})
	        end
	    end
	    
	    if node.param1 ~= 1 then
	        local p = {x=pos.x-1,y=pos.y,z=pos.z}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:gfcable_empty" then
	            minetest.env:add_node(p, {name="oil:gfcable_energy", param2=n.param2, param1=0})
	            minetest.env:add_node(pos, {name="oil:gfcable_empty",param2=node.param2})
	        end
	    end
	    
	    if node.param1 ~= 2 then
	        local p = {x=pos.x,y=pos.y,z=pos.z+1}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:gfcable_empty" then
	            minetest.env:add_node(p, {name="oil:gfcable_energy", param2=n.param2, param1=3})
	            minetest.env:add_node(pos, {name="oil:pipe_empty",param2=node.param2})
	        end
	    end
	    
	    if node.param1 ~= 3 then
	        local p = {x=pos.x,y=pos.y,z=pos.z-1}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:gfcable_empty" then
	            minetest.env:add_node(p, {name="oil:gfcable_energy", param2=n.param2, param1=2})
	            minetest.env:add_node(pos, {name="oil:gfcable_empty",param2=node.param2})
	        end
	    end
	end})

minetest.register_abm({
	nodenames = {"oil:pipe_fuel"},
	interval = 0.5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
	    if node.param1 == nil then node.param1 = 5 end -- No Flow-Direction
	    if node.param1 ~= 0 then
	        local p = {x=pos.x+1,y=pos.y,z=pos.z}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:pipe_empty" then
	            minetest.env:add_node(p, {name="oil:pipe_fuel", param2=n.param2,param1=1})
	            minetest.env:add_node(pos, {name="oil:pipe_empty",param2=node.param2})
	        end
	    end
	    
	    if node.param1 ~= 1 then
	        local p = {x=pos.x-1,y=pos.y,z=pos.z}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:pipe_empty" then
	            minetest.env:add_node(p, {name="oil:pipe_fuel", param2=n.param2,param1=0})
	            minetest.env:add_node(pos, {name="oil:pipe_empty",param2=node.param2})
	        end
	    end
	    
	    if node.param1 ~= 2 then
	        local p = {x=pos.x,y=pos.y,z=pos.z+1}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:pipe_empty" then
	            minetest.env:add_node(p, {name="oil:pipe_fuel", param2=n.param2,param1=3})
	            minetest.env:add_node(pos, {name="oil:pipe_empty",param2=node.param2})
	        end
	    end
	    
	    if node.param1 ~= 3 then
	        local p = {x=pos.x,y=pos.y,z=pos.z-1}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:pipe_empty" then
	            minetest.env:add_node(p, {name="oil:pipe_fuel", param2=n.param2,param1=2})
	            minetest.env:add_node(pos, {name="oil:pipe_empty",param2=node.param2})
	        end
	    end
	end})

minetest.register_abm({
	nodenames = {"oil:pipe_wood_fuel"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local p = {x=pos.x+1,y=pos.y,z=pos.z}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_empty" then
	        minetest.env:add_node(p, {name="oil:pipe_fuel", param2=n.param2,param1=5})
	        minetest.env:add_node(pos, {name="oil:pipe_wood",param2=node.param2})
	    end
	    
	    local p = {x=pos.x-1,y=pos.y,z=pos.z}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_empty" then
	        minetest.env:add_node(p, {name="oil:pipe_fuel", param2=n.param2,param1=5})
	        minetest.env:add_node(pos, {name="oil:pipe_wood",param2=node.param2})
	    end
	    
	    local p = {x=pos.x,y=pos.y,z=pos.z+1}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_empty" then
	        minetest.env:add_node(p, {name="oil:pipe_fuel", param2=n.param2,param1=5})
	        minetest.env:add_node(pos, {name="oil:pipe_wood",param2=node.param2})
	    end
	    
	    local p = {x=pos.x,y=pos.y,z=pos.z-1}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_empty" then
	        minetest.env:add_node(p, {name="oil:pipe_fuel", param2=n.param2,param1=5})
	        minetest.env:add_node(pos, {name="oil:pipe_wood",param2=node.param2})
	    end
	end})

-- oil:refinery_working States
-- 1 = contains oil
-- 2 = contains fuel

minetest.register_abm({
	nodenames = {"oil:refinery_empty"},
	interval = 5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
        local p = {x=pos.x+1,y=pos.y,z=pos.z}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_oil" then
	        minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	        minetest.env:add_node(pos, {name="oil:refinery_working",param2=1})
	    end
	    
	    local p = {x=pos.x-1,y=pos.y,z=pos.z}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_oil" then
	        minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	        minetest.env:add_node(pos, {name="oil:refinery_working",param2=1})
	    end
	    
	    local p = {x=pos.x,y=pos.y,z=pos.z+1}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_oil" then
	        minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	        minetest.env:add_node(pos, {name="oil:refinery_working",param2=1})
	    end
	    
	    local p = {x=pos.x,y=pos.y,z=pos.z-1}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_oil" then
	        minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	        minetest.env:add_node(pos, {name="oil:refinery_working",param2=1})
	    end
	end})

minetest.register_abm({
	nodenames = {"oil:refinery_working"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
	    if node.param2 == nil then
	        print("[Oil] ERROR: Refinery with wrong param2 found at " .. dump(pos) .. " -> deleting itself")
	        minetest.env:remove_node(pos)
	    else
	        did_something = false
	        trash_param1 = true
	        
	        if node.param1 >= 5 then
	            -- The Refinery tried 5 Times to find Oil but didn't found anything -> Deactivate itself
	            did_something = false
	            node.param2 = 1337 -- Nothing should happen
	            minetest.env:add_node(pos,{name="oil:refinery_empty"})
	        end
	        if node.param2 == 0 then
	            local found_oil = false
	            --------------------
	            local p = {x=pos.x+1,y=pos.y,z=pos.z}
	            local n = minetest.env:get_node(p)
	            if n.name == "oil:pipe_oil" then
	                minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	                found_oil = true
	            end
	            
	            local p = {x=pos.x-1,y=pos.y,z=pos.z}
	            local n = minetest.env:get_node(p)
	            if n.name == "oil:pipe_oil" then
	                minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	                found_oil = true
	            end
	            
	            local p = {x=pos.x,y=pos.y,z=pos.z+1}
	            local n = minetest.env:get_node(p)
	            if n.name == "oil:pipe_oil" then
	                minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	                found_oil = true
	            end
	            
	            local p = {x=pos.x,y=pos.y,z=pos.z-1}
	            local n = minetest.env:get_node(p)
	            if n.name == "oil:pipe_oil" then
	                minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	                found_oil = true
	            end
	            --------------------
	            if found_oil then
	                node.param2 = 1
	                did_something = true
	            else
	                if node.param1 == nil then
	                    node.param1 = 1
	                else
	                    node.param1 = node.param1 + 1
	                end
	                did_something = true
	                trash_param1 = false
	            end
	        end
	        if node.param2 == 1 then
	            -- Contains Oil -> Convert Oil
	            node.param2 = 2
	            did_something = true
	        end
	        if node.param2 == 2 then
	            -- Contains Fuel -> Output Fuel
                --------------------
                did_something = false -- Assume did_something is false
	            local p = {x=pos.x+1,y=pos.y,z=pos.z}
	            local n = minetest.env:get_node(p)
	            if n.name == "oil:pipe_wood" and did_something == false then
	                minetest.env:add_node(p, {name="oil:pipe_wood_fuel", param2=n.param2,param1=5})
	                did_something = true
	            end
	            
	            local p = {x=pos.x-1,y=pos.y,z=pos.z}
	            local n = minetest.env:get_node(p)
	            if n.name == "oil:pipe_wood" and did_something == false then
	                minetest.env:add_node(p, {name="oil:pipe_wood_fuel", param2=n.param2,param1=5})
	                did_something = true
	            end
	            
	            local p = {x=pos.x,y=pos.y,z=pos.z+1}
	            local n = minetest.env:get_node(p)
	            if n.name == "oil:pipe_wood" and did_something == false then
	                minetest.env:add_node(p, {name="oil:pipe_wood_fuel", param2=n.param2,param1=5})
	                did_something = true
	            end
	            
	            local p = {x=pos.x,y=pos.y,z=pos.z-1}
	            local n = minetest.env:get_node(p)
	            if n.name == "oil:pipe_wood" and did_something == false then
	                minetest.env:add_node(p, {name="oil:pipe_wood_fuel", param2=n.param2,param1=5})
	                did_something = true
	            end
	            --------------------
	            if did_something then
	                node.param2 = 0
	            end
	        end
	        
	        if did_something then
	            -- Save param2
	            if trash_param1 then
	                node.param1 = nil
	            end
	            minetest.env:add_node(pos, node)
	        end
	    end
	end})

minetest.register_craftitem("oil:fuel_bucket", {
	inventory_image = "oil_fuel_bucket.png",
	stack_max = 50,
	description = "Bucket of Fuel",
})

minetest.register_craft({
	type = "fuel",
	recipe = "oil:fuel_bucket",
	burntime = 90,
})

minetest.register_abm({
	nodenames = {"oil:siphon_empty"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
        local p = {x=pos.x+1,y=pos.y,z=pos.z}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_fuel" then
	        minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	        minetest.env:add_node(pos, {name="oil:siphon_fuel"})
	    end
	    
	    local p = {x=pos.x-1,y=pos.y,z=pos.z}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_fuel" then
	        minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	        minetest.env:add_node(pos, {name="oil:siphon_fuel"})
	    end
	    
	    local p = {x=pos.x,y=pos.y,z=pos.z+1}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_fuel" then
	        minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	        minetest.env:add_node(pos, {name="oil:siphon_fuel"})
	    end
	    
	    local p = {x=pos.x,y=pos.y,z=pos.z-1}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_fuel" then
	        minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	        minetest.env:add_node(pos, {name="oil:siphon_fuel"})
	    end
	end})

minetest.register_abm({
	nodenames = {"oil:siphon_fuel"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
        minetest.env:add_item({x=pos.x,y=pos.y+1,z=pos.z}, "oil:fuel_bucket")
        minetest.env:add_node(pos, {name="oil:siphon_empty"})
	end})

minetest.register_abm({
	nodenames = {"oil:ec"},
	interval = 0.5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
	    local found_fuel = false
	    --------------------
	    local p = {x=pos.x+1,y=pos.y,z=pos.z}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_fuel" and found_fuel == false then
	        minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	        found_fuel = true
	    end
	    
	    local p = {x=pos.x-1,y=pos.y,z=pos.z}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_fuel" and found_fuel == false then
	        minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	        found_fuel = true
	    end
	    
	    local p = {x=pos.x,y=pos.y,z=pos.z+1}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_fuel" and found_fuel == false then
	        minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	        found_fuel = true
	    end
	    
	    local p = {x=pos.x,y=pos.y,z=pos.z-1}
	    local n = minetest.env:get_node(p)
	    if n.name == "oil:pipe_fuel" and found_fuel == false then
	        minetest.env:add_node(p, {name="oil:pipe_empty", param2=n.param2,param1=n.param1})
	        found_fuel = true
	    end
	    --------------------
	    if found_fuel then
	        local energy_gone = false
	        ----------
	        local p = {x=pos.x+1,y=pos.y,z=pos.z}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:gfcable_empty" and energy_gone == false then
	            minetest.env:add_node(p, {name="oil:gfcable_energy", param2=n.param2,param1=n.param1})
	            energy_gone = true
	        end
	        
	        local p = {x=pos.x-1,y=pos.y,z=pos.z}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:gfcable_empty" and energy_gone == false then
	            minetest.env:add_node(p, {name="oil:gfcable_energy", param2=n.param2,param1=n.param1})
	            energy_gone = true
	        end
	        
	        local p = {x=pos.x,y=pos.y,z=pos.z+1}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:gfcable_empty" and energy_gone == false then
	            minetest.env:add_node(p, {name="oil:gfcable_energy", param2=n.param2,param1=n.param1})
	            energy_gone = true
	        end
	        
	        local p = {x=pos.x,y=pos.y,z=pos.z-1}
	        local n = minetest.env:get_node(p)
	        if n.name == "oil:gfcable_empty" and energy_gone == false then
	            minetest.env:add_node(p, {name="oil:gfcable_energy", param2=n.param2,param1=n.param1})
	            energy_gone = true
	        end
	        ----------
	    end
	end})

