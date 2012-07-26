--=========
-- Maximum speed of the cart
--=========
local MAX_SPEED = 4.5
--=========
-- Transport the player like a normal item
-- Note: This is extremly laggy <- FIXME
--=========
local TRANSPORT_PLAYER = true
--=========
-- The name of the Soundfile
--=========
local SOUND_FILE = ""

RAILS = {"default:rail", "carts:meseconrail_off", "carts:meseconrail_on", "carts:meseconrail_stop_off", "carts:meseconrail_stop_on"}

--Initialwerte
local cart = {
	physical = true,
	collisionbox = {-0.425, -0.425, -0.425, 0.425, 0.425, 0.425},
	visual = "cube",
	textures = {"carts_cart_top.png", "carts_cart_bottom.png", "carts_cart_side.png", "carts_cart_side.png", "carts_cart_side.png", "carts_cart_side.png"},
	visual_size = {x=.85, y=.85, z=0.85},
	--Variablen
	fahren = false, -- gibt an ob in irgeneiner weise gefahren wird
	fallen = false, -- gibt an, ob das cart bergab fährt
	bremsen = false, -- gibt an, ob das cart bremst/bremsen soll
	dir = nil, -- gibt die Fahrtrichtung an
	old_dir = nil, -- speichert Fahrtrichtung auch beim stehen
	items = {}, -- Liste der zu transportierenden items
	weiche = {x=nil, y=nil, z=nil}, -- wenn gerade über Weiche gefahren wird die Position hier gespeichert (um Dopplungen zu verhindern)
	sound_handler = nil, -- Referenz auf den Sound-Hanlder vom cart
}

--Aktuelle Geschwindigkeit in Fahrtrichtung zurückgeben
function cart:get_speed()
	if self.dir == "x+" then
		return self.object:getvelocity().x
	elseif self.dir == "x-" then
		return -1*self.object:getvelocity().x
	elseif self.dir == "z+" then
		return self.object:getvelocity().z
	elseif self.dir == "z-" then
		return -1*self.object:getvelocity().z
	end
	return 0
end

--Geschwindigkeit abhängig von der Fahrtrichtung setzen
function cart:set_speed(speed)
	local newsp = {x=0, y=0, z=0}
	if self.dir == "x+" then
		newsp.x = speed
	elseif self.dir == "x-" then
		newsp.x = -1*speed
	elseif self.dir == "z+" then
		newsp.z = speed
	elseif self.dir == "z-" then
		newsp.z = -1*speed
	end
	self.object:setvelocity(newsp)
end

--Beschleunigung abhängig von der Fahrtrichtung setzen
function cart:set_acceleration(staerke)
	if self.dir == "x+" then
		self.object:setacceleration({x=staerke, y=-10, z=0})
	elseif self.dir == "x-" then
		self.object:setacceleration({x=-staerke, y=-10, z=0})
	elseif self.dir == "z+" then
		self.object:setacceleration({x=0, y=-10, z=staerke})
	elseif self.dir == "z-" then
		self.object:setacceleration({x=0, y=-10, z=-staerke})
	end
end

--Anhalten und Startzustand wiederherstellen
function cart:stop()
	self.fahren = false
	self.bremsen = false
	self.items = {}
	self.fallen = false
	self.object:setacceleration({x = 0, y = -10, z = 0})
	self:set_speed(0)
	local pos = self.object:getpos()
	self.object:setpos(pos)
	if self.sound_handler ~= nil then
		minetest.sound_stop(self.sound_handler)
		self.sound_handler = nil
	end
end

--Abhängig von der aktuellen Fahrtrichtung die neue Fahrtrichtung bestimmen
--Es werden von oben die Möglichkeiten geprüft und die oberste der Möglichen genommen
--1. Geradeaus
--2. Rechts
--3. Links
--4. Halt
function cart:get_new_direction()
	local pos = self.object:getpos()
	if self.dir == nil then
		return nil
	end
	pos.x = math.floor(0.5+pos.x)
	pos.y = math.floor(0.5+pos.y)
	pos.z = math.floor(0.5+pos.z)
	if self.fallen then
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == rail then
				return "y-"
			end
		end
	end
	if self.dir == "x+" then
		pos.x = pos.x+1
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				pos.x = pos.x-1
				local meta = minetest.env:get_meta(pos)
				if meta:get_string("rail_direction") == "right" and not pos_equals(pos, self.weiche) then
					pos.z = pos.z+1
					for i,rail1 in ipairs(RAILS) do
						if minetest.env:get_node(pos).name == rail1 then
							self.weiche = {x=pos.x, y=pos.y, z=pos.z-1}
							return "z+"
						end
					end
					pos.z = pos.z-1
				elseif meta:get_string("rail_direction") == "left" and not pos_equals(pos, self.weiche) then
					pos.z = pos.z-1
					for i,rail1 in ipairs(RAILS) do
						if minetest.env:get_node(pos).name == rail1 then
							self.weiche = {x=pos.x, y=pos.y, z=pos.z+1}
							return "z-"
						end
					end
					pos.z = pos.z+1
				end
				
				return "x+"
			end
		end
		pos.y = pos.y-1
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "y-"
			end
		end
		pos.y = pos.y+2
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "y+"
			end
		end
		pos.y = pos.y-1
		pos.x = pos.x-1
		
		local tmp = minetest.env:get_meta(pos):get_string("rail_direction")
		if tmp == "left" then
			pos.z = pos.z+1
			for i,rail in ipairs(RAILS) do
				if minetest.env:get_node(pos).name == rail then
					return "z+"
				end
			end
			pos.z = pos.z-1
		elseif tmp == "right" then
			pos.z = pos.z-1
			for i,rail in ipairs(RAILS) do
				if minetest.env:get_node(pos).name == rail then
					return "z-"
				end
			end
			pos.z = pos.z+1
		end
		
		pos.z = pos.z-1
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "z-"
			end
		end
		pos.z = pos.z+2
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "z+"
			end
		end
		pos.z = pos.z-1
	elseif self.dir == "x-" then
		pos.x = pos.x-1
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				pos.x = pos.x+1
				local meta = minetest.env:get_meta(pos)
				if meta:get_string("rail_direction") == "left" and not pos_equals(pos, self.weiche) then
					pos.z = pos.z+1
					for i,rail1 in ipairs(RAILS) do
						if minetest.env:get_node(pos).name == rail1 then
							self.weiche = {x=pos.x, y=pos.y, z=pos.z-1}
							return "z+"
						end
					end
					pos.z = pos.z-1
				elseif meta:get_string("rail_direction") == "right" and not pos_equals(pos, self.weiche) then
					pos.z = pos.z-1
					for i,rail1 in ipairs(RAILS) do
						if minetest.env:get_node(pos).name == rail1 then
							self.weiche = {x=pos.x, y=pos.y, z=pos.z+1}
							return "z-"
						end
					end
					pos.z = pos.z+1
				end
				
				return "x-"
			end
		end
		pos.y = pos.y-1
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "y-"
			end
		end
		pos.y = pos.y+2
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "y+"
			end
		end
		pos.y = pos.y-1
		pos.x = pos.x+1
		
		local tmp = minetest.env:get_meta(pos):get_string("rail_direction")
		if tmp == "left" then
			pos.z = pos.z-1
			for i,rail in ipairs(RAILS) do
				if minetest.env:get_node(pos).name == rail then
					return "z-"
				end
			end
			pos.z = pos.z+1
		elseif tmp == "right" then
			pos.z = pos.z+1
			for i,rail in ipairs(RAILS) do
				if minetest.env:get_node(pos).name == rail then
					return "z+"
				end
			end
			pos.z = pos.z-1
		end
		
		pos.z = pos.z+1
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "z+"
			end
		end
		pos.z = pos.z-2
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "z-"
			end
		end
		pos.z = pos.z+1
	elseif self.dir == "z+" then
		pos.z = pos.z+1
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				pos.z = pos.z-1
				local meta = minetest.env:get_meta(pos)
				if meta:get_string("rail_direction") == "left" and not pos_equals(pos, self.weiche) then
					pos.x = pos.x+1
					for i,rail1 in ipairs(RAILS) do
						if minetest.env:get_node(pos).name == rail1 then
							self.weiche = {x=pos.x-1, y=pos.y, z=pos.z}
							return "x+"
						end
					end
					pos.x = pos.x-1
				elseif meta:get_string("rail_direction") == "right" and not pos_equals(pos, self.weiche) then
					pos.x = pos.x-1
					for i,rail1 in ipairs(RAILS) do
						if minetest.env:get_node(pos).name == rail1 then
							self.weiche = {x=pos.x+1, y=pos.y, z=pos.z}
							return "x-"
						end
					end
					pos.x = pos.x+1
				end
				
				return "z+"
			end
		end
		pos.y = pos.y-1
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "y-"
			end
		end
		pos.y = pos.y+2
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "y+"
			end
		end
		pos.y = pos.y-1
		pos.z = pos.z-1
		
		local tmp = minetest.env:get_meta(pos):get_string("rail_direction")
			if tmp == "left" then
			pos.x = pos.x-1
			for i,rail in ipairs(RAILS) do
				if minetest.env:get_node(pos).name == rail then
					return "x-"
				end
			end
			pos.x = pos.x+1
		elseif tmp == "right" then
			pos.x = pos.x+1
			for i,rail in ipairs(RAILS) do
				if minetest.env:get_node(pos).name == rail then
					return "x+"
				end
			end
			pos.x = pos.x-1
		end
		
		pos.x = pos.x+1
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "x+"
			end
		end
		pos.x = pos.x-2
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "x-"
			end
		end
		pos.x = pos.x+1
	elseif self.dir == "z-" then
		pos.z = pos.z-1
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				pos.z = pos.z+1
				local meta = minetest.env:get_meta(pos)
				if meta:get_string("rail_direction") == "right" and not pos_equals(pos, self.weiche) then
					pos.x = pos.x+1
					for i,rail1 in ipairs(RAILS) do
						if minetest.env:get_node(pos).name == rail1 then
							self.weiche = {x=pos.x-1, y=pos.y, z=pos.z}
							return "x+"
						end
					end
					pos.x = pos.x-1
				elseif meta:get_string("rail_direction") == "left" and not pos_equals(pos, self.weiche) then
					pos.x = pos.x-1
					for i,rail1 in ipairs(RAILS) do
						if minetest.env:get_node(pos).name == rail1 then
							self.weiche = {x=pos.x+1, y=pos.y, z=pos.z}
							return "x-"
						end
					end
					pos.x = pos.x+1
				end
				
				return "z-"
			end
		end
		pos.y = pos.y-1
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "y-"
			end
		end
		pos.y = pos.y+2
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "y+"
			end
		end
		pos.y = pos.y-1
		pos.z = pos.z+1
		
		local tmp = minetest.env:get_meta(pos):get_string("rail_direction")
		if tmp == "left" then
			pos.x = pos.x+1
			for i,rail in ipairs(RAILS) do
				if minetest.env:get_node(pos).name == rail then
					return "x+"
				end
			end
			pos.x = pos.x-1
		elseif tmp == "right" then
			pos.x = pos.x-1
			for i,rail in ipairs(RAILS) do
				if minetest.env:get_node(pos).name == rail then
					return "x-"
				end
			end
			pos.x = pos.x+1
		end
		
		pos.x = pos.x-1
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "x-"
			end
		end
		pos.x = pos.x+2
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				return "x+"
			end
		end
		pos.x = pos.x-1
	end
	return nil
end

--Beim fahren: Aktuelle Position auswerten und Geschwindigkeit und Beschleunigung anpassen
--Sonst: Gravitation setzen
function cart:on_step(dtime)
	--Wenn nicht gefahren wird die Gravitation setzen
	if not self.fahren then
		self.object:setacceleration({x=0, y=-10, z=0})
		return
	end
	local pos_tmp = self.object:getpos()
	pos_tmp.x = math.floor(0.5+pos_tmp.x)
	pos_tmp.y = math.floor(0.5+pos_tmp.y)
	pos_tmp.z = math.floor(0.5+pos_tmp.z)
	if not pos_equals(pos_tmp, self.weiche) then
		self.weiche = {x=nil, y=nil, z=nil}
	end
	
	--Neue Richtung bestimmen
	local newdir = self:get_new_direction()
	--[[if newdir ~= nil then
		minetest.debug("[carts] Neue Richtung ist "..newdir)
	else
		minetest.debug("[carts] Cart muss anhalten")
	end]]
	--Ende des Gleises erreicht
	if newdir == nil and not self.fallen then
		self:stop()
		local pos = self.object:getpos()
		pos.x = math.floor(0.5+pos.x)
		pos.z = math.floor(0.5+pos.z)
		self.object:setpos(pos)
		return
	elseif newdir == "y+" then
		self.fallen = false
		local vel = self.object:getvelocity()
		vel.y = MAX_SPEED
		self.object:setvelocity(vel)
	elseif newdir == "y-" then
		local vel = self.object:getvelocity()
		vel.y = -2*MAX_SPEED
		self.object:setvelocity(vel)
		self.fallen = true
	--Richtungsänderung
	elseif newdir ~= self.dir then
		self.fallen = false
		local pos = self.object:getpos()
		--Warten bis der Kurvenstein nahezu erreicht wird
		if not equals(pos.x, math.floor(0.5+pos.x)) or not equals(pos.y, math.floor(0.5+pos.y)) or not equals(pos.z, math.floor(0.5+pos.z)) then
			return
		end
		--Genau auf die Kurve springen
		pos.x = math.floor(0.5+pos.x)
		pos.z = math.floor(0.5+pos.z)
		local speed = self:get_speed()
		self.dir = newdir
		self.old_dir = newdir
		self:set_speed(speed)
		self.object:setpos(pos)
	end
	
	if self.bremsen then
		if not equals(self:get_speed(), 0) then
			self:set_acceleration(-10)
		else
			self:stop()
		end
	else
		if self.fahren and self:get_speed() < MAX_SPEED then
			self:set_acceleration(10)
		else
			self:set_acceleration(0)
		end
	end
	
	--Items bewegen
	for i,item in ipairs(self.items) do
		if item:is_player() then
			local pos = self.object:getpos()
			pos.y = pos.y-0.5
			item:setpos(pos)
		else
			item:setpos(self.object:getpos())
		end
	end
	
	--Wenn neben dem Gleis eine Truhe steht werden die Items abgeladen
	for x=-1,1 do
		local pos = {x=self.object:getpos().x+x, y=self.object:getpos().y, z=self.object:getpos().z}
		local name = minetest.env:get_node(pos).name
		if name == "carts:chest" and self.items ~= {} then
			local items_tmp = {}
			for i,item in ipairs(self.items) do
				if not item:is_player() then
					item:setpos({x=math.floor(0.5+pos.x), y=math.floor(0.5+pos.y)+0.2, z=math.floor(0.5+pos.z)})
				else
					table.insert(items_tmp, item)
				end
			end
			self.items = items_tmp
		end
	end
	for z=-1,1 do
		local pos = {x=self.object:getpos().x, y=self.object:getpos().y, z=self.object:getpos().z+z}
		local name = minetest.env:get_node(pos).name
		if name == "carts:chest" and self.items ~= {} then
			local items_tmp = {}
			for i,item in ipairs(self.items) do
				if not item:is_player() then
					item:setpos({x=math.floor(0.5+pos.x), y=math.floor(0.5+pos.y)+0.2, z=math.floor(0.5+pos.z)})
				else
					table.insert(items_tmp, item)
				end
			end
			self.items = items_tmp
		end
	end
	
	--Mesecons
	if minetest.get_modpath("mesecons") ~= nil then
		local pos = self.object:getpos()
		pos.x = math.floor(0.5+pos.x)
		pos.y = math.floor(0.5+pos.y)
		pos.z = math.floor(0.5+pos.z)
		local name = minetest.env:get_node(pos).name
		if name == "carts:meseconrail_off" then
			minetest.env:set_node(pos, {name="carts:meseconrail_on"})
			mesecon:receptor_on(pos)
		end
		
		if name == "carts:meseconrail_stop_on" then
			self:stop()
			local pos = self.object:getpos()
			pos.x = math.floor(0.5+pos.x)
			pos.z = math.floor(0.5+pos.z)
			self.object:setpos(pos)
		return
		end
	end
end

--Bei rechtskilck: Anfaren oder Bremsen
function cart:on_rightclick(clicker)
	if self.fahren then
		self.bremsen = true
	else
		--Fahrtrichtung bestimmen
		local pos_cart = self.object:getpos()
		local pos_player = clicker:getpos()
		local res = {x=pos_cart.x-pos_player.x, z=pos_cart.z-pos_player.z}
		if math.abs(res.x) > math.abs(res.z) then
			if res.x < 0 then
				self.dir = "x-"
				self.old_dir = "x-"
				if self:get_new_direction() ~= "x-" then
					if res.z < 0 then
						self.dir = "z-"
						self.old_dir = "z-"
					else
						self.dir = "z+"
						self.old_dir = "z+"
					end
					if self:get_new_direction() ~= self.dir then
						self.dir = "x-"
						self.old_dir = "x-"
					end
				end
			else
				self.dir = "x+"
				self.old_dir = "x+"
				if self:get_new_direction() ~= "x+" then
					if res.z < 0 then
						self.dir = "z-"
						self.old_dir = "z-"
					else
						self.dir = "z+"
						self.old_dir = "z+"
					end
					if self:get_new_direction() ~= self.dir then
						self.dir = "x+"
						self.old_dir = "x+"
					end
				end
			end
		else
			if res.z < 0 then
				self.dir = "z-"
				self.old_dir = "z-"
				if self:get_new_direction() ~= "z-" then
					if res.x < 0 then
						self.dir = "x-"
						self.old_dir = "x-"
					else
						self.dir = "x+"
						self.old_dir = "x+"
					end
					if self:get_new_direction() ~= self.dir then
						self.dir = "z-"
						self.old_dir = "z-"
					end
				end
			else
				self.dir = "z+"
				self.old_dir = "z+"
				if self:get_new_direction() ~= "z+" then
					if res.x < 0 then
						self.dir = "x-"
						self.old_dir = "x-"
					else
						self.dir = "x+"
						self.old_dir = "x+"
					end
					if self:get_new_direction() ~= self.dir then
						self.dir = "z+"
						self.old_dir = "z+"
					end
				end
			end
		end
		--Items erfassen
		local tmp = minetest.env:get_objects_inside_radius(self.object:getpos(), 1)
		for i,item in ipairs(tmp) do
			if not item:is_player() and item:get_luaentity().name ~= "carts:cart" then
				table.insert(self.items, item)
			elseif item:is_player() and TRANSPORT_PLAYER then
				table.insert(self.items, item)
			end
		end
		
		--Sound
		self.sound_handler = minetest.sound_play(SOUND_FILE, {
			object = self.object,
			loop = true,
		})
		
		self.fahren = true
	end
end

--Wenn das Cart geschlagen wird: Cart entfernen und im Inventar einfügen
function cart:on_punch(hitter)
	if self.sound_handler ~= nil then
		minetest.sound_stop(self.sound_handler)
		self.sound_handler = nil
	end
	self.object:remove()
	hitter:get_inventory():add_item("main", "carts:cart")
end

function cart:get_staticdata()
	local str = tostring(self.fahren)
	str = str..","
	if self.fahren then
		str = str..self.dir
	end
	self.object:setvelocity({x=0, y=0, z=0})
	return str
end

--Beim einfügen des Carts die Gravitation setzen oder weiterfahren, wenn nur neugeladen
function cart:on_activate(staticdata)
	self.object:setacceleration({x = 0, y = -10, z = 0})
	self.items = {}
	if staticdata ~= nil then
		if string.find(staticdata, ",") ~= nil then
			if string.sub(staticdata, 1, string.find(staticdata, ",")-1)=="true" then
				self.dir = string.sub(staticdata, string.find(staticdata, ",")+1)
				self.old_dir = dir
				self.fahren = true
			end
		end
	end
end

minetest.register_entity("carts:cart", cart)

--Inventaritem erstellen
minetest.register_craftitem("carts:cart", {
	description = "Cart",
	image = minetest.inventorycube("carts_cart_top.png", "carts_cart_side.png", "carts_cart_side.png"),
	wield_image = "carts_cart_top.png",
	stack_max = 1,
	--Beim platzieren durch entity ersetzen
	on_place = function(itemstack, placer, pointed)
		local pos = pointed.under
		local bool = false
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				bool = true
			end
		end
		if not bool then
			pos = pointed.above
		end
		pos = {x = math.floor(0.5+pos.x), y = math.floor(0.5+pos.y), z = math.floor(0.5+pos.z)}
		minetest.env:add_entity(pos, "carts:cart")
		itemstack:take_item(1)
		return itemstack
	end,
})

minetest.register_craft({
	output = '"carts:cart" 1',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'}
	}
})

dofile(minetest.get_modpath("carts").."/switches.lua")
dofile(minetest.get_modpath("carts").."/mesecons.lua")
dofile(minetest.get_modpath("carts").."/chest.lua")
dofile(minetest.get_modpath("carts").."/functions.lua")
