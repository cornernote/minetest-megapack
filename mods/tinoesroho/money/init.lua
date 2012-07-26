minetest.register_craftitem("money:coin_copper",
{
	description = "Copper Coins",
	inventory_image = "money_coin_copper.png",
	stack_max = 1000000,
})

minetest.register_craftitem("money:coin_silver",
{
	description = "Silver Coins",
	inventory_image = "money_coin_silver.png",
	stack_max = 100000000,
})

minetest.register_craftitem("money:coin_gold",
{
	description = "Gold Coins",
	inventory_image = "money_coin_gold.png",
	stack_max = 1000000,
})

minetest.register_craft({
	type = 'shapeless',
	output = 'money:coin_silver',
	recipe = {'money:coin_copper', 'money:coin_copper', 'money:coin_copper', 'money:coin_copper', 'money:coin_copper'}
})

minetest.register_craft({
	type = 'shapeless',
	output = 'money:coin_gold',
	recipe = {'money:coin_silver', 'money:coin_silver', 'money:coin_silver', 'money:coin_silver', 'money:coin_silver'}
})

minetest.register_craft({
	output = 'money:coin_silver 5',
	recipe = {
		{'money:coin_gold', '', ''},
	}
})

minetest.register_craft({
	output = 'money:coin_copper 5',
	recipe = {
		{'money:coin_silver', '', ''},
	}
})

-- Exported functions for other mods to use
money = {}

money.CONVERT_AMOUNT = 5

function money.ConvertToCopper(gold, silver, copper)
	return ((((gold * money.CONVERT_AMOUNT) + silver) * money.CONVERT_AMOUNT) + copper)
end

function money.ConvertCopperToOthers(c)
	g = math.floor(c / (money.CONVERT_AMOUNT * money.CONVERT_AMOUNT))
	c = c - (g * (money.CONVERT_AMOUNT * money.CONVERT_AMOUNT))
	
	s = math.floor(c / (money.CONVERT_AMOUNT))
	c = c - (s * (money.CONVERT_AMOUNT))
	
	return g, s, c
end
