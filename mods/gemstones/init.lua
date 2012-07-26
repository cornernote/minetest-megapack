--------------------------------------------------------------------------------
--    Gemstones!
--------------------------------------------------------------------------------
--    This mod adds gems such as rubies, sapphires, emeralds, etc. Tools and
--    "solid" blocks can be crafted from the gems.
--
--    (c) 2011 Fernando Zapata
--    Code licensed under GNU GPLv3
--    Content licensed under CC BY-SA 3.0
--
--    2011-12-04    13:26:40
--------------------------------------------------------------------------------

-- List containing the names and quantity of the ores --
minerallist = {}

---- Big, bad function to declare gems -----------------------------------------
register_gem = function( gemtype, rarity, basetime, durability, toolrules )

	-- Ores --
	mineralname = "gemstones:mineral_" .. gemtype
	mineraltex  = "default_stone.png^gemstones_mineral_" .. gemtype .. ".png"

	-- Gems/lumps --
	gemname     = "gemstones:gem_" .. gemtype
	gemtex      = "gemstones_gem_" .. gemtype .. ".png"
	craftname   = gemname

	-- Solid block --
	blockname   = "gemstones:block_" .. gemtype
	blocktex    = "gemstones_block_" .. gemtype .. ".png"

	table.insert( minerallist, { mineralname, rarity } )

	minetest.register_craftitem( gemname, {
		image = gemtex,
		on_place_on_ground = minetest.craftitem_place_item,
	} )

	-- Mineral block --
	minetest.register_node( mineralname, {
		tiles           = { mineraltex },
		inventory_image       = minetest.inventorycube( mineraltex ),
		is_ground_content     = true,
		material              = minetest.digprop_stonelike(1.0),
		drop                  = craftname .. ' 1',

	} )

	-- Solid block --
	minetest.register_node( blockname, {
		--drawtype              = "glasslike",
		tiles           = { blocktex },
		inventory_image       = blocktex,
		--alpha                 = 200,
		is_ground_content     = true,
		material              = minetest.digprop_glasslike(3.0),
	} )

	-- Tools, with "add_tool" by MarkTraceur
	register_tool_type("gemstones", gemtype, craftname, basetime, durability, toolrules)

	-- Crafting blocks --
	minetest.register_craft( {
		output                = blockname .. ' 1',
		recipe = {
			                { craftname,craftname,craftname },
			                { craftname,craftname,craftname },
			                { craftname,craftname,craftname },
		},
	} )

	minetest.register_craft( {
		output                = craftname .. ' 9',
		recipe = {
			                { blockname .. '"' },
		},
	} )
end

---- Create gems on chunk generation -------------------------------------------
-- celeron55 said:
-- "It is somewhat doable, but not very fancily. Off the top of my head
-- without any testing:"
-- + My fixes
local generate_gem = function( minp, maxp )
	for c, oreinfo in ipairs( minerallist ) do
		--print( oreinfo )
		local amount = math.random( 0, oreinfo[2] )
		for a = 0, amount do
			local pos = {
				x = math.random( minp.x, maxp.x ),
				y = math.random( minp.y, maxp.y ),
				z = math.random( minp.z, maxp.z ),
			}
			for i = -1, 1 do
				for j = -1, 1 do
					for k = -1, 1 do
						if math.random() > 0.2 then
							--continue
						else
							local p = { x=pos.x+i, y=pos.y+j, z=pos.z+k }
							local n = minetest.env:get_node( p )
							if n.name == "default:stone" then
								minetest.env:add_node( p, { name = oreinfo[1] } )
							end
						end
					end
				end
			end
		end
	end
end

minetest.register_on_generated( generate_gem )

---- Register new gemstones ----------------------------------------------------

---- Amethyst ----
-- Less durable but slightly faster than steel.
register_gem( "amethyst", 5, 0.9, 250,  { sword_time = 1 } )

---- Cubic Zirconia ----
-- Almost wood slow, but almost mese-like durability
register_gem( "czirconia", 5, 1.6, 1000, { sword_time = 1 } )

---- Emerald ----
-- Just a bit less durable than steel
register_gem( "emerald",  5, 1.0, 300,  { sword_time = 1 } )

---- Ruby ----
-- Faster, but much less durable than steel
register_gem( "ruby",     5, 0.7, 180,  { sword_time = 1 } )

---- Sapphire ----
-- Slow, but more durable than steel
register_gem( "sapphire", 5, 1.2, 500, { sword_time = 1 } )

---- Was loaded? ---------------------------------------------------------------
-- Just to be sure, may remove if you like.
print( " ++ loaded : Gemstones, by ZLovesPancakes" )
