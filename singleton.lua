--[[
	优点
	1 实例控制
	单例模式会阻止其他对象实例化其自己的单例对象副本，从而确保所有对象都访问唯一实例
	2 灵活性
	因为类控制了实例化过程，所以类可以灵活更改实例化过程

	缺点
	1 开销
	虽然数量很少，但如果每次对象请求引用时都要检查是否存在类实例，将仍然需要一些开销。可以通过使用静态初始化解决此问题
	2 可能的开发混淆
	使用单例对象 尤其在类库中定义的对象 时，开发人员必须记住自己不能使用new关键字实例化对象。因为可能无法访问库源代码，
	因此应用程序开发人员可能会意外发现自己无法直接实例化此类。
	3 对象生存周期
	不能解决删除单个对象的问题，在提供内存管理语言中，只有单例类能够导致实例被取消分配，因为它包含对该实例私有引用。在某些
	语言中，其他类可以删除对象实例，但这样会导致单例类中出现悬浮引用。
]]

Singleton = {}

function Singleton:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Singleton:Instance()
	if self.instance == nil then
		self.instance = self:new()
	end
	return self.instance
end

s1 = Singleton:Instance()
s2 = Singleton:Instance()

if s1 == s2 then
	print("the same object.")
end