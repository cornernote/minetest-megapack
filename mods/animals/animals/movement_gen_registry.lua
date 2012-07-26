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

movement_generators = {}


function getMovementGen(id)
	
	return movement_generators[id]

end

function registerMovementGen(name,generator)

	--some movement gen checks
	
	if generator.init_dynamic_data == nil then
		return false
	end
	
	if generator.callback == nil then
		return false
	end	
	if movement_generators[name] == nil then
		movement_generators[name] = generator
		
		print ("\tRegistering movement generator ".. name)
		if generator.initilize ~= nil then
			generator.initialize()
		end
		return true
	else
		return false	
	end

end