Person = {}

function Person:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	return o
end

function Person:Show()
	print("i am person")
end

Decorator = Person:new{component = nil}

function Decorator:Decorate(com)
	self.component = com
end

function Decorator:Show()
	print("i am decorator")
end

Shirt = Decorator:new()
function Shirt:Show()
	print("i am shirt")
	if self.component ~= nil then
		self.component:Show()
	end
end

Trouser = Decorator:new()

function Trouser:Show()
	print("i am Trouser")
	if self.component ~= nil then
		self.component:Show()
	end
end

Shoe = Decorator:new()
function Shoe:Show()
	print("i am Shoe")
	if self.component ~= nil then
		self.component:Show()
	end
end

person = Person:new()

shirt = Shirt:new()
shirt:Decorate(person)

trouser = Trouser:new()
trouser:Decorate(shirt)

shoe = Shoe:new()
shoe:Decorate(trouser)

shoe:Show()





