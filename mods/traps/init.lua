dofile(minetest.get_modpath("traps").."/mine.lua")
dofile(minetest.get_modpath("traps").."/cage.lua")

minetest.register_craft({
output="traps:cage",
recipe={
{"","default:mese",""},
{"","default:mese",""},
{"","default:dirt",""}}
})

minetest.register_craft({
output="traps:mine",
recipe={
{"","default:coal_lump",""},
{"","default:coal_lump",""},
{"default:mese","default:dirt","default:mese"}}
})