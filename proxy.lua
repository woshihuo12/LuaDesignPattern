--[[
	背景： 陈冠希想追张柏芝，但是无从下手，于是找来了谢婷风
	陈冠希叫谢婷风帮他送洋娃娃，玫瑰花，巧克力。于是谢婷风就是代理人
]]

GiveGift = {girlname = nil}

function GiveGift:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end


Pursuit = GiveGift:new()
function Pursuit:new(o, name)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.girlname = name
	return o
end

function Pursuit:GiveDolls()
	if self.girlname ~= nil then
		print("give" .. self.girlname .. "doll")
	end
end

function Pursuit:GiveFlowers()
	if self.girlname ~= nil then
		print("give" .. self.girlname .. "Flowers")
	end
end

function Pursuit:GiveChocolate()
	if self.girlname ~= nil then
		print("give" .. self.girlname .. "Chocolate")
	end
end

Proxy = GiveGift:new()

function Proxy:new(o,name)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	o.pursuit = Pursuit:new({}, name)
	return o
end

function Proxy:GiveDolls()
	self.pursuit:GiveDolls()
end

function Proxy:GiveFlowers()
	self.pursuit:GiveFlowers()
end

function Proxy:GiveChocolate()
	self.pursuit:GiveChocolate()
end

XieTingFeng = Proxy:new({}, "ZhangBoZhi")
XieTingFeng:GiveDolls()
XieTingFeng:GiveFlowers()
XieTingFeng:GiveChocolate()