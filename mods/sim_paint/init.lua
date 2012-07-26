-- Modified paintings mod.
-- The original is by jordan4ibanez.
-- My changes are licensed under either CC-0 or WTFPL. You can do what
-- you want with my changes.

minetest.register_node("sim_paint:canvas", {
  description = "Painting",
  drawtype = "signlike",
  tiles = {"sim_paint_canvas.png"},
  inventory_image = "sim_paint_canvas.png",
  wield_image = "sim_paint_canvas.png",
  paramtype = "light",
  paramtype2 = "wallmounted",
  sunlight_propagates = true,
  walkable = false,
  paramtype2 = 'wallmounted',
  groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3},
  selection_box = {
    type = "wallmounted",
    --wall_top = <default>
    --wall_bottom = <default>
    --wall_side = <default>
  },
  material = minetest.digprop_constanttime(0.5),
  furnace_burntime = 10,
  legacy_wallmounted = true,
})

minetest.register_craft({
  output = 'sim_paint:canvas',
  recipe = {
    { 'default:stick', 'default:stick', 'default:stick'},
    { 'default:stick', 'default:paper', 'default:stick'},
    { 'default:stick', 'default:stick', 'default:stick'},
  },
})

-- Shortcut function for defining paintings.

function register_painting(id, image)
  minetest.register_node("sim_paint:id_" .. tostring(id), {
    drawtype = "signlike",
    tiles = {image},
    inventory_image = image,
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    paramtype = 'light',
    paramtype2 = 'wallmounted',
    drop = 'sim_paint:canvas',
    groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3},
    selection_box = {
      type = "wallmounted",
      --wall_top = <default>
      --wall_bottom = <default>
      --wall_side = <default>
    },
    material = minetest.digprop_constanttime(0.0),
    furnace_burntime = 10,
    legacy_wallmounted = true
  })
end

-- Paintings can be added by adding to the list below.
--
-- Example:
--   local paintings = {
--     "paintings_fluttershy.png",
--     "paintings_pinkiepie.png"
--   }
--
-- This will register two paintings. Their names start at "sim_paint:id_1",
-- and increment: "sim_paint:id_2" "sim_paint:id_3" and so on.
--
-- The corresponding image filename is used as the texture. Yay? :)
--

local paintings = {
  "paintings_foresight.png",
  "paintings_apocalypse.png",
  "paintings_memories.png",
  "paintings_pinkamena.png",
  "paintings_sepia.png",
  "paintings_sugar.png",
  "paintings_expected.png",
  "paintings_sleeping.png"
}

-- Below is very important code.

local AMOUNT_OF_PAINTING_TYPES = #paintings
for i=1,AMOUNT_OF_PAINTING_TYPES do
  register_painting(i, paintings[i])
end

--RANDOM GIVER
  
minetest.register_on_placenode(function(pos, newnode, placer)
  --first section detects if it is the base painting
  if newnode.name == "sim_paint:canvas" then
    --param.2 detects the state that this object is placed in and stores it
    local state = newnode.param2

    --this makes the game generate a random number
    local i = math.random(1, AMOUNT_OF_PAINTING_TYPES)

    --removes the painting_canvas
    if minetest.env:remove_node(pos) then
      minetest.env:add_node(pos, {name="sim_paint:id_" .. tostring(i),param2=state})
    end
 end
end)

