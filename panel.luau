--[[
    Environment Control Panel
    Luau / Roblox
]]

local Lighting = game:GetService("Lighting")

--// Save the original environment settings
local originalFog = {
	FogStart = Lighting.FogStart,
	FogEnd = Lighting.FogEnd,
	FogColor = Lighting.FogColor,
}

local originalTime = Lighting.ClockTime

--// Create the GUI
local gui = Instance.new("ScreenGui")
gui.Name = "EnvironmentPanel"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.fromOffset(250, 230)
panel.Position = UDim2.new(0, 20, 0.5, -115)
panel.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
panel.BorderSizePixel = 0
panel.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = panel

--// Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.fromOffset(10, 5)
title.BackgroundTransparency = 1
title.Text = "Environment Controls"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = panel

--// Button creator
local function createButton(
	name: string,
	text: string,
	position: UDim2
): TextButton

	local button = Instance.new("TextButton")
	button.Name = name
	button.Size = UDim2.new(1, -30, 0, 40)
	button.Position = position
	button.BackgroundColor3 = Color3.fromRGB(50, 50, 58)
	button.BorderSizePixel = 0
	button.Text = text
	button.TextColor3 = Color3.new(1, 1, 1)
	button.TextSize = 16
	button.Font = Enum.Font.Gotham
	button.AutoButtonColor = true
	button.Parent = panel

	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 7)
	buttonCorner.Parent = button

	return button
end

--// Create controls
local fogButton = createButton(
	"FogButton",
	"Fog: ON",
	UDim2.fromOffset(15, 55)
)

local dayButton = createButton(
	"DayButton",
	"☀ Daytime",
	UDim2.fromOffset(15, 105)
)

local nightButton = createButton(
	"NightButton",
	"🌙 Nighttime",
	UDim2.fromOffset(15, 155)
)

--// Fog state
local fogEnabled = true

fogButton.Activated:Connect(function()
	fogEnabled = not fogEnabled

	if fogEnabled then
		-- Restore the existing fog.
		Lighting.FogStart = originalFog.FogStart
		Lighting.FogEnd = originalFog.FogEnd
		Lighting.FogColor = originalFog.FogColor

		fogButton.Text = "Fog: ON"
	else
		-- Disable the existing fog.
		Lighting.FogStart = 100000
		Lighting.FogEnd = 100000

		fogButton.Text = "Fog: OFF"
	end
end)

--// Daytime
dayButton.Activated:Connect(function()
	Lighting.ClockTime = 12
end)

--// Nighttime
nightButton.Activated:Connect(function()
	Lighting.ClockTime = 0
end)
