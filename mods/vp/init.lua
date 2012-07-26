local keres_szam = 12
local furas_szam = 10

minetest.register_craft({
	output = 'vp:si_i 1',
	recipe = {
		{'default:cobble', 'default:cobble', 'default:cobble'},
		{'default:cobble', 'default:coal_lump', 'default:cobble'},
		{'default:cobble', 'default:cobble', 'default:cobble'},
	}
})


minetest.register_craftitem("vp:si_i", {
	description = "SI_i",
	inventory_image = "vp_si_i.png",
})

minetest.register_craftitem("vp:mese_i", {
	description = "Mese_i",
	inventory_image = "vp_mese_i.png",
})

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "vp:si_i",
})

minetest.register_craft({
output = 'vp:mese_i 1',
	recipe = {
		{'vp:si_i', 'default:sand', 'vp:si_i'},
		{'default:cobble', 'default:steel_ingot', 'default:cobble'},
		{'vp:si_i', 'default:sand', 'vp:si_i'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "default:mese",
	recipe = "vp:mese_i",
})

minetest.register_node("vp:obsidian",{
	description = "Obsidian",
	tiles = {"obsidian.png"},
	is_ground_content = true,
	drop = 'vp:obsidian',
	legacy_mineral = true,
	material = minetest.digprop_constanttime(10)
})

minetest.register_craft({
output = 'vp:obsidian 1',
	recipe = {
		{'bucket:bucket_water','bucket:bucket_lava'}
	}
})

minetest.register_craft({
output = 'vp:obsidian 1',
	recipe = {
		{'bucket:bucket_lava','bucket:bucket_water'}
	}
})


minetest.register_node("vp:kereso",{
	description = "Kereso",
	tiles = {"kereso_top.png", "kereso_side.png",
			"kereso_side.png", "kereso_side.png",
			"kereso_side.png", "kereso_side.png"},
	inventory_image = minetest.inventorycube("kereso_top.png",
			"kereso_side.png", "kereso_side.png"),
	
	is_ground_content = true,
	drop = 'vp:kereso',
	legacy_mineral = true,
	material = minetest.digprop_dirtlike(2.0),
})

minetest.register_craft({
output = 'vp:kereso 1',
	recipe = {
		{'vp:obsidian','default:mese','vp:obsidian'},
		{'default:mese','default:sapling','default:mese'},
		{'vp:obsidian','default:mese','vp:obsidian'},
	}
})



local on_kereso_punched = function(pos, node, puncher)
	if node.name ~= 'vp:kereso' then
		return
	end
	kereses(pos,keres_szam)
end


minetest.register_on_punchnode(on_kereso_punched)

function kereses(pos, keres)

	for p_x=(pos.x-keres), (pos.x+keres) do
	 for p_y=(pos.y-keres), (pos.y+keres) do
	  for p_z=(pos.z-keres), (pos.z+keres) do

		local keres_n = minetest.env:get_node({x=p_x, y=p_y, z=p_z})

		if keres_n.name == "default:mese" then
		minetest.chat_send_all('mese: x: '..p_x..' y: '..p_y..' z: '..p_z)
		end
		
		if keres_n.name == "default:stone_with_iron" then
		minetest.chat_send_all('Iron: x: '..p_x..' y: '..p_y..' z: '..p_z)
		end

		--if keres_n.name == "default:stone_with_coal" then
		--minetest.chat_send_all('Coal: x: '..p_x..' y: '..p_y..' z: '..p_z)
		--end
	  end
	 end
	end
	
	minetest.chat_send_all('--: x: -- y: -- z: -- ')
end


minetest.register_node("vp:furo",{
	description = "Furo",
	tiles = {"furo_top.png","furo_d.png","furo_side.png"},
	is_ground_content = true,
	drop = 'vp:furo',
	legacy_mineral = true,
	material = minetest.digprop_stonelike(2.0),
})

minetest.register_node("vp:furo_end",{
	description = "Furo",
	tiles = {"furo_top.png","furo_d.png","furo_side.png"},
	is_ground_content = true,
	drop = 'vp:furo',
	legacy_mineral = true,
	material = minetest.digprop_stonelike(2.0),
})


minetest.register_craft({
output = 'vp:furo 1',
	recipe = {
		{'vp:obsidian','default:mese','vp:obsidian'},
		{'vp:obsidian','default:steel_ingot','vp:obsidian'},
		{'','vp:obsidian',''},
	}
})

local on_furo_punched = function(pos, node, puncher)
	if node.name ~= 'vp:furo' then
		return
	end
	furas(pos,furas_szam)
end


minetest.register_on_punchnode(on_furo_punched)

function furas(pos, fsz)
	for k_y=1, fsz do
	 local seged = {x=pos.x,y=pos.y-k_y,z=pos.z}
	 minetest.env:remove_node(seged)
	 --minetest.chat_send_all('Furas:'..pos.y-k_y-1)
	end
	minetest.env:remove_node({x=pos.x,y=pos.y,z=pos.z})
	minetest.env:add_node({x=pos.x,y=pos.y-fsz,z=pos.z}, {name = 'vp:furo_end'})
end


minetest.register_node("vp:tnt",{
	description = "TNT",
	tiles = {"default_tnt_top.png", "default_tnt_bottom.png",
			"default_tnt_side.png", "default_tnt_side.png",
			"default_tnt_side.png", "default_tnt_side.png"},
	inventory_image = minetest.inventorycube("default_tnt_top.png",
			"default_tnt_side.png", "default_tnt_side.png"),
	is_ground_content = true,
	drop = 'vp:tnt',
	legacy_mineral = true,
	material = minetest.digprop_dirtlike(0.5),
})

minetest.register_craft({
output = 'vp:tnt 1',
	recipe = {
		{'','default:wood',''},
		{'default:wood','default:coal_lump','default:wood'},
		{'','default:wood',''},
	}
})

local on_tnt_punched = function(pos, node, puncher)
	if node.name ~= 'vp:tnt' then
		return
	end
	tnt_indit(pos)
end


minetest.register_on_punchnode(on_tnt_punched)


function tnt_indit(pos)
	for p_x=(pos.x-3), (pos.x+3) do
	 for p_y=(pos.y-3), (pos.y+3) do
	  for p_z=(pos.z-3), (pos.z+3) do
		local seged = {x=p_x,y=p_y,z=p_z}
	 	minetest.env:remove_node(seged)
	  end
	 end
	end

	for p_x=(0-2), (0+2) do
	 for p_y=(0-2), (0+2) do
	 	p_z=(0-4)
		local seged = {x=p_x+pos.x,y=p_y+pos.y,z=p_z+pos.z}
	 	minetest.env:remove_node(seged)
		local seged = {x=p_x+pos.x,y=p_z+pos.y,z=p_y+pos.z}
	 	minetest.env:remove_node(seged)
		local seged = {x=p_y+pos.x,y=p_x+pos.y,z=p_z+pos.z}
	 	minetest.env:remove_node(seged)
		local seged = {x=p_y+pos.x,y=p_z+pos.y,z=p_x+pos.z}
	 	minetest.env:remove_node(seged)
		local seged = {x=p_z+pos.x,y=p_x+pos.y,z=p_y+pos.z}
	 	minetest.env:remove_node(seged)
		local seged = {x=p_z+pos.x,y=p_y+pos.y,z=p_x+pos.z}
	 	minetest.env:remove_node(seged)
		p_z=(0+4)
		local seged = {x=p_x+pos.x,y=p_y+pos.y,z=p_z+pos.z}
	 	minetest.env:remove_node(seged)
		local seged = {x=p_x+pos.x,y=p_z+pos.y,z=p_y+pos.z}
	 	minetest.env:remove_node(seged)
		local seged = {x=p_y+pos.x,y=p_x+pos.y,z=p_z+pos.z}
	 	minetest.env:remove_node(seged)
		local seged = {x=p_y+pos.x,y=p_z+pos.y,z=p_x+pos.z}
	 	minetest.env:remove_node(seged)
		local seged = {x=p_z+pos.x,y=p_x+pos.y,z=p_y+pos.z}
	 	minetest.env:remove_node(seged)
		local seged = {x=p_z+pos.x,y=p_y+pos.y,z=p_x+pos.z}
	 	minetest.env:remove_node(seged)
		
	 end
	end
	
	local seged = {x=pos.x-5,y=pos.y,z=pos.z}
	minetest.env:remove_node(seged)
	local seged = {x=pos.x+5,y=pos.y,z=pos.z}
	minetest.env:remove_node(seged)
	local seged = {x=pos.x,y=pos.y,z=pos.z}
	minetest.env:remove_node(seged)
	local seged = {x=pos.x,y=pos.y-5,z=pos.z}
	minetest.env:remove_node(seged)
	local seged = {x=pos.x,y=pos.y+5,z=pos.z}
	minetest.env:remove_node(seged)
	local seged = {x=pos.x,y=pos.y,z=pos.z-5}
	minetest.env:remove_node(seged)
	local seged = {x=pos.x,y=pos.y,z=pos.z+5}
	minetest.env:remove_node(seged)
end

minetest.register_node("vp:tntfuro",{
	description = "TNT",
	tiles = {"default_tnt_top.png","furo_d.png","furo_side.png"},
	is_ground_content = true,
	drop = 'vp:tntfuro',
	legacy_mineral = true,
	material = minetest.digprop_stonelike(2.0),
})

minetest.register_craft({
output = 'vp:tntfuro 2',
	recipe = {
		{'','vp:furo',''},
		{'vp:furo','vp:tnt','vp:furo'},
		{'','vp:furo',''},
	}
})


local on_tntfuro_punched = function(pos, node, puncher)
	if node.name ~= 'vp:tntfuro' then
		return
	end
	furas(pos,furas_szam)
	tnt_indit({x=pos.x,y=pos.y-furas_szam,z=pos.z})
end


minetest.register_on_punchnode(on_tntfuro_punched)


print "[VP] Elindult..."

--minetest.env:add_node({x=pos.x,y=pos.y,z=pos.z}, {name = 'vp:tnt'})
