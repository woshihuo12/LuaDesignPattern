OperationFactory = {}

Operation = {}

function Operation:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.numberA = 0
	o.numberB = 1
	return o
end

OperationAdd = Operation:new()

OperationSub = Operation:new()

OperationMul = Operation:new()

OperationDiv = Operation:new()


function OperationAdd:GetResult()
	if self.numberA and self.numberB then
		return self.numberA + self.numberB;
	else
		return "error"
	end
end

function OperationSub:GetResult()
	if self.numberA and self.numberB then
		return self.numberA - self.numberB;
	else
		return "error"
	end
end

function OperationMul:GetResult()
	if self.numberA and self.numberB then
		return self.numberA * self.numberB;
	else
		return "error"
	end
end

function OperationDiv:GetResult()
	if self.numberA and self.numberB then
		return self.numberA / self.numberB;
	else
		return "error"
	end
end

function OperationFactory:CreateOperation(oper)
	if oper == "+" then
		return OperationAdd:new()
	elseif oper == "-" then
		return OperationSub:new()
	elseif oper == "*" then
		return OperationMul:new()
	elseif oper == "/" then
		return OperationDiv:new()
	else
	end
end

Oper1 = OperationFactory:CreateOperation("+")
Oper1.numberA = 10
Oper1.numberB = 5
print(Oper1:GetResult())

Oper2 = OperationFactory:CreateOperation("-")
Oper2.numberA = 10
Oper2.numberB = 5
print(Oper2:GetResult())

Oper3 = OperationFactory:CreateOperation("*")
Oper3.numberA = 10
Oper3.numberB = 5
print(Oper3:GetResult())

Oper4 = OperationFactory:CreateOperation("/")
Oper4.numberA = 10
Oper4.numberB = 5
print(Oper4:GetResult())