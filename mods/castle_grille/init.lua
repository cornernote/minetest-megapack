local GRILLE_HEIGHT = 11;

local grilles_to_remove = {}
local grilles_to_add = {}
local tmp = {}
minetest.register_node("castle_grille:mechanism", {
	description = "Grille mechanism",
	tiles = {"grille_meh.png"},
	is_ground_content = true,
	groups = {fastness = 3, level = 2},
	--sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("castle_grille:grille", {
	description = "Grille",
	drawtype = "fencelike",
	paramtype = "light",
	tiles = {"grille_gril.png"},
	is_ground_content = true,
	drop = "",
	groups = {fastness = 2, level = 3},
	--sounds = default.node_sound_stone_defaults(),
})

local function remove_up(pos, height, reversed)
	if height > GRILLE_HEIGHT then
		return height
	end
	local current_node = minetest.env:get_node(pos)
	if current_node.name ~= "castle_grille:grille" then
		return height
	end
	local max_h = remove_up({x = pos.x, y =  pos.y - 1, z = pos.z}, height + 1)
	if reversed == true then
		grilles_to_remove[pos] = height + 1
	else
		grilles_to_remove[pos] = max_h - height
	end
	return max_h
end

mesecon:register_on_signal_on(function (pos, node)
	if node.name == "castle_grille:mechanism" then
		grilles_to_add[{x = pos.x, y = pos.y - 1, z = pos.z}] = GRILLE_HEIGHT
	end
end)

mesecon:register_on_signal_off(function (pos,node)
	if node.name == "castle_grille:mechanism" then
		remove_up({x = pos.x, y = pos.y - 1, z = pos.z}, 0)
	end
end)

local delta = 0
minetest.register_globalstep(function(dtime)
	delta = delta + dtime
	while delta >= 1 do
		delta = delta - 1
		for pos, time in pairs(grilles_to_remove) do
			if time == 1 and minetest.env:get_node(pos).name == "castle_grille:grille" then
				minetest.env:remove_node(pos)
				grilles_to_remove[pos] = nil
			else
				grilles_to_remove[pos] = time - 1
			end
		end
		for pos, time in pairs(grilles_to_add) do
			if minetest.env:get_node(pos).name == "air"  then
				minetest.env:add_node(pos, {name = "castle_grille:grille"})
				grilles_to_add[pos] = nil
				if time ~= 1 then
					tmp[{x = pos.x, y = pos.y - 1, z = pos.z}] = time - 1
				end
			end
		end
		for pos, time in pairs(tmp) do
			grilles_to_add[pos] = time
		end
	end
end)

minetest.register_on_dignode(function(pos, oldnode)
	if oldnode.name == "castle_grille:grille" or oldnode.name == "castle_grille:mechanism" then
		remove_up({x = pos.x, y = pos.y - 1, z = pos.z}, 0, true)
	end
end)

minetest.register_craft({
	output = 'castle_grille:mechanism',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:stone', 'default:stick', 'default:stone'},
		{'default:steel_ingot', 'default:stick', 'default:steel_ingot'},
	}
})
