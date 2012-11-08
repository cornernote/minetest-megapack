-- Copyright (C) 2012 cosarara97

--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU Affero General Public License as published
--    by the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.

--    This program is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU Affero General Public License for more details.

--    You should have received a copy of the GNU Affero General Public License
--    along with this program.  If not, see <http://www.gnu.org/licenses/>.

-- Textures are under the WTFPL - because there's only a blue square =P

-- Points mod version 0.2


dofile(minetest.get_modpath("points").."/table.save-1.0.lua")

minetest.register_node("points:flag", {
	description = "Flag - keep it with you.",
    tiles = {"points_blue_flag.png"},
	is_ground_content = true,
	
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{0.15,0.45,-0.05, 0.05,-0.45,0.05},
			{-0.45,0.43,-0.02, 0.05,-0.07,0.02}
		}
	},
	groups = {tree=1,snappy=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
})


function check_flags()
    --print("flags check!")
    --local data,err = table.load(minetest.get_modpath("points").."/pointsdata.lua")
    local data,err = table.load(minetest.get_worldpath().."/pointsdata.lua")
    if err ~= nil then
        print("No points file!")
    end
    if data == nil then
        data = {}
    end
    local players = minetest.get_connected_players()
    if (# players) > 1 then
        for _, player in pairs(players) do
            --print("aaa")
            local name = player:get_player_name()
            if not data[name] then
                data[name] = 0
            end
            local inv = player:get_inventory()
            if inv:contains_item("main", "points:flag") then
                data[name] = data[name] + 5
            else
                data[name] = data[name] - 2
            end
            print("player "..name.." has "..data[name].." points.")
            minetest.chat_send_all("player "..name.." has "..data[name].." points.")
        end
    end
    --print("saving table...")
    --table.save(data, minetest.get_modpath("points").."/pointsdata.lua")
    table.save(data, minetest.get_worldpath().."/pointsdata.lua")
    --print("end flags check")
end

function points_update(dtime)
    --print(minetest.env:get_timeofday())
    if not points_tick then
        points_tick = 1
    end
    points_tick = points_tick+1
    if (points_tick % 1000) == 0 then
        --print(points_tick)
        check_flags()
    end
end

function drop_flag(player)
    local name = player:get_player_name()
    local pos = player:getpos()
    pos = {
        x=math.floor(pos.x+0.5),
        y=math.floor(pos.y+0.5),
        z=math.floor(pos.z+0.5)
    }
    local inv = player:get_inventory()
    local removed_flag = false
    if inv:contains_item("main", "points:flag") then
        inv:remove_item("main", "points:flag")
        removed_flag = true
    elseif inv:contains_item("craft", "points:flag") then
        inv:remove_item("craft", "points:flag")
        removed_flag = true
    end
    if removed_flag then
        minetest.env:set_node(pos, {name="points:flag"})
        minetest.chat_send_all("Player "..name.." died while he was carrying a flag!\nYou can find it at "..pos.x..","..pos.y..","..pos.z..".")
    end
    
end


--minetest.after(10, check_flags)
minetest.register_globalstep(points_update)
minetest.register_on_dieplayer(drop_flag)

print("points mod loaded")

