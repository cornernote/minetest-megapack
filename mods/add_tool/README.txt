add_tool

Make it easier to add a tool type (e.g. gold tools, silver tools, etc.)
Copyright 2011 Mark Holmquist, licensed under GPLv3

syntax:
  register_tool_type(mod, type, crafttype, time, uses, extra_rules)
     mod = name of your mod
     type = type of tool
     crafttype = name of item used to craft the tool ('craft "default:cobble"' or similar)
     time = speed of the tool type (lower is faster)
     uses = durability
     extra_rules = a table with any extra rules. example:
        {shovel_durability = 40} -- increases the base durability of shovels by 40 uses
        {pick_speed = -0.2} -- decreases the amount of time taken per dig by 0.2 seconds for picks

Please note that, if you're adding your tools using this mod, it expects your texture to be of form
   [[modname]]_tool_[[type]]shovel.png
For example:
   moreores_tool_goldpick.png