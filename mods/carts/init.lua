--Help-Functions
local APPROXIMATION = 0.8

local equals = function(num1, num2)
	if math.abs(num1-num2) <= APPROXIMATION then
		return true
	else
		return false
	end
end

local pos_equals = function(pos1, pos2)
	if pos1.x == pos2.x and pos1.y == pos2.y and pos1.z == pos2.z then
		return true
	else
		return false
	end
end

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

local RAILS = {"default:rail", "carts:meseconrail_off", "carts:meseconrail_on"}

--Initialwerte
local cart = {
	physical = true,
	collisionbox = {-0.4, -0.4, -0.4, 0.4, 0.4, 0.4},
	visual = "cube",
	textures = {"carts_cart_top.png", "carts_cart_side.png", "carts_cart_side.png", "carts_cart_side.png", "carts_cart_side.png", "carts_cart_side.png"},
	visual_size = {x=.8, y=.8, z=0.8},
	--Variablen
	fahren = false,
	fallen = false,
	bremsen = false,
	v = 0,
	dir = nil,
	vertikal = -10,
	items = {},
	weiche = {x=nil, y=nil, z=nil},
	handler = nil,
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
		self.object:setacceleration({x=staerke, y=self.vertikal, z=0})
	elseif self.dir == "x-" then
		self.object:setacceleration({x=-staerke, y=self.vertikal, z=0})
	elseif self.dir == "z+" then
		self.object:setacceleration({x=0, y=self.vertikal, z=staerke})
	elseif self.dir == "z-" then
		self.object:setacceleration({x=0, y=self.vertikal, z=-staerke})
	end
end

--Anhalten und Startzustand wiederherstellen
function cart:stop()
	self.fahren = false
	self.bremsen = false
	self.items = {}
	self.vertikal = -10
	self.fallen = false
	self.object:setacceleration({x = 0, y = self.vertikal, z = 0})
	self:set_speed(0)
	local pos = self.object:getpos()
	self.object:setpos(pos)
	if self.handler ~= nil then
		minetest.sound_stop(self.handler)
		self.handler = nil
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
		self.object:setacceleration({x=0, y=self.vertikal, z=0})
		return
	end
	local pos_tmp = self.object:getpos()
	pos_tmp.x = math.floor(0.5+pos_tmp.x)
	pos_tmp.y = math.floor(0.5+pos_tmp.y)
	pos_tmp.z = math.floor(0.5+pos_tmp.z)
	if not pos_equals(pos_tmp, self.weiche) then
		self.weiche = {x=nil, y=nil, z=nil}
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
		self.vertikal = 30
	elseif newdir == "y-" then
		self.vertikal = -500
		self.fallen = true
	--Richtungsänderung
	elseif newdir ~= self.dir then
		self.fallen = false
		self.vertikal = -10
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
		self:set_speed(speed)
		self.object:setpos(pos)
	else
		self.vertikal = -10
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
	
	--Mesecons
	if minetest.get_modpath("mesecons") ~= nil then
		local pos = self.object:getpos()
		pos.x = math.floor(0.5+pos.x)
		pos.y = math.floor(0.5+pos.y)
		pos.z = math.floor(0.5+pos.z)
		local name = minetest.env:get_node(pos).name
		if name == "carts:meseconrail_off" then
			minetest.env:set_node(pos, {name="carts:meseconrail_on"})
			mesecon:receptor_on (pos)
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
			else
				self.dir = "x+"
			end
		else
			if res.z < 0 then
				self.dir = "z-"
			else
				self.dir = "z+"
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
		self.handler = minetest.sound_play(SOUND_FILE, {
			object = self.object,
			loop = true,
		})
		
		self.fahren = true
	end
end

--Wenn das Cart geschlagen wird: Cart entfernen und im Inventar einfügen
function cart:on_punch(hitter)
	if self.handler ~= nil then
		minetest.sound_stop(self.handler)
		self.handler = nil
	end
	self.object:remove()
	hitter:get_inventory():add_item("main", "carts:cart")
end

--Beim einfügen des Carts die Gravitation setzen
function cart:on_activate(staticdata)
	self.object:setacceleration({x = 0, y = self.vertikal, z = 0})
	self.items = {}
end

minetest.register_entity("carts:cart", cart)

--Inventaritem erstellen
minetest.register_craftitem("carts:cart", {
	image = minetest.inventorycube("carts_cart_top.png", "carts_cart_side.png", "carts_cart_side.png"),
	wield_image = "carts_cart_side.png",
	description = "Cart",
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

minetest.register_node("carts:chest", {
	drawtype = "nodebox",
	description = "Box",
	paramtype = "light",
	tiles = {"default_wood.png"},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	node_box = {
		type = "fixed",
		fixed = {
					--Außenseiten
					{-0.5, -0.5, -0.5, -0.5, 0.5, 0.5},
					{-0.5, -0.5, -0.5, 0.5, 0.5, -0.5},
					{0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
					{0.5, 0.5, 0.5, -0.5, -0.5, 0.5},
					
					--Innenseiten
					{-0.4, -0.5, -0.4, -0.4, 0.5, 0.4},
					{-0.4, -0.5, -0.4, 0.4, 0.5, -0.4},
					{0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
					{0.4, 0.5, 0.4, -0.4, -0.5, 0.4},
					
					--Obere Ränder
					{-0.5, 0.5, -0.5, 0.4, 0.5, -0.4},
					{0.5, 0.5, -0.5, 0.4, 0.5, 0.4},
					{0.5, 0.5, 0.5, -0.4, 0.5, 0.4},
					{-0.5, 0.5, 0.5, -0.4, 0.5, -0.4},
					
					--Boden
					{-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
					{-0.5, -0.4, -0.5, 0.5, -0.4, 0.5},
				}
	},
})

minetest.register_node("carts:switch_left", {
	description = "Switch",
	paramtype2 = "facedir",
	tiles = {"default_wood.png"},
	groups = {bendy=2,snappy=1,dig_immediate=2},
	on_punch = function(pos, node, puncher)
		node.name = "carts:switch_right"
		minetest.env:set_node(pos, node)
				local par2 = minetest.env:get_node(pos).param2
		if par2 == 0 then
			pos.z = pos.z-1
		elseif par2 == 1 then
			pos.x = pos.x-1
		elseif par2 == 2 then
			pos.z = pos.z+1
		elseif par2 == 3 then
			pos.x = pos.x+1
		end
		
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				local meta = minetest.env:get_meta(pos)
				meta:set_string("rail_direction", "right")
			end
		end
	end,
	on_construct = function(pos)
		local par2 = minetest.env:get_node(pos).param2
		if par2 == 0 then
			pos.z = pos.z-1
		elseif par2 == 1 then
			pos.x = pos.x-1
		elseif par2 == 2 then
			pos.z = pos.z+1
		elseif par2 == 3 then
			pos.x = pos.x+1
		end
		
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				local meta = minetest.env:get_meta(pos)
				meta:set_string("rail_direction", "left")
			end
		end
	end,
	on_destruct = function(pos)
		local par2 = minetest.env:get_node(pos).param2
		if par2 == 0 then
			pos.z = pos.z-1
		elseif par2 == 1 then
			pos.x = pos.x-1
		elseif par2 == 2 then
			pos.z = pos.z+1
		elseif par2 == 3 then
			pos.x = pos.x+1
		end
		
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				local meta = minetest.env:get_meta(pos)
				meta:set_string("rail_direction", "")
			end
		end
	end,
	
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
					--Stiel
					{-0.05, -0.5, -0.45, 0.05, -0.4, -0.4},
					{-0.1, -0.4, -0.45, 0, -0.3, -0.4},
					{-0.15, -0.3, -0.45, -0.05, -0.2, -0.4},
					{-0.2, -0.2, -0.45, -0.1, -0.1, -0.4},
					{-0.25, -0.1, -0.45, -0.15, 0, -0.4},
					{-0.3, 0, -0.45, -0.2, 0.1, -0.4},
					--Kopf
					{-0.45, 0.1, -0.5, -0.25, 0.3, -0.3},
				},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.3, -0.3},
		}
	},
	walkable = false,
})

minetest.register_node("carts:switch_right", {
	paramtype2 = "facedir",
	tiles = {"default_wood.png"},
	groups = {bendy=2,snappy=1,dig_immediate=2},
	drop = "carts:switch_left",
	on_punch = function(pos, node, puncher)
		node.name = "carts:switch_left"
		minetest.env:set_node(pos, node)
		local par2 = minetest.env:get_node(pos).param2
		if par2 == 0 then
			pos.z = pos.z-1
		elseif par2 == 1 then
			pos.x = pos.x-1
		elseif par2 == 2 then
			pos.z = pos.z+1
		elseif par2 == 3 then
			pos.x = pos.x+1
		end
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				local meta = minetest.env:get_meta(pos)
				meta:set_string("rail_direction", "left")
			end
		end
	end,
	on_destruct = function(pos)
		local par2 = minetest.env:get_node(pos).param2
		if par2 == 0 then
			pos.z = pos.z-1
		elseif par2 == 1 then
			pos.x = pos.x-1
		elseif par2 == 2 then
			pos.z = pos.z+1
		elseif par2 == 3 then
			pos.x = pos.x+1
		end
		for i,rail in ipairs(RAILS) do
			if minetest.env:get_node(pos).name == rail then
				local meta = minetest.env:get_meta(pos)
				meta:set_string("rail_direction", "")
			end
		end
	end,
	
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
					--Stiel
					{-0.05, -0.5, -0.45, 0.05, -0.4, -0.4},
					{0, -0.4, -0.45, 0.1, -0.3, -0.4},
					{0.05, -0.3, -0.45, 0.15, -0.2, -0.4},
					{0.1, -0.2, -0.45, 0.2, -0.1, -0.4},
					{0.15, -0.1, -0.45, 0.25, 0, -0.4},
					{0.2, 0, -0.45, 0.3, 0.1, -0.4},
					--Kopf
					{0.25, 0.1, -0.5, 0.45, 0.3, -0.3},
				},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.3, -0.3},
		}
	},
	walkable = false,
})

minetest.register_alias("carts:switch", "carts:switch_left")

minetest.register_craft({
	output = '"carts:chest" 1',
	recipe = {
		{'default:wood', '', 'default:wood'},
		{'default:wood', 'default:wood', 'default:wood'}
	}
})

minetest.register_craft({
	output = '"carts:cart" 1',
	recipe = {
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'}
	}
})

minetest.register_craft({
	output = '"carts:switch_left" 1',
	recipe = {
		{'', 'default:rail', ''},
		{'default:rail', '', ''},
		{'', 'default:rail', ''},
	}
})

--Mesecons
if minetest.get_modpath("mesecons") ~= nil then
	mesecon:register_on_signal_on(function(pos, node)
		for i,rail in ipairs(RAILS) do
			if node.name == rail then
				local carts = minetest.env:get_objects_inside_radius(pos, 1)
				for i,cart in ipairs(carts) do
					if not cart:is_player() and cart:get_luaentity().name == "carts:cart" and not cart:get_luaentity().fahren then
						local self = cart:get_luaentity()
						--Fahrtrichtung bestimmen
						for i,dir in ipairs({"x+", "x-", "z+", "z-"}) do
							self.dir = dir
							if self:get_new_direction() == self.dir then
								break
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
						self.handler = minetest.sound_play(SOUND_FILE, {
							object = self.object,
							loop = true,
						})
						
						self.fahren = true
					end
				end
			end
		end
	end)
	
	minetest.register_node("carts:meseconrail_off", {
		description = "Meseconrail",
		drawtype = "raillike",
		tiles = {"carts_meseconrail_off.png", "carts_meseconrail_curved_off.png", "carts_meseconrail_t_junction_off.png", "carts_meseconrail_crossing_off.png",},
		inventory_image = "carts_meseconrail_off.png",
		wield_image = "carts_meseconrail_off.png",
		paramtype = "light",
		is_ground_content = true,
		walkable = false,
		selection_box = {
			type = "fixed",
			fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
		},
		groups = {bendy=2,snappy=1,dig_immediate=2},
	})
	
	minetest.register_node("carts:meseconrail_on", {
		description = "Meseconrail",
		drawtype = "raillike",
		tiles = {"carts_meseconrail_on.png", "carts_meseconrail_curved_on.png", "carts_meseconrail_t_junction_on.png", "carts_meseconrail_crossing_on.png",},
		inventory_image = "carts_meseconrail_on.png",
		wield_image = "carts_meseconrail_on.png",
		paramtype = "light",
		light_source = LIGHT_MAX-11,
		is_ground_content = true,
		walkable = false,
		selection_box = {
			type = "fixed",
			fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
		},
		groups = {bendy=2,snappy=1,dig_immediate=2},
	})
	
	mesecon:add_receptor_node("carts:meseconrail_on")
	mesecon:add_receptor_node_off("carts:meseconrail_off")
	
	minetest.register_abm({
		nodenames = {"carts:meseconrail_on"},
		interval = 1.0,
		chance = 1,
		action = function(pos, node)
			local tmp =  minetest.env:get_objects_inside_radius(pos, 1)
			local cart_is_there = false
			for i,cart in ipairs(tmp) do
				if not cart:is_player() and cart:get_luaentity().name == "carts:cart" then
					cart_is_there = true
				end
			end
			if not cart_is_there then
				minetest.env:set_node(pos, {name="carts:meseconrail_off"})
				mesecon:receptor_off (pos)
			end
		end
	})
	
	minetest.register_craft({
		output = '"carts:meseconrail_off" 1',
		recipe = {
			{'default:rail', 'mesecons:mesecon_off', 'default:rail'},
			{'default:rail', 'mesecons:mesecon_off', 'default:rail'},
			{'default:rail', 'mesecons:mesecon_off', 'default:rail'},
		}
	})
	
end
