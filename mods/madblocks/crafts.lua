--		** dye

minetest.register_craft({	type = "cooking",	output = "madblocks:dye_black",	recipe = "default:coal_lump", })
minetest.register_craft({	output = 'madblocks:dye_blue 1',	recipe = {
		{'','',''},
		{'','madblocks:dye_black',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:dye_green 1',	recipe = {
		{'','',''},
		{'','madblocks:dye_blue',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:dye_yellow 1',	recipe = {
		{'','',''},
		{'','madblocks:dye_green',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:dye_red 1',	recipe = {
		{'','',''},
		{'','madblocks:dye_yellow',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:dye_black 3',	recipe = {		-- back to black when stuck w/ dif colors
		{'','madblocks:dye_red',''},
		{'','madblocks:dye_yellow',''},
		{'','madblocks:dye_blue',''},
	}})

--		** bricks

minetest.register_craft({	output = 'madblocks:greenbrick 1',	recipe = {
		{'','madblocks:dye_green',''},
		{'','"brick"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:blackbrick 1',	recipe = {
		{'','madblocks:dye_black',''},
		{'','"brick"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:bluebrick 1',	recipe = {
		{'','madblocks:dye_blue',''},
		{'','"brick"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:yellowbrick 1',	recipe = {
		{'','madblocks:dye_yellow',''},
		{'','"brick"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:brownbrick 1',	recipe = {
		{'','madblocks:dye_red',''},
		{'','"brick"',''},
		{'','madblocks:dye_black',''},
	}})

minetest.register_craft({	output = 'madblocks:oddbrick 1',	recipe = {
		{'','madblocks:dye_red',''},
		{'','"brick"',''},
		{'','madblocks:dye_yellow',''},
	}})
minetest.register_craft({	output = 'madblocks:asphalte 1',	recipe = {
		{'','',''},
		{'','craft "lump_of_coal"',''},
		{'','"cobble"',''},
	}})
minetest.register_craft({	output = 'madblocks:mossystonebrick 1',	recipe = {
		{'','"default:leaves"',''},
		{'','"default:cobble"',''},
		{'','madblocks:dye_yellow',''},
	}})
minetest.register_craft({	output = 'madblocks:culturedstone 1',	recipe = {
		{'','madblocks:dye_yellow',''},
		{'','"default:cobble"',''},
		{'','madblocks:dye_red',''},
	}})
minetest.register_craft({	output = 'madblocks:marblestonebrick 1',	recipe = {
		{'','madblocks:dye_green',''},
		{'','"default:cobble"',''},
		{'','madblocks:dye_black',''},
	}})
minetest.register_craft({	output = 'madblocks:shinystonebrick 1',	recipe = {
		{'','"default:sand"',''},
		{'','"default:cobble"',''},
		{'','madblocks:dye_red',''},
	}})
minetest.register_craft({	output = 'madblocks:roundstonebrick 5',	recipe = {
	{'','default:cobble',''},
	{'default:cobble','madblocks:cement','default:cobble'},
	{'','default:cobble',''},
}})
minetest.register_craft({	output = 'madblocks:slimstonebrick 3',	recipe = {
		{'','default:cobble',''},
		{'','madblocks:cement',''},
		{'','default:cobble',''},
	}})
minetest.register_craft({	output = 'madblocks:greystonebrick 2',	recipe = {
		{'','madblocks:dye_black',''},
		{'','default:cobble',''},
		{'','madblocks:cement',''},
	}})
minetest.register_craft({	output = 'madblocks:medistonebrick 3',	recipe = {
		{'','',''},
		{'madblocks:dye_blue','','madblocks:dye_yellow'},
		{'default:cobble','madblocks:cement','default:cobble'},
	}})
minetest.register_craft({	output = 'madblocks:whitestonebrick 3',	recipe = {
		{'','default:clay',''},
		{'','default:cobble',''},
		{'','madblocks:cement',''},
	}})
minetest.register_craft({	output = 'madblocks:countrystonebrick 2',	recipe = {
		{'','',''},
		{'','madblocks:cement',''},
		{'','default:cobble',''},
	}})
minetest.register_craft({	output = 'madblocks:blackstonebrick 1',	recipe = {
		{'','',''},
		{'','madblocks:dye_black',''},
		{'','default:cobble',''},
	}})
minetest.register_craft({	output = 'madblocks:cement 2',	recipe = {
		{'','',''},
		{'','default:sand',''},
		{'','default:gravel',''},
	}})
minetest.register_craft({	output = 'madblocks:cinderblock 9',	recipe = {
		{'default:cobble','default:cobble','default:cobble'},
		{'default:cobble','default:cobble','default:cobble'},
		{'default:cobble','default:cobble','default:cobble'},
	}})
minetest.register_craft({	output = 'madblocks:cinderblock_planter 2',	recipe = {
		{'','',''},
		{'','default:dirt',''},
		{'','madblocks:cinderblock',''},
	}})

--		** woods

minetest.register_craft({	output = 'madblocks:woodshingles 8',	recipe = {
		{'"default:wood"','"default:wood"'},
		{'"default:wood"','"default:wood"'},
	}})

minetest.register_craft({	output = 'madblocks:bluewood 1',	recipe = {
		{'','madblocks:dye_blue',''},
		{'','"default:wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:blackwood 1',	recipe = {
		{'','madblocks:dye_black',''},
		{'','"default:wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:yellowwood 1',	recipe = {
		{'','madblocks:dye_yellow',''},
		{'','"default:wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:greenwood 1',	recipe = {
		{'','madblocks:dye_green',''},
		{'','"default:wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:redwood 1',	recipe = {
		{'','madblocks:dye_red',''},
		{'','"default:wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:redwood_fence 1',	recipe = {
		{'','madblocks:dye_red',''},
		{'','"default:fence_wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:blackwood_fence 1',	recipe = {
		{'','madblocks:dye_black',''},
		{'','"default:fence_wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:greenwood_fence 1',	recipe = {
		{'','madblocks:dye_green',''},
		{'','"default:fence_wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:yellowwood_fence 1',	recipe = {
		{'','madblocks:dye_yellow',''},
		{'','"default:fence_wood"',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:bluewood_fence 1',	recipe = {
		{'','madblocks:dye_blue',''},
		{'','"default:fence_wood"',''},
		{'','',''},
	}})


--		** lights
minetest.register_craft({	output = 'madblocks:glowyellow 1',	recipe = {
		{'','torch',''},
		{'','glass',''},
		{'','madblocks:dye_yellow',''},
	}})
minetest.register_craft({	output = 'madblocks:glowgreen 1',	recipe = {
	{'','torch',''},
	{'','glass',''},
	{'','madblocks:dye_green',''},
}})
minetest.register_craft({	output = 'madblocks:glowred 1',	recipe = {
	{'','torch',''},
	{'','glass',''},
	{'','madblocks:dye_red',''},
}})
minetest.register_craft({	output = 'madblocks:glowblue 1',	recipe = {
	{'','torch',''},
	{'','glass',''},
	{'','madblocks:dye_blue',''},
}})
minetest.register_craft({	output = 'madblocks:spotlight 1',	recipe = {
	{'','',''},
	{'','madblocks:glowyellow',''},
	{'','madblocks:sheetmetal',''},
}})
minetest.register_craft({	output = 'madblocks:searchlight 1',	recipe = {
	{'','madblocks:spotlight',''},
	{'madblocks:spotlight','madblocks:sheetmetal','madblocks:spotlight'},
	{'','madblocks:spotlight',''},
}})
minetest.register_craft({	output = 'madblocks:fancylamp 1',	recipe = {
	{'','madblocks:dye_black',''},
	{'','madblocks:sheetmetal',''},
	{'','madblocks:glowyellow',''},
}})
minetest.register_craft({	output = 'madblocks:lampling 1',	recipe = {
	{'','madblocks:glowyellow',''},
	{'','default:stick',''},
	{'','default:stick',''},
}})

--		** sound nodes

minetest.register_craft({	output = 'madblocks:bigben 1',	recipe = {
		{'','madblocks:dye_black',''},
		{'','madblocks:sheetmetal',''},
		{'','default:wood',''},
	}})
minetest.register_craft({	output = 'madblocks:siren 1',	recipe = {
		{'','',''},
		{'madblocks:sheetmetal','madblocks:dye_red','madblocks:sheetmetal'},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:churchbells 1',	recipe = {
		{'','',''},
		{'','madblocks:sheetmetal',''},
		{'madblocks:sheetmetal','','madblocks:sheetmetal'},
	}})
--		** decorative

minetest.register_craft({	output = 'madblocks:hangingflowers 1',	recipe = {
		{'','',''},
		{'default:stick','madblocks:rosebush','default:stick'},
		{'','default:stick',''},
	}})
minetest.register_craft({	output = 'madblocks:gnome 1',	recipe = {
		{'default:clay_lump','madblocks:dye_red','default:clay_lump'},
		{'','default:clay_lump','madblocks:dye_green'},
		{'default:clay_lump','','default:clay_lump'},
	}})
minetest.register_craft({	output = 'madblocks:statue 1',	recipe = {
		{'','default:clay_lump',''},
		{'','default:clay_lump',''},
		{'','default:clay_lump',''},
	}})
minetest.register_craft({	output = 'madblocks:gargoyle 1',	recipe = {
		{'','',''},
		{'default:clay_lump','madblocks:dye_black','default:clay_lump'},
		{'','default:clay_lump',''},
	}})
minetest.register_craft({	output = 'madblocks:awning 2',	recipe = {
		{'','',''},
		{'','','default:junglegrass'},
		{'','default:junglegrass','madblocks:dye_red'},
	}})

minetest.register_craft({	output = 'madblocks:stool 1',	recipe = {
		{'','madblocks:dye_red',''},
		{'','madblocks:sheetmetal',''},
		{'default:stick','','default:stick'},
	}})

--[[				fix me
minetest.register_craft({	output = 'madblocks:flowers2 2',	recipe = {
		{'','',''},
		{'madblocks:hydroponics_yellowflower','madblocks:hydroponics_magentaflower',''},
		{'','',''},
	}})
minetest.register_craft({	output = 'madblocks:flowers1 2',	recipe = {
		{'','',''},
		{'madblocks:hydroponics_magentaflower','madblocks:hydroponics_cyanflower',''},
		{'','',''},
	}})
]]--

--		** signs

minetest.register_craft({	output = 'madblocks:signs_cafe 1',	recipe = {
		{'','madblocks:coffeecup',''},
		{'','default:sign_wall',''},
		{'','default:torch',''},
	}})
minetest.register_craft({	output = 'madblocks:signs_drpepper 1',	recipe = {
		{'','madblocks:dye_black',''},
		{'','default:sign_wall',''},
		{'','madblocks:dye_red',''},
	}})
minetest.register_craft({	output = 'madblocks:signs_enjoycoke 1',	recipe = {
		{'','madblocks:sheetmetal',''},
		{'','default:sign_wall',''},
		{'','madblocks:dye_red',''},
	}})
minetest.register_craft({	output = 'madblocks:signs_hucksfoodfuel 1',	recipe = {
		{'','madblocks:dye_red',''},
		{'','default:sign_wall',''},
		{'','madblocks:dye_yellow',''},
	}})
minetest.register_craft({	output = 'madblocks:signs_dangermines 1',	recipe = {
		{'','madblocks:dye_yellow',''},
		{'','default:sign_wall',''},
		{'','madblocks:dye_black',''},
	}})

--		** metallic & misc. items

minetest.register_craft({	output = 'madblocks:sheetmetal 4',	recipe = {
		{'default:steel_ingot'},
	}})
minetest.register_craft({	output = 'madblocks:pylon 5',	recipe = {
		{'madblocks:sheetmetal','','madblocks:sheetmetal'},
		{'','madblocks:sheetmetal',''},
		{'madblocks:sheetmetal','','madblocks:sheetmetal'},
	}})
minetest.register_craft({	output = 'madblocks:safetyladder 7',	recipe = {
		{'madblocks:sheetmetal','','madblocks:sheetmetal'},
		{'madblocks:sheetmetal','madblocks:sheetmetal','madblocks:sheetmetal'},
		{'madblocks:sheetmetal','','madblocks:sheetmetal'},
	}})
minetest.register_craft({	output = 'madblocks:fancybracket 4',	recipe = {
		{'','','madblocks:sheetmetal'},
		{'','','madblocks:sheetmetal'},
		{'','madblocks:sheetmetal','madblocks:sheetmetal'},
	}})
minetest.register_craft({	output = 'madblocks:street 1',	recipe = {
		{'','',''},
		{'','',''},
		{'default:mese','default:mese','default:mese'},
	}})

