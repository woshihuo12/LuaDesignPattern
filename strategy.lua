Strategy = {}

ConcreteStrategyA = {}
ConcreteStrategyB = {}
ConcreteStrategyC = {}

Context = {strategy = nil}

function Strategy:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	return o
end

function Strategy:AlgorithmInterface()
	print("逻辑接口")
end


ConcreteStrategyA = Strategy:new()
function ConcreteStrategyA:AlgorithmInterface()
	print("具体策略 A")
end

function Context:new(o,s)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	if s ~= nil then
		o.strategy = s
	end
	return o
end


function Context:ContextInterface()
	self.strategy:AlgorithmInterface()
end

context = Context:new({},ConcreteStrategyA:new())
context:ContextInterface()