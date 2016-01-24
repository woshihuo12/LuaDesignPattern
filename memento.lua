--[[
2. 优点：
3. 1、有时一些发起人对象的内部信息必须保存在发起人对象以外的地方，但是必须要由发起
人对象自己读取，这时，使用备忘录模式可以把复杂的发起人内部信息对其他的对象屏蔽起来，从而可以
恰当地保持封装的边界。
4. 2、本模式简化了发起人类。发起人不再需要管理和保存其内部状态的一个个版本，客户端
可以自行管理他们所需要的这些状态的版本。
5. 3、当发起人角色的状态改变的时候，有可能这个状态无效，这时候就可以使用暂时存储起
来的备忘录将状态复原。
6.
7. 缺点：
8. 1、如果发起人角色的状态需要完整地存储到备忘录对象中，那么在资源消耗上面备忘录对
象会很昂贵。
9. 2、当负责人角色将一个备忘录 存储起来的时候，负责人可能并不知道这个状态会占用多大
的存储空间，从而无法提醒用户一个操作是否很昂贵。
10. 3、当发起人角色的状态改变的时候，有可能这个协议无效。如果状态改变的成功率不高的
话，不如采取“假如”协议模式。
11.
12. ]]--

Originator = {}

function Originator:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	o.state = {}
	return o;
end

function Originator:SetState(k,s)
	if self.state == nil then
		self.state = {}
	end
	self.state[k] = s
end

function Originator:ShowState()
	for _, v in pairs(self.state) do
		print(v)
	end
end

function table_copy_table(ori_tab)
	if (type(ori_tab) ~= "table") then
		return nil
	end
	local new_tab = {}
	for i,v in pairs(ori_tab) do
		local vtyp = type(v)
		if (vtyp == "table") then
			new_tab[i] = table_copy_table(v)
		else
			new_tab[i] = v
		end
	end
	return new_tab
end

function Originator:CreateMemento()
	o = Memento:new()
	o.state = table_copy_table(self.state)
	return o
end

function Originator:SetMemento(o)
	self.state = o.state
end

Memento = {}
function Memento:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	return o;
end

Caretaker = {}
function Caretaker:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	o.memento = nil
	return o;
end

print("陈冠稀 和 张伯芝激战前")
originator = Originator:new()
originator:SetState("clothes","衣衫整齐")
originator:SetState("face","春光满面")
originator:SetState("hair","头发飘飞")
originator:ShowState()
caretaker = Caretaker:new()
caretaker.memento = originator:CreateMemento()

print("高潮中......")
originator:SetState("clothes","衣衫褴褛")
originator:SetState("face","累容满面")
originator:SetState("hair","头发凌乱")
originator:ShowState()

print("激战后......")
originator:SetMemento(caretaker.memento)
originator:ShowState()

print("张伯芝回家")