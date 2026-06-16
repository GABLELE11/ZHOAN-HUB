-- [[ LATTIC FLING — FULL UNIFIED ENGLISH MASTER LAYOUT ]] --

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local hiddenfling = false
local flingPower = 1000000 
local lp = Players.LocalPlayer
local isRunning = true

ScreenGui.Name = "LatticFlingGui"
ScreenGui.Parent = lp:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Frame.BackgroundTransparency = 0.25
Frame.Position = UDim2.new(0.5, -110, 0.5, -55)
Frame.Size = UDim2.new(0, 220, 0, 110)
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = true

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = Frame

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 1.5
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainStroke.LineJoinMode = Enum.LineJoinMode.Round
mainStroke.Parent = Frame

local strokeGradient = Instance.new("UIGradient")
strokeGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
}
strokeGradient.Parent = mainStroke

local dragArea = Instance.new("TextButton")
dragArea.Size = UDim2.new(1, 0, 0, 35)
dragArea.BackgroundTransparency = 1
dragArea.Text = ""
dragArea.Parent = Frame

TextLabel.Parent = Frame
TextLabel.BackgroundTransparency = 1
TextLabel.Size = UDim2.new(1, 0, 0, 35)
TextLabel.Font = Enum.Font.GothamBold
TextLabel.Text = "LATTIC FLING"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 16

ToggleButton.Parent = Frame
ToggleButton.Position = UDim2.new(0.1, 0, 0, 48)
ToggleButton.Size = UDim2.new(0.8, 0, 0, 42)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "DISABLED" -- Corrected standard English text label
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ToggleButton.BackgroundTransparency = 0.4
ToggleButton.TextSize = 20 -- Optimized text size to perfectly fit "DISABLED"
ToggleButton.BorderSizePixel = 0
local tc = Instance.new("UICorner") tc.CornerRadius = UDim.new(0, 8) tc.Parent = ToggleButton

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Thickness = 1
toggleStroke.Color = Color3.fromRGB(255, 255, 255)
toggleStroke.Transparency = 0.8
toggleStroke.Parent = ToggleButton

if not ReplicatedStorage:FindFirstChild("juisdfj0i32i0eidsuf0iok") then
	local detection = Instance.new("Decal")
	detection.Name = "juisdfj0i32i0eidsuf0iok"
	detection.Parent = ReplicatedStorage
end

local function fling()
	local hrp, c, vel, movel = nil, nil, nil, 0.1
	while isRunning do
		RunService.Heartbeat:Wait()
		if hiddenfling and isRunning then
			while hiddenfling and isRunning and not (c and c.Parent and hrp and hrp.Parent) do
				RunService.Heartbeat:Wait()
				c = lp.Character
				hrp = c and c:FindFirstChild("HumanoidRootPart")
			end

			if hiddenfling and isRunning and hrp then
				vel = hrp.Velocity
				hrp.Velocity = vel * flingPower + Vector3.new(0, flingPower, 0)
				RunService.RenderStepped:Wait()
				if c and c.Parent and hrp and hrp.Parent and isRunning then
					hrp.Velocity = vel
				end
				RunService.Stepped:Wait()
				if c and c.Parent and hrp and hrp.Parent and isRunning then
					hrp.Velocity = vel + Vector3.new(0, movel, 0)
					movel = movel * -1
				end
			end
		end
	end
end

ToggleButton.MouseButton1Click:Connect(function()
	hiddenfling = not hiddenfling
	if hiddenfling then
		ToggleButton.Text = "ENABLED" -- Fixed English active state text [1]
		ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
		ToggleButton.BackgroundTransparency = 0
	else
		ToggleButton.Text = "DISABLED" -- Fixed English inactive state text [1]
		ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
		ToggleButton.BackgroundTransparency = 0.4
	end
end)

local dragToggle, dragStart, startPos
dragArea.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragToggle = false end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local isVisible = true
local ctrlConnection
local f1Connection

ctrlConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightControl then
        isVisible = not isVisible
        if isVisible then
            Frame.Visible = true
            TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 220, 0, 110), BackgroundTransparency = 0.25}):Play()
        else
            local tween = TweenService:Create(Frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 220, 0, 0), BackgroundTransparency = 1})
            tween:Play()
            tween.Completed:Connect(function() if not isVisible then Frame.Visible = false end end)
        end
    end
end)

f1Connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        isRunning = false
        hiddenfling = false
        if ctrlConnection then ctrlConnection:Disconnect() end
        if f1Connection then f1Connection:Disconnect() end
        if ScreenGui then ScreenGui:Destroy() end
    end
end)

task.spawn(fling)
 --GO SKID BASTARDS LOL
