-- local RunService = game:GetService("RunService")
-- local VALID_MODULE_TAG = "RelocateToServerScriptService"
-- local PRIORITY_ATTR = "Priority"

-- local LOADING_FUNCTIONS = {
-- 	INIT = { "__init", "_onInit" },
-- 	START = { "__start", "_onStart" },
-- }

-- local originalPrint = print
-- local print = function(...)
-- 	originalPrint("[MainRequirer]", ...)
-- end

-- local function canLoadFolder(folder: Folder): boolean
-- 	return not folder:HasTag("IgnoreLoading")
-- end

-- local function canLoadModule(module: ModuleScript): boolean
-- 	local moduleRunContextAttr = module:GetAttribute("RunContext")

-- 	if moduleRunContextAttr then
-- 		local lower = moduleRunContextAttr:lower()

-- 		if lower == "client" and RunService:IsServer() then
-- 			return false
-- 		end

-- 		if lower == "server" and RunService:IsClient() then
-- 			return false
-- 		end
-- 	end

-- 	return not module:HasTag("IgnoreLoading")
-- end

-- local function getPriority(item: Instance): number
-- 	local priority = item:GetAttribute(PRIORITY_ATTR)
-- 	if typeof(priority) == "number" then
-- 		return priority
-- 	end

-- 	return 0
-- end

-- type ModuleLoadEntry = {
-- 	module: ModuleScript,
-- 	priority: number,
-- 	order: number,
-- }

-- type LoadedModuleEntry = {
-- 	module: ModuleScript,
-- 	priority: number,
-- 	order: number,
-- 	value: any,
-- }

-- local MainRequirer = {}

-- local function collectModules(container: Instance, modules: { ModuleLoadEntry })
-- 	for _, item in container:GetChildren() do
-- 		if item:IsA("Folder") and canLoadFolder(item) then
-- 			collectModules(item, modules)
-- 		elseif item:IsA("ModuleScript") and canLoadModule(item) then
-- 			table.insert(modules, {
-- 				module = item,
-- 				priority = getPriority(item),
-- 				order = #modules + 1,
-- 			})
-- 		end
-- 	end
-- end

-- local function requireModule(entry: ModuleLoadEntry): LoadedModuleEntry?
-- 	local success, loadedModule = pcall(require, entry.module)
-- 	if not success then
-- 		warn("Issue when loading " .. entry.module.Name .. " (" .. loadedModule .. ")")
-- 		return nil
-- 	end

-- 	print("Successfully loaded " .. entry.module.Name)

-- 	return {
-- 		module = entry.module,
-- 		priority = entry.priority,
-- 		order = entry.order,
-- 		value = loadedModule,
-- 	}
-- end

-- local function callLifecycleFunction(entry: LoadedModuleEntry, functionNames: { string }?)
-- 	local loadedModule = entry.value

-- 	if functionNames == nil then
-- 		if typeof(loadedModule) == "function" then
-- 			loadedModule()
-- 		end
-- 		return
-- 	end

-- 	if typeof(loadedModule) ~= "table" then
-- 		return
-- 	end

-- 	if functionNames then
-- 		for _, functionName in functionNames do
-- 			local possibleFunc: (() -> ())? = rawget(loadedModule, functionName)
-- 			if typeof(possibleFunc) == "function" then
-- 				local ok, err = pcall(possibleFunc)
-- 				if not ok then
-- 					print("Module " .. entry.module.Name .. " Had an issue: " .. err)
-- 				end
-- 				return
-- 			end
-- 		end
-- 	end
-- end

-- function MainRequirer.loadModules(container: Instance)
-- 	local modules: { ModuleLoadEntry } = {}
-- 	local loadedModules: { LoadedModuleEntry } = {}

-- 	collectModules(container, modules)

-- 	table.sort(modules, function(a: ModuleLoadEntry, b: ModuleLoadEntry): boolean
-- 		if a.priority == b.priority then
-- 			return a.order < b.order
-- 		end

-- 		return a.priority > b.priority
-- 	end)

-- 	for _, entry in modules do
-- 		local loadedModule = requireModule(entry)
-- 		if loadedModule then
-- 			table.insert(loadedModules, loadedModule)
-- 		end
-- 	end

-- 	for _, entry in loadedModules do
-- 		callLifecycleFunction(entry, LOADING_FUNCTIONS.INIT)
-- 	end

-- 	for _, entry in loadedModules do
-- 		callLifecycleFunction(entry, LOADING_FUNCTIONS.START)
-- 	end

-- 	for _, entry in loadedModules do
-- 		callLifecycleFunction(entry, nil)
-- 	end
-- end

-- --[[
-- 	moves all modules with the tag "RelocateToServerScriptService" to ServerScriptService
-- 	if he's not a descendant already.
-- ]]
-- function MainRequirer.moveValidModulesToServerScriptService()
-- 	local ServerScriptService = game:GetService("ServerScriptService")

-- 	local relocateFolder = Instance.new("Folder")
-- 	relocateFolder.Name = "REQUIRED_RELOCATED_HERE"
-- 	relocateFolder.Parent = ServerScriptService
-- 	assert(RunService:IsServer(), "This function should work only on server.")
-- 	for _, module in game:QueryDescendants("." .. VALID_MODULE_TAG) do
-- 		if module:IsA("ModuleScript") and not module:IsDescendantOf(ServerScriptService) then
-- 			print("Moved module " .. module.Name .. " to ServerScriptService.")
-- 			module.Parent = relocateFolder
-- 		end
-- 	end
-- end

-- return MainRequirer
