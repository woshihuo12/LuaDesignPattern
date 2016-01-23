--[[
	将一个类的接口转换成客户希望的另外一个接口。Adapter模式使得原本由于接口不兼容而不能
	一起工作的那些类可以一起工作

	应用：
	例如联合国开会，每个国家的领导说着自己国家的语言，但接收着却有不同国家的人，
	因此国家领导人需要翻译，这个翻译就是适配器

	例如我们玩游戏，特别玩以前不同平台的游戏，我们需要一个模拟器，这个模拟器就是适配器
]]

Target = {}
function Target:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Target:Listen(content)
	print(content)
end

Adaptee = {}
function Adaptee:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Adaptee:Translate(content)
	return "are you happy"
end

Adapter = Target:new()
function Adapter:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.adaptee = Adaptee:new()
	return o 
end

function Adapter:Listen(content)
	print(self.adaptee:Translate(content))
end

c = "aaaaaaa"
aobama = Adapter:new()
aobama:Listen(c)
