timber_nodenames={"default:jungletree", "default:papyrus", "default:cactus", "default:tree", "conifers:trunk"}
leaf_nodenames = {"default:leaves", "default:apple", "conifers:leaves"}

minetest.register_on_dignode(function(pos, node, player)
	local i=1
	while timber_nodenames[i]~=nil do
		if node.name==timber_nodenames[i] then
			np={x=pos.x, y=pos.y+1, z=pos.z}
			while minetest.env:get_node(np).name==timber_nodenames[i] do
				minetest.env:remove_node(np)
				local timber_item = minetest.env:add_item(np, timber_nodenames[i])
				timber_item:get_luaentity().dug_by = player:get_player_name()
				np={x=np.x, y=np.y+1, z=np.z}

				local leafpos = minetest.env:find_node_near(np,3,leaf_nodenames)
				while leafpos ~=nil do
					local name = minetest.env:get_node(leafpos).name

					-- Drop stuff other than the node itself
					itemstacks = minetest.get_node_drops(name)
					for _, itemname in ipairs(itemstacks) do
						minetest.env:remove_node(leafpos)
						local leaf_item = minetest.env:add_item(leafpos, itemname)
						leaf_item:get_luaentity().dug_by = player:get_player_name()
					end
					leafpos = minetest.env:find_node_near(np,3,leaf_nodenames)

				end
			end
		end
		i=i+1
	end
end)
