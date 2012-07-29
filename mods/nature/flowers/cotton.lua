-- Cotton

minetest.register_craftitem('flowers:cotton', {
    description = "Cotton",
    image = 'cotton.png',
})

minetest.register_craft({
    output = 'flowers:cotton 3',
    recipe ={
	{'flowers:flower_cotton 1'},
    }
})
