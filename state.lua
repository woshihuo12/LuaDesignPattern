--[[
2. 状态模式(State Pattern)是设计模式的一种，属于行为模式。
3. 适用场景：
4. 1.一个对象的行为取决于它的状态，并且它必须在运行时刻根据状态改变它的行为。
5. 2.一个操作中含有庞大的多分支结构，并且这些分支决定于对象的状态。
6.
7. ]]

Work = {}

function Work:new(o,s)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.hour = 0
	o.currentstate = s
	return o
end

function Work:SetTime(h)
	self.hour = h
end

function Work:GetTime()
	return self.hour
end

function Work:SetState(s)
	self.currentstate = s
end

function Work:WriteProgram()
	self.currentstate:WriteProgram(self)
end

State = {}

function State:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	return o;
end

MorningState = State:new()

function MorningState:WriteProgram(w)
	if w.hour < 12 and w.hour >= 9 then
		print("早上写代码，精神百倍")
	else
		w:SetState(NoonState:new())
		w:WriteProgram()
	end
end

NoonState = State:new()

function NoonState:WriteProgram(w)
	if w.hour < 14 and w.hour >= 12 then
		print("中午写代码，犯困了，先小睡一下再说")
	else
		w:SetState(AfternoonState:new())
		w:WriteProgram()
	end
end

AfternoonState = State:new()

function AfternoonState:WriteProgram(w)
	if w.hour < 17 and w.hour >= 14 then
		print("下午写代码, 精神充足")
	else 
		w:SetState(EveningState:new())
		w:WriteProgram()
	end
end

EveningState = State:new()
function EveningState:WriteProgram(w)
	if w.hour < 20 and w.hour >=17 then
		print("傍晚写代码，有点累，但还是继续")
	else
		w:SetState(NightState:new())
		w:WriteProgram()
	end
end

NightState = State:new()


function NightState:WriteProgram(w)
	if w.hour < 22 and w.hour >= 20 then
		print("晚上写代码，苦逼啊")
	else
		w:SetState(MidnightState:new())
		w:WriteProgram()
	end
end


MidnightState = State:new()

function MidnightState:WriteProgram(w)
	if w.hour < 9 or w.hour >= 22 then
		print("深夜写代码，尼玛，先睡醒了再说")
	else
		w:SetState(MorningState:new())
		w:WriteProgram()
	end
end

w = Work:new(nil,MorningState:new())
w:SetTime(21)
w:WriteProgram()

w:SetTime(18)
w:WriteProgram()

w:SetTime(10)
w:WriteProgram()

w:SetTime(13)
w:WriteProgram()



