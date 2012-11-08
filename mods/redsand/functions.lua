-- !!! FUNCTIONS !!! --
-- Getting the player object.
function get_player_obj (name)
	goodname = string.match(name, "^([^ ]+) *$")
	if goodname == nil then
		print("ERROR!")
		return nil
	end

	-- Looping trough all the players currently online
	for _,player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()

		-- Caring about letters or not?
		if not careLetters then
			if string.lower(name) == string.lower(goodname) then
				return player
			end
		else
			if name == goodname then
				return player
			end
		end
	end
	return nil
end