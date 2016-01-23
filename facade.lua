--[[
	优点：外观模式的目的不是给子系统添加新的功能接口，
	而是为了让外部减少与子系统内多个模块的交互，
	松散耦合，从而让外部能够更简单的使用子系统。
	当然，这是一把双刃剑

	缺点：不能很好的限制客户端直接使用子系统类，
	如果对客户端访问子系统类做太多的限制则减少了
	可变性和灵活性
	下面外部只与Facade交互，而facade与system交互，
	从而达到上述优点
]]

System = {}
function System:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

SubSystemOne = System:new()

function SubSystemOne:Method1()
	print("SubSystemOne:Method1")
end

function SubSystemOne:Method2()
	print("SubSystemOne:Method2")
end

function SubSystemOne:Method3()
	print("SubSystemOne:Method3")
end

SubSystemTwo = System:new()

function SubSystemTwo:Method1()
	print("SubSystemTwo:Method1")
end

function SubSystemTwo:Method2()
	print("SubSystemTwo:Method2")
end

function SubSystemTwo:Method3()
	print("SubSystemTwo:Method3")
end

Facade = {}
function Facade:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.one = SubSystemOne:new()
	o.two = SubSystemTwo:new()
	return o
end

function Facade:Method1()
	self.one:Method1()
	self.two:Method1()
end

function Facade:Method2()
	self.one:Method2()
	self.two:Method2()
end

function Facade:Method3()
	self.one:Method3()
	self.two:Method3()
end

facade = Facade:new()
facade:Method1()