minetest.register_chatcommand("maze", {
	params = "<size_x> <size_y> <material_floor> <material_wall> <material_ceiling>",
	description = "Create a maze near your position",
	-- privs = {},
	func = function(name, param)
		local player_pos = minetest.env:get_player_by_name(name):getpos()
		local found, _, maze_size_x_st, maze_size_y_st, material_floor, material_wall, material_ceiling = param:find("(%d+)%s+(%d+)%s+([^%s]+)%s+([^%s]+)%s+([^%s]+)")
		local min_size = 20
		local maze_size_x = tonumber(maze_size_x_st)
		local maze_size_y = tonumber(maze_size_y_st)
		if maze_size_x == nil then maze_size_x = min_size end
		if maze_size_y == nil then maze_size_y = min_size end
		if maze_size_x < min_size then maze_size_x = min_size end
		if maze_size_y < min_size then maze_size_y = min_size end
		if material_floor == nil then material_floor = "default:cobble" end
		-- if material_floor == nil then material_floor = "default:stone" end
		if material_wall == nil then material_wall = "default:cobble" end
		if material_ceiling == nil then material_ceiling = "default:cobble" end
		-- if material_ceiling == nil then material_ceiling = "air" end
		
		minetest.chat_send_player(name, "Try to build "..maze_size_x.." * "..maze_size_y.." maze.  F:"..material_floor.." W:"..material_wall.." C:"..material_ceiling)

		local maze = {}
		for x=0, maze_size_x-1, 1 do
			maze[x] = {}
			for y=0, maze_size_y-1, 1 do
				maze[x][y] = true -- everything walls
			end
		end

-- create maze map
		local start_x = 0
		local start_y = math.floor(maze_size_y/2)
		local pos_x = start_x
		local pos_y = start_y
		maze[pos_x][pos_y] = false -- the entrance
		local moves = {}
		local possible_ways = {}
		local direction = ''
		local pos = {x=0, y=0}
		table.insert(moves, {x=pos_x, y=pos_y})
		-- print(#moves.." "..moves[1].x.." "..moves[1].y)
		repeat
			possible_ways = {}
			-- is N possible?
			if (
				((pos_y-2) >= 0) and ((pos_x-1) >= 0) and ((pos_x+1) < maze_size_x) and 
				(maze[pos_x][pos_y-1]) and -- N is wall
				(maze[pos_x][pos_y-2]) and -- N from N is wall
				(maze[pos_x-1][pos_y-2]) and -- NW from N is wall
				(maze[pos_x+1][pos_y-2]) and -- NE from N is wall
				(maze[pos_x-1][pos_y-1]) and -- W from N is wall
				(maze[pos_x+1][pos_y-1]) -- E from N is wall
			) then
				table.insert(possible_ways, 'N')
			end
			-- is E possible?
			if (
				((pos_x+2) < maze_size_x) and ((pos_y-1) >= 0) and ((pos_y+1) < maze_size_y) and 
				(maze[pos_x+1][pos_y]) and -- E is wall
				(maze[pos_x+2][pos_y]) and -- E from E is wall
				(maze[pos_x+2][pos_y-1]) and -- NE from E is wall
				(maze[pos_x+2][pos_y+1]) and -- SE from E is wall
				(maze[pos_x+1][pos_y-1]) and -- N from E is wall
				(maze[pos_x+1][pos_y+1]) -- S from E is wall
			) then
				table.insert(possible_ways, 'E')
			end
			-- is S possible?
			if (
				((pos_y+2) < maze_size_y) and ((pos_x-1) >= 0) and ((pos_x+1) < maze_size_x) and 
				(maze[pos_x][pos_y+1]) and -- S is wall
				(maze[pos_x][pos_y+2]) and -- S from S is wall
				(maze[pos_x-1][pos_y+2]) and -- SW from S is wall
				(maze[pos_x+1][pos_y+2]) and -- SE from S is wall
				(maze[pos_x-1][pos_y+1]) and -- W from S is wall
				(maze[pos_x+1][pos_y+1]) -- E from S is wall
			) then
				table.insert(possible_ways, 'S')
			end
			-- is W possible?
			if (
				((pos_x-2) >= 0) and ((pos_y-1) >= 0) and ((pos_y+1) < maze_size_y) and 
				(maze[pos_x-1][pos_y]) and -- W is wall
				(maze[pos_x-2][pos_y]) and -- W from W is wall
				(maze[pos_x-2][pos_y-1]) and -- NW from W is wall
				(maze[pos_x-2][pos_y+1]) and -- SW from W is wall
				(maze[pos_x-1][pos_y-1]) and -- N from W is wall
				(maze[pos_x-1][pos_y+1]) -- S from W is wall
			) then
				table.insert(possible_ways, 'W')
			end
			if #possible_ways>0 then
				direction = possible_ways[math.random(# possible_ways)]
				if direction == 'N' then 
					pos_y = pos_y - 1
				elseif direction == 'E' then 
					pos_x = pos_x + 1
				elseif direction == 'S' then 
					pos_y = pos_y + 1
				elseif direction == 'W' then 
					pos_x = pos_x - 1
				end
				table.insert(moves, {x=pos_x, y=pos_y})
				maze[pos_x][pos_y] = false
				-- print(# possible_ways.." "..direction)
			else
				pos = table.remove(moves)
				pos_x = pos.x
				pos_y = pos.y
				-- print("get back to "..pos_x.." / "..pos_y.." to find another way from there")
			end
		until ((pos_x == start_x) and (pos_y == start_y))
-- create exit on opposite end of maze and make sure it is reachable
		pos_x = maze_size_x-1
		pos_y = maze_size_y-2
		while maze[pos_x][pos_y] do
			maze[pos_x][pos_y] = false
			pos_x = pos_x - 1
		end

-- create big room in the maze: commented out, looks strange...
		-- local room_size_x = 3
		-- local room_size_y = 3
		-- start_x = math.random(maze_size_x-(2+room_size_x))
		-- start_y = math.random(maze_size_y-(2+room_size_y))
		-- for y=start_y, start_y+5, 1 do
			-- for x=start_x, start_x+5, 1 do
				-- maze[x][y] = false
			-- end
		-- end

		
-- get transform factors to place the maze in "look_dir" of player
		local player_dir=minetest.env:get_player_by_name(name):get_look_dir()
		local cosinus = 1
		local sinus = 0
		if math.abs(player_dir.x) > math.abs(player_dir.z) then 
			if player_dir.x > 0 then 
				cosinus = 1
				sinus = 0
			else
				cosinus = -1
				sinus = 0
			end
		else
			if player_dir.z < 0 then 
				cosinus = 0
				sinus = -1
			else
				cosinus = 0
				sinus = 1
			end
		end
		-- print (cosinus.." "..sinus)

-- build maze in minetest-world
		local offset_x = 1
		local offset_y = 1
		local line = ""
		local pos = {x=0, y=0, z=0}
		for y=0, maze_size_y-1, 1 do
			if y==math.floor(maze_size_y/2) then line = "<-" else line = "  " end
			for x=0, maze_size_x-1, 1 do
				pos.x = cosinus * (x+2) - sinus * (y-math.floor(maze_size_y/2)) + player_pos.x
				pos.z = sinus * (x+2) + cosinus * (y-math.floor(maze_size_y/2)) + player_pos.z
				pos.y = player_pos.y - 1
				minetest.env:add_node(pos,{type="node",name=material_floor})
				if maze[x][y] then 
					line = "X"..line
					pos.y = player_pos.y
					minetest.env:add_node(pos,{type="node",name=material_wall})
					pos.y = player_pos.y + 1
					minetest.env:add_node(pos,{type="node",name=material_wall})
				else
					line = " "..line
					pos.y = player_pos.y
					minetest.env:add_node(pos,{type="node",name="air"})
					pos.y = player_pos.y + 1
					minetest.env:add_node(pos,{type="node",name="air"})
				end
				pos.y = player_pos.y + 2
				minetest.env:add_node(pos,{type="node",name=material_ceiling})
			end
			if y==maze_size_y-2 then line = "<-"..line else line = "  "..line end
			print(line)
		end

		-- print("playerdir: ("..player_dir.x..", "..player_dir.y..", "..player_dir.z..")")
		-- print("playerpos: ("..player_pos.x..", "..player_pos.y..", "..player_pos.z..")")
	end,
})