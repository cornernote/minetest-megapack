-- Save table functions (functions made local so this file is portable)
-- http://lua-users.org/wiki/SaveTableToFile
--[[
   Save Table to File
   Load Table from File
   v 1.0
   
   Lua 5.2 compatible
   
   Only Saves Tables, Numbers and Strings
   Insides Table References are saved
   Does not save Userdata, Metatables, Functions and indices of these
   ----------------------------------------------------
   table.save( table , filename )
   
   on failure: returns an error msg
   
   ----------------------------------------------------
   table.load( filename or stringtable )
   
   Loads a table that has been saved via the table.save function
   
   on success: returns a previously saved table
   on failure: returns as second argument an error msg
   ----------------------------------------------------
   
   Licensed under the same terms as Lua itself.
]]--

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


minetest.register_craftitem("admin_tools:remove_stick", {
	description = "Admin Remove Stick",
	inventory_image = "admin_tools_removestick.png",
	on_use = function(item, user, pointed_thing)
		if pointed_thing.type == "node" then
			minetest.env:remove_node(pointed_thing.under)
		elseif pointed_thing.type == "object" then
			obj = pointed_thing.ref
			if obj ~= nil then
				if obj:get_player_name() ~= nil then
					-- Player
					obj:set_hp(-1)
				else
					-- Mob or other entity
					obj:remove()
				end
			end
		end
	end,
	stack_max = 1,
	liquids_pointable = true,
})

admin_tools = {} -- exported functions

local admin_tools_privileges_db_filename = minetest.get_worldpath("admin_tools") .. "/admin_tools_player_privileges.tbl"

local admin_tools_privileges_defs = table_load(admin_tools_privileges_db_filename)

if type(admin_tools_privileges_defs) ~= "table" then
	admin_tools_privileges_defs = {}
end

table_save( admin_tools_privileges_defs, admin_tools_privileges_db_filename )

function admin_tools.set_privilege(player_name, priv, value)
	-- sanity check
	if type(player_name) ~= "string" or type(priv) ~= "string" or type(value) ~= "boolean" then
		return false
	end
	
	if admin_tools_privileges_defs[player_name] == nil then
		admin_tools_privileges_defs[player_name] = {}
	end
	admin_tools_privileges_defs[player_name][priv] = value
	
	table_save( admin_tools_privileges_defs, admin_tools_privileges_db_filename )
end

function admin_tools.get_privileges(player_name, priv)
	-- sanity check
	if type(player_name) ~= "string" or type(priv) ~= "string" then
		return nil
	end
	
	if admin_tools_privileges_defs[player_name] == nil then
		return false
	elseif admin_tools_privileges_defs[player_name][priv] == nil then
		return false
	end
	
	return admin_tools_privileges_defs[player_name][priv]
end


