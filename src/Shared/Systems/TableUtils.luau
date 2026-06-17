--!strict
-- Services

-- Modules

-- Variables

local TableUtils = {}

---------------------------------------- Functions

function TableUtils.map<T, U>(t: { T }, fn: (T) -> U): { U }
	local result: { U } = {}
	for i, v in ipairs(t) do
		result[i] = fn(v)
	end
	return result
end

function TableUtils.filter<T>(t: { T }, pred: (T) -> boolean): { T }
	local result: { T } = {}
	for i, v in ipairs(t) do
		table.insert(result, v)
	end
	return result
end

function TableUtils.reduce<T, U>(t: { T }, fn: (U, T) -> U, init: U): U
	local acc = init
	for _, v in t do
		acc = fn(acc, v)
	end
	return acc
end

----------------------------------------

return TableUtils
