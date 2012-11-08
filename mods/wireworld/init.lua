
minetest.register_node("wireworld:conductor", {
	description = "Conductor",
	tiles = {"wireworld_conductor.png"},
	inventory_image = "wireworld_conductor.png",
	wield_image = "wireworld_conductor.png",
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	selection_box = {
		type = "wallmounted"
	},
	groups = {dig_immediate=3},
})

minetest.register_node("wireworld:electron_head", {
	description = "Electron Head",
	tiles = {"wireworld_electron_head.png"},
	inventory_image = "wireworld_electron_head.png",
	wield_image = "wireworld_electron_head.png",
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	selection_box = {
		type = "wallmounted"
	},
	groups = {dig_immediate=3, electron=1},
})

minetest.register_node("wireworld:electron_tail", {
	description = "Electron Tail",
	tiles = {"wireworld_electron_tail.png"},
	inventory_image = "wireworld_electron_tail.png",
	wield_image = "wireworld_electron_tail.png",
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	selection_box = {
		type = "wallmounted"
	},
	groups = {dig_immediate=3, electron=1},
})

local run = true

local function mark(pos)
	local meta = minetest.env:get_meta(pos)
	meta:set_string("wireworld_marked", "true")
	minetest.after(0.5, function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("wireworld_marked", "false")
	end, pos)
end

local function marked(pos)
	local meta = minetest.env:get_meta(pos)
	return meta:get_string("wireworld_marked")=="true"
end

local function turn_conductor(pos, param2)
	local count = 0
	local minp = {x=pos.x-1, y=pos.y, z=pos.z-1}
	local maxp = {x=pos.x+1, y=pos.y, z=pos.z+1}
	for x=minp.x,maxp.x do
	for y=minp.y,maxp.y do
	for z=minp.z,maxp.z do
		local p = {x=x, y=y, z=z}
		if minetest.env:get_node(p).name == "wireworld:electron_head" then
			if not marked(p) then
				count = count+1
			end
		end
	end
	end
	end
	
	if count>0 and count<3 then
		minetest.env:set_node(pos, {name="wireworld:electron_head", param2=param2})
		mark(pos)
	elseif count>0 then
		for x=minp.x,maxp.x do
		for y=minp.y,maxp.y do
		for z=minp.z,maxp.z do
			local p = {x=x, y=y, z=z}
			if minetest.env:get_node(p).name == "wireworld:electron_head" then
				if not marked(p) then
					local param2 = minetest.env:get_node(p).param2
					minetest.env:set_node(p, {name="wireworld:electron_tail", param2=param2})
					mark(p)
				end
			end
		end
		end
		end
	end
end

minetest.register_abm({
	nodenames = {"group:electron"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if not run then
			return
		end
		if node.name == "wireworld:electron_head" then
			if marked(pos) then
				return
			end
			
			local minp = {x=pos.x-1, y=pos.y, z=pos.z-1}
			local maxp = {x=pos.x+1, y=pos.y, z=pos.z+1}
			for x=minp.x,maxp.x do
			for y=minp.y,maxp.y do
			for z=minp.z,maxp.z do
				local p = {x=x, y=y, z=z}
				if minetest.env:get_node(p).name == "wireworld:conductor" then
					if not marked(p) then
						turn_conductor(p, minetest.env:get_node(pos).param2)
					end
				end
			end
			end
			end
			
			minetest.env:set_node(pos, {name="wireworld:electron_tail", param2=node.param2})
			mark(pos)
		elseif node.name == "wireworld:electron_tail" then
			if marked(pos) then
				return
			end
			minetest.env:set_node(pos, {name="wireworld:conductor", param2=node.param2})
			mark(pos)
		end
	end,
})

minetest.register_chatcommand("wireworld", {
	params = "<on/off>",
	description = "Turn wireworld on and off",
	func = function(name, param)
		if run then
			if param == "on" then
				minetest.chat_send_player(name, "Wireworld is already on")
			elseif param == "off" then
				run = false
				minetest.chat_send_player(name, "Wireworld stopped")
			else
				minetest.chat_send_player(name, "Illegal param; use \"on\" or \"off\"")
			end
		else
			if param == "on" then
				run = true
				minetest.chat_send_player(name, "Wireworld started")
			elseif param == "off" then
				minetest.chat_send_player(name, "Wireworld is already off")
			else
				minetest.chat_send_player(name, "Illegal param; use \"on\" or \"off\"")
			end
		end
	end,
})
