-- Teleporters mod by Zeg9
-- Licensed under the WTFPL
-- Have fun :D

teleporters = {}

-- config
teleporters.go_up_effect = true
-- end

teleporters.block_groups = {cracky=2}
teleporters.copy_pos = function (_pos)
	return {x=_pos.x, y=_pos.y, z=_pos.z}
end

teleporters.is_safe = function (pos)
	ok = false
	if minetest.env:get_node(pos).name ~= "air" then
		pos.y = pos.y +1
		if minetest.env:get_node(pos).name == "air" then
			pos.y = pos.y +1
			if minetest.env:get_node(pos).name == "air" then
				ok = true
			end
			pos.y = pos.y -1
		end
		pos.y = pos.y -1
	end
	return ok
end

teleporters.find_safe = function (_pos)
	pos = teleporters.copy_pos(_pos)
	pos.x = pos.x +1 if teleporters.is_safe(pos) then return pos end
	
	pos = teleporters.copy_pos(_pos)
	pos.x = pos.x -1 if teleporters.is_safe(pos) then return pos end
	
	pos = teleporters.copy_pos(_pos)
	pos.z = pos.z +1 if teleporters.is_safe(pos) then return pos end
	
	pos = teleporters.copy_pos(_pos)
	pos.z = pos.z -1 if teleporters.is_safe(pos) then return pos end
	
	return _pos
end

teleporters.network = {}

teleporters.file = minetest.get_worldpath()..'/teleporters'

teleporters.save = function()
	local output = ''
	for id, coords in pairs(teleporters.network) do output = output..id..':'..coords.x..','..coords.y..','..coords.z..';'	end
	local f = io.open(teleporters.file, "w")
	f:write(output)
	io.close(f)
end

teleporters.load = function()
	local f = io.open(teleporters.file, "r")  
	if f then
		local contents = f:read()
		io.close(f)
		if contents ~= nil then 
			local entries = contents:split(";") 
			for i,entry in pairs(entries) do
				local id, coords = unpack(entry:split(":"))
				local p = {}
				p.x, p.y, p.z = string.match(coords, "^([%d.-]+)[, ] *([%d.-]+)[, ] *([%d.-]+)$")
				if p.x and p.y and p.z then
					teleporters.network[tonumber(id)] = {x = tonumber(p.x),y= tonumber(p.y),z = tonumber(p.z)}
				end
			end
		end
	end
end

teleporters.load()

teleporters.get_new_id = function()
	id = 0
	for k,_ in pairs(teleporters.network) do
		if k > id then id = k end
	end
	return id+1
end

teleporters.make_formspec = function (meta)
	formspec = "size[6,3]" ..
	"label[0,0;Teleporter #"..meta:get_int("id").."]"..
	"field[1,1.25;4.5,1;desc;Description;"..meta:get_string("infotext").."]"..
	"button_exit[2,2;2,1;save;Save]"
	return formspec
end

teleporters.teleport = function (params)
	params.obj:setpos(params.pos)
end

-- Nodes and items

minetest.register_craftitem("teleporters:spiral", {
	description = "Mese spiral",
	inventory_image = "teleporters_spiral.png",
})

minetest.register_node("teleporters:base", {
	description = "Teleporter base",
	tiles = {"teleporters_base.png"},
	groups = teleporters.block_groups,
	light_source = 10,
})

minetest.register_node("teleporters:teleporter", {
	description = "Teleporter",
	tiles = {"teleporters_base.png^teleporters_spiral.png","teleporters_base.png"},
	groups = teleporters.block_groups,
	light_source = 10,
	on_construct = function(pos)
		id = teleporters.get_new_id()
		teleporters.network[id] = pos
		teleporters.save()
		local meta = minetest.env:get_meta(pos)
		meta:set_int("id",id)
		meta:set_string("infotext","Teleporter")
		meta:set_string("formspec",teleporters.make_formspec(meta))
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if fields.desc then
			local meta = minetest.env:get_meta(pos)
			meta:set_string("infotext",fields.desc)
			meta:set_string("formspec",teleporters.make_formspec(meta))
		end
	end,
})

-- ABM

minetest.register_abm({
	nodenames = {"teleporters:teleporter"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local meta = minetest.env:get_meta(pos)
		pos.y = pos.y+1
		local objs = minetest.env:get_objects_inside_radius(pos, 1)
		pos.y = pos.y-1
		for _, obj in pairs(objs) do
			minetest.sound_play("teleporters_teleport",{pos=pos,gain=1,max_hear_distance=32})
			if meta:get_int("id") %2 == 0 then newpos = teleporters.network[meta:get_int("id")-1]
			else newpos = teleporters.network[meta:get_int("id")+1] end
			if not newpos then newpos = pos end
			newpos = teleporters.copy_pos(newpos)
			minetest.sound_play("teleporters_teleport",{gain=1,to_player=obj:get_player_name()})
			newpos = teleporters.find_safe(newpos)
			newpos.y = newpos.y + .5
			if teleporters.go_up_effect then
				newpos.y = newpos.y -1
				teleporters.teleport({obj=obj,pos=newpos})
				newpos.y = newpos.y +1
				minetest.after(.1, teleporters.teleport, {obj=obj,pos=newpos})
			else
				teleporters.teleport({obj=obj,pos=newpos})
			end
		end
	end,
})

-- Crafting

minetest.register_craft({
	output = '"teleporters:spiral" 16',
	recipe = {
	{"default:coal_lump","default:mese","default:coal_lump"},
	{"default:mese","","default:mese"},
	{"default:coal_lump","default:mese","default:coal_lump"}
	}
})

minetest.register_craft({
	output = '"teleporters:base" 4',
	type = "shapeless",
	recipe = {"default:steel_ingot","default:steel_ingot","default:mese","default:mese","bucket:bucket_lava"},
	replacements = {{"bucket:bucket_lava", "bucket:bucket_empty"}}
})

minetest.register_craft({
	output = "teleporters:teleporter",
	recipe = { {"teleporters:spiral"}, {"teleporters:base"} },
})

