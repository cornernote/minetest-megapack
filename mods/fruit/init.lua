-- Globals
grow_time = 40
max_fruit = 200
current_fruit = 0
current_fruit_list = {}
fruit_timer =0
--global step function








--entity definition
Apple_Entity = {

  hp_max = 1,
    physical = false,
    weight = 5,
    collisionbox = {-0,-0,-0, 0,0,0},
    visual = "sprite",
    visual_size = {x=1, y=1},
    textures = {"fruit_apple.png"}, -- number of required textures depends on visual
    is_visible = true,
    makes_footstep_sound = false,
    automatic_rotate = false,
    timer =0,

    on_step = function(self, dtime)
         pos = self.object:getpos()
        self.timer = self.timer + dtime
        if self.timer > grow_time   then

              self.object:remove()
              obj = minetest.env:add_item(pos, "fruit:apple")
              current_fruit = current_fruit +1
              current_fruit_list[current_fruit] = obj
        end

    end,
}
Bananna_Entity = {

  hp_max = 1,
    physical = false,
    weight = 5,
    collisionbox = {-0,-0,-0, 0,0,0},
    visual = "sprite",
    visual_size = {x=1, y=1},
    textures = {"fruit_bananna.png"}, -- number of required textures depends on visual
    is_visible = true,
    makes_footstep_sound = false,
    automatic_rotate = false,
    timer =0,

    on_step = function(self, dtime)
         pos = self.object:getpos()
        self.timer = self.timer + dtime
        if self.timer > grow_time    then

              self.object:remove()
               obj = minetest.env:add_item(pos, "fruit:bananna")
              current_fruit = current_fruit +1
              current_fruit_list[current_fruit] = obj
        end

    end,
}
Pear_Entity = {

  hp_max = -1,
    physical = false,
    weight = 5,
    collisionbox = {-0,-0,-0, 0,0,0},
    visual = "sprite",
    visual_size = {x=1, y=1},
    textures = {"fruit_pear.png"}, -- number of required textures depends on visual
    is_visible = true,
    makes_footstep_sound = false,
    automatic_rotate = false,
    timer =0,

    on_step = function(self, dtime)
         pos = self.object:getpos()
        self.timer = self.timer + dtime
        if self.timer > grow_time    then

              self.object:remove()
               obj = minetest.env:add_item(pos, "fruit:pear")
              current_fruit = current_fruit +1
              current_fruit_list[current_fruit] = obj
        end

    end,
}
Orange_Entity = {

  hp_max = -1,
    physical = false,
    weight = 5,
    collisionbox = {-0,-0,-0, 0,0,0},
    visual = "sprite",
    visual_size = {x=1, y=1},
    textures = {"fruit_orange.png"}, -- number of required textures depends on visual
    is_visible = true,
    makes_footstep_sound = false,
    automatic_rotate = false,
    timer =0 ,

    on_step = function(self, dtime)
         pos = self.object:getpos()
        self.timer = self.timer + dtime
        if self.timer > grow_time    then

              self.object:remove()
               obj = minetest.env:add_item(pos, "fruit:orange")
              current_fruit = current_fruit +1
              current_fruit_list[current_fruit] = obj
        end

    end,
}
-- register entities

 minetest.register_entity("fruit:Apple_Entity", Apple_Entity)
 minetest.register_entity("fruit:Pear_Entity", Pear_Entity)
 minetest.register_entity("fruit:Bananna_Entity", Bananna_Entity)
 minetest.register_entity("fruit:Orange_Entity", Orange_Entity)















--ABMs


minetest.register_abm(
{
    -- make fruit grow
    nodenames = {"default:leaves"},
    neighbors = {"default:air"}, -- (any of these)

    interval = 25, -- (operation interval)
    chance = 2000, -- (chance of trigger is 1.0/this)

    action = function(pos, node, active_object_count, active_object_count_wider)
           if current_fruit < max_fruit then
                   local fruit_pos   = {x=pos.x , y=pos.y -1, z=pos.z}
                   if minetest.env:get_node(fruit_pos).name == "air" then
                     local fruit
                     local fruit_num = math.random(1,100)
                          if fruit_num >= 1 and fruit_num < 40 then
                            fruit = "fruit:Apple_Entity"

                          end
                          if fruit_num >= 40 and fruit_num < 70 then
                            fruit = "fruit:Pear_Entity"

                          end
                          if fruit_num >= 70 and fruit_num < 90 then
                            fruit = "fruit:Bananna_Entity"
                     
                          end
                          if fruit_num >= 90 then
                            fruit =  "fruit:Orange_Entity"

                          end


                      obj=minetest.env:add_entity( fruit_pos,fruit)
                      print(fruit.." is growing at: X:"..fruit_pos.x..", Y:"..fruit_pos.y..", Z:"..fruit_pos.z.." : current fruit on ground: "..current_fruit)
                    end
                    
                    
            else
              fruit_timer = fruit_timer +1
               if fruit_timer > 100 then
                    local i =0
                     while i < current_fruit    do
                         i = i +1
                         current_fruit_list[i]:remove()

                     end
                     fruit_timer = 0
                     current_fruit = 0
               end
            end





              end ,

} )



--register craft items 


minetest.register_craftitem("fruit:apple", {
    description = "Apple",
    inventory_image = "fruit_apple.png",
    stack_max = 99,
    groups = {
              fruit=1,
              eatable=1,
    },
    on_use = minetest.item_eat(1),
    })
 minetest.register_craftitem("fruit:pear", {
    description = "Pear",
    inventory_image = "fruit_pear.png",
    stack_max = 99,
    groups = {
              fruit=1,
              eatable=1,
    },
   on_use = minetest.item_eat(3),
    })
  minetest.register_craftitem("fruit:bananna", {
    description = "Banana",
    inventory_image = "fruit_bananna.png",
    stack_max = 99,
    groups = {
              fruit=1,
              eatable=1,
    },
    on_use = minetest.item_eat(10),
    })
    
 minetest.register_craftitem("fruit:orange", {
    description = "Orange",
    inventory_image = "fruit_orange.png",
    stack_max = 99,
    groups = {
              fruit=1,
              eatable=1,
    },
    on_use = minetest.item_eat(20),
    })
    

    
