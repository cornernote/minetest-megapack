function x(val)
 return ((val -80) / 160)
end

function z(val) 
 return ((val -80) / 160)
end

function y(val)
	return ((val + 80) / 160)
end

local textures_launcher = {
			"fireworks2_launcher_top.png",  --bottom
			"fireworks2_launcher_top.png",     --top
			"fireworks2_launcher_front.png",    --right
			"fireworks2_launcher_front.png",   --left
			"fireworks2_launcher_front.png",     --front
			"fireworks2_launcher_front.png",      --back
}
local textures_blank = {
			"fireworks2_blank.png",  --bottom
			"fireworks2_blank.png",     --top
			"fireworks2_blank.png",    --right
			"fireworks2_blank.png",   --left
			"fireworks2_blank.png",     --front
			"fireworks2_blank.png",      --back
}

local nodebox_rocket ={
        -- I use this only as a 0 point marker. I find it esier to build the model with it in place so i know where 0 is and there for know which way to go sculpting wise.
        --{x(0),y(0),z(0),x(5),y(5),z(5)},
	--Top

	{x(75),y(0),z(75),x(85),y(-10),z(85)},
        {x(70),y(-10),z(70),x(90),y(-20),z(90)},
        {x(65),y(-20),z(65),x(95),y(-30),z(95)},

	--shaft

        {x(85),y(-150),z(85),x(75),y(-10),z(75)},
         --xfin
        {x(70),y(-100),z(75),x(90),y(-110),z(85)},
        {x(65),y(-110),z(75),x(95),y(-120),z(85)},
        {x(60),y(-120),z(75),x(100),y(-130),z(85)},
        {x(55),y(-130),z(75),x(105),y(-140),z(85)},
        {x(50),y(-140),z(75),x(110),y(-150),z(85)},

        --zfin

        {x(75),y(-100),z(70),x(85),y(-110),z(90)},
        {x(75),y(-110),z(65),x(85),y(-120),z(95)},
        {x(75),y(-120),z(60),x(85),y(-130),z(100)},
        {x(75),y(-130),z(55),x(85),y(-140),z(105)},
        {x(75),y(-140),z(50),x(85),y(-150),z(110)},
}
local nodebox_launcher ={


            --{x(0),y(0),z(0),x(5),y(5),z(5)},

            {x(150),y(0),z(75),x(160),y(-50),z(85)},
            {x(105),y(0),z(75),x(115),y(-50),z(85)},
            {x(55),y(0),z(75),x(65),y(-50),z(85)},
            {x(5),y(0),z(75),x(15),y(-50),z(85)},
            {x(0),y(-50),z(90),x(160),y(-180),z(25)},
}

 minetest.register_node("fireworks2:launcher", {
    drawtype = "nodebox",
    tiles = textures_launcher,
     param1 = ""  ,
     paramtype = "light" ,
     param2 = ""  ,
      is_ground_content = true,
      walkable = true, -- If true, objects collide with node
    pointable = true,
     digable = true,
     timer=0,
     start_posY =0,
     node_box = {
		type = "fixed",
		fixed = nodebox_launcher
		},

    on_timer = function(pos,elapsed)
         if elapsed > 0.5  then
         


    minetest.env:add_node( {x=pos.x ,y=pos.y +1 ,z=pos.z },{name="fireworks2:rocket"})
     local meta = minetest.env:get_meta({x=pos.x ,y=pos.y +1 ,z=pos.z })
          meta:set_int("start_posY", pos.y)
          print("Launcher:start_posY: "..meta:get_int("start_posY"))
     minetest.sound_play( 'fireworks2_launch', {
                                                    pos = pos,
                                                    gain = 0.3,
                                                    max_hear_distance = 50,
                                                })
           T = minetest.env:get_node_timer(pos)
           T:set(8,0)
          end
        return true
    end,
    after_place_node  =  function(pos)
         T = minetest.env:get_node_timer(pos)

           T:start(8)

     
     end,





})
  minetest.register_node("fireworks2:rocket", {
    drawtype = "nodebox",
    tiles =  textures_launcher,
     param1 = ""  ,
     paramtype = "light" ,
     timer=0,
     digable = false,
     walkable = false, -- If true, objects collide with node
     pointable = false,
     node_box = {
		type = "fixed",
		fixed = nodebox_rocket
		},

     on_construct =  function(pos)
        T = minetest.env:get_node_timer(pos)


           T:start(1)

     
     end,

      on_timer = function(pos,elapsed)
      if elapsed > 0  then
        local pos2 = {x=pos.x,y=pos.y + 1, z=pos.z}

       local meta1 = minetest.env:get_meta(pos)
       local SP = meta1:get_int("start_posY")
       minetest.env:set_node(pos2, {name="fireworks2:rocket"})
       minetest.env:remove_node(pos, {name="fireworks2:rocket"})
       local meta2 = minetest.env:get_meta(pos2)
          meta2:set_int("start_posY", SP)
      end



      return true
        end,




     
     
     
     


})
  minetest.register_node("fireworks2:lighting", {
    drawtype = "normal",
     tiles =  textures_blank,
     param1 = ""  ,
     paramtype = "light" ,
    light_source = 50,



})




