--yo, mobs
--licensed under GPL v2 or later
--contains code from darkrose and sfan5

local t = "default_cactus_top.png"
local s = "default_cactus_side.png"

local vscale = 0.2
local voff = 0.5-vscale
local vw = vscale/4

local offsets = {
   [0]={ x=-vw, z=  0 },
   [1]={ x=-vw, z= vw },
   [2]={ x=  0, z= vw },
   [3]={ x= vw, z= vw },
   [4]={ x= vw, z=  0 },
   [5]={ x= vw, z=-vw },
   [6]={ x=  0, z=-vw },
   [7]={ x=-vw, z=-vw },
   }
minetest.register_entity("wobblycactus:mob",
                         {
                            physical = true,
                            collisionbox = { 0, 0, 0, 0, 0, 0 },
                            visual = "sprite",
                            textures = { t, t, s, s, s, s },
                            visual_size = { x = 0.1, y = 0.1 },
                            automatic_rotate = false,

                            on_activate = function(self, staticdata)
                               self.num = math.random(2, 4)
                               local pos = self.object:getpos()

                               self.segments = {}
                               self.step = 1
                               self.hp = 3
                               self.pop = moven

                               for i=0, self.num do
                                  local np = { x=pos.x, y=pos.y+i*vscale*2, z=pos.z }
                                  local seg = minetest.env:add_entity(np, "wobblycactus:seg"):get_luaentity()
                                  seg.parent = self
                                  seg.step = i
                                  seg.boom = explode
                                  table.insert(self.segments, seg)
                               end
                            end,

                            on_punch = function (self)
                               print(dump(self.num))
                            end,

                            on_step = function (self, dtime)
                               self.step = self.step + 1

                               if self.step%5 ~= 0 then return end

                               if self.step%5 == 0 then
                                  for i, e in ipairs( self.segments )  do
                                     if i ~= 1 then
                                        local pos = e.object:getpos()
                                        local wob = offsets[(e.step)%8]
                                        local wpos = {x=pos.x+wob.x, y=pos.y, z=pos.z+wob.z}
                                        e.object:moveto(wpos, true)
                                     end
                                     e.step = e.step + 1
                                     if e.step > 40 then e.step = 1 end
                                  end
                               end
                               if self.step%40 == 0 then
                                  self.step = 0
                                  self:pop()
                               end
                            end
                         })

minetest.register_entity("wobblycactus:seg",
                         {
                            physical = true,
                            collisionbox = { -vscale, -vscale, -vscale, vscale, vscale, vscale },
                            visual = "cube",
                            textures = { t, t, s, s, s, s },
                            visual_size = { x = vscale*2, y = vscale*2 },
                            automatic_rotate = false,

                            parent,
                            off,
                            
                            on_punch = function(self, puncher)
                               if not self.parent then
                                  self.object:remove()
                                  return
                               end
                               self.parent:pop(nil, 8)
                               self.parent.hp = self.parent.hp-1
                               if self.parent.hp<1 then
                                  for i, e in pairs(self.parent.segments) do
                                     e:boom()
                                  end
                                  self.parent.object:remove()
                               end
                               
                            end
                         })

minetest.register_entity("wobblycactus:frag",
                         {
                            physical = true,
                            collisionbox = { 0, 0, 0, 0, 0, 0 },
                            visual = "cube",
                            textures = { t, t, s, s, s, s },
                            visual_size = { x = 1/8, y = 1/8 },
                            automatic_rotate = false,

                            timer = 0,
                            on_step = function(self, dtime)
                               self.timer = self.timer + dtime
                               if self.timer > math.random(1, 3) then
                                  self.object:remove()
                               end
                            end,
                            on_activate = function(self, staticdata)
                               self.object:setacceleration({x=0, y=-7.5, z=0})
                            end,
                         })

explode = function (self)
   local pos = self.object:getpos()
   self.object:remove()
   for x = 1,5,1 do
      local e = minetest.env:add_entity({
                                           x=pos.x+1-(math.random()*1.5),
                                           y=pos.y+0.25,z=pos.z+1-(math.random()*1.5)}, "wobblycactus:frag")
      e:setvelocity({x=math.random(),y=1,z=math.random()})
   end   
end

moven = function(self, puncher, range)
   local r = range or 1
   local pos = self.object:getpos()
   local inf = {x=pos.x+math.random(-r,r), y=pos.y, z=pos.z+math.random(-r,r)}
   local und = {x=inf.x, y=pos.y-1.0, z=inf.z}
   local infn = minetest.env:get_node(inf)
   local undn = minetest.env:get_node(und)
   local npos = pos
   if minetest.registered_nodes[minetest.env:get_node({x=pos.x,y=pos.y-1,z=pos.z}).name].walkable == false then
      npos = {x=pos.x,y=pos.y-1,z=pos.z}
   elseif minetest.registered_nodes[infn.name].walkable == false and minetest.registered_nodes[undn.name].walkable then
      -- Create node and remove entity
      if undn.name == 'air' then
         local uu = minetest.env:get_node({und.x,und.y-1,und.z})
         if minetest.registered_nodes[uu.name].walkable == false then return end
         inf.y = pos.y-1
      end
      npos = inf
   elseif minetest.registered_nodes[infn.name].walkable then
      local abv = {x=inf.x,y=inf.y+1-voff, z=inf.z}
      local abvn = minetest.env:get_node(abv)
      if abvn.name ~= 'air' then return end
      npos = abv
   end

   self.object:moveto(npos, true)
   for i=0, #self.segments-1 do
      local epos = {x=npos.x, y=npos.y+i*vscale*2, z=npos.z}
      self.segments[i+1].object:moveto(epos, true)
   end
   
end

spawn_on_surface = function(nname)
   minetest.register_abm({
                            nodenames = { "default:dirt_with_grass" },
                            interval = 1200,
                            chance = 30,
                            action = function(pos, node, active_object_count, active_object_count_wider)
                               local p_top = {
                                  x = pos.x,
                                  y = pos.y + 1-voff,
                                  z = pos.z
                               }
                               local n_top = minetest.env:get_node(p_top)
                               local rnd = math.random(1, 4)
                               
                               if n_top.name == "air" then
                                  if rnd == 1 then
                                     if not minetest.env:find_node_near(p_top, 40, nname) then
                                        --would like something like find_entity_near() here
                                        minetest.env:add_entity(p_top, nname)
                                     end
                                  end
                               end
                            end
                         })
end

spawn_on_surface("wobblycactus:mob")
