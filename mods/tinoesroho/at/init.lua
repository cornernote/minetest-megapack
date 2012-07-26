

-- Tinoesroho's AuTomated Trader
-- Depends on money mod & moreores
-- Version 0.2
-- Released under terms of CC-ATTRIB-BY-SA

-- Setting properties
minetest.register_node("at:at",
 {
	description = "AuTomated Trader",

	tile_images = {"at.png"},

	is_ground_content = true,

	material = minetest.digprop_constanttime(999.0),

	paramtype = "facedir_simple",

	metadata_name = "generic",
})

minetest.register_node("at:at_block_steel", {
	description = "AuTomated Trader",
	tile_images = {"at_block_steel.png"},
	is_ground_content = true,
	material = minetest.digprop_constanttime(999.0),
	paramtype = "facedir_simple",
	metadata_name = "generic",
})


minetest.register_on_placenode(function(pos, newnode, placer) if newnode.name == "at:at" then	local meta = minetest.env:get_meta(pos)
	meta:set_infotext("PAWNCH with INGOT to get COINS.") elseif newnode.name == "at:at_block_steel" then
 local meta = minetest.env:get_meta(pos)	meta:set_infotext("PAWNCH WITH COIN TO GET INGOT.") end end)

-- On PAWNCHING


minetest.register_on_punchnode(function(pos, node, puncher) 	
if node.name == "at:at" then
hit_with = puncher:get_wielded_item()

hit_with_name = hit_with:get_name()
		
hit_with_count = hit_with:get_count()
				
if hit_with_name == "moreores:copper_ingot" then

	puncher:get_inventory():remove_item("main", hit_with)
puncher:get_inventory():add_item("main", "money:coin_gold")

minetest.chat_send_player(puncher:get_player_name(), 'Thank you for using a Tinoesroho AuTomated trader!')
  elseif hit_with_name == "moreores:tin_ingot" then

puncher:get_inventory():remove_item("main", hit_with)
puncher:get_inventory():add_item("main", "money:coin_silver")

minetest.chat_send_player(puncher:get_player_name(), 'Thank you for using a Tinoesroho AuTomated trader!')
elseif hit_with_name == "moreores:silver_ingot" then

puncher:get_inventory():remove_item("main", hit_with)
puncher:get_inventory():add_item("main", "money:coin_gold 3")

minetest.chat_send_player(puncher:get_player_name(), 'Thank you for using a Tinoesroho AuTomated trader!')
elseif hit_with_name == "moreores:gold_ingot" then

puncher:get_inventory():remove_item("main", hit_with)
puncher:get_inventory():add_item("main", "money:coin_gold 6" )

minetest.chat_send_player(puncher:get_player_name(), 'Thank you for using a Tinoesroho AuTomated trader!')
elseif hit_with_name == "default:cactus" then

puncher:get_inventory():remove_item("main", hit_with)
puncher:get_inventory():add_item("main", "money:coin_copper")

minetest.chat_send_player(puncher:get_player_name(), 'Thank you for using a Tinoesroho AuTomated trader!')
end elseif node.name == "at:at_block_steel" then
hit_with = puncher:get_wielded_item()

hit_with_name = hit_with:get_name()
		
hit_with_count = hit_with:get_count()
				
if hit_with_name == "money:coin_gold" then
puncher:get_inventory():remove_item("main", hit_with)
puncher:get_inventory():add_item("main", "default:steel_ingot ")

end end 
end)
	 

print("[Tinoesroho's AuTomated Trader] Loaded & Ready to TRADE!")