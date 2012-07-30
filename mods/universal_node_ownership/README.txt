[mod] Universal Node Ownership

Forum Page: http://minetest.net/forum/viewtopic.php?pid=34814


Contributors:
mauvebic


Description:

Each node placed records its owner. Blocks placed by the server mapgen, or mods, are diggable. Nodes with owners can be removed using worldedit or multinode, or whatever tool mod that removes nodes instead of digging them.


Installation:

add to /buitin/builtin.lua, just below misc_register:
dofile(minetest.get_modpath("__builtin").."/universal_node_ownership.lua")
