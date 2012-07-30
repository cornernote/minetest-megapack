function item_drop(pos, oldnode, digger, anzahl)
	if anzahl == nil then
		anzahl = 1
	end
	for i=1,anzahl do
		if digger:get_inventory():room_for_item("main", ItemStack(oldnode.name)) then
			digger:get_inventory():remove_item("main", ItemStack(oldnode.name))
		end
		local item = minetest.env:add_item(pos, oldnode)
		local x = math.random(1, 5)
		if math.random(1,2) == 1 then
			x = -x
		end
		local z = math.random(1, 5)
		if math.random(1,2) == 1 then
			z = -z
		end
		item:setvelocity({x=1/x, y=item:getvelocity().y, z=1/z})
	end
end

local players = {}

minetest.register_on_joinplayer(function(player)
	table.insert(players, player)
end)

minetest.register_on_leaveplayer(function(player)
	table.remove(players, player)
end)

minetest.register_globalstep(function(dtime)
	for i,player in ipairs(players) do
		local pos = player:getpos()
		pos.y = pos.y+1
		local items = minetest.env:get_objects_inside_radius(pos,1)
		for j,item in ipairs(items) do
			if not item:is_player() and item:get_luaentity().itemstring ~= nil then
				if item:get_luaentity().itemstring ~= "" and player:get_inventory():room_for_item("main", ItemStack(item:get_luaentity().itemstring)) then
					minetest.debug("[item_drop] Item given: "..item:get_luaentity().itemstring)
					player:get_inventory():add_item("main", ItemStack(item:get_luaentity().itemstring))
					minetest.sound_play("item_drop_pickup", {
						to_player = player,
					})
					item:remove()
					item:get_luaentity().itemstring = ""
				end
			end
		end
		
		items = minetest.env:get_objects_inside_radius(pos,4)
		for j,item in ipairs(items) do
			if not item:is_player() and item:get_luaentity().itemstring ~= nil then
				if player:get_inventory():room_for_item("main", ItemStack(item:get_luaentity().itemstring)) then
					local p = player:getpos()
					p.y = p.y+1
					local i = item:getpos()
					local move = {x=(p.x-i.x)*15, y=(p.y-i.y)*15, z=(p.z-i.z)*15}
					item:setacceleration(move)
				end
			end
		end
	end
end)