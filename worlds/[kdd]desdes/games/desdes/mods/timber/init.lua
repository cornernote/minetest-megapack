timber_nodenames={"default:jungletree", "default:papyrus", "default:cactus", "default:tree","default:leaves"}

minetest.register_on_dignode(function(pos, node, digger)
	local i=1
	while timber_nodenames[i]~=nil do
		if node.name==timber_nodenames[i] then
			np={x=pos.x, y=pos.y+1, z=pos.z}
			while minetest.env:get_node(np).name==timber_nodenames[i] do
				minetest.env:remove_node(np)
				digger:get_inventory():add_item('main', timber_nodenames[i])
				np={x=np.x, y=np.y+1, z=np.z}
			end
		end
		i=i+1
	end
end)
