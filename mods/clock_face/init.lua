minetest.register_node("clock_face:clock_12", {
	tiles = {"default_wood.png", "default_wood.png", "clock_face_1.png"},
	is_ground_content = true,
	description = "Clock face",
	groups = {snappy=2,choppy=2},
})

minetest.register_craft({
	output = 'clock_face:clock_12 1',
	recipe = {
		{'default:wood', 'default:wood', 'default:wood'},
		{'default:wood', 'default:steelblock', 'default:wood'},
		{'default:wood', 'default:wood', 'default:wood'},
	}
})

for iLoop = 1,11 do
	minetest.register_node("clock_face:clock_" .. iLoop, {
		tiles = {"default_wood.png", "default_wood.png", "clock_face_" .. iLoop .. ".png"},
		is_ground_content = true,
		groups = {snappy=2,choppy=2},
		drop = 'clock_face:clock_12 1',
	})
end

-- update 3 times in a "hour"
local clock_interval = math.min(60, (3600 / (tonumber(minetest.setting_get("time_speed")))) / 3)

minetest.register_abm({
nodenames = { "clock_face:clock_1", "clock_face:clock_2", "clock_face:clock_3", "clock_face:clock_4", "clock_face:clock_5", "clock_face:clock_6", "clock_face:clock_7", "clock_face:clock_8",
"clock_face:clock_9", "clock_face:clock_10", "clock_face:clock_11", "clock_face:clock_12" },
interval = clock_interval,
chance = 1,
action = function(pos, node, active_object_count, active_object_count_wider)
	hour = minetest.env:get_timeofday() * 24
	if hour > 12 then
		hour = hour - 12
	end
	hour = math.ceil(hour)
	
	--print ("[clock_face] Hour is " .. hour .. " (" .. minetest.env:get_timeofday() .. ")")
	
	if hour < 1 then
		hour = 1
	elseif hour > 12 then
		hour = 12
	end
	
	if node.name ~= "clock_face:clock_"..hour then
		minetest.env:add_node(pos, {name="clock_face:clock_"..hour})
	end
end
})
