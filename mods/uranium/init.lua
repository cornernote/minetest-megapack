--Mod Name: Uranium Mod
--Author: LandMine
--Last Edit: 07.28.2012
--About Mod: Adds various items to Minetest
--MineTest Version: MineTest-C55 0.4.dev-20120606-c57e508

-------------------------------------
function spawn_tnt(pos, entname)
    minetest.sound_play("", {pos = pos,gain = 1.0,max_hear_distance = 8,})
    return minetest.env:add_entity(pos, entname)
end

function activate_if_tnt(nname, np, tnt_np, tntr)
    if nname == "uranium:nuclear_bomb" or nname == "uranium:nuclear_launch" then
        local e = spawn_tnt(np, nname)
        e:setvelocity({x=(np.x - tnt_np.x)*3+(tntr / 4), y=(np.y - tnt_np.y)*3+(tntr / 3), z=(np.z - tnt_np.z)*3+(tntr / 4)})
    end
end

function do_tnt_physics(tnt_np,tntr)
    local objs = minetest.env:get_objects_inside_radius(tnt_np, tntr)
    for k, obj in pairs(objs) do
        local oname = obj:get_entity_name()
        local v = obj:getvelocity()
        local p = obj:getpos()
        if oname == "uranium:nuclear_bomb" or nname == "uranium:nuclear_launch" then
            obj:setvelocity({x=(p.x - tnt_np.x) + (tntr / 2) + v.x, y=(p.y - tnt_np.y) + tntr + v.y, z=(p.z - tnt_np.z) + (tntr / 2) + v.z})
        else
            if v ~= nil then
                obj:setvelocity({x=(p.x - tnt_np.x) + (tntr / 4) + v.x, y=(p.y - tnt_np.y) + (tntr / 2) + v.y, z=(p.z - tnt_np.z) + (tntr / 4) + v.z})
            else
                if obj:get_player_name() ~= nil then
                    obj:set_hp(obj:get_hp() - 1)
                end
            end
        end
    end
end

--
-- Fuels
--

minetest.register_craft({
	type = "fuel",
	recipe = "uranium:uranium_dust",
	burntime = 40,
})

minetest.register_craft({
	type = "fuel",
	recipe = "uranium:radioactive_coal",
	burntime = 80,
})

uranium = {}
---------------------------------------------------------------------------------------------------------

--01. Uranium Ore:

minetest.register_node( "uranium:uranium_ore", {
	description = "Uranium Ore",
	tiles = { "default_stone.png^uranium_ore.png" },
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "uranium:uranium_dust" 3',
})

---------------------------------------------------------------------------------------------------------

--02.Uranium Dust:

minetest.register_craftitem( "uranium:uranium_dust", {
	description = "Uranium Dust",
	inventory_image = "uranium_dust.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

---------------------------------------------------------------------------------------------------------

--03.Uranium Block:

minetest.register_node( "uranium:uranium_block", {
	description = "Uranium Block",
	tiles = { "uranium_block.png" },
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 15,
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	sounds = default.node_sound_stone_defaults(),
})


minetest.register_craft( {
	output = 'node "uranium:uranium_block" 1',
	recipe = {
		{ 'uranium:uranium_dust', 'uranium:uranium_dust', 'uranium:uranium_dust' },
		{ 'uranium:uranium_dust', 'uranium:uranium_dust', 'uranium:uranium_dust' },
		{ 'uranium:uranium_dust', 'uranium:uranium_dust', 'uranium:uranium_dust' },
	}
})
---------------------------------------------------------------------------------------------------------

--04.Radioactive Coal:

minetest.register_craftitem( "uranium:radioactive_coal", {
	description = "Radioactive Coal",
	inventory_image = "uranium_coal.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craft({
    type = "cooking",
    output = "uranium:radioactive_coal",
    recipe = "default:coal_lump",
})

---------------------------------------------------------------------------------------------------------

--05.Uranium Gem:

minetest.register_craftitem( "uranium:uranium_gem", {
	description = "Uranium Gem",
	inventory_image = "uranium_gem.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craft({
    type = "cooking",
    output = "uranium:uranium_gem",
    recipe = "default:steel_ingot",
})
---------------------------------------------------------------------------------------------------------

--05.Uranium Tools:

--Uranium Pick
minetest.register_tool("uranium:uranium_pick", {
	description = "Uranium Pickaxe",
	inventory_image = "uranium_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			cracky={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3},
			crumbly={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3},
			snappy={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3}
		}
	},
})

minetest.register_craft( {
	output = 'craft "uranium:uranium_pick" 1',
	recipe = {
		{ 'uranium:uranium_gem', 'uranium:uranium_gem', 'uranium:uranium_gem' },
		{ '', 'Stick', '' },
		{ '', 'Stick', '' },
	}
})

--Uranium Shovel
minetest.register_tool("uranium:uranium_shovel", {
	description = "Uranium Shovel",
	inventory_image = "uranium_shovel.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			crumbly={times={[1]=1.50, [2]=0.70, [3]=0.60}, uses=30, maxlevel=2}
		}
	},
})

minetest.register_craft( {
	output = 'craft "uranium:uranium_shovel" 1',
	recipe = {
		{ '', 'uranium:uranium_gem', '' },
		{ '', 'Stick', '' },
		{ '', 'Stick', '' },
	}
})

--Uranium Axe
minetest.register_tool("uranium:uranium_axe", {
	description = "Uranium Axe",
	inventory_image = "uranium_axe.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=3.00, [2]=1.60, [3]=1.00}, uses=30, maxlevel=2},
			fleshy={times={[2]=1.10, [3]=0.60}, uses=40, maxlevel=1}
		}
	},
})

minetest.register_craft( {
	output = 'craft "uranium:uranium_axe" 1',
	recipe = {
		{ 'uranium:uranium_gem', 'uranium:uranium_gem', '' },
		{ 'uranium:uranium_gem', 'Stick', '' },
		{ '', 'Stick', '' },
	}
})

--Uranium Sword
minetest.register_tool("uranium:uranium_sword", {
	description = "Uranium Sword",
	inventory_image = "uranium_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.45,
		max_drop_level=3,
		groupcaps={
			fleshy={times={[2]=0.65, [3]=0.25}, uses=200, maxlevel=1},
			snappy={times={[2]=0.70, [3]=0.25}, uses=200, maxlevel=1},
			choppy={times={[3]=0.65}, uses=200, maxlevel=0}
		}
	}
})

minetest.register_craft( {
	output = 'craft "uranium:uranium_sword" 1',
	recipe = {
		{ '', 'uranium:uranium_gem', '' },
		{ '', 'uranium:uranium_gem', '' },
		{ '', 'Stick', '' },
	}
})

--Uranium Paxel

minetest.register_tool("uranium:uranium_paxel", {
	description = "Uranium Paxel",
	inventory_image = "uranium_paxel.png",
	tool_capabilities = {
		full_punch_interval = 0.45,
		max_drop_level=3,
		groupcaps={
			cracky={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3},
			crumbly={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3},
			snappy={times={[1]=2.0, [2]=1.0, [3]=0.5}, uses=20, maxlevel=3}
		}
	}
})

minetest.register_craft( {
	output = 'craft "uranium:uranium_paxel" 1',
	recipe = {
		{ 'uranium:uranium_shovel', 'uranium:uranium_pick', 'uranium:uranium_axe' },
		{ '', 'Stick', '' },
		{ '', 'Stick', '' },
	}
})

---------------------------------------------------------------------------------------------------------

--06.Reactor:

minetest.register_craft( {
	output = 'craft "uranium:reactor" 1',
	recipe = {
		{ 'cobble', 'cobble', 'cobble' },
		{ 'cobble', 'uranium:uranium_dust', 'cobble' },
		{ 'cobble', 'cobble', 'cobble' },
	}
})

uranium.uranium_reactor_inactive_formspec =
	"invsize[8,9;]"..
	"image[2,2;1,1;uranium_fireon.png]"..
	"list[current_name;fuel;2,3;1,1;]"..
	"list[current_name;src;2,1;1,1;]"..
	"list[current_name;dst;5,1;2,2;]"..
	"list[current_player;main;0,5;8,4;]"

minetest.register_node("uranium:reactor", {
	description = "Reactor",
	tiles = {"uranium_reactortop.png", "uranium_reactorside.png", "uranium_reactorside.png",
		"uranium_reactorside.png", "uranium_reactorside.png", "uranium_reactorfrontidle.png"},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", uranium.uranium_reactor_inactive_formspec)
		meta:set_string("infotext", "Reactor")
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
})

minetest.register_node("uranium:reactor_active", {
	description = "Reactor",
	tiles = {"uranium_reactortop.png", "uranium_reactorside.png", "uranium_reactorside.png",
		"uranium_reactorside.png", "uranium_reactorside.png", "uranium_reactorfrontactive.png"},
	paramtype2 = "facedir",
	light_source = 8,
	drop = "uranium:reactor",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", uranium.uranium_reactor_inactive_formspec)
		meta:set_string("infotext", "Furnace");
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
})

function hacky_swap_node(pos,name)
	local node = minetest.env:get_node(pos)
	local meta = minetest.env:get_meta(pos)
	local meta0 = meta:to_table()
	if node.name == name then
		return
	end
	node.name = name
	local meta0 = meta:to_table()
	minetest.env:set_node(pos,node)
	meta = minetest.env:get_meta(pos)
	meta:from_table(meta0)
end

minetest.register_abm({
	nodenames = {"uranium:reactor","uranium:reactor_active"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.env:get_meta(pos)
		for i, name in ipairs({
				"fuel_totaltime",
				"fuel_time",
				"src_totaltime",
				"src_time"
		}) do
			if meta:get_string(name) == "" then
				meta:set_float(name, 0.0)
			end
		end

		local inv = meta:get_inventory()

		local srclist = inv:get_list("src")
		local cooked = nil
		
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		
		local was_active = false
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			was_active = true
			meta:set_float("fuel_time", meta:get_float("fuel_time") + 1)
			meta:set_float("src_time", meta:get_float("src_time") + 1)
			if cooked and cooked.item and meta:get_float("src_time") >= cooked.time then
				-- check if there's room for output in "dst" list
				if inv:room_for_item("dst",cooked.item) then
					-- Put result in "dst" list
					inv:add_item("dst", cooked.item)
					-- take stuff from "src" list
					srcstack = inv:get_stack("src", 1)
					srcstack:take_item()
					inv:set_stack("src", 1, srcstack)
				else
					print("Could not insert '"..cooked.item.."'")
				end
				meta:set_string("src_time", 0)
			end
		end
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			local percent = math.floor(meta:get_float("fuel_time") /
					meta:get_float("fuel_totaltime") * 100)
			meta:set_string("infotext","Reactor active: "..percent.."%")
			hacky_swap_node(pos,"uranium:reactor_active")
			meta:set_string("formspec",
				"invsize[8,9;]"..
				"image[2,2;1,1;uranium_fireon.png^[lowpart:"..
						(100-percent)..":uranium_fireoff.png]"..
				"list[current_name;fuel;2,3;1,1;]"..
				"list[current_name;src;2,1;1,1;]"..
				"list[current_name;dst;5,1;2,2;]"..
				"list[current_player;main;0,5;8,4;]")
			return
		end

		local fuel = nil
		local cooked = nil
		local fuellist = inv:get_list("fuel")
		local srclist = inv:get_list("src")
		
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		if fuellist then
			fuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
		end

		if fuel.time <= 0 then
			meta:set_string("infotext","Reactor out of fuel")
			hacky_swap_node(pos,"uranium:reactor")
			meta:set_string("formspec", uranium.uranium_reactor_inactive_formspec)
			return
		end

		if cooked.item:is_empty() then
			if was_active then
				meta:set_string("infotext","Reactor is empty")
				hacky_swap_node(pos,"uranium:reactor")
				meta:set_string("formspec", uranium.uranium_reactor_inactive_formspec)
			end
			return
		end

		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)
		
		local stack = inv:get_stack("fuel", 1)
		stack:take_item()
		inv:set_stack("fuel", 1, stack)
	end,
})

---------------------------------------------------------------------------------------------------------

--06.Toxic Waste:

minetest.register_node("uranium:toxic_waste_flowing", {
	description = "Flowing Waste",
	inventory_image = minetest.inventorycube("uranium_waste.png"),
	drawtype = "flowingliquid",
	tiles = {"uranium_waste.png"},
	special_tiles = {
		{
			image="uranium_waste_source_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.3}
		},
		{
			image="uranium_waste_source_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.3}
		},
	},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "uranium:toxic_waste_flowing",
	liquid_alternative_source = "uranium:nuclear_waste",
	liquid_viscosity = LAVA_VISC,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=2, hot=3, igniter=2},
})

minetest.register_node("uranium:nuclear_waste", {
	description = "Nuclear Waste",
	inventory_image = minetest.inventorycube("uranium_waste.png"),
	drawtype = "liquid",
	tiles = {
		{name="uranium_waste_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	special_tiles = {
		-- New-style waste source material (mostly unused)
		{name="uranium_waste.png", backface_culling=false},
	},
	paramtype = "light",
	light_source = LIGHT_MAX - 1,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "source",
	liquid_alternative_flowing = "uranium:toxic_waste_flowing",
	liquid_alternative_source = "uranium:nuclear_waste",
	liquid_viscosity = LAVA_VISC,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=2, hot=3, igniter=2},
})

minetest.register_abm(
	{nodenames = {"uranium:nuclear_waste"},
	interval = 1.0,
	chance = 3,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local objs = minetest.env:get_objects_inside_radius(pos, 500)
		for k, obj in pairs(objs) do
			obj:set_hp(obj:get_hp()-1)
		end
	end,
})

-------------------------------------------
--06.Toxic Container:

minetest.register_alias("container", "uranium:container_empty")
minetest.register_alias("container_lava", "uranium:container_waste")

minetest.register_craft({
	output = 'uranium:container_empty 1',
	recipe = {
		{'uranium:uranium_gem', '', 'uranium:uranium_gem'},
		{'', 'uranium:uranium_gem', ''},
	}
})

container = {}
container.liquids = {}

function container.register_liquid(source, flowing, itemname, inventory_image)
	container.liquids[source] = {
		source = source,
		flowing = flowing,
		itemname = itemname,
	}
	container.liquids[flowing] = container.liquids[source]

	if itemname ~= nil then
		minetest.register_craftitem(itemname, {
			inventory_image = inventory_image,
			stack_max = 1,
			liquids_pointable = true,
			on_use = function(itemstack, user, pointed_thing)
				-- Must be pointing to node
				if pointed_thing.type ~= "node" then
					return
				end
				-- Check if pointing to a liquid
				n = minetest.env:get_node(pointed_thing.under)
				if container.liquids[n.name] == nil then
					-- Not a liquid
					minetest.env:add_node(pointed_thing.above, {name=source})
				elseif n.name ~= source then
					-- It's a liquid
					minetest.env:add_node(pointed_thing.under, {name=source})
				end
				return {name="uranium:container_empty"}
			end
		})
	end
end

minetest.register_craftitem("uranium:container_empty", {
	inventory_image = "container.png",
	stack_max = 1,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		-- Must be pointing to node
		if pointed_thing.type ~= "node" then
			return
		end
		-- Check if pointing to a liquid source
		n = minetest.env:get_node(pointed_thing.under)
		liquiddef = container.liquids[n.name]
		if liquiddef ~= nil and liquiddef.source == n.name and liquiddef.itemname ~= nil then
			minetest.env:add_node(pointed_thing.under, {name="air"})
			return {name=liquiddef.itemname}
		end
	end,
})

container.register_liquid(
	"uranium:nuclear_waste",
	"uranium:toxic_waste_flowing",
	"uranium:container_waste",
	"container_waste.png"
)


-------------------------------------------
-- 7.Nuclear Bomb

minetest.register_craft({
	output = 'node "uranium:nuclear_bomb" 1',
	recipe = {
		{'cobble','cobble','cobble'},
		{'cobble','uranium:uranium_gem','cobble'},
		{'cobble','cobble','cobble'}
	}
})
minetest.register_node("uranium:nuclear_bomb", {
	tiles = {"uranium_nucleartop.png", "uranium_nuclearbottom.png",
			"uranium_nuclearside.png", "uranium_nuclearside.png",
			"uranium_nuclearside.png", "uranium_nuclearside.png"},
	drop = '', -- Get nothing
	material = {
		diggability = "not",
	},
	description = "Nuclear Bomb",
})

minetest.register_on_punchnode(function(p, node)
	if node.name == "uranium:nuclear_bomb" then
		minetest.env:remove_node(p)
		spawn_tnt(p, "uranium:nuclear_bomb")
		nodeupdate(p)
	end
end)

local URANIUM_BOMB_RANGE = 20
local URANIUM_BOMB = {
	-- Static definition
	physical = true, -- Collides with things
	 --weight = -100,
	collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
	visual = "cube",
	textures = {"uranium_nucleartop.png", "uranium_nuclearbottom.png",
			"uranium_nuclearside.png", "uranium_nuclearside.png",
			"uranium_nuclearside.png", "uranium_nuclearside.png"},
	-- Initial value for our timer
	timer = 0,
	-- Number of punches required to defuse
	health = 1,
	blinktimer = 0,
	blinkstatus = true,}

function URANIUM_BOMB:on_activate(staticdata)
	self.object:setvelocity({x=0, y=4, z=0})
	self.object:setacceleration({x=0, y=-10, z=0})
	self.object:settexturemod("^[brighten")
end

function URANIUM_BOMB:on_step(dtime)
	self.timer = self.timer + dtime
	self.blinktimer = self.blinktimer + dtime
    if self.timer>5 then
        self.blinktimer = self.blinktimer + dtime
        if self.timer>8 then
            self.blinktimer = self.blinktimer + dtime
            self.blinktimer = self.blinktimer + dtime
        end
    end
	if self.blinktimer > 0.5 then
		self.blinktimer = self.blinktimer - 0.5
		if self.blinkstatus then
			self.object:settexturemod("")
		else
			self.object:settexturemod("^[brighten")
		end
		self.blinkstatus = not self.blinkstatus
	end
	if self.timer > 10 then
		local pos = self.object:getpos()
        pos.x = math.floor(pos.x+0.5)
        pos.y = math.floor(pos.y+0.5)
        pos.z = math.floor(pos.z+0.5)
        do_tnt_physics(pos, URANIUM_BOMB_RANGE)
        minetest.sound_play("nuke_explode", {pos = pos,gain = 1.0,max_hear_distance = 16,})
        if minetest.env:get_node(pos).name == "default:water_source" or minetest.env:get_node(pos).name == "default:water_flowing" then
            -- Cancel the Explosion
            self.object:remove()
            return
        end
        for x=-URANIUM_BOMB_RANGE,URANIUM_BOMB_RANGE do
        for y=-URANIUM_BOMB_RANGE,URANIUM_BOMB_RANGE do
        for z=-URANIUM_BOMB_RANGE,URANIUM_BOMB_RANGE do
            if x*x+y*y+z*z <= URANIUM_BOMB_RANGE * URANIUM_BOMB_RANGE + URANIUM_BOMB_RANGE then
                local np={x=pos.x+x,y=pos.y+y,z=pos.z+z}
                local n = minetest.env:get_node(np)
                if n.name ~= "air" then
                    minetest.env:remove_node(np)					
                end
                activate_if_tnt(n.name, np, pos, URANIUM_BOMB_RANGE)
            end
        end
        end
        end
		self.object:remove()
	end
end

function URANIUM_BOMB:on_punch(hitter)
	self.health = self.health - 1
	if self.health <= 0 then
		self.object:remove()
		hitter:get_inventory():add_item("main", "uranium:nuclear_bomb")
	end
end

minetest.register_entity("uranium:nuclear_bomb", URANIUM_BOMB)

-------------------------------------------
-- 8.Test Node
minetest.register_craft({
	output = 'node "uranium:nuclear_lauch" 1',
	recipe = {
		{'','',''},
		{'','',''},
		{'','',''}
	}
})
minetest.register_node("uranium:nuclear_launch", {
	tiles = {"pulser.png", "pulser.png",
			"pulser.png", "pulser.png",
			"pulser.png", "pulser.png"},
	drop = '', -- Get nothing
	material = {
		diggability = "not",
	},
	description = "Nuclear Launch",
})

minetest.register_on_punchnode(function(p, node)
	if node.name == "uranium:nuclear_launch" then
		minetest.env:remove_node(p)
		spawn_tnt(p, "uranium:nuclear_launch")
		nodeupdate(p)
	end
end)

local URANIUM_LAUNCH_RANGE = 20
local URANIUM_LAUNCH = {
	-- Static definition
	physical = true, -- Collides with things
	-- weight = 5,
	collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
	visual = "cube",
	textures = {"pulser.png", "pulser.png",
			"pulser.png", "pulser.png",
			"pulser.png", "pulser.png"},
	-- Initial value for our timer
	timer = 0,
	-- Number of punches required to defuse
	health = 1,
	blinktimer = 0,
	blinkstatus = true,}

function URANIUM_LAUNCH:on_activate(staticdata)
	self.object:setvelocity({x=0, y=4, z=0})
	self.object:setacceleration({x=0, y=-10, z=0})
	self.object:settexturemod("^[brighten")
end

function URANIUM_LAUNCH:on_step(dtime)
	self.timer = self.timer + dtime
	self.blinktimer = self.blinktimer + dtime
    if self.timer>5 then
        self.blinktimer = self.blinktimer + dtime
        if self.timer>8 then
            self.blinktimer = self.blinktimer + dtime
            self.blinktimer = self.blinktimer + dtime
        end
    end
	if self.blinktimer > 0.5 then
		self.blinktimer = self.blinktimer - 0.5
		if self.blinkstatus then
			self.object:settexturemod("")
		else
			self.object:settexturemod("^[brighten")
		end
		self.blinkstatus = not self.blinkstatus
	end
	if self.timer > 10 then
		local pos = self.object:getpos()
        pos.x = math.floor(pos.x+0.5)
        pos.y = math.floor(pos.y+0.5)
        pos.z = math.floor(pos.z+0.5)
        do_tnt_physics(pos, URANIUM_LAUNCH_RANGE)
        minetest.sound_play("nuke_explode", {pos = pos,gain = 1.0,max_hear_distance = 16,})
        if minetest.env:get_node(pos).name == "default:water_source" or minetest.env:get_node(pos).name == "default:water_flowing" then
            -- Cancel the Explosion
            self.object:remove()
            return
        end
        for x=-URANIUM_LAUNCH_RANGE,URANIUM_LAUNCH_RANGE do
        for y=-URANIUM_LAUNCH_RANGE,URANIUM_LAUNCH_RANGE do
        for z=-URANIUM_LAUNCH_RANGE,URANIUM_LAUNCH_RANGE do
            if x*x+y*y+z*z <= URANIUM_LAUNCH_RANGE * URANIUM_LAUNCH_RANGE + URANIUM_LAUNCH_RANGE then
                local np={x=pos.x+x,y=pos.y+y,z=pos.z+z}
                local n = minetest.env:get_node(np)
                if n.name ~= "air" and n.name ~= "default:dirt" and n.name ~= "default:dirt_with_grass" and n.name ~= "default:stone" and n.name ~= "default:tree" and n.name ~= "default:leaves" and n.name ~= "default:sand" then
                    minetest.env:remove_node(np)					
                end
                activate_if_tnt(n.name, np, pos, URANIUM_LAUNCH_RANGE)
            end
        end
        end
        end
		self.object:remove()
	end
end

function URANIUM_LAUNCH:on_punch(hitter)
	self.health = self.health - 1
	if self.health <= 0 then
		self.object:remove()
		hitter:get_inventory():add_item("main", "uranium:nuclear_launch")
	end
end

minetest.register_entity("uranium:nuclear_launch", URANIUM_LAUNCH)

-------------------------------------------		
-- Ore generation

local function generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, ore_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local chunk_size = 3
	if ore_per_chunk <= 4 then
		chunk_size = 2
	end
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	--print("generate_ore num_chunks: "..dump(num_chunks))
	for i=1,num_chunks do
	if (y_max-chunk_size+1 <= y_min) then return end
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.env:get_node(p2).name == wherein then
						minetest.env:set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
	--print("generate_ore done")
end

minetest.register_on_generated(function(minp, maxp, seed)
generate_ore("uranium:uranium_ore", "default:stone", minp, maxp, seed+21,   1/13/13/13,    5, -31000,  -150)

end)
