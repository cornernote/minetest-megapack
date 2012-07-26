-- A simple bedrock mod by jn
-- Calinou made the texture, I brightened it up

-- This program is free software. It comes without any warranty, to
-- the extent permitted by applicable law. You can redistribute it
-- and/or modify it under the terms of the Do What The Fuck You Want
-- To Public License, Version 2, as published by Sam Hocevar. See
-- http://sam.zoy.org/wtfpl/COPYING or the file COPYING for more details.

--do return end -- uncomment to disable bedrock

local bedrock = {}

bedrock.layer = -30976 -- determined as appropriate by experiment
bedrock.node = {name = "bedrock:bedrock"}
--bedrock.digprop = minetest.digprop_constanttime(1000000)
bedrock.digprop = {diggability = "not"}

minetest.register_on_generated(function(minp, maxp)
	if maxp.y >= bedrock.layer and minp.y <= bedrock.layer then
		local p = {y = bedrock.layer}
		local n = bedrock.node
		for x = minp.x,maxp.x do
		for z = minp.z,maxp.z do
			p.x=x; p.z=z
			minetest.env:add_node(p, n)
		end
		end
	end
end)

minetest.register_node("bedrock:bedrock", {
	description = "Bedrock",
	tiles = {"bedrock.png"},
	material = bedrock.digprop
})
