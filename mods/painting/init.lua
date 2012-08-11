-- painting - in-game painting for minetest-c55

-- THIS MOD CODE AND TEXTURES LICENSED 
--            <3 TO YOU <3
--    UNDER TERMS OF GPL LICENSE

-- 2012 obneq aka jin xi

-- a picture is drawn using a node(box) to draw the supporting canvas
-- and an entity which has the painting as it's texture.
-- this texture is created by minetest-c55's internal image
-- compositing engine (see tile.cpp).

dofile(minetest.get_modpath("painting").."/crafts.lua")

textures = {
   white = "white.png", yellow = "yellow.png", 
   orange = "orange.png", red = "red.png", 
   violet = "violet.png", blue = "blue.png", 
   green = "green.png", magenta = "pink.png", 
   cyan = "cyan.png", lightgrey = "lightgrey.png",
   darkgrey = "darkgrey.png", black = "black.png" 
}   

res = 16
thickness = 0.1

-- picture node
picbox = {
   type = "fixed",
   fixed = { -0.499, -0.499, 0.499, 0.499, 0.499, 0.499 - thickness }
}

picnode =  {                                                    
   description = "pic",                          
   tiles = { "white.png" },
   inventory_image = "painted.png",
   drawtype = "nodebox",
   sunlight_propagates = true,
   paramtype = "light",
   paramtype2 = "facedir",
   node_box = picbox,
   selection_box = picbox,
   groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2 },
   
   --handle that right below, don't drop anything
   drop = "",
   
   after_dig_node=function(pos, oldnode, oldmetadata, digger)
      --find and remove the entity
      local objects = minetest.env:get_objects_inside_radius(pos, 0.5)
      for _, e in ipairs(objects) do
         if e:get_luaentity().name == "painting:picent" then
            e:remove()
         end
      end
      
      --put picture data back into inventory item
      local data = oldmetadata.fields["painting:picturedata"]
      local item = { name = "painting:paintedcanvas", count = 1, metadata = data } 
      digger:get_inventory():add_item("main", item)
   end
}

-- picture texture entity

paintbox1 = { -0.5,-0.5,0,0.5,0.5,0 }
paintbox2 = { 0,-0.5,-0.5,0,0.5,0.5 }

picent = {
   collisionbox = { 0, 0, 0, 0, 0, 0 },
   visual = "upright_sprite",
   textures = { "white.png" },

   on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
      local ppos = puncher:getpos()
      --get player eye level
      ppos = { x = ppos.x, y = ppos.y+(1.5 + 1/16), z = ppos.z }

      local pos = self.object:getpos()
      local l = puncher:get_look_dir()

      local d = dirs[self.fd]
      local od = dirs[(self.fd + 1) % 4]
      local normal = { x = d.x, y = 0, z = d.z }
      local p = intersect(ppos, l, pos, normal)
      
      local off = -0.5
      pos = { x = pos.x + off * od.x, y=pos.y + off, z=pos.z + off * od.z }
      p = sub(p, pos)
      local x = math.abs(p.x + p.z)
      local y = p.y

      x = round(x/(1/res))
      y = round((1-y)/(1/res))

      x = clamp(x)
      y = clamp(y-1)

      local name = puncher:get_wielded_item():get_name()
      name = string.split(name, "_")[2]
      local t = textures[name]
      if t then
         self.grid[x][y]=colors[name]
         self.object:set_properties({textures = { to_imagestring(self.grid) }})
      end
   end,

  on_activate = function(self, staticdata)
      local pos = self.object:getpos()
      local meta = minetest.env:get_meta(pos)
      local data = meta:get_string("painting:picturedata")

      if data == "" then
         self.grid = initgrid()
      else
         data = minetest.deserialize(data)
         data = to_imagestring(data)
         self.object:set_properties({textures = { data }})
      end
  end
}

--paintedcanvas picture inventory item
paintedcanvas = {
   inventory_image = "painted.png",
   stack_max = 1,
   
   on_place = function(itemstack, placer, pointed_thing)
      --place node
      local placerpos = placer:getpos()
      local pos = pointed_thing.above
      local dir = {x = pos.x - placerpos.x, y = pos.y - placerpos.y, z = pos.z - placerpos.z}
      local fd = minetest.dir_to_facedir(dir)

      local pic = minetest.env:add_node(pos, { name = "painting:pic",
                                               param2 = fd,
                                               paramtype2 = "none" })
      
      --save metadata
      local data = itemstack:get_metadata()
      local meta = minetest.env:get_meta(pos)
      meta:set_string("painting:picturedata", data)

      --add entity
      dir = dirs[fd]
      local off = 0.5-thickness-0.01
      
      local np = { x = pos.x + dir.x*off,
                   y = pos.y,
                   z = pos.z + dir.z*off}
      
      data = minetest.deserialize(data)
      data = to_imagestring(data)
      
      local p = minetest.env:add_entity(np, "painting:picent"):get_luaentity()
      p.object:set_properties({textures = { data }})
      p.object:setyaw(math.pi*fd/-2)
      
      return ItemStack("")
   end
}

--canvas inventory item
canvas = {
        inventory_image = "default_paper.png",
        stack_max = 99,
}

--canvas for drawing
canvasbox = {
   type = "fixed",
   fixed = { -0.5, -0.5, 0.0, 0.5, 0.5, thickness }
}

canvasnode = {
   description = "canvas",
   tiles = { "white.png" },
   inventory_image = "painted.png",
   drawtype = "nodebox",
   sunlight_propagates = true,
   paramtype = "light",
   paramtype2 = "facedir",
   node_box = canvasbox,
   selection_box = canvasbox,
   groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2 },

   drop = "",

   on_construct = function(pos)
      local easel = minetest.env:get_node({ x = pos.x, y = pos.y - 1, z = pos.z})
      local fd = easel.param2
      local dir = dirs[fd]
      pos = {x = pos.x - 0.01 * dir.x, y = pos.y, z = pos.z - 0.01 * dir.z}

      local p = minetest.env:add_entity(pos, "painting:picent"):get_luaentity()
      p.object:setyaw(math.pi*easel.param2/-2)
      p.fd = easel.param2
      p.grid = initgrid()
      if fd == 0 or fd == 2 then 
         p.object:set_properties({ collisionbox = paintbox1 })
      else
         p.object:set_properties({ collisionbox = paintbox2 })
      end
   end,

   after_dig_node=function(pos, oldnode, oldmetadata, digger)
      --get data and remove pixels
      local data
      local objects = minetest.env:get_objects_inside_radius(pos, 0.5)
      for _, e in ipairs(objects) do
         e = e:get_luaentity()
         if e.grid then
            data = e.grid
         end
         e.object:remove()
      end

      if data then
         local item = { name = "painting:paintedcanvas", count = 1, metadata = minetest.serialize(data) }
         digger:get_inventory():add_item("main", item)
      end
   end
}

-- easel
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

easel = {
   description = "easel",
   tiles = { "default_wood.png" },
   drawtype = "nodebox",
   sunlight_propagates = true,
   paramtype = "light",
   paramtype2 = "facedir",
   node_box = easelbox,
   selection_box = easelbox,
   
   groups = { snappy = 2, choppy = 2, oddly_breakable_by_hand = 2 },
   
   on_punch = function(pos, node, player)
      local wielded = player:get_wielded_item():get_name()
      if wielded ~= "painting:canvas" then
         return
      end    
      local meta = minetest.env:get_meta(pos)       
      local np  = { x = pos.x, y = pos.y+1, z = pos.z }
      
      if minetest.env:get_node(np).name == "air" then 
         minetest.env:add_node(np, { name = "painting:canvasnode",
                                     param2 = node["param2"],
                                     paramtype2 = "none" })
      end
      
      meta:set_int("has_canvas", 1)
      local itemstack = ItemStack("painting:canvas")
      player:get_inventory():remove_item("main", itemstack)  
   end,
   
   can_dig = function(pos,player)
      local meta = minetest.env:get_meta(pos)
      local inv = meta:get_inventory()
      
      if meta:get_int("has_canvas") == 0 then
         return true
      end
      return false
   end
}

--brushes

brush = {                  
   description = "brush",
   inventory_image = "default_tool_steelaxe.png",
   wield_image = "",
   wield_scale = {x=1,y=1,z=1},
   stack_max = 99,
   liquids_pointable = false,
   tool_capabilities = {
      full_punch_interval = 1.0,
      max_drop_level=0,
      groupcaps = {}
   }
}

minetest.register_entity("painting:picent", picent)
minetest.register_node("painting:pic", picnode) 

minetest.register_craftitem("painting:canvas", canvas)
minetest.register_craftitem("painting:paintedcanvas", paintedcanvas)
minetest.register_node("painting:canvasnode", canvasnode)

minetest.register_node("painting:easel", easel)

colors = {}
revcolors = {}

for color, _ in pairs(textures) do
   table.insert(revcolors, color)
   
   minetest.register_tool("painting:brush_"..color, brush)
end

for i, color in ipairs(revcolors) do
   colors[color] = i
end

minetest.register_alias("easel", "painting:easel")
minetest.register_alias("canvas", "painting:canvas")

function initgrid()
   local grid, x, y = {}
   for x = 0, res-1 do
      grid[x] = {}
      for y = 0, res-1 do
         grid[x][y] = colors["white"]
      end
   end
   return grid
end

function to_imagestring(data)
   if not data then return end
   local imagestring = "[combine:"..res.."x"..res..":"
   for y = 0, res-1 do
      for x = 0, res-1 do
         imagestring  = imagestring..x..","..y.."="..revcolors[ data[x][y] ]..".png:"
      end
   end
   return imagestring
end

dirs = {
   [0] = { x = 0, z = 1 },
   [1] = { x = 1, z = 0 },
   [2] = { x = 0, z =-1 },
   [3] = { x =-1, z = 0 } }

function sub(v, w)
   return { x = v.x - w.x,
            y = v.y - w.y,
            z = v.z - w.z }
end

function dot(v, w)
   return  v.x * w.x + v.y * w.y + v.z * w.z
end

function intersect(pos, dir, origin, normal)
   local t = -(dot(sub(pos, origin), normal)) / dot(dir, normal)
   return { x = pos.x + dir.x * t,
            y = pos.y + dir.y * t,
            z = pos.z + dir.z * t }
end

function round(num)
   return math.floor(num+0.5)
end

function clamp(num)
   if num < 0 then
      return 0
   elseif num > 15 then
      return 15
   else
      return num
   end
end
