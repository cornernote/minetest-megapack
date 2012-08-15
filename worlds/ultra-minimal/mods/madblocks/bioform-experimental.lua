-- ***********************************************************************************
--		BIOFORMER							**************************************************
-- ***********************************************************************************

BIOFORM = nil
minetest.register_chatcommand("bioform", {
	params = "<biome>",
	description = "transform",
	privs = {server=true},
	func = function(name, param)
		if param == 'beach' or param == 'tallforest' then
		 BIOFORM = param 
		end
		minetest.chat_send_player(name, "bioforming to "..param)
		return
	end,
})
minetest.register_abm({
		nodenames = { "default:leaves","default:tree",'default:dirt_with_grass','default:sand' },
		interval = 20,
		chance = 2,
		action = function(pos, node, active_object_count, active_object_count_wider)
			if BIOFORM == 'beach' then
				if node.name == 'default:tree' or node.name == 'default:leaves' then minetest.env:remove_node(pos)
				elseif node.name == 'default:dirt_with_grass' then minetest.env:add_node(pos,{type="node",name='default:sand'})
				elseif node.name == 'default:sand' then 
					local air = { x=pos.x, y=pos.y+1,z=pos.z }
					local is_air = minetest.env:get_node_or_nil(air)
					if is_air ~= nil and is_air.name == 'air' and math.random(1,1000) == 1 then
						minetest.env:add_node(air,{type="node",name='madblocks:palmtree'})
					end
				end
			elseif BIOFORM == 'tallforest' then
				if node.name == 'default:tree' then 
					local air = { x=pos.x, y=pos.y+1,z=pos.z }
					local is_air = minetest.env:get_node_or_nil(air)
					if is_air == nil then return end
					if is_air.name == 'air' or is_air.name == 'default:leaves' then
						minetest.env:add_node(air,{type="node",name='default:sapling'})
					end
				end
			end
		end
})

