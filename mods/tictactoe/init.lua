-- TIC-TAC-TOE BOARD MOD
-- by whiskers75

minetest.register_node ("tictactoe:x_on", {
    drawtype = signlike,
    description = "TicTacToe X",
    tiles = {"tttx.png"},
    inventory_image = {"tttx.png"},
    sunlight_propagates = true,
    paramtype = 'light',
    walkable = true,
    groups = {dig_immediate=2},
    material = minetest.digprop_constanttime(1.0),
   })

minetest.register_node ("tictactoe:o_on", {
    drawtype = signlike,
    description = "TicTacToe O",
    tiles = {"ttto.png"},
    inventory_image = {"ttto.png"},
    sunlight_propagates = true,
    paramtype = 'light',
    walkable = true,
    groups = {dig_immediate=2},
    material = minetest.digprop_constanttime(1.0),
   })

mesecon:add_receptor_node("tictactoe:x_on")
mesecon:add_receptor_node("tictactoe:o_on")

minetest.register_on_dignode(
	function(pos, oldnode, digger)
		if oldnode.name == "tictactoe:x_on" then
			mesecon:receptor_off(pos)
		end
	end
)
minetest.register_on_dignode(
	function(pos, oldnode, digger)
		if oldnode.name == "tictactoe:o_on" then
			mesecon:receptor_off(pos)
		end
	end
)

minetest.register_on_punchnode(function(pos, node, puncher)
	if node.name == "tictactoe:x_on" then
		mesecon:receptor_on(pos)
	end
end)

minetest.register_on_punchnode(function(pos, node, puncher)
	if node.name == "tictactoe:o_on" then
		mesecon:receptor_on(pos)
	end
end)
