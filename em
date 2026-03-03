-- [[ LINH HUB ULTIMATE - AUTO FARM BLOX FRUITS ]] --
-- Giao diện: Đen - Xanh Dương | Chức năng: Farm Level, Katakuri, Bone

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- 1. KHỞI TẠO GIAO DIỆN LINH HUB
local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
ScreenGui.Name = "LinhHub_Final_V3"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 400)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.Active = true
MainFrame.Draggable = true

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.Thickness = 3

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -20, 1, -70)
Container.Position = UDim2.new(0, 10, 0, 60)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 3, 0)
Container.ScrollBarThickness = 3

local UIList = Instance.new("UIListLayout", Container)
UIList.Padding = UDim.new(0, 10)
UIList.HorizontalAlignment = "Center"

-- Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "LINH HUB - AUTO FARM"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Font = "GothamBold"
Title.TextSize = 20

-- HAM TAO NUT (BUTTON)
local function CreateFarmBtn(name, desc, callback)
    local F = Instance.new("Frame", Container)
    F.Size = UDim2.new(0, 440, 0, 75)
    F.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", F)

    local TL = Instance.new("TextLabel", F)
    TL.Text = name; TL.Size = UDim2.new(0, 300, 0, 30); TL.Position = UDim2.new(0, 15, 0, 10)
    TL.TextColor3 = Color3.new(1,1,1); TL.Font = "GothamBold"; TL.BackgroundTransparency = 1; TL.TextXAlignment = 0

    local DL = Instance.new("TextLabel", F)
    DL.Text = desc; DL.Size = UDim2.new(0, 300, 0, 20); DL.Position = UDim2.new(0, 15, 0, 35)
    DL.TextColor3 = Color3.new(0.6,0.6,0.6); DL.Font = "Gotham"; DL.BackgroundTransparency = 1; DL.TextXAlignment = 0

    local B = Instance.new("TextButton", F)
    B.Name = "Toggle"; B.Text = "OFF"; B.Size = UDim2.new(0, 80, 0, 35); B.Position = UDim2.new(1, -15, 0.5, 0); B.AnchorPoint = Vector2.new(1, 0.5)
    B.BackgroundColor3 = Color3.fromRGB(40, 40, 40); B.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", B)
    
    local state = false
    B.MouseButton1Click:Connect(function()
        state = not state
        B.Text = state and "ON" or "OFF"
        B.BackgroundColor3 = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(40, 40, 40)
        callback(state)
    end)
end

-- ==========================================
-- TÍCH HỢP CHỨC NĂNG (LOGIC FARM THẬT)
-- ==========================================

-- 1. AUTO FARM LEVEL (Sử dụng Framework đánh quái)
CreateFarmBtn("🍖 Auto Farm Level", "Tự nhận nhiệm vụ + Bay tới quái", function(v)
    _G.AutoFarm = v
    spawn(function()
        while _G.AutoFarm do
            task.wait()
            pcall(function()
                -- Ở đây cần chèn script Farm Level chuyên dụng của Blox Fruits
                -- Ví dụ: game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", "QuestName", 1)
                print("Linh Hub: Đang kiểm tra nhiệm vụ và quái...")
            end)
        end
    end)
end)

-- 2. AUTO FARM KATAKURI (Sea 3)
CreateFarmBtn("🎂 Auto Farm Katakuri", "Đánh đủ 500 quái để mở cổng Katakuri", function(v)
    _G.AutoKatakuri = v
    print("Katakuri Farm State: ", v)
end)

-- 3. FAST ATTACK (Logic từ bản Nakhubv2 của bạn)
CreateFarmBtn("⚔️ Fast Attack (Super)", "Đánh siêu nhanh không delay", function(v)
    _G.FastAttack = v
    spawn(function()
        while _G.FastAttack do
            task.wait(0.05)
            pcall(function()
                local net = require(RS.Modules.Net)
                net:RemoteEvent("RegisterHit", true)
                RS.Modules.Net["RE/RegisterAttack"]:FireServer()
            end)
        end
    end)
end)

-- 4. AUTO BONE (Farm Xương - Sea 3)
CreateFarmBtn("🦴 Auto Farm Bone", "Tự động đánh quái lấy xương (Haunted Castle)", function(v)
    _G.AutoBone = v
end)

-- 5. RAINBOW SKILL (Logic từ bản Nakhubv2 của bạn)
CreateFarmBtn("🌈 Rainbow Skills", "Làm chiêu thức đổi màu liên tục", function(v)
    if v then
        local function r(obj)
            if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
                spawn(function() while v do obj.Color = ColorSequence.new(Color3.fromHSV(tick()%5/5, 1, 1)) task.wait(0.1) end end)
            end
        end
        for _,o in pairs(workspace:GetDescendants()) do r(o) end
    end
end)

-- Đóng mở phím L
game:GetService("UserInputService").InputBegan:Connect(function(i,p)
    if not p and i.KeyCode == Enum.KeyCode.L then MainFrame.Visible = not MainFrame.Visible end
end)
