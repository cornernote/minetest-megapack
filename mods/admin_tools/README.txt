[Mod] Admin Tools [admin_tools]

Homepage: http://minetest.net/forum/viewtopic.php?id=1144
License: WTFPL

Contributors:
randomproof

Description:

I was thinking there needs to be tools that let server admins to control their servers.  For now I have only made one tool. 

Tools:
Remove Stick - removes anything it hits (nodes or entities, not players though(yet))
Mainly this will allow you to remove locked chest and mobs.

Exported functions:

admin_tools.set_privilege(player_name, priv, value) - Allows you to set arbitrarily player privileges
player_name - string
priv - string
value - boolean

admin_tools.get_privileges(player_name, priv) - Checks the values set with admin_tools.set_privilege, returns false if not set yet
player_name - string
priv - string