-------------------------------------------------------------------------------
-- Mob Framework Mod by Sapier
-- 
-- You may copy, use, modify or do nearly anything except removing this
-- copyright notice. 
-- And of course you are NOT allow to pretend you have written it.
--
--! @file movement_gen_registry.lua
--! @brief registry for movement generators
--! @copyright Sapier
--! @author Sapier
--! @date 2012-08-09
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

movement_generators = {}


-------------------------------------------------------------------------------
-- name: getMovementGen(id)
--
--! @brief get movement generator specified by id
--
--! @param id id of movementgenerator
--! @return module pointer for movementgenerator
-------------------------------------------------------------------------------
function getMovementGen(id)
	if movement_generators[id] == nil then
		minetest.log(LOGLEVEL_ERROR,"MOBF: movement generator " .. id .. " not found!")
	end
	return movement_generators[id]
end

-------------------------------------------------------------------------------
-- name: registerMovementGen(name,generator)
--
--! @brief register a movement generator to mob framework
--! @ingroup framework_int
--
--! @param name id to use for movement generator
--! @param generator pointer to movement generator
--! @return true/false successfully added generator
-------------------------------------------------------------------------------
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