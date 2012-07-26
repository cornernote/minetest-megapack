max_search_distance = 12
min_search_distance = 4

-- All type detector

minetest.register_node("mineral_detector:detector", {
	description = "Mineral Detector",
	tiles = {"mineral_detector_none_none_none.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_inv.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:detector_none_none_none", {
	tiles = {"mineral_detector_none_none_none.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_inv.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:detector_low_none_none", {
	tiles = {"mineral_detector_low_none_none.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_inv.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:detector_low_low_none", {
	tiles = {"mineral_detector_low_low_none.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_inv.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:detector_low_low_low", {
	tiles = {"mineral_detector_low_low_low.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_inv.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:detector_low_none_low", {
	tiles = {"mineral_detector_low_none_low.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_inv.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:detector_none_low_low", {
	tiles = {"mineral_detector_none_low_low.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_inv.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:detector_none_none_low", {
	tiles = {"mineral_detector_none_none_low.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_inv.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:detector_none_low_none", {
	tiles = {"mineral_detector_none_low_none.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_inv.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:detector 1',
	metadata_name = "generic"
})


minetest.register_craft({
	output = 'mineral_detector:detector 1',
	recipe = {
		{'default:steelblock', 'default:iron_lump', 'default:steelblock'},
		{'default:steelblock', 'default:coal_lump', 'default:steelblock'},
		{'default:steelblock', 'default:mese', 'default:steelblock'},
	}
})

-- Iron detector

minetest.register_node("mineral_detector:iron_detector", {
	description = "Iron Detector",
	tiles = {"mineral_detector_inv_iron.png", "default_wood.png"},
	inventory_image = "mineral_detector_inv_iron.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:iron_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:iron_detector_0", {
	tiles = {"mineral_detector_iron_0.png", "default_wood.png"},
	inventory_image = "mineral_detector_iron_0.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:iron_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:iron_detector_1", {
	tiles = {"mineral_detector_iron_1.png", "default_wood.png"},
	inventory_image = "mineral_detector_iron_1.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:iron_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:iron_detector_2", {
	tiles = {"mineral_detector_iron_2.png", "default_wood.png"},
	inventory_image = "mineral_detector_iron_2.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:iron_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:iron_detector_3", {
	tiles = {"mineral_detector_iron_3.png", "default_wood.png"},
	inventory_image = "mineral_detector_iron_3.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:iron_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:iron_detector_4", {
	tiles = {"mineral_detector_iron_4.png", "default_wood.png"},
	inventory_image = "mineral_detector_iron_4.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:iron_detector 1',
	metadata_name = "generic"
})

minetest.register_craft({
	output = 'mineral_detector:iron_detector 1',
	recipe = {
		{'default:wood', 'default:iron_lump', 'default:wood'},
		{'default:wood', 'default:iron_lump', 'default:wood'},
		{'default:wood', 'default:iron_lump', 'default:wood'},
	}
})

-- Coal detector

minetest.register_node("mineral_detector:coal_detector", {
	description = "Coal Detector",
	tiles = {"mineral_detector_inv_coal.png", "default_wood.png"},
	inventory_image = "mineral_detector_inv_coal.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:coal_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:coal_detector_0", {
	tiles = {"mineral_detector_coal_0.png", "default_wood.png"},
	inventory_image = "mineral_detector_coal_0.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:coal_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:coal_detector_1", {
	tiles = {"mineral_detector_coal_1.png", "default_wood.png"},
	inventory_image = "mineral_detector_coal_1.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:coal_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:coal_detector_2", {
	tiles = {"mineral_detector_coal_2.png", "default_wood.png"},
	inventory_image = "mineral_detector_coal_2.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:coal_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:coal_detector_3", {
	tiles = {"mineral_detector_coal_3.png", "default_wood.png"},
	inventory_image = "mineral_detector_coal_3.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:coal_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:coal_detector_4", {
	tiles = {"mineral_detector_coal_4.png", "default_wood.png"},
	inventory_image = "mineral_detector_coal_4.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:coal_detector 1',
	metadata_name = "generic"
})

minetest.register_craft({
	output = 'mineral_detector:coal_detector 1',
	recipe = {
		{'default:wood', 'default:coal_lump', 'default:wood'},
		{'default:wood', 'default:coal_lump', 'default:wood'},
		{'default:wood', 'default:coal_lump', 'default:wood'},
	}
})

-- Mese detector


minetest.register_node("mineral_detector:mese_detector", {
	description = "Mese Detector",
	tiles = {"mineral_detector_inv_mese.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_inv_mese.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:mese_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:mese_detector_0", {
	tiles = {"mineral_detector_mese_0.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_mese_0.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:mese_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:mese_detector_1", {
	tiles = {"mineral_detector_mese_1.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_mese_1.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:mese_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:mese_detector_2", {
	tiles = {"mineral_detector_mese_2.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_mese_2.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:mese_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:mese_detector_3", {
	tiles = {"mineral_detector_mese_3.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_mese_3.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:mese_detector 1',
	metadata_name = "generic"
})

minetest.register_node("mineral_detector:mese_detector_4", {
	tiles = {"mineral_detector_mese_4.png", "default_steel_block.png"},
	inventory_image = "mineral_detector_mese_4.png",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = 'mineral_detector:mese_detector 1',
	metadata_name = "generic"
})

minetest.register_craft({
	output = 'mineral_detector:mese_detector 1',
	recipe = {
		{'default:steelblock', 'default:mese', 'default:steelblock'},
		{'default:steelblock', 'default:mese', 'default:steelblock'},
		{'default:steelblock', 'default:mese', 'default:steelblock'},
	}
})

function UpdateDetectorAll(pos, search_distance)
	local search_p = {x=0, y=0, z=0}

	local iron_found, coal_found, mese_found = 0, 0, 0

	for p_x=(pos.x-search_distance), (pos.x+search_distance) do
		for p_y=(pos.y-search_distance), (pos.y+search_distance) do
			for p_z=(pos.z-search_distance), (pos.z+search_distance) do
				local search_n = minetest.env:get_node({x=p_x, y=p_y, z=p_z})

				if search_n.name == "default:mese" then
					mese_found = mese_found + 1
				elseif search_n.name == "default:stone_with_iron" then
					iron_found = iron_found + 1
				elseif search_n.name == "default:stone_with_coal" then
					coal_found = coal_found + 1
				end
			end
		end
	end
	--iron_percent = math.floor((iron_found/(math.pow((search_distance*2)+1,3))*1000))/10
	--coal_percent = math.floor((coal_found/(math.pow((search_distance*2)+1,3))*1000))/10
	--mese_percent = math.floor((mese_found/(math.pow((search_distance*2)+1,3))*1000))/10
	info_text = ("Range: " .. tostring(search_distance) .. " | Found (iron: " .. iron_found .. ") (coal: " .. coal_found .. ") (mese: " .. mese_found .. ")")
	--info_text = ("Found (iron: " .. iron_percent .. "%) (coal: " .. coal_percent .. "%) (mese: " .. mese_percent .. "%)")
	--info_text = ("Found (iron: " .. iron_found .. "-" .. iron_percent .. "%) (coal: " .. coal_found .. "-" .. coal_percent .. "%) (mese: " .. mese_found .. "-" .. mese_percent .. "%)")

	--local high_cutoff = (search_distance * search_distance * search_distance) * 0.1
	local coal_level, iron_level, mese_level = "none", "none", "none"

	--[[if iron_found >= high_cutoff then
		iron_level = "high"
	elseif iron_found > 0 then
		iron_level = "low"
	end

	if coal_found >= high_cutoff then
		coal_level = "high"
	elseif coal_found > 0 then
		coal_level = "low"
	end

	if mese_found >= high_cutoff then
		mese_level = "high"
	elseif mese_found > 0 then
		mese_level = "low"
	end
	]]
	if iron_found > 0 then
		iron_level = "low"
	end

	if coal_found > 0 then
		coal_level = "low"
	end

	if mese_found > 0 then
		mese_level = "low"
	end

	minetest.env:add_node(pos, {name = "mineral_detector:detector_" .. iron_level .. "_" .. coal_level .. "_" .. mese_level})
	local newmeta = minetest.env:get_meta(pos)
	newmeta:set_infotext(info_text)
	newmeta:set_string("search_distance", tostring(search_distance))
end

function UpdateDetectorIron(pos, search_distance)
	local search_p = {x=0, y=0, z=0}

	local iron_found = 0

	for p_x=(pos.x-search_distance), (pos.x+search_distance) do
		for p_y=(pos.y-search_distance), (pos.y+search_distance) do
			for p_z=(pos.z-search_distance), (pos.z+search_distance) do
				local search_n = minetest.env:get_node({x=p_x, y=p_y, z=p_z})

				if search_n.name == "default:stone_with_iron" then
					iron_found = iron_found + 1
				end
			end
		end
	end
	info_text = ("Range: " .. tostring(search_distance) .. " | Found (iron: " .. iron_found .. ")")

	local ten_percent = (search_distance * search_distance * search_distance) * 0.1
	local iron_level = "0"

	if iron_found > (ten_percent*3) then
		iron_level = "4"
	elseif iron_found > (ten_percent*2) then
		iron_level = "3"
	elseif iron_found > (ten_percent) then
		iron_level = "2"
	elseif iron_found > 0 then
		iron_level = "1"
	end

	minetest.env:add_node(pos, {name = "mineral_detector:iron_detector_" .. iron_level})
	local newmeta = minetest.env:get_meta(pos)
	newmeta:set_infotext(info_text)
	newmeta:set_string("search_distance", tostring(search_distance))
end

function UpdateDetectorCoal(pos, search_distance)
	local search_p = {x=0, y=0, z=0}

	local coal_found = 0

	for p_x=(pos.x-search_distance), (pos.x+search_distance) do
		for p_y=(pos.y-search_distance), (pos.y+search_distance) do
			for p_z=(pos.z-search_distance), (pos.z+search_distance) do
				local search_n = minetest.env:get_node({x=p_x, y=p_y, z=p_z})

				if search_n.name == "default:stone_with_coal" then
					coal_found = coal_found + 1
				end
			end
		end
	end
	info_text = ("Range: " .. tostring(search_distance) .. " | Found (coal: " .. coal_found .. ")")

	local ten_percent = (search_distance * search_distance * search_distance) * 0.1
	local coal_level = "0"

	if coal_found > (ten_percent*3) then
		coal_level = "4"
	elseif coal_found > (ten_percent*2) then
		coal_level = "3"
	elseif coal_found > (ten_percent) then
		coal_level = "2"
	elseif coal_found > 0 then
		coal_level = "1"
	end

	minetest.env:add_node(pos, {name = "mineral_detector:coal_detector_" .. coal_level})
	local newmeta = minetest.env:get_meta(pos)
	newmeta:set_infotext(info_text)
	newmeta:set_string("search_distance", tostring(search_distance))
end

function UpdateDetectorMese(pos, search_distance)
	local search_p = {x=0, y=0, z=0}

	local mese_found = 0

	for p_x=(pos.x-search_distance), (pos.x+search_distance) do
		for p_y=(pos.y-search_distance), (pos.y+search_distance) do
			for p_z=(pos.z-search_distance), (pos.z+search_distance) do
				local search_n = minetest.env:get_node({x=p_x, y=p_y, z=p_z})

				if search_n.name == "default:mese" then
					mese_found = mese_found + 1
				end
			end
		end
	end
	info_text = ("Range: " .. tostring(search_distance) .. " | Found (mese: " .. mese_found .. ")")

	local ten_percent = (search_distance * search_distance * search_distance) * 0.1
	local mese_level = "0"

	if mese_found > (ten_percent*3) then
		mese_level = "4"
	elseif mese_found > (ten_percent*2) then
		mese_level = "3"
	elseif mese_found > (ten_percent) then
		mese_level = "2"
	elseif mese_found > 0 then
		mese_level = "1"
	end

	minetest.env:add_node(pos, {name = "mineral_detector:mese_detector_" .. mese_level})
	local newmeta = minetest.env:get_meta(pos)
	newmeta:set_infotext(info_text)
	newmeta:set_string("search_distance", tostring(search_distance))
end

minetest.register_on_punchnode(function(pos, node, puncher)
	if string.match(node.name, "mineral_detector:") ~= nil then
		if puncher:get_wielded_item():get_tool_capabilities().groupcaps[oddly_breakable_by_hand] == nil then
			return
		end

		local meta = minetest.env:get_meta(pos)
		local search_distance = tonumber(meta:get_string("search_distance"))
		if search_distance < max_search_distance then
			search_distance = search_distance + 1
		else
			search_distance = min_search_distance
		end

		if string.match(node.name, "mineral_detector:detector_") ~= nil then
			UpdateDetectorAll(pos, search_distance)
		elseif string.match(node.name, "mineral_detector:iron_detector_") ~= nil then
			UpdateDetectorIron(pos, search_distance)
		elseif string.match(node.name, "mineral_detector:coal_detector_") ~= nil then
			UpdateDetectorCoal(pos, search_distance)
		elseif string.match(node.name, "mineral_detector:mese_detector_") ~= nil then
			UpdateDetectorMese(pos, search_distance)
		end
	end
end)

minetest.register_on_placenode(
function(pos, newnode, placer)
	if string.match(newnode.name, "mineral_detector:") ~= nil then
		local meta = minetest.env:get_meta(pos)
		meta:set_infotext("")

		if newnode.name == "mineral_detector:detector" then
			UpdateDetectorAll(pos, min_search_distance)
		elseif newnode.name == "mineral_detector:iron_detector" then
			UpdateDetectorIron(pos, min_search_distance)
		elseif newnode.name == "mineral_detector:coal_detector" then
			UpdateDetectorCoal(pos, min_search_distance)
		elseif newnode.name == "mineral_detector:mese_detector" then
			UpdateDetectorMese(pos, min_search_distance)
		end
	end
end
)
