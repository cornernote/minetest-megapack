--
--
-- 		Author: Nemo08
--		Portal mod
--
	local version = "0.0.3"
--
--	

	local save_conf_time = 5
	local portals_content_conf = minetest.get_modpath('portal').."/portals_content"
	
	
	portal_list = {}
	halfportal_list = {} -- unfinished portals
	dofile (minetest.get_modpath('portal') .. "/portal_list.lua")
	portals_changed = false
	local rune_unactive = "portal:rune_raido_b"
	local rune_active = "portal:rune_raido_g"
	local rune_otherstone ="default:cobble"
	
	-----------------------------------------------------------------------------
	local base = _G
local function isValidType(valueType)
  return "number" == valueType or 
         "boolean" == valueType or 
         "string" == valueType
end

-- конвертация переменной в строку
local function valueToString (value)
  local valueType = base.type(value)
  
  if "number" == valueType or "boolean" == valueType then
    result = base.tostring(value)
  else  -- assume it is a string
    -- обратите внимание на флаг "%q"!
    -- этот флаг правильно обрабатывает строки, 
    -- содержащие в себе кавычки и другие управляющие символы
    result = base.string.format("%q", value)
  end
  
  return result
end

local function portal_save (sfile,name, value, saved)
  saved = saved or {}       -- initial value
  sfile:write(name, " = ")
  local valueType = base.type(value)
  if isValidType(valueType) then
    sfile:write(valueToString(value), "\n")
  elseif "table" == valueType then
    if saved[value] then    -- value already saved?
      sfile:write(saved[value], "\n")  -- use its previous name
    else
      saved[value] = name   -- save name for next time
      sfile:write("{}\n")     -- create a new table
      for k,v in base.pairs(value) do      -- save its fields
        -- добавляем проверку ключа таблицы
        local keyType = base.type(k)
        if isValidType(keyType) then
          local fieldname = base.string.format("%s[%s]", name, valueToString(k))
          portal_save(sfile,fieldname, v, saved)
        else
          base.error("cannot save a " .. keyType)
        end
      end
    end
  else
    base.error("cannot save a " .. valueType)
  end
end
	-----------------------------------------------------------------------------
	
local function save_portals ()
		if portals_changed then
			local output = io.open(minetest.get_modpath('portal').."/portal_list.lua", "w")
			portal_save(output,"portal_list", portal_list)
			portal_save(output,"halfportal_list", halfportal_list)
			io.close(output)
			print("Сохранил порталы!!! ")
		end
	end	
	
	local delta = 0
	minetest.register_globalstep(function(dtime)
    delta = delta + dtime
    if delta > save_conf_time then
        delta = 0
		if portals_changed then
			save_portals()
			portals_changed = false
		end
    end
end)
	
	
function build_portal(pos,placer,size,rune,stone)
		local placer_pos = placer:getpos()
		local dirang = -1  -- in grad, 0 grad from x counterclockwise
		local ld = placer:get_look_dir()
		--print(pos.x,pos.z)
		--print(placer_pos.x,placer_pos.z)
		for j,k in pairs(halfportal_list) do
			if (placer.name == k.builder) then
				size = k.size
			end
		end
		
		if math.abs(ld.x)<math.abs(ld.z) then
			for i=0,(size-1) do
				minetest.env:add_node({x=(pos.x - (size-1)/2), y=(pos.y+i), z=pos.z}, {name=stone})
				minetest.env:add_node({x=(pos.x + (size-1)/2), y=(pos.y+i), z=pos.z}, {name=stone})
				minetest.env:add_node({x=(pos.x - (size-1)/2+i), y=(pos.y+(size-1)), z=(pos.z)}, {name=stone})
				minetest.env:add_node({x=(pos.x - (size-1)/2+i), y=(pos.y), z=pos.z}, {name=stone})
			end
			minetest.env:add_node({x=pos.x, y=pos.y, z=pos.z}, {name=rune})
			minetest.env:add_node({x=pos.x, y=(pos.y+(size-1)), z=pos.z}, {name=rune})
			minetest.env:add_node({x=(pos.x - (size-1)/2), y=(pos.y + (size-1)/2), z=pos.z}, {name=rune})
			minetest.env:add_node({x=(pos.x + (size-1)/2), y=(pos.y + (size-1)/2), z=pos.z}, {name=rune})
			
			dirang = 180 + (math.abs(ld.z) / ld.z) * 90
		else
			for i=0,(size-1) do
				minetest.env:add_node({x=pos.x, y=(pos.y+i), z=(pos.z - (size-1)/2)}, {name=stone})
				minetest.env:add_node({x=pos.x, y=(pos.y+i), z=(pos.z + (size-1)/2)}, {name=stone})
				minetest.env:add_node({x=pos.x, y=(pos.y+(size-1)), z=(pos.z - (size-1)/2+i)}, {name=stone})
				minetest.env:add_node({x=pos.x, y=(pos.y), z=(pos.z - (size-1)/2+i)}, {name=stone})
			end
			minetest.env:add_node({x=pos.x, y=pos.y, z=pos.z}, {name=rune})
			minetest.env:add_node({x=pos.x, y=(pos.y+(size-1)), z=pos.z}, {name=rune})
			minetest.env:add_node({x=pos.x, y=(pos.y + (size-1)/2), z=(pos.z - (size-1)/2)}, {name=rune})
			minetest.env:add_node({x=pos.x, y=(pos.y + (size-1)/2), z=(pos.z + (size-1)/2)}, {name=rune})
			
			dirang = 90 - (math.abs(ld.x) / ld.x) * 90
		end

			local findhalf = false
			local placername = placer:get_player_name()
			
			for j, k in pairs(halfportal_list) do
				if (placername == k.builder) then
					--print("Нашол полупортал этого игрока! ",j," , добавляю этот и " .. pos.x .."_" .. pos.y .. "_" .. pos.z .. " в полный портал")
					print("player "..placer:get_player_name().." build fullportal ("..pos.x..","..pos.y..","..pos.z..")->("..k.myx..","..k.myy..","..k.myz..")")
					portal_list[pos.x .."_" .. pos.y .. "_" .. pos.z] = { 	builder = placername, --this portal add to portal_list
																			type ="public",
																			portaltype = "door",
																			size = size,
																			exname = j,
																			state = "built",
																			dir = dirang,
																			myx = pos.x,
																			myy = pos.y,
																			myz = pos.z,
																			name = "",
																			}
					portal_list[k.myx .."_" .. k.myy .. "_" .. k.myz] = { 	builder = placername, --target portal add to portal_list
																			type ="public",
																			portaltype = "door",
																			size = k.size,
																			exname = pos.x .."_" .. pos.y .. "_" .. pos.z,
																			state = "built",
																			dir = k.dir,
																			myx = k.myx,
																			myy = k.myy,
																			myz = k.myz,	
																			name = "",
																			}
					halfportal_list[j] = nil -- rem target from halfportal
					check_portal_door(pos)
					findhalf = true
				end
			end
			
			if findhalf == false then --we dont find other halfportal, add this to halfportal_list
				--print("Не нашол полупортала этого игрока, добавляю ".. pos.x .."_" .. pos.y .. "_" .. pos.z)
				print("player "..placer:get_player_name().." build halfportal ("..pos.x..","..pos.y..","..pos.z..")")
				--local pinv = placer.get_inventory()
				local pinv = placer:get_inventory()
				pinv:autoinsert_stackstring("main",  'node "portal:rune_raido_b" 1')
				--placer:add_to_inventory("main", 'node "portal:rune_raido_b" 1')
				halfportal_list[pos.x .."_" .. pos.y .. "_" .. pos.z] = { 	builder = placername, --this portal add to portal_list
																			type ="public",
																			portaltype = "door",
																			size = size,
																			exname = "no_exit!",
																			state = "half",
																			dir = dirang,
																			myx = pos.x,
																			myy = pos.y,
																			myz = pos.z,
																			name = "",
																		}
			end
		
		minetest.env:add_entity({x=pos.x,y=pos.y,z=pos.z},'portal:portal_control_ent')
		portals_changed = true
	end
	
local function remove_portal_door(pos,entity)
		pos.x = math.floor(pos.x)
		pos.y = math.floor(pos.y)
		pos.z = math.floor(pos.z)
		local this_portal = {}
		if portal_list[pos.x .."_" .. pos.y .. "_" .. pos.z] ~= nil then
			this_portal = portal_list[pos.x .."_" .. pos.y .. "_" .. pos.z]
		else
			this_portal = halfportal_list[pos.x .."_" .. pos.y .. "_" .. pos.z]
		end
		if this_portal.portaltype ~= "door" then
			return
		end
		if (this_portal.dir == 90)or(this_portal.dir == 270) then
			for i=0,(this_portal.size-1) do
				minetest.env:remove_node({x=(pos.x - (this_portal.size-1)/2), y=(pos.y+i), z=pos.z})
				minetest.env:remove_node({x=(pos.x + (this_portal.size-1)/2), y=(pos.y+i), z=pos.z})
				minetest.env:remove_node({x=(pos.x - (this_portal.size-1)/2+i), y=(pos.y+(this_portal.size-1)), z=(pos.z)})
				minetest.env:remove_node({x=(pos.x - (this_portal.size-1)/2+i), y=(pos.y), z=pos.z})
			end
		else
			for i=0,(this_portal.size-1) do
				minetest.env:remove_node({x=pos.x, y=(pos.y+i), z=(pos.z - (this_portal.size-1)/2)})
				minetest.env:remove_node({x=pos.x, y=(pos.y+i), z=(pos.z + (this_portal.size-1)/2)})
				minetest.env:remove_node({x=pos.x, y=(pos.y+(this_portal.size-1)), z=(pos.z - (this_portal.size-1)/2+i)})
				minetest.env:remove_node({x=pos.x, y=(pos.y), z=(pos.z - (this_portal.size-1)/2+i)})
			end
		end
		if portal_list[pos.x .."_" .. pos.y .. "_" .. pos.z] ~= nil then
			--portal_list[this_portal.exname].state = "deleted"
			portal_list[pos.x .."_" .. pos.y .. "_" .. pos.z] = nil
		else
			halfportal_list[pos.x .."_" .. pos.y .. "_" .. pos.z] = nil
		end
		entity.object:remove()
		portals_changed = true
	end
	
	function check_portal_door(pos,entity)
		pos.x = math.floor(pos.x)
		pos.y = math.floor(pos.y)
		pos.z = math.floor(pos.z)
		local this_portal = {}
		if portal_list[pos.x .."_" .. pos.y .. "_" .. pos.z] ~= nil then
			this_portal = portal_list[pos.x .."_" .. pos.y .. "_" .. pos.z]
		else
			this_portal = halfportal_list[pos.x .."_" .. pos.y .. "_" .. pos.z]
		end
		if this_portal.portaltype ~= "door" then
			return
		end
		if (this_portal.state == "built") then
			if (this_portal.dir == 90)or(this_portal.dir == 270) then
				minetest.env:add_node({x=pos.x, y=pos.y, z=pos.z}, {name="portal:rune_raido_g"})
				minetest.env:add_node({x=pos.x, y=(pos.y+(this_portal.size-1)), z=pos.z}, {name="portal:rune_raido_g"})
				minetest.env:add_node({x=(pos.x - (this_portal.size-1)/2), y=(pos.y + (this_portal.size-1)/2), z=pos.z}, {name="portal:rune_raido_g"})
				minetest.env:add_node({x=(pos.x + (this_portal.size-1)/2), y=(pos.y + (this_portal.size-1)/2), z=pos.z}, {name="portal:rune_raido_g"})
			elseif (this_portal.state == "half") then
				minetest.env:add_node({x=pos.x, y=pos.y, z=pos.z}, {name="portal:rune_raido_g"})
				minetest.env:add_node({x=pos.x, y=(pos.y+(this_portal.size-1)), z=pos.z}, {name="portal:rune_raido_g"})
				minetest.env:add_node({x=pos.x, y=(pos.y + (this_portal.size-1)/2), z=(pos.z - (this_portal.size-1)/2)}, {name="portal:rune_raido_g"})
				minetest.env:add_node({x=pos.x, y=(pos.y + (this_portal.size-1)/2), z=(pos.z + (this_portal.size-1)/2)}, {name="portal:rune_raido_g"})
			end
		end
		print("check!!!!!!!!!!!!")
		local portal_broken = false
		local dynpos = {}
		local dynnodename = ""
		local nnames = {}
		if (this_portal.dir == 90)or(this_portal.dir == 270) then
			for i=0,(this_portal.size-1) do
				dynpos = {x=(pos.x - (this_portal.size-1)/2), y=(pos.y+i), z=pos.z}
				table.insert(nnames,minetest.env:get_node(dynpos).name)
				dynpos = {x=(pos.x + (this_portal.size-1)/2), y=(pos.y+i), z=pos.z}
				table.insert(nnames,minetest.env:get_node(dynpos).name)
				dynpos = {x=(pos.x - (this_portal.size-1)/2+i), y=(pos.y+(this_portal.size-1)), z=(pos.z)}
				table.insert(nnames,minetest.env:get_node(dynpos).name)
				dynpos = {x=(pos.x - (this_portal.size-1)/2+i), y=(pos.y), z=pos.z}
				table.insert(nnames,minetest.env:get_node(dynpos).name)
			end
			for i,j in ipairs(nnames) do
				if (j ~= rune_active) then
					if (j ~= rune_otherstone) then
						if (j ~= rune_unactive) then
							portal_broken = true
						end
					end
				end
			end
		else
			for i=0,(this_portal.size-1) do
				dynpos = {x=pos.x, y=(pos.y+i), z=(pos.z - (this_portal.size-1)/2)}
				table.insert(nnames,minetest.env:get_node(dynpos).name)
				dynpos = {x=pos.x, y=(pos.y+i), z=(pos.z + (this_portal.size-1)/2)}
				table.insert(nnames,minetest.env:get_node(dynpos).name)
				dynpos = {x=pos.x, y=(pos.y+(this_portal.size-1)), z=(pos.z - (this_portal.size-1)/2+i)}
				table.insert(nnames,minetest.env:get_node(dynpos).name)
				dynpos = {x=pos.x, y=(pos.y), z=(pos.z - (this_portal.size-1)/2+i)}
				table.insert(nnames,minetest.env:get_node(dynpos).name)
			end
			for i,j in ipairs(nnames) do
				if (j ~= rune_active) then
					if (j ~= rune_otherstone) then
						if (j ~= rune_unactive) then
							portal_broken = true
						end
					end
				end
			end
		end
		if portal_broken == true then
			print("portal "..pos.x .."_" .. pos.y .. "_" .. pos.z.. " broken!")
			if this_portal.state =="built" then
				portal_list[this_portal.exname].state = "deleted"
			end
			
			remove_portal_door(pos,entity)
		end
	end
	
	portal_control_ent = {
		physical = false,
		lastpos={},
		--initial_sprite_basepos = {x=0, y=0},
		mydir = -1,
		size = 0,
		type ="",
		owner = "",
		exname = "no_exit!",
		timer = 0,
		state="",
	}
	
	portal_control_ent.on_activate = function(self, data)
		local pos = self.object:getpos()
			pos.x = math.floor(pos.x)
			pos.y = math.floor(pos.y)
			pos.z = math.floor(pos.z)
		local this_portal = {}
		
		if portal_list[pos.x .."_" .. pos.y .. "_" .. pos.z] ~= nil then
			this_portal = portal_list[pos.x .."_" .. pos.y .. "_" .. pos.z]
		else
			this_portal = halfportal_list[pos.x .."_" .. pos.y .. "_" .. pos.z]
		end
		
		if this_portal == nil then
			self.object:remove()
			print("portal ent selfremove!!")
			return
		end
		if this_portal.portaltype ~= "door" then
			return
		end
		self.dir = this_portal.dir
		self.size = this_portal.size
		self.type = this_portal.type
		self.owner = this_portal.builder
		self.exname = this_portal.exname
		self.state = this_portal.state
		check_portal_door(pos,self)
	end
	
	portal_control_ent.on_step = function(self, dtime)
		self.timer=self.timer+dtime
		local pos = self.object:getpos()
			pos.x = math.floor(pos.x)
			pos.y = math.floor(pos.y)
			pos.z = math.floor(pos.z)
			
		if (self.timer>1)and(self.state ~= "deleted")and((self.state)) then
			self.timer = 0
			local this_portal = {}
			if portal_list[pos.x .."_" .. pos.y .. "_" .. pos.z] ~= nil then
				this_portal = portal_list[pos.x .."_" .. pos.y .. "_" .. pos.z]
			else
				this_portal = halfportal_list[pos.x .."_" .. pos.y .. "_" .. pos.z]
			end
			self.dir = this_portal.dir
			self.size = this_portal.size
			self.type = this_portal.type
			self.owner = this_portal.builder
			self.exname = this_portal.exname
			self.state = this_portal.state			
			
			local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y+(self.size-1)/2,z=pos.z}, self.size)
			for k, obj in pairs(objs) do
				if obj:get_player_name() ~= nil then
					local player_pos = obj:getpos()
					local player_tp = false
					local dir_to_player = 0
					local target_portal = portal_list[self.exname]
					local new_player_pos = {}
					local add_pos = 0
					if (self.dir == 0)or(self.dir == 180) then
						if 		((player_pos.x < (pos.x + (self.size-1)/2))and(player_pos.x > (pos.x - (self.size-1)/2))) and
								((player_pos.y < (pos.y + (self.size)))and(player_pos.y > pos.y)) then
							player_tp = true
							dir_to_player = pos.x - player_pos.x
							add_pos = pos.z - player_pos.z
						end
					end
					if (self.dir == 90)or(self.dir == 270) then
						if 		((player_pos.z < (pos.z + (self.size-1)/2))and(player_pos.z > (pos.z - (self.size-1)/2))) and
								((player_pos.y < (pos.y + (self.size)))and(player_pos.y > pos.y)) then
							player_tp = true
							dir_to_player = pos.z - player_pos.z
							add_pos = pos.x - player_pos.x
						end
					end
					if (self.state == "built")and(player_tp==true) then
						if (target_portal.dir == 90)or(target_portal.dir == 270) then
							new_player_pos.z = target_portal.myz + 2*(add_pos / math.abs(add_pos))
							new_player_pos.x = target_portal.myx + (dir_to_player)
						else
							new_player_pos.x = target_portal.myx + 2*(add_pos / math.abs(add_pos))
							new_player_pos.z = target_portal.myz + (dir_to_player)
						end
						new_player_pos.y = (player_pos.y - pos.y) + target_portal.myy
						print("player "..obj:get_player_name().." teleports from (" ..pos.x..","..pos.y..","..pos.z..") to ("..target_portal.myx..","..target_portal.myy..","..target_portal.myz..")")
						obj:setpos(new_player_pos)
					end
				end
			end
			check_portal_door(pos,self)
		end
		if (self.state == "deleted") then
			remove_portal_door(pos,self)
		end
	end
	
	minetest.register_entity("portal:portal_control_ent", portal_control_ent)
	
	------------ Nodes ----------------
	minetest.register_node("portal:rune_raido_b", {
		tiles = {"default_cobble.png","default_cobble.png","raido_b.png","raido_b.png","raido_b.png","raido_b.png"},
		inventory_image = minetest.inventorycube("raido_b.png"),
		is_ground_content = false,
		material = minetest.digprop_dirtlike(1.0),
		drop = 'node "portal:rune_raido_b" 1',
	})
	minetest.register_node("portal:rune_raido_g", {
		tiles = {"default_cobble.png","default_cobble.png","raido_g.png","raido_g.png","raido_g.png","raido_g.png"},
		inventory_image = minetest.inventorycube("raido_b.png"),
		is_ground_content = false,
		material = minetest.digprop_dirtlike(1.0),
		drop = 'node "portal:rune_raido_b" 1',
		light_source = 8,
	})

minetest.register_on_placenode(function(pos, newnode, placer)
	if newnode.name == "portal:rune_raido_b" then
		build_portal(pos,placer,5,rune_unactive,rune_otherstone)
	end
end)

minetest.register_craft({
	output = 'node "portal:rune_raido_b" 1',
	recipe = {
		{'node "default:sand"', 'node "default:wood"','node "default:cobble"'},
		{'node "default:dirt"', 'node "default:mese" 5','node "default:jungletree"'},
		{'node "default:cactus"','node "default:leaves"','node "default:tree"'}
	}
})

---------- PENTAS -----------
function add_penta_portal(name,pos)

	if check_activated_portal_integrity(pos) == false then return false; end

	local nameinbase =  false
	for i,j in pairs(portal_list) do
		if j.name == name then
			nameinbase =  false
			return nil
		end
	end
	if nameinbase ==  false then
		portal_list[pos.x .."_" .. pos.y .. "_" .. pos.z] = { 	builder = placername, --this portal add to portal_list
			type ="public",
			portaltype = "penta",
			size = size,
			exname = j,
			state = "penta",
			dir = dirang,
			myx = pos.x,
			myy = pos.y,
			myz = pos.z,
			name = name,
		}
		portals_changed = true
		save_portals ()
		print("penta "..name.." added")
		minetest.chat_send_all('Portal ' .. name.. ' made!')
		return true
	end
end

function get_penta_portal_pos(name)
	for i,j in pairs(portal_list) do
		if (j.name == name)and(j.portaltype == "penta") then
			return {x =j.myx,y=j.myy,z=j.myz}
		end
	end
	return false
end

function remove_penta_portal(name)
	local p_pos = get_penta_portal_pos(name)
	if p_pos ~= false then
		portal_list[p_pos.x .."_" .. p_pos.y .. "_" .. p_pos.z] = nil
		portals_changed = true
		save_portals ()
		print("[Portal] Penta "..name .." removed!")
		minetest.chat_send_all('Portal ' .. name.. ' removed!')
		deactivate_activated_portal(p_pos)
		return true
	else
		return false
	end
end

function move_player_to_penta_name(player_obj,pname)
	local to_pos = get_penta_portal_pos(pname)
	if to_pos ~= false then
		print("[Portal] Player "..player_obj:get_player_name().." teleports to penta '" ..pname.."'!")
		player_obj:setpos({x =to_pos.x,y=to_pos.y+0.5,z=to_pos.z})
		if check_activated_portal_integrity(to_pos) == false then
			remove_penta_portal(pname)
			print("[Portal] Penta "..pname.." broken!")
		end
		return true
	else
		print("[Portal] No any pentas with name "..pname.."!")
		return false
	end
end

-------------------------------------------------------------------------------

local replace_node = function(pos, n)
	minetest.env:remove_node(pos)
	minetest.env:add_node(pos, {name = n})
end

local texture = "obsidian_block.png"

check_portal_integrity = function(pos)
	local co = 1
	for i=-1,1 do
		for j=-1,1 do
			p = {x = pos.x+j,y = pos.y,z = pos.z+i}
			if minetest.env:get_node(p).name~="portal:baph_" .. co then return false; end
			co = co +1 
		end
	end
	return true
end

check_activated_portal_integrity = function(pos)
	local co = 1
	for i=-1,1 do
		for j=-1,1 do
			p = {x = pos.x+j,y = pos.y-0.2,z = pos.z+i}
			if minetest.env:get_node(p).name~="portal:baph_" .. co .. "_act" then return false; end
			co = co +1 
		end
	end
	return true
end

deactivate_activated_portal = function(pos)
	if pos == false then return; end
	local co = 1
	for i=-1,1 do
		for j=-1,1 do
			p = {x = pos.x+j,y = pos.y,z = pos.z+i}
			if minetest.env:get_node(p).name=="portal:baph_" .. co .. "_act" then
				replace_node(p,"portal:baph_" .. co)
			end
			co = co +1 
		end
	end
	print("[Portal] Penta deactivated!")
	return true
end


for i = 1, 9 do 
	minetest.register_node("portal:baph_" .. i, {
		tiles = {"baph_obs.png^baph" .. i .. ".png",texture,texture,texture,texture,texture},
		inventory_image = minetest.inventorycube("obsidian_block.png"),
		is_ground_content = true,
		material = minetest.digprop_glasslike(5.0),
		drop = 'node "obsidian:obsidian_block" 1',
	})

	minetest.register_node("portal:baph_" .. i .. "_act", {
		tiles = {"baph" .. i .. "_a.png",texture,texture,texture,texture,texture},
		inventory_image = "baph" .. i .. "_a.png",
		inventory_image = minetest.inventorycube("obsidian_block.png"),
		is_ground_content = true,
		diggable = false,
		--material = minetest.digprop_glasslike(5.0),
		drop = 'node "obsidian:obsidian_block" 1',
		light_source = 14-1,
	})
end

minetest.register_on_punchnode(function(pos, node, puncher)
	local tool = puncher.get_wielded_item(puncher)
    if (tool == nil) or (tool.name ~= "obsidian:obsidian_knife") then return; end
	if (node.name == "obsidian:obsidian_block")or minetest.env:get_node(p).name=="portal:baph_5" then 
		local co = 1
		for i=-1,1 do
			for j=-1,1 do
				p = {x = pos.x+j,y = pos.y,z = pos.z+i}
				if minetest.env:get_node(p).name=="obsidian:obsidian_block" then 
					replace_node(p,"portal:baph_" .. co)
				end
				co = co +1 
			end
		end
	end
end)

minetest.register_on_chat_message(function(name, message)
	local cmd = "/activate"
	if message:sub(0, #cmd) == cmd then
		print("activate")
		local cmd = "/activate"
		local pname = string.match(message, cmd.." (.*)")
		if pname == nil then
			minetest.chat_send_player(name, 'usage: '..cmd..' portal_name')
			return true -- Handled chat message
		end

		local player = minetest.env:get_player_by_name(name)
		local pos = player:getpos()
		pos.y = pos.y -0.2
		print("[Portal] Trying to activete " .. pos.x..' ' .. pos.y..' ' .. pos.z..'...')

		if (check_portal_integrity(pos)) then 
			minetest.chat_send_player(name, "AVE SATANAS!")

			local co = 1
			for i=-1,1 do
				for j=-1,1 do
					p = {x = pos.x+j,y = pos.y,z =pos.z+i}
					replace_node(p,"portal:baph_" .. co .. "_act")
					co = co +1 
				end
			end
			add_penta_portal(pname,pos)
		end
		return true
	end
end)

minetest.register_on_chat_message(function(name, message)
	local cmd = "/tp"
	if message:sub(0, #cmd) == cmd then
		local pname = string.match(message, cmd.." (.*)")
		if pname == nil then
			minetest.chat_send_player(name, 'usage: '..cmd..' portal_name')
			return true -- Handled chat message
		end
		local player = minetest.env:get_player_by_name(name)
		local pos = player:getpos()
		pos.y = pos.y -0.2
		if check_activated_portal_integrity(pos) == false then
			minetest.chat_send_player(name,"Started portal broken!")
			deactivate_activated_portal(pos)
			return true
		elseif move_player_to_penta_name(player,pname) == true then
			minetest.chat_send_player(name,'You teleported to ' .. pname.. '!')
			return true
		else
			minetest.chat_send_player(name,' Can\'t teleport you to ' .. pname.. '!')
			return true
		end
	end
end)

minetest.register_on_chat_message(function(name, message)
	local cmd = "/deactivate"
	if message:sub(0, #cmd) == cmd then
		local pname = string.match(message, cmd.." (.*)")
		if pname == nil then
			local player = minetest.env:get_player_by_name(name)
			local pos = player:getpos()
			pos.y = pos.y -0.2
			if deactivate_activated_portal(pos) == false then
				minetest.chat_send_player(name, 'usage: '..cmd..' portal_name')
			else
				minetest.chat_send_player(name,'Portal under you deactivated')
			end
			return true -- Handled chat message
		end
		local player = minetest.env:get_player_by_name(name)
		local pos = player:getpos()
		pos.y = pos.y -0.2
		
		if (remove_penta_portal(pname) == false) then
			deactivate_activated_portal(get_penta_portal_pos(pname))
			return true
		end
		return true
	end
end)
-------------------------------------------------------------------------------
print("[Portal " .. version .. "] Loaded!")
