minetest.register_craft({
	output = 'protector:protect 16',
	recipe = {
		{'moreores:silver_ingot', 'moreores:silver_ingot'},
		{'moreores:silver_ingot', 'moreores:silver_ingot'},
	}
})


function isprotect(r,pos,digger)
	if pos.y < -999 then
		return false
	end
	local ok=true
	for ix = pos.x-r,pos.x+r do
		for iy = pos.y-r,pos.y+r do
			for iz = pos.z-r,pos.z+r do
				local node_name = minetest.env:get_node({x=ix,y=iy,z=iz})
				if node_name.name == "protector:protect" then
					local meta = minetest.env:get_meta({x=ix,y=iy,z=iz})
					if digger ~= nil then
						local owner = (meta:get_string("owner"))					
							if owner ~= digger:get_player_name() then 
								ok=false	
							end
						else
							ok=false
						end			
				end
			end
		end
	end
	return ok
end

local old_node_dig = minetest.node_dig
function minetest.node_dig(pos, node, digger)
	local ok=true
	ok = isprotect(5,pos,digger)	
	if ok == true then
		old_node_dig(pos, node, digger)
	else
		minetest.chat_send_player(digger:get_player_name(), "area protected")
		return
	end
end

local old_node_place = minetest.item_place
function minetest.item_place(itemstack, placer, pointed_thing)
	if itemstack:get_definition().type == "node" then
		local ok=true
		if itemstack:get_name() ~= "protector:protect" then
			local pos = pointed_thing.above
			ok = isprotect(5,pos,placer)
		else
			local pos = pointed_thing.above
			ok = isprotect(10,pos,placer)
		end 
		if ok == true then
			if itemstack:get_name() == "protector:protect" then
				local pos = pointed_thing.above
				--minetest.chat_send_player(placer:get_player_name(), "this block protect ( ".. 
				--tostring(pos.x-3) .. " to " .. tostring(pos.x+3).." , "..
				--tostring(pos.y-3) .. " to " .. tostring(pos.y+3).." , "..
				--tostring(pos.z-3) .. " to " .. tostring(pos.z+3).." )"
				--)
			end
			return old_node_place(itemstack, placer, pointed_thing)
		else
			minetest.chat_send_player(placer:get_player_name(), "area protected")
			return
		end	
	end	
	return old_node_place(itemstack, placer, pointed_thing)
end
protect = {}
minetest.register_node("protector:protect", {
	description = "protect",
	tile_images = {"glo2.png"},
	groups = {cracky=3},
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "protect (owned by "..
				meta:get_string("owner")..")")
	end,
})
