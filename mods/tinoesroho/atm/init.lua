dofile(minetest.get_modpath("atm") .. "/table_db.lua")

minetest.register_node("atm:atm_deposit", {
	description = "ATM Deposits",
	tile_images = {"atm_deposit.png"},
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.0),
	paramtype = "facedir_simple",
	metadata_name = "generic",
})

minetest.register_node("atm:atm_withdrawl", {
	description = "ATM Withdrawals",
	tile_images = {"atm_withdrawl.png"},
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.0),
	paramtype = "facedir_simple",
	metadata_name = "generic",
})

minetest.register_node("atm:atm_check_balance", {
	description = "ATM Check Balance",
	tile_images = {"atm_check.png"},
	is_ground_content = true,
	material = minetest.digprop_stonelike(1.0),
	paramtype = "facedir_simple",
	metadata_name = "generic",
})

minetest.register_on_placenode(function(pos, newnode, placer)
	if newnode.name == "atm:atm_deposit" then
		local meta = minetest.env:get_meta(pos)
		meta:set_infotext("Punch with coins to deposit them.")
	elseif newnode.name == "atm:atm_withdrawl" then
		local meta = minetest.env:get_meta(pos)
		meta:set_infotext("Punch to remove some coins from your account.")
	elseif newnode.name == "atm:atm_check_balance" then
		local meta = minetest.env:get_meta(pos)
		meta:set_infotext("Punch to check the balance of your account.")
	end
end)

local money_db_filename = minetest.get_modpath("atm") .. "/accounts.tbl"
accounts = table.load(money_db_filename)

if type(accounts) ~= "table" then
	accounts = {}
end

function GetAccountBalance(player_name)
	if accounts[player_name] == nil then
		accounts[player_name] = 0
		table.save( accounts, money_db_filename )
	end
	
	print ("[ATM] GetAccountBalance - " .. player_name .. "  " .. tostring(accounts[player_name]))
	return accounts[player_name]
end

function AddToAccount(player_name, amount)
	if accounts[player_name] == nil then
		accounts[player_name] = 0
	end
	
	accounts[player_name] = accounts[player_name] + amount
	
	table.save( accounts, money_db_filename )
end

function GetFromAccount(player_name, amount)
	if accounts[player_name] == nil then
		accounts[player_name] = 0
	end
	
	if accounts[player_name] >= amount then
		accounts[player_name] = accounts[player_name] - amount
		table.save( accounts, money_db_filename )
		return true, amount
	else
		amount = accounts[player_name]
		accounts[player_name] = 0
		table.save( accounts, money_db_filename )
		return false, amount
	end
end

minetest.register_on_punchnode(function(pos, node, puncher)
	if node.name == "atm:atm_deposit" then
		hit_with = puncher:get_wielded_item()
		hit_with_name = hit_with:get_name()
		hit_with_count = hit_with:get_count()
		total_amount = 0
		if hit_with_name == "money:coin_copper" then
			total_amount = hit_with_count
		elseif hit_with_name == "money:coin_silver" then
			total_amount = money.ConvertToCopper(0, hit_with_count, 0)
		elseif hit_with_name == "money:coin_gold" then
			total_amount = money.ConvertToCopper(hit_with_count, 0, 0)
		else
			return
		end
		AddToAccount(puncher:get_player_name(), total_amount)
		puncher:get_inventory():remove_item("main", hit_with)
	elseif node.name == "atm:atm_withdrawl" then
		-- For now try to pull out 5 gold coins, in the future we may be able to as the player how much they want
		-- full will be false if we didn't get the amount requested, also means that the account is now empty
		full, amount = GetFromAccount(puncher:get_player_name(), money.ConvertToCopper(5, 0, 0))
		local g, s, c = money.ConvertCopperToOthers(amount)
		
		if c > 0 then
			puncher:get_inventory():add_item("main", "money:coin_copper " .. c)
		end
		if s > 0 then
			puncher:get_inventory():add_item("main", "money:coin_silver " .. s)
		end
		if g > 0 then
			puncher:get_inventory():add_item("main", "money:coin_gold " .. g)
		end
	elseif node.name == "atm:atm_check_balance" then
		local c_total = GetAccountBalance(puncher:get_player_name())
		local g, s, c = money.ConvertCopperToOthers(c_total)
		minetest.chat_send_player(puncher:get_player_name(), 'Account Balance: ' .. c_total .. ' copper\nor ' .. g .. ' gold, ' .. s .. ' silver, ' .. c .. ' copper') 
	end
end)
