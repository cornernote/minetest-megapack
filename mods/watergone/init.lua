minetest.register_node("watergone:remover", 
	{
		description = "Water Remover",
		tiles = {"watergone_remover_top.png", "watergone_remover_bottom.png",
						"watergone_remover_side.png", "watergone_remover_side.png",
						"watergone_remover_side.png", "watergone_remover_side.png"},
		inventory_image = minetest.inventorycube("watergone_remover_top.png",
													"watergone_remover_side.png",
													"watergone_remover_side.png"),
		groups = {oddly_breakable_by_hand=3},		
	}
)

minetest.register_node("watergone:lavaremover",
	{
		description = "Lava Remover",
		tiles = {"watergone_lavaremover_top.png", "watergone_lavaremover_bottom.png",
						"watergone_lavaremover_side.png", "watergone_lavaremover_side.png",
						"watergone_lavaremover_side.png", "watergone_lavaremover_side.png"},
		inventory_image = minetest.inventorycube("watergone_lavaremover_top.png",
													"watergone_lavaremover_side.png",
													"watergone_lavaremover_side.png"),
		groups = {oddly_breakable_by_hand=3},
	}
)

minetest.register_craft(
	{
		output = 'node "watergone:remover" 5',
		recipe = {
			{'', 'default:sand', ''},
			{'default:wood', 'default:dirt', 'default:wood'},
			{'', 'default:wood', ''}
		}
	}
)

minetest.register_craft(
	{
		output = 'node "watergone:lavaremover" 5',
		recipe = {
			{'', 'default:gravel', ''},
			{'default:coal_lump', 'default:steelblock', 'default:coal_lump'},
			{'default:coal_lump', 'default:coal_lump', 'default:coal_lump'}
		}
	}
)

function recurse_removewaternodes(pos, water_blocks, max_blocks)
if water_blocks <= max_blocks then
	water_blocks = water_blocks + 1
	local CubeRange = 1		--Used for nearby solid border detection. Generally, don't change this unless you're just playing around.
	for Y=CubeRange,-CubeRange,-1 do
		for X=CubeRange,-CubeRange,-1 do
			for Z=CubeRange,-CubeRange,-1 do
				if (X*X + Y*Y + Z*Z) <= CubeRange*CubeRange then				
					local LPos = {x=pos.x+X, y=pos.y+Y, z=pos.z+Z}
					local LNode = minetest.env:get_node(LPos)
					if LNode.name == "default:water_source" or LNode.name == "default:water_flowing" then
						minetest.env:remove_node(LPos)
						recurse_removewaternodes(LPos, water_blocks, max_blocks)
					end				
				end
			end
		end
	end
end
return water_blocks
end

function recurse_removelavanodes(pos, lava_blocks, max_blocks)
if lava_blocks <= max_blocks then
	lava_blocks = lava_blocks + 1
	local CubeRange = 1		--Used for nearby solid border detection. Generally, don't change this unless you're just playing around.
	for Y=CubeRange,-CubeRange,-1 do
		for X=CubeRange,-CubeRange,-1 do
			for Z=CubeRange,-CubeRange,-1 do
				if (X*X + Y*Y + Z*Z) <= CubeRange*CubeRange then				
					local LPos = {x=pos.x+X, y=pos.y+Y, z=pos.z+Z}
					local LNode = minetest.env:get_node(LPos)
					if LNode.name == "default:lava_source" or LNode.name == "default:lava_flowing" then
						minetest.env:remove_node(LPos)
						recurse_removelavanodes(LPos, lava_blocks, max_blocks)
					end				
				end
			end
		end
	end
end
return water_blocks
end
minetest.register_on_punchnode(function(pos, node, hitter)
	if node.name == "watergone:remover" then
		local max_blocks = 5000		--Estimate on the number of blocks in any direction you want cleared out in open environments.
		local water_blocks = 0
		minetest.env:remove_node(pos)
		recurse_removewaternodes(pos, water_blocks, max_blocks)
	end
	
		if node.name == "watergone:lavaremover" then
		local max_blocks = 5000		--Estimate on the number of blocks in any direction you want cleared out in open environments.
		local lava_blocks = 0
		minetest.env:remove_node(pos)
		recurse_removelavanodes(pos, lava_blocks, max_blocks)
	end
end)