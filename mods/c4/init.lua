c4 ={}
blow_up=function(list)
		local function test(pos)
			local n = minetest.env:get_node(pos).name
			if n ~= "default:steelblock" then
				if n ~= "air" then
					if n ~= "default:water_source" then
						if n ~= "fire:basic_flame" then
							if n ~= "default:water_flowing" then
								if n ~= "default:lava_flowing" then
									if n ~= "default:lava_source" then
										return true
									end
								end
							end
						end
					end
				end
			end
		end
		local player = list.player
		local InvRef = player:get_inventory()
		local pos = list.pos
		local mount = minetest.env:get_node(pos).param2
		local env = minetest.env
		--down=1,top=0, x+=3,x-=2 z+=4,z-=5
		--default:steelblock not destroyable
		minetest.sound_play("c4_explode", {pos = pos, gain = 1.0, max_hear_distance = 30,})
		if mount==0 then
			if test({x=pos.x,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z}).name == "c4:c4" then
				else
					env:remove_node({x=pos.x,y=pos.y,z=pos.z})
				end
			end
			if test({x=pos.x,y=pos.y+1,z=pos.z}) == true then
				if env:get_node({x=pos.x,y=pos.y+1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y+1,z=pos.z},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x,y=pos.y+1,z=pos.z})
				end
			end
			if test({x=pos.x+1,y=pos.y+1,z=pos.z}) then
				if env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y+1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y+1,z=pos.z},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y+1,z=pos.z})
				end
			end
			if test({x=pos.x-1,y=pos.y+1,z=pos.z}) then
				if env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y+1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y+1,z=pos.z},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y+1,z=pos.z})
				end
			end
			if test({x=pos.x,y=pos.y+1,z=pos.z+1}) then
				if env:get_node({x=pos.x,y=pos.y+1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y+1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y+1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x,y=pos.y+1,z=pos.z+1})
				end
			end
			if test({x=pos.x,y=pos.y+1,z=pos.z-1}) then
				if env:get_node({x=pos.x,y=pos.y+1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y+1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y+1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x,y=pos.y+1,z=pos.z-1})
				end
			end
			if test({x=pos.x+1,y=pos.y+1,z=pos.z+1}) then
				if env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y+1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y+1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y+1,z=pos.z+1})
				end
			end
			if test({x=pos.x-1,y=pos.y+1,z=pos.z-1}) then
				if env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y+1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y+1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y+1,z=pos.z-1})
				end
			end
			if test({x=pos.x-1,y=pos.y+1,z=pos.z+1}) then
				if env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y+1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y+1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y+1,z=pos.z+1})
				end
			end
			if test({x=pos.x+1,y=pos.y+1,z=pos.z-1}) then
				if env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y+1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y+1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y+1,z=pos.z-1})
				end
			end
			if test({x=pos.x,y=pos.y,z=pos.z+1}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y,z=pos.z+1},player=player})
				end
			end
			if test({x=pos.x,y=pos.y,z=pos.z-1}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y,z=pos.z-1},player=player})
				end
			end
			if test({x=pos.x+1,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y,z=pos.z},player=player})
				end
			end
			if test({x=pos.x-1,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y,z=pos.z},player=player})
				end
			end
			if test({x=pos.x+1,y=pos.y,z=pos.z+1}) then
				if env:get_node({x=pos.x+1,y=pos.y,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y,z=pos.z+1},player=player})
				end
			end
			if test({x=pos.x-1,y=pos.y,z=pos.z-1}) then
				if env:get_node({x=pos.x-1,y=pos.y,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y,z=pos.z-1},player=player})
				end
			end
			if test({x=pos.x+1,y=pos.y,z=pos.z-1}) then
				if env:get_node({x=pos.x+1,y=pos.y,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y,z=pos.z-1},player=player})
				end
			end
			if test({x=pos.x-1,y=pos.y,z=pos.z+1}) then
				if env:get_node({x=pos.x-1,y=pos.y,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y,z=pos.z+1},player=player})
				end
			end
		end
		if mount==1 then
			if test({x=pos.x,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y+1,z=pos.z},player=player})
				else
					env:remove_node({x=pos.x,y=pos.y,z=pos.z})
				end
			end
			if test({x=pos.x,y=pos.y-1,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y-1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y-1,z=pos.z},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x,y=pos.y-1,z=pos.z})
				end
			end
			if test({x=pos.x+1,y=pos.y-1,z=pos.z}) then
				if env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y-1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y-1,z=pos.z},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y-1,z=pos.z})
				end
			end
			if test({x=pos.x-1,y=pos.y-1,z=pos.z}) then
				if env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y-1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y-1,z=pos.z},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y-1,z=pos.z})
				end
			end
			if test({x=pos.x,y=pos.y-1,z=pos.z+1}) then
				if env:get_node({x=pos.x,y=pos.y-1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y-1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y-1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x,y=pos.y-1,z=pos.z+1})
				end
			end
			if test({x=pos.x,y=pos.y-1,z=pos.z-1}) then
				if env:get_node({x=pos.x,y=pos.y-1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y-1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y-1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x,y=pos.y-1,z=pos.z-1})
				end
			end
			if test({x=pos.x+1,y=pos.y-1,z=pos.z+1}) then
				if env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y-1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y-1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y-1,z=pos.z+1})
				end
			end
			if test({x=pos.x-1,y=pos.y-1,z=pos.z-1}) then
				if env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y-1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y-1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y-1,z=pos.z-1})
				end
			end
			if test({x=pos.x-1,y=pos.y-1,z=pos.z+1}) then
				if env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y-1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y-1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y-1,z=pos.z+1})
				end
			end
			if test({x=pos.x+1,y=pos.y-1,z=pos.z-1}) then
				if env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y-1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y-1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y-1,z=pos.z-1})
				end
			end
			if test({x=pos.x,y=pos.y,z=pos.z+1}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y,z=pos.z+1},player=player})
				end
			end
			if test({x=pos.x,y=pos.y,z=pos.z-1}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y,z=pos.z-1},player=player})
				end
			end
			if test({x=pos.x+1,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y,z=pos.z},player=player})
				end
			end
			if test({x=pos.x-1,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y,z=pos.z},player=player})
				end
			end
			if test({x=pos.x+1,y=pos.y,z=pos.z+1}) then
				if env:get_node({x=pos.x+1,y=pos.y,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y,z=pos.z+1},player=player})
				end
			end
			if test({x=pos.x-1,y=pos.y,z=pos.z-1}) then
				if env:get_node({x=pos.x-1,y=pos.y,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y,z=pos.z-1},player=player})
				end
			end
			if test({x=pos.x+1,y=pos.y,z=pos.z-1}) then
				if env:get_node({x=pos.x+1,y=pos.y,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y,z=pos.z-1},player=player})
				end
			end
			if test({x=pos.x-1,y=pos.y,z=pos.z+1}) then
				if env:get_node({x=pos.x-1,y=pos.y,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y,z=pos.z+1},player=player})
				end
			end
		end
		if mount==2 then
			if test({x=pos.x,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z}).name == "c4:c4" then
				else
					env:remove_node({x=pos.x,y=pos.y,z=pos.z})
				end
			end
			if test({x=pos.x+1,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y,z=pos.z},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y,z=pos.z})
				end
			end
			if test({x=pos.x+1,y=pos.y+1,z=pos.z}) then
				if env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y+1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y+1,z=pos.z},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y+1,z=pos.z})
				end
			end
			if test({x=pos.x+1,y=pos.y-1,z=pos.z}) then
				if env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y-1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y-1,z=pos.z},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y-1,z=pos.z})
				end
			end
			if test({x=pos.x+1,y=pos.y,z=pos.z-1}) then
				if env:get_node({x=pos.x+1,y=pos.y,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y,z=pos.z-1})
				end
			end
			if test({x=pos.x+1,y=pos.y,z=pos.z+1}) then
				if env:get_node({x=pos.x+1,y=pos.y,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y,z=pos.z+1})
				end
			end
			if test({x=pos.x+1,y=pos.y+1,z=pos.z-1}) then
				if env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y+1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y+1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y+1,z=pos.z-1})
				end
			end
			if test({x=pos.x+1,y=pos.y-1,z=pos.z+1}) then
				if env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y-1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y-1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y-1,z=pos.z+1})
				end
			end
			if test({x=pos.x+1,y=pos.y-1,z=pos.z-1}) then
				if env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y-1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y-1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y-1,z=pos.z-1})
				end
			end
			if test({x=pos.x+1,y=pos.y+1,z=pos.z+1}) then
				if env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y+1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y+1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y+1,z=pos.z+1})
				end
			end
			if test({x=pos.x,y=pos.y,z=pos.z+1}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y,z=pos.z+1},player=player})
				end
			end
			if test({x=pos.x,y=pos.y,z=pos.z-1}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y,z=pos.z-1},player=player})
				end
			end
			if test({x=pos.x,y=pos.y+1,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y+1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y+1,z=pos.z},player=player})
				end
			end
			if test({x=pos.x,y=pos.y-1,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y-1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y-1,z=pos.z},player=player})
				end
			end
			if test({x=pos.x,y=pos.y-1,z=pos.z+1}) then
				if env:get_node({x=pos.x,y=pos.y-1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y-1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y-1,z=pos.z+1},player=player})
				end
			end
			if test({x=pos.x,y=pos.y+1,z=pos.z-1}) then
				if env:get_node({x=pos.x,y=pos.y+1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y+1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y+1,z=pos.z-1},player=player})
				end
			end
			if test({x=pos.x,y=pos.y-1,z=pos.z-1}) then
				if env:get_node({x=pos.x,y=pos.y-1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y-1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y-1,z=pos.z-1},player=player})
				end
			end
			if test({x=pos.x,y=pos.y+1,z=pos.z+1}) then
				if env:get_node({x=pos.x,y=pos.y+1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y+1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y+1,z=pos.z+1},player=player})
				end
			end
		end
		if mount==3 then
			if test({x=pos.x,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z}).name == "c4:c4" then
				else
					env:remove_node({x=pos.x,y=pos.y,z=pos.z})
				end
			end
			if test({x=pos.x-1,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y,z=pos.z},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y,z=pos.z})
				end
			end
			if test({x=pos.x-1,y=pos.y+1,z=pos.z}) then
				if env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y+1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y+1,z=pos.z},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y+1,z=pos.z})
				end
			end
			if test({x=pos.x-1,y=pos.y-1,z=pos.z}) then
				if env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y-1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y-1,z=pos.z},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y-1,z=pos.z})
				end
			end
			if test({x=pos.x-1,y=pos.y,z=pos.z-1}) then
				if env:get_node({x=pos.x-1,y=pos.y,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y,z=pos.z-1})
				end
			end
			if test({x=pos.x-1,y=pos.y,z=pos.z+1}) then
				if env:get_node({x=pos.x-1,y=pos.y,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y,z=pos.z+1})
				end
			end
			if test({x=pos.x-1,y=pos.y+1,z=pos.z-1}) then
				if env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y+1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y+1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y+1,z=pos.z-1})
				end
			end
			if test({x=pos.x-1,y=pos.y-1,z=pos.z+1}) then
				if env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y-1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y-1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y-1,z=pos.z+1})
				end
			end
			if test({x=pos.x-1,y=pos.y-1,z=pos.z-1}) then
				if env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y-1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y-1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y-1,z=pos.z-1})
				end
			end
			if test({x=pos.x-1,y=pos.y+1,z=pos.z+1}) then
				if env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y+1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y+1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y+1,z=pos.z+1})
				end
			end
			if test({x=pos.x,y=pos.y,z=pos.z+1}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y,z=pos.z+1},player=player})
				end
			end
			if test({x=pos.x,y=pos.y,z=pos.z-1}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y,z=pos.z-1},player=player})
				end
			end
			if test({x=pos.x,y=pos.y+1,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y+1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y+1,z=pos.z},player=player})
				end
			end
			if test({x=pos.x,y=pos.y-1,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y-1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y-1,z=pos.z},player=player})
				end
			end
			if test({x=pos.x,y=pos.y-1,z=pos.z+1}) then
				if env:get_node({x=pos.x,y=pos.y-1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y-1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y-1,z=pos.z+1},player=player})
				end
			end
			if test({x=pos.x,y=pos.y+1,z=pos.z-1}) then
				if env:get_node({x=pos.x,y=pos.y+1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y+1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y+1,z=pos.z-1},player=player})
				end
			end
			if test({x=pos.x,y=pos.y-1,z=pos.z-1}) then
				if env:get_node({x=pos.x,y=pos.y-1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y-1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y-1,z=pos.z-1},player=player})
				end
			end
			if test({x=pos.x,y=pos.y+1,z=pos.z+1}) then
				if env:get_node({x=pos.x,y=pos.y+1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y+1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y+1,z=pos.z+1},player=player})
				end
			end
		end
		if mount==4 then
			if test({x=pos.x,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z}).name == "c4:c4" then
				else
					env:remove_node({x=pos.x,y=pos.y,z=pos.z})
				end
			end
			if test({x=pos.x,y=pos.y,z=pos.z+1}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x,y=pos.y,z=pos.z+1})
				end
			end
			if test({x=pos.x,y=pos.y-1,z=pos.z+1}) then
				if env:get_node({x=pos.x,y=pos.y-1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y-1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y-1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x,y=pos.y-1,z=pos.z+1})
				end
			end
			if test({x=pos.x,y=pos.y+1,z=pos.z+1}) then
				if env:get_node({x=pos.x,y=pos.y+1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y+1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y+1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x,y=pos.y+1,z=pos.z+1})
				end
			end
			if test({x=pos.x-1,y=pos.y,z=pos.z+1}) then
				if env:get_node({x=pos.x-1,y=pos.y,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y,z=pos.z+1})
				end
			end
			if test({x=pos.x+1,y=pos.y,z=pos.z+1}) then
				if env:get_node({x=pos.x+1,y=pos.y,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y,z=pos.z+1})
				end
			end
			if test({x=pos.x+1,y=pos.y-1,z=pos.z+1}) then
				if env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y-1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y-1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y-1,z=pos.z+1})
				end
			end
			if test({x=pos.x-1,y=pos.y+1,z=pos.z+1}) then
				if env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y+1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y+1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y+1,z=pos.z+1})
				end
			end
			if test({x=pos.x+1,y=pos.y+1,z=pos.z+1}) then
				if env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y+1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y+1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y+1,z=pos.z+1})
				end
			end
			if test({x=pos.x-1,y=pos.y-1,z=pos.z+1}) then
				if env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z+1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y-1,z=pos.z+1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z+1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y-1,z=pos.z+1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z+1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y-1,z=pos.z+1})
				end
			end
			if test({x=pos.x+1,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y,z=pos.z},player=player})
				end
			end
			if test({x=pos.x,y=pos.y+1,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y+1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y+1,z=pos.z},player=player})
				end
			end
			if test({x=pos.x,y=pos.y-1,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y-1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y-1,z=pos.z},player=player})
				end
			end
			if test({x=pos.x-1,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y,z=pos.z},player=player})
				end
			end
			if test({x=pos.x-1,y=pos.y-1,z=pos.z}) then
				if env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y-1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y-1,z=pos.z},player=player})
				end
			end
			if test({x=pos.x+1,y=pos.y+1,z=pos.z}) then
				if env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y+1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y+1,z=pos.z},player=player})
				end
			end
			if test({x=pos.x+1,y=pos.y-1,z=pos.z}) then
				if env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y-1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y-1,z=pos.z},player=player})
				end
			end
			if test({x=pos.x-1,y=pos.y+1,z=pos.z}) then
				if env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y+1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y+1,z=pos.z},player=player})
				end
			end
		end
		if mount==5 then
			if test({x=pos.x,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z}).name == "c4:c4" then
				else
					env:remove_node({x=pos.x,y=pos.y,z=pos.z})
				end
			end
			if test({x=pos.x,y=pos.y,z=pos.z-1}) then
				if env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x,y=pos.y,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x,y=pos.y,z=pos.z-1})
				end
			end
			if test({x=pos.x,y=pos.y-1,z=pos.z-1}) then
				if env:get_node({x=pos.x,y=pos.y-1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y-1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y-1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x,y=pos.y-1,z=pos.z-1})
				end
			end
			if test({x=pos.x,y=pos.y+1,z=pos.z-1}) then
				if env:get_node({x=pos.x,y=pos.y+1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y+1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y+1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x,y=pos.y+1,z=pos.z-1})
				end
			end
			if test({x=pos.x-1,y=pos.y,z=pos.z-1}) then
				if env:get_node({x=pos.x-1,y=pos.y,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y,z=pos.z-1})
				end
			end
			if test({x=pos.x+1,y=pos.y,z=pos.z-1}) then
				if env:get_node({x=pos.x+1,y=pos.y,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y,z=pos.z-1})
				end
			end
			if test({x=pos.x+1,y=pos.y-1,z=pos.z-1}) then
				if env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y-1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y-1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y-1,z=pos.z-1})
				end
			end
			if test({x=pos.x-1,y=pos.y+1,z=pos.z-1}) then
				if env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y+1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y+1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y+1,z=pos.z-1})
				end
			end
			if test({x=pos.x+1,y=pos.y+1,z=pos.z-1}) then
				if env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y+1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y+1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x+1,y=pos.y+1,z=pos.z-1})
				end
			end
			if test({x=pos.x-1,y=pos.y-1,z=pos.z-1}) then 
				if env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z-1}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y-1,z=pos.z-1}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z-1}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y-1,z=pos.z-1},player=player})
				else
					node_to_get=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z-1}).name
					node_to_drop=minetest.get_node_drops(node_to_get, ":")
					for i,v in pairs(node_to_drop) do
						InvRef:add_item("main", v)
					end
					env:remove_node({x=pos.x-1,y=pos.y-1,z=pos.z-1})
				end
			end
			if test({x=pos.x+1,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y,z=pos.z},player=player})
				end
			end
			if test({x=pos.x,y=pos.y+1,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y+1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y+1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y+1,z=pos.z},player=player})
				end
			end
			if test({x=pos.x,y=pos.y-1,z=pos.z}) then
				if env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x,y=pos.y-1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x,y=pos.y-1,z=pos.z},player=player})
				end
			end
			if test({x=pos.x-1,y=pos.y,z=pos.z}) then
				if env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y,z=pos.z},player=player})
				end
			end
			if test({x=pos.x-1,y=pos.y-1,z=pos.z}) then
				if env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y-1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y-1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y-1,z=pos.z},player=player})
				end
			end
			if test({x=pos.x+1,y=pos.y+1,z=pos.z}) then
				if env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y+1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y+1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y+1,z=pos.z},player=player})
				end
			end
			if test({x=pos.x+1,y=pos.y-1,z=pos.z}) then
				if env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x+1,y=pos.y-1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x+1,y=pos.y-1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x+1,y=pos.y-1,z=pos.z},player=player})
				end
			end
			if test({x=pos.x-1,y=pos.y+1,z=pos.z}) then
				if env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z}).name == "c4:c4" then
					minetest.env:set_node({x=pos.x-1,y=pos.y+1,z=pos.z}, {name="c4:c4_on",param2=minetest.env:get_node({x=pos.x-1,y=pos.y+1,z=pos.z}).param2})
					c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
					minetest.after(2,blow_up,{pos={x=pos.x-1,y=pos.y+1,z=pos.z},player=player})
				end
			end
		end
end
minetest.register_node("c4:c4", {
	description = "C4!!!",
	drawtype = "signlike",
	tiles = {"c4_c4_on_floor.png"},
	inventory_image = "c4_c4_on_floor.png",
	wield_image = "c4_c4_on_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	is_ground_content = true,
	sunlight_propagates = true,
	on_punch=function(pos,node,puncher)
		minetest.env:set_node(pos,{name="c4:c4_on",param2=node.param2})
		c4.beep=minetest.sound_play("c4_beep", {pos = pos, gain = 1.0, max_hear_distance = 7,})
		minetest.after(2,blow_up,{pos=pos,player=puncher})end,
	walkable = false,
	groups = {choppy=2,crumbly=3},
	selection_box = {
		type = "wallmounted",
	},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})
minetest.register_node("c4:c4_on", {
	description = "C4!!!",
	drawtype = "signlike",
	tiles = {"c4_c4_on_floor_on.png"},
	inventory_image = "c4_c4_on_floor.png",
	wield_image = "c4_c4_on_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	is_ground_content = true,
	sunlight_propagates = true,
	walkable = false,
	drop = 'c4:c4',
	light_source = LIGHT_MAX-2,
	--groups = {choppy=2,crumbly=3,dig_immediate=3,},
	selection_box = {
		type = "wallmounted",
	},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})

minetest.register_craft({
	output = 'c4:c4 4',
	recipe = {
		{'default:steel_ingot'},
		{'default:junglegrass'},
	}
})
minetest.register_craft({
	output = 'c4:c4 4',
	recipe = {
		{'default:steel_ingot'},
		{'default:dry_shrub'},
	}
})
