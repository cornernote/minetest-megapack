--
-- Lottery mod
--
-- cactuz_pl
--
-- Licence: WTFPL

--Ticket

minetest.register_node("lottery:ticket", {
description = "Put and wait.",
tiles = {"quest.png"},
is_ground_content = true,
groups = { choppy = 3, oddly_breakable_by_hand = 1.5},
})

minetest.register_craft({
	output = 'lottery:ticket 1',
	recipe = {
		{'default:mese', 'default:wood'},
	},
})

--Rewards
--1 mese
minetest.register_node("lottery:1mese", {
description = "Craft to receive revard!",
tiles = {"reward.png"},
is_ground_content = true,
groups = { choppy = 3, oddly_breakable_by_hand = 1.5},
})

minetest.register_craft({
	output = 'default:mese 1',
	recipe = {
		{'lottery:1mese'},
	},
})
--5 mese
minetest.register_node("lottery:5mese", {
description = "Craft to receive revard!",
tiles = {"reward.png"},
is_ground_content = true,
groups = { choppy = 3, oddly_breakable_by_hand = 1.5},
})

minetest.register_craft({
	output = 'default:mese 5',
	recipe = {
		{'lottery:5mese'},
	},
})
--20 mese
minetest.register_node("lottery:20mese", {
description = "Craft to receive revard!",
tiles = {"reward.png"},
is_ground_content = true,
groups = { choppy = 3, oddly_breakable_by_hand = 1.5},
})

minetest.register_craft({
	output = 'default:mese 20',
	recipe = {
		{'lottery:20mese'},
	},
})
--50 mese
minetest.register_node("lottery:50mese", {
description = "Craft to receive revard!",
tiles = {"reward.png"},
is_ground_content = true,
groups = { choppy = 3, oddly_breakable_by_hand = 1.5},
})

minetest.register_craft({
	output = 'default:mese 50',
	recipe = {
		{'lottery:50mese'},
	},
})
--99 mese
minetest.register_node("lottery:99mese", {
description = "Craft to receive revard!",
tiles = {"reward.png"},
is_ground_content = true,
groups = { choppy = 3, oddly_breakable_by_hand = 1.5},
})

minetest.register_craft({
	output = 'default:mese 99',
	recipe = {
		{'lottery:99mese'},
	},
})
--99 coal
minetest.register_node("lottery:99coal", {
description = "Craft to receive revard!",
tiles = {"reward.png"},
is_ground_content = true,
groups = { choppy = 3, oddly_breakable_by_hand = 1.5},
})

minetest.register_craft({
	output = 'default:coal_lump 99',
	recipe = {
		{'lottery:99coal'},
	},
})
--99 wood
minetest.register_node("lottery:99wood", {
description = "Craft to receive revard!",
tiles = {"reward.png"},
is_ground_content = true,
groups = { choppy = 3, oddly_breakable_by_hand = 1.5},
})

minetest.register_craft({
	output = 'default:wood 99',
	recipe = {
		{'lottery:99wood'},
	},
})
--99 ingots
minetest.register_node("lottery:99ingot", {
description = "Craft to receive revard!",
tiles = {"reward.png"},
is_ground_content = true,
groups = { choppy = 3, oddly_breakable_by_hand = 1.5},
})

minetest.register_craft({
	output = 'default:steel_ingot 99',
	recipe = {
		{'lottery:99ingot'},
	},
})
--99 sapling
minetest.register_node("lottery:99sapling", {
description = "Craft to receive revard!",
tiles = {"reward.png"},
is_ground_content = true,
groups = { choppy = 3, oddly_breakable_by_hand = 1.5},
})

minetest.register_craft({
	output = 'default:sapling 99',
	recipe = {
		{'lottery:99sapling'},
	},
})
--1 apple
minetest.register_node("lottery:apple", {
description = "Craft to receive revard!",
tiles = {"reward.png"},
is_ground_content = true,
groups = { choppy = 3, oddly_breakable_by_hand = 1.5},
})

minetest.register_craft({
	output = 'default:apple 1',
	recipe = {
		{'lottery:apple'},
	},
})

--ABM

minetest.register_abm(
        {nodenames = {"lottery:ticket"},
        interval = 0,
        chance = 1,
        action = function(pos)
local i = math.random(1,999)
        
if i<500 then
minetest.env:add_node(pos,{name="lottery:apple"})
end

if i>499 and i<750 then
minetest.env:add_node(pos,{name="lottery:1mese"})
end

if i>749 and i<770 then
minetest.env:add_node(pos,{name="lottery:5mese"})
end

if i>769 and i<777 then
minetest.env:add_node(pos,{name="lottery:20mese"})
end

if i>776 and i<780 then
minetest.env:add_node(pos,{name="lottery:50mese"})
end

if i==780 then
minetest.env:add_node(pos,{name="lottery:99mese"})
end

if i>780 and i<841 then
minetest.env:add_node(pos,{name="lottery:99coal"})
end

if i>840 and i<901 then
minetest.env:add_node(pos,{name="lottery:99wood"})
end

if i>900 and i<951 then
minetest.env:add_node(pos,{name="lottery:99ingot"})
end

if i>950 then
minetest.env:add_node(pos,{name="lottery:99ingot"})
end

end
})
