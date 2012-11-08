 --get the firework model.
local modpath = minetest.get_modpath("fireworks2")

dofile (modpath .. "/model.lua")

BOOM_P_RED = {

  hp_max = 1,
    physical = true,
    weight = 5,
    collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
    visual = "sprite",
    visual_size = {x=1, y=1},
    textures = {"fireworks2_red_ember.png"}, -- number of required textures depends on visual
    is_visible = true,
    makes_footstep_sound = false,
    automatic_rotate = false,
    timer =0

}

function BOOM_P_RED.on_activate(self, dtime)

  if DX == nil then
  local DX =  math.random()* 8 - 4
  local DY =  math.random()* 8 - 4
  local DZ =  math.random()* 8 - 4
  gravity = 0.5
  if DY > -gravity then
      DY = DY - gravity
  end
  self.dir = {x=DX, y=DY, z=DZ}

  self.object:setvelocity({x=self.dir.x, y=self.dir.y, z=self.dir.z})
   end
end
function BOOM_P_RED.on_step(self, dtime)
   self.timer=self.timer+dtime
  pos = self.object:getpos()
  if pos.y < 20 then
     self.object:remove()

  end
  if self.timer > 3 then
    self.object:remove()
  end
end
BOOM_P_BLUE = {

  hp_max = 1,
    physical = true,
    weight = 5,
    collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
    visual = "sprite",
    visual_size = {x=1, y=1},
    textures = {"fireworks2_blue_ember.png"}, -- number of required textures depends on visual
    is_visible = true,
    makes_footstep_sound = false,
    automatic_rotate = false,
    timer =0

}

function BOOM_P_BLUE.on_activate(self, dtime)

  if DX == nil then
  local DX =  math.random()* 3 - 1.5
  local DY =  math.random()* 5 - 2
  local DZ =  math.random()* 3 - 1.5
  gravity = 0.5
  if DY > -gravity then
      DY = DY - gravity
  end
  self.dir = {x=DX, y=DY, z=DZ}

  self.object:setvelocity({x=self.dir.x, y=self.dir.y, z=self.dir.z})
   end
end
function BOOM_P_BLUE.on_step(self, dtime)
   self.timer=self.timer+dtime
  pos = self.object:getpos()
  if pos.y < 20 then
     self.object:remove()

  end
  if self.timer > 3 then
    self.object:remove()
  end
end
 BOOM_P_WHITE = {

  hp_max = 1,
    physical = true,
    weight = 5,
    collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
    visual = "sprite",
    visual_size = {x=1, y=1},
    textures = {"fireworks2_white_ember.png"}, -- number of required textures depends on visual
    is_visible = true,
    makes_footstep_sound = false,
    automatic_rotate = false,
    timer =0

}

function BOOM_P_WHITE.on_activate(self, dtime)

  if DX == nil then
  local DX =  math.random()* 3 - 1.5
  local DY =  math.random()* 3 - 1
  local DZ =  math.random()* 3 - 1.5
  gravity = 0.5
  if DY > -gravity then
      DY = DY - gravity
  end
  self.dir = {x=DX, y=DY, z=DZ}

  self.object:setvelocity({x=self.dir.x, y=self.dir.y, z=self.dir.z})
   end
end
function BOOM_P_WHITE.on_step(self, dtime)
   self.timer=self.timer+dtime
  pos = self.object:getpos()
  if pos.y < 20 then
     self.object:remove()

  end
  if self.timer > 3 then
    self.object:remove()
  end
end
BOOM_P_GREEN = {

  hp_max = 1,
    physical = true,
    weight = 5,
    collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
    visual = "sprite",
    visual_size = {x=1, y=1},
    textures = {"fireworks2_green_ember.png"}, -- number of required textures depends on visual
    is_visible = true,
    makes_footstep_sound = false,
    automatic_rotate = false,
    timer =0

}

function BOOM_P_GREEN.on_activate(self, dtime)

  if DX == nil then
  local DX =  math.random()* 5 - 2.5
  local DY =  math.random()* 5 - 2.5
  local DZ =  math.random()* 5 - 2.5
  gravity = 0.5
  if DY > -gravity then
      DY = DY - gravity
  end
  self.dir = {x=DX, y=DY, z=DZ}

  self.object:setvelocity({x=self.dir.x, y=self.dir.y, z=self.dir.z})
   end
end
function BOOM_P_GREEN.on_step(self, dtime)
   self.timer=self.timer+dtime
  pos = self.object:getpos()
  if pos.y < 20 then
     self.object:remove()

  end
  if self.timer > 3 then
    self.object:remove()
  end
end




minetest.register_entity("fireworks2:red_ember", BOOM_P_RED)
minetest.register_entity("fireworks2:blue_ember", BOOM_P_BLUE)
minetest.register_entity("fireworks2:white_ember", BOOM_P_WHITE)
minetest.register_entity("fireworks2:green_ember", BOOM_P_GREEN)
minetest.register_abm(
{
    -- In the following two fields, also group:groupname will work.
    nodenames = {"fireworks2:rocket"},
   -- (any of these)
     --^ If left out or empty, any neighbor will do
    interval = 1, -- (operation interval)
    chance = 1, -- (chance of trigger is 1.0/this)

    action = function(pos, node, active_object_count, active_object_count_wider)



                     local pos2 = {x=pos.x,y=pos.y + 1, z=pos.z}

                      local meta = minetest.env:get_meta(pos)
                      print("Rocket:start_posY: "..meta:get_int("start_posY"))
                     if pos2.y > meta:get_int("start_posY") + 10 then
                       local Chance = math.random(1,10)
                       if Chance > 8 and meta:get_int("start_posY") ~= 0 then
                          minetest.env:set_node(pos2, {name="fireworks2:lighting"})
                          minetest.env:remove_node(pos, {name="fireworks2:rocket"})

                         local color =  math.random(1,4)
                         local num = math.random(25,49)
                         local num2 = 0
                         if color == 1 then
                           while  num > num2 do

                             minetest.env:add_entity( {x=pos.x,y=pos.y +1 ,z=pos.z },"fireworks2:red_ember")
                             num2 = num2 + 1

                           end
                          end
                           if color == 2  then
                            while  num > num2 do

                             minetest.env:add_entity( {x=pos.x,y=pos.y +1 ,z=pos.z },"fireworks2:blue_ember")
                             num2 = num2 + 1

                           end
                           end
                           if color == 3 then
                            while  num > num2 do

                             minetest.env:add_entity( {x=pos.x,y=pos.y +1 ,z=pos.z },"fireworks2:white_ember")
                             num2 = num2 + 1

                           end
                           end
                            if color == 4  then
                             while  num > num2 do

                             minetest.env:add_entity( {x=pos.x,y=pos.y +1 ,z=pos.z },"fireworks2:green_ember")
                             num2 = num2 + 1

                           end
                           end

                           pos = {x=pos.x,y=3,z=pos.z}
                           pos2 =  {x= pos.x, y=pos.y, z=pos.z}
                           --play sound--
                minetest.sound_play( 'fireworks2_boom', {
                                                    pos = pos,
                                                    gain = 0.3,
                                                    max_hear_distance = 50,
                                                })

                     end
                 end
              end,
})

minetest.register_abm(
{
    -- In the following two fields, also group:groupname will work.
    nodenames = {"fireworks2:lighting"},
    neighbors = {"default:air"}, -- (any of these)
     --^ If left out or empty, any neighbor will do
    interval = 13, -- (operation interval)
    chance = 1, -- (chance of trigger is 1.0/this)

    action = function(pos, node, active_object_count, active_object_count_wider)

                  minetest.env:remove_node(pos, {name="fireworks2:lighting"})
              end ,
} )
minetest.register_abm(
{
    -- In the following two fields, also group:groupname will work.
    nodenames = {"fireworks2:launcher"},
    neighbors = {"default:air"}, -- (any of these)
     --^ If left out or empty, any neighbor will do
    interval = 200, -- (operation interval)
    chance = 1, -- (chance of trigger is 1.0/this)

    action = function(pos, node, active_object_count, active_object_count_wider)

                  minetest.env:remove_node(pos, {name="fireworks2:launcher"})
              end ,
} )




 minetest.register_craft({
	output = 'fireworks2:launcher',
	recipe = {
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
		{'default:iron_lump', 'default:iron_lump', 'default:iron_lump'},
		{'default:iron_lump', 'default:iron_lump', 'default:iron_lump'},
	}
})


