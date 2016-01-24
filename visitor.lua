--[[
2. 1.Visitor 抽象访问者角色，为该对象结构中具体元素角色声明一个访问操作接口。该操
作接口的名字和参数标识了发送访问请求给具体访问者的具体元素角色，这样访问者就可以通过该元素角
色的特定接口直接访问它。
3. 2.ConcreteVisitor.具体访问者角色，实现 Visitor 声明的接口。
4. 3.Element 定义一个接受访问操作(accept())，它以一个访问者(Visitor)作为参数。
5. 4.ConcreteElement 具体元素，实现了抽象元素(Element)所定义的接受操作接口。
6. 5.ObjectStructure 结构对象角色，这是使用访问者模式必备的角色。它具备以下特性：
能枚举它的元素；可以提供一个高层接口以允许访问者访问它的元素；如有需要，可以设计成一个复合对
象或者一个聚集（如一个列表或无序集合）。
7. 访问者模式适用于数据结构相对稳定算法又易变化的系统。因为访问者模式使得算法操作增
加变得容易。若系统数据结构对象易于变化，经常有新的数据对象增加进来，则不适合使用访问者模式。
8. ]]

Visitor = {}

function Visitor:new(n,o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	self.name = n
	return o;
end

ConcreteVisitor1 = Visitor:new()

function ConcreteVisitor1:VisitConcreteElementA(c)
	print(c.name.." 被 "..self.name.."访问")
end

function ConcreteVisitor1:VisitConcreteElementB(c)
	print(c.name.." 被 "..self.name.."访问")
end

ConcreteVisitor2 = Visitor:new()

function ConcreteVisitor2:VisitConcreteElementA(c)
	print(c.name.." 被 "..self.name.."访问")
end

function ConcreteVisitor2:VisitConcreteElementB(c)
	print(c.name.." 被 "..self.name.."访问")
end

Element = {}

function Element:new(n,o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	self.name = n
	return o;
end

ConcreteElementA = Element:new()

function ConcreteElementA:Accept(v)
	v:VisitConcreteElementA(self)
end

ConcreteElementB = Element:new()

function ConcreteElementB:Accept(v)
	v:VisitConcreteElementB(self)
end

ObjectStructure = {}

function ObjectStructure:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	o.elements = {}
	return o
end

function ObjectStructure:Attach(e)
	table.insert(self.elements,e)
end

function ObjectStructure:Detach(e)
	for k, v in pairs(self.elements) do
		if v == theconcreteobserver then
			table.remove(self.elements,k)
			break
		end
	end
end

function ObjectStructure:Accept(v)
	for _,e in ipairs(self.elements) do
		e:Accept(v)
	end
end

obj = ObjectStructure:new()
obj:Attach(ConcreteElementA:new("XX 博物馆"))
obj:Attach(ConcreteElementB:new("XX 动物园"))

xiaoming = ConcreteVisitor1:new("小明")
xiaohong = ConcreteVisitor2:new("小红")

obj:Accept(xiaoming)
obj:Accept(xiaohong)