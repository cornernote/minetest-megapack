

-------------------------------------------------------------------------------
-- name: farming_add_hoe_type(value)
--
-- action: add hoe type
--
-- param1: name of base node
-- retval: -
-------------------------------------------------------------------------------
function farming_add_hoe_type(value)
	--print("Adding "..value[2].." hoe with durability "..value[3])

	minetest.register_craft({
		output = 'tool "farming:'..value[2]..'_hoe"',
		recipe = {
			{'node "'..value[1]..":"..value[2]..'"', 'node "'..value[1]..":"..value[2]..'"'},
			{'', 'craft "default:stick"'},
			{'', 'craft "default:stick"'},
		}
	})


	minetest.register_tool("farming:"..value[2].."_hoe", {
		image = "farming_"..value[2].."hoe.png",
		basetime = 300.0,
		dt_weight = 0.2,
		dt_crackiness = 0.2,
		dt_crumbliness = 0.2,
		dt_cuttability = 0.2,
		basedurability = value[3],
		dd_weight = -5,
		dd_crackiness = -5,
		dd_crumbliness = -5,
		dd_cuttability = -5,
	})
end

-------------------------------------------------------------------------------
-- name: is_hoe(toolname)
--
-- action: return true if tool is a hoe
--
-- param1: name to check
-- retval: -
-------------------------------------------------------------------------------
function is_hoe(toolname)

	for index,value in ipairs(tool_types) do 
	
		if toolname == "farming:"..value[2].."_hoe" then
			return value[3]
		end
	end

	return false
end
