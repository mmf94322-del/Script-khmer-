local SAE = "https://raw.githubusercontent.com/tienkhanh1/Chilli-Hub-Script/refs/heads/main/StealAnEgg"
local RAP = "https://raw.githubusercontent.com/tienkhanh1/Chilli-Hub-Script/refs/heads/main/RideAPet"
local JFA = "https://raw.githubusercontent.com/tienkhanh1/Chilli-Hub-Script/refs/heads/main/JumpForAnimals"
local SAB = "https://raw.githubusercontent.com/tienkhanh1/spicy/refs/heads/main/Steal-a-Brainrot"

local byGameId = {
    [10563114921] = SAE,
    [10035204815] = RAP,
    [10690360998] = JFA,
    [7709344486] = SAB,
}

local byPlaceId = {
    [107778070777162] = SAE,
    [124216119978534] = RAP,
    [126870639873289] = JFA,
    [109983668079237] = SAB,
}

local gameId = game.GameId
while gameId == 0 and game.PlaceId == 0 do
    task.wait()
    gameId = game.GameId
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local flySpeed = 100
local flying = false

local function startFly()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    local bv = Instance.new("BodyVelocity")
    bv.Name = "FlyVelocity"
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.Parent = hrp

    local bg = Instance.new("BodyGyro")
    bg.Name = "FlyGyro"
    bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bg.CFrame = hrp.CFrame
    bg.Parent = hrp

    flying = true

    task.spawn(function()
        while flying and char and hrp and hrp.Parent do
            local camera = workspace.CurrentCamera
            local moveDir = Vector3.new()
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDir = moveDir + camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDir = moveDir - camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDir = moveDir - camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDir = moveDir + camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDir = moveDir + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveDir = moveDir - Vector3.new(0, 1, 0)
            end

            if moveDir.Magnitude > 0 then
                moveDir = moveDir.Unit
            end

            bv.Velocity = moveDir * flySpeed
            bg.CFrame = camera.CFrame
            RunService.RenderStepped:Wait()
        end
        
        bv:Destroy()
        bg:Destroy()
    end)
end

local function toggleFly()
    flying = not flying
    if flying then
        startFly()
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.E then
        toggleFly()
    end
end)

local url = byGameId[gameId] or byPlaceId[game.PlaceId]
if not url then
    return
end

for _ = 1, 3 do
    local ok, source = pcall(game.HttpGet, game, url)
    if ok and type(source) == "string" and source ~= "" then
        local chunk = loadstring(source)
        if chunk then
            chunk()
        end
        return
    end
    task.wait(0.5)
end
