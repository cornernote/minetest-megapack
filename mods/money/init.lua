--Mod by kotolegokot
dofile(minetest.get_modpath("money") .. "/settings.txt")

local function set_money(name, value)
	local output = io.open(minetest.get_worldpath() .. "/money_" .. name .. ".txt", "w")
	output:write(value)
	io.close(output)
end

local function get_money(name)
	local input = io.open(minetest.get_worldpath() .. "/money_" .. name .. ".txt", "r")
	if not input then 
		return nil
	end
	money = input:read("*n")
	io.close(input)
	return money
end

minetest.register_on_joinplayer(function(player)
	name = player:get_player_name()
	if not get_money(name) then
		set_money(name, tostring(INITIAL_MONEY))
	end
end)

minetest.register_privilege("money", "Can use /money [pay <player> <amount>] command")
minetest.register_privilege("money_admin", {
	description = "Can use /money [<player> | pay/set/add/dec <player> <amount>] command",
	give_to_singleplayer = false,
})

minetest.register_chatcommand("money", {
	privs = {money=true},
	params = "[<player> | pay/set/add/dec <player> <amount>]",
	description = "Operations with money",
	func = function(name,  param)
		if param == "" then
			minetest.chat_send_player(name, get_money(name) .. MONEY_NAME)
		else
			local param1, reciever, amount = string.match(param, "([^ ]+) ([^ ]+) (.+)")
			if not reciever and not amount then
				if minetest.get_player_privs(name)["money_admin"] then
					if not get_money(param) then
						minetest.chat_send_player(name, "Player named \"" .. param .. "\" do not exist or not have an account.")
						return true
					end
					minetest.chat_send_player(name, get_money(param) .. MONEY_NAME)
					return true
				else
					minetest.chat_send_player(name, "You don't have permission to run this command (missing privileges: money_admin)")
				end
			end
			if (param1 ~= "pay") and (param1 ~= "set") and (param1 ~= "add") and (param1 ~= "dec") or not reciever or not amount then
				minetest.chat_send_player(name, "Invalid parameters (see /help money)")
				return true
			elseif not get_money(reciever) then
				minetest.chat_send_player(name, "Player named \"" .. reciever .. "\" does not exist or not have account.")
				return true
			elseif not tonumber(amount) then
				minetest.chat_send_player(name, amount .. " is not a number.")
				return true
			elseif tonumber(amount) < 0 then
				minetest.chat_send_player(name, "The amount must be greater than 0.")
				return true
			end
			amount = tonumber(amount)
			if param1 == "pay" then
				if get_money(name) < amount then
					minetest.chat_send_player(name, "You do not have enough " .. amount - get_money(name) .. MONEY_NAME .. ".")
					return true
				end
				set_money(name, get_money(name) - amount)
				set_money(reciever, get_money(reciever) + amount)
				minetest.chat_send_player(name, reciever .. " took your " .. amount .. MONEY_NAME)
				minetest.chat_send_player(reciever, name .. " sent you " .. amount .. MONEY_NAME)
			elseif minetest.get_player_privs(name)["money_admin"] then
				if param1 == "add" then
					newmoney = get_money(reciever) + amount
					set_money(reciever, newmoney)
				elseif param1 == "dec" then
					if amount <= get_money(reciever) then
						newmoney = get_money(reciever) - amount
						set_money(reciever, newmoney)
					else
						minetest.chat_send_player(name, reciever .. " has too little money.")
					end
				elseif param1 == "set" then
					newmoney = amount
					set_money(reciever, amount)
				end
				minetest.chat_send_player(name, reciever .. " " .. newmoney .. MONEY_NAME)
			else
				minetest.chat_send_player(name, "You don't have permission to run this command (missing privileges: money_admin)")
			end
		end
	end,
})

local function has_shop_privilege(meta, player)
	if player:get_player_name() == meta:get_string("owner") or minetest.get_player_privs(player:get_player_name())["money_admin"] then
		return true
	end
	return false
end

minetest.register_node("money:shop", {
	description = "Shop",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "money_shop_front.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name())
		meta:set_string("infotext", "Untuned Shop (owned by " .. placer:get_player_name() .. ")")
	end,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "size[8,7]"..
			"field[0.256,0.5;8,1;shopname;Name of your shop:;]"..
			"field[0.256,1.5;8,1;action;Do you want buy(B) or sell(S) or buy and sell(BS):;]"..
			"field[0.256,2.5;8,1;nodename;Name of node, that you want buy or/and sell:;]"..
			"field[0.256,3.5;8,1;amount;Amount of these nodes:;]"..
			"field[0.256,4.5;8,1;costbuy;Cost of purchase, if you buy nodes:;]"..
			"field[0.256,5.5;8,1;costsell;Cost of sales, if you sell nodes:;]"..
			"button_exit[3.3,6.5;2,1;button;Proceed]")
		meta:set_string("infotext", "Untuned Shop")
		meta:set_string("owner", "")
		meta:set_string("form", "yes")
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and (meta:get_string("owner") == player:get_player_name() or minetest.get_player_privs(player:get_player_name())["money_admin"])
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_shop_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a shop belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		if not has_shop_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a shop belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_shop_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a shop belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return count
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in shop at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to shop at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from shop at "..minetest.pos_to_string(pos))
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.env:get_meta(pos)
		if meta:get_string("form") == "yes" then
			if fields.shopname ~= "" and (fields.action == "B" or fields.action == "S" or fields.action == "BS") and minetest.registered_items[fields.nodename] and tonumber(fields.amount) and tonumber(fields.amount) >= 1 and (meta:get_string("owner") == sender:get_player_name() or minetest.get_player_privs(sender:get_player_name())["money_admin"]) then
				if fields.action == "B" then
					if not tonumber(fields.costbuy) then
						return
					end
					if not (tonumber(fields.costbuy) >= 0) then
						return
					end
				end
				if fields.action == "S" then
					if not tonumber(fields.costsell) then
						return
					end
					if not (tonumber(fields.costsell) >= 0) then
						return
					end
				end
				if fields.action == "BS" then
					if not tonumber(fields.costbuy) then
						minetest.chat_send_all("2")
						return
					end
					if not (tonumber(fields.costbuy) >= 0) then
						minetest.chat_send_all("3")
						return
					end
					if not tonumber(fields.costsell) then
						minetest.chat_send_all("4")
						return
					end
					if not (tonumber(fields.costsell) >= 0) then
						minetest.chat_send_all("5")
						return
					end
				end
				local s, ss
				if fields.action == "B" then
					s = " sell "
					ss = "button[1,5;2,1;buttonsell;Sell("..fields.costbuy..")]"
				elseif fields.action == "S" then
					s = " buy "
					ss = "button[1,5;2,1;buttonbuy;Buy("..fields.costsell..")]"
				else
					s = " buy and sell "
					ss = "button[1,5;2,1;buttonbuy;Buy("..fields.costsell..")]" .. "button[5,5;2,1;buttonsell;Sell("..fields.costbuy..")]"
				end
				local meta = minetest.env:get_meta(pos)
				meta:set_string("formspec", "size[8,10;]"..
					"list[context;main;0,0;8,4;]"..
					"label[0.256,4.5;You can"..s..fields.amount.." "..fields.nodename.."]"..
					ss..
					"list[current_player;main;0,6;8,4;]")
				meta:set_string("shopname", fields.shopname)
				meta:set_string("nodename", fields.nodename)
				meta:set_string("amount", fields.amount)
				meta:set_string("costbuy", fields.costsell)
				meta:set_string("costsell", fields.costbuy)
				meta:set_string("infotext", "Shop \"" .. fields.shopname .. "\" (owned by " .. meta:get_string("owner") .. ")")
				local inv = meta:get_inventory()
				inv:set_size("main", 8*4)
				meta:set_string("form", "no")
			end
		elseif fields["buttonbuy"] then
			local sender_name = sender:get_player_name()
			local inv = meta:get_inventory()
			local sender_inv = sender:get_inventory()
			if not inv:contains_item("main", meta:get_string("nodename") .. " " .. meta:get_string("amount")) then
				minetest.chat_send_player(sender_name, "In the shop is not enough goods.")
				return true
			elseif not sender_inv:room_for_item("main", meta:get_string("nodename") .. " " .. meta:get_string("amount")) then
				minetest.chat_send_player(sender_name, "In your inventory is not enough space.")
				return true
			elseif get_money(sender_name) - tonumber(meta:get_string("costbuy")) < 0 then
				minetest.chat_send_player(sender_name, "You do not have enough money.")
				return true
			end
			set_money(sender_name, get_money(sender_name) - meta:get_string("costbuy"))
			set_money(meta:get_string("owner"), get_money(meta:get_string("owner")) + meta:get_string("costbuy"))
			sender_inv:add_item("main", meta:get_string("nodename") .. " " .. meta:get_string("amount"))
			inv:remove_item("main", meta:get_string("nodename") .. " " .. meta:get_string("amount"))
			minetest.chat_send_player(sender_name, "You bought " .. meta:get_string("amount") .. " " .. meta:get_string("nodename") .. " at a price of " .. meta:get_string("costbuy") .. MONEY_NAME .. ".")
		elseif fields["buttonsell"] then
			local sender_name = sender:get_player_name()
			local inv = meta:get_inventory()
			local sender_inv = sender:get_inventory()
			if not sender_inv:contains_item("main", meta:get_string("nodename") .. " " .. meta:get_string("amount")) then
				minetest.chat_send_player(sender_name, "You do not have enough product.")
				return true
			elseif not inv:room_for_item("main", meta:get_string("nodename") .. " " .. meta:get_string("amount")) then
				minetest.chat_send_player(sender_name, "In the shop is not enough space.")
				return true
			elseif get_money(meta:get_string("owner")) - meta:get_string("costsell") < 0 then
				minetest.chat_send_player(sender_name, "The buyer is not enough money.") 
				return true
			end
			set_money(sender_name, get_money(sender_name) + meta:get_string("costsell"))
			set_money(meta:get_string("owner"), get_money(meta:get_string("owner")) - meta:get_string("costsell"))
			sender_inv:remove_item("main", meta:get_string("nodename") .. " " .. meta:get_string("amount"))
			inv:add_item("main", meta:get_string("nodename") .. " " .. meta:get_string("amount"))
			minetest.chat_send_player(sender_name, "You sold " .. meta:get_string("amount") .. " " .. meta:get_string("nodename") .. " at a price of " .. meta:get_string("costsell") .. MONEY_NAME .. ".")
		end
	end,
 })

minetest.register_craft({
	output = "money:shop",
	recipe = {
		{"default:chest_locked"},
		{"locked_sign:sign_wall_locked"},
	},
})

minetest.register_alias("shop", "money:shop")

minetest.register_node("money:barter_shop", {
	description = "Barter Shop",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "money_shop_front.png"},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	after_place_node = function(pos, placer)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("owner", placer:get_player_name())
		meta:set_string("infotext", "Untuned Barter Shop (owned by " .. placer:get_player_name() .. ")")
	end,
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", "size[8,6]"..
			"field[0.256,0.5;8,1;bartershopname;Name of your barter shop:;]"..
			"field[0.256,1.5;8,1;nodename1;What kind of a node you want to exchange:;]"..
			"field[0.256,2.5;8,1;nodename2;for:;]"..
			"field[0.256,3.5;8,1;amount1;Amount of first kind of node:;]"..
			"field[0.256,4.5;8,1;amount2;Amount of second kind of node:;]"..
			"button_exit[3.3,5.5;2,1;button;Proceed]")
		meta:set_string("infotext", "Untuned Shop")
		meta:set_string("owner", "")
		meta:set_string("form", "yes")
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and (meta:get_string("owner") == player:get_player_name() or minetest.get_player_privs(player:get_player_name())["money_admin"])
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_shop_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a barter shop belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		if not has_shop_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a barter shop belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, count, player)
		local meta = minetest.env:get_meta(pos)
		if not has_shop_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a barter shop belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return count
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in barter shop at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to barter shop at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, count, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from barter shop at "..minetest.pos_to_string(pos))
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.env:get_meta(pos)
		if meta:get_string("form") == "yes" then
			if fields.bartershopname ~= "" and minetest.registered_items[fields.nodename1] and minetest.registered_items[fields.nodename2] and tonumber(fields.amount1) and tonumber(fields.amount1) >= 1 and tonumber(fields.amount2) and tonumber(fields.amount2) >= 1 and (meta:get_string("owner") == sender:get_player_name() or minetest.get_player_privs(sender:get_player_name())["money_admin"]) then
				local meta = minetest.env:get_meta(pos)
				meta:set_string("formspec", "size[8,10;]"..
					"list[context;main;0,0;8,4;]"..
					"label[0.256,4.5;"..fields.amount2.." "..fields.nodename2.." --> "..fields.amount1.." "..fields.nodename1.."]"..
					"button[3.3,5;2,1;button;Exchange]"..
					"list[current_player;main;0,6;8,4;]")
				meta:set_string("bartershopname", fields.bartershopname)
				meta:set_string("nodename1", fields.nodename1)
				meta:set_string("nodename2", fields.nodename2)
				meta:set_string("amount1", fields.amount1)
				meta:set_string("amount2", fields.amount2)
				meta:set_string("infotext", "Barter Shop \"" .. fields.bartershopname .. "\" (owned by " .. meta:get_string("owner") .. ")")
				local inv = meta:get_inventory()
				inv:set_size("main", 8*4)
				meta:set_string("form", "no")
			end
		elseif fields["button"] then
			local sender_name = sender:get_player_name()
			local inv = meta:get_inventory()
			local sender_inv = sender:get_inventory()
			if not inv:contains_item("main", meta:get_string("nodename1") .. " " .. meta:get_string("amount1")) then
				minetest.chat_send_player(sender_name, "In the barter shop is not enough goods.")
				return
			elseif not sender_inv:contains_item("main", meta:get_string("nodename2") .. " " .. meta:get_string("amount2")) then
				minetest.chat_send_player(sender_name, "In your inventory is not enough goods.")
				return
			elseif not inv:room_for_item("main", meta:get_string("nodename2") .. " " .. meta:get_string("amount2")) then
				minetest.chat_send_player(sender_name, "In the barter shop is not enough space.")
				return
			elseif not sender_inv:room_for_item("main", meta:get_string("nodename1") .. " " .. meta:get_string("amount1")) then
				minetest.chat_send_player(sender_name, "In your inventory is not enough space.")
				return
			end
			inv:remove_item("main", meta:get_string("nodename1") .. " " .. meta:get_string("amount1"))
			sender_inv:remove_item("main", meta:get_string("nodename2") .. " " .. meta:get_string("amount2"))
			inv:add_item("main", meta:get_string("nodename2") .. " " .. meta:get_string("amount2"))
			sender_inv:add_item("main", meta:get_string("nodename1") .. " " .. meta:get_string("amount1"))
			minetest.chat_send_player(sender_name, "You exchanged " .. meta:get_string("amount2") .. " " .. meta:get_string("nodename2") .. " on " .. meta:get_string("amount1") .. " " .. meta:get_string("nodename1") .. ".")
		end
	end,
})
	
minetest.register_craft({
	output = "money:barter_shop",
	recipe = {
		{"locked_sign:sign_wall_locked"},
		{"default:chest_locked"},
	},
})

minetest.register_alias("barter_shop", "money:barter_shop")