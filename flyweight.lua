--[[
2. 设计模式中的享元模式，避免大量拥有相同内容的小类的开销(如耗费内存),使大家共享一
个类(元类).
3. 它使用共享物件，用来尽可能减少内存使用量以及分享资讯给尽可能多的相似物件；它适合
用于当大量物件只是重复因而导致无法令人接受的使用大量内存。
4. 抽象享元(Flyweight)角色：此角色是所有的具体享元类的超类，为这些类规定出需要实现
的公共接口。那些需要外蕴状态(External State)的操作可以通过调用商业方法以参数形式传入。
5.
6. 具体享元(ConcreteFlyweight)角色：实现抽象享元角色所规定的接口。如果有内蕴状态的
话，必须负责为内蕴状态提供存储空间。享元对象的内蕴状态必须与对象所处的周围环境无关，从而使得
享元对象可以在系统内共享的。
7.
8. 享元工厂(FlyweightFactory)角色：本角色负责创建和管理享元角色。本角色必须保证享
元对象可以被系统适当地共享。当一个客户端对象调用一个享元对象的时候，享元工厂角色会检查系统中
是否已经有一个复合要求的享元对象。如果已经有了，享元工厂角色就应当提供这个已有的享元对象；如
果系统中没有一个适当的享元对象的话，享元工厂角色就应当创建一个合适的享元对象。
9.
10. ]]

FlyweightFactory = {}

function FlyweightFactory:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	o.flyweight = {}
	o.flyweight["male"] = ConcreteFlyweight1:new()
	o.flyweight["female"] = ConcreteFlyweight2:new()
	return o;
end

function FlyweightFactory:GetFlyweight(key)
	if key ~= nil then
		return self.flyweight[key]
	end
end

Flyweight = {}

function Flyweight:new(o)
	o = o or {}
	setmetatable(o,self) 
	self.__index = self
	return o
end

function Flyweight:Operation()
	print("base operation")
end

function Flyweight:SetName(n)
	self.name = n
	return self
end

ConcreteFlyweight1 = Flyweight:new()

function ConcreteFlyweight1:Operation(state)
	print(self.name.." 追求 "..state.name)
end

ConcreteFlyweight2 = Flyweight:new()

function ConcreteFlyweight2:Operation(state)
	print(self.name.." 喜欢 "..state.name)
end

UnsharedConcreteFlyweight = Flyweight:new()
function UnsharedConcreteFlyweight:Operation(state)
 --这里是不需要共享的操作
	print(state)
end

print("月老牵红线......")

f = FlyweightFactory:new()
xietingfeng = f:GetFlyweight("male"):SetName("谢霆疯")
zhangbozhi = f:GetFlyweight("female"):SetName("张伯芝")
xietingfeng:Operation(zhangbozhi)
zhangbozhi:Operation(xietingfeng)

zhubajie = f:GetFlyweight("male"):SetName("猪八戒")
change = f:GetFlyweight("female"):SetName("嫦娥")
zhubajie:Operation(change)
change:Operation(zhubajie)

xietingfeng = UnsharedConcreteFlyweight:new()
xietingfeng:Operation("谢霆疯:我后悔了")

zhubajie = UnsharedConcreteFlyweight:new()
zhubajie:Operation("猪八戒:感谢月老")