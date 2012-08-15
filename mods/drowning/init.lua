drowning = {}	-- Exported functions

local players_under_water = {}

local START_DROWNING_SECONDS = 60
local DROWNING_SECONDS = 5
local DROWNING_DAMAGE = 1

local timer = 0
if minetest.setting_getbool("enable_damage") == true then
minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer >= .5 then
		timer = timer - .5
	else
		return
	end
	for k, v in pairs(minetest.object_refs) do
		if v:get_player_name() ~= nil then
			name = v:get_player_name()
			if players_under_water[name] == nil then
				players_under_water[name] = {count=0, drowning=false}
			end
			if IsPlayerInAir(v) == false then
				players_under_water[name].count = players_under_water[name].count + .5
				
				if players_under_water[name].drowning and players_under_water[name].count >= DROWNING_SECONDS then
					v:set_hp(v:get_hp() - DROWNING_DAMAGE)
					pos = v:getpos()
					pos.y=pos.y+1
					minetest.sound_play({name="drowning_gurp"}, {pos = pos, gain = 1.0, max_hear_distance = 16})
					players_under_water[name].count = players_under_water[name].count - DROWNING_SECONDS
				elseif not players_under_water[name].drowning and players_under_water[name].count >= START_DROWNING_SECONDS then
					players_under_water[name] = {count=0, drowning=true}
					v:set_hp(v:get_hp() - DROWNING_DAMAGE)
					pos = v:getpos()
					pos.y=pos.y+1
					minetest.sound_play({name="drowning_gurp"}, {pos = pos, gain = 1.0, max_hear_distance = 16})
				end
			elseif players_under_water[name].count > 0 then
				pos = v:getpos()
				pos.y=pos.y+1
				minetest.sound_play({name="drowning_gasp"}, {pos = pos, gain = 1.0, max_hear_distance = 32})
				players_under_water[name] = {count=0, drowning=false}
			end
		end
	end
end)
end

function IsPlayerInAir(player)
	-- player:getpos() is at the feet (I think) so add 1 to y to get where the head is?
	pos = player:getpos()
	pos.x = math.floor(pos.x+0.5)
	pos.y = math.floor(pos.y+1.5)
	pos.z = math.floor(pos.z+0.5)
	
	if minetest.env:get_node(pos).name == "air" then
		return true
	end
	return false
end
