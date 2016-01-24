--[[
2. 职责链模式:使多个对象都有机会处理请求，从而避免请求的发送者和接收者之间的耦合关
系。将这个对象连成一条链，并沿着这条链传递该请求，直到有一个对象处理它为止。
3. 应用：
4. 1、有多个对象处理请求，到底怎么处理在运行时确定。
5. 2、希望在不明确指定接收者的情况下，向多个对象中的一个提交请求。
6. 3、可处理一个请求的对象集合应该被动态指定。
7. ]]--

Handler = {}

function Handler:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	return o;
end

function Handler:SetSuccessor(s)
	self.successor = s
end

ConcreteHandler1 = Handler:new()


function ConcreteHandler1:HandleRequest(r)
	if r <= 10 then
		print("Handler1 处理了请求")
	elseif self.successor then
		self.successor:HandleRequest(r)
	end	
end

ConcreteHandler2 = Handler:new()

function ConcreteHandler2:HandleRequest(r)
	if r > 10 and r <= 20 then
		print("Handler2 处理了请求")
	elseif self.successor then
		self.successor:HandleRequest(r)
	end
end

ConcreteHandler3 = Handler:new()

function ConcreteHandler3:HandleRequest(r)
	if r > 20 then
		print("Handler3 处理了请求")
	elseif self.successor then
		self.successor:HandleRequest(r)
	end
end

h1 = ConcreteHandler1:new()
h2 = ConcreteHandler2:new()
h3 = ConcreteHandler3:new()

h1:SetSuccessor(h2)
h2:SetSuccessor(h3)

print("*********************实例一***********************")
h1:HandleRequest(25)
h2:HandleRequest(5)
h3:HandleRequest(15)

print("*********************实例二***********************")
h1:HandleRequest(25)
h1:HandleRequest(5)
h1:HandleRequest(15)
 --[[
71. PS:
72. 当时"弄懂"了职责链模式后，不禁心里大骂：尼玛，这不就是状态模式吗？！
73. 后来细心地发现了其中的不同：
74. 状态模式：后一个状态的处理对象早已在类的内部设定好了。
75. 职责链模式：后一个请求的处理对象由客户端来设定。
76.
77. ]]--
