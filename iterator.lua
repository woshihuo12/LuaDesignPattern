--[[
2. 访问一个聚合对象的内容而无需暴露它的内部表示
3. 支持对聚合对象的多种遍历
4. 为遍历不同的聚合结构提供一个统一的接口
5.
6. 应用：
7. 最经典莫过于 C++ STL 了
8. ]]--

Iterator = {}

function Iterator:new()
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

ConcreteIterator = Iterator:new()

function ConcreteIterator:new(d)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.data = d
	o.index = 1
	o.size = table.getn(d)
	return o
end

function ConcreteIterator:Next()
	self.index = self.index + 1
end

function ConcreteIterator:IsDone()
	if self.index > self.size then
		return true
	end
	return false
end

function ConcreteIterator:GetItem()
	return self.data[self.index]
end

Aggregate = {}
function Aggregate:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	return o;
end

ConcreteAggregate = Aggregate:new()
function ConcreteAggregate:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	o.data = {}
	return o;
end

function ConcreteAggregate:CreateIterator()
	return ConcreteIterator:new(self.data)
end

function ConcreteAggregate:PushBack(d)
	table.insert(self.data,d)
end

function ConcreteAggregate:Remove(d)
	for k,v in pairs(self.data) do
		if v == d then
			table.remove(self.data,k)
			break
		end
	end
end

aggregate = ConcreteAggregate:new()

aggregate:PushBack(true)
aggregate:PushBack("QQ 群:")
aggregate:PushBack(315249378)

it = aggregate:CreateIterator()

while it:IsDone() == false do
	print(it:GetItem())
	it:Next()
end