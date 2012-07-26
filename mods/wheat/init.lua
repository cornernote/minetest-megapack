math.randomseed(os.time())

--[[

Author: Victor Hackeridze hackeridze@gmail.com
VERSION: 0.9.11
LICENSE: GPLv3
TODO: 

]]

PLANTS_GROW_INTERVAL = 90 -- interval in ABMs for plants
PLANTS_GROW_CHANCE = 6 -- chance in ABMs for plants
PLANTS_VISUAL_SCALE = 1.19 -- visualscale for plants



local WHEAT_STATES = {
	'1',
	'2', 
	'3',
	'4',
	'5',
	'6',
	'7',
	--'final',
}

local DIRT_BED_TO_GRASS = {
	"zhive_belarus:sprout_1",
	"zhive_belarus:sprout_2",
	"zhive_belarus:sprout_3",
	"zhive_belarus:sprout_4",
	"zhive_belarus:sprout_5",
	"zhive_belarus:sprout_6",
	"wheat:wheat_1",
	"wheat:wheat_2",
	"wheat:wheat_3",
	"wheat:wheat_4",
	"wheat:wheat_5",
	"wheat:wheat_6",
	"wheat:wheat_7",
	"wheat:wheat_final",
	"watermelon:watermelon_sprout_1",
	"watermelon:watermelon_sprout_2",
	"watermelon:watermelon_sprout_3",
	"watermelon:watermelon_sprout_4",
	"watermelon:watermelon_sprout_5",
	"watermelon:watermelon_sprout_6",
	"watermelon:watermelon_sprout_final",
	"pumpkin:pumpkin_sprout_1",
	"pumpkin:pumpkin_sprout_2",
	"pumpkin:pumpkin_sprout_3",
	"pumpkin:pumpkin_sprout_4",
	"pumpkin:pumpkin_sprout_5",
	"pumpkin:pumpkin_sprout_6",
	"pumpkin:pumpkin_sprout_final",
	"hruschev:corn_sprout_1",
	"hruschev:corn_sprout_2",
	"hruschev:corn_sprout_3",
	"hruschev:corn_sprout_4",
	"hruschev:corn_sprout_5",

}

local LIGHT = 5 -- amount of light neded to wheat grow

-- ABMs
minetest.register_abm({
	nodenames = {"wheat:wheat_1","wheat:wheat_2","wheat:wheat_3","wheat:wheat_4",
										   "wheat:wheat_5","wheat:wheat_6","wheat:wheat_7"},
	interval = PLANTS_GROW_INTERVAL/3*2,
	chance = PLANTS_GROW_CHANCE/2,
		action = function(pos, node, _, __)
			local l = minetest.env:get_node_light(pos, nil)
			local p = pos
			local rnd = math.random(1, 3)
			p.y = p.y - 1 -- it will change pos too, that cause using p.y = p.y + 1
			local under_node = minetest.env:get_node(p)
			if (l >= LIGHT) and (under_node.name == "wheat:dirt_bed") and (rnd == 1) then
				local nname  --= 'wheat:wheat_final' 
				if node.name == "wheat:wheat_1" then 

						nname = 'wheat:wheat_2'

				elseif node.name == "wheat:wheat_2" then

						nname = 'wheat:wheat_3'

				elseif  node.name == 'wheat:wheat_3' then

						nname = 'wheat:wheat_4'

				elseif  node.name == 'wheat:wheat_4' then

						nname = 'wheat:wheat_5'

				elseif  node.name == 'wheat:wheat_5' then

						nname = 'wheat:wheat_6'

				elseif  node.name == 'wheat:wheat_6' then

						nname = 'wheat:wheat_7'
					
				else nname = 'wheat:wheat_final' end
				p.y = p.y + 1 -- magic
				minetest.env:remove_node(pos)
				minetest.env:add_node(pos, { name = nname })
			end
		end
}) 

minetest.register_abm({
	nodenames = "wheat:dirt_bed",
	interval = 40,
	chance = 3,
		action = function(pos, node, _, __)
			local p = {x = pos.x,y = pos.y +1,z = pos.z}
			local above_node = minetest.env:get_node(p)

			for i, plant in ipairs(DIRT_BED_TO_GRASS) do
				if (above_node.name == plant) then return; end			 
			end
			minetest.env:remove_node(pos)
			minetest.env:add_node(pos, {name = "default:dirt"})
		end
})-- ABMs end

-- Nodes
for i, state in ipairs(WHEAT_STATES) do
	minetest.register_node("wheat:wheat_" .. state, {
		drawtype = "plantlike",
		tiles = {"wheat_wheat_" .. state .. ".png"},
		inventory_image = "wheat_wheat_" .. state .. ".png",
		paramtype = "light",
		is_ground_content = true,
		walkable = false,
		wall_mounted = false,
		visual_scale = PLANTS_VISUAL_SCALE,
		drop = {
			max_items = 1,
			items = {
				{
					items = {'wheat:wheat_seeds'},
					rarity = 10,
				},
			}
		},
		groups = {snappy = 3, flammable = 2},
		selection_box = {
			type = "fixed",
			fixed = {-1/2, -1/2, -1/2, 1/2, -0.4, 1/2},
		},
		sounds = default.node_sound_leaves_defaults(),
		stack_max = 128,
	})
end

minetest.register_node("wheat:wheat_final", {
	drawtype = "plantlike",
	tiles = {"wheat_wheat_final.png"},
	inventory_image = "wheat_wheat_final.png",
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	drop = {
		max_items = 3,
		items = {
			{
				items = {'wheat:wheat_seeds 1'},
				rarity = 1,
			},
			{
				items = {'wheat:wheat_seeds 1'},
				rarity = 2,
			},
			{
				items = {'wheat:wheat_seeds 1'},
				rarity = 5,
			},
		},
	},
	groups = {snappy = 3, flammable = 2},
	wall_mounted = false,
	visual_scale = PLANTS_VISUAL_SCALE,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -0.4, 1/2},
	},
	sounds = default.node_sound_leaves_defaults(),
	stack_max = 128,
}) 

minetest.register_node("wheat:dirt_bed", {
	tiles = {"wheat_bed.png", "default_dirt.png"},
	inventory_image = minetest.inventorycube("default_dirt.png"),
	is_ground_content = true,
	description = "Dirt bed",
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
	drop = "default:dirt",
	stack_max = 128,
})

-- Nodes end

-- Craftitems
minetest.register_craftitem("wheat:wheat_seeds", {
	image = "wheat_wheat_seeds.png",
	usable = true,
	dropcount = 10,
	liquids_pointable = false,
	on_place_on_ground = minetest.craftitem_place_item,
	on_use = function(item, player, pointed_thing)
		if pointed_thing.type == "node" then
			n = minetest.env:get_node(pointed_thing.under)
			if n.name == "wheat:dirt_bed" then
				minetest.env:add_node(pointed_thing.above, {name="wheat:wheat_1"})
				item:take_item(); return item
			end
		end
	end,
	stack_max = 128,
}) -- Craftitems end
