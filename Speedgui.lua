repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

--============================================================
--  KONFIGURASI
--============================================================
local CONFIG = {
	CurrentSpeed = 16,
	DefaultSpeed = 16,
	MaxSpeed = 200,
}

local currentWalkSpeed = 16

--============================================================
--  BIKIN GUI MODERN
--============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpeedGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Panel Utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 140)
MainFrame.Position = UDim2.new(0, 20, 0, 100)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(60, 60, 80)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- Judul
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 32)
Title.BackgroundTransparency = 1
Title.Text = "⚡ SPEED HACK"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.Parent = MainFrame

-- Label Speed Sekarang
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -20, 0, 20)
SpeedLabel.Position = UDim2.new(0, 10, 0, 32)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.TextSize = 13
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = MainFrame

-- Background Slider
local SliderBG = Instance.new("Frame")
SliderBG.Size = UDim2.new(1, -20, 0, 8)
SliderBG.Position = UDim2.new(0, 10, 0, 58)
SliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
SliderBG.BorderSizePixel = 0
SliderBG.Parent = MainFrame

local SliderBGCorner = Instance.new("UICorner")
SliderBGCorner.CornerRadius = UDim.new(1, 0)
SliderBGCorner.Parent = SliderBG

-- Fill Slider (warna progress)
local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(100, 255, 150)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBG

local SliderFillCorner = Instance.new("UICorner")
SliderFillCorner.CornerRadius = UDim.new(1, 0)
SliderFillCorner.Parent = SliderFill

-- Tombol Knob Slider
local SliderKnob = Instance.new("TextButton")
SliderKnob.Size = UDim2.new(0, 20, 0, 20)
SliderKnob.Position = UDim2.new(0, 0, 0, -6)
SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SliderKnob.BorderSizePixel = 0
SliderKnob.Text = ""
SliderKnob.Parent = SliderBG

local SliderKnobCorner = Instance.new("UICorner")
SliderKnobCorner.CornerRadius = UDim.new(1, 0)
SliderKnobCorner.Parent = SliderKnob

-- Efek glow di knob
local KnobStroke = Instance.new("UIStroke")
KnobStroke.Color = Color3.fromRGB(100, 255, 150)
KnobStroke.Thickness = 2
KnobStroke.Parent = SliderKnob

-- Teks Min / Max
local MinText = Instance.new("TextLabel")
MinText.Size = UDim2.new(0, 50, 0, 15)
MinText.Position = UDim2.new(0, 10, 0, 70)
MinText.BackgroundTransparency = 1
MinText.Text = "16"
MinText.TextColor3 = Color3.fromRGB(150, 150, 170)
MinText.Font = Enum.Font.Gotham
MinText.TextSize = 10
MinText.TextXAlignment = Enum.TextXAlignment.Left
MinText.Parent = MainFrame

local MaxText = Instance.new("TextLabel")
MaxText.Size = UDim2.new(0, 50, 0, 15)
MaxText.Position = UDim2.new(1, -60, 0, 70)
MaxText.BackgroundTransparency = 1
MaxText.Text = "200"
MaxText.TextColor3 = Color3.fromRGB(150, 150, 170)
MaxText.Font = Enum.Font.Gotham
MaxText.TextSize = 10
MaxText.TextXAlignment = Enum.TextXAlignment.Right
MaxText.Parent = MainFrame

-- Tombol Cepat (Preset)
local PresetFrame = Instance.new("Frame")
PresetFrame.Size = UDim2.new(1, -20, 0, 28)
PresetFrame.Position = UDim2.new(0, 10, 0, 95)
PresetFrame.BackgroundTransparency = 1
PresetFrame.Parent = MainFrame

local PresetLayout = Instance.new("UIListLayout")
PresetLayout.FillDirection = Enum.FillDirection.Horizontal
PresetLayout.Padding = UDim.new(0, 5)
PresetLayout.Parent = PresetFrame

-- Fungsi bikin tombol preset
local function makePreset(text, speedValue)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 40, 1, 0)
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 11
	btn.Parent = PresetFrame

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		CONFIG.CurrentSpeed = speedValue
		updateSlider()
		applySpeed()
	end)
	return btn
end

makePreset("16", 16)    -- Normal
makePreset("50", 50)    -- Cepat
makePreset("100", 100)  -- Sangat cepat
makePreset("200", 200)  -- Max

--============================================================
--  LOGIKA SLIDER
--============================================================
local sliderDragging = false

local function updateSlider()
	local percent = (CONFIG.CurrentSpeed - 16) / (CONFIG.MaxSpeed - 16)
	percent = math.clamp(percent, 0, 1)

	SliderFill.Size = UDim2.new(percent, 0, 1, 0)
	SliderKnob.Position = UDim2.new(percent, -10, 0, -6)
	SpeedLabel.Text = "Speed: " .. math.floor(CONFIG.CurrentSpeed)
end

local function applySpeed()
	local char = LP.Character
	if char then
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = CONFIG.CurrentSpeed
		end
	end
end

-- Fungsi hitung posisi slider dari X mouse
local function updateFromMouse(x)
	local absPos = SliderBG.AbsolutePosition.X
	local absSize = SliderBG.AbsoluteSize.X
	local percent = (x - absPos) / absSize
	percent = math.clamp(percent, 0, 1)

	CONFIG.CurrentSpeed = 16 + percent * (CONFIG.MaxSpeed - 16)
	updateSlider()
	applySpeed()
end

-- Deteksi klik/drag di slider
SliderBG.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 
		or input.UserInputType == Enum.UserInputType.Touch then
		sliderDragging = true
		updateFromMouse(input.Position.X)
	end
end)

SliderKnob.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 
		or input.UserInputType == Enum.UserInputType.Touch then
		sliderDragging = true
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if sliderDragging then
		if input.UserInputType == Enum.UserInputType.MouseMovement 
			or input.UserInputType == Enum.UserInputType.Touch then
			updateFromMouse(input.Position.X)
		end
	end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 
		or input.UserInputType == Enum.UserInputType.Touch then
		sliderDragging = false
	end
end)

--============================================================
--  AUTO APPLY SAAT RESPAWN
--============================================================
LP.CharacterAdded:Connect(function(char)
	task.wait(1)
	applySpeed()
end)

-- Apply pertama
task.wait(0.5)
applySpeed()
updateSlider()

--============================================================
--  NOTIFIKASI
--============================================================
pcall(function()
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "⚡ Speed GUI",
		Text = "Panel di kiri atas. Drag slider buat atur speed.",
		Duration = 4,
	})
end)

print("[SpeedGUI] Aktif")
