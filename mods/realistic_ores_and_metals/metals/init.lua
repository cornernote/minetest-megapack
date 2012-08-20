METALS_LIST={
	'bismuth',
	'pig_iron',
	'wrought_iron',
	'steel',
	'gold',
	'nickel',
	'platinum',
	'tin',
	'silver',
	'lead',
	'copper',
	'zinc',
	'brass',
	'sterling_silver',
	'rose_gold',
	'black_bronze',
	'bismuth_bronze',
	'bronze',
	'black_steel',
}

DESC_LIST={
	'Bismuth',
	'Pig iron',
	'Wrought iron',
	'Steel',
	'Gold',
	'Nickel',
	'Platinum',
	'Tin',
	'Silver',
	'Lead',
	'Copper',
	'Zinc',
	'Brass',
	'Sterling silver',
	'Rose gold',
	'Black bronze',
	'Bismuth bronze',
	'Bronze',
	'Black steel',
}

for i=1, #METALS_LIST do
	minetest.register_craftitem("metals:"..METALS_LIST[i].."_unshaped", {
		description = "Unshaped "..DESC_LIST[i],
		inventory_image = "metals_"..METALS_LIST[i].."_unshaped.png",
	})
	
	minetest.register_craftitem("metals:"..METALS_LIST[i].."_ingot", {
		description = DESC_LIST[i].." ingot",
		inventory_image = "metals_"..METALS_LIST[i].."_ingot.png",
	})
	
	minetest.register_node("metals:"..METALS_LIST[i].."_block", {
		description = DESC_LIST[i].." block",
		tiles = {"metals_"..METALS_LIST[i].."_block.png"},
		is_ground_content = true,
		groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
		sounds = default.node_sound_stone_defaults(),
	})
	
	minetest.register_craft({
		output = "metals:"..METALS_LIST[i].."_block",
		recipe = {
			{"metals:"..METALS_LIST[i].."_ingot", "metals:"..METALS_LIST[i].."_ingot"},
			{"metals:"..METALS_LIST[i].."_ingot", "metals:"..METALS_LIST[i].."_ingot"},
		}
	})
	
	minetest.register_craft({
		output = "metals:"..METALS_LIST[i].."_ingot 4",
		recipe = {
			{"metals:"..METALS_LIST[i].."_block"},
		}
	})
	
	minetest.register_tool("metals:tool_pick_"..METALS_LIST[i], {
		description = DESC_LIST[i].." pickaxe",
		inventory_image = "metals_tool_pick_"..METALS_LIST[i]..".png",
		tool_capabilities = {
			max_drop_level=1,
			groupcaps={
				cracky={times={[1]=4.00, [2]=1.60, [3]=1.00}, uses=30, maxlevel=2}
			}
		},
	})
	minetest.register_tool("metals:tool_shovel_"..METALS_LIST[i], {
		description = DESC_LIST[i].." hovel",
		inventory_image = "metals_tool_shovel_"..METALS_LIST[i]..".png",
		tool_capabilities = {
			max_drop_level=1,
			groupcaps={
				crumbly={times={[1]=1.50, [2]=0.70, [3]=0.60}, uses=30, maxlevel=2}
			}
		},
	})
	minetest.register_tool("metals:tool_axe_"..METALS_LIST[i], {
		description = DESC_LIST[i].." axe",
		inventory_image = "metals_tool_axe_"..METALS_LIST[i]..".png",
		tool_capabilities = {
			max_drop_level=1,
			groupcaps={
				choppy={times={[1]=3.00, [2]=1.60, [3]=1.00}, uses=30, maxlevel=2},
				fleshy={times={[2]=1.10, [3]=0.60}, uses=40, maxlevel=1}
			}
		},
	})
	minetest.register_tool("metals:tool_sword_"..METALS_LIST[i], {
		description = DESC_LIST[i].." sword",
		inventory_image = "metals_tool_sword_"..METALS_LIST[i]..".png",
		tool_capabilities = {
			full_punch_interval = 1.0,
			max_drop_level=1,
			groupcaps={
				fleshy={times={[1]=2.00, [2]=0.80, [3]=0.40}, uses=10, maxlevel=2},
				snappy={times={[2]=0.70, [3]=0.30}, uses=40, maxlevel=1},
				choppy={times={[3]=0.70}, uses=40, maxlevel=0}
			}
		}
	})
	
	minetest.register_craft({
	output = "metals:tool_pick_"..METALS_LIST[i],
	recipe = {
			{"metals:"..METALS_LIST[i].."_ingot"},
			{"metals:recipe_pick"},
			{"default:stick"},
		}
	})
	
	minetest.register_craft({
	output = "metals:tool_axe_"..METALS_LIST[i],
	recipe = {
			{"metals:"..METALS_LIST[i].."_ingot"},
			{"metals:recipe_axe"},
			{"default:stick"},
		}
	})
	
	minetest.register_craft({
	output = "metals:tool_shovel_"..METALS_LIST[i],
	recipe = {
			{"metals:"..METALS_LIST[i].."_ingot"},
			{"metals:recipe_shovel"},
			{"default:stick"},
		}
	})
	
	minetest.register_craft({
	output = "metals:tool_sword_"..METALS_LIST[i],
	recipe = {
			{"metals:"..METALS_LIST[i].."_ingot"},
			{"metals:recipe_sword"},
			{"default:stick"},
		}
	})
	
	minetest.register_craftitem("metals:ceramic_mold_"..METALS_LIST[i], {
		description = "Ceramic mold with "..DESC_LIST[i],
		inventory_image = "metals_ceramic_mold.png^metals_"..METALS_LIST[i].."_ingot.png",
	})
	
	minetest.register_craft({
		output = "metals:ceramic_mold_"..METALS_LIST[i],
		recipe = {
			{"metals:"..METALS_LIST[i].."_ingot"},
			{"metals:ceramic_mold"},
		}
	})
	
	minetest.register_craft({
		type = "cooking",
		output = "metals:"..METALS_LIST[i].."_unshaped",
		recipe = "metals:ceramic_mold_"..METALS_LIST[i],
}	)
	
	minetest.register_craft({
		output = "metals:"..METALS_LIST[i].."_ingot",
		recipe = {
			{"metals:"..METALS_LIST[i].."_unshaped"},
		}
	})
	
	minetest.register_craft({
	output = 'bucket:bucket_empty',
	recipe = {
		{"metals:"..METALS_LIST[i].."_ingot", '', "metals:"..METALS_LIST[i].."_ingot"},
		{'', "metals:"..METALS_LIST[i].."_ingot", ''},
	}
})
end

minetest.register_craftitem("metals:clay_mold", {
	description = "Clay mold",
	inventory_image = "metals_clay_mold.png",
})

minetest.register_craftitem("metals:ceramic_mold", {
	description = "Ceramic mold",
	inventory_image = "metals_ceramic_mold.png",
})

-------------------------------------------------

MINERALS_LIST={
	'magnetite',
	'hematite',
	'limonite',
	'bismuthinite',
	'cassiterite',
	'galena',
	'malachite',
	'native_copper',
	'native_gold',
	'native_platinum',
	'native_silver',
	'sphalerite',
	'tetrahedrite',
	'garnierite',
}

MINERALS_METALS_LIST={
	'pig_iron',
	'pig_iron',
	'pig_iron',
	'bismuth',
	'tin',
	'lead',
	'copper',
	'copper',
	'gold',
	'platinum',
	'silver',
	'zinc',
	'copper',
	'nickel',
}

for i=1, #MINERALS_LIST do
	minetest.register_craftitem("metals:ceramic_mold_"..MINERALS_LIST[i], {
		description = "Ceramic mold with "..MINERALS_LIST[i],
		inventory_image = "metals_ceramic_mold_"..MINERALS_LIST[i]..".png",
	})

	minetest.register_craft({
		output = "metals:ceramic_mold_"..MINERALS_LIST[i],
		recipe = {
			{"minerals:"..MINERALS_LIST[i]},
			{"metals:ceramic_mold"},
		}
	})

	minetest.register_craft({
		type = "cooking",
		output = "metals:"..MINERALS_METALS_LIST[i].."_unshaped",
		recipe = "metals:ceramic_mold_"..MINERALS_LIST[i],
	})
end

minetest.register_craftitem("metals:recipe_pick", {
	description = "Pick's recipe",
	inventory_image = "metals_recipe.png",
})

minetest.register_craftitem("metals:recipe_axe", {
	description = "Axe's recipe",
	inventory_image = "metals_recipe.png",
})

minetest.register_craftitem("metals:recipe_shovel", {
	description = "Shovel's recipe",
	inventory_image = "metals_recipe.png",
})

minetest.register_craftitem("metals:recipe_sword", {
	description = "Sword's recipe",
	inventory_image = "metals_recipe.png",
})

DYE_LIST={
	'white',
	'red',
	'green',
	'lime',
	'violet',
	'yellow',
	'orange',
	'black',
	'brown',
	'purple',
	'gray',
	'light_gray',
	'pink',
	'blue',
	'cyan',
	'light_blue',
	'light_brown',
	'biruza',
}

for i=1, #DYE_LIST do
	minetest.register_craft({
		output = "metals:recipe_pick",
		recipe = {
			{"dye:"..DYE_LIST[i], "dye:"..DYE_LIST[i], "dye:"..DYE_LIST[i]},
			{"", "", ""},
			{"default:paper", "", ""},
		}
	})
	
	minetest.register_craft({
		output = "metals:recipe_axe",
		recipe = {
			{"dye:"..DYE_LIST[i], "dye:"..DYE_LIST[i]},
			{"dye:"..DYE_LIST[i], ""},
			{"default:paper", ""},
		}
	})
	
	minetest.register_craft({
		output = "metals:recipe_shovel",
		recipe = {
			{"dye:"..DYE_LIST[i]},
			{""},
			{"default:paper"},
		}
	})
	
	minetest.register_craft({
		output = "metals:recipe_sword",
		recipe = {
			{"dye:"..DYE_LIST[i]},
			{"dye:"..DYE_LIST[i]},
			{"default:paper"},
		}
	})
end

minetest.register_craft({
	output = "metals:clay_mold",
	recipe = {
		{"default:clay_lump", "",                  "default:clay_lump"},
		{"default:clay_lump", "default:clay_lump", "default:clay_lump"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "metals:ceramic_mold",
	recipe = "metals:clay_mold",
})

minetest.register_craft({
	output = "metals:wrought_iron_ingot",
	recipe = {
		{"metals:pig_iron_ingot"},
	}
})

minetest.register_craft({
	output = "metals:steel_unshaped 4",
	recipe = {
		{"metals:wrought_iron_unshaped", "metals:wrought_iron_unshaped", "metals:wrought_iron_unshaped"},
		{"", "metals:pig_iron_unshaped", ""},
	}
})

minetest.register_craft({
	output = "metals:brass_unshaped 4",
	recipe = {
		{"metals:copper_unshaped", "metals:copper_unshaped", "metals:copper_unshaped"},
		{"","metals:zinc_unshaped",""},
	}
})

minetest.register_craft({
	output = "metals:sterling_silver_unshaped 4",
	recipe = {
		{"metals:silver_unshaped", "metals:silver_unshaped", "metals:silver_unshaped"},
		{"", "metals:copper_unshaped", ""},
	}
})

minetest.register_craft({
	output = "metals:rose_gold_unshaped 4",
	recipe = {
		{"metals:gold_unshaped", "metals:gold_unshaped", "metals:gold_unshaped"},
		{"", "metals:brass_unshaped", ""},
	}
})

minetest.register_craft({
	output = "metals:black_bronze_unshaped 4",
	recipe = {
		{"metals:copper_unshaped", "metals:copper_unshaped"},
		{"metals:gold_unshaped", ""},
		{"metals:silver_unshaped", ""},
	}
})

minetest.register_craft({
	output = "metals:bismuth_bronze_unshaped 4",
	recipe = {
		{"metals:copper_unshaped", "metals:copper_unshaped"},
		{"metals:bismuth_unshaped", ""},
		{"metals:tin_unshaped", ""},
	}
})

minetest.register_craft({
	output = "metals:bronze_unshaped 4",
	recipe = {
		{"metals:copper_unshaped", "metals:copper_unshaped", "metals:copper_unshaped"},
		{"", "metals:tin_unshaped", ""},
	}
})

minetest.register_craft({
	output = "metals:black_steel_unshaped 4",
	recipe = {
		{"metals:steel_unshaped", "metals:steel_unshaped"},
		{"metals:nickel_unshaped", ""},
		{"metals:black_bronze_unshaped", ""},
	}
})