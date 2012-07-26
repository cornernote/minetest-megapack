-- declare local variables
--// exportstring( string )
--// returns a "Lua" portable version of the string
local function exportstring( s )
  s = string.format( "%q",s )
  -- to replace
  s = string.gsub( s,"\\\n","\\n" )
  s = string.gsub( s,"\r","\\r" )
  s = string.gsub( s,string.char(26),"\"..string.char(26)..\"" )
  return s
end
--// The Save Function
local function table_save(  tbl,filename )
   local charS,charE = "   ","\n"
   local file,err
   -- create a pseudo file that writes to a string and return the string
   if not filename then
      file =  { write = function( self,newstr ) self.str = self.str..newstr end, str = "" }
      charS,charE = "",""
   -- write table to tmpfile
   elseif filename == true or filename == 1 then
      charS,charE,file = "","",io.tmpfile()
   -- write table to file
   -- use io.open here rather than io.output, since in windows when clicking on a file opened with io.output will create an error
   else
      file,err = io.open( filename, "w" )
      if err then return _,err end
   end
   -- initiate variables for save procedure
   local tables,lookup = { tbl },{ [tbl] = 1 }
   file:write( "return {"..charE )
   for idx,t in ipairs( tables ) do
      if filename and filename ~= true and filename ~= 1 then
         file:write( "-- Table: {"..idx.."}"..charE )
      end
      file:write( "{"..charE )
      local thandled = {}
      for i,v in ipairs( t ) do
         thandled[i] = true
         -- escape functions and userdata
         if type( v ) ~= "userdata" then
            -- only handle value
            if type( v ) == "table" then
               if not lookup[v] then
                  table.insert( tables, v )
                  lookup[v] = #tables
               end
               file:write( charS.."{"..lookup[v].."},"..charE )
            elseif type( v ) == "function" then
               file:write( charS.."loadstring("..exportstring(string.dump( v )).."),"..charE )
            else
               local value =  ( type( v ) == "string" and exportstring( v ) ) or tostring( v )
               file:write(  charS..value..","..charE )
            end
         end
      end
      for i,v in pairs( t ) do
         -- escape functions and userdata
         if (not thandled[i]) and type( v ) ~= "userdata" then
            -- handle index
            if type( i ) == "table" then
               if not lookup[i] then
                  table.insert( tables,i )
                  lookup[i] = #tables
               end
               file:write( charS.."[{"..lookup[i].."}]=" )
            else
               local index = ( type( i ) == "string" and "["..exportstring( i ).."]" ) or string.format( "[%d]",i )
               file:write( charS..index.."=" )
            end
            -- handle value
            if type( v ) == "table" then
               if not lookup[v] then
                  table.insert( tables,v )
                  lookup[v] = #tables
               end
               file:write( "{"..lookup[v].."},"..charE )
            elseif type( v ) == "function" then
               file:write( "loadstring("..exportstring(string.dump( v )).."),"..charE )
            else
               local value =  ( type( v ) == "string" and exportstring( v ) ) or tostring( v )
               file:write( value..","..charE )
            end
         end
      end
      file:write( "},"..charE )
   end
   file:write( "}" )
   -- Return Values
   -- return stringtable from string
   if not filename then
      -- set marker for stringtable
      return file.str.."--|"
   -- return stringttable from file
   elseif filename == true or filename == 1 then
      file:seek ( "set" )
      -- no need to close file, it gets closed and removed automatically
      -- set marker for stringtable
      return file:read( "*a" ).."--|"
   -- close file and return 1
   else
      file:close()
      return 1
   end
end

--// The Load Function
local function table_load( sfile )
   -- catch marker for stringtable
   if string.sub( sfile,-3,-1 ) == "--|" then
      tables,err = loadstring( sfile )
   else
      tables,err = loadfile( sfile )
   end
   if err then return _,err
   end
   tables = tables()
   for idx = 1,#tables do
      local tolinkv,tolinki = {},{}
      for i,v in pairs( tables[idx] ) do
         if type( v ) == "table" and tables[v[1]] then
            table.insert( tolinkv,{ i,tables[v[1]] } )
         end
         if type( i ) == "table" and tables[i[1]] then
            table.insert( tolinki,{ i,tables[i[1]] } )
         end
      end
      -- link values, first due to possible changes of indices
      for _,v in ipairs( tolinkv ) do
         tables[idx][v[1]] = v[2]
      end
      -- link indices
      for _,v in ipairs( tolinki ) do
         tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
      end
   end
   return tables[1]
end

local owners_db_filename = minetest.get_worldpath("node_ownership") .. "/owners.tbl"

owner_defs = table_load(owners_db_filename)

if type(owner_defs) ~= "table" then
	owner_defs = {}
end

function IsPlayerNodeOwner(pos, name)
	r = true
	for _,def in pairs(owner_defs) do
		if pos.x >= def.x1 and pos.x <= def.x2 or
			pos.x <= def.x1 and pos.x >= def.x2 then
			
			if pos.y >= def.y1 and pos.y <= def.y2 or
				pos.y <= def.y1 and pos.y >= def.y2 then
				
				if pos.z >= def.z1 and pos.z <= def.z2 or
					pos.z <= def.z1 and pos.z >= def.z2 then
					
					if name == def.owner then
						return true
					else
						r = false
					end
				end
			end
		end
	end
	
	return r
end

function HasOwner(pos)
	for _,def in pairs(owner_defs) do
		if pos.x >= def.x1 and pos.x <= def.x2 or
			pos.x <= def.x1 and pos.x >= def.x2 then
			
			if pos.y >= def.y1 and pos.y <= def.y2 or
				pos.y <= def.y1 and pos.y >= def.y2 then
				
				if pos.z >= def.z1 and pos.z <= def.z2 or
					pos.z <= def.z1 and pos.z >= def.z2 then
					
					return true
				end
			end
		end
	end
	
	return false
end

local old_node_place = minetest.item_place
function minetest.item_place(itemstack, placer, pointed_thing)
	if itemstack:get_definition().type == "node" then
		local pos = pointed_thing.above
		if HasOwner(pos) then
			if not IsPlayerNodeOwner(pos, placer:get_player_name()) then
				minetest.chat_send_player(placer:get_player_name(), "You can not place nodes here.")
				return itemstack
			end
		end
		return old_node_place(itemstack, placer, pointed_thing)
	end
	
	return old_node_place(itemstack, placer, pointed_thing)
end

local old_node_dig = minetest.node_dig
function minetest.node_dig(pos, node, digger)
	if HasOwner(pos) then
		if not IsPlayerNodeOwner(pos, digger:get_player_name()) then
		minetest.chat_send_player(digger:get_player_name(), "You can not dig nodes here.")
			return
		end
	end
	old_node_dig(pos, node, digger)
end

function CheckCollisions(pos1, pos2)
	-- Find all 8 cube corners and make sure all 8 are not already in someone elses zone
	pos3 = {x=pos2.x,y=pos1.y,z=pos1.z}
	pos4 = {x=pos1.x,y=pos2.y,z=pos1.z}
	pos5 = {x=pos1.x,y=pos2.y,z=pos2.z}
	pos6 = {x=pos1.x,y=pos1.y,z=pos2.z}
	pos7 = {x=pos2.x,y=pos2.y,z=pos1.z}
	pos8 = {x=pos2.x,y=pos1.y,z=pos2.z}
	
	if HasOwner(pos1) == false and
		HasOwner(pos2) == false and
		HasOwner(pos3) == false and
		HasOwner(pos4) == false and
		HasOwner(pos5) == false and
		HasOwner(pos6) == false and
		HasOwner(pos7) == false and
		HasOwner(pos8) == false then
		return false
	end
	
	return true
end

function RemoveTableEntryRe(r_id)
	--Find child entries and remove them
	for n,def in pairs(owner_defs) do
		if def.parent == r_id then
			RemoveTableEntryRe(def.id)
		end
	end
	-- now remove main entry
	for n,def in pairs(owner_defs) do
		if def.id == r_id then
			table.remove(owner_defs, n)
			break
		end
	end
end

function RemoveTableEntry(r_id)
	RemoveTableEntryRe(r_id)
	
	--Re-number ids to match place in table
	for n,ndef in pairs(owner_defs) do
		if ndef.id ~= n then
			for p,pdef in pairs(owner_defs) do
				if pdef.parent == ndef.id then
					pdef.parent = n
				end
			end
			ndef.id = n
		end
	end
	
	table_save( owner_defs, owners_db_filename )
end

minetest.register_on_chat_message(function(name, message)
	local cmd = "/set_owner"
	if message:sub(0, #cmd) == cmd then
		if not minetest.get_player_privs(name)["privs"] then
			minetest.chat_send_player(name, "you don't have permission to do this")
			return true -- Handled chat message
		end
		local ownername, sx, sy, sz, ex, ey, ez = string.match(message, cmd.." (.-) ([0-9%-]-)%,([0-9%-]-)%,([0-9%-]-) ([0-9%-]-)%,([0-9%-]-)%,([0-9%-]*)")
		if ownername == nil or string.len(ownername) == 0
		or sx == nil or string.len(sx) == 0
		or sy == nil or string.len(sy) == 0
		or sz == nil or string.len(sz) == 0
		or ex == nil or string.len(ex) == 0
		or ey == nil or string.len(ey) == 0
		or ez == nil or string.len(ez) == 0
		then
			minetest.chat_send_player(name, 'usage: '..cmd..' playername startpos endpos')
			return true -- Handled chat message
		end
		local player = minetest.env:get_player_by_name(ownername)
		if player == nil then
			print("player is nil")
			return true -- Handled chat message
		end
		print(cmd.." invoked, owner=" .. ownername .. " startpos=" .. sx .. "," .. sy .. "," .. sz .. " endpos=" .. ex .. "," .. ey .. "," .. ez)
		
		sx = tonumber(sx)
		sy = tonumber(sy)
		sz = tonumber(sz)
		
		ex = tonumber(ex)
		ey = tonumber(ey)
		ez = tonumber(ez)
		
		if (CheckCollisions({x=sx,y=sy,z=sz}, {x=ex,y=ey,z=ez})) == true then
			minetest.chat_send_player(name, "Owner Collision")
			return true -- Handled chat message
		end	
		
		table.insert(owner_defs, {x1=sx, y1=sy, z1=sz, x2=ex, y2=ey, z2=ez, owner=ownername})
		owner_defs[table.maxn(owner_defs)].id = table.maxn(owner_defs)
		table_save( owner_defs, owners_db_filename )
		
		return true -- Handled chat message
	end
	local cmd = "/add_owner"
	if message:sub(0, #cmd) == cmd then
		local new_ownername, sx, sy, sz, ex, ey, ez = string.match(message, cmd.." (.-) ([0-9%-]-)%,([0-9%-]-)%,([0-9%-]-) ([0-9%-]-)%,([0-9%-]-)%,([0-9%-]*)")
		if new_ownername == nil or string.len(new_ownername) == 0
		or sx == nil or string.len(sx) == 0
		or sy == nil or string.len(sy) == 0
		or sz == nil or string.len(sz) == 0
		or ex == nil or string.len(ex) == 0
		or ey == nil or string.len(ey) == 0
		or ez == nil or string.len(ez) == 0
		then
			minetest.chat_send_player(name, 'usage: '..cmd..' playername startpos endpos')
			return true -- Handled chat message
		end
		local player = minetest.env:get_player_by_name(new_ownername)
		
		if player == nil then
			print("player is nil")
			return true -- Handled chat message
		end
		
		print(cmd.." invoked, new_ownername=" .. new_ownername .. " startpos=" .. sx .. "," .. sy .. "," .. sz .. " endpos=" .. ex .. "," .. ey .. "," .. ez)
		
		
		sx = tonumber(sx)
		sy = tonumber(sy)
		sz = tonumber(sz)
		
		ex = tonumber(ex)
		ey = tonumber(ey)
		ez = tonumber(ez)
		
		area_pos1 = {x=sx, y=sy, z=sz}
		area_pos2 = {x=ex, y=ey, z=ez}
		
		p=nil
		
		--Look to see if this new area is inside an area owned by the player using this function
		for n,def in pairs(owner_defs) do
			if (area_pos1.x >= def.x1 and area_pos1.x <= def.x2 or
				area_pos1.x <= def.x1 and area_pos1.x >= def.x2) and
				(area_pos2.x >= def.x1 and area_pos2.x <= def.x2 or
				area_pos2.x <= def.x1 and area_pos2.x >= def.x2) then
				
				if (area_pos1.y >= def.y1 and area_pos1.y <= def.y2 or
					area_pos1.y <= def.y1 and area_pos1.y >= def.y2) and
					(area_pos2.y >= def.y1 and area_pos2.y <= def.y2 or
					area_pos2.y <= def.y1 and area_pos2.y >= def.y2) then
					
					if (area_pos1.z >= def.z1 and area_pos1.z <= def.z2 or
						area_pos1.z <= def.z1 and area_pos1.z >= def.z2) and
						(area_pos2.z >= def.z1 and area_pos2.z <= def.z2 or
						area_pos2.z <= def.z1 and area_pos2.z >= def.z2) then
						
						--OK, found entry that has both area_poss
						if def.owner == name then
							p=def.id
							break
						end
					end
				end
			end
		end
		
		if p == nil then
			minetest.chat_send_player(name, "You don't have permission to do this")
			return true -- Handled chat message
		end
		
		table.insert(owner_defs, {x1=sx, y1=sy, z1=sz, x2=ex, y2=ey, z2=ez, owner=new_ownername})
		if p ~= nil then
			owner_defs[table.maxn(owner_defs)].parent = p
		end
		owner_defs[table.maxn(owner_defs)].id = table.maxn(owner_defs)
		table_save( owner_defs, owners_db_filename )
		
		return true -- Handled chat message
	end
	local cmd = "/list_areas"
	if message:sub(0, #cmd) == cmd then
		show_all = false
		if minetest.get_player_privs(name)["privs"] then
			show_all = true
			minetest.chat_send_player(name, "Showing all owner entries")
			for n,def in pairs(owner_defs) do
				entry = def.id .. ": " .. def.owner .. " (" .. def.x1 .. "," .. def.y1 .. "," .. def.z1 .. ") (" .. def.x2 .. "," .. def.y2 .. "," .. def.z2 .. ")"
				if def.parent ~= nil then
					entry = entry .. " parent: " .. def.parent
				end
				minetest.chat_send_player(name, entry)
			end
		else
			minetest.chat_send_player(name, "Showing your owner entries (You can delete only these)")
			for n,def in pairs(owner_defs) do
				if def.owner == name then
					entry = def.id .. ": " .. def.owner .. " (" .. def.x1 .. "," .. def.y1 .. "," .. def.z1 .. ") (" .. def.x2 .. "," .. def.y2 .. "," .. def.z2 .. ")"
					if def.parent ~= nil then
						entry = entry .. " parent: " .. def.parent
					end
					minetest.chat_send_player(name, entry)
					for n,defc in pairs(owner_defs) do
						if defc.parent == def.id then
							entry = "->" .. defc.id .. ": " .. defc.owner .. " (" .. defc.x1 .. "," .. defc.y1 .. "," .. defc.z1 .. ") (" .. defc.x2 .. "," .. defc.y2 .. "," .. defc.z2 .. ")"
							if defc.parent ~= nil then
								entry = entry .. " parent: " .. defc.parent
							end
							minetest.chat_send_player(name, entry)
						end
					end
				end
			end
		end
		return true -- Handled chat message
	end
	local cmd = "/remove_areas"
	if message:sub(0, #cmd) == cmd then
		your_ids = {}
		for n,def in pairs(owner_defs) do
			if def.owner == name then
				table.insert(your_ids, def.id)
				for n,defc in pairs(owner_defs) do
					if defc.parent == def.id then
						table.insert(your_ids, defc.id)
					end
				end
			end
		end
		
		
		local e = string.match(message, cmd.." (.*)")
		
		if e == nil or string.len(e) == 0 then
			minetest.chat_send_player(name, 'usage: '..cmd..' entry_number')
			minetest.chat_send_player(name, 'use /list_owner_entries to see entries')
			return true -- Handled chat message
		end
		e = tonumber(e)
		found = false
		for _,k in pairs(your_ids) do
			if k == e then 
				RemoveTableEntry(e)
				table_save( owner_defs, owners_db_filename )
				return true -- Handled chat message
			end
		end
		return true -- Handled chat message
	end
	local cmd = "/change_area_owner"
	if message:sub(0, #cmd) == cmd then
		your_ids = {}
		for n,def in pairs(owner_defs) do
			if def.owner == name then
				table.insert(your_ids, def.id)
				for n,defc in pairs(owner_defs) do
					if defc.parent == def.id then
						table.insert(your_ids, defc.id)
					end
				end
			end
		end
		
		local e, new_owner = string.match(message, cmd.." (.-) (.*)")
		
		if e == nil or new_owner == nil or
		 string.len(e) == 0 or string.len(new_owner) == 0 then
			minetest.chat_send_player(name, 'usage: '..cmd..' entry_number new_owner')
			minetest.chat_send_player(name, 'use /list_owner_entries to see entries')
			return true -- Handled chat message
		end
		
		local player = minetest.env:get_player_by_name(new_owner)
		
		if player == nil then
			print("new_owner is nil")
			return true -- Handled chat message
		end
		e = tonumber(e)
		found = false
		for _,k in pairs(your_ids) do
			if k == e then 
				for n,def in pairs(owner_defs) do
					if def.id == e then
						owner_defs[n].owner = new_owner
						
						table_save( owner_defs, owners_db_filename )
						return true -- Handled chat message
					end
				end
				
			end
		end
		return true -- Handled chat message
	end
end)
