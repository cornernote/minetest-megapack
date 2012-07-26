--crafting
--[[
   the idea is to create an easel, which allows to "craft", ie paint 8x8 pics

   palettes: tool, crafted from 9 dyes, use giveme

   canvas: item, crafted from 9 paper

   hit easel with canvas

   hit easel with palette

   right-click easel

   place 64 dyes... 

   take picture

   build pic

   THIS MOD CODE AND TEXTURES LICENSED 
          <3 TO YOU <3
   UNDER TERMS OF WTFPL LICENSE

   --]]
textures =
   {
      white_paint = "white.png", yellow = "yellow.png", 
      orange = "orange.png", red = "red.png", 
      violet= "violet.png", blue = "blue.png", 
      green = "green.png", magenta = "pink.png", 
      cyan = "cyan.png", lightgrey_paint = "lightgrey.png",
      darkgrey_paint = "darkgrey.png", black = "black.png" 
   }

for n,p in pairs(textures) do
   minetest.register_entity("painting:pixel_"..n, 
                            {
                               physical = true,
                               collisionbox = { -0.01, -0.01, -0.01, 0, 0, 0 },
                               visual = "cube",
                               textures = { p, p, p, p, p, p },
                               visual_size = { x = 1/8, y = 1/8 },
                               automatic_rotate = true,
                            }
                           )
   minetest.register_craftitem("painting:swatch_"..n,
                               {
                                  groups = { dye = 1 },
                                  inventory_image = p
                               }
                              )
end

minetest.register_craft(
   {
      output = 'painting:easel 1',
      recipe = {
         { 'default:wood', '' },
         { 'default:wood', 'default:wood' },
         { 'default:stick', 'default:stick' },
      }
   })

minetest.register_craft(
   {
      output = 'painting:palette 1',
      recipe = {
         { 'group:dye', 'group:dye', 'group:dye' },
         { 'group:dye', 'group:dye', 'group:dye' },
         { 'group:dye', 'group:dye', 'group:dye' },       
      },
   })

minetest.register_craft(
   {
      output = 'painting:canvas 1',
      recipe = {
         { 'default:paper', 'default:paper', 'default:paper' },
         { 'default:paper', 'default:paper', 'default:paper' },
         { 'default:paper', 'default:paper', 'default:paper' },
      },
   })

minetest.register_craft(
   {
      output = 'painting:paintedcanvas 1',
      recipe = {
         { 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye' }, 
         { 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye' },       
         { 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye' },       
         { 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye' },       
         { 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye' },       
         { 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye' },       
         { 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye' },       
         { 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye', 'group:dye' },     
      },
   })

minetest.register_craftitem("painting:paintedcanvas", {
        inventory_image = "painted.png",
        stack_max = 1,
        
        on_place=function(itemstack, placer, pointed_thing)
           local picturestring = minetest.deserialize(itemstack:get_metadata())

           local placerpos = placer:getpos()
           local pos = pointed_thing.above
           local dir = {x = pos.x - placerpos.x, y = pos.y - placerpos.y, z = pos.z - placerpos.z}
           local fd = minetest.dir_to_facedir(dir)

           local pic = minetest.env:add_node(pos, { name = "painting:pic",
                                                    param2=fd,
                                                    paramtype2= 'none' })
           local meta = minetest.env:get_meta(pos)
           meta:set_string("picturestring", itemstack:get_metadata())

           local name = minetest.hash_node_position(pos)

           if fd == 0 then
              xd = 1; zd = -1
              xx = 1; zz=0
           elseif fd == 1 then              
              xd = -1; zd = -1
              xx = 0; zz=-1
           elseif fd == 2 then
              xd = -1; zd = 1
              xx = -1; zz=0
           elseif fd == 3 then
              xd = 1; zd = 1
              xx = 0; zz=1
           end
           
           local i = 1
           for y = 0, 7 do
              for x = 0, 7 do
                 local npos = {x = pos.x - (0.5-1/16) * xd + x/8*xx,
                               y = pos.y + (0.5-1/16) - y/8,
                               z = pos.z - (0.5-1/16) * zd + x/8*zz}
                 
                 local p = minetest.env:add_entity(npos, "painting:pixel_"..picturestring[i])
                 p:get_luaentity().name = name
                 i = i + 1
              end
           end
           return ItemStack("")
        end
        
})

testbox = {
   type = "fixed",
   fixed = { -0.49, -0.49, 0.49, 0.49, 0.49, 0.38 }
}

selbox = {
   type = "fixed",
   fixed = { -0.5, -0.5, 0.5, 0.5, 0.5, 0.375 }
}

minetest.register_node("painting:pic", {                                                    
                          description = 'pic',                          
                          tiles = { "white.png" },
                          inventory_image = "red.png",
                          drawtype = "nodebox",
                          sunlight_propagates = true,
                          paramtype = 'light',
                          paramtype2 = "facedir",
                          node_box = testbox,
                          selection_box = selbox,
                          groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2 },
                          drop = "",

                          on_destruct=function(pos)
                             local name = minetest.hash_node_position(pos)
                             for i, e in pairs(minetest.luaentities) do
                                if e.name == name then
                                   e.object:remove()
                                end
                             end
                          end,

                          after_dig_node=function(pos, oldnode, oldmetadata, digger)  
                             local item = {name="painting:paintedcanvas", count=1, metadata=oldmetadata.fields["picturestring"]}
                             digger:get_inventory():add_item("main", item)
                          end,
}) 

minetest.register_craftitem("painting:canvas", {
        inventory_image = "default_paper.png",
        stack_max = 99,
})

minetest.register_craftitem("painting:palette", {
	inventory_image = "palette.png",
	stack_max = 1,
})

canvasbox = {
   type = "fixed",
   fixed = { -0.5, -0.54, 0.0, 0.5, 0.4, 0.09 }
}

minetest.register_node(
   "painting:canvasnode",
   {
      description = 'canvas',
      tiles = { "white.png" },
      drawtype = "nodebox",
      sunlight_propagates = true,
      paramtype = 'light',
      paramtype2 = "facedir",
      node_box = canvasbox,
      selection_box = canvasbox,
      groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2},
      
      can_dig = function ()
          return false
      end,

      on_punch = function(pos, node, player)
         local wielded = player:get_wielded_item():get_name()
         if wielded ~= "painting:palette" then
            return
         end
         local easel = { x = pos.x, y = pos.y - 1, z = pos.z }
         local meta = minetest.env:get_meta(easel)
         local inv = meta:get_inventory()
         local randpic = {}
         for i=0, 64 do
            --local rand = colors[math.random(0, 12)]
            --how the fuck  do i get from a random number to
            --a color from textures... it boggles my mind.
            inv:set_stack("canvas", i, "painting:swatch_red")
         end

         local canvaslist = inv:get_list("canvas")
         local srclist = inv:get_list("src")
         local painted = nil

         if canvaslist then
            painted = minetest.get_craft_result({ method = "normal", width = 8, items = canvaslist })
         end

         if painted then
            inv:set_stack("dst", 1, painted.item)
         end
      end
   })

easelbox = {
   type="fixed",
   fixed = {
      --feet
      {-0.4, -0.5, -0.5, -0.3, -0.4, 0.5 },
      { 0.3, -0.5, -0.5,  0.4, -0.4, 0.5 },
      --legs
      {-0.4, -0.4, 0.1, -0.3, 1.5, 0.2 },            
      { 0.3, -0.4, 0.1,  0.4, 1.5, 0.2 },
      --shelf
      {-0.5, 0.35, -0.3, 0.5, 0.45, 0.1 }
   }
}

minetest.register_node(
   "painting:easel",
   {
      description = 'easel',
      tiles = { "default_wood.png" },
      drawtype = "nodebox",
      sunlight_propagates = true,
      paramtype = 'light',
      paramtype2 = "facedir",
      node_box = easelbox,
      selection_box = easelbox,

      groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2 },
      
      on_construct = function(pos)
         local meta = minetest.env:get_meta(pos)
         meta:set_int("has_canvas", 0)
         meta:set_int("has_palette", 0)
         meta:set_string(
            "formspec",
            "invsize[8,11;]"..
               "list[context;canvas; 0, 0; 8, 8;]"..
               "list[context;palette; 1, 8.5; 6,2;]"..
               "list[context;src; 0, 9; 1, 1;]"..
               "list[context;dst; 7, 9; 1, 1;]")
         meta:set_string("infotext", "easel")
         
         local inv = meta:get_inventory()
         inv:set_size("canvas", 8*8)
         inv:set_size("palette", 6*2)
         inv:set_size("src", 1)
         inv:set_size("dst", 1)
      end,
       
      on_punch = function(pos, node, player)
         local wielded = player:get_wielded_item():get_name()
         if wielded ~= 'painting:palette' and 
            wielded ~= 'painting:canvas' then
            return
         end    
         local meta = minetest.env:get_meta(pos)
         local inv = meta:get_inventory()
         if wielded == "painting:palette" and 
            meta:get_int("has_palette") == 0 then
            local i = 1
            for n,p in pairs(textures) do
               inv:set_stack("palette", i, "unifieddyes:"..n)
               i = i + 1
            end
            meta:set_int("has_palette", 1)
            local itemstack = ItemStack("painting:palette")
            player:get_inventory():remove_item("main", itemstack)
         elseif meta:get_int("has_canvas") == 0 then
            inv:set_stack("src", 1, "painting:canvas")
            
            local np  = { x = pos.x, y= pos.y+1, z=pos.z }
            if minetest.env:get_node(np).name == "air" then 
               minetest.env:add_node(np, { name="painting:canvasnode",
                                           param2=node["param2"],
                                           paramtype2='none' })
            end
            meta:set_int("has_canvas", 1)
            local itemstack = ItemStack("painting:canvas")
            player:get_inventory():remove_item("main", itemstack)
         end
      end,
      
      can_dig = function(pos,player)
         local meta = minetest.env:get_meta(pos)
         local inv = meta:get_inventory()
         if inv:is_empty("canvas") and inv:is_empty("src") and 
            inv:is_empty("dst") and inv:is_empty("palette") then
            return true
         end
         return false
      end,

      on_metadata_inventory_move = function(pos, from_list, from_index,
                                            to_list, to_index, count, player)
         local meta = minetest.env:get_meta(pos)
         local inv = meta:get_inventory()
         local col = inv:get_stack("palette", from_index)
         local name = col:get_name()
         local swatch = "painting:swatch_"..name:sub(13)

         if from_list == "palette" then
            inv:set_stack("canvas", to_index, swatch)
         end

         local canvaslist = inv:get_list("canvas")
         local srclist = inv:get_list("src")
         local painted = nil

         if canvaslist then
            painted = minetest.get_craft_result({ method = "normal", width = 8, items = canvaslist })
         end

         if painted then
            inv:set_stack("dst", 1, painted.item)
         else
            inv:set_stack("dst", 1, nil)
         end
      end,

      on_metadata_inventory_take = function(pos, listname, index, count, player)
         --[[ TODO: 
              ability to move colors in canvas
              fill whole canvas with right click or so
            --]]
         if listname == "dst" then
            local meta = minetest.env:get_meta(pos)
            local inv = meta:get_inventory()
            local canvaslist = inv:get_list("canvas")
            
            local mypic = {}
            
            for i=1, #canvaslist do
               local n = canvaslist[i]:get_name()
               n=n:sub(string.len("painting:swatch_")+1)
               table.insert(mypic, n)
               --commented out for ease of debugging... it takes a while to
               --fill an 8x8 crafting table
               --inv:set_stack("canvas", i, nil)
            end
            
            local str = minetest.serialize(mypic)
            local item = {name="painting:paintedcanvas", count=1, metadata=str}
            player:get_inventory():add_item("main", item)

            
            inv:set_stack("src", 1, nil)
            inv:set_stack("dst", 1, nil)
            meta:set_int("has_canvas", 0)
            meta:set_int("has_palette", 0)
            local np  = {x = pos.x, y = pos.y + 1, z = pos.z}
            --remove canvasnode
            if minetest.env:get_node(np).name == "painting:canvasnode" then 
               minetest.env:remove_node(np)
            end
         end
      end
   })

minetest.register_alias('easel', 'painting:easel')
minetest.register_alias('pic', 'painting:pic')
minetest.register_alias('palette', 'painting:palette')
minetest.register_alias('canvas', 'painting:canvas')
