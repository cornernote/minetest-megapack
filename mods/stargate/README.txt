STARGATE mod
Created by SegFault22
----------------
This version is: 0.3
stuff in this version:
--A basic teleporter, made by making a ring of special cubes (5x5, center is 3x3 and hollowed-out)
--A very rare ore in crystaline form, NAQUEDA, that can be used to make gate blocks
recipe for gate blocks:
MSM
SNS
MSM
M = Mese
S = steel block
N = Naqueda Crystal
produces ONE gate block
--/give commands
-/giveme stargate:naqueda_crystals - naqueda crystals in ore form
-/giveme stargate:naqueda_crystal - naqueda crystal
-/giveme stargate:gateblock - block used to make the stargate
----------------
--these ''gates'' are IDed by the block you put in the center of the ring (use a glass
block for stargate A, steel block for stargate B) and teleport the player to the other gate
when the block in the center is hit.
----------------
Currently, to get the gates to work right, one must edit the init.lua file, and change the teleport
coordinates (as if each stargate is at 0,0,0, see Init.lua for details, and if you need help setting
it up, ask SegFault22)
By default, the coordinates of Stargate A are 0,0,0 and the coordinates of Stargate B are 0,-20000,0
It is planned to make the stargate work better in a later release someday (you won't have to set the
coordinates in init.lua, and teleporting will only require stepping through the gate)
It is HIGHLY recomended that this mod is not used in public servers UNTIL a stable version is released.
----------------
(please) Check the forum regularly for updates to this mod.
I plan to also add a device, the DHD, that can be used to input the
''address'' or ''ID'' of a stargate to go to with a stargate. Maybe even the weird blast of energy
that comes out of the gate when another gate is dialed with the DHD. But it will all be determined by
how much support I get for finishing this mod.
----------------
License: WTFPL
Note that you can modify this mod, to make simple teleporters, if you know how to edit the coordinates
of the pieces of the gate.
----------------
Thank you for downloading.