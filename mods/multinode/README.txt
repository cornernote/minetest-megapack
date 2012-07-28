[Mod] Multinode [20120720] [multinode]

Forum Page: http://minetest.net/forum/viewtopic.php?id=2398

License: WTFPL (applies to all parts)

Contributors:
mauvebic

Description:

Simple tool to manipulate multiple nodes from the chat interface. Like worldedit, though written from scratch
  
Chat commands [priv:server] 
/p1 (coords optional, defaults to player pos) define first corner
/giveme multinode:m1 (to use a node)
/p2 (coords optional, defaults to player pos) define opposite corner
/giveme multinode:m2 (to use a node)
/giveme multinode:pasteref   useful for setting the paste reference coords.
/clear    clear positions, clipboard and paste reference points
/reload   reloads the last set of multinode coords

/fill <nodename>  fills the area with given node
/fill -light     fix persistent shadows
/remove <nodename>     remove specific nodes from area
/remove -a   removes all nodes from the area
/replace <nodename> replace specific node from selection
/with <nodename>  what it should be replaced with
/doit    completes /replace /with
/copy    copy the selection
/saveas <building name> store contents of /copy for later use
/load <building name> load a saved building, use /paste to spawn.
/paste <+90|-90|+180 or leave empty>  paste the selection 
Spheres & hollow spheres
/p0   sets the center of the sphere (using your position)
/radius <number>   sets radius of the sphere, defaults to 12
/thickness <number>   sets thickness of hollow sphere, defaults to 1
/sphere <nodename> spawns a sphere
/hollowsphere <nodename> spawns a hollow sphere
    