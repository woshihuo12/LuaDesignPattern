--[[
2. 抽象主题（Subject）角色：主题角色把所有对观察考对象的引用保存在一个聚集里，
3. 每个主题都可以有任何数量的观察者。抽象主题提供一个接口，可以增加和删除观察者对
4. 象，主题角色又叫做抽象被观察者（Observable）角色，一般用一个抽象类或者一个接口
5. 实现。
6. 抽象观察者（Observer）角色：为所有的具体观察者定义一个接口，在得到主题的通
7. 知时更新自己。这个接口叫做更新接口。抽象观察者角色一般用一个抽象类或者一个接口
8. 实现。在这个示意性的实现中，更新接口只包含一个方法（即 Update()方法），这个方法
9. 叫做更新方法。

具体主题（ConcreteSubject）角色：将有关状态存入具体现察者对象；在具体主题
11. 的内部状态改变时，给所有登记过的观察者发出通知。具体主题角色又叫做具体被观察者
12. 角色（Concrete Observable）。具体主题角色通常用一个具体子类实现。
13. 具体观察者（ConcreteObserver）角色：存储与主题的状态自恰的状态。具体现察者
14. 角色实现抽象观察者角色所要求的更新接口，以便使本身的状态与主题的状态相协调。如
15. 果需要，具体现察者角色可以保存一个指向具体主题对象的引用。具体观察者角色通常用
16. 一个具体子类实现。
17. ]]--

Subject = {}

function Subject:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	return o
end

ConcreteSubject = Subject:new()

function ConcreteSubject:Attach(theconcreteobserver)
	if self.observers == nil then
		self.observers = {}
	end
	table.insert(self.observers,theconcreteobserver)
end

function ConcreteSubject:Detach(theconcreteobserver)
	for k, v in pairs(self.observers) do
		if v == theconcreteobserver then
			table.remove(self.observers,k)
			break
		end
	end
end

function ConcreteSubject:Notify()
	for _, v in pairs(self.observers) do
		v:Update()
	end
end

Observer = {}

function Observer:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	return o
end

ConcreteObserver = Observer:new()

function ConcreteObserver:new(s,n)
	o = {}
	setmetatable(o,self)
	self.__index = self
	o.subject = s
	o.observername = n
	return o
end

function ConcreteObserver:Update()
	print("陈冠稀大喊："..self.observername.."!!"..self.subject.subjectstate)
end

s = ConcreteSubject:new()

s:Attach(ConcreteObserver:new(s,"张伯芝"))
zhongxintong = ConcreteObserver:new(s,"钟欣同")
chenwenyuan = ConcreteObserver:new(s,"陈文援")

s:Attach(zhongxintong)
s:Attach(chenwenyuan)
s.subjectstate = "谢霆疯来了,快躲起来!!"
s:Notify()
s:Detach(zhongxintong)
s:Detach(chenwenyuan)
s.subjectstate = "谢霆疯走了,快回家!!"
s:Notify()




