[Mod] Minecraft-Like Node drop

Forum Page: http://minetest.net/forum/viewtopic.php?pid=34817


Contributors:
LorenzoVulcan


INSTALL:

open item.lua, inside minetest.node_dig(), 
replace:
digger:get_inventory():add_item("main", dropped_item)
with:
minetest.env:add_item(pos,dropped_item);