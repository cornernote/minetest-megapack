local version = "0.0.2"

local growing_trees_modpath = minetest.get_modpath("growing_trees")

dofile (growing_trees_modpath .. "/trunk_functions.lua")
dofile (growing_trees_modpath .. "/branch_functions.lua")
dofile (growing_trees_modpath .. "/generic_functions.lua")

minetest.register_node("growing_trees:sprout", {
	description = "Trunk-Sprout (growing_trees)",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_leaves.png"},
	paramtype = "light",
	groups = {snappy=3},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'growing_trees:sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("growing_trees:leaves", {
	description = "Leaves (growing_trees)",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_leaves.png"},
	paramtype = "light",
	groups = {snappy=3},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'growing_trees:sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("growing_trees:branch_sprout", {
	description = "Leaves-Sprout (growing_trees)",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_leaves.png"},
	paramtype = "light",
	groups = {snappy=3},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'growing_trees:sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("growing_trees:trunk", {
	description = "Trunk (growing_trees)",
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
	drop =  "default:tree"
})


minetest.register_node("growing_trees:branch", {
	description = "Branch (growing_trees)",
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=1},
	sounds = default.node_sound_wood_defaults(),
	drop =  "default:tree"
})


minetest.register_craftitem("growing_trees:sapling", {
		description = "Sapling (growing tree mod)",
		image = "default_sapling.png",
		on_place = function(item,place,pointed_thing)
			if pointed_thing.type == "node" then
				local pos = pointed_thing.above
				local pos_above = {x=pos.x,y=pos.y+1,z=pos.z}
				local node = minetest.env:get_node(pos)
				local node_above = minetest.env:get_node(pos_above)

				if node.name == "air" and
					node_above.name == "air" then
					local pos_bottom = { x=pos.x,y=pos.y-1,z=pos.z }
		
					local bottom_node = minetest.env:get_node(pos_bottom)

					if bottom_node.name == "default:dirt" or
						 bottom_node.name == "default:dirt_with_grass" then

						minetest.env:add_node(pos,{type=node,name="growing_trees:trunk"})
						minetest.env:add_node(pos_above,{type=node,name="growing_trees:sprout"})
						item:take_item(1)
					end
				end
			end

			return item
		end
	})


minetest.register_craft({
	output = "growing_trees:sapling",
	recipe = {
		{"default:sapling"},
		{"default:sapling"},
	}
})

minetest.register_abm({
		nodenames = { "growing_trees:sprout" },
		interval = 10,
		chance = 5,
		action = function(pos, node, active_object_count, active_object_count_wider)

			--print("Sprout abm called " .. os.time(os.date('*t')));
			
			local trunktop = growing_trees_get_trunk_below(pos)
			
			if trunktop == nil then
				print("ERROR sprout not ontop of tree")
				return
			end
			
			local treesize = growing_trees_get_tree_size(trunktop)
			
			--print("Treesize: " .. treesize)
			
			--reduce growing speed for trees larger then 10
			if (treesize > 10 ) then
				if math.random() > 1/treesize then
					return
				end
			end
			

			local grown = false

			if math.random() > 0.2 then
				--print("growing straight")
				local pos_above = {x= pos.x,y=pos.y+1,z=pos.z}
				
				local node_above = minetest.env:get_node(pos_above)
				
				if node_above.name == "air" or
					node_above.name == "growing_trees:leaves" then
					
					minetest.env:remove_node(pos)
					minetest.env:add_node(pos,{type=node,name="growing_trees:trunk"})
					minetest.env:add_node(pos_above,{type=node,name="growing_trees:sprout"})
				
					grown = true
				end
			end
			
			if not grown then
				if growing_trees_next_to(pos,"growing_trees:trunk") == false then
					--print("growing horizontaly")
					--decide which direction to grow trunk
					local pos_to_grow_to = growing_trees_get_random_next_to(pos)
	
					--check if pos is feasable
					--TODO
					
					minetest.env:remove_node(pos)
					minetest.env:add_node(pos,{type=node,name="growing_trees:trunk"})
					
					minetest.env:add_node(pos_to_grow_to,{type=node,name="growing_trees:sprout"})
					
					grown = true
				else
					print("Not growing horizontaly twice")
				end
			end

		end
	})
	
	
minetest.register_abm({
		nodenames = { "growing_trees:trunk" },
		interval = 10,
		chance = 5,
		
		action = function(pos, node, active_object_count, active_object_count_wider)
			
				--print("Add branch sprout abm called")
			
				local treesize = growing_trees_get_tree_size(pos)
				
				--don't add branches to trees to small
				if treesize < 5 then
					return
				end
				
				local growpos = growing_trees_get_random_next_to(pos)
				
				if growing_trees_is_tree_structure(growpos) == false then
				
					local distance = growing_trees_min_distance(growpos)
					
					--print("branch sprout add function, distance to ground: " .. distance)
					
					if distance > 2 and
						growing_trees_next_to_branch(growpos,nil) == false then
						minetest.env:remove_node(growpos)
						minetest.env:add_node(growpos,{type=node,name="growing_trees:branch_sprout"})
					end
				
				end
		end
	})
	
minetest.register_abm({
		nodenames = { "growing_trees:branch_sprout" },
		interval = 10,
		chance = 5,
		
		action = function(pos, node, active_object_count, active_object_count_wider)
		
			--print("Add branch abm called")
			--TODO add chance to grow up
			local growpos = growing_trees_get_brach_growpos(pos)
			local node_at_pos = minetest.env:get_node(growpos)
			
			if 	growing_trees_is_tree_structure(growpos) == false and
				growing_trees_next_to_branch(growpos,pos) == false then
			
				
				--print("valid growing pos found:" .. printpos(growpos) .. " -> " .. node_at_pos.name )
				
				local branch = {}
			
				local distance_from_trunk,treesize = growing_trees_get_distance_from_trunk(pos,branch)
				
				--print ("Treesize: " .. treesize .. " Distance: " .. distance_from_trunk)
				
				if treesize ~= 0 and
					distance_from_trunk < treesize/4 then
					minetest.env:remove_node(pos)
					minetest.env:add_node(pos,{type=node,name="growing_trees:branch"})
					minetest.env:remove_node(growpos)
					minetest.env:add_node(growpos,{type=node,name="growing_trees:branch_sprout"})
				end
			else
				print("Position invalid to grow branch to")
			end
		end
		})
		
minetest.register_abm({
		nodenames = { "growing_trees:branch" },
		interval = 10,
		chance = 5,
		
		action = function(pos, node, active_object_count, active_object_count_wider)
				
				growing_trees_grow_leaves(pos)
		
			end
			
		})
		
minetest.register_abm({
		nodenames = { "growing_trees:leaves" },
		interval = 10,
		chance = 5,
		
		action = function(pos, node, active_object_count, active_object_count_wider)
		
				if math.random() < 0.3 then	
					minetest.env:remove_node(pos)
				end
			end
			
		})
		
minetest.register_abm({
		nodenames = { "growing_trees:sprout" },
		interval = 10,
		chance = 5,
		action = function(pos, node, active_object_count, active_object_count_wider)
			 growing_trees_grow_sprout_leaves(pos)
		end
		})

print("growing_trees mod " .. version .. " loaded")