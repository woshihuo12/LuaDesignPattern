--[[
	将一个复杂对象的构造与它的表示分离，使同样的构建过程可以创建不同的表示，这样的模式被称为建造者模式
	1 当创建复杂对象的算法应该独立于该对象的组成部分以及他们的装配方式时
	2 当构造过程必须允许被构造的对象有不同表示时
]]

Director = {}

function Director:new()
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Director:Construct(builder)
	if builder ~= nil then
		builder:Coating()
		builder:Engine()
		builder:Radar()
	end
end

Builder = {}

function Builder:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

Product = {}

function Product:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Product:Show()
	print(self.unit)
end

F22Builder = Builder:new()

function F22Builder:new(o)
	o = o or {}
	setmetatable(o, self)	
	self.__index = self
	o.product = Product:new()
	return o
end

function F22Builder:Coating()
	if self.product.unit == nil then
		self.product.unit = "F22:"
	end
	self.product.unit = self.product.unit .. " 隐形涂料"
end

function F22Builder:Engine()
	self.product.unit = self.product.unit .. " 2台 PW发动机"
end

function F22Builder:Radar()
	self.product.unit = self.product.unit .. " 77雷达"
end

function F22Builder:GetProduct()
	return self.product
end

J10Builder = Builder:new()

function J10Builder:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.product = Product:new()
	return o
end

function J10Builder:Coating()
	if self.product.unit == nil then
		self.product.unit = "J10:"
	end
	self.product.unit = self.product.unit .. " sss形涂料"
end

function J10Builder:Engine()
	self.product.unit = self.product.unit .. " 1台 PW发动机"
end

function J10Builder:Radar()
	self.product.unit = self.product.unit .. " 66雷达"
end

function J10Builder:GetProduct()
	return self.product
end

theF22Builder = F22Builder:new()
Director:Construct(theF22Builder)
F22 = theF22Builder:GetProduct()
F22:Show()

j10Builder = J10Builder:new()
Director:Construct(j10Builder)
J10 = j10Builder:GetProduct()
J10:Show()