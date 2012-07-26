-- gates
-- By Splizard
-- Forum post: http://c55.me/minetest/forum/viewtopic.php?id=896 

-- Quick documentation about the API
-- =================================:
--
-- Create new gate:
--
-- gates.register_node(yourmod:gate, {
--     #shared node options go here
--
--	   description = "A Gate",
--     groups = {choppy=2,dig_immediate=2},
--     drop = "yourmod:gate", #Without this you can pick up open gates
--
-- },
-- {
--     #open gate options go here
--
--     tiles = {'open_gate.png'}, 
--	   walkable = false,
--     drawtype = "plantlike",
-- },
-- {
--     #closed gate options go here
--
--     tiles = {'closed_gate_top.png','closed_gate_bottom.png','closed_gate_sides.png'}, 
--	   walkable = true,
-- },
-- }, "on_punch") #The mode to switch the gate eg. on_punch, on_mesecon_signal, on_whatever
--
--
--	If you want to switch the gate with another callback, use:
--  gates.toggle(pos, node, player, mode) #Same mode that you used to register the node
--

-- Definitions made by this mod that other mods can use too
gates = {}
gates.registered_nodes = {}
gates.registered_nodes["on_punch"] = {}
gates.registered_nodes["on_mesecon"] = {}


--
-- Api functions
--
gates.register_node = function(name, shared, open, closed, mode)
	if name ~= nil then
		if mode == nil then mode = "on_punch" end
		
		--Creates two nodes, open and closed node
		for i,v in pairs(shared) do open[i] = v end
		minetest.register_node(name.."_open", open)
		
		for i,v in pairs(shared) do closed[i] = v end
		minetest.register_node(name, closed)
		
		--Index nodes
		gates.registered_nodes[mode][name] = name.."_open"
		gates.registered_nodes[mode][name.."_open"] = name
	else
		minetest.log(LOGLEVEL_ERROR,"GATES: in function \"gates.register_node\": missing node name!")
	end
end

local gate_punched = function(pos, node, puncher)
	if gates.registered_nodes["on_punch"][node.name] ~= nil then
		
		if node.param2 then
			local playerpos = puncher:getpos()
			local dir = {x = pos.x - playerpos.x, y = pos.y - playerpos.y, z = pos.z - playerpos.z}
			local param = minetest.dir_to_facedir(dir)
			if node.param2 == 0 and param == 2 then node.param2 = 2 end
			if node.param2 == 2 and param == 0 then node.param2 = 0 end
			if node.param2 == 1 and param == 3 then node.param2 = 3 end
			if node.param2 == 3 and param == 1 then node.param2 = 1 end
		end
	
		minetest.env:add_node(pos, {
			name = gates.registered_nodes["on_punch"][node.name],
			param2 = node.param2
		})
		
		 --handle gates above this one
		local lpos = pos
		while true do
			lpos.y = lpos.y + 1
			local lnode = minetest.env:get_node(lpos)
			if gates.registered_nodes["on_punch"][lnode.name] ~= nil then
				minetest.env:add_node(pos, {
					name = gates.registered_nodes["on_punch"][node.name],
					param2 = node.param2
				})
			else break
			end
		end
		
		 --handle gates below this one
		local lpos = pos
		while true do
			lpos.y = lpos.y - 1
			local lnode = minetest.env:get_node(lpos)
			if gates.registered_nodes["on_punch"][lnode.name] ~= nil then
				minetest.env:add_node(pos, {
					name = gates.registered_nodes["on_punch"][node.name],
					param2 = node.param2
				})
			else break
			end
		end
		
	end
end

gates.toggle = function(pos, node, puncher, mode)
	if gates.registered_nodes[mode][node.name] ~= nil then
	
		if node.param2 then
			local playerpos = puncher:getpos()
			local dir = {x = pos.x - playerpos.x, y = pos.y - playerpos.y, z = pos.z - playerpos.z}
			local param = minetest.dir_to_facedir(dir)
			if node.param2 == 0 and param == 2 then node.param2 = 2 end
			if node.param2 == 2 and param == 0 then node.param2 = 0 end
			if node.param2 == 1 and param == 3 then node.param2 = 3 end
			if node.param2 == 3 and param == 1 then node.param2 = 1 end
		end
	
		minetest.env:add_node(pos, {
			name = gates.registered_nodes[mode][node.name],
			param2 = node.param2
		})
				
		--handle gates above this one
		local lpos = pos
		while true do
			lpos.y = lpos.y + 1
			local lnode = minetest.env:get_node(lpos)
			if gates.registered_nodes[mode][lnode.name] ~= nil then
				minetest.env:add_node(pos, {
					name = gates.registered_nodes[mode][node.name],
					param2 = node.param2
				})
			else break
			end
		end
		
		 --handle gates below this one
		local lpos = pos
		while true do
			lpos.y = lpos.y - 1
			local lnode = minetest.env:get_node(lpos)
			if gates.registered_nodes[mode][lnode.name] ~= nil then
				minetest.env:add_node(pos, {
					name = gates.registered_nodes[mode][node.name],
					param2 = node.param2
				})
			else break
			end
		end
	end
end

-- Change the gate state
minetest.register_on_punchnode(gate_punched)
