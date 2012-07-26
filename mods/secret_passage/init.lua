minetest.register_node('secret_passage:component', {
	drawtype = 'allfaces',
	tiles = minetest.registered_nodes["default:glass"].tiles,
	inventory_image = minetest.registered_nodes["default:glass"].inventory_image,
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	climbable = false,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	material = minetest.digprop_constanttime(1.0),
	description = "Component"
})
minetest.register_craft({
	output = 'secret_passage:component 1',
	recipe = {
		{'default:glass 1', 'default:glass 1', 'default:glass 1'},
		{'', 'default:dirt 1', ''},
	},
})
local default_typenames = {
	"dirt",
	"brick",
	"cobble",
	"wood",
	"sand",
	"stone",
	"tree",
	"glass",
	"jungletree",
	"mossycobble",
	"mese",
	"steelblock",
	"sandstone",
	"gravel",
	"clay",
	"leaves",
	"cactus",
	"papyrus",
	"bookshelf",
}
register_secret_passage = function(modnam, typename, crafttype)
   minetest.register_craft({
      output = modnam..':'..typename,
      recipe = {
         { "secret_passage:component", crafttype, "secret_passage:component"},
         { "secret_passage:component", crafttype, "secret_passage:component"}
      }
   })
   minetest.register_node('secret_passage:'..typename, {
	drawtype = 'allfaces',
	tiles = minetest.registered_nodes[crafttype].tiles,
	inventory_image = minetest.registered_nodes[crafttype].inventory_image,
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = false,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	material = minetest.digprop_constanttime(1.0),
	description = "False " .. string.lower(minetest.registered_nodes[crafttype].description),
   })
end
for _, typename in ipairs(default_typenames) do
	register_secret_passage("secret_passage", typename, 'default:'..typename)
end
