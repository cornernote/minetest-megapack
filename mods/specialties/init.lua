--Other mods can use this table to check player's specialty levels
specialties = {}

--variable used for time keeping for updating xp
time = 0

--The GUI used to display the skills of each specialty
local skills = {}
skills["miner"] = "button[4.5,1;3,0.5;healpick;(100)Heal Pick]"..
		  "button[4.5,2;3,0.5;upgradepick;(200)Upgrade Pick]"..
			"list[current_player;pick;5.5,0;1,1;]"
skills["lumberjack"] = "button[4.5,1;3,0.5;healaxe;(100)Heal Axe]"..
			"button[4.5,2;3,0.5;upgradeaxe;(200)Upgrade Axe]"..
			"list[current_player;axe;5.5,0;1,1;]"
skills["digger"] = "button[4.5,1;3,0.5;healshovel;(100)Heal Shovel]"..
		   "button[4.5,2;3,0.5;upgradeshovel;(200)Upgrade Shovel]"..
			"list[current_player;shovel;5.5,0;1,1;]"
skills["builder"] = ""

--Amount to heal each type of tool
--mod support
local healAmount = {}
healAmount["default:pick_wood"] = 40000
healAmount["default:pick_stone"] = 30000
healAmount["default:pick_steel"] = 20000
healAmount["default:pick_mese"] = 10000
healAmount["default:axe_wood"] = 30000
healAmount["default:axe_stone"] = 20000
healAmount["default:axe_steel"] = 10000
healAmount["default:shovel_wood"] = 30000
healAmount["default:shovel_stone"] = 20000
healAmount["default:shovel_steel"] = 10000
healAmount["moreores:pick_bronze"] = 20000
healAmount["moreores:pick_silver"] = 32000
healAmount["moreores:pick_gold"] = 40000
healAmount["moreores:pick_mithril"] = 14000
healAmount["moreores:axe_bronze"] = 20000
healAmount["moreores:axe_silver"] = 32000
healAmount["moreores:axe_gold"] = 40000
healAmount["moreores:axe_mithril"] = 14000
healAmount["moreores:shovel_bronze"] = 20000
healAmount["moreores:shovel_silver"] = 32000
healAmount["moreores:shovel_gold"] = 40000
healAmount["moreores:shovel_mithril"] = 14000

--List of tools that can be upgraded into a better one
--mod support
local upgradeTree = {}
upgradeTree["default:pick_wood"] = "default:pick_stone"
upgradeTree["default:pick_stone"] = "default:pick_steel"
upgradeTree["default:pick_steel"] = "default:pick_mese"
upgradeTree["default:axe_wood"] = "default:axe_stone"
upgradeTree["default:axe_stone"] = "default:axe_steel"
upgradeTree["default:shovel_wood"] = "default:shovel_stone"
upgradeTree["default:shovel_stone"] = "default:shovel_steel"
upgradeTree["moreores:pick_bronze"] = "moreores:pick_silver"
upgradeTree["moreores:pick_silver"] = "moreores:pick_gold"
upgradeTree["moreores:pick_gold"] = "moreores:pick_mithril"
upgradeTree["moreores:shovel_bronze"] = "moreores:shovel_silver"
upgradeTree["moreores:shovel_silver"] = "moreores:shovel_gold"
upgradeTree["moreores:shovel_gold"] = "moreores:shovel_mithril"
upgradeTree["moreores:axe_bronze"] = "moreores:axe_silver"
upgradeTree["moreores:axe_silver"] = "moreores:axe_gold"
upgradeTree["moreores:axe_gold"] = "moreores:axe_mithril"

local get_specialties = function(player)
    local formspec = "size[8,8]" -- size of the formspec page
        .."button[0,0;2,0.5;main;Back]" -- back to main inventory
	.."button[2,0;2,0.5;miner;Miner]"
	.."button[2,1;2,0.5;lumberjack;Lumberjack]"
	.."button[2,2;2,0.5;digger;Digger]"
	.."button[2,3;2,0.5;builder;Builder]"
	.."list[current_player;main;0,4;8,4;]"
    return formspec
end
local get_specialInfo = function(player, specialty)
    local formspec = "size[8,8]" -- size of the formspec page
	.."button[0,0;2,0.5;main;Back]" -- back to main inventory
	.."button[2,0;2,0.5;miner;Miner]"
	.."button[2,1;2,0.5;lumberjack;Lumberjack]"
	.."button[2,2;2,0.5;digger;Digger]"
	.."button[2,3;2,0.5;builder;Builder]"
      .."label[4,0;XP: "..specialties[player:get_player_name()][specialty].."]"
	.."list[current_player;main;0,4;8,4;]"
	formspec = formspec..skills[specialty]
    return formspec
end

--File Manipulating
local function writeXP(player, specialty, amount)
	local file = io.open(minetest.get_worldpath().."/"..player.."_"..specialty, "w")
	file:write(amount)
	file:close()
end
local function readXP(player, specialty)
	local file = io.open(minetest.get_worldpath().."/"..player.."_"..specialty, "r")
	if file == nil then
		writeXP(player, specialty, 0)
		return 0
	end
	local xp = file:read("*number")
	file:close()
	return xp
end

--Table Modification
local function changeXP(player, specialty, amount)
	local current = specialties[player][specialty]
	if current+amount >= 0 then
		specialties[player][specialty] = current+amount
		print(specialties[player][specialty])
		return true
	else
		return false
	end
end

--XP Updates
local function updateXP(player)--Called every 10 seconds
	writeXP(player, "miner", specialties[player]["miner"])
	writeXP(player, "lumberjack", specialties[player]["lumberjack"])
	writeXP(player, "digger", specialties[player]["digger"])
	writeXP(player, "builder", specialties[player]["builder"])
end
minetest.register_on_leaveplayer(function(player)--Called if on a server, if single player than it isn't called
	updateXP(player:get_player_name())
end)

--Initial Files Created
minetest.register_on_newplayer(function(player)
	writeXP(player:get_player_name(), "miner", 0)
	writeXP(player:get_player_name(), "lumberjack", 0)
	writeXP(player:get_player_name(), "digger", 0)
	writeXP(player:get_player_name(), "builder", 0)
end)

--Initial XP Extraction
--optimizes the amount of calls to files
minetest.register_on_joinplayer(function(player)
	inventory_plus.register_button(player,"specialties","Specialties")
	player:get_inventory():set_size("pick", 1)
	player:get_inventory():set_size("axe", 1)
	player:get_inventory():set_size("shovel", 1)
	name = player:get_player_name()
	specialties[name] = {}
	specialties[name]["miner"] = readXP(name, "miner")
	specialties[name]["lumberjack"] = readXP(name, "lumberjack")
	specialties[name]["digger"] = readXP(name, "digger")
	specialties[name]["builder"] = readXP(name, "builder")
end)

--Skill Events
local function healTool(player, list, specialty, cost)
	tool = player:get_inventory():get_list(list)[1]
	print(tool:get_name())
	if (tool:get_name():find(list) ~= nil and tool:get_wear() ~= 0 and healAmount[tool:get_name()] ~= nil)then
		if (changeXP(player:get_player_name(), specialty, -cost)) then
			tool:add_wear(-healAmount[tool:get_name()])
			player:get_inventory():set_stack(list, 1, tool)
			inventory_plus.set_inventory_formspec(player, get_specialInfo(player, specialty))
		end
	end
end
local function upgradeTool(player, list, specialty, cost)
	tool = player:get_inventory():get_list(list)[1]
	if(tool:get_name():find(list) ~= nil and upgradeTree[tool:get_name()] ~= nil) then
		if (changeXP(player:get_player_name(), specialty, -cost)) then
			player:get_inventory():set_stack(list, 1, upgradeTree[tool:get_name()])
			inventory_plus.set_inventory_formspec(player, get_specialInfo(player, specialty))
		end
	end
end

--GUI Events
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if fields.specialties then
		inventory_plus.set_inventory_formspec(player, get_specialties(player))
		return
	end

	--MINER
	if fields.miner then
		inventory_plus.set_inventory_formspec(player, get_specialInfo(player, "miner"))
		return
	end
	if fields.healpick then healTool(player, "pick", "miner", 100) end
	if fields.upgradepick then upgradeTool(player, "pick", "miner", 200) end

	--LUMBERJACK
	if fields.lumberjack then
		inventory_plus.set_inventory_formspec(player, get_specialInfo(player, "lumberjack"))
		return
	end
	if fields.healaxe then healTool(player, "axe", "lumberjack", 100) end
	if fields.upgradeaxe then upgradeTool(player, "axe", "lumberjack", 200) end

	--DIGGER
	if fields.digger then
		inventory_plus.set_inventory_formspec(player, get_specialInfo(player, "digger"))
		return
	end
	if fields.healshovel then healTool(player, "shovel", "digger", 100) end
	if fields.upgradeshovel then upgradeTool(player, "shovel", "digger", 200) end
	
	--BUILDER
	if fields.builder then
		inventory_plus.set_inventory_formspec(player, get_specialInfo(player, "builder"))
		return
	end
end)


--XP Events
minetest.register_on_dignode(function(pos, oldnode, digger)
	if(digger == nil) then
		return
	end
	if(digger:get_wielded_item():is_empty())then
		return
	end
	local tool = digger:get_wielded_item():get_name()
	local name = digger:get_player_name()
	if(tool:find("pick") ~= nil)then
		changeXP(name, "miner", 1)
	end
	if(tool:find("axe") ~= nil)then
		changeXP(name, "lumberjack", 1)
	end
	if(tool:find("shovel") ~= nil)then
		changeXP(name, "digger", 1)
	end
end)
minetest.register_on_placenode(function(pos, newnode, placer, oldnode)
	changeXP(placer:get_player_name(), "builder", 1)
end)
minetest.register_globalstep(function(dtime)
	if(time+dtime < 10) then
		time = time+dtime
	else
		time = 0
		for key in pairs(specialties)do
			updateXP(key)
		end
	end
end)