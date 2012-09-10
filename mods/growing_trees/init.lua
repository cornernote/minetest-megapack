-------------------------------------------------------------------------------
-- Growing Trees Mod by Sapier
-- 
-- License GPLv3
--
--! @file init.lua
--! @brief main module file responsible for including all parts of growing tees
--! mod
--! @copyright Sapier
--! @author Sapier
--! @date 2012-09-04
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------
local version = "0.0.5"

local growing_trees_modpath = minetest.get_modpath("growing_trees")

dofile (growing_trees_modpath .. "/type_declarations.lua")
dofile (growing_trees_modpath .. "/models.lua")
dofile (growing_trees_modpath .. "/trunk_functions.lua")
dofile (growing_trees_modpath .. "/branch_functions.lua")
dofile (growing_trees_modpath .. "/generic_functions.lua")
dofile (growing_trees_modpath .. "/nodes.lua")
dofile (growing_trees_modpath .. "/crafts.lua")
dofile (growing_trees_modpath .. "/model_selection.lua")
dofile (growing_trees_modpath .. "/abms.lua")
dofile (growing_trees_modpath .. "/spawning.lua")

MAX_TREE_SIZE = 20
SLOWDOWN_TREE_GROWTH_SIZE = 10

function growing_trees_debug(loglevel,text)
    minetest.log(loglevel,text)
end

local tree_size_setting = minetest.setting_get("growing_trees_max_size")
local tree_slowdown_setting = minetest.setting_get("growing_trees_slowdown_size")

if tree_size_setting ~= nil then
    MAX_TREE_SIZE = tree_size_setting
end

if tree_slowdown_setting ~= nil then
    SLOWDOWN_TREE_GROWTH_SIZE = tree_slowdown_setting
end

print("growing_trees mod " .. version .. " loaded")