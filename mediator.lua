--[[
Colleage 抽象同事类。
ConcreteColleage 是具体同事类，每个具体同事只知道自己的行为，而不了解其他同事类
的情况，但它们却都认识中介者对象。
4. Mediator 是抽象中介者，定义了同事对象到中介者对象的接口。
5. ConcreteMediator 是具体中介者对象，实现抽象类的方法，它需要知道所有具体同事类，
并从具体同事接受消息，向具体同事对象发出命令。
6.
7. 优点是：
8. 各个 Colleague 减少了耦合。
9.
10. 缺点是：
11. 由于 Mediator 控制了集中化，于是就把 Colleague 之间的交互复杂性变为了中介者的
复杂性，也就是中介者会变的比任何一个 Colleague 都复杂。
]]


Mediator = {}

function Mediator:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.colleagues = {}
	return o
end

function Mediator:Send(c,message)
	for _,v in pairs(self.colleagues) do
		if v ~= c then
			v:GetMessage(message)
		end
	end
end

ConcreteMediator = Mediator:new()

Colleague = {}

function Colleague:new(n,m,o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	o.mediator = m
	o.name = n
	return o
end

function Colleague:Send(message)
	print(self.name.."说:"..message)
	self.mediator:Send(self,message)
end

function Colleague:GetMessage(message)
	print(self.name.."收到："..message)
end

China = Colleague:new()
America = Colleague:new()
Russia = Colleague:new()
Japan = Colleague:new()
SouthKorea = Colleague:new()
NorthKorea = Colleague:new()

liufang = ConcreteMediator:new()

xijinping = China:new("习近萍",liufang)
aobama = America:new("奥爸妈",liufang)
pujing = Russia:new("普惊",liufang)
anbeijinsan = Japan:new("俺被进三",liufang)
piaojinhui = SouthKorea:new("扑僅慧",liufang)
jinzhengen = NorthKorea:new("金正嗯",liufang)


table.insert(liufang.colleagues,xijinping)
table.insert(liufang.colleagues,aobama)
table.insert(liufang.colleagues,pujing)
table.insert(liufang.colleagues,anbeijinsan)
table.insert(liufang.colleagues,piaojinhui)
table.insert(liufang.colleagues,jinzhengen)

xijinping:Send("为了地区安全，我方支持半岛无核化")
print("---------------")
jinzhengen:Send("如果我们放弃核武，我们就会被欺负")
print("---------------")
aobama:Send("如果朝鲜继续发展核武，我国不排除武力去核")