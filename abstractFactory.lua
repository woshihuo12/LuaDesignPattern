--[[
	工厂方法模式：
		一个抽象产品类，可以派生出多个具体产品类
		一个抽象工厂类，可以派生出多个具体工厂类
	    每个具体工厂类只能创建一个具体产品类的实例
        
    抽象工厂模式：
        多个抽象产品类，每个抽象产品类可以派生出多个具体产品类
		一个抽象工厂类，可以派生出多个具体工厂类
		每个具体工厂类可以创建多个具体产品类的实例

	简单工厂：一个工厂生产所有部件
	工厂方法：一个工厂生产一种部件
	抽象工厂：一个工厂生产几种部件
	
]]

IUser = {}

function IUser:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

SqlServerUser = IUser:new()

function SqlServerUser:Insert()
	print("在 SQL Server 中给USer表增加一条记录")
end

function SqlServerUser:GetUserRecord()
	print("在 SQL Server 中User表获取一条记录")
end

AccessUser = IUser:new()

function AccessUser:Insert()
	print("在Access中给User表增加一条记录")
end

function AccessUser:GetUserRecord()
	print("在Access中User表获取一条记录")
end

IDepartment = {}

function IDepartment:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

SqlServerDepartment = IDepartment:new()

function SqlServerDepartment:Insert()
	print("在 SQL Server 中给Department表增加一条记录")
end

function SqlServerDepartment:GetDepartmentRecord()
	print("在 SQL Server中Department表获取一条记录")
end

AccessDepartment = IDepartment:new()

function AccessDepartment:Insert()
	print("在 Access 中给Department表增加一条记录")
end

function AccessDepartment:GetDepartmentRecord()
	print("在 Access 中Department表获取一条记录")
end

IFactory = {}

function IFactory:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

SqlFactory = IFactory:new()

function SqlFactory:GetUser()
	return SqlServerUser:new()
end

function SqlFactory:GetDepartment()
	return SqlServerDepartment:new()
end

AccessFactory = IFactory:new()

function AccessFactory:GetUser()
	return AccessUser:new()
end

function AccessFactory:GetDepartment()
	return AccessDepartment:new()
end

choice = io.read()
factory = nil
if choice == "s" then
	factory = SqlFactory:new()
elseif choice == "a" then
	factory = AccessFactory:new()
end

factory = SqlFactory:new()

if factory ~= nil then
	user = factory:GetUser()
	department = factory:GetDepartment()

	user:Insert()
	user:GetUserRecord()

	department:Insert()
	department:GetDepartmentRecord()
end		