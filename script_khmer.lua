-- LocalScript: Complete Custom Hub (No Key Required)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. បង្កើត ScreenGui Main Container
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomHubUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- 2. បង្កើត Main Frame (ផ្ទាំង Menu)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 260)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -130)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- អាចអូសទីតាំងបាន
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- 3. បង្កើត Title Bar
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
titleLabel.Text = "  My Utility Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleLabel

-- Function សម្រាប់បង្កើត Button ងាយស្រួល
local function createButton(text, positionY, color)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.85, 0, 0, 38)
    button.Position = UDim2.new(0.075, 0, 0, positionY)
    button.BackgroundColor3 = color
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 15
    button.Font = Enum.Font.SourceSans
    button.Parent = mainFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = button
    
    return button
end

-- 4. ប៊ូតុង WalkSpeed
local speedButton = createButton("Toggle Speed (32)", 55, Color3.fromRGB(0, 120, 215))
local speedActive = false

speedButton.MouseButton1Click:Connect(function()
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        speedActive = not speedActive
        if speedActive then
            character.Humanoid.WalkSpeed = 32
            speedButton.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        else
            character.Humanoid.WalkSpeed = 16
            speedButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        end
    end
end)

-- 5. ប៊ូតុង JumpPower
local jumpButton = createButton("Toggle High Jump (100)", 105, Color3.fromRGB(0, 120, 215))
local jumpActive = false

jumpButton.MouseButton1Click:Connect(function()
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        jumpActive = not jumpActive
        character.Humanoid.UseJumpPower = true
        if jumpActive then
            character.Humanoid.JumpPower = 100
            jumpButton.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        else
            character.Humanoid.JumpPower = 50
            jumpButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        end
    end
end)

-- 6. ប៊ូតុង Teleport ទៅ Spawn
local teleportButton = createButton("Teleport ទៅ Center (0, 10, 0)", 155, Color3.fromRGB(140, 50, 255))

teleportButton.MouseButton1Click:Connect(function()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        -- ផ្លាស់ប្តូរទីតាំងតួអង្គ
        character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
    end
end)

-- 7. ប៊ូតុង បិទ/បើក UI (Hide/Show)
local toggleButton = createButton("បិទ/បើក Menu", 205, Color3.fromRGB(200, 60, 60))

toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
