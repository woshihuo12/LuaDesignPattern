--[[
2. 优点：
3. 1.降低对象之间的耦合度。
4. 2.新的命令可以很容易地加入到系统中。
5. 3.可以比较容易地设计一个组合命令。
6. 4.调用同一方法实现不同的功能。
7. 缺点：
8. 使用命令模式可能会导致某些系统有过多的具体命令类。因为针对每一个命令都需要设计一
个具体命令类，因此某些系统可能需要大量具体命令类，这将影响命令模式的使用。
9.
10. Command 类：是一个抽象类，类中对需要执行的命令进行声明，一般来说要对外公布一个
execute 方法用来执行命令。
11. ConcreteCommand 类：Command 类的实现类，对抽象类中声明的方法进行实现。
12. Invoker 类：调用者，负责调用命令。
13. Receiver 类：接收者，负责接收命令并且执行命令。
14. ]]--

Command = {}

function Command:new(r,o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	o.receiver = r
	return o;
end

ConcreteCommand1 = Command:new()

function ConcreteCommand1:Execute()
	self.receiver:Action1()
end

ConcreteCommand2 = Command:new()

function ConcreteCommand2:Execute()
	self.receiver:Action2()
end

Receiver = {}
function Receiver:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	return o;
end

function Receiver:Action1()
	print("来一条清蒸鱼")
end

function Receiver:Action2()
	print("来一个蛋糕")
end

Invoker = {}

function Invoker:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	o.allcommand = {}
	return o;
end

function Invoker:SetCommand(c)
	table.insert(self.allcommand,c)
end

function Invoker:ExecuteCommand()
	for _,v in pairs(self.allcommand) do
		v:Execute()
	end
end

--厨师 是 Receiver
chef = Receiver:new()
--下面是两个菜(命令)，执行者是 Receiver(chef)
fish = ConcreteCommand1:new(chef)
cake = ConcreteCommand2:new(chef)

--调用者 是服务员
waiter = Invoker:new()
--服务员下达了两个菜(命令)，执行者当然是 Receiver(chef)
waiter:SetCommand(fish)
waiter:SetCommand(cake)

--看似服务员做了两个菜，实际是 Receiver 做，从而做了解耦；客人与厨师不用相互紧耦合
waiter:ExecuteCommand()