-- ---------
-- |EFFECTS|
-- ---------

heal_entity_base = function(time, power)
 return function(self, dtime)
    if self.user ~= nil then
    	self.last_healing=self.last_healing+dtime
        self.timer = self.timer - dtime
        self.object:setpos(self.user:getpos())
        if self.last_healing > time and self.user:get_hp() ~= 20 then 
            self.user:set_hp(self.user:get_hp()+power)
            self.last_healing = 0
            self.healing = self.healing - power
        end
        if self.healing < 1 or self.timer < 0 then self.object:remove() end
    else
        self.object:remove()
    end
end
end

-- bomb_on_step = function()
--    return function(self, dtime)
--    if self.user ~= nil then
--        self.timer = self.timer - dtime
--        self.object:setpos(self.user:getpos())
--        if self.timer < 0 then
--       		bomb = minetest.env:add_entity(self.object:getpos(), "tcluster:tnt")
--            self.object:remove()
--        end
--    else
--        self.object:remove()
--    end
-- end
-- end

heal_entity={
	physical = false,
	timer=60,
    last_healing = 0,
    healing = 20,
	textures = {"trans.png"},
	collisionbox = {0,0,0,0,0,0},
    on_step = heal_entity_base(1, 1),
    on_punch = function(self, puncher) self.user = puncher end
}

great_heal_entity={
	physical = false,
	timer=90,
    last_healing = 0,
    healing = 30,
	textures = {"trans.png"},
	collisionbox = {0,0,0,0,0,0},
    on_step = heal_entity_base(1, 2),
    on_punch = function(self, puncher) self.user = puncher end
}

-- bomb_entity = {
--    physical = false,
--    timer = 5,
--    textures = {"trans.png"},
--    collisionbox = {0,0,0,0,0,0},
--    on_step = bomb_on_step(),
--    on_punch = function(self, puncher) self.user = puncher end
-- }

minetest.register_entity("potions:great_heal_entity", great_heal_entity)
minetest.register_entity("potions:heal_entity", heal_entity)
-- minetest.register_entity("potions:bomb_entity", bomb_entity)

local drink_heal_potion = function(hp_change)
	return function(item, user, pointed_thing)
		user:set_hp(user:get_hp() + hp_change)
        if math.random() > 0.25 then
            user:add_to_inventory('craft "potions:vial" 1')
        end
		return true
	end
end

local random_potion_effect = function()
    return function(item, user, pointed_thing)
        if math.random() > 0.25 then
            user:add_to_inventory('craft "potions:vial" 1')
        end
        return true
    end
end

-- ----------
-- |RECIEPTS|
-- ----------

-- Pattern:
-- First digit - base potion: 1 - water, 2 - clear water, 3 - lava, 4 - hot lava
-- Second digit - first ingridient: 0 - absent, 1 - negredo, 2 - albedo, 3 - rubedo
-- Third digit - first ingridient: 0 - absent, 1 - negredo, 2 - albedo, 3 - rubedo
-- Forth digit - first ingridient: 0 - absent, 1 - negredo, 2 - albedo, 3 - rubedo
-- If reaction doesn't fit any of patterns, then output is "mess"
local basekey = { 
    ["potions:base_potion"] = "1", 
    ["potions:clear_water_potion"] = "2", 
    ["potions:lava_potion"] = "3", 
    ["potions:hot_lava_potion"] = "4",
    ["potions:heal_potion"] = "a",
}
local ingkey = {
    ["potions:nigredo"] = "1",
    ["potions:albedo"] = "2",
    ["potions:rubedo"] = "3",
}
local reciepts = {
    ["1222"] = 'craft "potions:heal_potion" 1', 
    ["1200"] = 'craft "potions:clear_water_potion" 1',
    ["3300"] = 'craft "potions:hot_lava_potion" 1',
    ["2223"] = 'craft "potions:great_heal_potion" 1',
    ["a300"] = 'craft "potions:great_heal_potion" 1',
    ["1221"] = 'craft "potions:time_heal_potion" 1',
    ["2221"] = 'craft "potions:great_time_heal_potion" 1',
}

function get_result(base, in1, in2, in3)
    in1 = ingkey[in1] or "0"
    in2 = ingkey[in2] or "0"
    in3 = ingkey[in3] or "0"
    base = basekey[base] or "-1"
    cmbs = {base..in1..in2..in3, base..in1..in3..in2, base..in2..in1..in3, base..in2..in3..in1, base..in3..in2..in1, base..in3..in1..in2}
    result = 'craft "potions:mess_potion" 1'
    for k,res in pairs(reciepts) do
        for _,v in ipairs(cmbs) do
            if k == v then result = res end
        end
    end
    return result
end

-- -------------
-- |INGRIDIENTS|
-- -------------

minetest.register_craftitem("potions:albedo", {
	image = "albedo.png",
})

minetest.register_craftitem("potions:nigredo", {
	image = "nigredo.png",
})

minetest.register_craftitem("potions:rubedo", {
	image = "rubedo.png",
})

local flowers = {
    ['node "flowers:flower_rose"'] = 'craft "potions:rubedo" 1',
	['node "flowers:flower_dandelion_yellow"'] = 'craft "potions:albedo" 1',
	['node "flowers:flower_dandelion_white"'] = 'craft "potions:albedo" 1',
	['node "flowers:flower_dandelion_tultip"'] = 'craft "potions:rubedo" 1',
	['node "flowers:flower_dandelion_viola"'] = 'craft "potions:nigredo" 1',
	['node "flowers:flower_waterlily"'] = 'craft "potions:nigredo" 1',
    ['node "default:apple"'] = 'craft "potions:rubedo" 1',
}

for k, v in pairs(flowers) do
    minetest.register_craft({
        recipe = {{k},{'craft "potions:extractor"'}},
  	    output = v
    }) 
end

-- ---------
-- |POTIONS|
-- ---------

minetest.register_craftitem("potions:heal_potion", {
	stack_max = 1,
	image = "potion_heal.png",
  	on_use = drink_heal_potion(6)
})

minetest.register_craftitem("potions:great_heal_potion", {
	stack_max = 1,
	image = "potion_heal_great.png",
  	on_use = drink_heal_potion(16)
})


minetest.register_craftitem("potions:time_heal_potion", {
    stack_max = 1,
    image = "potion_heal_time.png",
    on_use = function(item, user, pointed_thing)
        heal = minetest.env:add_entity(user:getpos(), "potions:heal_entity")
        print(dump(heal))
        heal:punch(user)
        if math.random() > 0.25 then user:add_to_inventory('craft "potions:vial" 1') end
        return true
    end
})

minetest.register_craftitem("potions:great_time_heal_potion", {
    stack_max = 1,
    image = "potion_heal_time_great.png",
    on_use = function(item, user, pointed_thing)
        heal = minetest.env:add_entity(user:getpos(), "potions:great_heal_entity")
        heal:punch(user)
        if math.random() > 0.25 then user:add_to_inventory('craft "potions:vial" 1') end
        return true
    end
})

-- minetest.register_craftitem("potions:bomb_potion", {
--    stack_max = 1,
--    image = "potion_heal_time_great.png",
--    on_use = function(item, user, pointed_thing)
--        bomb = minetest.env:add_entity(user:getpos(), "potions:bomb_entity")
--        bomb:punch(user)
--        if math.random() > 0.25 then user:add_to_inventory('craft "potions:vial" 1') end
--        return true
--    end
-- })

minetest.register_craftitem("potions:base_potion", {
	stack_max = 1,
	image = "potion_water.png",
  	on_use = drink_heal_potion(0)
})

minetest.register_craftitem("potions:clear_water_potion", {
	stack_max = 1,
	image = "potion_clear_water.png",
  	on_use = drink_heal_potion(2)
})

minetest.register_craftitem("potions:lava_potion", {
	stack_max = 1,
	image = "potion_lava.png",
  	on_use = drink_heal_potion(-10)
})

minetest.register_craftitem("potions:hot_lava_potion", {
	stack_max = 1,
	image = "potion_hot_lava.png",
  	on_use = drink_heal_potion(-20)
})

minetest.register_craftitem("potions:mess_potion", {
	stack_max = 1,
	image = "potion_mess.png",
  	on_use = random_potion_effect()
})

function isbase(name)
    bases = {"potions:base_potion", "potions:clear_water_potion", "potions:lava_potion", "potions:hot_lava_potion", "potions:mess", "potions:heal_potion",
    "potion:great_heal_potion"}
    for k, v in pairs(bases) do
        if name == v or name == nil then return true end
    end
    return false
end

-- -------
-- |TOOLS|
-- -------

minetest.register_craftitem("potions:extractor", {
    image = "potions_extractor.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craft({
    recipe = {
        {'', 'craft "default:stick"', ''},
        {'craft "default:stick"', '', 'craft "default:stick"'},
        {'craft "default:stick"', 'craft "default:stick"', 'craft "default:stick"'},
    },
	output = 'craft "potions:extractor" 3',
})

minetest.register_craftitem("potions:vial", {
  	image = "potion_empty.png",
	liquids_pointable = true,
	on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "default:water_source" then
				minetest.env:add_node(pointed_thing.under, {name="air"})
				player:add_to_inventory_later('craft "potions:base_potion" 1')
				return true
			elseif n.name == "default:lava_source" then
				minetest.env:add_node(pointed_thing.under, {name="air"})
				player:add_to_inventory_later('craft "potions:lava_potion" 1')
				return true
			end
		end
		return false
	end,
})

minetest.register_craft({
	output = 'node "potions:combiner" 1',
	recipe = {
		{'node "default:wood"', 'node "default:wood"', 'node "default:wood"'},
		{'craft "potions:vial"', 'craft "potions:vial"', 'craft "potions:vial"' },
		{'node "default:wood"', 'node "default:wood"', 'node "default:wood"'},
	}
})


minetest.register_craft({
	recipe = {
    		{'','node "default:glass"',''},
	    	{'','node "default:glass"',''},
            {'node "default:glass"','node "default:glass"','node "default:glass"'},
    	},
	output = 'craft "potions:vial" 6',
})

minetest.register_node("potions:combiner", {
	tiles = {"default_wood.png", "default_wood.png",
		"default_wood.png", "default_wood.png",
		"default_wood.png", "potions_combiner.png"},
	inventory_image = minetest.inventorycube("default_wood.png", "potions_combiner.png"),
	paramtype = "facedir_simple",
	metadata_name = "generic",
	material = minetest.digprop_stonelike(3.0),
})

minetest.register_on_placenode(function(pos, newnode, placer)
	if newnode.name == "potions:combiner" then
		local meta = minetest.env:get_meta(pos)
		meta:inventory_set_list("ing", {"", "", ""})
		meta:inventory_set_list("pot", {"", "", ""})
		meta:set_inventory_draw_spec(
			"invsize[8,9;]"
			.."list[current_name;pot;2,3;3,1;]"
			.."list[current_name;ing;2,1;3,1;]"
			.."list[current_player;main;0,5;8,4;]"
		)

		meta:set_infotext("Combiner")
		meta:set_string("timer", "-999")
		meta:set_string("ings", "")
		meta:set_string("pots", "")
	end
end)

minetest.register_abm({
	nodenames = {"potions:combiner"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
   		local meta = minetest.env:get_meta(pos)
		local potlist = meta:inventory_get_list("pot")
		local inglist = meta:inventory_get_list("ing")
		local timer = tonumber(meta:get_string("timer"))
		if potlist == nil or inglist == nil then 
            meta:set_string("timer", "-999")
            return 
        end
        _, ing1 = stackstring_take_item(inglist[1])
        _, ing2 = stackstring_take_item(inglist[2])
        _, ing3 = stackstring_take_item(inglist[3])
        _, pot1 = stackstring_take_item(potlist[1])
        _, pot2 = stackstring_take_item(potlist[2])
        _, pot3 = stackstring_take_item(potlist[3])
        
        if pot1 == nil and pot2 == nil and pot3 == nil then meta:set_string("timer", -999) meta:set_infotext("Combiner") return end
        if ing1 == nil and ing2 == nil and ing3 == nil then meta:set_string("timer", -999) meta:set_infotext("Combiner") return end

        if ing1 == nil then ing1 = {["name"] = nil} end
        if ing2 == nil then ing2 = {["name"] = nil} end
        if ing3 == nil then ing3 = {["name"] = nil} end
        if pot1 == nil then pot1 = {["name"] = nil} end
        if pot2 == nil then pot2 = {["name"] = nil} end
        if pot3 == nil then pot3 = {["name"] = nil} end

        if isbase(pot1.name) == false or isbase(pot2.name) == false or isbase(pot3.name) == false then
            meta:set_string("timer", -999)
            meta:set_infotext("Combiner")
        return end

        pots = dump(pot1).."|"..dump(pot2).."|"..dump(pot3)
        ings = dump(ing1).."|"..dump(ing2).."|"..dump(ing3)

        if pots ~= meta:get_string("pots") or ings ~= meta:get_string("ings") then
            meta:set_string("pots", pots)
            meta:set_string("ings", ings)
            meta:set_string("timer", 50)
            return
        end
        
        if timer > 0 then 
            meta:set_string("timer", timer-1) 
    		meta:set_infotext("Combiner, working, "..100-(2*timer).."%")
        else 
            if timer == 0 then 
                local changed = false
                if pot1.name ~= nil then
                    res = get_result(pot1.name, ing1.name, ing2.name, ing3.name)
                    if res ~= nil then
                        potlist[1] = ""
                        potlist[1], success = stackstring_put_stackstring(potlist[1], res)
                        changed = true
                    end
                end
                if pot2.name ~= nil then
                    res = get_result(pot2.name, ing1.name, ing2.name, ing3.name)
                    if res ~= nil then
                        potlist[2] = ""
                        potlist[2], success = stackstring_put_stackstring(potlist[2], res)
                        changed = true
                    end
                end
                if pot3.name ~= nil then
                    res = get_result(pot3.name, ing1.name, ing2.name, ing3.name)
                    if res ~= nil then
                        potlist[3] = ""
                        potlist[3], success = stackstring_put_stackstring(potlist[3], res)
                        changed = true
                    end
                end
                if changed == true then
                    if ing1.name ~= nil then inglist[1], _ = stackstring_take_item(inglist[1]) end
                    if ing2.name ~= nil then inglist[2], _ = stackstring_take_item(inglist[2]) end
                    if ing3.name ~= nil then inglist[3], _ = stackstring_take_item(inglist[3]) end
                end
                meta:set_string("timer", -999)
           		meta:set_infotext("Combiner")
            else if timer < 0 then
                meta:set_string("timer", 50)
        		meta:set_infotext("Combiner, working, "..100-(2*timer).."%")
                end
            end
        end
		meta:inventory_set_list("pot", potlist)
		meta:inventory_set_list("ing", inglist)
    end
})
