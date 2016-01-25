--[[
2. 解释器模式（Interpreter），给定一个语言，定义它的文法的一种表示，并定义一个解释
器，用这个解释器使用该表示来解释语言中句子。
3. 解释器模式需要解决的是，如果一种特定类型的问题发生的频率足够高，那么可能就值得将
该问题的各个实例表述为一个简单语言中的句子。这样就可以构建一个解释器，该解释器通过解释这些句
子来解决该问题。
4. AbstractExpression 抽象解释器：具体的解释任务由各个实现类完成，具体的解释器分别
由 TerminalExpression 和 NonterminalExpression 完成。
5.
6. TerminalExpression 终结符表达式：实现与文法中的元素相关联的解释操作，通常一个解
释器模式中只有一个终结符表达式，但有多个实例，对应不同的终结符。具体到我们例子就是
VarExpression 类，表达式中的每个终结符都在堆栈中产生了一个 VarExpression 对象。
7.
8. NonterminalExpression 非终结符表达式：文法中的每条规则对应于一个非终结表达式，
具体到我们的例子就是加减法规则分别对应到 AddExpression 和 SubExpression 两个类。非终结符表达
式根据逻辑的复杂程度而增加，原则上每个文法规则都对应一个非终结符表达式。
9.
10. Context 环境角色：包含解释之外的一些全局信息。
11.
12. ]]--

Context = {}

function Context:Sort(e)
	local index = 1
	local last = 1
	local sub = ""
	local num = 1
	local top = 1
	local stack = {}
	while 1 do
		last = string.find(e," ",index)
		if last == nil or last <= 0 then
			break
		end
		sub = string.sub(e,index,last)
		num = tonumber(sub)
		if num == nil then
			stack[top] = sub
		else
			stack[top] = num
		end
		top = top + 1
		index = last + 1
	end
	--table.foreach(stack,print)
	return stack
end

function Context:new(e,o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	o.stack = {}
	o.top = 1 --顶指针
	o.expression = self:Sort(e)
	return o
end

function Context:Calculate()
	self.top = 1
	local i = 1
	while 1 do
		if i >= #self.expression then
			break
		end
		if string.find(self.expression[i],"+") then
			self.stack[self.top - 1] = AddExpression:new(self.stack[self.top],VarExpression:new(self.expression[i + 1]))
			i = i + 2
		elseif string.find(self.expression[i],"-") then
			self.stack[self.top - 1] = SubExpression:new(self.stack[self.top],VarExpression:new(self.expression[i + 1]))
			i = i + 2
		else
			self.stack[self.top] = VarExpression:new(self.expression[i])
			i = i + 1
			self.top = self.top + 1
		end
	end

	for i = 1,self.top - 1,1 do
		print(self.stack[i]:Interpret())
	end
end

AbstractExpression = {}

function AbstractExpression:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	return o
end

TerminalExpression = AbstractExpression:new()

function TerminalExpression:new(v,o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	o.val = v
	return o
end

function TerminalExpression:Interpret()
	return self.val
end

VarExpression = TerminalExpression:new()

NonterminalExpression = AbstractExpression:new()

function NonterminalExpression:new(l,r,o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	o.left = l
	o.right = r
	return o
end

AddExpression = NonterminalExpression:new()

function AddExpression:Interpret(c)
	return self.left:Interpret() + self.right:Interpret()
end

SubExpression = NonterminalExpression:new()

function SubExpression:Interpret(c)
	return self.left:Interpret() - self.right:Interpret()
end


c = Context:new("1+9-3+5")
c:Calculate()