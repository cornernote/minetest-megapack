--
--GELD MOD v 1.0
--by Severak
--
--Licence: WTFPL (on all)
--
minetest.register_craftitem("geld:default",{
	description="Sestertius",
	stack_max=100,
	inventory_image="geld_default.png"
})

minetest.register_craft({
	output="geld:default 25",
	recipe={
		{"","default:mese",""},
		{"default:mese","default:mese","default:mese"},
		{"","default:mese",""}
	}
})