minetest.register_craftitem("coin:copper",
{
	description = "Copper Coins",
	inventory_image = "coin_copper.png",
	stack_max = 1000000,
})

minetest.register_craftitem("coin:silver",
{
	description = "Silver Coins",
	inventory_image = "coin_silver.png",
	stack_max = 100000000,
})

minetest.register_craftitem("coin:gold",
{
	description = "Gold Coins",
	inventory_image = "coin_gold.png",
	stack_max = 1000000,
})

minetest.register_craft({
	type = 'shapeless',
	output = 'coin:silver',
	recipe = {'coin:copper', 'coin:copper', 'coin:copper', 'coin:copper', 'coin:copper'}
})

minetest.register_craft({
	type = 'shapeless',
	output = 'coin:gold',
	recipe = {'coin:silver', 'coin:silver', 'coin:silver', 'coin:silver', 'coin:silver'}
})

minetest.register_craft({
	output = 'coin:silver 5',
	recipe = {
		{'coin:gold', '', ''},
	}
})

minetest.register_craft({
	output = 'coin:copper 5',
	recipe = {
		{'coin:silver', '', ''},
	}
})

-- Exported functions for other mods to use
coin = {}

coin.CONVERT_AMOUNT = 5

function coin.ConvertToCopper(gold, silver, copper)
	return ((((gold * coin.CONVERT_AMOUNT) + silver) * coin.CONVERT_AMOUNT) + copper)
end

function coin.ConvertCopperToOthers(c)
	g = math.floor(c / (coin.CONVERT_AMOUNT * coin.CONVERT_AMOUNT))
	c = c - (g * (coin.CONVERT_AMOUNT * coin.CONVERT_AMOUNT))
	
	s = math.floor(c / (coin.CONVERT_AMOUNT))
	c = c - (s * (coin.CONVERT_AMOUNT))
	
	return g, s, c
end
