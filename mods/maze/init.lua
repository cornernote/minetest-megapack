minetest.register_chatcommand("maze", {
	params = "<size_x> <size_y> <#floors> <material_floor> <material_wall> <material_ceiling>",
	description = "Create a maze near your position",
	func = function(name, param)
		math.randomseed(os.time())
		local player_pos = minetest.env:get_player_by_name(name):getpos()
		local found, _, maze_size_x_st, maze_size_y_st, maze_size_l_st, material_floor, material_wall, material_ceiling = param:find("(%d+)%s+(%d+)%s+(%d+)%s+([^%s]+)%s+([^%s]+)%s+([^%s]+)")
		local min_size = 11
		local maze_size_x = tonumber(maze_size_x_st)
		if maze_size_x == nil then maze_size_x = 20 end
		if maze_size_x < min_size then maze_size_x = min_size end
		local maze_size_y = tonumber(maze_size_y_st)
		if maze_size_y == nil then maze_size_y = 20 end
		if maze_size_y < min_size then maze_size_y = min_size end
		local maze_size_l = tonumber(maze_size_l_st)
		if maze_size_l == nil then maze_size_l = 3 end
		if maze_size_l < 1 then maze_size_l = 1 end
		-- check if chosen material exists
		if not minetest.registered_nodes[material_floor] then material_floor = "default:cobble" end
		if material_floor == nil then material_floor = "default:cobble" end
		if not minetest.registered_nodes[material_wall] then material_wall = "default:cobble" end
		if material_wall == nil then material_wall = "default:cobble" end
		if not minetest.registered_nodes[material_ceiling] then material_ceiling = "default:cobble" end
		if material_ceiling == nil then material_ceiling = "default:cobble" end
		
		minetest.chat_send_player(name, "Try to build " .. maze_size_x .. " * " .. maze_size_y .. " * " .. maze_size_l .. " maze.  F:" .. material_floor .. " W:" .. material_wall .. " C:" .. material_ceiling)

		local maze = {}
		for l = 0, maze_size_l-1, 1 do
			maze[l] = {}
			for x = 0, maze_size_x-1, 1 do
				maze[l][x] = {}
				for y = 0, maze_size_y-1, 1 do
					maze[l][x][y] = true -- everywhere walls
				end
			end
		end

-- create maze map
		local start_x = 0
		local start_y = math.floor(maze_size_y/2)
		local start_l = 0
		local pos_x = start_x
		local pos_y = start_y
		local pos_l = start_l
		maze[pos_l][pos_x][pos_y] = false -- the entrance
		local moves = {}
		local updowns = {}
		local possible_ways = {}
		local direction = ""
		local pos = {x = 0, y = 0, l = 0}
		table.insert(moves, {x = pos_x, y = pos_y, l = pos_l})
		-- print(#moves .. " " .. moves[1].x .. " " .. moves[1].y)
		repeat
			possible_ways = {}
			-- is D possible?
			if 
				pos_x > 1 and pos_x < maze_size_x - 1 and pos_y > 1 and pos_y < maze_size_y - 1 and
				pos_l < maze_size_l - 1 and
				maze[pos_l + 1][pos_x - 1][pos_y - 1] and
				maze[pos_l + 1][pos_x - 1][pos_y] and
				maze[pos_l + 1][pos_x - 1][pos_y + 1] and
				maze[pos_l + 1][pos_x][pos_y - 1] and
				maze[pos_l + 1][pos_x][pos_y] and
				maze[pos_l + 1][pos_x][pos_y + 2] and
				maze[pos_l + 1][pos_x + 1][pos_y - 1] and
				maze[pos_l + 1][pos_x + 1][pos_y] and
				maze[pos_l + 1][pos_x + 1][pos_y + 1]
			then
				table.insert(possible_ways, "D")
			end
			-- is U possible?
			if
				pos_x > 1 and pos_x < maze_size_x - 1 and pos_y > 1 and pos_y < maze_size_y - 1 and
				pos_l > 0 and
				maze[pos_l - 1][pos_x - 1][pos_y - 1] and
				maze[pos_l - 1][pos_x - 1][pos_y] and
				maze[pos_l - 1][pos_x - 1][pos_y + 1] and
				maze[pos_l - 1][pos_x][pos_y - 1] and
				maze[pos_l - 1][pos_x][pos_y] and
				maze[pos_l - 1][pos_x][pos_y + 2] and
				maze[pos_l - 1][pos_x + 1][pos_y - 1] and
				maze[pos_l - 1][pos_x + 1][pos_y] and
				maze[pos_l - 1][pos_x + 1][pos_y + 1]
			then
				table.insert(possible_ways, "U")
			end
			-- is N possible?
			if
				pos_y - 2 >= 0 and pos_x - 1 >= 0 and pos_x + 1 < maze_size_x and 
				maze[pos_l][pos_x][pos_y - 1] and -- N is wall
				maze[pos_l][pos_x][pos_y - 2] and -- N from N is wall
				maze[pos_l][pos_x - 1][pos_y - 2] and -- NW from N is wall
				maze[pos_l][pos_x + 1][pos_y - 2] and -- NE from N is wall
				maze[pos_l][pos_x - 1][pos_y - 1] and -- W from N is wall
				maze[pos_l][pos_x + 1][pos_y - 1] -- E from N is wall
			then
				table.insert(possible_ways, "N")
				table.insert(possible_ways, "N") -- twice as possible as U and D
			end
			-- is E possible?
			if
				pos_x + 2 < maze_size_x and pos_y - 1 >= 0 and pos_y + 1 < maze_size_y and 
				maze[pos_l][pos_x + 1][pos_y] and -- E is wall
				maze[pos_l][pos_x + 2][pos_y] and -- E from E is wall
				maze[pos_l][pos_x + 2][pos_y - 1] and -- NE from E is wall
				maze[pos_l][pos_x + 2][pos_y + 1] and -- SE from E is wall
				maze[pos_l][pos_x + 1][pos_y - 1] and -- N from E is wall
				maze[pos_l][pos_x + 1][pos_y + 1] -- S from E is wall
			then
				table.insert(possible_ways, "E")
				table.insert(possible_ways, "E") -- twice as possible as U and D
			end
			-- is S possible?
			if
				pos_y + 2 < maze_size_y and pos_x - 1 >= 0 and pos_x + 1 < maze_size_x and 
				maze[pos_l][pos_x][pos_y + 1] and -- S is wall
				maze[pos_l][pos_x][pos_y + 2] and -- S from S is wall
				maze[pos_l][pos_x - 1][pos_y + 2] and -- SW from S is wall
				maze[pos_l][pos_x + 1][pos_y + 2] and -- SE from S is wall
				maze[pos_l][pos_x - 1][pos_y + 1] and -- W from S is wall
				maze[pos_l][pos_x + 1][pos_y + 1] -- E from S is wall
			then
				table.insert(possible_ways, "S")
				table.insert(possible_ways, "S") -- twice as possible as U and D
			end
			-- is W possible?
			if
				pos_x - 2 >= 0 and pos_y - 1 >= 0 and pos_y + 1 < maze_size_y and 
				maze[pos_l][pos_x - 1][pos_y] and -- W is wall
				maze[pos_l][pos_x - 2][pos_y] and -- W from W is wall
				maze[pos_l][pos_x - 2][pos_y - 1] and -- NW from W is wall
				maze[pos_l][pos_x - 2][pos_y + 1] and -- SW from W is wall
				maze[pos_l][pos_x - 1][pos_y - 1] and -- N from W is wall
				maze[pos_l][pos_x - 1][pos_y + 1] -- S from W is wall
			then
				table.insert(possible_ways, "W")
				table.insert(possible_ways, "W") -- twice as possible as U and D
			end
			if #possible_ways > 0 then
				direction = possible_ways[math.random(# possible_ways)]
				if direction == "N" then 
					pos_y = pos_y - 1
				elseif direction == "E" then 
					pos_x = pos_x + 1
				elseif direction == "S" then 
					pos_y = pos_y + 1
				elseif direction == "W" then 
					pos_x = pos_x - 1
				elseif direction == "D" then 
					table.insert(updowns, {x = pos_x, y = pos_y, l = pos_l}) -- mark way down
					pos_l = pos_l + 1
				elseif direction == "U" then 
					pos_l = pos_l - 1
					table.insert(updowns, {x = pos_x, y = pos_y, l = pos_l}) -- mark way up = down from level above
				end
				table.insert(moves, {x = pos_x, y = pos_y, l = pos_l})
				maze[pos_l][pos_x][pos_y] = false
				-- print(# possible_ways .. " " .. direction)
			else
				pos = table.remove(moves)
				pos_x = pos.x
				pos_y = pos.y
				pos_l = pos.l
				-- print("get back to " .. pos_x .. " / " .. pos_y .. " / " .. pos_l .. " to find another way from there")
			end
		until pos_x == start_x and pos_y == start_y
-- create exit on opposite end of maze and make sure it is reachable
		local exit_x = maze_size_x - 1 -- exit always on opposite side of maze
		local exit_y = math.random(maze_size_y - 3) + 1
		local exit_l = math.random(maze_size_l) - 1
		local exit_reachable = false
		repeat
			maze[exit_l][exit_x][exit_y] = false
			exit_reachable = not maze[exit_l][exit_x - 1][exit_y] or not maze[exit_l][exit_x][exit_y - 1] or not maze[exit_l][exit_x][exit_y + 1]
			exit_x = exit_x - 1
		until exit_reachable

-- get transform factors to place the maze in "look_dir" of player
		local player_dir = minetest.env:get_player_by_name(name):get_look_dir()
		local cosine = 1
		local sine = 0
		if math.abs(player_dir.x) > math.abs(player_dir.z) then 
			if player_dir.x > 0 then 
				cosine = 1
				sine = 0
			else
				cosine = -1
				sine = 0
			end
		else
			if player_dir.z < 0 then 
				cosine = 0
				sine = -1
			else
				cosine = 0
				sine = 1
			end
		end
		-- print (cosine .. " " .. sine)

-- build maze in minetest-world
		local offset_x = 1
		local offset_y = 1
		local line = ""
		local pos = {x = 0, y = 0, z = 0}
		local change_level_down = false
		local change_level_up = false
		local ladder_direction = 2
		for l = maze_size_l - 1, 0, -1 do
			for y = 0, maze_size_y - 1, 1 do
				if l == 0 and y == math.floor(maze_size_y / 2) then line = "<-" else line = "  " end
				for x = 0, maze_size_x - 1, 1 do
					-- rotate the maze in players view-direction and move it to his position
					pos.x = cosine * (x + 2) - sine * (y - math.floor(maze_size_y / 2)) + player_pos.x
					pos.z = sine * (x + 2) + cosine * (y - math.floor(maze_size_y / 2)) + player_pos.z
					pos.y = player_pos.y - 1 - 3 * l
					
					change_level_down = false
					change_level_up = false
					for i, v in ipairs(updowns) do
						if v.x == x and v.y == y and v.l == l then 
							change_level_down = true
							-- find direction for the ladders
							ladder_direction = 2
							if maze[l][x - 1][y] and maze[l + 1][x - 1][y] then ladder_direction = 3 end
							if maze[l][x + 1][y] and maze[l + 1][x + 1][y] then ladder_direction = 2 end
							if maze[l][x][y - 1] and maze[l + 1][x][y - 1] then ladder_direction = 5 end
							if maze[l][x][y + 1] and maze[l + 1][x][y + 1] then ladder_direction = 4 end
						end
						if v.x == x and v.y == y and v.l == l - 1 then
							change_level_up = true
							-- find direction for the ladders
							ladder_direction = 2
							-- if maze[l - 1][x - 1][y] and maze[l][x - 1][y] then ladder_direction = 3 end
							-- if maze[l - 1][x + 1][y] and maze[l][x + 1][y] then ladder_direction = 2 end
							-- if maze[l - 1][x][y - 1] and maze[l][x][y - 1] then ladder_direction = 5 end
							-- if maze[l - 1][x][y + 1] and maze[l][x][y + 1] then ladder_direction = 4 end
							if maze[l][x - 1][y] then ladder_direction = 3 end
							if maze[l][x + 1][y] then ladder_direction = 2 end
							if maze[l][x][y - 1] then ladder_direction = 5 end
							if maze[l][x][y + 1] then ladder_direction = 4 end
						end
					end
					-- rotate direction for the ladders
					if cosine == -1 then
						if ladder_direction == 2 then ladder_direction = 3
						elseif ladder_direction == 3 then ladder_direction = 2
						elseif ladder_direction == 4 then ladder_direction = 5
						elseif ladder_direction == 5 then ladder_direction = 4 end
					end
					if sine == -1 then
						if ladder_direction == 2 then ladder_direction = 5
						elseif ladder_direction == 3 then ladder_direction = 4
						elseif ladder_direction == 4 then ladder_direction = 2
						elseif ladder_direction == 5 then ladder_direction = 3 end
					end
					if sine == 1 then
						if ladder_direction == 2 then ladder_direction = 4
						elseif ladder_direction == 3 then ladder_direction = 5
						elseif ladder_direction == 4 then ladder_direction = 3
						elseif ladder_direction == 5 then ladder_direction = 2 end
					end
					if not change_level_down then 
					-- if change_level_down then 
						-- minetest.env:add_node(pos, {type = "node", name = "air"})
						-- minetest.env:add_node(pos, {type = "node", name = "default:ladder", param2 = ladder_direction})
					-- else
						minetest.env:add_node(pos, {type = "node", name = material_floor})
					end
					if maze[l][x][y] then 
						line = "X" .. line
						pos.y = pos.y + 1
						minetest.env:add_node(pos, {type = "node", name = material_wall})
						pos.y = pos.y + 1
						minetest.env:add_node(pos, {type = "node", name = material_wall})
					else
						line = " " .. line
						pos.y = pos.y + 1
						minetest.env:add_node(pos, {type = "node", name = "air"})
						-- if change_level_down then minetest.env:add_node(pos, {type = "node", name = "default:ladder", param2 = ladder_direction}) end
						if change_level_up then minetest.env:add_node(pos, {type = "node", name = "default:ladder", param2 = ladder_direction}) end
						pos.y = pos.y + 1
						minetest.env:add_node(pos, {type = "node", name = "air"})
						if change_level_up then minetest.env:add_node(pos, {type = "node", name = "default:ladder", param2 = ladder_direction}) end
					end
					pos.y = pos.y + 1
					if change_level_up then 
						minetest.env:add_node(pos, {type = "node", name = "air"})
						minetest.env:add_node(pos, {type = "node", name = "default:ladder", param2 = ladder_direction})
					else
						minetest.env:add_node(pos, {type = "node", name = material_ceiling})
					end
				end
				if l==exit_l and y==exit_y then line = "<-" .. line else line = "  " .. line end
				print(line)
			end
		end
		-- print("playerdir: (" .. player_dir.x .. ", " .. player_dir.y .. ", " .. player_dir.z .. ")")
		-- print("playerpos: (" .. player_pos.x .. ", " .. player_pos.y .. ", " .. player_pos.z .. ")")
	end,
})