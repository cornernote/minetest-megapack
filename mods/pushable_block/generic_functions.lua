-------------------------------------------------------------------------------
-- name: round_pos(pos)
--
-- action: calculate integer position
--
-- param1: position to be rounded
-- retval: rounded position
-------------------------------------------------------------------------------
function round_pos(pos)

	return { 	x=math.floor(pos.x + 0.5),
			y=math.floor(pos.y + 0.5),
			z=math.floor(pos.z + 0.5)
		 }

end

-------------------------------------------------------------------------------
-- name: printpos(pos)
--
-- action: convert pos to string of type "(X,Y,Z)"
--
-- param1: position to convert
-- retval: string with coordinates of pos
-------------------------------------------------------------------------------
function printpos(pos)
	return "("..pos.x..","..pos.y..","..pos.z..")"
end
