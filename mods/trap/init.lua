dofile(minetest.get_modpath("traps").."/mine.lua")
dofile(minetest.get_modpath("traps").."/cage.lua")
dofile(minetest.get_modpath("traps").."/lava.lua")

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

minetest.register_craft({
output="traps:lava",
recipe={
{"bucket:bucket_lava","bucket:bucket_lava","bucket:bucket_lava"},
{"","default:glass",""},
{"default:mese","default:dirt","default:mese"}}
})