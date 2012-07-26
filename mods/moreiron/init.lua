local ironore = {
	"default:stone_with_iron"
}

local tin_gen = function( minp, maxp )
    if maxp.y > -8 then return; end
	for c, ironmineral in ipairs(ironore) do
		local amount = math.random( 0, 8 )
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
						else
							local p = { x=pos.x+i, y=pos.y+j, z=pos.z+k }
							local n = minetest.env:get_node( p )
							if n.name == "default:stone" then
								minetest.env:add_node( p, { name = ironmineral } )
							end
						end
					end
				end
			end
		end
	end
end

minetest.register_on_generated( iron_gen )

