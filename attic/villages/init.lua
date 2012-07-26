
math.randomseed(os.time())

if minetest.get_modpath ~= nil then
          dofile(minetest.get_modpath('villages')..'buildings.lua')
end

local MAX_RATIO = 1000

-- Utils functions
local print_vector = function(pos)
	print('(' .. pos.x
		.. ', ' .. pos.y
		.. ', ' .. pos.z .. ')')
end

local vector_le = function(pos1, pos2)
	return (pos1.x <= pos2.x) and (pos1.y <= pos2.y) and (pos1.z <= pos2.z)
end

local vector_add = function(pos1, pos2)
	return {
		x = pos1.x + pos2.x,
		y = pos1.y + pos2.y,
		z = pos1.z + pos2.z,
	}
end

local table_contains = function(t, v)
	for _, i in ipairs(t) do
		if (i == v) then
			return true
		end
	end

	return false
end

-- Mods main functions
local building_fits = function(building, min_pos, max_pos)
	local max_rad_y = max_pos.y - min_pos.y - building.size.y - 1
	local ry = 0
	local block

	while ry < max_rad_y do
		block = false
		for i = 0, building.size.y do
			for j = 0, building.size.x do
				for k = 0, building.size.z do
					local node = minetest.env:get_node({
						x = min_pos.x + j + 0,
						y = min_pos.y + i + ry,
						z = min_pos.z + k + 0,
					})
					if (node.name ~= 'air') then
						if ry == max_rad_y - 1 then
							return nil
						else
							block = true
						end
					end
				end
			end
		end

		if block == true then
			ry = ry + 1
		else
			break
		end
	end

	return block == true and nil or {
		x = 0 + min_pos.x,
		y = ry + min_pos.y,
		z = 0 + min_pos.z,
	}
end


local place_building = function(building, building_pos)
	for i = 0, building.size.x - 1 do
		for j = 0, building.size.y - 1 do
			for k = 0, building.size.z - 1 do
				local pos = {
					x = building_pos.x + i,
					y = building_pos.y + j,
					z = building_pos.z + k,
				}
				local node = building.structure[j + 1][k + 1][i + 1]

				if node ~= nil then
					minetest.env:remove_node(pos)
					minetest.env:add_node(pos, {
						name = node
					})
				end
			end
		end
	end
end

local count_blocks = function(blocks, pos1, pos2)
	local n = 0

	for i = pos1.x, pos2.x do
		for j = pos1.y, pos2.y do
			for k = pos1.z, pos2.z do
				local node = minetest.env:get_node_or_nil({
					x = i,
					y = j,
					z = k,
				})

				if (node ~= nil)
					and table_contains(blocks, node.name) then
					n = n + 1
				end
			end
		end
	end

	return n
end

local has_building_ground = function(building, pos1)
	for i = 0, building.size.x - 1 do
		for j = 0, building.size.z - 1 do
			local node = minetest.env:get_node_or_nil({
				x = pos1.x + i,
				y = pos1.y,
				z = pos1.z + j,
			})

			if (node ~= nil) then
				if (table_contains(building.building_surfaces, node.name) == false)
					and (building.structure[1][j + 1][i + 1] ~= nil) then
					return false
				end
			end
		end
	end

	return true
end

minetest.register_on_generated(function(min_pos, max_pos)
	local diff_pos = {
		x = max_pos.x - min_pos.x,
		y = max_pos.y - min_pos.y,
		z = max_pos.z - min_pos.z,
	}

	for _, building in ipairs(BUILDINGS) do
		if vector_le(building.size, diff_pos) then
			local building_pos = building_fits(building, min_pos, max_pos)

			if (building_pos ~= nil)
				and (math.random(1, MAX_RATIO) < building.odds) then
				local v1 = vector_add(building_pos, {
					x = 0,
					y = -1,
					z = 0,
				})

				if has_building_ground(building, v1) then
					print('Placing building ' .. building.name .. ': ')
					print_vector(building_pos)
					place_building(building, building_pos)
					-- One building per chunk
					break
				end
			end
		end
	end
end)
