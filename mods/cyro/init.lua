--
--Cyro Mod By InfinityProject 
--

--
--Nodes
--

minetest.register_node ("cyro:ccube", {
    drawtype = draw,
    description = "Cyro Cube",
    tiles = {"cyro_cube.png"},
    inventory_image = {"cyro_cube.png"},
    sunlight_propagates = true,
    paramtype = 'light',
    walkable = true,
    light_source = LIGHT_MAX-0,
    material = minetest.digprop_constanttime(1.0),
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,}
   })

minetest.register_node ("cyro:cpower", {
    drawtype = draw,
    description = "Cyro Power",
    tiles = {"cyro_power_block.png"},
    inventory_image = {"cyro_power_block.png"},
    sunlight_propagates = true,
    paramtype = 'light',
    walkable = true,
    light_source = 15,
    material = minetest.digprop_constanttime(1.0),
    drop = 'craft "cyro:cpowerorb" 2',
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,}
   })

minetest.register_node ("cyro:cextractor", {
    drawtype = draw,
    description = "Cyro Extractor",
    tiles = {"cyro_extractor.png"},
    inventory_image = {"cyro_extractor.png"},
    sunlight_propagates = true,
    paramtype = 'light',
    walkable = true,
    light_source = 15,
    material = minetest.digprop_constanttime(1.0),
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,}
   })

minetest.register_node ("cyro:cblock", {
    drawtype = draw,
    description = "Cyro Block",
    tiles = {"cyro_block.png"},
    inventory_image = {"cyro_block.png"},
    sunlight_propagates = true,
    paramtype = 'light',
    walkable = true,
    light_source = 15,
    material = minetest.digprop_constanttime(1.0),
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,}
   })

minetest.register_node ("cyro:cnode", {
    drawtype = draw,
    description = "Cyro Node",
    tiles = {"cyro_node.png"},
    inventory_image = {"cyro_node.png"},
    sunlight_propagates = true,
    paramtype = 'light',
    walkable = true,
    light_source = 30,
    material = minetest.digprop_constanttime(1.0),
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,}
   })

minetest.register_node ("cyro:cglass", {
    drawtype = 'glasslike',
    description = "Cyro Glass",
    tiles = {"cyro_glass.png"},
    inventory_image = {"cyro_glass.png"},
    sunlight_propagates = true,
    paramtype = 'light',
    walkable = true,
    light_source = 30,
    material = minetest.digprop_constanttime(1.0),
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,}
   })

minetest.register_node ("cyro:cstairs", {
    drawtype = 'signlike',
    description = "Cyro stairs",
    tiles = {"cyro_block.png"},
    inventory_image = {"cyro_block.png"},
    sunlight_propagates = true,
    paramtype = 'wallmounted',
    walkable = true,
    climbable = true,
    light_source = 15,
    material = minetest.digprop_constanttime(1.0),
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,}
   })

minetest.register_node ("cyro:croof", {
    drawtype = 'raillike',
    description = "Cyro roof",
    tiles = {"cyro_node.png"},
    inventory_image = {"cyro_node.png"},
    sunlight_propagates = true,
    paramtype = 'wallmounted',
    walkable = true,
    light_source = 30,
    material = minetest.digprop_constanttime(1.0),
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,}
   })

minetest.register_node("cyro:cfence", {
	description = "Cyro Fence",
	drawtype = "fencelike",
	tiles = {"cyro_cube.png"},
	inventory_image = "cyro_fence_inventory.png",
	wield_image = "cyro_fence_inventory.png",
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("cyro:cladder", {
    description = "Cyro Ladder",
    drawtype = "signlike",
    tiles = {"cyro_ladder.png"},
    inventory_image = "cyro_ladder.png",
    wield_image = "cyro_ladder.png",
    paramtype = "light",
    paramtype2 = "wallmounted",
    is_ground_content = true,
    walkable = false,
    climbable = true,
    light_source = 30,
    selection_box = {
        type = "wallmounted",
        --wall_top = = <default>
        --wall_bottom = = <default>
        --wall_side = = <default>
    },
    material = minetest.digprop_glasslike(5.0),
    legacy_wallmounted = true,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,}
})

minetest.register_node("cyro:cchest", {
	description = "Cyro Chest",
	tiles = {"cyro_chest_top.png", "cyro_chest_top.png", "cyro_chest_side.png",
		"cyro_chest_side.png", "cyro_chest_side.png", "cyro_chest_front.png"},
	paramtype2 = "facedir",
	metadata_name = "chest",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("cyro:cchest_locked", {
	description = "Cyro Locked Chest",
	tiles = {"cyro_chest_top.png", "cyro_chest_top.png", "cyro_chest_side.png",
		"cyro_chest_side.png", "cyro_chest_side.png", "cyro_chest_lock.png"},
	paramtype2 = "facedir",
	metadata_name = "locked_chest",
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
})


minetest.register_node("cyro:sign_wall", {
	description = "Cyro Sign",
	drawtype = "signlike",
	tiles = {"cyro_sign_wall.png"},
	inventory_image = "cyro_sign_wall.png",
	wield_image = "cyro_sign_wall.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
        light_source = 30,
	metadata_name = "sign",
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups = {choppy=2,dig_immediate=2,},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})

minetest.register_node("cyro:clight", {
	description = "Cyro Light",
	drawtype = "torchlike",
	tiles = {"cyro_light_floor.png", "cyro_light_ceiling.png", "cyro_light.png"},
	inventory_image = "cyro_light.png",
	wield_image = "cyro_light.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = LIGHT_MAX-1,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	material = minetest.digprop_constanttime(0.0),
	legacy_wallmounted = true,
        groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,dig_immediate=2}
})

--
--Tools
--

minetest.register_tool("cyro:csword", {
	description = "Cyro Sword",
	inventory_image = "cyro_sword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			fleshy={times={[2]=0.80, [3]=0.40}, uses=100, maxlevel=1},
			snappy={times={[2]=0.80, [3]=0.40}, uses=100, maxlevel=1},
			choppy={times={[3]=0.90}, uses=100, maxlevel=0}
		}
	}
})

minetest.register_tool("cyro:cpick", {
	description = "Cyro Pick",
	inventory_image = "cyro_pick.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			cracky={times={[1]=4.00, [2]=1.60, [3]=1.00}, uses=100, maxlevel=2}
		}
	},
})

minetest.register_tool("cyro:caxe", {
	description = "Cyro Axe",
	inventory_image = "cyro_axe.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			choppy={times={[1]=3.00, [2]=1.00, [3]=0.60}, uses=100, maxlevel=1},
			fleshy={times={[2]=1.30, [3]=0.70}, uses=100, maxlevel=1}
		}
	},
})

minetest.register_tool("cyro:cshovel", {
	description = "Cyro Shovel",
	inventory_image = "cyro_shovel.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			crumbly={times={[1]=1.50, [2]=0.50, [3]=0.30}, uses=100, maxlevel=1}
		}
	},
})

--
--Craft Items
--

minetest.register_craftitem("cyro:cstaff", {
	image = "staff.png",
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = gunmod_shoot_cenergy,
	description = "Cyro Staff"
})

minetest.register_craftitem("cyro:cmatter", {
    image = "cyro_matter.png",
    on_place_on_ground = craftitem_place_item,
})

minetest.register_craftitem("cyro:cstick", {
    image = "cyro_stick.png",
    on_place_on_ground = craftitem_place_item,
})

minetest.register_craftitem("cyro:crod", {
    image = "cyro_rod.png",
    on_place_on_ground = craftitem_place_item,
})

minetest.register_craftitem("cyro:cenergy", {
    image = "cyro_energy.png",
    on_place_on_ground = craftitem_place_item,
})

minetest.register_craftitem("cyro:cpowerorb", {
    image = "cyro_power_orb.png",
    on_place_on_ground = craftitem_place_item,
})

--
--Crafting
--


minetest.register_craft({
    output = 'cyro:cmatter 16',
    recipe = {
	{'node mese'},
	{'node mese'},
    }
})

minetest.register_craft({
    output = 'cyro:cstick 4',
    recipe = {
	{'cyro:cmatter'},
	{'cyro:cmatter'},
    }
})

minetest.register_craft({
    output = 'cyro:cpick',
    recipe = {
        {'cyro:cmatter', 'cyro:cmatter', 'cyro:cmatter'},
        {'', 'cyro:cstick', ''},
        {'', 'cyro:cstick', ''},
    }
})

minetest.register_craft({
    output = 'cyro:caxe',
    recipe = {
        {'cyro:cmatter', 'cyro:cmatter', ''},
        {'cyro:cmatter', 'cyro:cstick', ''},
        {'', 'cyro:cstick', ''},
    }
})

minetest.register_craft({
    output = 'cyro:csword',
    recipe = {
        {'', 'cyro:cmatter', ''},
        {'', 'cyro:cmatter', ''},
        {'', 'cyro:cstick', ''},
    }
})

minetest.register_craft({
    output = 'cyro:cshovel',
    recipe = {
        {'', 'cyro:cmatter', ''},
        {'', 'cyro:cstick', ''},
        {'', 'cyro:cstick', ''},
    }
})

minetest.register_craft({
    output = 'cyro:ccube 4',
    recipe = {
        {'', '', ''},
        {'cyro:cmatter', 'cyro:cmatter', ''},
        {'cyro:cmatter', 'cyro:cmatter', ''},
    }
})

minetest.register_craft({
    output = 'cyro:cblock 4',
    recipe = {
        {'', '', ''},
        {'cyro:cenergy', 'cyro:cenergy', ''},
        {'cyro:cenergy', 'cyro:cenergy', ''},
    }
})

minetest.register_craft({
    output = 'cyro:cnode 4',
    recipe = {
        {'', 'cyro:cenergy', ''},
        {'cyro:cenergy', 'cyro:ccube', 'cyro:cenergy'},
        {'', 'cyro:cenergy', ''},
    }
})

minetest.register_craft({
    output = 'cyro:cchest ',
    recipe = {
        {'cyro:cmatter', 'cyro:cmatter', 'cyro:cmatter'},
        {'cyro:cmatter', '', 'cyro:cmatter'},
        {'cyro:cmatter', 'cyro:cmatter', 'cyro:cmatter'},
    }
})

minetest.register_craft({
    output = 'cyro:cchest_locked ',
    recipe = {
        {'cyro:cmatter', 'cyro:cmatter', 'cyro:cmatter'},
        {'cyro:cmatter', 'cyro:cenergy', 'cyro:cmatter'},
        {'cyro:cmatter', 'cyro:cmatter', 'cyro:cmatter'},
    }
})

minetest.register_craft({
    output = 'cyro:cladder 4',
    recipe = {
        {'cyro:cmatter', '', 'cyro:cmatter'},
	{'cyro:cmatter', 'cyro:cmatter', 'cyro:cmatter'},
	{'cyro:cmatter', '', 'cyro:cmatter'},
    }
})

minetest.register_craft({
    output = 'cyro:cfence 4',
    recipe = {
	{'cyro:cmatter', 'cyro:cmatter', 'cyro:cmatter'},
	{'cyro:cmatter', 'cyro:cmatter', 'cyro:cmatter'},
    }
})

minetest.register_craft({
    output = 'cyro:sign_wall 2',
    recipe = {
        {'cyro:cmatter', 'cyro:cmatter', 'cyro:cmatter'},
        {'cyro:cmatter', 'cyro:cmatter', 'cyro:cmatter'},
        {'', 'cyro:cstick', ''},
    }
})

minetest.register_craft({
    output = 'cyro:cstairs 4',
    recipe = {
	{'', 'cyro:cenergy', ''},
	{'cyro:cenergy', '', ''},
    }
})

minetest.register_craft({
    output = 'cyro:croof 4',
    recipe = {
	{'cyro:cenergy', 'cyro:cenergy', 'cyro:cenergy'},
    }
})

minetest.register_craft({
    output = 'cyro:cmatter 4',
    recipe = {
        {'', '', ''},
        {'', 'cyro:ccube', ''},
        {'', '', ''},
    }
})

minetest.register_craft({
    output = 'cyro:cmatter 16',
    recipe = {
	{'cyro:cblock'},
    }
})

minetest.register_craft({
    output = 'cyro:ccube 4',
    recipe = {
	{'cyro:cnode'},
    }
})


minetest.register_craft({
	type = "fuel",
	recipe = "cyro:cmatter",
	burntime = 100,
})

minetest.register_craft({
	type = "fuel",
	recipe = "cyro:cenergy",
	burntime = 500,
})

minetest.register_craft({
	type = "cooking",
	recipe = "cyro:cenergy",
	output = "cyro:cglass 4",
})

minetest.register_craft({
    output = 'cyro:clight 4',
    recipe = {
	{'cyro:cmatter'},
	{'cyro:cstick'},
    }
})

minetest.register_craft({
    output = 'cyro:crod 2',
    recipe = {
	{'cyro:cstick'},
	{'cyro:cstick'},
        {'cyro:cstick'},
    }
})

minetest.register_craft({
    output = 'cyro:cstaff',
    recipe = {
	{'cyro:cmatter'},
	{'cyro:crod'},
        {'cyro:crod'},
    }
})

minetest.register_craft({
    output = 'cyro:cenergy 16',
    recipe = {
	{'', 'cyro:cmatter', ''},
	{'cyro:cmatter', '', 'cyro:cmatter'},
        {'', 'cyro:cmatter', ''},
    }
})

minetest.register_craft({
    output = 'cyro:cextractor',
    recipe = {
	{'', 'cyro:ccube', ''},
	{'cyro:ccube', '', 'cyro:ccube'},
        {'', 'cyro:ccube', ''},
    }
})

minetest.register_craft({
    output = 'cyro:pure_matter',
    recipe = {
	{'cyro:cmatter'},
        {'cyro:cextractor'},
    }
})

minetest.register_craft({
    output = 'cyro:pure_energy',
    recipe = {
	{'cyro:cenergy'},
        {'cyro:cextractor'},
    }
})

--
--Pure Energy and Matter
--

minetest.register_node("cyro:pure_energy_flowing", {
	description = "pure energy (flowing)",
	inventory_image = minetest.inventorycube("cyro_pure_energy.png"),
	drawtype = "flowingliquid",
	tiles = {"cyro_pure_energy.png"},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "cyro:pure_energy_flowing",
	liquid_alternative_source = "cyro:pure_energy",
	liquid_viscosity = LAVA_VISC,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	special_materials = {
		{image="cyro_pure_energy.png", backface_culling=false},
		{image="cyro_pure_energy.png", backface_culling=true},
	},
	groups = {lava=3, liquid=2, hot=10, igniter=12},
})

minetest.register_node("cyro:pure_energy", {
	description = "Pure Energy",
	inventory_image = minetest.inventorycube("cyro_pure_energy.png"),
	drawtype = "liquid",
	tiles = {"cyro_pure_energy.png"},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "cyro:pure_energy_flowing",
	liquid_alternative_source = "cyro:pure_energy",
	liquid_viscosity = LAVA_VISC,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	special_materials = {
		-- New-style lava source material (mostly unused)
		{image="cyro_pure_energy.png", backface_culling=false},
	},
	groups = {lava=3, liquid=2, hot=10, igniter=12},
})

minetest.register_node("cyro:pure_matter_flowing", {
	description = "pure matter (flowing)",
	inventory_image = minetest.inventorycube("cyro_pure_matter.png"),
	drawtype = "flowingliquid",
	tiles = {"cyro_pure_matter.png"},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "cyro:pure_matter_flowing",
	liquid_alternative_source = "cyro:pure_matter",
	liquid_viscosity = LAVA_VISC,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	special_materials = {
		{image="cyro_pure_matter.png", backface_culling=false},
		{image="cyro_pure_matter.png", backface_culling=true},
	},
	groups = {lava=3, liquid=2, hot=6, igniter=8},
})

minetest.register_node("cyro:pure_matter", {
	description = "Pure Matter",
	inventory_image = minetest.inventorycube("cyro_pure_matter.png"),
	drawtype = "liquid",
	tiles = {"cyro_pure_matter.png"},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "cyro:pure_matter_flowing",
	liquid_alternative_source = "cyro:pure_matter",
	liquid_viscosity = LAVA_VISC,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	special_materials = {
		-- New-style lava source material (mostly unused)
		{image="cyro_pure_matter.png", backface_culling=false},
	},
	groups = {lava=3, liquid=2, hot=10, igniter=12},
})

minetest.register_abm({nodenames = {"cyro:pure_energy"},
    interval = 1.0,
    chance = 1,
    action = function(pos, node, active_cyroject_count, active_cyroject_count_wider)
            for i=-1,1 do
            for j=-1,1 do
            for k=-1,1 do
        p = {x=pos.x+i, y=pos.y+j, z=pos.z+k}
        n = minetest.env:get_node(p)
        if (n.name=="cyro:pure_matter_flowing") or (n.name == "cyro:pure_matter") then
            minetest.env:add_node(pos, {name="cyro:cpower"})
                end
            end
        end
    end
end
})
