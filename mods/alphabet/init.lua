--
--
-- Alphabet mod cactuz_pl
-- v 0.2 (09_july_2012)
-- 
-- Contains: upper case (A-Z) and lower case (a-z) letters, numbers (0-9) and symbols (!@#$%^&*()-_=+\/?,.:')
--
-- Licence: GNU GPL
--
-------------- 
--Lower case
-- a
minetest.register_node('alphabet:a', {
	tiles = {'lower_a.png'},
	inventory_image = 'lower_a.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "a"
})
minetest.register_craft({
	output = 'alphabet:a 1',
	recipe = {
		{'default:dirt', '', ''},
		{'', '', 'default:wood'}
		
	},
})
-- b
minetest.register_node('alphabet:b', {
	tiles = {'lower_b.png'},
	inventory_image = 'lower_b.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "b"
})
minetest.register_craft({
	output = 'alphabet:b 1',
	recipe = {
		{'default:dirt', '', ''},
		{'default:dirt', '', 'default:wood'}
	}
})
-- c
minetest.register_node('alphabet:c', {
	tiles = {'lower_c.png'},
	inventory_image = 'lower_c.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "c"
})
minetest.register_craft({
	output = 'alphabet:c 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'', '', 'default:wood'}
		
	}
})
--d
minetest.register_node('alphabet:d', {
	tiles = {'lower_d.png'},
	inventory_image = 'lower_d.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "d"
})
minetest.register_craft({
	output = 'alphabet:d 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'', 'default:dirt', 'default:wood'}
	}
})
--e
minetest.register_node('alphabet:e', {
	tiles = {'lower_e.png'},
	inventory_image = 'lower_e.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "e"
})
minetest.register_craft({
	output = 'alphabet:e 1',
	recipe = {
		{'default:dirt', '', ''},
		{'', 'default:dirt', 'default:wood'}
	}
})
--f
minetest.register_node('alphabet:f', {
	tiles = {'lower_f.png'},
	inventory_image = 'lower_f.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "f"
})
minetest.register_craft({
	output = 'alphabet:f 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', '', 'default:wood'}
	}
})
--g
minetest.register_node('alphabet:g', {
	tiles = {'lower_g.png'},
	inventory_image = 'lower_g.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "g"
})
minetest.register_craft({
	output = 'alphabet:g 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', 'default:wood'}
	}
})
--h
minetest.register_node('alphabet:h', {
	tiles = {'lower_h.png'},
	inventory_image = 'lower_h.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "h"
})
minetest.register_craft({
	output = 'alphabet:h 1',
	recipe = {
		{'default:dirt', '', ''},
		{'default:dirt', 'default:dirt', 'default:wood'}
	}
})
--i
minetest.register_node('alphabet:i', {
	tiles = {'lower_i.png'},
	inventory_image = 'lower_i.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "i"
})
minetest.register_craft({
	output = 'alphabet:i 1',
	recipe = {
		{'', 'default:dirt', ''},
		{'default:dirt', '', 'default:wood'}
	}
})
--j
minetest.register_node('alphabet:j', {
	tiles = {'lower_j.png'},
	inventory_image = 'lower_j.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "j"
})
minetest.register_craft({
	output = 'alphabet:j 1',
	recipe = {
		{'', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', 'default:wood'}
	}
})
--k
minetest.register_node('alphabet:k', {
	tiles = {'lower_k.png'},
	inventory_image = 'lower_k.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "k"
})
minetest.register_craft({
	output = 'alphabet:k 1',
	recipe = {
		{'default:dirt', '', ''},
		{'', '', 'default:wood'},
		{'default:dirt', '', ''}
	}
})
--l
minetest.register_node('alphabet:l', {
	tiles = {'lower_l.png'},
	inventory_image = 'lower_l.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "l"
})
minetest.register_craft({
	output = 'alphabet:l 1',
	recipe = {
		{'default:dirt', '', ''},
		{'default:dirt', '', 'default:wood'},
		{'default:dirt', '', ''}
	}
})
--m
minetest.register_node('alphabet:m', {
	tiles = {'lower_m.png'},
	inventory_image = 'lower_m.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "m"
})
minetest.register_craft({
	output = 'alphabet:m 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'', '', 'default:wood'},
		{'default:dirt', '', ''}
	}
})
--n
minetest.register_node('alphabet:n', {
	tiles = {'lower_n.png'},
	inventory_image = 'lower_n.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "n"
})
minetest.register_craft({
	output = 'alphabet:n 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'', 'default:dirt', 'default:wood'},
		{'default:dirt', '', ''}
	}
})
--o
minetest.register_node('alphabet:o', {
	tiles = {'lower_o.png'},
	inventory_image = 'lower_o.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "o"
})
minetest.register_craft({
	output = 'alphabet:o 1',
	recipe = {
		{'default:dirt', '', ''},
		{'', 'default:dirt', 'default:wood'},
		{'default:dirt', '', ''}
	}
})
--p
minetest.register_node('alphabet:p', {
	tiles = {'lower_p.png'},
	inventory_image = 'lower_p.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "p"
})
minetest.register_craft({
	output = 'alphabet:p 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', '', 'default:wood'},
		{'default:dirt', '', ''}
	}
})
--q
minetest.register_node('alphabet:q', {
	tiles = {'lower_q.png'},
	inventory_image = 'lower_q.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "q"
})
minetest.register_craft({
	output = 'alphabet:q 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', 'default:wood'},
		{'default:dirt', '', ''}
	}
})
--r
minetest.register_node('alphabet:r', {
	tiles = {'lower_r.png'},
	inventory_image = 'lower_r.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "r"
})
minetest.register_craft({
	output = 'alphabet:r 1',
	recipe = {
		{'default:dirt', '', ''},
		{'default:dirt', 'default:dirt', 'default:wood'},
		{'default:dirt', '', ''}
	}
})
--s
minetest.register_node('alphabet:s', {
	tiles = {'lower_s.png'},
	inventory_image = 'lower_s.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "s"
})
minetest.register_craft({
	output = 'alphabet:s 1',
	recipe = {
		{'', 'default:dirt', ''},
		{'default:dirt', '', 'default:wood'},
		{'default:dirt', '', ''}
	}
})
--t
minetest.register_node('alphabet:t', {
	tiles = {'lower_t.png'},
	inventory_image = 'lower_t.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "t"
})
minetest.register_craft({
	output = 'alphabet:t 1',
	recipe = {
		{'', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', 'default:wood'},
		{'default:dirt', '', ''}
	}
})
--u
minetest.register_node('alphabet:u', {
	tiles = {'lower_u.png'},
	inventory_image = 'lower_u.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "u"
})
minetest.register_craft({
	output = 'alphabet:u 1',
	recipe = {
		{'default:dirt', '', ''},
		{'', '', 'default:wood'},
		{'default:dirt', 'default:dirt', ''}
	}
})
--v
minetest.register_node('alphabet:v', {
	tiles = {'lower_v.png'},
	inventory_image = 'lower_v.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "v"
})
minetest.register_craft({
	output = 'alphabet:v 1',
	recipe = {
		{'default:dirt', '', ''},
		{'default:dirt', '', 'default:wood'},
		{'default:dirt', 'default:dirt', ''}
	}
})
--w
minetest.register_node('alphabet:w', {
	tiles = {'lower_w.png'},
	inventory_image = 'lower_w.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "w"
})
minetest.register_craft({
	output = 'alphabet:w 1',
	recipe = {
		{'', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', 'default:wood'},
		{'', 'default:dirt', ''}
	}
})
--x
minetest.register_node('alphabet:x', {
	tiles = {'lower_x.png'},
	inventory_image = 'lower_x.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "x"
})
minetest.register_craft({
	output = 'alphabet:x 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'', '', 'default:wood'},
		{'default:dirt', 'default:dirt', ''}
	}
})
--y
minetest.register_node('alphabet:y', {
	tiles = {'lower_y.png'},
	inventory_image = 'lower_y.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "y"
})
minetest.register_craft({
	output = 'alphabet:y 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'', 'default:dirt', 'default:wood'},
		{'default:dirt', 'default:dirt', ''}
	}
})
--z
minetest.register_node('alphabet:z', {
	tiles = {'lower_z.png'},
	inventory_image = 'lower_z.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "z"
})
minetest.register_craft({
	output = 'alphabet:z 1',
	recipe = {
		{'default:dirt', '', ''},
		{'', 'default:dirt', 'default:wood'},
		{'default:dirt', 'default:dirt', ''}
	}
})
--Upper case
-- A
minetest.register_node('alphabet:A', {
	tiles = {'upper_A.png'},
	inventory_image = 'upper_A.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "A"
})
minetest.register_craft({
	output = 'alphabet:A 1',
	recipe = {
		{'default:dirt', '', 'default:wood'}

		
	},
})
-- B
minetest.register_node('alphabet:B', {
	tiles = {'upper_B.png'},
	inventory_image = 'upper_B.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "B"
})
minetest.register_craft({
	output = 'alphabet:B 1',
	recipe = {
		{'default:dirt', '', 'default:wood'},
		{'default:dirt', '', ''}

	},
})
-- C
minetest.register_node('alphabet:C', {
	tiles = {'upper_C.png'},
	inventory_image = 'upper_C.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "C"
})
minetest.register_craft({
	output = 'alphabet:C 1',
	recipe = {
		{'default:dirt', 'default:dirt', 'default:wood'}
		
	}
})
--D
minetest.register_node('alphabet:D', {
	tiles = {'upper_D.png'},
	inventory_image = 'upper_D.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "D"
})
minetest.register_craft({
	output = 'alphabet:D 1',
	recipe = {
		{'default:dirt', 'default:dirt', 'default:wood'},
		{'', 'default:dirt', ''}
	}
})
--E
minetest.register_node('alphabet:E', {
	tiles = {'upper_E.png'},
	inventory_image = 'upper_E.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "E"
})
minetest.register_craft({
	output = 'alphabet:E 1',
	recipe = {
		{'default:dirt', '', 'default:wood'},
		{'', 'default:dirt', ''}
	}
})
--F
minetest.register_node('alphabet:F', {
	tiles = {'upper_F.png'},
	inventory_image = 'upper_F.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "F"
})
minetest.register_craft({
	output = 'alphabet:F 1',
	recipe = {
		{'default:dirt', 'default:dirt', 'default:wood'},
		{'default:dirt', '', ''}
	}
})
--G
minetest.register_node('alphabet:G', {
	tiles = {'upper_G.png'},
	inventory_image = 'upper_G.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "G"
})
minetest.register_craft({
	output = 'alphabet:G 1',
	recipe = {
		{'default:dirt', 'default:dirt', 'default:wood'},
		{'default:dirt', 'default:dirt', ''}
	}
})
--H
minetest.register_node('alphabet:H', {
	tiles = {'upper_H.png'},
	inventory_image = 'upper_H.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "H"
})
minetest.register_craft({
	output = 'alphabet:H 1',
	recipe = {
		{'default:dirt', '', 'default:wood'},
		{'default:dirt', 'default:dirt', ''}
	}
})
--I
minetest.register_node('alphabet:I', {
	tiles = {'upper_I.png'},
	inventory_image = 'upper_I.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "I"
})
minetest.register_craft({
	output = 'alphabet:I 1',
	recipe = {
		{'', 'default:dirt', 'default:wood'},
		{'default:dirt', '', ''}
	}
})
--J
minetest.register_node('alphabet:J', {
	tiles = {'upper_J.png'},
	inventory_image = 'upper_J.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "J"
})
minetest.register_craft({
	output = 'alphabet:J 1',
	recipe = {
		{'', 'default:dirt', 'default:wood'},
		{'default:dirt', 'default:dirt', ''}
	}
})
--K
minetest.register_node('alphabet:K', {
	tiles = {'upper_K.png'},
	inventory_image = 'upper_K.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "K"
})
minetest.register_craft({
	output = 'alphabet:K 1',
	recipe = {
		{'default:dirt', '', 'default:wood'},
		{'', '', ''},
		{'default:dirt', '', ''}
	}
})
--L
minetest.register_node('alphabet:L', {
	tiles = {'upper_L.png'},
	inventory_image = 'upper_L.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "L"
})
minetest.register_craft({
	output = 'alphabet:L 1',
	recipe = {
		{'default:dirt', '', 'default:wood'},
		{'default:dirt', '', ''},
		{'default:dirt', '', ''}
	}
})
--M
minetest.register_node('alphabet:M', {
	tiles = {'upper_M.png'},
	inventory_image = 'upper_M.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "M"
})
minetest.register_craft({
	output = 'alphabet:M 1',
	recipe = {
		{'default:dirt', 'default:dirt', 'default:wood'},
		{'', '', ''},
		{'default:dirt', '', ''}
	}
})
--N
minetest.register_node('alphabet:N', {
	tiles = {'upper_N.png'},
	inventory_image = 'upper_N.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "N"
})
minetest.register_craft({
	output = 'alphabet:N 1',
	recipe = {
		{'default:dirt', 'default:dirt', 'default:wood'},
		{'', 'default:dirt', ''},
		{'default:dirt', '', ''}
	}
})
--O
minetest.register_node('alphabet:O', {
	tiles = {'upper_O.png'},
	inventory_image = 'upper_O.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "O"
})
minetest.register_craft({
	output = 'alphabet:O 1',
	recipe = {
		{'default:dirt', '', 'default:wood'},
		{'', 'default:dirt', ''},
		{'default:dirt', '', ''}
	}
})
--P
minetest.register_node('alphabet:P', {
	tiles = {'upper_P.png'},
	inventory_image = 'upper_P.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "P"
})
minetest.register_craft({
	output = 'alphabet:P 1',
	recipe = {
		{'default:dirt', 'default:dirt', 'default:wood'},
		{'default:dirt', '', ''},
		{'default:dirt', '', ''}
	}
})
--Q
minetest.register_node('alphabet:Q', {
	tiles = {'upper_Q.png'},
	inventory_image = 'upper_Q.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Q"
})
minetest.register_craft({
	output = 'alphabet:Q 1',
	recipe = {
		{'default:dirt', 'default:dirt', 'default:wood'},
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', '', ''}
	}
})
--R
minetest.register_node('alphabet:R', {
	tiles = {'upper_R.png'},
	inventory_image = 'upper_R.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "R"
})
minetest.register_craft({
	output = 'alphabet:R 1',
	recipe = {
		{'default:dirt', '', 'default:wood'},
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', '', ''}
	}
})
--S
minetest.register_node('alphabet:S', {
	tiles = {'upper_S.png'},
	inventory_image = 'upper_S.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "S"
})
minetest.register_craft({
	output = 'alphabet:S 1',
	recipe = {
		{'', 'default:dirt', 'default:wood'},
		{'default:dirt', '', ''},
		{'default:dirt', '', ''}
	}
})
--T
minetest.register_node('alphabet:T', {
	tiles = {'upper_T.png'},
	inventory_image = 'upper_T.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "T"
})
minetest.register_craft({
	output = 'alphabet:T 1',
	recipe = {

		{'', 'default:dirt', 'default:wood'},
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', '', ''}
	}
})
--U
minetest.register_node('alphabet:U', {
	tiles = {'upper_U.png'},
	inventory_image = 'upper_U.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "U"
})
minetest.register_craft({
	output = 'alphabet:U 1',
	recipe = {
		{'default:dirt', '', 'default:wood'},
		{'', '', ''},
		{'default:dirt', 'default:dirt', ''}
	}
})
--V
minetest.register_node('alphabet:V', {
	tiles = {'upper_V.png'},
	inventory_image = 'upper_V.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "V"
})
minetest.register_craft({
	output = 'alphabet:V 1',
	recipe = {
		{'default:dirt', '', 'default:wood'},
		{'default:dirt', '', ''},
		{'default:dirt', 'default:dirt', ''}
	}
})
--W
minetest.register_node('alphabet:W', {
	tiles = {'upper_W.png'},
	inventory_image = 'upper_W.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "W"
})
minetest.register_craft({
	output = 'alphabet:W 1',
	recipe = {
		{'', 'default:dirt', 'default:wood'},
		{'default:dirt', 'default:dirt', ''},
		{'', 'default:dirt', ''}
	}
})
--X
minetest.register_node('alphabet:X', {
	tiles = {'upper_X.png'},
	inventory_image = 'upper_X.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "X"
})
minetest.register_craft({
	output = 'alphabet:X 1',
	recipe = {
		{'default:dirt', 'default:dirt', 'default:wood'},
		{'', '', ''},
		{'default:dirt', 'default:dirt', ''}
	}
})
--y
minetest.register_node('alphabet:Y', {
	tiles = {'upper_Y.png'},
	inventory_image = 'upper_Y.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Y"
})
minetest.register_craft({
	output = 'alphabet:Y 1',
	recipe = {
		{'default:dirt', 'default:dirt', 'default:wood'},
		{'', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', ''}
	}
})
--Z
minetest.register_node('alphabet:Z', {
	tiles = {'upper_Z.png'},
	inventory_image = 'upper_Z.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Z"
})
minetest.register_craft({
	output = 'alphabet:Z 1',
	recipe = {
		{'default:dirt', '', 'default:wood'},
		{'', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', ''}
	}
})

--space
minetest.register_node('alphabet:space', {
	tiles = {'symbol_space.png'},
	inventory_image = 'symbol_space.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Space"
})
minetest.register_craft({
	output = 'alphabet:space 2',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', ''}
	}
})
--numbers
--1
minetest.register_node('alphabet:1', {
	tiles = {'number_1.png'},
	inventory_image = 'number_1.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "1"
})
minetest.register_craft({
	output = 'alphabet:1 1',
	recipe = {
		{'default:dirt', '', ''},
		{'', '', ''},
		{'', '', 'default:wood'}
		
	},
})
-- 2
minetest.register_node('alphabet:2', {
	tiles = {'number_2.png'},
	inventory_image = 'number_2.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "2"
})
minetest.register_craft({
	output = 'alphabet:2 1',
	recipe = {
		{'default:dirt', '', ''},
		{'default:dirt', '', ''},
		{'', '', 'default:wood'}
	}
})
-- 3
minetest.register_node('alphabet:3', {
	tiles = {'number_3.png'},
	inventory_image = 'number_3.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "3"
})
minetest.register_craft({
	output = 'alphabet:3 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'', '', ''},
		{'', '', 'default:wood'}
		
	}
})
--4
minetest.register_node('alphabet:4', {
	tiles = {'number_4.png'},
	inventory_image = 'number_4.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "4"
})
minetest.register_craft({
	output = 'alphabet:4 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'', 'default:dirt', ''},
		{'', '', 'default:wood'}
	}
})
--5
minetest.register_node('alphabet:5', {
	tiles = {'number_5.png'},
	inventory_image = 'number_5.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "5"
})
minetest.register_craft({
	output = 'alphabet:5 1',
	recipe = {
		{'default:dirt', '', ''},
		{'', 'default:dirt', ''},
		{'', '', 'default:wood'}
	}
})
--6
minetest.register_node('alphabet:6', {
	tiles = {'number_6.png'},
	inventory_image = 'number_6.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "6"
})
minetest.register_craft({
	output = 'alphabet:6 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', '', ''},
		{'', '', 'default:wood'}
	}
})
--7
minetest.register_node('alphabet:7', {
	tiles = {'number_7.png'},
	inventory_image = 'number_7.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "7"
})
minetest.register_craft({
	output = 'alphabet:7 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', ''},
		{'', '', 'default:wood'}
	}
})
--8
minetest.register_node('alphabet:8', {
	tiles = {'number_8.png'},
	inventory_image = 'number_8.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "8"
})
minetest.register_craft({
	output = 'alphabet:8 1',
	recipe = {
		{'default:dirt', '', ''},
		{'default:dirt', 'default:dirt', ''},
		{'', '', 'default:wood'}
	}
})
--9
minetest.register_node('alphabet:9', {
	tiles = {'number_9.png'},
	inventory_image = 'number_9.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "9"
})
minetest.register_craft({
	output = 'alphabet:9 1',
	recipe = {
		{'', 'default:dirt', ''},
		{'default:dirt', '', ''},
		{'', '', 'default:wood'}
	}
})
--0
minetest.register_node('alphabet:0', {
	tiles = {'number_0.png'},
	inventory_image = 'number_0.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "j"
})
minetest.register_craft({
	output = 'alphabet:0 1',
	recipe = {
		{'', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', ''},
		{'', '', 'default:wood'}
	}
})
--Symbols
--s1 !
minetest.register_node('alphabet:s1', {
	tiles = {'symbol_s1.png'},
	inventory_image = 'symbol_s1.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Exclamation mark"
})
minetest.register_craft({
	output = 'alphabet:s1 1',
	recipe = {
		{'default:dirt', '', ''},
		{'', '', ''},
		{'', '', 'default:cobble'}
	}
})
-- s2 @
minetest.register_node('alphabet:s2', {
	tiles = {'symbol_s2.png'},
	inventory_image = 'symbol_s2.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "At"
})
minetest.register_craft({
	output = 'alphabet:s2 1',
	recipe = {
		{'default:dirt', '', ''},
		{'default:dirt', '', ''},
		{'', '', 'default:cobble'}
	}
})
-- s3 #
minetest.register_node('alphabet:s3', {
	tiles = {'symbol_s3.png'},
	inventory_image = 'symbol_s3.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Number sign"
})
minetest.register_craft({
	output = 'alphabet:s3 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'', '', ''},
		{'', '', 'default:cobble'}
		
	}
})
--s4 $
minetest.register_node('alphabet:s4', {
	tiles = {'symbol_s4.png'},
	inventory_image = 'symbol_s4.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Dollar"
})
minetest.register_craft({
	output = 'alphabet:s4 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'', 'default:dirt', ''},
		{'', '', 'default:cobble'}
	}
})
--s5 %
minetest.register_node('alphabet:s5', {
	tiles = {'symbol_s5.png'},
	inventory_image = 'symbol_s5.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Percent"
})
minetest.register_craft({
	output = 'alphabet:s5 1',
	recipe = {
		{'default:dirt', '', ''},
		{'', 'default:dirt', ''},
		{'', '', 'default:cobble'}
	}
})
--s6 ^
minetest.register_node('alphabet:s6', {
	tiles = {'symbol_s6.png'},
	inventory_image = 'symbol_s6.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Caret"
})
minetest.register_craft({
	output = 'alphabet:s6 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', '', ''},
		{'', '', 'default:cobble'}
	}
})
--s7 &
minetest.register_node('alphabet:s7', {
	tiles = {'symbol_s7.png'},
	inventory_image = 'symbol_s7.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Ampersand"
})
minetest.register_craft({
	output = 'alphabet:s7 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', ''},
		{'', '', 'default:cobble'}
	}
})
--s8 *
minetest.register_node('alphabet:s8', {
	tiles = {'symbol_s8.png'},
	inventory_image = 'symbol_s8.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Asterisk"
})
minetest.register_craft({
	output = 'alphabet:s8 1',
	recipe = {
		{'default:dirt', '', ''},
		{'default:dirt', 'default:dirt', ''},
		{'', '', 'default:cobble'}
	}
})
--s9 (
minetest.register_node('alphabet:s9', {
	tiles = {'symbol_s9.png'},
	inventory_image = 'symbol_s9.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "("
})
minetest.register_craft({
	output = 'alphabet:s9 1',
	recipe = {
		{'', 'default:dirt', ''},
		{'default:dirt', '', ''},
		{'', '', 'default:cobble'}
	}
})
--s0 )
minetest.register_node('alphabet:s0', {
	tiles = {'symbol_s0.png'},
	inventory_image = 'symbol_s0.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = ")"
})
minetest.register_craft({
	output = 'alphabet:s0 1',
	recipe = {
		{'', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', ''},
		{'', '', 'default:cobble'}
	}
})
--apos ' (craft like K, but with cobble)
minetest.register_node('alphabet:apos', {
	tiles = {'symbol_apos.png'},
	inventory_image = 'symbol_apos.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Apostrophe"
})
minetest.register_craft({
	output = 'alphabet:apos 1',
	recipe = {
		{'default:dirt', '', ''},
		{'', '', ''},
		{'default:dirt', '', 'default:cobble'}
	}
})
--bslash \ (craft like L, but with cobble)
minetest.register_node('alphabet:bslash', {
	tiles = {'symbol_bslash.png'},
	inventory_image = 'symbol_bslash.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Back Slash"
})
minetest.register_craft({
	output = 'alphabet:bslash 1',
	recipe = {
		{'default:dirt', '', ''},
		{'default:dirt', '', ''},
		{'default:dirt', '', 'default:cobble'}
	}
})
--colon : (craft like M, but with cobble)
minetest.register_node('alphabet:colon', {
	tiles = {'symbol_colon.png'},
	inventory_image = 'symbol_colon.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Colon"
})
minetest.register_craft({
	output = 'alphabet:colon 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'', '', ''},
		{'default:dirt', '', 'default:cobble'}
	}
})
--comma , (craft like N, but with cobble)
minetest.register_node('alphabet:comma', {
	tiles = {'symbol_comma.png'},
	inventory_image = 'symbol_comma.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Comma"
})
minetest.register_craft({
	output = 'alphabet:comma 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'', 'default:dirt', ''},
		{'default:dirt', '', 'default:cobble'}
	}
})
--equal = (craft like O (not zero), but with cobble)
minetest.register_node('alphabet:equal', {
	tiles = {'symbol_equal.png'},
	inventory_image = 'symbol_equal.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Equals sign"
})
minetest.register_craft({
	output = 'alphabet:equal 1',
	recipe = {
		{'default:dirt', '', ''},
		{'', 'default:dirt', ''},
		{'default:dirt', '', 'default:cobble'}
	}
})
--minus - (craft like P, but with cobble)
minetest.register_node('alphabet:minus', {
	tiles = {'symbol_minus.png'},
	inventory_image = 'symbol_minus.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Minus"
})
minetest.register_craft({
	output = 'alphabet:minus 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', '', ''},
		{'default:dirt', '', 'default:cobble'}
	}
})
--plus + (craft like Q, but with cobble)
minetest.register_node('alphabet:plus', {
	tiles = {'symbol_plus.png'},
	inventory_image = 'symbol_plus.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Plus"
})
minetest.register_craft({
	output = 'alphabet:plus 1',
	recipe = {
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', '', 'default:cobble'}
	}
})
--quest ? (craft like R, but with cobble)
minetest.register_node('alphabet:quest', {
	tiles = {'symbol_quest.png'},
	inventory_image = 'symbol_quest.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Question mark"
})
minetest.register_craft({
	output = 'alphabet:quest 1',
	recipe = {
		{'default:dirt', '', ''},
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', '', 'default:cobble'}
	}
})
--quo " (craft like S, but with cobble)
minetest.register_node('alphabet:quo', {
	tiles = {'symbol_quo.png'},
	inventory_image = 'symbol_quo.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Quotation mark"
})
minetest.register_craft({
	output = 'alphabet:quo 1',
	recipe = {
		{'', 'default:dirt', ''},
		{'default:dirt', '', ''},
		{'default:dirt', '', 'default:cobble'}
	}
})
--slash / (craft like T, but with cobble)
minetest.register_node('alphabet:slash', {
	tiles = {'symbol_slash.png'},
	inventory_image = 'symbol_slash.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Slash"
})
minetest.register_craft({
	output = 'alphabet:slash 1',
	recipe = {
		{'', 'default:dirt', ''},
		{'default:dirt', 'default:dirt', ''},
		{'default:dirt', '', 'default:cobble'}
	}
})
--under " (craft like U, but with cobble)
minetest.register_node('alphabet:under', {
	tiles = {'symbol_under.png'},
	inventory_image = 'symbol_under.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Underscore"
})
minetest.register_craft({
	output = 'alphabet:under 1',
	recipe = {
		{'default:dirt', '', ''},
		{'', '', ''},
		{'default:dirt', 'default:dirt', 'default:cobble'}
	}
})
--dot . (craft like V, but with cobble)
minetest.register_node('alphabet:dot', {
	tiles = {'symbol_dot.png'},
	inventory_image = 'symbol_dot.png',
	sunlight_propagates = true,
	paramtype = 'light',
	walkable = true,
	climbable = false,
	diggable = true,
	drawtype = "nodebox",
	groups = { choppy = 3, oddly_breakable_by_hand = 1},
	material = minetest.digprop_constanttime(1.0),
	description = "Dot"
})
minetest.register_craft({
	output = 'alphabet:dot 1',
	recipe = {
		{'default:dirt', '', ''},
		{'default:dirt', '', ''},
		{'default:dirt', 'default:dirt', 'default:cobble'}
	}
})
