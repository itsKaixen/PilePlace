-- Modules
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableUtils = require(ReplicatedStorage.Shared.Systems.TableUtils)

-- Variables
local nums = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }

---------------------------------------- Functions

local double = TableUtils.map(nums, function(n)
	return n * 2
end)

local evens = TableUtils.filter(nums, function(n)
	return n % 2 == 0
end)

local sum = TableUtils.reduce(nums, function(acc, n)
	return acc + n
end, 0)

----------------------------------------

---------------------------------------- Running

print(table.concat(double, ", "))
print(table.concat(evens, ", "))
print(sum)
