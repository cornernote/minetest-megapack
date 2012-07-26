-- add_tool
-- Make it easier to add a tool type (e.g. gold tools, silver tools, etc.)
-- Copyright 2011 Mark Holmquist, licensed under GPLv3

-- syntax:
--   register_tool_type(mod, type, crafttype, time, uses, extra_rules)
--      mod = name of your mod
--      type = type of tool
--      crafttype = name of item used to craft the tool ('craft "default:cobble"' or similar)
--      time = speed of the tool type (lower is faster)
--      uses = durability
--      extra_rules = a table with any extra rules. example:
--         {shovel_durability = 40} -- increases the base durability of shovels by 40 uses
--         {pick_speed = -0.2} -- decreases the amount of time taken per dig by 0.2 seconds for picks

-- Please note that, if you're adding your tools using this mod, it expects your texture to be of form
--    [[modname]]_tool_[[type]]shovel.png
-- For example:
--    moreores_tool_goldpick.png

-- Updated by Calinou on 2011-01-23
-- For More Ores mod

register_tool_type = function(modname, labelname, typename, crafttype, basetime, basedurability, extra_rules)
   minetest.register_craft({
      description = labelname,
      output = 'tool "'..modname..':'..typename..'_pick'..'"',
      recipe = {
         { crafttype, crafttype, crafttype },
         { '', 'craft "default:stick"', ''},
         { '', 'craft "default:stick"', ''}
      }
   })

   minetest.register_craft({
      description = labelname,
      output = 'tool "'..modname..':'..typename..'_shovel'..'"',
      recipe = {
         { '', crafttype, '' },
         { '', 'craft "default:stick"', ''},
         { '', 'craft "default:stick"', ''}
      }
   })

   minetest.register_craft({
      description = labelname,
      output = 'tool "'..modname..':'..typename..'_axe'..'"',
      recipe = {
         { crafttype, crafttype },
         { crafttype, 'craft "default:stick"' },
         { '', 'craft "default:stick"'}
      }
   })

   minetest.register_craft({
      description = labelname,
      output = 'tool "'..modname..':'..typename..'_sword'..'"',
      recipe = {
         { crafttype },
         { crafttype },
         { 'craft "default:stick"' }
      }
   })

   local ft = basetime + (extra_rules.pick_speed or 0)
   local fd = basedurability + (extra_rules.pick_durability or 0)
   minetest.register_tool(modname..":"..typename.."_pick", {
      inventory_image = modname.."_tool_"..typename.."pick.png",
      basetime = ft,
      dt_weight = 0,
      dt_crackiness = -0.5,
   	dt_crumbliness = 2,
   	dt_cuttability = 0,
      basedurability = fd,
      dd_weight = 0,
   	dd_crackiness = 0,
   	dd_crumbliness = 0,
   	dd_cuttability = 0,
   })

   ft = basetime + (extra_rules.shovel_speed or 0)
   fd = basedurability + (extra_rules.shovel_durability or 0)
   minetest.register_tool(modname..":"..typename.."_shovel", {
      inventory_image = modname.."_tool_"..typename.."shovel.png",
      basetime = ft,
      dt_weight = 0.5,
      dt_crackiness = 2,
   	dt_crumbliness = -1.5,
   	dt_cuttability = 0,
      basedurability = fd,
      dd_weight = 0,
   	dd_crackiness = 0,
   	dd_crumbliness = 0,
   	dd_cuttability = 0,
   })

   ft = basetime + (extra_rules.axe_speed or 0)
   fd = basedurability + (extra_rules.axe_durability or 0)
   minetest.register_tool(modname..":"..typename.."_axe", {
      inventory_image = modname.."_tool_"..typename.."axe.png",
      basetime = ft,
      dt_weight = 0.5,
      dt_crackiness = -0.2,
   	dt_crumbliness = 1,
   	dt_cuttability = -0.5,
      basedurability = fd,
      dd_weight = 0,
   	dd_crackiness = 0,
   	dd_crumbliness = 0,
   	dd_cuttability = 0,
   })

   ft = basetime + (extra_rules.sword_speed or 0)
   fd = basedurability + (extra_rules.sword_durability or 0)
   minetest.register_tool(modname..":"..typename.."_sword", {
      inventory_image = modname.."_tool_"..typename.."sword.png",
      basetime = ft,
      dt_weight = 3,
      dt_crackiness = 0,
   	dt_crumbliness = 1,
   	dt_cuttability = -1,
      basedurability = fd,
      dd_weight = 0,
   	dd_crackiness = 0,
   	dd_crumbliness = 0,
   	dd_cuttability = 0,
   })
end
