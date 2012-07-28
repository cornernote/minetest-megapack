--Colors mod for RTMMP


-- Dye table for public funcs
dye = {}

dye.add_dye_recipe = function(new, first, second) 
	minetest.register_craft({
		output = new,
		recipe = {
				{first, "dye:" .. second},
		}
	})

	minetest.register_craft({
		output = new,
		recipe = {
				{"dye:".. second, "dye:" .. first},
		}
	})

	minetest.register_craft({
		output = new,
		recipe = {
				{first},
				{"dye:".. second},
		}
	})

	minetest.register_craft({
		output = new,
		recipe = {
				{"dye:".. second},
				{first},
		}
	})

	minetest.register_craft({
		output = new,
		recipe = {
				{"dye:".. second,""},
				{"",first},
		}
	})

	minetest.register_craft({
		output = new,
		recipe = {
				{first,""},
				{"","dye:".. second},
		}
	})

	minetest.register_craft({
		output = new,
		recipe = {
				{"","dye:".. second},
				{first,""},
		}
	})

	minetest.register_craft({
		output = new,
		recipe = {
				{"",first},
				{"dye:".. second,""},
		}
	})
end

--Public colors for mods:
DYE_COLORS = {
	'white',
	'light_gray',
	'gray',
	'black',
	'red',
	'orange',
	'yellow',
	'lime',
	'green',
	'light_blue',
	'cyan',
	'blue',
	'purple',
	'magenta',
	'pink',
	'brown',
}

DYE_CRAFTS = {
	['white']	=	{'flowers:flower_dandelion_white'},
	['black']	=	{'default:scorched_stuff'},
	['red']		=	{'flowers:flower_rose'},
	['orange']	=	{'flowers:flower_tulip'},
	['yellow']	=	{'flowers:flower_dandelion_yellow'},
	['purple']	=	{'flowers:flower_viola'},
	['brown 2']	=	{'default:clay_brick'},
}

-- Somefunc
local cute_descr = function(str)  -- ^^ nya!~~~
	return(str:gsub('_',' '):gsub('^%l', string.upper))
end

-- Dyes
for _, color in pairs(DYE_COLORS) do
	if color ~= 'blue' then
		minetest.register_craftitem('dye:' .. color, {
			description = cute_descr(color) .. ' dye',
			inventory_image = 'dye_' .. color .. '.png',
			groups = {dye = 1},
			stack_max = 128,
		})
	end
end

minetest.register_alias('dye:blue', 'lazurite:lazurite')

--Dye recipes
local addSMrecipe = function(new, first, second)
	minetest.register_craft({
		type = 'shapeless',
		output = 'dye:' .. new ..' 2',
		recipe = {
				'dye:' .. first,
				'dye:' .. second,
		},
	})
end

--second
addSMrecipe('orange','red','yellow')
addSMrecipe('cyan','green','blue')
addSMrecipe('purple','red','blue')
addSMrecipe('gray','black','white')
addSMrecipe('light_blue','white','blue')
addSMrecipe('pink','red','white')
addSMrecipe('lime','green','white')

--third
addSMrecipe('magenta','purple','pink')
addSMrecipe('light_gray','gray','white')

--first

for reslt, ourrecipe in pairs(DYE_CRAFTS) do
	minetest.register_craft({
		type = 'shapeless',
		output = 'dye:' .. reslt,
		recipe = ourrecipe,
	})
end

--nonstandart craft
minetest.register_craft({
	type = 'shapeless',
	type = 'cooking',
	output = 'dye:green',
	recipe = 'default:cactus',
	cooktime = 5,
})

