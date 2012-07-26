local HOUSE_SPAWN_INTERVAL = 600
local HOUSE_SPAWN_CHANCE = 10

local STRUCTURES_FILE = minetest.get_modpath("livehouse")
    .. "/structures.txt"
local HOUSE_CONFIG_SEPARATOR = " "

dofile (minetest.get_modpath("livehouse") .. "/kit.lua")
dofile (minetest.get_modpath("livehouse") .. "/split.lua")

local structure_count = 0
for line in io.lines(STRUCTURES_FILE) do
    if line:sub(1, 1) == "#" then
	structure_count = structure_count + 1
    end
end
print(structure_count .. " structures loaded.")


minetest.register_abm({
    nodenames = "livehouse:kit",
    interval = HOUSE_SPAWN_INTERVAL,
    chance = HOUSE_SPAWN_CHANCE,

    action = function(pos, _, _, _)
	minetest.env:remove_node(pos)
	local house_number = math.random(1, structure_count)
	local counter = 0
	for line in io.lines(STRUCTURES_FILE) do
	    if line:sub(1, 1) == "#" then
		counter = counter + 1
	    else
		if counter == house_number and line:sub(1, 1) ~= ";" then
		    local params = split(line, HOUSE_CONFIG_SEPARATOR)
		    local new_pos = {
			x = pos.x + params[1],
			y = pos.y + params[2],
			z = pos.z + params[3],
		    }
		    local node_name = params[4]
		    minetest.env:remove_node(new_pos)
		    minetest.env:add_node(new_pos, { name = node_name })
		    minetest.log("action", "Spawned " .. node_name
			.. " at " .. new_pos.x .. "," .. new_pos.y
			.. "," .. new_pos.z)
		end
	    end
	end
    end
})
