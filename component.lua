--[[
	组合模式使得用户对单个对象和组合对象的使用具有一致性
	应用
	1 你想表示对象的部分 整体层次结构
	2 你希望用户忽略组合对象与单个对象的不同，
	用户将统一使用组合结构中的所有对象
	定义
	1 component是组合中的对象声明接口，在适当的情况下
	实现所有类共有接口的默认行为。声明一个接口用于访问和
	管理component子部件。
	2 leaf在组合中表示叶子节点对象，叶子节点没有子节点
	3. composite定义有枝节点行为，用来存储子部件。
	在component接口中实现与子部件有关操作，如增加 和 删除对象
]]

Component = {}

function Component:new(name)
	o = {}
	setmetatable(o, self)
	self.__index = self
	o.name = name
	return o
end

Composite = Component:new()

function Composite:new(name)
	o = {}
	setmetatable(o, self)
	self.__index = self
	o.children = {}
	o.name = name
	return o
end

function Composite:Add(c)
	table.insert(self.children, c)
end

function Composite:Remove(c)
	for k, v in pairs(self.children) do
		if v == c then
			table.remove(self.children, k)
		end
	end
end

function Composite:Fuck()
	for _,v in pairs(self.children) do
		v:Fuck()
	end
end

function Composite:Announce()
	print(self.name)
	for _,v in pairs(self.children) do
		v:Announce()
	end
end

Leaf = Component:new()

function Leaf:new(name)
	o = {}
	setmetatable(o, self)
	self.__index = self
	o.name = name
	return o
end

function Leaf:Fuck()
	print("fuck u," .. self.name)
end

function Leaf:Announce()
	print(self.name .. "hehehehehe.")
end


chengguanxi = Composite:new("称关系")
first = Composite:new("第一批曝光")
first:Add(Leaf:new("张柏芝"))
first:Add(Leaf:new("钟欣桐"))
chengguanxi:Add(first)

second = Composite:new("第2批曝光")
second:Add(Leaf:new("张柏芝2"))
chengguanxi:Add(second)

chengguanxi:Fuck()
