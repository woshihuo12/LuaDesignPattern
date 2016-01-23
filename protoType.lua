-- 原形模式可分为深复制和浅复制，下面以浅复制为例

Prototype = {}

function Prototype:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Prototype:Clone()
	return self
end

proto = Prototype:new()

proto.val = 10

cloneproto = proto:Clone()

print(cloneproto.val)

cloneproto.val = 123
print(proto.val)