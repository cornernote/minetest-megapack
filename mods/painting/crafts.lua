-- painting - in-game painting for minetest-c55

-- THIS MOD CODE AND TEXTURES LICENSED 
--            <3 TO YOU <3
--    UNDER TERMS OF GPL LICENSE

-- 2012 obneq aka jin xi

minetest.register_craft({
      output = 'painting:easel 1',
      recipe = {
         { '', 'default:wood', '' },
         { '', 'default:wood', '' },
         { 'default:stick','', 'default:stick' },
      }})

minetest.register_craft({
      output = 'painting:palette 1',
      recipe = {
         { 'group:dye', 'group:dye', 'group:dye' },
         { 'group:dye', '', 'group:dye' },
         { 'group:dye', 'group:dye', 'group:dye' },       
      }})

minetest.register_craft({
      output = 'painting:canvas 1',
      recipe = {
         { 'default:paper', 'default:paper', 'default:paper' },
         { 'default:paper', 'default:paper', 'default:paper' },
         { 'default:paper', 'default:paper', 'default:paper' },
      }})
