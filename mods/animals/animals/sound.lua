-------------------------------------------------------------------------------
-- Animals Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
-- (c) Sapier
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

sound =  {}


function sound.play(pos,soundspec) 

	if (soundspec ~= nil) then

		local toplay =  {
						gain = soundspec.gain,
						pos = pos,
						max_hear_distance = soundspec.max_hear_distance,
						loop = false,
						}
		
		minetest.sound_play(soundspec.name,toplay)
	else
		dbg_animals.sound_lvl2("ANIMALS: no soundspec")
		--todo add log entry
	end
end


function sound.play_random(entity,now)

	if entity.data.sound ~= nil and
		entity.data.sound.random ~= nil then
		
		if (entity.dynamic_data.sound.random_last + entity.data.sound.random.min_delta < now) then

			if math.random() < entity.data.sound.random.chance then
				sound.play(entity.object:getpos(),entity.data.sound.random)
				entity.dynamic_data.sound.random_last = now
				dbg_animals.sound_lvl1("ANIMALS: playing sound")
			else
				dbg_animals.sound_lvl1("ANIMALS: not playing sound")
			end
		end
	end

end

-------------------------------------------------------------------------------
-- name: sound.init_dynamic_data(entity) 
--
-- action: initialize all dynamic data on activate
--
-- param1: entity to do action
-- retval: -
-------------------------------------------------------------------------------
function sound.init_dynamic_data(entity,now)
	local data = {
		random_last					= now,	
	}	
	
	entity.dynamic_data.sound = data
end