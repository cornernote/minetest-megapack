--Tv Mod, by Jordan Snelling 2012.

minetest.register_node("tv:screen_1", {
	description = "TV",
	tiles = {"tv_screen_1.png"},
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	drop = 'tv:screen_1',
	light_source = 8,
})

minetest.register_node("tv:screen_2", {
	description = "TV",
	tiles = {"tv_screen_2.png"},
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	drop = 'tv:screen_1',
	light_source = 8,
})

minetest.register_node("tv:screen_3", {
	description = "TV",
	tiles = {"tv_screen_3.png"},
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	drop = 'tv:screen_1',
	light_source = 8,
})

minetest.register_node("tv:screen_4", {
	description = "TV",
	tiles = {"tv_screen_4.png"},
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	drop = 'tv:screen_1',
	light_source = 8,
})

minetest.register_node("tv:screen_5", {
	description = "TV",
	tiles = {"tv_screen_5.png"},
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	drop = 'tv:screen_1',
	light_source = 8,
})

minetest.register_node("tv:screen_6", {
	description = "TV",
	tiles = {"tv_screen_6.png"},
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	drop = 'tv:screen_1',
	light_source = 8,
})

minetest.register_node("tv:screen_7", {
	description = "TV",
	tiles = {"tv_screen_7.png"},
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	drop = 'tv:screen_1',
	light_source = 8,
})

minetest.register_node("tv:screen_8", {
	description = "TV",
	tiles = {"tv_screen_8.png"},
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	drop = 'tv:screen_1',
	light_source = 8,
})

minetest.register_node("tv:screen_9", {
	description = "TV",
	tiles = {"tv_screen_9.png"},
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	drop = 'tv:screen_1',
	light_source = 8,
})
minetest.register_node("tv:screen_10", {
	description = "TV",
	tiles = {"tv_screen_10.png"},
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	drop = 'tv:screen_1',
	light_source = 8,
})

minetest.register_abm(
        {nodenames = {"tv:screen_1", "tv:screen_2", "tv:screen_3", "tv:screen_4", "tv:screen_5", "tv:screen_6", "tv:screen_7", "tv:screen_8", "tv:screen_9", "tv:screen_10"},
        interval = 12,
        chance = 2,
        action = function(pos)
		local i = math.random(1,10)
        
			if i== 1 then
				minetest.env:add_node(pos,{name="tv:screen_1"})
			end
		
			if i== 2 then
				minetest.env:add_node(pos,{name="tv:screen_2"})
			end

			if i== 3 then
				minetest.env:add_node(pos,{name="tv:screen_3"})
			end
		
			if i== 4 then
				minetest.env:add_node(pos,{name="tv:screen_4"})
			end
		
			if i== 5 then
				minetest.env:add_node(pos,{name="tv:screen_5"})
			end

			if i== 6 then
				minetest.env:add_node(pos,{name="tv:screen_6"})
			end
		
			if i== 7 then
				minetest.env:add_node(pos,{name="tv:screen_7"})
			end
		
			if i== 8 then
				minetest.env:add_node(pos,{name="tv:screen_8"})
			end
		
			if i== 9 then
				minetest.env:add_node(pos,{name="tv:screen_9"})
			end
		
			if i== 10 then
				minetest.env:add_node(pos,{name="v:screen_10"})
			end
		
		end
})

minetest.register_craft({
	output = 'tv:screen_1',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', ''},
		{'default:steel_ingot', 'default:steel_ingot', ''},
		{'', '', ''},
	}
})