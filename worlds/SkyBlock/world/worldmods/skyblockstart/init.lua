skyblockstart = {
	startpos = {x=0,y=0.5,z=0},
	respawnpos = {x=-47,y=847.5,z=64},
	teleportpos = {x=-47,y=847.5,z=64},
}

local function lose_all_items(player)
	local lists = {"main", "craft", "craftresult", "craftpreview"}
	for _, list in ipairs(lists) do
		player:get_inventory():set_list(list, {})
	end
end

minetest.register_on_newplayer(function(player)
	player:setpos(skyblockstart.startpos)
	return true
end)

minetest.register_on_respawnplayer(function(player)
	player:setpos(skyblockstart.respawnpos)
	return true
end)

minetest.register_on_dieplayer(function(player)
	lose_all_items(player)
end)

minetest.register_node("skyblockstart:grass", {
	description = "SkyBlock grass",
	tile_images = {"default_grass.png"},
	paramtype = "light",
	light_source = 14,
	diggable = false,
	material = {diggability='not'},
})

minetest.register_node("skyblockstart:wall", {
	description = "SkyBlock wall",
	tile_images = {"skyblockstart_wall.png"},
	paramtype = "light",
	light_source = 14,
	diggable = false,
	material = {diggability='not'},
})

minetest.register_node("skyblockstart:cloud", {
	description = "SkyBlock cloud",
	tile_images = {"skyblockstart_cloud.png"},
	drawtype = "allfaces",
	paramtype = "light",
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = false,
	post_effect_color = {a=200, r=255, g=255, b=255},
})

minetest.register_node("skyblockstart:portal", {
	description = "SkyBlock portal",
	inventory_image = minetest.inventorycube("skyblockstart_cloud.png"),
	drawtype = "liquid",
	tile_images = {"skyblockstart_cloud.png"},
	alpha = 140,
	paramtype = "light",
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	liquidtype = "source",
	liquid_alternative_flowing = "skyblockstart:portal_flowing",
	liquid_alternative_source = "skyblockstart:portal",
	liquid_viscosity = 1,
	post_effect_color = {a=200, r=255, g=255, b=255},
	special_materials = {
		{image="skyblockstart_cloud.png", backface_culling=false},
		{image="skyblockstart_cloud.png", backface_culling=true},
	},
})

minetest.register_node("skyblockstart:portal_flowing", {
	description = "SkyBlock portal (flowing)",
	inventory_image = minetest.inventorycube("skyblockstart_cloud.png"),
	drawtype = "flowingliquid",
	tile_images = {"skyblockstart_cloud.png"},
	alpha = 140,
	paramtype = "light",
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	liquidtype = "flowing",
	liquid_alternative_flowing = "skyblockstart:portal_flowing",
	liquid_alternative_source = "skyblockstart:portal",
	liquid_viscosity = 1,
	post_effect_color = {a=200, r=255, g=255, b=255},
	special_materials = {
		{image="skyblockstart_cloud.png", backface_culling=false},
		{image="skyblockstart_cloud.png", backface_culling=true},
	},
})

minetest.register_abm({
	nodenames = {"skyblockstart:portal"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if active_object_count_wider >= 1 then
			for _, obj in ipairs(minetest.env:get_objects_inside_radius(pos, 2)) do
				if obj:get_player_name() ~= nil then -- is it a player?
					lose_all_items(obj)
					obj:setpos(skyblockstart.teleportpos)
				end
			end
		end
	end
})


minetest.log("info", "SKyBlock mod loaded")
