-- Vars
local workspace = game:WaitForChild("Workspace")
-- local part = workspace:WaitForChild("SpawnPart")

-- Functions

local function Spawn(size: number)
	local part = Instance.new("Part")
	part.Parent = workspace
	part.Name = "SpawnPart"
	part.Size = Vector3.new(size, size, size)
	part.Position = Vector3.new(0, 0, 0)
	return part
end

local function CreateGUI(Attach: Part, Content: string)
	local Gui = Instance.new("BillboardGui")
	local frame = Instance.new("Frame", Gui)
	local Text = Instance.new("TextLabel", frame)

	Gui.Parent = Attach
	Gui.Size = UDim2.fromOffset(200, 50)
	Gui.AlwaysOnTop = true

	frame.Size = UDim2.fromScale(1, 1)
	Text.Size = UDim2.fromScale(0.5, 0.5)
	Text.AnchorPoint = Vector2.new(0.5, 0.5)
	Text.Position = UDim2.fromScale(0.5, 0.5)
	Text.Text = Content
	return Text
end

local function Countdown(part: Part, Label: TextLabel)
	for count = 10, 0, -1 do
		Label.Text = count
		task.wait(1)
	end
	part:Destroy()
end

-- Running

local part = Spawn(5)
local text = CreateGUI(part, "10")
Countdown(part, text)
