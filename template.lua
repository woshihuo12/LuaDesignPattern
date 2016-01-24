--模板方法模式是通过把不变行为搬移到基类，去除之类中的重复代码来体现它的优势。
-- 下面以考试试卷为例，试题都是一样的，但是答案可能不一样

TestPaper = {}

function TestPaper:new(o)
	o = o or {}
	setmetatable(o,self)
	self.__index = self
	return o
end

function TestPaper:TestQuestion1()
	print("孙悟空的师弟是谁？")
	print("A 猪七戒 B 猪八戒 C 猪九戒")
	print("答案是:"..self:Answer1())
end

function TestPaper:Answer1()
	return ""
end

function TestPaper:TestQuestion2()
	print("猪八戒的师弟是谁？")
	print("A 沙和尚 B 沙道士 C 沙井盖")
	print("答案是:"..self:Answer2())
end

function TestPaper:Answer2()
	return ""
end

function TestPaper:TestQuestion3()
	print("沙和尚的大师兄是谁？")
	print("A 孙中山 B 孙权 C 孙悟空")
	print("答案是:"..self:Answer3())
end

function TestPaper:Answer3()
	return ""
end

--小组 A 的试卷
GroupATestPaper = TestPaper:new()

function GroupATestPaper:Answer1()
	return "B"
end

function GroupATestPaper:Answer2()
	return "C"
end

function GroupATestPaper:Answer3()
	return "A"
end

--小组 B 的试卷
GroupBTestPaper = TestPaper:new()

function GroupBTestPaper:Answer1()
	return "A"
end

function GroupBTestPaper:Answer2()
	return "B"
end

function GroupBTestPaper:Answer3()
	return "C"
end

--小明是小组 A 的一员
print("********小明的试卷*********")
XiaoMingTestPaper = GroupATestPaper:new()
XiaoMingTestPaper:TestQuestion1()
XiaoMingTestPaper:TestQuestion2()
XiaoMingTestPaper:TestQuestion3()

--小红是小组 B 的一员
print("********小红的试卷*********")
XiaoHongTestPaper = GroupBTestPaper:new()
XiaoHongTestPaper:TestQuestion1()
XiaoHongTestPaper:TestQuestion2()
XiaoHongTestPaper:TestQuestion3()